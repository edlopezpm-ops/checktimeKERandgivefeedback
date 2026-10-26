import hashlib
import json
from pathlib import Path

AUDIT=Path(__file__).resolve().parents[1]
SOURCE=Path(r'<SOURCE_ROOT>')
topics={
'7e416c6444fe_baseline.py':'Initial tables, integer minutes, NUMERIC money, ownership FKs, timecard identity, reservation primary key, forward and reverse dependency order.',
'c46f2f62a011_immutable_artifacts.py':'Invoice snapshot/artifact/audit immutability, entry parent integrity, deferred complete-artifact commit check.',
'e3b42aea781a_parent_guards_and_sessions.py':'Both source and destination parents guarded, revocation epoch, immutable payment facts.',
'f409a1ac1700_parent_lock_guards.py':'Stable parent row locking before entry/line mutation guards; compatible protection retained on downgrade.',
'a10d45de891c_issued_status_guard.py':'Issued_at-based financial protections independent of operational status, no issued-to-Draft.',
'b07c9d621a30_pin_guard_schema.py':'Installed schema quoted and pinned for all six original guard functions.',
'd3517d81ce20_contact_reservations.py':'Durable bounded abuse fingerprints/statuses; no message plaintext columns.',
'e672c40fa912_cases_and_allocations.py':'Owned case associations; exact-minute allocation sum under parent locks; retained case identity.',
'3f3c0f09ecf4_mail_custody_and_six_month_archive.py':'Immutable normalized mail, revocable capture identity, permanent archive markers, explicit associations.',
'c41894d13cb7_project_commercial_metadata.py':'Nullable owner-chosen project type, budget/currency and document-reference pairs.',
'd529b08f14a2_project_billing.py':'Fixed-fee/manual-extra claims, unique nonvoid fee/reference, budget reservation and financial parent guards.',
'e640ab7230cd_case_identity_and_types.py':'Empty-only legacy case classification preflight, generated case identity, owned mandatory project, Mail case lock.',
'f710bc319ae2_mail_attachment_custody.py':'Immutable bounded attachment payload/size/hash metadata and parent count/size concurrency locks.',
'a82d43cf6120_project_workflow_and_agreements.py':'Closed project status; immutable bounded owner agreement; nonempty downgrade refused.',
'ph2_001_credit_memos.py':'Historical full-credit/Void coupling and new-timecard-void restriction; original credit history immutable.',
'ph2_002_time_commands.py':'Retained source identities/idempotency receipts; contribution parent/aggregate and deferred allocation checks.',
'ph2_003_integrations.py':'Tenant-local hashed grant/code/token authority and retained operation/client-proposal records.',
'ph3_001_subscriptions.py':'Single tenant assignment, explicit catalog/version and immutable operation receipts.',
'ph3_002_sandbox_billing.py':'Durable provider intents/events, current binding partial uniqueness, proven access interval and immutable terminal history.',
'ph3_003_onboarding_auth.py':'Immutable issuer/subject and acknowledgment, bounded challenge state and attempt transitions.',
'ph3_004_sending.py':'Artifact/owner-bound sending plan, durable uncertain attempts and conservative delivery state transitions.',
'ph3_005_public_admission.py':'Finite central slot ownership, immutable identities, bounded email challenge state; no runtime DDL.',
'ph3_006_quoting_library.py':'All quotation/library/commercial delivery tables, published revision/artifact/source guards, lineage and source bytes binding.',
'ph3_007_work_records.py':'Retained numeric identities/flexfields, internal nonbillable cards, case archive/Closed restriction and existing guard extensions.',
'ph3_008_client_lifecycle.py':'Draft client status without rewriting prior Active records; refuse downgrade with retained Draft.',
'ph3_009_read_indexes.py':'Three stable-pagination indexes only; no data rewrite or trigger alteration.',
'ph3_010_work_batches.py':'Explicit batch ordinal, persistent holds, frozen Ready rates, aggregate daily/weekly limits and guarded repricing.',
'ph3_011_publication.py':'New publication-contract claims permanent even after credits; exact source_ids and no new Void escape.',
'ph3_012_partial_credits.py':'Deliberate replacement of old single/full/paid-prohibition credit rules; cumulative line/statement money+minute bounds, immutable credit drafts/results.',
'ph3_013_browser_sessions.py':'Per-browser immutable identity/expiry and monotonic last-seen/revocation.',
'ph3_014_account_closure.py':'Closure receipt restriction/provider/retention states; operating-role retention policy and no ordinary reactivation.',
'ph3_015_sending_revisions.py':'Explicit replacements only for credit-stopped plans, no payment/full-credit or uncertain replay.',
'ph3_016_publication_reviews.py':'Complete exact reviewed artifact, recipient and content retained and revalidated against publication/plan.',
'ph3_017_operation_limits.py':'Short-lived minute-window owner/principal/class counters separate from business facts and no commercial daily quota.'}
paths=sorted((SOURCE/'alembic/versions').glob('*.py'))+[SOURCE/'alembic/env.py']+sorted((SOURCE/'scripts').glob('postgres-*.sql'))+sorted((SOURCE/'app').glob('*models.py'))+[SOURCE/'app/db.py']
ledger=[]
for p in paths:
    raw=p.read_bytes();relative=p.relative_to(SOURCE).as_posix()
    text=raw.decode('utf-8-sig')
    if p.parent.name=='versions': note=topics[p.name]
    elif p.name=='env.py':note='Imports every model module; accepts explicit supplied migration connection; no schema creation on normal runtime startup.'
    elif p.suffix=='.sql':note='Development-only owner grants or explicit hosted runtime DML allowlist; no live application/external execution.'
    elif p.name=='db.py':note='Fixed role/schema checked at connect; pool bounded; matches SCHEMA_HEAD017; no runtime DDL.'
    else:note='Full ORM definition reviewed against migration semantics: columns/types/nullability, exact monetary/duration types, identifiers/FKs/checks, source/history custody and deferred large payloads where configured.'
    copy=AUDIT/'sandbox/product'/relative
    ledger.append({'path':relative,'sha256':hashlib.sha256(raw).hexdigest(),'lines':len(text.splitlines()),
                   'review':'STATIC_FULL','reviewed_ranges':[[1,len(text.splitlines())]],'semantic_note':note,
                   'matches_sandbox':copy.exists() and hashlib.sha256(copy.read_bytes()).hexdigest()==hashlib.sha256(raw).hexdigest()})
catalog=json.loads((AUDIT/'evidence/migration-model-compare.json').read_text())
guards=json.loads((AUDIT/'evidence/migration-guard-probe.json').read_text())
result={'reviewer':'contract agent, independent migration/model/SQL pass','snapshot_head':'1036d705f7f3721e2fa83df67cf913a40dad65b8',
        'files':ledger,'full_review_file_count':len(ledger),'all_reviewed_files_match_sandbox':all(x['matches_sandbox'] for x in ledger),
        'migration_count':len(topics),'model_module_count':len(list((SOURCE/'app').glob('*models.py'))),
        'catalog_result':{'head':catalog['head'],'tables':catalog['actual_table_count'],'models':catalog['model_table_count'],
                          'checks':catalog['check_constraint_count'],'functions':len(catalog['functions']),'triggers':len(catalog['triggers']),
                          'missing_tables':catalog['missing_actual_tables'],'missing_columns':catalog['missing_columns'],
                          'type_differences':catalog['type_string_differences'],'metadata_drift':catalog['autogenerate_differences']},
        'guard_probe':{'checks':guards['checks_count'],'expected_rejections':guards['expected_rejections'],'evidence':'evidence/migration-guard-probe.json'},
        'confirmed_new_findings':[],
        'nonblocking_observations':[{'id':'M-OBS01','path':'app/models.py','topic':'Project.status mapper omits installed draft server_default; ORM Python default agrees, no current functional defect established.'}],
        'evidence':['evidence/migration-model-compare.json','evidence/migration-model-compare-initial.json','evidence/migration-guard-probe.json','evidence/migration-guard-probe-initial-error.json'],
        'limits':['Only new disposable loopback targets; no live tenant/role/provider execution.',
                  'No exhaustive old-dataset or concurrency validation credited by this subreview.',
                  'Generic type aliases and inline-JSON bind harness errors retained and corrected; not product failures.',
                  'Static full-file review is not a claim that every input/state was executed.']}
(AUDIT/'reviews/migrations.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'full_review_files':len(ledger),'migration_files':len(topics),'model_modules':result['model_module_count'],'sandbox_match':result['all_reviewed_files_match_sandbox'],'tables':catalog['actual_table_count'],'new_confirmed_findings':0}))
