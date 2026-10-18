# 09 — PH3 prompt preparation and open decisions

Snapshot: **2026-10-18**, source `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64`. PH2 bookkeeping is closed, PH3 is prepared, and the owner will provide feature prompts. Use this chapter to review the product and formulate bounded work. It starts no implementation and creates no competing specification. Read [canonical CONTINUE][continue] and the [exact queue](08-PAUSE-AND-CONTINUE.md).

## 1. Keep four evidence questions separate

1. **Capability:** Which service, route, model, migration and maintained test implements the behavior?
2. **Activation:** Is it configured in the selected environment? Source defaults/packages do not establish runtime state.
3. **Execution:** Did the actual actor/client/provider flow run, or a local/synthetic selection? Retain target, source, date, role and result.
4. **Acceptance:** Has the owner accepted the behavior or approved the specific release? Tests/readback and administrative closeout do not supply this decision.

A single completion percentage cannot answer all four. Outcome, delivery, product and gate/authority remain distinct. PH2 closure transfers P2-01/P2-02/P2-03 and EXT-01 through EXT-05 explicitly. Source: [STATUS][status].

## 2. Inspect delivered work before proposing replacements

| Area | Existing behavior to reuse | Review question |
| --- | --- | --- |
| Navigation | Branded server-rendered pages, wordmark K/chevrons, icon-only Back, enhanced/native destinations | Which concrete journey loses context? Preserve keyboard/no-JS accessibility. |
| Records/search | Owner-scoped search/lookups, stable references, mass editing, Settings page size and independent card paging | What reproducible missing-result/state defect remains? Avoid rebuilding delivered search/paging. |
| Dashboard | Complete aggregates, independent detail/rhythm state, fixed-five Outstanding paging and selective detail preparation | Are totals, period meaning and native/HTMX transitions understandable? |
| Timecards | Integer minutes, contract weeks, retained correction/history and owner-wide selected-week metrics | Which week/filter/save/finalize case fails expectations? Preserve cohort semantics and IDs. |
| Performance | Grouped exact payment totals, batched metadata, blocking reads/readiness in workers, three indexes and versioned public assets | Does matched measurement identify a remaining bottleneck? Preserve freshness and tenant authority. |
| Public-file refresh | Settings reloads 22 known public files with bounded concurrency/timeouts and unsaved-state preservation | Is progress/retry clear? It does not clear all browser/CDN caches or replace running scripts. |
| Identity | Immutable issuer/subject, explicit linking, prepared slots, acknowledgment/first plan and shared challenge/notice | Do normal existing/new owners reach the correct private workspace? Human proof remains required. |
| Assistant/import | Idempotent reviewed Draft import, scoped OAuth/PKCE/API/MCP and connection guidance | Can the actual host discover/use tools for two isolated owners and honor rotation/revocation? |
| Commercial | Case-bound Quoting/HLE, private Library/templates/uploads/publications and independent Sending | Can the owner complete synthetic creation/edit/upload/publication/review without undocumented prerequisites? |
| Subscriptions | Individual Free/Solo/Pro capacity and durable Paddle Sandbox lifecycle/receipts | Which remaining real-provider scenarios need evidence before Live is considered? |
| Money/delivery | Exact-minute/Decimal totals, immutable issuance/full cancellation memos, manual payments, Sending/Stop/retry | Are uncertainty, confirmation and manual/scheduled effects clear? Preserve no-blind-replay behavior. |

Sources: [commercial contract][commercial], [work records][work], [dense workspace decisions][dense], [weekly metrics][weekly], [performance decisions][performance], [measured results][measure].

The base cohort and Settings spot check serve different purposes. Retained medians do not prove field Core Web Vitals, capacity, individual-change causation or human acceptance. Do not duplicate delivered optimizations without identifying a remaining defect.

## 3. Existing required proof and decisions

| ID | Current gap | Suitable bounded result |
| --- | --- | --- |
| P2-01 | Actual assistant OAuth/tool discovery, reciprocal isolation, idempotent Draft correction and token lifecycle | Real-client receipts for two fictional owners, exact supported surface and refresh/revocation outcomes |
| P2-02 | Human Stage UAT for identity and business workflows | Owner walkthrough with explicit accept/reject and reproducible defects |
| P2-03 | Selected backup/key/off-host custody, restore, retention/holds, budgets and recovery objectives | Owner-adopted operating contract and separately authorized proof |
| EXT-01 | Apple and complete lifecycle/offboarding | Approved identity/data lifecycle contract before adapters, notifications/revocation or deletion writers |
| EXT-02 | Actual Sandbox annual/3DS/change/cancellation/retention/failed-renewal/grace rehearsal | Provider/tenant/cycle/signed-event evidence; Live activation separate |
| EXT-03 | Hosted Quoting/Library/commercial Sending UAT | Normal authenticated synthetic creation/edit/upload/publication/review |
| EXT-04 | Sending operating selection | Decision on manual/jobs/recipient scope and bounded authorized rehearsal; jobs off |
| EXT-05 | Combined PH2 plus PH3 production candidate | Current diff, owner/bootstrap/override reconciliation, required QA/UAT and release authority |

Source: [canonical residuals][residuals]. Latest navigation/performance/Settings acceptance and actual Case-cron execution remain explicit limits. Configured cron is not observed execution; a synthetic Pro grant is not a paid-provider event.

## 4. Review dimensions

| Dimension | Questions and evidence |
| --- | --- |
| Product/domain | What observed need is unmet? Reuse the owning service/caller. Preserve ownership, HLE without mandatory SOW/SLA, immutable issuance, integer minutes and Decimal totals. |
| Concurrency | Which locks/idempotency/guards protect the transition? Verify races/negative paths with actual restricted roles and unchanged foreign data. |
| Capacity | What admitted-owner/concurrency/storage/mail workload is funded? Measure the selected host/request mix; fifty local schemas do not prove hosted capacity. |
| Documents | Keep original attachment, edited text, template and numbered publication distinct; preserve ownership, bounded parsing and prior hashes. |
| Privacy/lifecycle | Which export/deletion/offboarding/retention/hold promises are adopted, by whom and for which purpose/provider? Preserve financial history and unknown legal/controller facts. |
| Diagnostics/security | Prefer safe typed reasons; keep audit separate. Do not add raw exceptions, payload telemetry or enumeration detail. |
| Recovery | Define key/backup/off-host/cutover custody and required hosted RPO/RTO/provider reconciliation. Archive/decrypt/TOC checks are insufficient. |
| Accessibility | Identify keyboard/no-JS/reduced-motion/physical-device/assistive-technology evidence; attribute automated and human observations separately. |
| Delivery | Include later Stage changes, compatible writers/schema/history, actual overrides and exact authority. |

Retain one deployable app and one PostgreSQL database per environment. Reuse approved capabilities. New dependencies, Redis/Celery, SPA or microservice split require demonstrated need and a canonical decision. Preserve mandatory durability, authorization, financial/provider and acceptance boundaries. Sources: [stack/boundaries][agents], [operating limits][operations].

## 5. Decisions a prompt must not invent

Unknown tax/legal identifiers, contract clauses, bank facts, exchange rates, controller/retention obligations, merchant eligibility, backup objectives and actual client facts stay pending until an approved source is supplied. Template wording is not an adopted agreement; Quoting does not imply signature/purchase/charge. Scheduled Sending, public plugin distribution, teams/shared owners, tenant switching, mailbox synchronization and arbitrary assistant financial writers are not missing original PH2 modules.

Apple is design-only. Actual ChatGPT/Claude host behavior, voice/dot support and distribution cannot be inferred from a package. Authentication SMTP remains separate from Sending. Fresh normal owner identity proof remains required; existing sessions do not supply UAT. Sources: [brief][brief], [remaining scope][extensions].

## 6. Shape of the next prompt

Specify the journey and before/after behavior; bounded scope/exclusions; canonical sources and reused capability; unresolved decisions; actor/tenant/provider/effect limits; deterministic acceptance; disposable/negative tests; evidence attribution; and compatible repair boundary. Identify required human proof and authorized external effects. Preserve unrelated pending rows.

A useful review request identifies one selected journey, a reproducible issue, its authorized environment and acceptance evidence, then asks for the smallest coherent correction at the existing boundary. It preserves provider/legal/production/destructive-action authority. This prepares a prompt; it does not authorize execution.

The owner selects the next journey, actual assistant host/device scope, lifecycle promises, funded operating targets and final acceptance evidence. Await that PH3 prompt. Sources: [CONTINUE][continue], [D075 closure][closure].

## 7. Source and custody

This analysis follows PH2 consolidation and three PH3 startup-document changes. Tests/migrations/contracts/design references remain active. Superseded operators/test output have local recoverable custody: 28 batches/8,149 files, outside this public package. It does not supply off-host recovery. Independent PH3 bytes/object/link/map checks passed; generic root-AGENTS scaffold compatibility remains an explicit concern. Sources: [custody][custody], [verification limits][verification].

Approved behavior changes belong in canonical source documents when the owner provides the next scope.

[continue]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/CONTINUE.md#L1
[status]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L7
[commercial]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L945
[work]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L983
[dense]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L1011
[weekly]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L1036
[performance]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L1060
[measure]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PERFORMANCE_IMPROVEMENTS_2026-10-17.md#L1
[residuals]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L27
[agents]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/AGENTS.md#L49
[operations]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/OPERATIONS.md#L711
[brief]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PROJECT_BRIEF.md#L1
[extensions]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L39
[closure]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/DECISIONS.md#L1079
[custody]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L49
[verification]: https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L77
