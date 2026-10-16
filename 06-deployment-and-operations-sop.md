# 06 — Deployment and operations SOP

**Snapshot and handoff date: 16 October 2026.** This is a source-backed operational dossier at the HOC pause, not a new active runbook or authorization to operate production. Commands are documentation only; none were run to prepare this chapter. A future operator must re-read the canonical repository, current receipts and the specific approval before using any example.

**Reviewed feature checkout (source snapshot):** `C:/Users/edlop/OneDrive/Documents/VS Code/timeker-PH2-quoting`, at documentation HEAD `48e854ff2107dffb217dfe7c487b1b9d36a7f41d`. The current Stage branch and canonical continuation are in the parent checkout, `C:/Users/edlop/OneDrive/Documents/VS Code/timeker-PH2`; its pre-pause source matched this snapshot. The deployed feature bytes are from `dbf73e52ca03726e7903dc74ef27e40339c06936`. All `file:line` references below describe the analyzed snapshot. The original production checkout remained clean at `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609`; this delivery did not change production.

## 1. Pause state and operator responsibilities

The requested HOC pause means stop engineering, deployments, migrations, new verification activity and discretionary provider actions until explicit resumption. It **does not** terminate the deployed application, PostgreSQL service, provider webhook traffic, previously configured cron/email routing, or an external subscription. Runtime shutdown, message cancellation or subscription cancellation are separate actions with separate consequences and authority.

Retain the working source, immutable release artifacts, failed receipts, encrypted backup and private operator custody. Do not clean up by deleting databases, schemas, receipts, uploads, roles, container history or customer artifacts. The task-owned disposable PostgreSQL cluster was stopped gracefully at **20:14:47 UTC**, with files retained; temporary Docker registry credentials were logged out after release. These facts do not mean the hosted runtime was stopped. Source: `docs/STATUS.md:113`.

On resume, start with `AGENTS.md`, `docs/PROJECT_BRIEF.md`, current sections of `docs/STATUS.md`, `docs/DECISIONS.md`, design references, `HOSTING.md`, `docs/OPERATIONS.md` and the relevant privacy/legal documents. Historical sections remain evidence of earlier states; they are not current configuration. `README.md` and `docs/DEPLOYMENT.md` contain useful local setup material but retained older release identities/test counts must not replace the current STATUS/HOSTING release record.

## 2. Runtime topology and boundaries

### 2.1 Cloudflare edge and Container

The isolated Stage public origin is `https://stage-timeker.aekr.io`. A Cloudflare Worker validates the selected environment and forwards same-origin requests into one named Cloudflare Container through its Durable Object binding. The Stage configuration selects a **basic** instance and `max_instances: 1`, disables workers.dev and preview URLs, and disables platform log/tracing collection in that profile. This is not a high-availability or autoscaling promise. Sources: `deploy/cloudflare/wrangler.jsonc:3`, `deploy/cloudflare/wrangler.jsonc:8`, `deploy/cloudflare/wrangler.jsonc:11`, `deploy/cloudflare/wrangler.jsonc:16`, `deploy/cloudflare/wrangler.jsonc:26`.

The Container listens on port 8000, sleeps after ten minutes of inactivity, and waits up to sixty seconds for the port with the incoming abort signal preserved. The longer wait was added because tenant readiness can exceed the SDK's old twenty-second default on a cold start. It does not authorize replaying the client's request after an uncertain business mutation. Activity/stream handling preserves the lifetime of active responses. Sources: `deploy/cloudflare/src/index.ts:6`, `deploy/cloudflare/src/index.ts:27`, `deploy/cloudflare/src/index.ts:32`.

The proxy strips untrusted forwarding headers and creates its own trusted forwarding context; the Stage origin, database project and provider configuration are pinned by the adapter. Network-derived abuse keys are purpose-separated HMACs rather than raw IP logging. Uvicorn runs without access logs; the image's generic command uses no proxy-header trust. Source: `deploy/cloudflare/src/proxy.ts:210`, `deploy/cloudflare/src/proxy.ts:247`, `deploy/cloudflare/src/proxy.ts:265`, `Dockerfile:23`.

There is one Python application, not a second backend: FastAPI, SQLAlchemy/Alembic, server-rendered Jinja, HTMX/local JavaScript, and server-side WeasyPrint PDFs. PostgreSQL is outside the Container; sleeping/replacing the Container does not erase database storage. Source: `Dockerfile:1`, `app/main.py`, `app/db.py:1`.

### 2.2 Separate Stage and production profiles

`deploy/cloudflare/wrangler.jsonc` is the active isolated Stage profile. `wrangler.production.jsonc` and the production entrypoint are separate prepared source, not a production cutover performed by this release. Do not use Stage bindings, fake identities, Sandbox catalogs, prepared Stage slots or development login settings in production. Quoting, Library and commercial Sending are unavailable in production through `commercial_documents_available`; production statement Sending additionally needs its own production flag. Sources: `docs/OPERATIONS.md:60`, `app/config.py:202`, `app/config.py:206`.

The production source entrypoint includes archive scheduling and inbound mail capture; Stage's entrypoint does not gain those handlers by sharing application code. Stage contact and mail capture are disabled, business Sending jobs are false, and Paddle is Sandbox. Existing production schedules were not modified by the Stage delivery. Sources: `deploy/cloudflare/src/production.ts:63`, `deploy/cloudflare/src/production.ts:67`, `deploy/cloudflare/src/production.ts:72`, `deploy/cloudflare/wrangler.jsonc:36`, `deploy/cloudflare/wrangler.jsonc:46`, `deploy/cloudflare/wrangler.jsonc:55`.

## 3. Current Stage release identity and proof

| Item | Verified value |
| --- | --- |
| Public origin | `https://stage-timeker.aekr.io` |
| Feature source | `dbf73e52ca03726e7903dc74ef27e40339c06936` |
| Worker version | `9a1cfc5f-73ec-4856-b3bb-ea9a2817168c` |
| Deployment | `7ad0ff03-c344-4cad-be59-409d3e490813`, 100% |
| Container application | `a0343dd5-a04b-4e30-b5da-98a373bf4990`, version 20 |
| Image SHA-256 | `9b04918f1171f93c5e7b6009c114846ba8b7f36390e2e3ad3e27cc879944f426` |
| Durable Object namespace | `7a44251757ea4f46ada50886133f915f` |
| Running instance | `18b0a510c32d8f837485fab90f752acf39ed6ec9036c6bf3f9a322144ada81d2`, `timeker-ph2-stage-v1`, version 20, bos03 |
| Database head | `ph3_006_quoting_library`, all nine retained/prepared runtime schemas |

Canonical record: `HOSTING.md:9`, `docs/STATUS.md:22`, `deploy/cloudflare/STAGE_RELEASE.md:1`. Private readback metadata is retained under `.aekr/work/quoting-library-20261016/`; it contains no credential values in this dossier.

The converged application metadata at **20:24:02.928 UTC** had no active rollout or errors. It reported **active 1 / healthy 0**, while the actual instance separately reported running/version 20. Do not normalize that provider counter to healthy 1. Independent HTTP checks establish different facts: `/health/live` and `/health/ready` returned 200, with readiness taking approximately 24.789 seconds. Source: `HOSTING.md:17`.

At **20:24:57.053515 UTC**, nineteen hosted **GET-only** checks passed: public authentication/policy/recovery paths, live/ready, seven source-matching static asset digests, and three anonymous protected routes redirecting 303 to `/`. Binding comparison preserved twenty-five plain values, twenty encrypted binding **names**, and the namespace. A Brave navigation initially saw a transient rollout 503, then the public landing because there was no authenticated session. This is not authenticated hosted Quoting/Library/Sending UAT. No auth POST, OTP/mail read, account creation, agreement acceptance, real send or payment was performed by these checks. Sources: `HOSTING.md:22`, `docs/STATUS.md:22`.

## 4. PostgreSQL, tenant roles and connection budgets

Stage uses the recorded Supabase **session pooler** endpoint `aws-0-us-east-2.pooler.supabase.com:5432/postgres`, not transaction pooling. The Worker requires `sslmode=verify-full`, the bundled trusted vendor CA, the pinned project/role/database, and only bounded supported connection options. Data API access is disabled; application business schemas are not exposed to anonymous/authenticated API roles. Sources: `HOSTING.md:336`, `deploy/cloudflare/src/proxy.ts:210`, `Dockerfile:18`.

The registry contains trusted fixed tenant descriptors. Verified session identity or an authenticated opaque integration credential resolves a descriptor; user/model input cannot name a schema, runtime role or arbitrary connection. Factories use fixed role/schema connections and verify `current_user` and `current_schema()` on connect. SQLAlchemy hides parameters, disables echo, uses pre-ping, zero overflow and a ten-second pool timeout. The generic factory default is five connections; registry tenant/slot factories explicitly use two. Budget all instances × active tenant pools plus migrations, backups, provider headroom and operator connections. Historical fifty-tenant local evidence is not a hosted capacity guarantee. Sources: `app/db.py:9`, `app/tenancy.py:96`, `app/tenancy.py:234`, `app/tenancy.py:276`, `app/tenancy.py:476`, `docs/OPERATIONS.md:673`.

Runtime roles do not own or migrate objects and have no superuser, CREATEDB, CREATEROLE, bypass-RLS, inherited membership, foreign schema access or own-schema CREATE. Maintained grants distinguish normal mutable tables from append-only snapshots/history and guarded draft deletion. The central admission directory alone permits the required SELECT/INSERT/UPDATE; noncentral shadow directories are denied. Function ownership/search paths and revoked PUBLIC/runtime execution are part of the boundary. Sources: `scripts/postgres-runtime-grants.sql:1`, `app/tenancy.py:355`, `app/admission_operations.py:79`, `app/workspace_operations.py:83`.

Readiness checks the maintained head, required tables, role authority and foreign boundaries before normal service. A healthy TCP port alone cannot establish correct schema/grants or registration readiness. `/health/live` and `/health/ready` expose status, not secrets or customer data. Sources: `app/db.py:6`, `app/tenancy.py:346`, `app/tenancy.py:355`, `app/main.py:678`.

## 5. Safe local setup and test procedure

These examples are for a **new disposable local environment only**, not Stage or production. Do not copy a hosted database or real client artifacts into fixtures. Use a dedicated database ending `_test` on loopback, an explicitly test environment, and a separate administrator for schema/role setup. Test fixtures migrate and TRUNCATE their database; pointing them at valuable data is destructive. The suite refuses hosted environment names and non-loopback/non-`_test` targets. Source: `tests/conftest.py:23`, `tests/conftest.py:38`, `tests/conftest.py:57`.

Keep PGDATA and PostgreSQL logs outside OneDrive or other synchronized folders. The retained auth work encountered a real PostgreSQL file-creation `Invalid argument` error with PGDATA inside OneDrive; a new empty local cluster outside sync storage was the remediation. A large unrelated process also coincided with resource exhaustion/browser closure, but the exact browser/WSL cause was not proven. Do not convert correlation into an established diagnosis. Serialize memory-heavy full backend, browser and Docker activity when capacity is constrained. Prior evidence/history: `docs/STATUS.md:128` and its serial validation record.

The latest task used PostgreSQL 18 on loopback port **55580**, outside OneDrive under the task's LocalAppData custody, restricted test roles, separate backend/browser/migration databases, and synthetic data. It is now stopped. Future work must verify path/port/pins and prepare new disposable databases; do not restart it or reuse a destructive fixture merely because it existed.

Documented setup commands after configuring a new isolated local target and synthetic keys:

```powershell
uv sync --locked
uv run timeker migrate
uv run timeker seed --profile fixture
uv run timeker doctor
uv run uvicorn app.main:app --host 127.0.0.1 --port 8000 --no-access-log
```

`doctor` checks database connectivity and a PDF render. `seed --profile fixture` is fictional; never run `seed --profile alco`, copy/restore or reset on a hosted target as release preparation. Development login must remain explicitly nonproduction. Source: `README.md:43`, `app/cli.py:24`, `app/cli.py:50`, `app/cli.py:54`, `app/cli.py:103`.

Compose provides local PostgreSQL, a migration job and the application; it is development-only. The separate demo override has its own project/volume and fictional data. It is not a deployment model for hosted credentials. Documented commands, not executed here:

```powershell
docker compose up --build
docker compose exec app timeker seed --profile fixture
```

Sources: `compose.yaml:1`, `compose.demo.yaml:1`, `README.md:64`.

For normal verification, use fresh receipt/log/XML paths and before/after source manifests. Backend and browser must use separate databases if overlapping; migration downgrade tests must use their own empty database. Existing fixture browsers start loopback port 8019 and cannot overlap that port; an external E2E origin is allowed only for the isolated local container at `http://127.0.0.1:8029`. Browser providers are stubbed; no real email or payment is required. Sources: `tests/e2e/conftest.py:14`, `tests/e2e/conftest.py:24`.

```powershell
uv run pytest tests --ignore=tests/e2e -q --tb=short --junitxml=<new-private-backend.xml>
uv run ruff check app tests
uv run mypy app
node --check app/web/static/app.js
node --check app/web/static/auth_challenge.js
uv run pytest tests/e2e/test_quoting_library_browser.py tests/e2e/test_quoting_lookup_browser.py tests/e2e/test_proposal_sending_browser.py tests/e2e/test_case_workflow_browser.py tests/e2e/test_lookups_browser.py tests/e2e/test_sending_browser.py -q --tb=short --junitxml=<new-private-browser.xml>
```

Angle-bracket output placeholders must be replaced before use. Matching Playwright Chromium installation is a separate local dependency step; no browser download was performed for this dossier. PDF/render checks also require the local Pango/WeasyPrint runtime. Sources: `README.md:45`, `README.md:82`.

### Current test evidence, without inflated totals

The latest backend gate is **CONSOLIDATED_PASS covering 1,785 distinct cases**, not a fresh all-green full run. Raw r3 is retained as **FAILED: 1,784 PASS / 1 FAIL**, 909.65 seconds, seven upstream warnings. Its only failure was an obsolete navigation order expectation. After a one-line assertion correction, the complete unit suite passed **761 cases**, 9.45 seconds, one warning. Current app/integration/root/migration/grant bytes match r3; the consolidated receipt retains **917 integration + 107 root-level backend** successes and the fresh 761 units with exact disjoint coverage and artifact/diff pins. One collection-time UUID4 parameter label was normalized solely for coverage matching. Do not sum overlapping runs into 2,546 or relabel raw r3 PASS. Source: `docs/STATUS.md:61`.

Final r4 affected browser: **32 PASS**, zero failures/errors/skips, 78.98 seconds, one upstream warning. Ruff, mypy **79 modules**, both JavaScript syntax checks and **84 Jinja templates** passed. A fresh disposable base→head→base→head and Alembic check passed with **32 protective functions**. Worker/dependency bytes were unchanged, so their suites were **not rerun** for this feature. Focused counts overlap and are not additional unique coverage. Sources and exact executed commands: `docs/STATUS.md:73`, `docs/STATUS.md:83`.

## 6. Docker build and guarded Stage release SOP

The multi-stage Dockerfile pins uv `0.13.0`, uses Python `3.13-slim`, installs locked non-development Python dependencies, and adds Pango/fonts for WeasyPrint. Runtime UID is 10001. Application, Alembic, grants and the vendor CA are copied into the image; database credentials and real business payloads are not build inputs. The runtime command serves port 8000 and the image probes local readiness. Sources: `Dockerfile:1`, `Dockerfile:8`, `Dockerfile:10`, `Dockerfile:15`, `Dockerfile:20`, `Dockerfile:22`.

The reviewed Stage deployment route is manual, with exact source and receipt seals, a strict build dry-run and `wrangler deploy --strict --keep-vars` against the fixed Stage config. `--keep-vars` is essential to the established binding-preservation discipline; success still requires comparing actual readback. The private wrapper is an immutable record of this release, not a reusable generic production script. The package's plain dry-run shortcut is not equivalent to all private guard checks. Sources: `docs/STATUS.md:97`, `docs/STATUS.md:104`, `deploy/cloudflare/package.json:6`; private `.aekr/work/quoting-library-20261016/release-stage.ps1:1`.

A future approved Stage release should follow this sequence:

1. Resolve current branch/HEAD/dirty state and verify the authorized environment/resource identity. Pin all app/test/migration/static/config/dependency bytes and current prior Worker/application metadata. Review changes and pending gates.
2. Produce appropriate clean local evidence with disposable targets, exact commands, logs/JUnit and source before/after hashes. Preserve failures explicitly; any consolidated gate needs an independently verified narrow change and disjoint unchanged coverage.
3. Inventory retained and prepared schemas. Obtain and verify encrypted consistent backup before DDL. Review migration/role/grant/function/slot boundaries. Complete the migration SOP below before deploying an image that requires the new head.
4. Verify all required binding **names**, plain configuration, protected inventory validators, namespace/resources and selected origin. Never print a binding value. Reject missing/mixed profiles rather than weakening validators.
5. Run the current reviewed strict Docker/Worker dry-run. Retain image digest and native build output. If download/build fails, retain the failed outcome; do not call it a deployment.
6. Only with current authority, deploy the sealed source/config/image. Save Worker version and deployment identity. Wait for the deployment percentage and Container rollout to converge; CLI exit zero alone is insufficient.
7. Read actual application/image/version, running instance, rollout/errors/resources and binding-preservation metadata. Run the specifically authorized hosted checks and match actual asset digests. Keep anonymous/public health results separate from authenticated feature UAT.
8. Record exact results, failures, pending human proof and rollback boundary in canonical docs. Retain backup/receipts and remove only temporary task credentials through the authorized custody procedure.

Current readback helper/receipt: `.aekr/work/quoting-library-20261016/verify_release_readback.py` and `stage-final-release-readback-receipt.json`. It records the actual healthy counter rather than fabricating one. This dossier does not rerun that helper or any network command.

## 7. Backup, migration and restore SOP

### 7.1 Inventory and backup before a writer change

Inventory **all retained, prepared and allocated** workspaces, not only logged-in owners. Current active inventory is four retained schemas (`timeker`, `timeker_eve`, `timeker_stage_ed`, `timeker_stage_cordo`) plus five correctly prepared `timeker_stage_signup_01` through `_05` slots. The five prefix-mismatched `timeker_signup_01` through `_05` are excluded quarantine: empty, NOLOGIN, unchanged head005/markers/structure. Do not allocate, delete or reassign them incidentally. Source: `docs/OPERATIONS.md:8`, `docs/OPERATIONS.md:104`.

Use existing schema owners for migration: four named migrators and the existing administrator for five administrator-owned prepared schemas. Runtime roles are never migration credentials. No owner/password/role change is an acceptable shortcut to pass DDL. All database/provider secrets remain in protected operator custody; the source tree/dossier holds only names, pins and safe receipts.

The completed release exported a consistent repeatable-read snapshot and custom-format dump for the bounded schemas, encrypted the backup outside Git, and verified archive inventory plus decrypted SHA-256. This proves custody/readability/inventory, **not** a restore rehearsal, RPO, RTO or hosted recovery readiness. Current backup completed its custody verification at **20:17:48 UTC**. Source: `docs/OPERATIONS.md:118`; private carrier review `.aekr/work/quoting-library-20261016/STAGE_CARRIER_REVIEW.md:31`.

Generic command shapes for a future authorized, protected operator session are shown only to identify tools; they are not executable targets:

```text
pg_dump --format=custom --file=<protected-staging-dump> <approved-connection>
pg_restore --list <verified-dump>
pg_restore --no-owner --exit-on-error --dbname=<new-isolated-restore-target> <verified-dump>
```

Never place an actual password/DSN in shell history or dossier text. A consistent multi-schema snapshot requires the reviewed snapshot/locking orchestration, not merely running several unrelated dumps. Encrypt protected business data promptly using the approved custody mechanism and retain integrity metadata separately. Source: `docs/OPERATIONS.md:760` and the bounded current carrier documentation.

### 7.2 Apply and verify a forward migration

The current head `ph3_006_quoting_library` adds nine tables: `quotes`, `quote_revisions`, `quote_lines`, `quote_artifacts`, `library_documents`, `library_uploads`, `library_document_versions`, `proposal_sending_deliveries`, and `proposal_sending_attempts`. It adds protective guards for frozen artifacts, owned Case binding, publication, immutable attempts and permitted claim/settle transitions. Downgrade refuses while commercial data or Services Cases remain. Sources: `alembic/versions/ph3_006_quoting_library.py:13`, `alembic/versions/ph3_006_quoting_library.py:281`, `alembic/versions/ph3_006_quoting_library.py:528`.

The completed Stage carrier verified source/pin/backup seals, expected server/database/TLS, existing owner identity, actual runtime password authority, retained fingerprints and function definitions **before any DDL**. Each schema's migration and exact grants executed in its own transaction under its existing owner. It updated compatible preparation markers for the five real slots and rechecked central/noncentral admission grants. UTC/ISO/bytea-hex canonicalization made fingerprints comparable across owner connections. Source: `docs/OPERATIONS.md:104`; private `stage_quoting_carrier.py` and `STAGE_CARRIER_REVIEW.md` under the reviewed task evidence directory.

Final migration/readback completed **20:21:58.954519 UTC**:

- Nine schemas at head006; **396** pre-existing non-Alembic table fingerprints unchanged, forty-four per schema including directory shadows.
- Nine new tables per schema, **81** total, all empty at migration readback.
- **32** exact protective functions per schema, pinned owner/search path, no PUBLIC/runtime execution, exact table/sequence grants.
- Actual nine restricted runtime password connections passed authority checks and produced **72 reciprocal SQLSTATE 42501 denials before DDL** and a separate **72 after**.
- No account allocation, role attribute, object ownership, credential or retained business data changed; all five quarantined schemas remained unchanged.

Source: `docs/OPERATIONS.md:118`, `docs/STATUS.md:47`. This is not a claim that every future schema or grant will remain correct without revalidation.

**Partial migration rule:** the nine transactions are separate commits, not one cross-schema atomic upgrade. On a failure or uncertain outcome, stop and retain the encrypted backup, expected source/image/pins and per-schema outcome journal. Independently read actual heads, structure, row fingerprints, grants and markers before preparing a bounded forward continuation. Never replay the executed carrier blindly, seed/reset, change schema ownership or downgrade populated history as an operational retry. Source: `docs/OPERATIONS.md:134`.

### 7.3 Restore rehearsal and recovery

A restore is a new separately approved operation. Rehearse into a new isolated database with compatible source/image, private key custody and no network effects. Validate the entire retained/prepared schema inventory, roles/grants/search paths/function guards, migration heads, issued bytes/checksums, financial balances, audit history, integration/token receipts, slot allocation markers, mail artifacts and subscription/delivery uncertainty. Do not expose restored sessions or old machine credentials to the public application. Sources: `docs/OPERATIONS.md:673`, `docs/OPERATIONS.md:708`, `docs/OPERATIONS.md:760`.

Previously committed external effects survive a database restore: a provider may already have accepted an email, a checkout may have charged, a webhook may have been delivered, or a refresh token may have rotated. Reconcile those facts with provider evidence before allowing replay. Restoring an old pending row is not authority to resend or recharge. Roll back an image only when its schema and immutable-writer behavior are compatible; otherwise use a reviewed forward correction. No restore rehearsal was performed on the current Stage backup, and no production recovery or recovery-time guarantee is claimed.

## 8. Incidents, logs and business audit

Diagnostic logs use standard Python logging with an allowlisted event/field boundary: UTC timestamp, severity, safe event, UUID request/execution/entity/actor IDs, registered route template, method, status, duration and terminal outcome. Exception text and unknown fields are redacted. Uvicorn/SQLAlchemy/HTTPX/Authlib/WeasyPrint noisy raw handlers are suppressed. A logging failure cannot alter an already committed business result. Sources: `app/logging.py:10`, `app/logging.py:32`, `app/logging.py:61`, `app/logging.py:81`, `app/logging.py:104`.

Never copy tokens, cookies, query strings, authorization headers, credentials, names, email addresses, correspondence, bank/tax data, line descriptions, contracts or PDF bytes into diagnostic output or incident tickets. Business audit is a separate database record tied to actor, entity, event and request ID in the business transaction; it is not a reason to log payloads externally. Source: `app/audit.py:8`; redaction tests `tests/unit/test_logging.py` and affected integration suites.

| Symptom | Bounded response |
| --- | --- |
| Cold-start/rollout 503 | Preserve status/timing and request identifier; check actual rollout/application/instance/image and readiness. Wait for convergence before declaring a persistent defect. Do not infer provider-auth failure from a generic page. |
| Ready fails or schema mismatch | Fail closed. Compare all selected schema heads, expected role/schema, guard definitions, prepared inventory and grants. Do not bypass startup validation. |
| OAuth callback generic error | Trace the sanitized reason and exact callback/recovery path. Require fresh normal provider proof; never copy cookies or infer a specific cause solely from text. |
| Email or Paddle request times out after claim | Retain uncertain state; reconcile exact provider evidence. Do not press retry or recreate the effect blindly. |
| Partial DDL/deploy | Stop, retain journal/backups/old and new image pins; inspect actual committed state before bounded continuation. |
| Local filesystem/resource fault | Preserve logs and failed receipts; isolate test PGDATA outside sync storage, verify free resources and serialize heavy work. Do not kill unrelated user processes or change OneDrive without authority. |
| Corrupt/NUL source file | Preserve original bytes/hash privately, restore only the owned intended file, verify AST/bytes/source hashes and rerun affected gates. Do not assign an unproven cause. |

The release retained interrupted operation-key/UTC runs, the first browser 30 PASS/2 FAIL, the restored NUL test, an initially denied local helper rehearsal and transient rollout 503 without giving them PASS credit. Current corrected gates do not erase those outcomes. Source: `docs/STATUS.md:107`.

## 9. Future production release — HOC-gated checklist

This list describes prerequisites, not approval. Production remains unchanged at this handoff.

- Obtain explicit production scope covering the target source, origin/resources, migration, provider changes, public registration, intended real effects and cutover/recovery authority. A Stage approval or engineering pause/resume is not production authority.
- Reconcile the original production workspace, existing owner/provider subjects and historical Google-only login before generic admission. Never assign the retained owner a new empty workspace or merge another tester into it. Complete the existing-owner bootstrap and fresh normal identity proof gates. Source: `docs/DEPLOYMENT.md:50`, `docs/DECISIONS.md:861`.
- Independently inventory and back up production retained/prepared/allocated schemas. Rehearse migration/restore using compatible images and exact restricted roles. Do not use Stage project, credentials, consent receipts or slot descriptors. Source: `docs/OPERATIONS.md:60`, `docs/OPERATIONS.md:104`.
- Verify production origin/TLS/trusted proxy policy, no development login, fixed registry/provider identities, CSRF/CAPTCHA/rate controls, pool capacity and all startup/grant/reciprocal-denial checks. Reconcile old production data against the migration chain before selecting any writer.
- Complete merchant/legal/privacy and customer-processing review. Paddle Live requires a separate merchant setup, mode-safe history, Live flag, keys, catalog, webhook verification and authorized real lifecycle checks. Sandbox success is not Live readiness. Source: `docs/OPERATIONS.md:226`.
- Decide each email channel separately: managed auth SMTP, public contact, business Sending, inbound capture. Verify domain/config/readiness without exposing secrets. Production statement Sending has its own enablement; commercial Quoting/Library remains production-disabled until separately changed and reviewed. Jobs stay off until explicitly authorized. Source: `app/config.py:202`, `app/config.py:206`, `docs/OPERATIONS.md:238`.
- Run current source-bound quality gates and reviewed build/deploy/readback procedure. Prove actual convergence and health separately from authenticated owner UAT, real recipient effects and product acceptance. Obtain the specific human proof rather than manufacturing a test session.
- Retain a compatible rollback/forward-repair plan, encrypted custody, operator escalation and uncertainty reconciliation. State remaining limits and obtain the actual HOC release decision before cutover.

## 10. Evidence index for the handoff

The canonical public-source account is `docs/STATUS.md:3`, `HOSTING.md:9`, `deploy/cloudflare/STAGE_RELEASE.md:1` and `docs/OPERATIONS.md:71`. Private task evidence remains in `.aekr/work/quoting-library-20261016/` and protected backup custody; it is intentionally not copied into this Desktop dossier.

| Reviewed evidence | SHA-256 or identity |
| --- | --- |
| Input pin JSON | `661d0942340383c7fe0c5ad18df738d1bdadad4138ad4f53a0f073626eabe886` |
| Backup receipt | `6019aa0aef9aebd44cfff744f15ddb092665effaa4bfed22bedadace313e75eb` |
| Migration receipt | `e38d488f09ffb577cddd00b84ba12ea59a265b26c89a84a37d02359b137132a9` |
| Consolidated backend receipt | `d2d0b3a6b983e2215e8023ce78b20b862f5f2cd8ac92b783a2d604d4da1f12e3` |
| Release readback helper | `9bb7913f3da3660cfc97e3d61d68014e6261b88f580b8adcc6627662bad10e40` |
| Final release readback receipt | `07778d041b22470ab950979e63d7a9198b3bc768e4ed289856614cb71c5d6787` |

These hashes are provenance checks, not authorization tokens or a promise that an unexamined future file is safe. On resume, verify the exact current artifacts and source before drawing operational credit from them.

**Handoff boundary:** technical Stage delivery is complete at the stated snapshot. Human owner sign-in and product review, actual addressed commercial sends, signatures, Live payments, production deployment and global acceptance are not claimed. No runtime, database, network, provider, credential or real business-data operation was performed to prepare this chapter.
