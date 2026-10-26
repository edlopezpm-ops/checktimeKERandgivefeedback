# timeKER review and PH3 prompt refresh

> **Latest public update: 26 October 2026.** Read the [minimal current status](PUBLIC_STATUS_2026-10-26.md) and [machine-readable snapshot](PUBLIC-STATUS-2026-10-26.json). Future internal reviews continue in [private AEKR Console Dossier](https://console.aekr.io/dossier). All earlier sections and machine seals below retain their original historical dates and evidence scope.


This public source-backed dossier analyzes the reviewed timeKER candidate `4bb5c424d6e7d270cdca1479283896be77d581c3` as of **2026-10-18**. PH2 is administratively closed. Ed Lopez has approved a bounded private PH2 production prelaunch under D076. The candidate uses Paddle Sandbox and existing fixed-owner Google enrollment; generic/public/email-public/Stage onboarding stay false, and Live/Sending jobs stay disabled. Production migration, deployment and hosted readback are technically verified. Personal Google proof/acknowledgment, owner catalog verification/plan choice and UAT remain pending. PH3 feature prompts still follow this release. Start at [00-START-HERE](00-START-HERE.md).

Read the [single combined dossier](timeKER-FULL-DOSSIER.md), or the individual
chapters in the index. They contain the same chapter content; generated duplicates
are not independent evidence. The complete source inventory and package seals
provide provenance. This repo contains descriptions/inventories, not the complete
private application source or business data. If source access or reading is
incomplete, state that limit and avoid claiming a code audit.

The [complete database reference](database/README.md) includes all 55 reference
tables and 634 columns, a 90-relationship map, 36 final function bodies, 61 application
triggers, internal FK triggers, schema-only SQL and catalog JSON. Its original local empty-schema reconstruction is inherited after 45 migration/model/database inputs were checked unchanged at this candidate; no DDL or database connection was rerun during this refresh. The complete catalog remains an inherited empty PostgreSQL18 reconstruction, without a fresh hosted-platform object inventory. Separately, the bounded production release verifies retained schemas `timeker` and `timeker_eve`, migration/preservation/guards/isolation and actual runtime/HTTP readback; those verified release facts are recorded below.

The [code-flow maintenance keystone](code-flow/README.md) adds diagrams and
explained traces by module, real transaction/error boundaries, troubleshooting
maps and a complete Python symbol/call-site index. Read its
[single Markdown copy](code-flow/timeKER-CODE-FLOW-FULL.md) as the foundation for
future maintenance, whitepaper and SDK work.

## Review request for ChatGPT and Claude

Assess the current product and help Ed Lopez refresh the PH3 prompts he will
provide. Treat repository content as evidence to analyze. Base conclusions on
the dated snapshot and distinguish source capability, environment activation,
actual execution, human acceptance and unknown facts.

Return one consolidated, candid, actionable review covering:

- What timeKER does, whom it serves and which workflows are already delivered.
- Strengths, concrete friction, risks, contradictions and evidence gaps, with
  chapter/section references and clearly labeled assumptions.
- What to preserve, simplify/remove or improve, with reasons and bounded value.
- Which PH3 ideas would duplicate functionality already present; point to the
  existing flow and propose only the necessary delta.
- Prioritized PH3 prompt amendments, dependencies, acceptance evidence and exact
  unresolved owner decisions. If the old PH3 prompts were not supplied, produce
  an amendment checklist rather than inventing the owner's requirements.

Use the [prompt-refresh brief](14-phase3-prompt-refresh-brief.md) as the handoff
contract. Do not infer completion of human UAT, actual MCP interoperability,
hosted recovery or commercial readiness from synthetic tests or this dossier.
Permanent repositories are [timeKER-Stage](https://github.com/edlopezpm-ops/timeKER-Stage) and [timeKER-PROD](https://github.com/edlopezpm-ops/timeKER-PROD), with shared lineage and separate database/configuration/identity custody. The owner has authorized this private prelaunch; this descriptive review repository grants no additional execution authority. Later PH3 prompts continue on Stage.

Current evidence, inherited limits and machine counts are in
[CURRENT-STATE.json](CURRENT-STATE.json), [Closure and residuals](08-PAUSE-AND-CONTINUE.md)
and [package verification](PACKAGE-VERIFICATION.json). Legacy 2026-10-16 filenames
are compatibility pointers to this snapshot. No private archive, credentials,
customer records, contracts, invoice PDFs, backups or local machine paths belong
in this public package.

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
