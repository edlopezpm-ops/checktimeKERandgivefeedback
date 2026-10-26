"""Read-only, independent cardinality check against the retained synthetic MCP target."""
import json
from pathlib import Path
import psycopg

AUDIT=Path(__file__).resolve().parents[1]
with psycopg.connect(host='127.0.0.1',port=55526,dbname='behavior_mcp_test',user='audit_admin') as db:
    db.execute('SET TRANSACTION READ ONLY')
    target=db.execute('SELECT id,client_id,owner_id,week_start FROM timecards ORDER BY id LIMIT 1').fetchone()
    if target is None:
        raise RuntimeError('Retained synthetic card is required')
    target_id,client_id,owner_id,week=target
    actual=db.execute('SELECT count(*) FROM timecards WHERE id=%s AND client_id=%s AND owner_id=%s AND week_start=%s',
                      (target_id,client_id,owner_id,week)).fetchone()[0]
    unrelated=db.execute('SELECT count(*) FROM clients WHERE id<>%s',(client_id,)).fetchone()[0]
    cross=db.execute("""SELECT count(*) FROM timecards t,clients c WHERE t.id=%s AND t.client_id=%s
        AND t.owner_id=%s AND t.week_start=%s AND t.archived_at IS NULL
        AND t.week_start+6 >= (timezone(coalesce(c.timezone,'UTC'),timestamptz '2026-10-26T20:00:00Z')::date-interval '6 months')::date""",
        (target_id,client_id,owner_id,week)).fetchone()[0]
    joined=db.execute("""SELECT count(*) FROM timecards t LEFT JOIN clients c ON c.id=t.client_id
        WHERE t.id=%s AND t.client_id=%s AND t.owner_id=%s AND t.week_start=%s AND t.archived_at IS NULL
        AND t.week_start+6 >= (timezone(coalesce(c.timezone,'UTC'),timestamptz '2026-10-26T20:00:00Z')::date-interval '6 months')::date""",
        (target_id,client_id,owner_id,week)).fetchone()[0]
assert actual==1 and unrelated==1 and cross==2 and joined==1
report={'method':'Read-only independent driver SQL on retained synthetic target; no product query/helper used',
        'stored_exact_cards':actual,'unrelated_clients':unrelated,'cross_join_rows':cross,'contract_association_join_rows':joined,
        'alternative_multiple_supplemental_batches':'Refuted: one exact persisted card selected by UUID, not two batches.',
        'alternative_helper_only_artifact':'Refuted: source query lacks join and independent direct SQL reproduces 2 vs 1 cardinality.',
        'limitations':'Local synthetic database only; actual external MCP host not exercised by this reviewer.'}
(AUDIT/'evidence/refutation-mcp-duplicate.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
print(json.dumps(report))
