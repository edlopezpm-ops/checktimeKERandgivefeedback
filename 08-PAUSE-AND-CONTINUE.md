# 08 — PH2 closed; PH3 prepared and awaiting owner prompts

Snapshot: **2026-10-18**, source `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64`. This stable filename is retained for dossier links; the former 2026-10-16 pause text is superseded by the later owner-authorized administrative transition. The active source entry is [CONTINUE.md:1](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/CONTINUE.md#L1). This chapter mirrors it and does not create a competing specification.

Outcome: DONE_WITH_CONCERNS

Delivery state: PH2 is consolidated/frozen at `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6`, annotated tag `ph2-closeout-2026-10-18`. The independent `timeKER PH3` checkout uses `codex/ph3-stage` and the existing `edlopezpm-ops/timeker-PH2` repository. The original production repository is a read-only baseline with push disabled in PH3.

Product state: continue using `https://stage-timeker.aekr.io`. Last verified runtime remains Stage 29/source `e282985ea74e89e1665351c22f91706498495e93`/schema `ph3_009_read_indexes`. Administrative preparation changes no running application, database, provider or environment.

Gate/authority state: Ed Lopez authorized closure/archive/consolidation/clone and will supply PH3 prompts. Await those prompts before feature implementation. Identity proof, UAT, hosted recovery, Live billing and production remain separate. One future reviewed production candidate must combine PH2 and authorized PH3. Do not merge, migrate or deploy old drafts by inference. Sources: [CONTINUE.md:3](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/CONTINUE.md#L3), [HOSTING.md:7](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L7).

## Current source and retained runtime

| Boundary | Current documented state |
| --- | --- |
| PH3 analysis checkpoint | `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` on `codex/ph3-stage` |
| Closed PH2 checkpoint | `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6` / `ph2-closeout-2026-10-18` |
| Last runtime release | Stage 29/source `e282985`; final readback `2026-10-18T03:42:14.067017+00:00` |
| Database evidence | Nine runtime schemas last verified at head 009; five quarantines unchanged |
| Human/provider limits | Actual MCP, normal identity/UAT, remaining Sandbox lifecycle and hosted recovery remain pending |
| Scheduling | Case-only daily 02:17 UTC cron configured; execution not observed; scheduled Sending off |
| Production baseline | Original main `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609`, unchanged; no fresh runtime query |
| Future production draft | [Original timeKER PR3](https://github.com/edlopezpm-ops/timeKER/pull/3), retained historical preparation requiring final PH2 plus PH3 reconciliation |

These are source/dated receipt facts, not continuous monitoring. Exact Worker/deployment/image and health metadata are in [chapter 06](06-deployment-and-operations-sop.md) and [HOSTING.md:12](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L12).

## Exact carried-forward queue

The canonical residual table is [docs/STATUS.md:27](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L27). Its requirements are retained here for prompt preparation.

| ID | Required work in a separately authorized PH3 scope | Evidence required to close |
| --- | --- | --- |
| P2-01 | Complete a real assistant/MCP connection through normal human OAuth allow; discover and invoke tools | Actual tool discovery and bounded reads with two separate fictional owners; reciprocal isolation; confirmed idempotent Draft creation/correction; refresh rotation and revocation stop access. Record actual host/client surface; do not infer dot/voice support. |
| P2-02 | Owner functional UAT on Stage with existing and newly admitted accounts | Sign-in/signup/provider linking and recovery; correct private workspace; import preview/commit/replay/correction; clients/proposals/Cases/timecards; invoice/credit/payment/report/history behavior. Use synthetic business data and fresh normal identity proof. Record defects and accept/reject explicitly. |
| P2-03 | Resolve operational closure decisions and verify the selected approach | Backup cadence, off-host custody and key custody, tenant restore/runbook, retention/rights/holds, actual hosting/pool/storage/mail budget and selected recovery objectives. Existing local capacity/restore proofs and backup checks do not supply hosted RPO/RTO. |

No additional unimplemented module was identified within the documented original
D052–D058 feature contract. This is not 100% product acceptance: P2-01 and P2-02
have not been executed end to end. Commercial/operational decisions remain distinct.

## Subsequent scope carried into PH3

| ID | Scope | Current gap |
| --- | --- | --- |
| EXT-01 | Apple/account lifecycle | Design only. Developer eligibility/configuration, provider adapter/callback/correlation, relay, revoke/notifications, complete account deletion/offboarding and actual provider/browser tests remain unimplemented/unverified. |
| EXT-02 | Phase3 subscription provider rehearsal | First Solo monthly Sandbox purchase passed historically. Annual/3DS, confirmed plan changes, retention/cancellation and failed-renewal/grace still need bounded real-provider rehearsal. Live merchant setup/activation remains separate and deferred. |
| EXT-03 | Quoting/Library/commercial Sending owner UAT | Source/local tests and public Stage readback passed. Authenticated owner creation/edit/upload/publication/review flows on hosted Stage remain to be exercised. No real client contract was uploaded or customer message sent during this increment. |
| EXT-04 | Sending operational selection | Manual review/confirmation framework exists. Scheduled statement jobs remain off. Decide/authorize any future job activation and exact addressed test separately; uncertain acceptance is never replayed. |
| EXT-05 | Future PROD candidate and full rollout | Reconcile current production runtime overrides, verified immutable owner bootstrap, migration/grants/inventory/providers, environment-specific capabilities and accepted data/custody contracts. Prepare a current reviewable candidate only after HOC authorizes that work. Older production draft packages do not automatically include later Stage improvements. |


Additional retained limits: human acceptance of the latest navigation/performance/
Settings changes remains open. The Case-only 02:17 UTC cron is configured, but an
actual scheduled execution has not been observed. Sending jobs remain disabled.
Live merchant/catalog/credentials/webhooks, general-admission/offboarding and
current production overrides need their own later review. The synthetic Stage
Pro grant is not a paid-provider event and must not be copied into production.

Source: [docs/STATUS.md:27](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L27). These rows are not one implementation sprint. A selected PH3 prompt supplies scope/acceptance; authorization for one row does not activate the others.

## What is already delivered

Preserve original PH2 credit memos, strict reviewed Draft imports/contributions/corrections, proposed clients, scoped OAuth/API/MCP services and Settings connection guidance. Later Stage source includes individual enrollment/Sandbox subscriptions; Google/GitHub/managed-email admission/linking; shared challenge/versioned sign-in notice; reviewed Sending; Case-bound Quoting/private Library; work-record/lifecycle/search/pagination refinements; Dashboard detail/rhythm behavior; owner-wide weekly Timecards summaries; K/Back navigation; native reference choices; measured read optimizations; and Settings public-file refresh. Apple runtime/offboarding and the acceptance rows above remain separate. Sources: [docs/PROJECT_BRIEF.md:1](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PROJECT_BRIEF.md#L1), [docs/DECISIONS.md:945](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L945), [docs/DECISIONS.md:983](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L983), [docs/DECISIONS.md:1060](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L1060).

No additional unimplemented module was identified in original D052–D058. Administrative closure transfers unresolved proof and decisions; it does not convert them into completed acceptance or erase failures.

## Archive and clone custody

Reversible local archive covers 28 batches/8,149 files/1,580,224,720 bytes, plus the separate native Quoting move. Current tests, migrations, contracts, design references and operative decisions remain active. Prior payload is not included in this public dossier or PH3 clone. Independent preparation proved all 500 nonstartup tracked files unchanged, independent Git storage and no old runtime/private environment copied. The generic root-AGENTS scaffold-validator incompatibility remains documented; Project Map validation passed. Source: [docs/PHASE2_CLOSEOUT.md:49](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L49).

## Entry procedure for the next PH3 prompt

1. Read canonical CONTINUE, AGENTS, STATUS, PH2_CLOSEOUT, HOSTING, operative decisions/design/contracts and applicable private governance. Historical payload stays outside ordinary context.
2. Record the owner's bounded prompt, exclusions and acceptance evidence. Missing business/legal/provider decisions remain unknown until supplied.
3. Verify current branch/HEAD/dirty state and relevant actual environment only within that scope. Preserve unrelated work and failed receipts.
4. Reuse delivered services/tests/migrations and retained evidence. Do not replay old seeds/imports, migrations, purchases, sends or release carriers.
5. Keep normal login/MFA/OTP/provider consent and UAT with the owner. Never read mailbox proof, copy sessions or synthesize acceptance.
6. Execute/verify only the selected PH3 scope and update canonical continuity. Keep a later PROD candidate, merge, migration/configuration and deployment separately authorized.

Source: [CONTINUE.md:20](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/CONTINUE.md#L20). No timer, tool availability, pending PR or saved package begins feature work. The next task is the owner's PH3 prompt.
