# timeKER — full codebase dossier and HOC pause

Prepared for Ed Lopez on 2026-10-16. Language: English, following the project's
source/documentation convention. This package supports a deep technical/product
review of the whole codebase and its operating model. It is a dated analysis
snapshot, not a competing active specification, source/data backup or permission
to execute the included operational commands.

**Stage improvement work is PAUSED until direct HOC resume. PROD remains as is.**
The current services/configuration/data are retained; no runtime shutdown or flag
change is part of the pause. Only documentation and verification of this package
were performed for this closeout. No database, provider, authentication, customer
send, payment, migration or deployment was executed to prepare it.

## Read this package

For one continuous Markdown document, open [timeKER-FULL-DOSSIER.md](timeKER-FULL-DOSSIER.md).
For focused review, use the chapters below. Both formats contain the same substantive
chapters; the combined file is generated from these files, not independently authored.

| Chapter | Content |
| --- | --- |
| [01 — Architecture and stack](01-architecture-and-stack.md) | System context, monolith, Worker/Container/PostgreSQL topology, layers, request lifecycle, actual stack/versions and runtime boundaries. |
| [02 — Data model and transactions](02-data-model-and-transactions.md) | Entity relationships, ownership, stored/derived states, constraints/guards, transaction protocols, money/minutes/time zones, history/immutability. |
| [03 — Product and user workflows](03-product-and-user-workflows.md) | Complete page/domain catalog and ordinary/error workflows: clients, projects/Cases, timecards, imports, reports, billing, credit memos, payments, Mail/archive, settings, plans, Quoting/Library and Sending. |
| [04 — Authentication, registration and access](04-authentication-registration-and-access.md) | Google/GitHub/managed email, shared Turnstile, identity binding/linking, notices/receipts, signup/admission slots, session/CSRF/roles, failure/recovery and absent Apple/deletion. |
| [05 — Integrations and external effects](05-integrations-and-external-effects.md) | OAuth/API/MCP tools/scopes, confirmation and token lifecycle, import, separate email channels, Paddle, signed webhooks/internal jobs, retry/uncertainty/idempotency boundaries. |
| [06 — Deployment and operations SOP](06-deployment-and-operations-sop.md) | Local setup, containers, environment/secret custody, actual Stage hosting, migration/grants, deployment/readback, backup/restore, incident handling and future HOC-gated production release steps. |
| [07 — Security, privacy, quality and evidence](07-security-privacy-quality-and-evidence.md) | Implemented controls, data/encryption/file limits, diagnostic/business audit distinction, policy/preferences, executed QA and honest pending verification. |
| [08 — Pause and continue](08-PAUSE-AND-CONTINUE.md) | Owner pause, exact retained snapshot, original Phase2 closure queue, later scope, receipts and resume procedure. This mirrors the canonical repository CONTINUE at closeout. |
| [09 — Improvement review guide](09-improvement-review-guide-and-open-decisions.md) | Source-backed review questions, measured change criteria, known open work and distinctions between capability, activation, execution and acceptance. No implementation is authorized by these prompts. |
| [10 — HTTP routes and templates](10-http-routes-and-templates.md) | Offline literal route-decorator catalog and Jinja template inventory, with extraction limits. |
| [11 — Models, configuration and dependencies](11-models-configuration-and-dependencies.md) | All53 mapped entities/fields,48 Settings fields, migration chain, complete Python lock inventory and Worker package inventory; credential values omitted. |
| [12 — Source map, tests and manifest](12-source-map-tests-and-manifest.md) | Every app module, static test-file catalog,414 tracked paths with byte/hash identity. Static counts are not executed-test counts. |
| [13 — PROD/Stage differences](13-production-stage-differences.md) | Exact untouched production baseline versus Stage, dated runtime identities, feature differences, complete tracked source delta and future release implications. |

## Snapshot and provenance

| Item | Snapshot |
| --- | --- |
| Primary analyzed codebase | `C:\Users\edlop\OneDrive\Documents\VS Code\timeker-PH2` |
| Stage source-analysis commit | `48e854ff2107dffb217dfe7c487b1b9d36a7f41d` on `codex/ph3-onboarding-auth` |
| Deployed Stage application source | `dbf73e52ca03726e7903dc74ef27e40339c06936`; analysis checkpoint adds documentation only |
| Stage URL | `https://stage-timeker.aekr.io` |
| Original production repository | `C:\Users\edlop\OneDrive\Documents\VS Code\timeKER`, main `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609`, clean and unchanged |
| Production URL | `https://timeker.aekr.io` |
| Inventory method | Offline AST/TOML/JSON/Git tree reads, no application imports or live service discovery |
| Static inventory | 414 tracked paths,227 Python files,173 literal route declarations,53 mapped entities,48 Settings fields,892 declared test functions |
| Canonical source of product truth | Repository AGENTS, PROJECT_BRIEF, DECISIONS, DESIGN_SPEC, STATUS, HOSTING and relevant maintained contracts |
| Canonical pause/resume entry | `timeker-PH2/CONTINUE.md`, carried in chapter08 |

Later pause closeout edits are Markdown/continuation only. The exact baseline
manifest intentionally remains pinned to the analyzed commit rather than silently
changing source identity when the pause is committed. Source pointers refer to
that commit; some local documentation line numbers move after the pause prefix is
added. Application source references remain stable because no app code changed.

The package uses public source and maintained operator/product documents, with
selected already-recorded release metadata. Runtime identities are last verified
receipts, not fresh continuous monitoring. No source archive/private historical
payload was retrieved to generate the technical chapters. Actual uploaded client
contracts, database contents, private seeds, invoice PDFs and protected credential
values are excluded. Configuration names, public URLs, source hashes and schema
structure are included to make analysis precise.

## Current delivery truth

- The original Phase2 feature core is implemented in Stage. Real assistant/client
  OAuth allow, tool discovery/use with two owners, refresh/revocation and owner UAT
  remain open. A saved private plugin is not evidence of an authenticated connection.
- Later Stage functionality includes public signup into finite preprepared private
  workspaces, alternate sign-in, Free/Solo/Pro Sandbox subscriptions, separate
  statement Sending and Case-bound Quoting/Library/commercial Sending.
- Apple runtime/account deletion is absent. Remaining actual subscription-provider
  rehearsals, hosted commercial owner UAT, operational budgets/custody and a current
  production candidate/full rollout are separately tracked.
- Last backend gate is consolidated coverage of1,785 distinct cases, not a new
  all-green full run. The raw full run remains FAILED at1,784 PASS/one obsolete
  assertion; a complete761-unit rerun passed after the test-only correction.
  Final affected browser suite32 PASS and19 hosted public GET checks passed.
- The nine-schema Stage migration retained396 old table fingerprints and verified
  guards/grants/isolation. Its encrypted backup passed custody/inventory/hash checks;
  that operation did not perform a restore rehearsal.
- No human Stage acceptance, actual customer email, Apple activation, Live payment
  or production rollout is implied by automated checks or this package.

## Recommended reading sequence

1. Read08 for what is paused, retained and allowed to resume.
2. Read01–02 for system/data/transaction structure.
3. Read03–05 for exact product, identity and integration behavior.
4. Read06–07 for SOP, operational limits and actual assurance.
5. Use10–13 while inspecting source or comparing a proposed change.
6. Use09 to organize improvement analysis without treating open ideas as approved work.

## Verification files

- [source-snapshot-manifest.json](source-snapshot-manifest.json) pins baseline source paths/bytes/hashes and offline extraction counts.
- `PACKAGE-MANIFEST.json` and `SHA256SUMS.txt` pin the final delivered Desktop files.
- `PACKAGE-VERIFICATION.json` records actual offline package checks, limitations and final closeout source identity. These describe documentation validation, not product test execution or a security certification.

Keep all chapters together so relative links resolve. The combined MD can be read
alone for narrative/appendices, while its linked chapter files remain useful for
navigation. No ZIP, vendor upload, sharing permission or external publication is
required to use the local package.
