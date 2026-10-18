# 06 — Deployment and operations SOP

Snapshot: **2026-10-18**, PH3 source `4bb5c424d6e7d270cdca1479283896be77d581c3`. PH2 is administratively closed at `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6`, tag `ph2-closeout-2026-10-18`. PH3 continues the existing Stage and awaits the owner's feature prompts. This chapter documents source and retained receipts; no operational command, provider request, database connection, deployment or customer effect was executed to produce it. Canonical entry: [CONTINUE.md:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/CONTINUE.md#L1); current operational record: [HOSTING.md:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L1).

## 1. Current authority and operator entry

Ed Lopez authorized PH2 closeout, reversible archive, consolidation and an independent PH3 clone. The next owner prompt selects bounded PH3 feature work. Administrative preparation does not grant provider, identity, database or production authority. Preserve Stage and production services; the transition does not stop services, revoke accounts, cancel subscriptions or activate schedules. See [continuation and pending work](08-PAUSE-AND-CONTINUE.md).

Before a future authorized operation, read current AGENTS, brief, STATUS, operative decisions, design references, privacy/legal documents, HOSTING and relevant operations/deployment sections. Resolve branch, HEAD, dirty state, source/image, target environment, inventory and receipt ownership. Dated historical examples belong to their own run; they do not replace current configuration or authorize replay. Sources: [AGENTS.md:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/AGENTS.md#L1), [CONTINUE.md:35](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/CONTINUE.md#L35), [docs/OPERATIONS.md:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L1).

## 2. Runtime topology and environment separation

One FastAPI/Jinja/HTMX application uses SQLAlchemy/Alembic, PostgreSQL and server-side WeasyPrint. Stage is `https://stage-timeker.aekr.io`. Its Cloudflare Worker routes same-origin requests through one Durable Object/container binding. The profile selects a basic container and `max_instances: 1`, disables workers.dev/preview URLs and platform logs/traces. This supplies no high-availability or autoscaling promise. PostgreSQL persists outside ephemeral container disk. Sources: [deploy/cloudflare/wrangler.jsonc:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/wrangler.jsonc#L1), [Dockerfile:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/Dockerfile#L1), [app/db.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L1).

The container serves port 8000, sleeps after ten idle minutes and waits up to sixty seconds for port readiness while preserving request cancellation. Active streams retain activity. The adapter strips untrusted forwarding headers, supplies trusted forwarding context and suppresses raw SDK exceptions. Uvicorn access logging is disabled. The Docker process probe uses `/health/live`; `/health/ready` remains the deeper explicit database/schema/role check. A listening port or liveness response alone does not establish readiness. Sources: [deploy/cloudflare/src/index.ts:6](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/index.ts#L6), [deploy/cloudflare/src/proxy.ts:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/proxy.ts#L1), [Dockerfile:22](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/Dockerfile#L22), [app/tenancy.py:481](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L481).

Stage uses `wrangler.jsonc`; prepared production configuration/adapter are separate source. Keep origins, database projects, registry descriptors, provider keys, sessions/encryption/internal transport, admission slots and billing datasets environment-specific. Do not copy Stage fixtures, synthetic Pro grants or provider sessions into production. Source defaults are not a fresh production override readback. Sources: [docs/OPERATIONS.md:98](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L98), [app/config.py:75](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L75), [HOSTING.md:204](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L204).

The Stage Worker has a Case-only daily `17 2 * * *` handler, 02:17 UTC. Source/configuration and retained readback establish its presence; actual scheduled execution remains unobserved. It does not dispatch statements. Scheduled Sending remains disabled. Production's archive/mail handlers remain a separate profile. Sources: [deploy/cloudflare/src/index.ts:62](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/index.ts#L62), [deploy/cloudflare/wrangler.jsonc:11](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/wrangler.jsonc#L11), [docs/OPERATIONS.md:30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L30), [HOSTING.md:220](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L220).

## 3. Last verified Stage release

These are retained dated observations, not continuous monitoring or fresh runtime verification by this dossier.

| Item | Retained value |
| --- | --- |
| Tested/deployed runtime source | `e282985ea74e89e1665351c22f91706498495e93` |
| Worker | `retained resource identifier omitted` |
| Deployment | `retained resource identifier omitted`, 100 percent at readback |
| Container application | `retained resource identifier omitted`, version/running 29 |
| Image SHA-256 | `fb3399f00baa2ee9efda0f0dd3e460cc2c706a4ce820133e8af429690948c80c` |
| Final readback | `2026-10-18T03:42:14.067017+00:00` |
| HTTP/asset selection | 31 anonymous GET checks; 15 source-matching versioned assets |
| Health | live 200 in 0.125 s; ready 200 in 4.184 s |
| Provider metadata | One running instance; no active rollout/provider errors; active 1 / healthy 0 |
| Schema | Nine runtime schemas last verified at `ph3_009_read_indexes`; five quarantines unchanged |
| Preserved configuration | 25 plain values, 20 encrypted binding names, existing namespace/resources and Case-only cron |

Source: [HOSTING.md:183](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L183). Preserve healthy 0 as recorded; HTTP 200 does not change that counter. Anonymous GETs do not establish authenticated owner UAT or reverify database persistence. A separate authenticated Clear cache check fetched 22 known public files, preserved an unsaved synthetic value and retained sign-in; it is one feature check. Temporary registry credentials were logged out at `2026-10-18T03:43:23.1891360Z`; that receipt does not describe a future operator session.

The current reviewed prelaunch candidate is `4bb5c424d6e7d270cdca1479283896be77d581c3`. Git publication alone does not deploy the candidate. Original PROD custody/registry has been reconciled into the maintained hosting record; [chapter 13](13-production-stage-differences.md) compares the two sources.

## 4. PostgreSQL, tenancy and connection budgets

Verified identity or a scoped opaque integration credential resolves a trusted fixed descriptor server-side. User/model input cannot select schema, DSN or role. Connections verify expected role/schema. Runtime roles remain nonowner and cannot create/migrate objects, bypass isolation or fall back to the default owner's workspace. Admission slots are operator-prepared; runtime DDL is prohibited. Sources: [app/tenancy.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L1), [app/admission_operations.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_operations.py#L1), [scripts/postgres-runtime-grants.sql:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/scripts/postgres-runtime-grants.sql#L1).

SQLAlchemy hides parameters, disables echo, uses pre-ping, zero overflow and bounded pool waiting. The generic factory defaults to five connections; registry tenant/slot factories use two. Budget all instances multiplied by potentially active pools plus migration, backup/provider and reserve connections. Fifty local workspaces do not prove hosted capacity. Keep reviewed session-pooler/TLS verification; transaction pooling requires separate identity/search_path/prepared-statement/guard compatibility proof. Sources: [app/db.py:9](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L9), [app/tenancy.py:240](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L240), [docs/OPERATIONS.md:711](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L711), [deploy/cloudflare/src/proxy.ts:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/proxy.ts#L1).

Deep readiness checks maintained head/tables/role authority and foreign boundaries. Inventory the relevant retained/prepared/allocated schemas freshly before a future operation; the last nine-schema inventory is not a permanent allocation map. Quarantines are not signup slots. Sources: [app/db.py:6](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L6), [HOSTING.md:206](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L206).

## 5. Disposable local setup and verification

PH3 has source/minimal governance, not old operators, environments, databases, credentials, browser sessions, installed dependencies or historical output. Prepare a new authorized local environment. Keep PostgreSQL data/logs outside synchronized storage. Preserve real filesystem/resource failures without inventing a cause; serialize heavy backend/browser/Docker work when measured capacity requires it.

The examples below apply only to a new fictional local target. Configure loopback PostgreSQL ending `_test`, synthetic keys and a separate DDL fixture authority. Fixtures migrate/TRUNCATE their own targets. Never point them at Stage, production, valuable existing data or real customer records. Guards reject hosted environment names and non-loopback/non-`_test` targets. Sources: [tests/conftest.py:23](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/conftest.py#L23), [README.md:52](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/README.md#L52).

```sh
uv sync --locked
uv run timeker migrate
uv run timeker seed --profile fixture
uv run timeker doctor
uv run uvicorn app.main:app --host 127.0.0.1 --port 8000 --no-access-log
```

`doctor` executes a database `SELECT 1` and imports/reports the WeasyPrint version; it does not render a PDF or prove hosted readiness. Fictional seeding is distinct from private real-data import. Development login is explicitly nonproduction. Compose/demo overrides require separate local database/volume custody and are not hosted deployment profiles. Sources: [app/cli.py:54](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cli.py#L54), [compose.yaml:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/compose.yaml#L1), [compose.demo.yaml:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/compose.demo.yaml#L1).

Use new receipt/log/XML names and source attribution for required checks. Concurrent backend/browser selections require separate targets; downgrade tests require a separate disposable migration database. Browser port 8019 cannot be shared concurrently; external E2E origin is limited to the isolated local demo at `http://127.0.0.1:8029`. Fixtures use synthetic mail/payment data. Install matching Playwright/Pango dependencies only for the selected tests. Sources: [tests/e2e/conftest.py:14](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/conftest.py#L14), [tests/migration_target.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/migration_target.py#L1).

```sh
uv run pytest tests --ignore=tests/e2e -q --tb=short
uv run ruff check app tests --no-cache
uv run mypy app
node --check app/web/static/app.js
node --check app/web/static/workspace.js
node --check app/web/static/settings_cache.js
uv run pytest tests/e2e -q --tb=short
```

These commands were not run for the dossier. Include disposable migration/guard, affected browser/accessibility, deterministic PDF totals and logging-redaction evidence when applicable. Keep exact selections, raw failures and role boundaries; do not sum overlapping suites into unique feature coverage. See [quality/evidence](07-security-privacy-quality-and-evidence.md) and [AGENTS.md:186](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/AGENTS.md#L186).

Retained base source `3e1d564ff56cafbd133533c784afa5e4780e5f53` passed 2,153 backend and 296 browser cases, zero failures/errors/skips in each selection, plus six static checks. Settings source `e282985` separately passed eight backend/four browser cases and seven static checks; this does not create a fresh full-suite claim. Earlier failed attempts remain retained. Administrative closure/clone ran source/Git/document/static checks without rerunning unchanged product suites. Sources: [docs/STATUS.md:143](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L143), [docs/PHASE2_CLOSEOUT.md:85](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/PHASE2_CLOSEOUT.md#L85).

## 6. Reviewed build and Stage release procedure

The multi-stage image uses locked nondevelopment dependencies, native Pango/fonts and UID 10001. Build inputs are explicit; Git ignore alone does not exclude private files from packaging. Do not include private governance, operators, credentials, real PDFs or databases. Sources: [Dockerfile:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/Dockerfile#L1), [.dockerignore:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/.dockerignore#L1).

For a separately authorized release:

1. Pin branch/HEAD/dirty state, bounded changes, prior runtime identities and exact target resources; preserve unrelated work.
2. Run source-bound local checks on disposable targets. Retain failures and justified unchanged-coverage attribution.
3. If schema changes are needed, inventory all applicable workspaces; verify encrypted backup, migration/grants/guards and the database procedure below before an image requiring the new head.
4. Check binding names, plain configuration, namespace/resources, origin and protected inventory validators. Never print secret values; reject mixed profiles.
5. Run the reviewed strict full-Docker/Worker dry-run and retain native output/image digest/input seals. A failed build is not deployment.
6. With current authority, deploy sealed inputs through the fixed Stage profile. The established family uses `wrangler deploy --strict --keep-vars`. Historical private wrappers are not automatically reusable operators.
7. Wait for actual deployment/container convergence; read version/image/running instance, rollout/errors and binding preservation before matching assets and authorized health/public checks.
8. Exercise only separately authorized normal authenticated/human/provider flows; attribute them separately from anonymous health.
9. Record commands, results, failures, compatible recovery boundary and pending acceptance in canonical docs. Close temporary task credentials through selected custody.

CLI exit zero, Git push, a visible form or one 403/503 cannot replace convergence/readback or completed human flow. The retained no-Builds/Actions-disabled observation was not refreshed for administrative closure. Sources: [HOSTING.md:228](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L228), [deploy/cloudflare/README.md:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/README.md#L1), [docs/DEPLOYMENT.md:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/DEPLOYMENT.md#L1).

## 7. Backup, forward migration and restore

### Inventory and protected backup

Inventory retained/prepared/allocated/quarantined schemas, exact heads/owners/runtime roles/grants/markers. Existing approved schema owners migrate; runtime credentials are not DDL authority. Do not change owner/password/role attributes to pass a migration. Credentials/keys stay in protected custody, absent from public text and shell history.

Use the reviewed consistent snapshot/custom-dump orchestration; encrypt protected payloads and retain independent integrity/TOC metadata. Unrelated dumps do not create one consistent multi-schema snapshot. `pg_dump`, `pg_restore --list` and reviewed `pg_restore --no-owner --exit-on-error` into a new isolated target identify tools, not a selected connection or execution instruction. Sources: [docs/OPERATIONS.md:142](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L142), [docs/OPERATIONS.md:758](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L758).

Separate schema 009 custody covered nine schemas/495 snapshot tables. Apply/fresh verify preserved 486 business-table full-column fingerprints, sequence values, definitions/ACLs, runtime grants and five quarantines; 36 guards/schema and 72 reciprocal SQLSTATE 42501 denials before/after passed. Only three additive B-trees and reviewed head/slot markers changed. Stage 29 image-only GET checks do not repeat this proof. Decrypt/TOC checks are not hosted restore. Sources: [HOSTING.md:197](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L197), [alembic/versions/ph3_009_read_indexes.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_009_read_indexes.py#L1), [docs/STATUS.md:173](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L173).

### Apply and independently verify

Rehearse the exact forward migration on a new disposable/restored target with compatible source and reviewed fixture-owner authority. Before hosted DDL, verify source/backup/pins, expected server/database/TLS, original immutable owner identity, actual restricted runtime authority and retained fingerprints/guards. Apply only reviewed migration/grants; journal each schema transaction separately. Verify heads/structures/full retained fingerprints, ownership/search paths, table/sequence grants, no runtime DDL and reciprocal denials under actual restricted roles. Include slot markers and central/noncentral directory boundaries.

Per-schema commits are not a globally atomic upgrade. On failure/uncertainty, stop and retain outcomes, backup/source/image/pins. Independently inspect actual committed heads/data/grants/markers before bounded forward continuation. Never blindly replay a carrier, reseed/reset, change ownership or downgrade populated history. Guard-only downgrades may retain protections; old writers can still be incompatible with stable IDs/immutable history. Sources: [docs/OPERATIONS.md:142](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L142), [scripts/postgres-runtime-grants.sql:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/scripts/postgres-runtime-grants.sql#L1), [alembic/versions/ph3_007_work_records.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L1).

### Restore and external effects

Restore/cutover is separately selected. Rehearse in a new isolated database with compatible image, separate key custody and effects disabled. Verify all retained/prepared schemas; roles/grants/search paths/guards; heads; issued bytes/checksums; balances/contributions/import/audit receipts; admission slots; integrations/revocations; Mail attachments; and subscription/delivery uncertainty. Do not revive stale sessions/provider credentials publicly.

Restore cannot undo an accepted email, purchase/webhook or refresh rotation. Reconcile post-snapshot provider effects/revocations before writers/retry. A restored Pending row does not authorize resend/recharge. Roll back an image only with compatible schema/immutable-writer semantics; otherwise prepare forward repair. Local rehearsals do not establish a current hosted restore, funded backup service, RPO or RTO. Sources: [docs/OPERATIONS.md:711](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L711), [docs/OPERATIONS.md:758](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L758), [docs/STATUS.md:94](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L94).

Archiving controls visibility/export while retaining references/history. It is neither backup nor storage reclamation. Issued artifacts remain immutable. Do not schedule destructive purges; retention/rights/holds and off-host/key custody remain selected operational decisions. Sources: [docs/OPERATIONS.md:758](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L758), [docs/OPERATIONS.md:8](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L8).

## 8. Incidents, diagnostics and uncertainty

Diagnostics allow sanitized UTC event/request/execution/entity IDs, registered route/method/status, duration and terminal outcome. Business audit belongs in its database transaction. Suppress raw exception/SQL/access/provider output. Logging failure cannot alter a committed result. Never copy tokens, cookies, headers/query strings, addresses, business text, contracts, bank/tax data or PDF bytes into diagnostics/tickets. Sources: [app/logging.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L1), [app/audit.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/audit.py#L1), [tests/unit/test_logging.py:1](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_logging.py#L1).

| Symptom | Bounded response |
| --- | --- |
| Rollout/cold-start 503 | Preserve safe timing/request ID; inspect rollout/image/instance/readiness, allow convergence, never replay a mutation. |
| Readiness/schema/role mismatch | Fail closed; compare inventory/head/grants/guards/expected role. No bypass. |
| Generic auth/CSRF error | Trace safe typed reason/exact normal flow; require fresh human proof. Generic text alone does not identify a provider cause. |
| Sending/Paddle timeout after claim | Retain uncertainty; reconcile exact provider acceptance before retry. |
| Partial DDL/deploy | Retain journal/backup/old and new source/image; inspect committed state before continuation. |
| Local filesystem/resource fault | Retain failure; isolate owned PostgreSQL storage outside sync, measure resources; do not kill unrelated processes. |
| Damaged source/artifact | Preserve original bytes/hash privately; restore only owned intended content, verify identity and rerun affected checks. |

## 9. Verified private PH2 production prelaunch


The bounded private PH2 production prelaunch is technically verified under D076. The deployed runtime is `5b0fb0d29f506d04e4a6af3ebd8a193089af7214`, with both retained production schemas at `ph3_009_read_indexes`. Paddle remains Sandbox; generic/public/email-public/Stage onboarding, Live and Sending jobs remain false. Existing inbound Mail capture remains enabled. Personal fresh Google proof, explicit acknowledgment, owner catalog verification/plan choice and human UAT remain pending. PH3 feature prompts still follow; no future feature prompt has been implemented.

| Technical observation | Verified release fact |
| --- | --- |
| Runtime source | `5b0fb0d29f506d04e4a6af3ebd8a193089af7214` |
| Worker version | `d7618b2e-0ff5-410c-b6db-63482e3ca355` |
| Deployment | `c20208fa-4510-45da-a3ad-f7204fa22645` |
| Container configuration / running versions | `13` / `[13]` |
| Container image digest | `sha256:9323ae9e842b70695b56f83c579dc939d91f8f210b8a39ba31bbaf79aa38b464` |
| Retained production schemas | Both `ph3_009_read_indexes`; no Stage data or identity copy |
| Preservation | All 40 old business-table projections preserved; issued artifact/history/role custody retained |
| Runtime restoration | Original LOGIN attributes restored; TLS verification and four actual reciprocal 42501 denials; no postLOGIN projection drift |
| Production HTTP | `/health/live` 200/status `ok`; `/health/ready` 200/status `ready`; private preview and invitation-only pages; 13 exact raw-source static assets |
| Unsigned webhook | Empty unsigned JSON rejected with HTTP400 and `event_rejected`; no verified billing event applied |
| Stage observation | Two read-only health GETs returned 200; this production rollout did not redeploy Stage |
| Activation | Sandbox/private prelaunch only; generic/public/email-public/Stage onboarding, Live, outbound Sending/jobs remain disabled; existing inbound Mail capture retained |
| Personal actions | Fresh Google/explicit acknowledgment, owner Verify catalog/plan choice and UAT pending |

The exact frozen encrypted backup `95db86b295a7c21c1ac0f64adc70a94d25cc1e7329a92b4f57c35ac14a4cb678` was restored and migrated only in an owned local rehearsal in 8.985 seconds; the local cluster was stopped. This is exact-ciphertext local recovery evidence, without a hosted restore or accepted hosted RPO/RTO claim.

Release verification retains the earlier 2,229 backend-case / 304 browser-case aggregate only at its original source and scope. The final five-template subscription correction freshly reran 429 backend cases including 49 added unit cases, and 13 browser cases including three added browser cases. These are overlapping blocks, not extra counts to sum into the earlier aggregate. The other 239 of 244 packaged runtime files were byte-identical to the prior candidate; 239 describes files, not browser tests. The full earlier backend/browser matrix was not freshly rerun for the final documentation pin. Dossier generation runs no product tests.

GitGuardian remains failed for the known historical transport test fixture: its password is fake, but the fixture references an actual Stage project rather than a placeholder. The signal is retained and is not reported as a passing check. Supabase Preview is SKIPPED because this branch lacks a Supabase Branch association; this does not replace the separately verified production database/readiness evidence.

These are retained release observations at `2026-10-18T16:39:19.019735+00:00`, not continuous monitoring. The final source checkpoint may add release documentation to the deployed runtime; each pin is labeled separately. Canonical authority: [HOSTING.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L1), [docs/STATUS.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L1), [CONTINUE.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/CONTINUE.md#L1).

## 10. Custody and evidence limits

PH2 archive validation retained **28 batches, 8,149 files and 1,580,224,720 bytes** with raw hashes/inverse restoration mappings. The separate Quoting move retained 823 files, one junction and 61,863,545 file bytes. This is local recoverable custody, not public payload, off-host backup or hosted recovery. Current tests/migrations/contracts/design references remain active. Historical payload requires bounded owner retrieval authority. Source: [docs/PHASE2_CLOSEOUT.md:57](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/PHASE2_CLOSEOUT.md#L57).

Historical initial PH3 preparation checked 503 tracked files. The current prelaunch candidate is separately inventoried at 506 paths. Only CONTINUE, README and STATUS changed for startup; the other 500 raw files match closed PH2. Git storage has no alternates/shared commondir, with independent corresponding object/pack file identities. Markdown and the 32-ID map passed. Generic scaffold validation failed on unchanged mandatory product `AGENTS.md`; preserve product authority and the minor compatibility concern rather than claiming PASS. Sources: [docs/PHASE2_CLOSEOUT.md:85](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/PHASE2_CLOSEOUT.md#L85), [CONTINUE.md:17](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/CONTINUE.md#L17).

Outcome remains `DONE_WITH_CONCERNS`: administrative delivery is closed/prepared; real MCP, human UAT, hosted recovery and Live/production acceptance remain open. The public dossier contains safe source explanations/provenance, without private keys, archived payload or business records.
