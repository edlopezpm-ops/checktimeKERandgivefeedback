"""Read committed synthetic effects in a new process, without product imports."""
import hashlib,json,os
import psycopg
url=os.environ['TIMEKER_DATABASE_URL'].replace('postgresql+psycopg://','postgresql://')
assert '127.0.0.1:55526/timeker_independent_test' in url
with psycopg.connect(url) as db:
    with db.cursor() as cur:
        cur.execute('SELECT id,status,total,snapshot FROM invoices')
        invoice=cur.fetchone()
        assert invoice[1]=='Issued' and str(invoice[2])=='54.20'
        assert invoice[3]['total_minutes']==69 and invoice[3]['total']=='54.20'
        cur.execute('SELECT pdf_bytes,sha256 FROM invoice_artifacts WHERE invoice_id=%s',(invoice[0],))
        pdf,digest=cur.fetchone()
        assert hashlib.sha256(pdf).hexdigest()==digest
        cur.execute('SELECT sum(amount) FROM payments WHERE invoice_id=%s',(invoice[0],))
        assert str(cur.fetchone()[0])=='13.07'
        cur.execute('SELECT sum(total) FROM credit_memos WHERE invoice_id=%s',(invoice[0],))
        assert str(cur.fetchone()[0])=='11.19'
        cur.execute('SELECT count(*) FROM invoice_time_entries WHERE invoice_id=%s',(invoice[0],))
        assert cur.fetchone()[0]==3
print(json.dumps({'status':'PASS','checks':6,'new_process':True,'product_imports':False,'committed_total':'54.20','payment':'13.07','credit':'11.19','claims':3,'pdf_sha256':digest}))
