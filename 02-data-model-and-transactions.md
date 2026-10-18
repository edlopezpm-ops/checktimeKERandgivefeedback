# 02 — Data model and transaction semantics

## Review baseline

This chapter describes declarations and service behavior at source `9fc9eeb`
in `edlopezpm-ops/timeker-PH2`, the prepared PH3 branch. PH2 is administratively
closed at tag `ph2-closeout-2026-10-18` / `39bcde0`; the retained Stage runtime
is Stage 29 / `e282985`. The expected migration head is
`ph3_009_read_indexes`. No database, real record, key or provider was queried
for this dossier refresh.

The entity catalog below is explanatory. Chapter 11 supplies the complete
declaration index; source models/migrations remain authoritative. Historical
`ph2_` and `ph3_` migration prefixes are permanent identifiers, not the current
delivery phase or instructions to rerun migrations.

Sources: [models](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eeb/app/models.py),
`app/db.py`, `docs/PHASE2_CLOSEOUT.md`, `docs/STATUS.md`.

## 1. Physical tenancy and ownership

One PostgreSQL database holds isolated private schemas and fixed runtime roles.
The server resolves a verified identity or authenticated delegated grant to a
registered tenant descriptor. Requests cannot select arbitrary schema names,
database URLs or roles. Each connection checks its actual role/schema; runtime
roles cannot create or own application objects or obtain reciprocal tenant access.

Tenant-local `User` is the active owner. Business entities generally inherit a
UUID primary key and UTC created/updated timestamps from `Entity`. Human-facing
object numbers are separate database-generated identifiers. Several parent rows
have explicit SQLAlchemy optimistic version columns; row locks and database
constraints additionally protect shared mutations.

The central admission directory records retained immutable subjects and prepared
workspace allocation. It lives in the same database, with separate directory
semantics; it is not a shared business-record pool. Admission uses an explicitly
prepared finite inventory and cross-transaction recovery states rather than
privileged runtime provisioning.

Sources: `app/models.py:47`, `app/tenancy.py`, `app/repositories.py`,
`app/admission_models.py`, `app/admission_operations.py`,
`app/workspace_operations.py`, `scripts/postgres-runtime-grants.sql`.

## 2. Entity groups and relationships

| Group | Entities and retained purpose |
| --- | --- |
| Owner/configuration | `User`, `AppSettings`, `Audit`; active identity, settings and business history |
| Client/project | `Client`, `Contact`, `ClientSourceReference`, `Project`, `ProjectAgreement` |
| Recorded work | `Timecard`, `TimeEntry`, `Case`, `CaseTimeAllocation` |
| Statements/payments | `Invoice`, `InvoiceLine`, `Reservation`, `Artifact`, `Payment`, `CreditMemo` |
| Imported/contributed time | `TimeImportRecord`, `TimeContribution`, `TimeOperation` |
| Delegated integration | `IntegrationGrant`, `IntegrationCode`, `IntegrationToken`, `IntegrationOperation`, `ClientDraft` |
| Individual subscription | `WorkspaceSubscription`, `SubscriptionOperation` |
| Provider subscription ledger | `BillingAccount`, `BillingOperation`, `BillingEvent` |
| Tenant-local enrollment | `OwnerIdentity`, `OwnerRegistration`, `EmailAuthChallenge` |
| Central admission | `WorkspaceAdmission`, `AdmissionIdentity`, `PublicEmailChallenge` |
| Statement collections | `SendingPreferences`, `SendingPlan`, `SendingDelivery`, `SendingAttempt` |
| Estimates | `Quote`, `QuoteRevision`, `QuoteLine`, `QuoteArtifact` |
| Private documents | `LibraryDocument`, `LibraryUpload`, `LibraryDocumentVersion` |
| Commercial-document outbox | `ProposalSendingDelivery`, `ProposalSendingAttempt` |
| Mail custody | `MailMessage`, `MailAddress`, `MailAttachment` |
| Support abuse admission | `ContactAttempt`; bounded reservation/digests, not support-message storage |

Relationships retain UUID associations: client → project → case; weekly card →
entry; entry ↔ case through allocated integer minutes; invoice → lines,
reservations, artifacts and payments. A case requires its real client and project.
A quotation revision is bound to its case/client/project context. Library
documents can optionally reference that context without becoming agreements.

`ClientSourceReference` retains one owner-provided URL or bounded uploaded file
per client. It provides evidence custody without automatic URL fetching or
conversion into authoritative legal/tax facts. Project agreement bytes and
published commercial/financial artifacts have separate immutable custody.

Sources: `app/models.py`, `app/*_models.py`; chapter 11 lists each concrete
model source file and declaration.

## 3. Current identity, lifecycle and work invariants

Client states are `draft`, `active`, `archived`; there is no Client Closed
state. Service validation normalizes new/edited codes to exactly four uppercase
ASCII letters. Incomplete clients can remain Draft. Activation validates the
required profile and active-plan capacity; it is not legal verification.

Project states are `draft`, `active`, `closed`, `archived`. Project types are
`time_and_materials`, `fixed_fee`, `on_call_support`, `on_demand_support_tm`
and `on_demand_support_ff`. Optional budget/currency and agreement type/reference
must form valid pairs. Human-facing Project ID is stored `object_id + 9999`,
so the first displayed value is 10000; UUID and stored identity are unchanged.

Cases have generated numbers starting at 10001, an optional retained legacy
number, explicit type and status, bounded description, owner/client/project and
lifecycle timestamps. Their statuses are Open, In progress, Waiting, Resolved,
Closed. Flexible fields are JSONB extension values validated by shared services.

Timecards store Monday service-week dates, owner, client or internal scope,
status, total integer minutes and optimistic version. Ordinary and internal
scopes have separate uniqueness/association rules. Internal work is nonbillable
and may omit a project; optional internal case links remain validated.

TimeEntry stores one project/day cell or internal day cell, integer minutes,
category, description, billable flag and optional Decimal rate override. Case
allocations reference existing entries; their aggregate cannot exceed recorded
minutes. Allocation is attribution, not additional billable time or money.

Parent close/archive transitions disclose consequences and require confirmation.
Open child projects/cases and linked nonempty Draft timecards block unsafe
transitions. Work history is retained rather than cascaded away. Reactivation
can consume active-plan capacity and must revalidate it.

Sources: `app/models.py:69`, `app/models.py:112`, `app/models.py:184`,
`app/models.py:233`, `app/record_references.py`, `app/clients.py`,
`app/forms.py`, `app/work_lifecycle.py`, `app/flexfields.py`.

## 4. Money, time and derived financial state

Money uses Python Decimal and PostgreSQL NUMERIC; financial services reject
binary floats. Billable duration is stored as integer minutes. Accepted decimal
hour input must resolve to whole minutes; H:MM is supported. A daily entry is
bounded by 24 hours, and a card by a seven-day week.

Time-based line amounts aggregate exact minutes at the applicable rate before
rounding the monetary result with decimal half-up rounding. Weekly periods run
Monday–Sunday in the configured IANA contract timezone. Browser-local decorative
time is separate from those service dates and business-day calculations.

The original verified client contract uses a combined 20-hour weekly cap, no
minimum and America/Santiago service weeks. These are contract data. No tax,
withholding, bank detail, legal identifier, exchange rate or gross-up value may
be invented. A commercial statement is not an official Chilean SII tax document.

Invoice stored states are Draft, Issued, Sent and Void. Partially Paid, Paid and
Overdue are derived from dates and unreversed payments. List/report services
batch exact payment sums for one read set; this does not become a stale Session
cache or replace current transactional checks during mutation.

Fixed-fee/manual-extra lines have zero synthetic time and rate. Their amount and
commercial metadata record an explicit project charge. A partial unique index
prevents two nonvoid base fixed-fee claims; manual extras retain a distinct
project/reference claim and explicit overbilling authorization.

Sources: `app/domain.py`, `app/billing.py:118`, `app/billing.py:150`,
`app/billing.py:475`, `app/models.py:280`, `app/models.py:341`,
`app/project_terms.py`, `docs/contracts/ALCO_CONTRACT_SOURCE_NOTES.md`.

## 5. Transaction boundaries

### Ordinary writes and concurrent work

Ordinary form mutations enter one database transaction in a framework worker.
Authorization/CSRF precede the service call. Optimistic versions detect stale
edits; required row locks serialize finalization, allocation, reservation,
issuance and payments. Numbering/capacity advisory locks apply before relevant
resource locks. Individual services preserve their documented lock order.

Weekly saves preserve retained entry identities and source contributions.
Reduction/removal cannot silently discard allocated or imported work. Finalize
locks the card, verifies version, contract limits and explicit override evidence.
Reopen is allowed only when billing reservations and other guards permit it.
Void is a retained historical state, not deletion.

Import preview validates bounded JSON/CSV before explicit commit. Source and
record identity, canonical payload digests, operation keys, contribution versions
and retained receipts distinguish replay from changed content. Corrections target
the contributing source within an editable Draft; they do not overwrite another
source's minutes or mutate Finalized/Invoiced history.

Sources: `app/main.py:379`, `app/repositories.py`, `app/timecards.py`,
`app/time_commands.py`, `app/time_import.py`, `app/time_command_models.py`.

### Drafts, issuance, payments and cancellation

A time draft reserves eligible unreserved entries from the requested dates.
Reservations use entry identity as a unique claim, preventing double billing.
A card already labeled Invoiced may still contain other unreserved eligible
entries for a different period; the label is not a substitute for reservation
checks. Project-based drafts use the separate commercial claims described above.

Issuance rechecks project/currency/budget conditions and explicit commercial-term
confirmation. In one transaction it records issue date, JSON snapshot, stored
PDF bytes, SHA-256, renderer version, state changes and audit. Later download
verifies stored bytes; draft preview can render anew. Operational sent/due-date
changes cannot rewrite frozen content.

Payments are positive, within the current issued balance, in invoice currency,
and dated within the allowed business interval. A payment can stop related
Sending. Reversal retains the original row and requires a reason. Full issued
cancellation retains an immutable credit memo and original artifact; it requires
the permitted payment state and releases reservations/claims through guarded
logic. Draft cancellation is distinct from an issued credit.

Sources: `app/billing.py:201`, `app/billing.py:396`, `app/billing.py:458`,
`app/billing.py:572`, `app/billing.py:608`, `app/billing.py:658`,
`app/credit_memo_models.py`.

### Identity, admission, quotas and provider operations

OwnerIdentity binds immutable issuer/subject, never an unverified email merge.
OwnerRegistration retains explicit terms/privacy/catalog versions and selected
offer. Challenges retain bounded state, expiry and attempts; no app-owned
password store is introduced. Public challenge destination custody is encrypted.

WorkspaceAdmission and AdmissionIdentity coordinate directory reservation,
tenant-local bootstrap and activation across explicit transactions. Their
reserved/pending/active/blocked/revoked states allow incomplete work to fail
closed. Runtime never falls back to another owner's workspace.

Subscription capacity uses a tenant-wide transaction advisory lock. Counts cover
active clients and active projects under active clients; project limits are
tenant totals. Operation receipts protect bounded retries. The SaaS provider
ledger is distinct from service-statement payments and commercial documents.

Paddle operations and signed events retain mode-specific identity, digests,
idempotency and observed outcomes. Database commits cannot atomically guarantee
an external provider action; uncertain outcomes require reconciliation rather
than an invented success. Sandbox evidence cannot activate Live.

Sources: `app/enrollment_models.py`, `app/admission_models.py`,
`app/admission.py`, `app/subscriptions.py`, `app/subscription_billing.py`,
`app/subscription_billing_models.py`.

### Publication, sending and retained custody

Quote publication and Library publication freeze snapshots, PDF bytes, hashes
and version identity. Revisions preserve the prior published record; originals
remain separate from rendered versions. Binary upload/artifact fields are
deferred on normal lists. Explicit authorized downloads retrieve and verify
the requested retained file.

Statement Sending and commercial-document Sending have separate delivery and
attempt models. Preparation/confirmation, guarded claims, provider calls and
recorded terminal outcomes are explicit stages. A transport uncertainty is not
safe permission to resend. Stop, void/payment changes, environment gates and
immutable artifact identity remain enforceable at dispatch.

Mail imports retain normalized bounded content and separate immutable files,
not arbitrary remote HTML execution. Age archive is six calendar months for
timecards/Mail, with export-only custody and no automatic deletion or normal
restore. Settings retention fields record operator policy rather than deleting
history automatically.

Sources: `app/quoting.py`, `app/library.py`, `app/sending.py`,
`app/proposal_sending.py`, `app/mail_service.py`, `app/archiving.py`.

## 6. Migrations, read behavior and PH3 review

Current linear head is 009: work records/source custody/internal work and guards
arrive in 007, incomplete Client Draft lifecycle in 008, and three stable recent
list indexes in 009. Downgrade 008 refuses to erase unresolved Draft clients.
Do not rename or remove historical migrations because PH2 is closed.

The recent indexes order invoice and audit records by creation/UUID and active
Mail by owner/receipt/UUID. They do not speed every substring filter or remove
later-offset costs. Pagination preserves complete filtered counts and financial
aggregates while slicing the displayed rows; list limits never limit exports or
billing eligibility.

Database guards complement services for immutable artifacts, legal parent
associations, financial reservations, work allocations and role boundaries.
Their installed state, migration correctness and recovery require explicit
evidence; source presence alone cannot establish hosted installation.

Canonical closure carries assistant end-to-end proof, owner UAT, operational
backup/restore/custody choices and later provider rehearsals into PH3. Retained
migration-preservation evidence is attributed in `docs/STATUS.md`; this dossier
refresh adds no database, migration, recovery or runtime-test PASS.

Sources: `alembic/versions/ph3_007_work_records.py`,
`alembic/versions/ph3_008_client_lifecycle.py`,
`alembic/versions/ph3_009_read_indexes.py`, `app/pagination.py`,
`docs/PERFORMANCE_IMPROVEMENTS_2026-10-17.md`, `docs/STATUS.md`.