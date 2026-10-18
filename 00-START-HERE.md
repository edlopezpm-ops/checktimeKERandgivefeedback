# timeKER — current codebase dossier and PH3 prompt handoff

Snapshot **2026-10-18**. PH2 is administratively closed; the independent PH3 source
checkout is prepared and awaits Ed Lopez's feature prompts. Existing Stage
continues. One later production candidate must include PH2 plus PH3.

This is a descriptive public review snapshot. Canonical contracts remain in the
application repository. No implementation, provider activation, data mutation,
human acceptance or production authority follows from this package.

## Exact provenance

| Item | Current snapshot |
| --- | --- |
| Analyzed source | `edlopezpm-ops/timeker-PH2`, branch `codex/ph3-stage`, commit `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` |
| Frozen PH2 baseline | `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6`, tag `ph2-closeout-2026-10-18` |
| PH3 startup delta | Three entry/continuation Markdown files; all 500 other tracked files match PH2 byte for byte |
| Last verified Stage source | `e282985ea74e89e1665351c22f91706498495e93`, Stage 29; release readback 2026-10-18T03:42:14.067017+00:00 |
| Last verified schema | `ph3_009_read_indexes`, nine actual runtime schemas; five quarantines retained |
| Stage URL | https://stage-timeker.aekr.io |
| Original production source | `edlopezpm-ops/timeKER`, main `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609`, clean and unchanged by this session |
| Production URL | https://timeker.aekr.io |
| Inventory | 503 tracked paths; 291 Python files; 180 literal route decorators; 54 mapped class/table declarations; 48 Settings fields; 90 Jinja templates; 1089 declared test functions |
| Generation | Offline AST/TOML/JSON/Git and maintained source/documentation; no application imports or product tests |

Source pointers are pinned to the analyzed commit and actual one-based lines.
Private source links can require repository access; the narrative and complete
inventories here support documentation review without pretending code access.
Runtime facts are retained dated receipts, not live continuous monitoring.

## Read the dossier

Use [timeKER-FULL-DOSSIER.md](timeKER-FULL-DOSSIER.md) for one continuous reading
copy, or the chapters below. The dated 2026-10-18 combined copy has identical bytes.

| Chapter | Content |
| --- | --- |
| [Architecture and stack](01-architecture-and-stack.md) | Monolith, edge/container/database topology, workers, read paths and public-file caching. |
| [Data model and transactions](02-data-model-and-transactions.md) | Owner/schema boundaries, exact minutes/money, immutable artifacts and transaction protocols. |
| [Product and workflows](03-product-and-user-workflows.md) | Current complete navigation/business flows, lifecycle, pagination, native choices and cache refresh. |
| [Authentication and admission](04-authentication-registration-and-access.md) | Existing/new owners, immutable proof, linking, finite slots, session/CSRF/CAPTCHA and actual gaps. |
| [Integrations and effects](05-integrations-and-external-effects.md) | MCP/scopes, imports, token lifecycle, separate delivery channels, Sandbox and jobs. |
| [Deployment and operations](06-deployment-and-operations-sop.md) | Current retained Stage 29/schema 009, safe SOP, custody, recovery and one future combined PROD candidate. |
| [Security, privacy and evidence](07-security-privacy-quality-and-evidence.md) | Controls, exact source-bound test/release attribution, historical failures and unverified acceptance. |
| [PH2 closure and PH3 continuation](08-PAUSE-AND-CONTINUE.md) | Current continuation; administrative closure and all transferred P2/EXT residuals. |
| [Improvement review](09-improvement-review-guide-and-open-decisions.md) | Current delivered baseline, remaining decisions and bounded review priorities. |
| [Routes and templates](10-http-routes-and-templates.md) | Complete offline literal route-decorator and Jinja inventories. |
| [Models/configuration/dependencies](11-models-configuration-and-dependencies.md) | Complete mapped-class/field, Settings, migration and lockfile appendices. |
| [Source/test manifest](12-source-map-tests-and-manifest.md) | Every tracked source path with raw-byte hash and complete static test/module catalogs. |
| [Production/Stage differences](13-production-stage-differences.md) | Exact source-tree comparison and dated environment differences; original production untouched. |
| [PH3 prompt-refresh brief](14-phase3-prompt-refresh-brief.md) | Instructions and acceptance boundaries for revising the owner-supplied PH3 prompts. |

## Current delivery truth

Original D052–D058 feature modules exist. Remaining P2-01 actual MCP/two-owner/
token lifecycle, P2-02 human Stage UAT and P2-03 operational/recovery decisions
are explicitly transferred. Later Apple/offboarding, actual Sandbox lifecycle,
commercial owner UAT, Sending selection and future PROD gates remain separate.
Stage follow-ups include work-record/client lifecycle, consistent pagination and
status, stable visible Project IDs, weekly Timecards summaries, Dashboard
fixed-five details/rhythm, K navigation, measured read-path performance, native
reference choices and Settings public-file refresh. Review these existing flows
before proposing them as new PH3 work.

Retained full base source 3e1d564 passed 2,153 backend/296 browser cases; final
Settings source e282985 passed 8 backend/4 browser focused cases and 7 static checks.
These source-bound denominators are not added as one unique-feature count.
Stage 29 readback passed 31 anonymous GETs/15 matching source assets. Separate schema 009
proof retained 486 business-table fingerprints across nine schemas. Human UAT,
hosted restore, actual external MCP and paid-PROD readiness remain unestablished.

Administrative closure verified 28 archive batches/8,149files with raw hashes and
inverse maps, recoverable Quoting checkout custody, independent PH3 Git storage
and 500 unchanged tracked raw-file hashes. The generic scaffold validator still
rejects unchanged mandatory product AGENTS; the Project Map passed. Local
custody is not off-host recovery. Current tests/migrations/contracts remain active.

## Integrity and limitations

[source-snapshot-manifest.json](source-snapshot-manifest.json) pins all source
paths/raw bytes/hashes and Git blob IDs. [PACKAGE-MANIFEST.json](PACKAGE-MANIFEST.json)
and [SHA256SUMS.txt](SHA256SUMS.txt) bind current review-package files.
[PACKAGE-VERIFICATION.json](PACKAGE-VERIFICATION.json) records actual offline
checks and limitations. Package integrity is not product correctness, security
certification, UAT, deployment or recovery proof.

No private archives, business records, actual uploaded contracts, environment
credentials, session tokens, invoice PDFs, backup/key material or machine-local
paths are published. Historical dated entry names are small compatibility pointers;
the previous dossier remains recoverable in this repository's Git history.
