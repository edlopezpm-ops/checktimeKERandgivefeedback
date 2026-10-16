# Improvement review guide and open decisions

Snapshot: 2026-10-16, source-analysis commit `48e854ff2107dffb217dfe7c487b1b9d36a7f41d`.
This chapter organizes the owner's requested deep analysis. It neither implements
improvements nor authorizes work while paused. The dated dossier explains the
current product; canonical `CONTINUE.md` controls any later resume.

## 1. Scope and evidence language

Use four separate questions for every proposal:

1. **Capability:** Does source code implement the behavior? Which service, route,
   model, migration and test owns it?
2. **Activation:** Is the capability actually configured in the selected environment?
   A source default, manifest or installed package is not a provider readback.
3. **Execution:** Has the real actor/client/provider flow been exercised, or only a
   synthetic/local test? Preserve exact dates, target and result.
4. **Acceptance:** Has HOC accepted the behavior for Stage or approved the exact
   production release? Engineering evidence does not make that decision.

Do not use a single completion percentage to hide these distinctions. The original
Phase2 feature core is implemented; real MCP connection/platform validation and
owner UAT remain open. Phase3 subscriptions, later authentication/public admission,
Quoting/Library/commercial Sending and Apple have separate histories and gaps.

## 2. Review map

| Review area | Existing implementation to preserve | Questions to investigate after resume | Evidence that would justify a change |
| --- | --- | --- | --- |
| Product navigation and discovery | Branded server-rendered pages; Timecards after Projects, Quoting before Billing; contextual help | Can a new owner understand Case, Project, HLE, working document, template and publication without assistance? Are missing prerequisites recoverable from the originating screen? | Bounded recorded owner walkthrough and concrete friction, not a preference for another UI framework. |
| Authentication and admission | Fresh immutable proof, explicit linking, finite prepared schemas, one shared widget, clear recovery | Do existing/new identities reliably enter the correct workspace? Are failure messages actionable without disclosing account existence or misidentifying provider causes? | Normal provider flows with actual registered/new test identities, request IDs and no token capture. |
| Account lifecycle | Revoked identities/session revisions and retained admission records exist | What exactly does account deletion, export, cancellation, held financial history, owner offboarding and Apple revocation mean for this product? | Owner-approved bounded lifecycle contract before a new UI/writer or destructive path. |
| MCP client compatibility | Scoped OAuth/PKCE, issuer metadata, tools and private package | Does the intended actual client authenticate, discover, read two isolated owners, write confirmed Draft contributions and honor refresh/revocation? What is actually supported for voice/dot surfaces? | Real-client receipts, reciprocal denials and idempotent Draft evidence; a saved package alone is insufficient. |
| Domain boundaries | Services separate from handlers/templates; Decimal and integer minutes | Are responsibilities duplicated among direct browser actions, imports, MCP and new commercial workflows? Are unrelated state machines coupled? | A specific drift or maintenance defect with caller/transaction mapping; preserve all entry-point contracts. |
| Money/time correctness | Exact-minute aggregation, explicit zones, frozen issuance, full cancellation memos | Are date-boundary, range/mixed pricing and plan-capacity transitions understandable? Is optional zero pricing distinguished from unknown pricing? | Synthetic counterexamples and deterministic expected totals before refactoring. |
| Persistence and concurrency | Fixed-role pools, row locks, retained idempotency, guard triggers | Do concurrent operations wait or conflict predictably? Is history protected by both services and database ACL/guards? | Real restricted-role race/negative tests tied to the changed resource. |
| Database capacity | One database/environment, tenant schemas, bounded per-tenant pools | At the desired admitted-owner count, what are connection, schema, disk, archive/binary, query and backup costs? | Actual selected-host measurements; local 50-schema evidence is not a hosted promise. |
| Synchronous work | One deployable app; bounded parsing/PDF generation; no extra queue/backend | At realistic concurrency, do PDF/DOCX/MIME operations or synchronous DB paths materially delay requests? | Reproducible synthetic timings/resource traces. Do not add Redis/Celery/microservices to solve a hypothetical issue. |
| Documents and uploads | Immutable originals and numbered publications, bounded safe parsing/download | Is selecting edited text versus original attachment unambiguous? Can owners reuse their own wording without silently modifying earlier versions? | Normal UI/document download checks and unchanged artifact hashes. |
| Commercial and collection Sending | Separate models/history, durable claim-before-network, exact attachment, manual review/Stop | Are retries, uncertainty and scheduled/manual actions clear? What constitutes operator reconciliation of an uncertain provider result? | Mock fault/race tests plus separately authorized addressed rehearsal, preserving no-replay behavior. |
| Subscription lifecycle | Free/Solo/Pro entitlement/capacity and Paddle Sandbox receipts | Do annual/3DS, immediate upgrade, deferred downgrade/cancel, retention and failed-renewal/grace behave as specified on the real provider? | Exact provider/tenant/cycle readbacks and signed webhook evidence. Live eligibility is a separate HOC decision. |
| Privacy and optional processing | Public maintained policies, versioned notice receipts, signed preferences, GPC/DNT precedence, optional usage disabled | Do disclosure and data inventory match each actual provider and retention purpose? What must be separately optional? | Source/provider data-flow inventory and appropriate owner/legal review; no speculative UI warnings or blanket worldwide compliance claim. |
| Support/contact | Fixed destination, dedicated CAPTCHA action, committed abuse/idempotency reservations | Are support failures understandable without leaking message/address/IP data? Are limits appropriate for observed abuse/load? | Bounded normal/error tests; no raw mailbox/message capture in diagnostics. |
| Audit and diagnostics | Business audit in DB; finite sanitized diagnostics; request IDs | Can an operator distinguish proof, binding, routing, storage and provider failure using safe metadata? | A concrete troubleshooting gap; expand typed reason vocabulary rather than raw exception logging. |
| Recovery | Migrations/grants, encrypted backup custody, actual local restore rehearsal | What are off-host schedule, key custody, tenant restore verification, recovery objectives and restore decision authority? | A selected operational runbook and bounded rehearsal. Do not treat archive inventory or decryption alone as restore proof. |
| Delivery/source custody | Separate PROD/Stage profiles, manual guarded releases, immutable runtime identities | Does the candidate include all later Stage changes? Have old runtime overrides and original immutable owner bootstrap been reconciled? | Fresh candidate diff, required QA/review/UAT and exact HOC release decision; never merge an old package by assumption. |
| Accessibility and browser coverage | Native/no-JS behavior, CSP, keyboard/axe/mobile synthetic tests, reduced motion | Are physical-device/browser/assistive-technology flows usable where mocked tests cannot establish behavior? | Targeted user/device evidence, with automation and human observations attributed separately. |

## 3. Concrete open work versus optional ideas

The following are documented current gaps, not newly invented improvement tickets:

- Real assistant OAuth allow/tool discovery/execution with two tenants, refresh and
  revocation; intended voice/dot surface compatibility is unproven.
- Owner end-to-end Stage UAT for the selected core and later commercial screens.
- Apple entitlement/configuration, provider adapter/callback, relay, notifications,
  revocation and complete account-deletion/offboarding implementation.
- Remaining real Sandbox subscription rehearsals; Live merchant setup/activation.
- Selected off-host backup/key custody/cadence, hosted capacity budgets and recovery
  objectives/restore verification.
- A current owner-reviewed production candidate, immutable owner bootstrap and
  runtime override reconciliation before any separately authorized release.

Scheduled statement Sending is deliberately off. Inbox synchronization, broad team
membership, a tenant switcher, arbitrary AI financial mutations, full/partial tax
authority, automatic FX and public plugin distribution are not missing features
within the contracted Phase2 core. They are unselected or separately scoped ideas.

Quoting is an effort/proposal workflow, not legal signature or subscription purchase.
An HLE does not need a SOW/SLA. A commercial contract template is editable starting
wording, not an adopted real customer contract or a universally applicable legal
form. Cases are mandatory for working commercial records because they bind the
owned Project/Client context. Reusable templates alone may be unassigned.

## 4. Documentation observations from this dossier task

The source-analysis commit has older checkpoint prose in README, PROJECT_MAP,
legacy security/deployment sections and private governance. STATUS/HOSTING plus
later ADRs carry the newest runtime behavior. The pause closeout updates the
entry documents and records the current continuation; older historical receipts
remain dated and are not rewritten into new PASS results.

The appendices pin source bytes at the analysis commit, before pause-only Markdown
edits. This intentionally makes a document line reference reproducible. The
Desktop pause chapter and package verification describe the later closeout state.
No business application file, migration, dependency, runtime configuration or
production checkout is changed by producing this dossier.

## 5. Questions for the owner's deep review

1. Which first-time user journey should define the next acceptance boundary: pure
   manual tracking, assistant-assisted Draft import, consulting quoting, or paid SaaS?
2. Which actual assistant host and browser/device combinations must be supported
   before rollout, and which remain explicitly outside the first release?
3. Which account/data lifecycle promises will the service make, and who operates
   exports, retention/holds and deletion when immutable financial records exist?
4. What initial admitted-owner volume, storage/mail budget and incident/recovery
   service target will be funded and verified?
5. Which real subscription and delivery scenarios must pass before activating
   Live payments or automated follow-ups?
6. What precise product/UAT and release evidence will HOC accept for the final
   Stage-to-PROD candidate?

These are review prompts. They do not ask the owner to answer during the pause and
they do not authorize agents to start implementation. Retain the current architecture
until an evidenced requirement justifies a bounded change.
