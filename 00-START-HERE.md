# timeKER — current codebase dossier and PH3 prompt handoff

> **Latest public update: 26 October 2026.** Read the [minimal current status](PUBLIC_STATUS_2026-10-26.md) and [machine-readable snapshot](PUBLIC-STATUS-2026-10-26.json). Future internal reviews continue in [private AEKR Console Dossier](https://console.aekr.io/dossier). All earlier sections and machine seals below retain their original historical dates and evidence scope.


Snapshot **2026-10-18**, candidate `4bb5c424d6e7d270cdca1479283896be77d581c3`. Ed Lopez has approved a bounded private PH2 production prelaunch under D076. The candidate uses Paddle Sandbox and existing fixed-owner Google enrollment; generic/public/email-public/Stage onboarding stay false, and Live/Sending jobs stay disabled. Production migration, deployment and hosted readback are technically verified. Personal Google proof/acknowledgment, owner catalog verification/plan choice and UAT remain pending. PH3 feature prompts still follow this release.

This is a descriptive public review snapshot. Canonical contracts remain in the
application repository. No implementation, provider activation, data mutation,
human acceptance or production authority follows from this package.

## Exact provenance

| Item | Current snapshot |
| --- | --- |
| Analyzed source | `edlopezpm-ops/timeKER-Stage`, branch `main`, commit `4bb5c424d6e7d270cdca1479283896be77d581c3` |
| Frozen PH2 baseline | `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6`, tag `ph2-closeout-2026-10-18` |
| Candidate lineage | Includes frozen PH2, the bounded private prelaunch changes and original PROD main/retained draft ancestry; preserves the reviewed current tree |
| Last verified Stage source | `e282985ea74e89e1665351c22f91706498495e93`, Stage 29; release readback 2026-10-18T03:42:14.067017+00:00 |
| Last verified schema | `ph3_009_read_indexes`, nine actual runtime schemas; five quarantines retained |
| Stage URL | https://stage-timeker.aekr.io |
| Retained original production baseline | `edlopezpm-ops/timeKER-PROD`, historical main `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609`; retained in candidate ancestry. New private production deployment technically verified |
| Production URL | https://timeker.aekr.io |
| Inventory | 506 tracked paths; 294 Python files; 180 literal route decorators; 54 mapped class/table declarations; 49 Settings fields; 90 Jinja templates; 1118 declared test functions |
| Generation | Fresh offline AST/TOML/JSON/Git inventories. Database structure inherits the original empty PostgreSQL18.4 reconstruction after 45 structural inputs were checked unchanged; no new DDL/database/product-test execution |

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
| [Deployment and operations](06-deployment-and-operations-sop.md) | Current retained Stage 29/schema 009, safe SOP, custody, recovery and authorized private prelaunch with technical execution verified and personal acceptance still pending. |
| [Security, privacy and evidence](07-security-privacy-quality-and-evidence.md) | Controls, exact source-bound test/release attribution, historical failures and unverified acceptance. |
| [PH2 closure and PH3 continuation](08-PAUSE-AND-CONTINUE.md) | Current continuation; administrative closure and all transferred P2/EXT residuals. |
| [Improvement review](09-improvement-review-guide-and-open-decisions.md) | Current delivered baseline, remaining decisions and bounded review priorities. |
| [Routes and templates](10-http-routes-and-templates.md) | Complete offline literal route-decorator and Jinja inventories. |
| [Models/configuration/dependencies](11-models-configuration-and-dependencies.md) | Complete mapped-class/field, Settings, migration and lockfile appendices. |
| [Source/test manifest](12-source-map-tests-and-manifest.md) | Every tracked source path with raw-byte hash and complete static test/module catalogs. |
| [Production/Stage differences](13-production-stage-differences.md) | Exact source-tree comparison and dated environment differences; permanent repositories, exact candidate lineage and verified bounded production execution. |
| [PH3 prompt-refresh brief](14-phase3-prompt-refresh-brief.md) | Instructions and acceptance boundaries for revising the owner-supplied PH3 prompts. |
| [Complete database reference](15-database-reference.md) | All tables/columns, schemas and unknown live names, relationship map, final SQL functions/triggers, procedures inventory and native metadata/DDL exports. |
| [Code flow and maintenance](16-code-flow-and-maintenance.md) | Module flowcharts, exact function/transaction/error traces, browser flow, troubleshooting maps and complete Python AST symbol/call-site index. |

## Current delivery truth

Original D052–D058 feature modules exist. Remaining P2-01 actual MCP/two-owner/
token lifecycle, P2-02 human Stage UAT and P2-03 operational/recovery decisions
are explicitly transferred. Later Apple/offboarding, actual Sandbox lifecycle,
commercial owner UAT, Sending selection, personal prelaunch enrollment/acceptance and later public/Live gates remain separate. The bounded technical prelaunch readback is verified.
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
[PACKAGE-VERIFICATION.json](PACKAGE-VERIFICATION.json) records actual package checks, inherited local reconstruction and current limits. Package integrity is not product correctness, security
certification, UAT, deployment or recovery proof.

No private archives, business records, actual uploaded contracts, environment
credentials, session tokens, invoice PDFs, backup/key material or machine-local
paths are published. Historical dated entry names are small compatibility pointers;
the previous dossier remains recoverable in this repository's Git history.

<!-- timeker-final-release-evidence -->
## Verified private prelaunch and remaining personal actions

The bounded private PH2 production prelaunch is technically verified under D076. The deployed runtime is `5b0fb0d29f506d04e4a6af3ebd8a193089af7214`, with both retained production schemas at `ph3_009_read_indexes`. Paddle remains Sandbox; generic/public/email-public/Stage onboarding, Live and Sending jobs remain false. Existing inbound Mail capture remains enabled. Personal fresh Google proof, explicit acknowledgment, owner catalog verification/plan choice and human UAT remain pending. PH3 feature prompts still follow; no future feature prompt has been implemented.

GitGuardian remains failed for the known historical transport test fixture: its password is fake, but the fixture references an actual Stage project rather than a placeholder. The signal is retained and is not reported as a passing check. Supabase Preview is SKIPPED because this branch lacks a Supabase Branch association; this does not replace the separately verified production database/readiness evidence.

Exact runtime/image, preservation, local recovery and qualified QA evidence are in [chapter06](06-deployment-and-operations-sop.md#9-verified-private-ph2-production-prelaunch).
<!-- /timeker-final-release-evidence -->

<!-- timeker-final-repository-promotion -->
## Permanent repositories and completed promotion

Both permanent GitHub `main` branches now resolve to `4bb5c424d6e7d270cdca1479283896be77d581c3`, tree `e0dd4c64d603b3e8c551342395b9683389821f25`. The annotated baseline tag `ph2-prelaunch-2026-10-18` peels to the same checkpoint on both repositories. Promotion evidence: [PROD PR](https://github.com/edlopezpm-ops/timeKER-PROD/pull/3) (merged `2026-10-18T16:49:42Z`), [Stage PR](https://github.com/edlopezpm-ops/timeKER-Stage/pull/5) (merged `2026-10-18T16:49:56Z`). The active Stage work branch is `codex/ph3-stage`. Old Stage PRs2/3 are closed with their branches retained; no Stage PR remains open at the recorded handoff. Frozen PH2 remains `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6`.

The final documentary checkpoint keeps all244 raw runtime-file hashes identical to the tested/deployed runtime `5b0fb0d29f506d04e4a6af3ebd8a193089af7214`. Shared Git lineage does not merge production and Stage databases, provider configuration or identity custody. The permanent repositories remain [timeKER-Stage](https://github.com/edlopezpm-ops/timeKER-Stage) and [timeKER-PROD](https://github.com/edlopezpm-ops/timeKER-PROD); future feature prompts continue on Stage.
<!-- /timeker-final-repository-promotion -->
