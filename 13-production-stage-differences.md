# 13 — Original production baseline and current PH3/Stage differences

Snapshot: **2026-10-18**. Original production repository main is `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609`. PH3 analysis checkpoint is `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` on `codex/ph3-stage`, independently cloned from closed PH2 `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6` / tag `ph2-closeout-2026-10-18` in the existing `edlopezpm-ops/timeker-PH2` repository.

This comparison reads committed Git tree metadata and maintained source documents. It performs no HTTP/provider/database query, deployment or production operation. Git source is distinct from the last verified deployed image. Sources: [CONTINUE.md:1](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/CONTINUE.md#L1), [docs/PHASE2_CLOSEOUT.md:10](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L10), [HOSTING.md:8](https://github.com/edlopezpm-ops/timeKER/blob/dfb2538ec81d07f1c91fdf2bdc5096d4d0313609/HOSTING.md#L8).

## Environment distinction and dated runtime attribution

| Area | Original production | Existing Stage continued by PH3 |
| --- | --- | --- |
| Origin | `https://timeker.aekr.io` | `https://stage-timeker.aekr.io` |
| Repository | `edlopezpm-ops/timeKER` | `edlopezpm-ops/timeker-PH2`; no new production repository |
| Git checkpoint | `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609` | `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` |
| Last documented runtime source | `a672c8f95bb54c61b6fdb7686f96161cd3491e8c`, last verified 2026-10-12 | `e282985ea74e89e1665351c22f91706498495e93`, final readback 2026-10-18T03:42:14.067017+00:00 |
| Worker | `retained resource identifier omitted`, dated registry | `retained resource identifier omitted` |
| Deployment | `retained resource identifier omitted`, dated 100 percent | `retained resource identifier omitted`, 100 percent at readback |
| Container | `retained resource identifier omitted`, dated configuration 12 | `retained resource identifier omitted`, application/running 29 |
| Image SHA-256 | `a5445f4403161b0d81804db3ad0ac9afac55ac44a591389f3fd83af778ef008a` | `fb3399f00baa2ee9efda0f0dd3e460cc2c706a4ce820133e8af429690948c80c` |
| PostgreSQL | Separate production project; two retained fixed schemas documented at `a82d43cf6120` | Separate Stage project; nine runtime schemas last verified at `ph3_009_read_indexes`; five quarantines unchanged |
| Authentication | Dated deployed Google-only allowlisted path; current overrides not queried | Google/GitHub/managed email configured, immutable binding, explicit linking/acknowledgment and finite prepared slots |
| Original PH2 core | Not promoted by this task | Credit memos, strict reviewed Draft imports/contributions, proposed clients and scoped OAuth/API/MCP implemented; actual host acceptance pending |
| Later business/UX | No final combined cutover performed | Enrollment/Sandbox, Quoting/Library/commercial Sending, lifecycle/search/paging, Dashboard/Timecards/navigation/reference/performance/Settings changes |
| Scheduling/delivery | Existing production profile/overrides retained; no new query/mutation | Manual Sending source; jobs off; Case-only 02:17 UTC handler configured, actual scheduled execution unobserved |
| Optional processing | Later optional-measurement source recorded OFF; no new runtime claim | Optional usage/contact/inbound capture are separate decisions; retained Stage profile disables them |
| Lifecycle | Existing service unchanged by administrative work | PH2 closed; independent PH3 prepared/awaiting owner prompts; existing Stage continues |

Production identities are dated original-registry facts, not current provider observations. Original source: [HOSTING.md:8](https://github.com/edlopezpm-ops/timeKER/blob/dfb2538ec81d07f1c91fdf2bdc5096d4d0313609/HOSTING.md#L8). Stage source: [HOSTING.md:12](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L12). Later optional-measurement/main source does not establish production activation. Git publication did not deploy either service during administrative work.

Stage final anonymous readback passed 31 GET checks/15 matching assets, live 200/ready 200. Provider metadata remains active 1/healthy 0, one running instance and no active rollout errors. Do not normalize counters or promote anonymous checks to authenticated UAT. Separate schema 009 custody preserved 486 business-table fingerprints, 36 guards/schema, 72 reciprocal denials before/after and five quarantines. Sources: [HOSTING.md:14](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L14), [HOSTING.md:26](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L26).

## Future combined production candidate

The retained [original timeKER draft PR3](https://github.com/edlopezpm-ops/timeKER/pull/3) has historical candidate `4f60d228fb205cff09698b94d6749dd86d76164a`. It was not merged/deployed by closeout and is not the final current Stage source. Its files exist in later PH2/PH3; an old snapshot must not overwrite later work. Refresh the reviewable candidate from eventual final **PH2 plus authorized PH3** source before separately authorized migration/configuration/deploy. No intermediate PH2-only promotion is requested. Source: [docs/PHASE2_CLOSEOUT.md:20](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L20).

Production is not a Stage Worker rename. Reconcile original immutable owner/bootstrap coverage, actual runtime overrides, environment-specific origin/provider/secret custody, retained/prepared database inventory, migrations/grants/guards, consistent encrypted backup and compatible repair. Keep Stage fixtures/Sandbox datasets/synthetic grants out of production. Source: [docs/OPERATIONS.md:197](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/OPERATIONS.md#L197).

General admission, Live merchant/catalog/credentials/webhooks, real billing/delivery lifecycle proof, accepted legal/retention/offboarding contracts and human UAT remain separate decisions. Quoting/Library/commercial Sending is production-disabled in source; statement Sending has separate production enablement. A source flag/draft PR does not establish activation. Sources: [app/config.py:74](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/config.py#L74), [app/config.py:199](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/config.py#L199), [docs/OPERATIONS.md:264](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/OPERATIONS.md#L264), [docs/STATUS.md:27](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L27).

## Static Git tree comparison

| Metadata category | Count |
| --- | ---: |
| Original tracked paths at `dfb2538` | 230 |
| PH3 tracked paths at `9fc9eeb` | 503 |
| Shared identical Git blobs | 102 |
| Shared different Git blobs | 128 |
| PH3-only paths | 273 |
| Original-only paths | 0 |
| Changed/added/removed rows below | 401 |

Counts use immutable `git ls-tree -r` metadata and object-ID comparison. `git diff --shortstat` reports 401 files changed, 54,751 insertions and 1,685 deletions. This line delta describes source, not completeness/risk/readiness. These are committed paths, not business records, database tables, passed tests or deployed artifacts. No source code, private data or archived payload is reproduced.

PH3 differs from frozen PH2 only in CONTINUE, README and STATUS. Independent preparation checked 503 tracked files and raw-byte identity of the other 500. Git storage has no shared commondir/alternates; all 22 corresponding object/pack metadata files checked had distinct file identities and link count one. Runtime/test/migration/build/dependency paths are unchanged. Root-AGENTS generic scaffold incompatibility remains explicit; 32-ID map/local-link checks passed. Source: [docs/PHASE2_CLOSEOUT.md:77](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L77).

Local reversible custody covers 28 batches/8,149 files/1,580,224,720 bytes plus the separate native Quoting move. Protected payload is outside this public comparison and does not supply off-host backup/hosted recovery. Source: [docs/PHASE2_CLOSEOUT.md:49](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L49).

## Complete changed-path metadata

Text-file links point to the exact committed file at one-based line 1; binary-file links point to the immutable blob without a line anchor. A source link supplies provenance; the dossier does not copy its contents or prescribe replacing that production file. Reconcile domain contracts, migration history and environment-specific behavior rather than treating this table as a release patch.

| Path | Source relationship |
| --- | --- |
| [.dockerignore](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/.dockerignore#L1) | Different Git blob |
| [.env.example](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/.env.example#L1) | Different Git blob |
| [.gitignore](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/.gitignore#L1) | Different Git blob |
| [AGENTS.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/AGENTS.md#L1) | Different Git blob |
| [CONTINUE.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/CONTINUE.md#L1) | PH3 only |
| [Dockerfile](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/Dockerfile#L1) | Different Git blob |
| [HOSTING.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L1) | Different Git blob |
| [PROJECT_MAP.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/PROJECT_MAP.md#L1) | Different Git blob |
| [README.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/README.md#L1) | Different Git blob |
| [alembic/env.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/env.py#L1) | Different Git blob |
| [alembic/versions/ph2_001_credit_memos.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph2_001_credit_memos.py#L1) | PH3 only |
| [alembic/versions/ph2_002_time_commands.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph2_002_time_commands.py#L1) | PH3 only |
| [alembic/versions/ph2_003_integrations.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph2_003_integrations.py#L1) | PH3 only |
| [alembic/versions/ph3_001_subscriptions.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_001_subscriptions.py#L1) | PH3 only |
| [alembic/versions/ph3_002_sandbox_billing.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_002_sandbox_billing.py#L1) | PH3 only |
| [alembic/versions/ph3_003_onboarding_auth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_003_onboarding_auth.py#L1) | PH3 only |
| [alembic/versions/ph3_004_sending.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_004_sending.py#L1) | PH3 only |
| [alembic/versions/ph3_005_public_admission.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_005_public_admission.py#L1) | PH3 only |
| [alembic/versions/ph3_006_quoting_library.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_006_quoting_library.py#L1) | PH3 only |
| [alembic/versions/ph3_007_work_records.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_007_work_records.py#L1) | PH3 only |
| [alembic/versions/ph3_008_client_lifecycle.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_008_client_lifecycle.py#L1) | PH3 only |
| [alembic/versions/ph3_009_read_indexes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/alembic/versions/ph3_009_read_indexes.py#L1) | PH3 only |
| [app/admission.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L1) | PH3 only |
| [app/admission_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission_models.py#L1) | PH3 only |
| [app/admission_operations.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission_operations.py#L1) | PH3 only |
| [app/archive_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/archive_routes.py#L1) | Different Git blob |
| [app/archiving.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/archiving.py#L1) | Different Git blob |
| [app/auth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/auth.py#L1) | Different Git blob |
| [app/billing.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/billing.py#L1) | Different Git blob |
| [app/case_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/case_routes.py#L1) | Different Git blob |
| [app/cases.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/cases.py#L1) | Different Git blob |
| [app/cli.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/cli.py#L1) | Different Git blob |
| [app/client_drafts.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/client_drafts.py#L1) | PH3 only |
| [app/client_sources.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/client_sources.py#L1) | PH3 only |
| [app/clients.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/clients.py#L1) | Different Git blob |
| [app/config.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/config.py#L1) | Different Git blob |
| [app/credit_memo_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/credit_memo_models.py#L1) | PH3 only |
| [app/dashboard.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/dashboard.py#L1) | PH3 only |
| [app/data/COPYRIGHT.pycountry.txt](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/data/COPYRIGHT.pycountry.txt#L1) | PH3 only |
| [app/data/LICENSE.pycountry.txt](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/data/LICENSE.pycountry.txt#L1) | PH3 only |
| [app/data/README.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/data/README.md#L1) | PH3 only |
| [app/data/iso_3166-1.json](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/data/iso_3166-1.json#L1) | PH3 only |
| [app/data/iso_4217.json](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/data/iso_4217.json#L1) | PH3 only |
| [app/db.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/db.py#L1) | Different Git blob |
| [app/demo.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/demo.py#L1) | Different Git blob |
| [app/email_auth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/email_auth.py#L1) | PH3 only |
| [app/enrollment.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment.py#L1) | PH3 only |
| [app/enrollment_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment_models.py#L1) | PH3 only |
| [app/enrollment_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment_routes.py#L1) | PH3 only |
| [app/flexfields.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/flexfields.py#L1) | PH3 only |
| [app/forms.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/forms.py#L1) | Different Git blob |
| [app/integration_auth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/integration_auth.py#L1) | PH3 only |
| [app/integration_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/integration_models.py#L1) | PH3 only |
| [app/integration_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/integration_routes.py#L1) | PH3 only |
| [app/internal_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/internal_routes.py#L1) | Different Git blob |
| [app/library.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/library.py#L1) | PH3 only |
| [app/library_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/library_models.py#L1) | PH3 only |
| [app/library_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/library_routes.py#L1) | PH3 only |
| [app/logging.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/logging.py#L1) | Different Git blob |
| [app/lookups.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/lookups.py#L1) | Different Git blob |
| [app/mail_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/mail_models.py#L1) | Different Git blob |
| [app/mail_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/mail_routes.py#L1) | Different Git blob |
| [app/main.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L1) | Different Git blob |
| [app/models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/models.py#L1) | Different Git blob |
| [app/paddle.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/paddle.py#L1) | PH3 only |
| [app/pagination.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/pagination.py#L1) | PH3 only |
| [app/pdf.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/pdf.py#L1) | Different Git blob |
| [app/project_billing_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/project_billing_routes.py#L1) | Different Git blob |
| [app/project_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/project_routes.py#L1) | Different Git blob |
| [app/proposal_sending.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/proposal_sending.py#L1) | PH3 only |
| [app/proposal_sending_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/proposal_sending_models.py#L1) | PH3 only |
| [app/proposal_sending_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/proposal_sending_routes.py#L1) | PH3 only |
| [app/proposal_sending_transport.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/proposal_sending_transport.py#L1) | PH3 only |
| [app/quoting.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/quoting.py#L1) | PH3 only |
| [app/quoting_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/quoting_models.py#L1) | PH3 only |
| [app/quoting_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/quoting_routes.py#L1) | PH3 only |
| [app/record_references.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/record_references.py#L1) | PH3 only |
| [app/reference_choices.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/reference_choices.py#L1) | PH3 only |
| [app/reports.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/reports.py#L1) | Different Git blob |
| [app/repositories.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/repositories.py#L1) | Different Git blob |
| [app/search_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/search_routes.py#L1) | PH3 only |
| [app/seed.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/seed.py#L1) | Different Git blob |
| [app/sending.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/sending.py#L1) | PH3 only |
| [app/sending_dispatch_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/sending_dispatch_routes.py#L1) | PH3 only |
| [app/sending_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/sending_models.py#L1) | PH3 only |
| [app/sending_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/sending_routes.py#L1) | PH3 only |
| [app/sending_transport.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/sending_transport.py#L1) | PH3 only |
| [app/settings.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/settings.py#L1) | Different Git blob |
| [app/social_auth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/social_auth.py#L1) | PH3 only |
| [app/static_assets.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/static_assets.py#L1) | PH3 only |
| [app/subscription_billing.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/subscription_billing.py#L1) | PH3 only |
| [app/subscription_billing_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/subscription_billing_models.py#L1) | PH3 only |
| [app/subscription_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/subscription_models.py#L1) | PH3 only |
| [app/subscription_payment_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/subscription_payment_routes.py#L1) | PH3 only |
| [app/subscription_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/subscription_routes.py#L1) | PH3 only |
| [app/subscriptions.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/subscriptions.py#L1) | PH3 only |
| [app/tenancy.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/tenancy.py#L1) | Different Git blob |
| [app/tenant_demo.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/tenant_demo.py#L1) | Different Git blob |
| [app/time_command_models.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/time_command_models.py#L1) | PH3 only |
| [app/time_commands.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/time_commands.py#L1) | PH3 only |
| [app/time_import.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/time_import.py#L1) | PH3 only |
| [app/time_import_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/time_import_routes.py#L1) | PH3 only |
| [app/timecards.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/timecards.py#L1) | Different Git blob |
| [app/web/static/app.css](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/app.css#L1) | Different Git blob |
| [app/web/static/app.js](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/app.js#L1) | Different Git blob |
| [app/web/static/auth_challenge.js](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/auth_challenge.js#L1) | PH3 only |
| [app/web/static/cases.css](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/cases.css#L1) | PH3 only |
| [app/web/static/cases.js](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/cases.js#L1) | PH3 only |
| [app/web/static/github-invertocat.svg](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/github-invertocat.svg#L1) | PH3 only |
| [app/web/static/google-g.png](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/google-g.png) | PH3 only |
| [app/web/static/google-sans-OFL.txt](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/google-sans-OFL.txt#L1) | PH3 only |
| [app/web/static/google-sans-medium.ttf](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/google-sans-medium.ttf) | PH3 only |
| [app/web/static/paddle_checkout.css](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/paddle_checkout.css#L1) | PH3 only |
| [app/web/static/paddle_checkout.js](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/paddle_checkout.js#L1) | PH3 only |
| [app/web/static/settings_cache.js](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/settings_cache.js#L1) | PH3 only |
| [app/web/static/status.css](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/status.css#L1) | PH3 only |
| [app/web/static/timecards.css](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/timecards.css#L1) | PH3 only |
| [app/web/static/timecards.js](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/timecards.js#L1) | PH3 only |
| [app/web/static/workspace.css](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/workspace.css#L1) | PH3 only |
| [app/web/static/workspace.js](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/workspace.js#L1) | PH3 only |
| [app/web/templates/account_security.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/account_security.html#L1) | PH3 only |
| [app/web/templates/archive.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/archive.html#L1) | Different Git blob |
| [app/web/templates/archived_timecard.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/archived_timecard.html#L1) | Different Git blob |
| [app/web/templates/assistant_connection_guide.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/assistant_connection_guide.html#L1) | PH3 only |
| [app/web/templates/audit.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/audit.html#L1) | Different Git blob |
| [app/web/templates/auth_challenge.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/auth_challenge.html#L1) | PH3 only |
| [app/web/templates/auth_layout.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/auth_layout.html#L1) | PH3 only |
| [app/web/templates/auth_methods.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/auth_methods.html#L1) | PH3 only |
| [app/web/templates/auth_notice.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/auth_notice.html#L1) | PH3 only |
| [app/web/templates/auth_notice_fields.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/auth_notice_fields.html#L1) | PH3 only |
| [app/web/templates/auth_provider_button.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/auth_provider_button.html#L1) | PH3 only |
| [app/web/templates/auth_provider_forms.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/auth_provider_forms.html#L1) | PH3 only |
| [app/web/templates/base.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/base.html#L1) | Different Git blob |
| [app/web/templates/billing.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/billing.html#L1) | Different Git blob |
| [app/web/templates/capacity_prompt.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/capacity_prompt.html#L1) | PH3 only |
| [app/web/templates/case_allocations.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/case_allocations.html#L1) | Different Git blob |
| [app/web/templates/case_detail.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/case_detail.html#L1) | Different Git blob |
| [app/web/templates/case_form.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/case_form.html#L1) | Different Git blob |
| [app/web/templates/case_mass_edit.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/case_mass_edit.html#L1) | PH3 only |
| [app/web/templates/case_mass_edit_content.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/case_mass_edit_content.html#L1) | PH3 only |
| [app/web/templates/cases.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/cases.html#L1) | Different Git blob |
| [app/web/templates/client_detail.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/client_detail.html#L1) | Different Git blob |
| [app/web/templates/client_drafts.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/client_drafts.html#L1) | PH3 only |
| [app/web/templates/client_form.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/client_form.html#L1) | Different Git blob |
| [app/web/templates/clients.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/clients.html#L1) | Different Git blob |
| [app/web/templates/components.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/components.html#L1) | Different Git blob |
| [app/web/templates/credit_memo.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/credit_memo.html#L1) | PH3 only |
| [app/web/templates/credit_memo_pdf.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/credit_memo_pdf.html#L1) | PH3 only |
| [app/web/templates/dashboard.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/dashboard.html#L1) | Different Git blob |
| [app/web/templates/dashboard_detail.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/dashboard_detail.html#L1) | PH3 only |
| [app/web/templates/email/invitation.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/email/invitation.html#L1) | PH3 only |
| [app/web/templates/error.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/error.html#L1) | Different Git blob |
| [app/web/templates/flexfields.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/flexfields.html#L1) | PH3 only |
| [app/web/templates/help.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/help.html#L1) | Different Git blob |
| [app/web/templates/invoice.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/invoice.html#L1) | Different Git blob |
| [app/web/templates/landing.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/landing.html#L1) | Different Git blob |
| [app/web/templates/landing_info.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/landing_info.html#L1) | Different Git blob |
| [app/web/templates/legal_policies.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/legal_policies.html#L1) | PH3 only |
| [app/web/templates/legal_policy_content.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/legal_policy_content.html#L1) | PH3 only |
| [app/web/templates/library.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/library.html#L1) | PH3 only |
| [app/web/templates/library_document.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/library_document.html#L1) | PH3 only |
| [app/web/templates/library_document_pdf.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/library_document_pdf.html#L1) | PH3 only |
| [app/web/templates/lookup.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/lookup.html#L1) | Different Git blob |
| [app/web/templates/mail.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/mail.html#L1) | Different Git blob |
| [app/web/templates/mail_addresses.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/mail_addresses.html#L1) | Different Git blob |
| [app/web/templates/mail_detail.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/mail_detail.html#L1) | Different Git blob |
| [app/web/templates/mail_import.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/mail_import.html#L1) | Different Git blob |
| [app/web/templates/navigation_icons.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/navigation_icons.html#L1) | Different Git blob |
| [app/web/templates/project_billing.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/project_billing.html#L1) | Different Git blob |
| [app/web/templates/project_form.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/project_form.html#L1) | Different Git blob |
| [app/web/templates/projects.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/projects.html#L1) | Different Git blob |
| [app/web/templates/proposal_sending.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/proposal_sending.html#L1) | PH3 only |
| [app/web/templates/proposal_sending_prepare.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/proposal_sending_prepare.html#L1) | PH3 only |
| [app/web/templates/proposal_sending_readiness.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/proposal_sending_readiness.html#L1) | PH3 only |
| [app/web/templates/proposal_sending_review.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/proposal_sending_review.html#L1) | PH3 only |
| [app/web/templates/public_plans.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/public_plans.html#L1) | PH3 only |
| [app/web/templates/quote_detail.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/quote_detail.html#L1) | PH3 only |
| [app/web/templates/quote_form.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/quote_form.html#L1) | PH3 only |
| [app/web/templates/quote_pdf.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/quote_pdf.html#L1) | PH3 only |
| [app/web/templates/quoting.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/quoting.html#L1) | PH3 only |
| [app/web/templates/registration.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/registration.html#L1) | PH3 only |
| [app/web/templates/reports.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/reports.html#L1) | Different Git blob |
| [app/web/templates/search.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/search.html#L1) | PH3 only |
| [app/web/templates/sending.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/sending.html#L1) | PH3 only |
| [app/web/templates/sending_followup_review.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/sending_followup_review.html#L1) | PH3 only |
| [app/web/templates/sending_prepare.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/sending_prepare.html#L1) | PH3 only |
| [app/web/templates/sending_readiness.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/sending_readiness.html#L1) | PH3 only |
| [app/web/templates/sending_review.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/sending_review.html#L1) | PH3 only |
| [app/web/templates/settings.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/settings.html#L1) | Different Git blob |
| [app/web/templates/settings_integrations.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/settings_integrations.html#L1) | PH3 only |
| [app/web/templates/sign_in.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/sign_in.html#L1) | PH3 only |
| [app/web/templates/sign_up.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/sign_up.html#L1) | PH3 only |
| [app/web/templates/subscription.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/subscription.html#L1) | PH3 only |
| [app/web/templates/subscription_account.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/subscription_account.html#L1) | PH3 only |
| [app/web/templates/subscription_change_review.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/subscription_change_review.html#L1) | PH3 only |
| [app/web/templates/subscription_checkout.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/subscription_checkout.html#L1) | PH3 only |
| [app/web/templates/subscription_command.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/subscription_command.html#L1) | PH3 only |
| [app/web/templates/subscription_payment_controls.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/subscription_payment_controls.html#L1) | PH3 only |
| [app/web/templates/subscription_portal.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/subscription_portal.html#L1) | PH3 only |
| [app/web/templates/subscription_retention_review.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/subscription_retention_review.html#L1) | PH3 only |
| [app/web/templates/time_import.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/time_import.html#L1) | PH3 only |
| [app/web/templates/timecards.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/timecards.html#L1) | Different Git blob |
| [app/web/templates/workspace_search_dialog.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/templates/workspace_search_dialog.html#L1) | PH3 only |
| [app/work_history.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/work_history.py#L1) | PH3 only |
| [app/work_lifecycle.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/work_lifecycle.py#L1) | PH3 only |
| [app/workspace_operations.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/workspace_operations.py#L1) | PH3 only |
| [app/workspace_search.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/workspace_search.py#L1) | PH3 only |
| [deploy/cloudflare/FOOTER_RELEASE.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/FOOTER_RELEASE.md#L1) | Different Git blob |
| [deploy/cloudflare/README.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/README.md#L1) | Different Git blob |
| [deploy/cloudflare/STAGE_RELEASE.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/STAGE_RELEASE.md#L1) | PH3 only |
| [deploy/cloudflare/VERIFICATION.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/VERIFICATION.md#L1) | Different Git blob |
| [deploy/cloudflare/package-lock.json](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/package-lock.json#L1) | Different Git blob |
| [deploy/cloudflare/package.json](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/package.json#L1) | Different Git blob |
| [deploy/cloudflare/src/contact.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/src/contact.ts#L1) | Different Git blob |
| [deploy/cloudflare/src/index.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/src/index.ts#L1) | Different Git blob |
| [deploy/cloudflare/src/internal.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/src/internal.ts#L1) | Different Git blob |
| [deploy/cloudflare/src/production-proxy.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/src/production-proxy.ts#L1) | PH3 only |
| [deploy/cloudflare/src/production.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/src/production.ts#L1) | PH3 only |
| [deploy/cloudflare/src/proxy.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/src/proxy.ts#L1) | Different Git blob |
| [deploy/cloudflare/src/stage-archive.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/src/stage-archive.ts#L1) | PH3 only |
| [deploy/cloudflare/test/paddle.test.mjs](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/test/paddle.test.mjs#L1) | PH3 only |
| [deploy/cloudflare/test/production.test.mjs](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/test/production.test.mjs#L1) | PH3 only |
| [deploy/cloudflare/test/proxy.test.mjs](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/test/proxy.test.mjs#L1) | Different Git blob |
| [deploy/cloudflare/test/sending.test.mjs](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/test/sending.test.mjs#L1) | PH3 only |
| [deploy/cloudflare/test/stage-archive.test.mjs](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/test/stage-archive.test.mjs#L1) | PH3 only |
| [deploy/cloudflare/tsconfig.json](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/tsconfig.json#L1) | Different Git blob |
| [deploy/cloudflare/worker-configuration.d.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/worker-configuration.d.ts#L1) | Different Git blob |
| [deploy/cloudflare/worker-production-configuration.d.ts](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/worker-production-configuration.d.ts#L1) | PH3 only |
| [deploy/cloudflare/wrangler.jsonc](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/wrangler.jsonc#L1) | Different Git blob |
| [deploy/cloudflare/wrangler.production.jsonc](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/wrangler.production.jsonc#L1) | PH3 only |
| [deploy/postgres/README.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/postgres/README.md#L1) | Different Git blob |
| [deploy/supabase/stage-auth-code.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/supabase/stage-auth-code.html#L1) | PH3 only |
| [deploy/supabase/stage-auth-invitation.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/supabase/stage-auth-invitation.html#L1) | PH3 only |
| [docs/DECISIONS.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L1) | Different Git blob |
| [docs/DEPLOYMENT.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DEPLOYMENT.md#L1) | Different Git blob |
| [docs/OPERATIONS.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/OPERATIONS.md#L1) | Different Git blob |
| [docs/PERFORMANCE_ANALYSIS_2026-10-17.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PERFORMANCE_ANALYSIS_2026-10-17.md#L1) | PH3 only |
| [docs/PERFORMANCE_IMPROVEMENTS_2026-10-17.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PERFORMANCE_IMPROVEMENTS_2026-10-17.md#L1) | PH3 only |
| [docs/PHASE2_CLOSEOUT.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L1) | PH3 only |
| [docs/PROJECT_BRIEF.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PROJECT_BRIEF.md#L1) | Different Git blob |
| [docs/STATUS.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L1) | Different Git blob |
| [docs/design/DESIGN_SPEC.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/design/DESIGN_SPEC.md#L1) | Different Git blob |
| [docs/design/EXPANSION_DISCOVERY.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/design/EXPANSION_DISCOVERY.md#L1) | Different Git blob |
| [docs/email/assets/timeker-wordmark.png](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/email/assets/timeker-wordmark.png) | PH3 only |
| [docs/email/invitation-preview.html](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/email/invitation-preview.html#L1) | PH3 only |
| [docs/legal/LANDING_COPY.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/legal/LANDING_COPY.md#L1) | Different Git blob |
| [docs/legal/PRIVACY_DISCOVERY.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/legal/PRIVACY_DISCOVERY.md#L1) | Different Git blob |
| [integrations/README.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/integrations/README.md#L1) | PH3 only |
| [integrations/timeker-stage/assets/logo.svg](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/integrations/timeker-stage/assets/logo.svg#L1) | PH3 only |
| [integrations/timeker-stage/mcp.json](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/integrations/timeker-stage/mcp.json#L1) | PH3 only |
| [integrations/timeker-stage/plugin.json](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/integrations/timeker-stage/plugin.json#L1) | PH3 only |
| [integrations/timeker-stage/skills/timeker/SKILL.md](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/integrations/timeker-stage/skills/timeker/SKILL.md#L1) | PH3 only |
| [scripts/postgres-runtime-grants.sql](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/scripts/postgres-runtime-grants.sql#L1) | Different Git blob |
| [scripts/render_invitation.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/scripts/render_invitation.py#L1) | PH3 only |
| [tests/conftest.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/conftest.py#L1) | Different Git blob |
| [tests/e2e/conftest.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/conftest.py#L1) | Different Git blob |
| [tests/e2e/test_archive_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_archive_browser.py#L1) | Different Git blob |
| [tests/e2e/test_case_mass_edit_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_case_mass_edit_browser.py#L1) | PH3 only |
| [tests/e2e/test_credit_memos_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_credit_memos_browser.py#L1) | PH3 only |
| [tests/e2e/test_dashboard_detail_pagination_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_dashboard_detail_pagination_browser.py#L1) | PH3 only |
| [tests/e2e/test_dashboard_outstanding_pagination_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_dashboard_outstanding_pagination_browser.py#L1) | PH3 only |
| [tests/e2e/test_delegated_oauth_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_delegated_oauth_browser.py#L1) | PH3 only |
| [tests/e2e/test_ker_navigation_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_ker_navigation_browser.py#L1) | PH3 only |
| [tests/e2e/test_live_checkout_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_live_checkout_browser.py#L1) | PH3 only |
| [tests/e2e/test_oauth_csp_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_oauth_csp_browser.py#L1) | Different Git blob |
| [tests/e2e/test_onboarding_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_onboarding_browser.py#L1) | PH3 only |
| [tests/e2e/test_owner_work_refinements_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_owner_work_refinements_browser.py#L1) | PH3 only |
| [tests/e2e/test_paddle_overlay_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_paddle_overlay_browser.py#L1) | PH3 only |
| [tests/e2e/test_projects_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_projects_browser.py#L1) | Different Git blob |
| [tests/e2e/test_proposal_sending_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_proposal_sending_browser.py#L1) | PH3 only |
| [tests/e2e/test_quoting_library_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_quoting_library_browser.py#L1) | PH3 only |
| [tests/e2e/test_quoting_lookup_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_quoting_lookup_browser.py#L1) | PH3 only |
| [tests/e2e/test_record_pagination_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_record_pagination_browser.py#L1) | PH3 only |
| [tests/e2e/test_reference_fields_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_reference_fields_browser.py#L1) | PH3 only |
| [tests/e2e/test_sending_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_sending_browser.py#L1) | PH3 only |
| [tests/e2e/test_sending_manual_followup_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_sending_manual_followup_browser.py#L1) | PH3 only |
| [tests/e2e/test_settings_cache_refresh_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_settings_cache_refresh_browser.py#L1) | PH3 only |
| [tests/e2e/test_shared_auth_challenge.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_shared_auth_challenge.py#L1) | PH3 only |
| [tests/e2e/test_stage_refinements.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_stage_refinements.py#L1) | PH3 only |
| [tests/e2e/test_subscription_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_subscription_browser.py#L1) | PH3 only |
| [tests/e2e/test_time_import_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_time_import_browser.py#L1) | PH3 only |
| [tests/e2e/test_timecard_local_clock.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_timecard_local_clock.py#L1) | Different Git blob |
| [tests/e2e/test_timecard_productivity_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_timecard_productivity_browser.py#L1) | PH3 only |
| [tests/e2e/test_timecard_selection.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_timecard_selection.py#L1) | Different Git blob |
| [tests/e2e/test_timecard_week_metrics_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_timecard_week_metrics_browser.py#L1) | PH3 only |
| [tests/e2e/test_ui_refresh_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_ui_refresh_browser.py#L1) | Different Git blob |
| [tests/e2e/test_work_management.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_work_management.py#L1) | Different Git blob |
| [tests/e2e/test_workflow_feedback_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_workflow_feedback_browser.py#L1) | Different Git blob |
| [tests/e2e/test_workspace_search_browser.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/e2e/test_workspace_search_browser.py#L1) | PH3 only |
| [tests/integration/test_archiving.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_archiving.py#L1) | Different Git blob |
| [tests/integration/test_auth_get_sessions.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_auth_get_sessions.py#L1) | PH3 only |
| [tests/integration/test_auth_notice.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_auth_notice.py#L1) | PH3 only |
| [tests/integration/test_case_lists.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_case_lists.py#L1) | Different Git blob |
| [tests/integration/test_case_mass_edit.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_case_mass_edit.py#L1) | PH3 only |
| [tests/integration/test_case_retention.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_case_retention.py#L1) | PH3 only |
| [tests/integration/test_case_workflow.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_case_workflow.py#L1) | Different Git blob |
| [tests/integration/test_cases.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_cases.py#L1) | Different Git blob |
| [tests/integration/test_cases_migration.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_cases_migration.py#L1) | Different Git blob |
| [tests/integration/test_client_codes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_client_codes.py#L1) | PH3 only |
| [tests/integration/test_credit_memos.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_credit_memos.py#L1) | PH3 only |
| [tests/integration/test_dashboard_contribution_scope.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_dashboard_contribution_scope.py#L1) | PH3 only |
| [tests/integration/test_dashboard_detail_pagination.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_dashboard_detail_pagination.py#L1) | PH3 only |
| [tests/integration/test_dashboard_outstanding_pagination.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_dashboard_outstanding_pagination.py#L1) | PH3 only |
| [tests/integration/test_dashboard_performance.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_dashboard_performance.py#L1) | PH3 only |
| [tests/integration/test_delegated_integration.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_delegated_integration.py#L1) | PH3 only |
| [tests/integration/test_email_start_retries.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_email_start_retries.py#L1) | PH3 only |
| [tests/integration/test_financial_query_growth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_financial_query_growth.py#L1) | PH3 only |
| [tests/integration/test_hardening.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_hardening.py#L1) | Different Git blob |
| [tests/integration/test_ker_navigation.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_ker_navigation.py#L1) | PH3 only |
| [tests/integration/test_library.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_library.py#L1) | PH3 only |
| [tests/integration/test_live_billing.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_live_billing.py#L1) | PH3 only |
| [tests/integration/test_lookups.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_lookups.py#L1) | Different Git blob |
| [tests/integration/test_mail.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_mail.py#L1) | Different Git blob |
| [tests/integration/test_migrations.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_migrations.py#L1) | Different Git blob |
| [tests/integration/test_onboarding_auth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_onboarding_auth.py#L1) | PH3 only |
| [tests/integration/test_owner_work_refinements.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_owner_work_refinements.py#L1) | PH3 only |
| [tests/integration/test_project_attachments.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_project_attachments.py#L1) | Different Git blob |
| [tests/integration/test_project_attachments_migration.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_project_attachments_migration.py#L1) | Different Git blob |
| [tests/integration/test_project_lifecycle_work.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_project_lifecycle_work.py#L1) | Different Git blob |
| [tests/integration/test_projects.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_projects.py#L1) | Different Git blob |
| [tests/integration/test_proposal_sending.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_proposal_sending.py#L1) | PH3 only |
| [tests/integration/test_public_admission.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_public_admission.py#L1) | PH3 only |
| [tests/integration/test_quoting.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_quoting.py#L1) | PH3 only |
| [tests/integration/test_quoting_list_performance.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_quoting_list_performance.py#L1) | PH3 only |
| [tests/integration/test_quoting_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_quoting_routes.py#L1) | PH3 only |
| [tests/integration/test_record_fields.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_record_fields.py#L1) | PH3 only |
| [tests/integration/test_record_pagination.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_record_pagination.py#L1) | PH3 only |
| [tests/integration/test_recovery_rehearsal.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_recovery_rehearsal.py#L1) | PH3 only |
| [tests/integration/test_reference_fields.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_reference_fields.py#L1) | PH3 only |
| [tests/integration/test_report_pagination.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_report_pagination.py#L1) | PH3 only |
| [tests/integration/test_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_routes.py#L1) | Different Git blob |
| [tests/integration/test_save_feedback.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_save_feedback.py#L1) | Different Git blob |
| [tests/integration/test_sending_dispatch.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_sending_dispatch.py#L1) | PH3 only |
| [tests/integration/test_sending_isolation.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_sending_isolation.py#L1) | PH3 only |
| [tests/integration/test_sending_manual_followup.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_sending_manual_followup.py#L1) | PH3 only |
| [tests/integration/test_sending_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_sending_routes.py#L1) | PH3 only |
| [tests/integration/test_settings_cache_refresh.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_settings_cache_refresh.py#L1) | PH3 only |
| [tests/integration/test_social_auth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_social_auth.py#L1) | PH3 only |
| [tests/integration/test_static_asset_cache.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_static_asset_cache.py#L1) | PH3 only |
| [tests/integration/test_subscription_billing.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_subscription_billing.py#L1) | PH3 only |
| [tests/integration/test_subscription_capacity.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_subscription_capacity.py#L1) | PH3 only |
| [tests/integration/test_subscription_domain.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_subscription_domain.py#L1) | PH3 only |
| [tests/integration/test_subscription_http.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_subscription_http.py#L1) | PH3 only |
| [tests/integration/test_subscription_payments_http.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_subscription_payments_http.py#L1) | PH3 only |
| [tests/integration/test_subscription_retention.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_subscription_retention.py#L1) | PH3 only |
| [tests/integration/test_tenancy.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_tenancy.py#L1) | Different Git blob |
| [tests/integration/test_tenancy_capacity.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_tenancy_capacity.py#L1) | PH3 only |
| [tests/integration/test_tenant_demo.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_tenant_demo.py#L1) | Different Git blob |
| [tests/integration/test_time_commands.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_time_commands.py#L1) | PH3 only |
| [tests/integration/test_time_import_http.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_time_import_http.py#L1) | PH3 only |
| [tests/integration/test_timecard_cross_module.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_timecard_cross_module.py#L1) | PH3 only |
| [tests/integration/test_timecard_productivity.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_timecard_productivity.py#L1) | PH3 only |
| [tests/integration/test_timecard_week_metrics.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_timecard_week_metrics.py#L1) | PH3 only |
| [tests/integration/test_usage_browser_flow.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_usage_browser_flow.py#L1) | Different Git blob |
| [tests/integration/test_workspace_operations.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_workspace_operations.py#L1) | PH3 only |
| [tests/integration/test_workspace_overview_search.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_workspace_overview_search.py#L1) | PH3 only |
| [tests/migration_target.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/migration_target.py#L1) | PH3 only |
| [tests/template_assets.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/template_assets.py#L1) | PH3 only |
| [tests/test_project_billing.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/test_project_billing.py#L1) | Different Git blob |
| [tests/test_project_billing_reports.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/test_project_billing_reports.py#L1) | Different Git blob |
| [tests/test_record_references.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/test_record_references.py#L1) | PH3 only |
| [tests/test_sending.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/test_sending.py#L1) | PH3 only |
| [tests/test_tenancy_config.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/test_tenancy_config.py#L1) | Different Git blob |
| [tests/timecard_history.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/timecard_history.py#L1) | PH3 only |
| [tests/unit/__init__.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/__init__.py#L1) | PH3 only |
| [tests/unit/test_client_code_validation.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_client_code_validation.py#L1) | PH3 only |
| [tests/unit/test_dashboard_calendar.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_dashboard_calendar.py#L1) | PH3 only |
| [tests/unit/test_email_auth.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_email_auth.py#L1) | PH3 only |
| [tests/unit/test_financial_values.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_financial_values.py#L1) | PH3 only |
| [tests/unit/test_flexfields.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_flexfields.py#L1) | PH3 only |
| [tests/unit/test_integration_contracts.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_integration_contracts.py#L1) | PH3 only |
| [tests/unit/test_invitation_template.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_invitation_template.py#L1) | PH3 only |
| [tests/unit/test_ker_navigation.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_ker_navigation.py#L1) | PH3 only |
| [tests/unit/test_library.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_library.py#L1) | PH3 only |
| [tests/unit/test_live_templates.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_live_templates.py#L1) | PH3 only |
| [tests/unit/test_logging.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_logging.py#L1) | Different Git blob |
| [tests/unit/test_migration_target.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_migration_target.py#L1) | PH3 only |
| [tests/unit/test_onboarding_templates.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_onboarding_templates.py#L1) | PH3 only |
| [tests/unit/test_paddle.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_paddle.py#L1) | PH3 only |
| [tests/unit/test_paddle_templates.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_paddle_templates.py#L1) | PH3 only |
| [tests/unit/test_pagination.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_pagination.py#L1) | PH3 only |
| [tests/unit/test_production_capabilities.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_production_capabilities.py#L1) | PH3 only |
| [tests/unit/test_proposal_sending.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_proposal_sending.py#L1) | PH3 only |
| [tests/unit/test_proposal_sending_transport.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_proposal_sending_transport.py#L1) | PH3 only |
| [tests/unit/test_public_admission_proof.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_public_admission_proof.py#L1) | PH3 only |
| [tests/unit/test_quote_pagination.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_quote_pagination.py#L1) | PH3 only |
| [tests/unit/test_quoting.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_quoting.py#L1) | PH3 only |
| [tests/unit/test_quoting_routes.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_quoting_routes.py#L1) | PH3 only |
| [tests/unit/test_readiness_worker.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_readiness_worker.py#L1) | PH3 only |
| [tests/unit/test_reference_choices.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_reference_choices.py#L1) | PH3 only |
| [tests/unit/test_retention.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_retention.py#L1) | PH3 only |
| [tests/unit/test_sending_templates.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_sending_templates.py#L1) | PH3 only |
| [tests/unit/test_sending_transport.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_sending_transport.py#L1) | PH3 only |
| [tests/unit/test_settings_cache_refresh.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_settings_cache_refresh.py#L1) | PH3 only |
| [tests/unit/test_social_auth_proof.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_social_auth_proof.py#L1) | PH3 only |
| [tests/unit/test_static_assets.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_static_assets.py#L1) | PH3 only |
| [tests/unit/test_status_palette.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_status_palette.py#L1) | PH3 only |
| [tests/unit/test_subscription_templates.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_subscription_templates.py#L1) | PH3 only |
| [tests/unit/test_subscriptions.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_subscriptions.py#L1) | PH3 only |
| [tests/unit/test_templates.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_templates.py#L1) | Different Git blob |
| [tests/unit/test_time_import.py](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/unit/test_time_import.py#L1) | PH3 only |
