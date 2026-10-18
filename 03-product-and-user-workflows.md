# 03 — Product and user workflows

## Current review boundary

Source `4bb5c424d6e7d270cdca1479283896be77d581c3` on prepared `main` is the 2026-10-18 review baseline.
PH2 is administratively closed. Its private production prelaunch is technically verified; Stage continues and PH3 awaits owner prompts.

Last retained hosted evidence is Stage 29 / runtime source `e282985` /
schema `ph3_009_read_indexes`. This chapter explains source-delivered behavior;
it does not report new human UAT, new provider proof or a fresh hosted check.
Current residuals are in `docs/STATUS.md`, including actual assistant connection,
owner UAT and operational recovery/custody.

Sources: [canonical product brief](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/PROJECT_BRIEF.md),
`docs/design/DESIGN_SPEC.md`, `docs/PHASE2_CLOSEOUT.md`, `CONTINUE.md`.

## 1. Product model, navigation and interaction

One private workspace belongs to one individual owner. Clients contain projects;
cases organize work inside real client/project context. Timecards record actual
minutes. Estimates describe proposed effort, Library holds private documents,
and Billing issues commercial service statements. SaaS plan billing is separate
from manually tracked client-statement payments.

The authenticated rail contains Dashboard, Clients, Projects, Timecards, Cases,
Mail, Quoting, Billing, Sending, Library, Reports, Archive, Settings and Audit
history. Environment capability gates control applicable entries and routes.
Archive remains below Reports; Timecards is below Projects and Quoting above
Billing. Production visibility must not be inferred from Stage navigation.

The ivory/teal/navy shell retains the exact timeKER wordmark, translucent cards
and decorative borderless clock. The clock shows browser-local time with a
continuous seconds hand, reduced-motion handling and static 9:00 fallback.
Contract weeks and business dates use explicit domain timezones instead.

A fixed topbar offers a centered search icon. Enhanced search opens above the
current screen, preserves underlying unsaved forms, restores focus and supports
Escape. Native `/search` remains available. Sections retain empty headings and
up to five direct links per result category.

Forms retain input/inline errors, accessible save feedback and native GET/POST.
Opened forms/details use a 44px icon-only named Back control with visible focus.
Back/forward chevrons reuse the wordmark's navy/teal K-arm geometry.

Sources: `app/web/templates/base.html`, `app/web/templates/navigation_icons.html`,
`app/web/static/workspace.js`, `app/search_routes.py`,
`app/workspace_search.py`, `docs/design/DESIGN_SPEC.md`.

## 2. Lists, references and shared status

Lists and histories use ten records by default, configurable from one to fifty
in Settings. Pagination remains inside the results card with record/page counts.
Enhanced navigation updates that card while preserving neighboring forms,
focus and scroll. Native links retain filters and support browser history.

Independent selector defaults are 50 choices per page and 1000 matching results.
List/selector limits never reduce billing eligibility, aggregates or exports.

The five Dashboard detail groups are a deliberate exception: at most five rows
each regardless of Settings. Every Status column uses shared labeled badges;
color supplements readable text. Compact histories retain date/event/detail.

Country, invoice/budget currency and service/default timezone use native
dropdowns from local reference data. Existing defaults, blank optional values,
submitted errors and historical values are preserved. The UI does not infer a
country, tax identity or contractual fact from browser locale.

Sources: `app/pagination.py`, `app/lookups.py`, `app/settings.py`,
`app/reference_choices.py`, `app/web/templates/components.html`,
`app/web/static/status.css`, `app/web/static/workspace.js`.

## 3. Landing, plans, registration and privacy

Landing provides separate Sign up/Sign in routes, concise product information,
legal/privacy panels and About plans. The center has no separate View plans
shortcut. Google, GitHub and configured managed email are supported source
methods; configuration alone does not prove successful human enrollment.
Apple remains design/preparation work.

Registration requires explicit versioned acknowledgment. An empty new workspace
requires explicit first-plan activation; an acknowledged owner with retained
client history may retain workspace access, while plan/capacity guards still
control growth. An existing identity signs in to its own
workspace; a verified new owner consumes a prepared private slot. Account
security links/revokes methods through fresh proof, never an email-string merge.

The current source catalog is Free (1 active client/1 active project, USD0),
Solo (5/10, USD7 monthly or USD70 annually), Pro (no commercial client/project
cap, USD12 monthly or USD120 annually). Projects are tenant totals. Free has no
card requirement or trial expiry. Tax/commercial acceptance and Live activation
remain separate decisions; these are source catalog terms, not a new quotation.

Cookie/privacy choices distinguish essential operation from optional usage.
Withdrawal and applicable privacy signals remain respected. Support contact,
where enabled, sends only an explicitly submitted message to the fixed operator
mailbox with CAPTCHA and durable abuse controls; Stage's public adapter gates it.

Sources: `app/web/templates/landing.html`, `app/enrollment.py`,
`app/enrollment_routes.py`, `app/subscriptions.py`, `app/privacy.py`,
`app/contact.py`, `app/web/templates/auth_methods.html`.

## 4. Dashboard

The five actionable summaries are This week hours, Draft statements, Outstanding
statements, Finalized unbilled time and Overdue statements. Complete counts,
minutes and financial totals cover their entire eligible scope. Selecting a
summary opens its own detail group with independent fixed-five paging.

Switching metric/rhythm preserves each group's page. Enhanced Previous/Next
replaces the selected detail panel only; late inactive responses cannot reopen
it or steal scroll/focus. Native GET/back/forward remains functional. Responses
are private/no-store; the optimization is reduced work, not a private-data cache.

The client workload panel shows up to four active clients with recorded hours
and project/case/timecard context over its documented 28-day period. It opens
Clients. The rhythm panel switches between fourteen daily bars and fourteen
Monday-first calendar weeks, including the current UTC week and thirteen prior
weeks. Its perimeter/heading opens Timecards, separate from chart switching.

The contribution grid retains exact daily minutes, seven weekday initials,
shared duration bins, legend and blank future padding. Weekdays use green;
weekends use violet with the same bins. Rounded cells, unequal gutters and an
opaque canvas address the reported grid illusion without changing recorded
values. Subjective comfort/visual acceptance remains an owner decision.

Sources: `app/main.py:739`, `app/dashboard.py`, `app/reports.py:108`,
`app/web/templates/dashboard.html`, `app/web/templates/dashboard_detail.html`,
`app/web/static/app.js`.

## 5. Clients, projects and cases

Clients can be searched, filtered, sorted, paged and opened for their profile,
contacts, projects, commercial terms, statements and history. Client Edit is
the normal status control: Draft, Active, Archived. New clients derive Draft
or Active from completeness. Codes are four ASCII letters, uppercase on save,
with inline duplicate feedback.

Draft permits missing activation details. Active requires basic valid profile,
Tax ID, legal representative name, billing email and contractual email, plus
available plan capacity. Missing values remain explicit; a Draft does not imply
a verified legal profile. An optional source URL/upload stays privately retained
as evidence with explicit edit/download actions, without automatic fact inference.

Projects retain name/description, real client, visible Project ID starting at
10000, lifecycle, billable/rate metadata and optional additional fields. Project
type can be Time and Materials, Fixed Fee, On Call Support or the two On Demand
support variants. Optional budget/currency and Contract/SAL/SOW reference pairs
record actual owner-provided arrangements. One private agreement upload up to
5 MiB remains immutable.

Cases retain real client/project, generated case number, type, title, bounded
description, status and optional flexible fields. Owners can review, edit and
allocate existing time entries; allocations cannot create extra time. Mass edit
uses the same validation/ownership boundaries.

Closing/archiving parents requires confirmation and checks open children or
linked nonempty Draft timecards. Closed/archived records leave normal new-work
selectors; retained work, files, billing and history remain readable through
their appropriate surfaces. Reactivation must meet capacity/lifecycle rules.

Sources: `app/clients.py`, `app/client_sources.py`, `app/project_routes.py`,
`app/project_attachments.py`, `app/record_references.py`, `app/cases.py`,
`app/case_routes.py`, `app/work_lifecycle.py`.

## 6. Weekly timecards and reviewed imports

A normal card belongs to one owner/client/Monday-start week with project/day
cells. Internal time can omit client/project, optionally link an owned case and
is always nonbillable. H:MM and exact-minute decimal-hour input persist integer
minutes. Notes remain optional sensitive business content.

Load week restores active-project structure. Owners can add/select/remove unused
Draft rows without deleting projects or protected work. Duplicate copies the
structure into the next week with empty durations. Save Draft, Finalize and
audited Reopen retain version/cap/reservation rules. Above-cap finalization needs
an explicit owner reason and authorization reference. Historical Voided cards
remain readable; new timecard voiding is prohibited.

The four top tiles now show Ongoing timecards, Ongoing projects, Fill rate and
the decorative local clock. Counts cover the viewed Monday–Sunday week across
all owner clients/internal work, excluding voided/archived scope and earlier-week
carry. Saved empty Drafts count as cards; projects count distinct real IDs with
entries in the scoped week. Fill rate shows Draft and Finalized counts, not a
percentage; Invoiced counts as Finalized. Zero is explicit. Current-card status
and unsaved/read-only feedback stay beside the editor.

JSON/CSV import provides preview before explicit commit. Strict source records,
payload hashes, idempotency keys and contribution receipts support replay and
bounded Draft corrections. Imported or allocated time cannot be silently
overwritten by another source, reduced below protected allocations or changed
after finalization/invoicing.

Sources: `app/main.py:1030`, `app/timecards.py:20`, `app/timecards.py:55`,
`app/time_import.py`, `app/time_import_routes.py`, `app/time_commands.py`,
`app/web/templates/timecards.html`, `app/web/static/timecards.js`.

## 7. Billing, immutable PDFs and manual payments

Owners create a time-based Draft for a client/date period from eligible finalized
unreserved work, review grouped lines and detailed time, adjust permitted draft
values, then explicitly issue. Exact minutes aggregate before monetary rounding.
Contract/source discrepancies require confirmation before issuance.

Fixed-fee and applicable support projects have an explicit base-fee action using
their stored fee/currency and service dates. A nonvoid base fee cannot be charged
twice. Manual extras require enabled overbilling, positive amount, reason and
unique reference; they do not fabricate hours or reserve time.

Draft PDF preview may regenerate. Issue freezes JSON snapshot, bytes, hash and
renderer identity. Issued downloads return those checked stored bytes; no
in-place edit is permitted. Spanish/English documents include actual supplied
details, exact totals and the commercial-statement qualification. Missing legal,
tax or bank values are never invented.

Mark as sent records delivery and default due date; due corrections require an
audited reason. Owner-entered payments use statement currency, allowed date and
current balance. Reversal preserves history. Paid/partial/overdue displays are
derived. Draft cancellation differs from full issued cancellation, which retains
an immutable credit memo and original artifact and requires permitted payment
state before releasing billing claims.

Sources: `app/billing.py`, `app/project_billing_routes.py`, `app/pdf.py`,
`app/credit_memo_models.py`, `app/web/templates/invoice.html`.

## 8. Quoting, Library and two outbound workflows

Quoting supports effort-only HLEs and optionally priced T&M/fixed estimates.
A working estimate requires a case, deriving its client/project. Create service
case opens the existing form with Services selected and returns to the composer.
Min/max integer-minute ranges, assumptions, exclusions and validity remain
owner-edited. An estimate creates neither actual work nor an invoice.

Publish retains an immutable revision/snapshot/PDF/checksum. Editing a published
estimate begins a new revision. Library holds working SOW/SLA/agreement wording,
reusable templates and complete owner uploads in PDF/DOCX/TXT/Markdown up to
5 MiB. Working documents require case context; reusable templates may be unbound.
Editable text, retained originals and published versions remain distinct.

Commercial Sending reviews one published estimate/Library version or explicitly
selected retained original with recipient, subject, body and exact attachment.
It has its own manual outbox, durable claim, attempt history, stop and guarded
retry. It does not schedule collections or record client payments.

Issued-statement Sending separately binds a reviewed unpaid immutable statement,
recipient and rendered text. Follow-ups are opt-in/bounded and stop on payment,
void, individual Stop or Stop all. Early follow-up uses a fresh explicit review
while retaining its original schedule. Partial payment stops the plan; reversal
does not resume it. Definitive rejection may permit explicit retry; uncertain
provider acceptance must not replay. Provider acceptance is not recipient reading.
Scheduled statement jobs remain disabled and actual sends need separate authority.

Sources: `app/quoting.py`, `app/quoting_routes.py`, `app/library.py`,
`app/library_routes.py`, `app/proposal_sending.py`, `app/sending.py`.

## 9. Mail, archive and reports

Mail imports bounded owner-selected .eml content with explicit client/optional
project/case association. Normalized text/headers and separate immutable files
remain private; original MIME is not retained. Sender/Date are unverified
reference data, not work approval. Capture addresses are revocable and configured;
the feature is not full inbox synchronization or an outbound mail client.

Timecards/Mail older than six calendar months become export-only Archive records.
Timecards use service-week end in contract timezone; Mail uses trusted receipt or
explicit historical receipt, not sender Date. This is retained custody, not
deletion, backup, statutory policy or a restore-to-normal-screen action.
Financial relationships and eligible finalized unbilled work remain preserved.

Reports retain monthly client hours, billable work estimates, finalized unbilled
time, statement aging and CSV. Display pagination does not truncate totals or
exports. Fixed fees remain separate from hourly estimates.

Sources: `app/mail_service.py`, `app/mail_routes.py`, `app/archiving.py`,
`app/archive_routes.py`, `app/reports.py`.

## 10. Settings, integrations and next decisions

Settings manages issuer details, encrypted payment instructions, PDF language/
paper/footer, defaults, independent list/selector limits and recorded retention
policy. It links Subscription, Assistant connections, Client drafts, readiness
and audit; secrets are never shown. Clear cache explicitly refreshes 22 known
versioned public app files, preserving sign-in, data and unsaved forms. It shows
progress/retry and native help; it does not automatically reload the page.

Subscription exposes current individual plan/capacity and explicit Sandbox
checkout/change/portal actions. Contextual upgrade controls do not block unrelated
work. First Solo-monthly Sandbox purchase has retained provider evidence; annual,
3DS, changes, cancellation/retention and renewal failure/grace need rehearsal.
A synthetic Stage Pro grant is not paid-provider evidence or a PROD entitlement.

Assistant connections use scoped OAuth/MCP/API access and operator-registered
clients. Proposed clients remain owner-reviewed drafts. Actual platform/tool
discovery, reciprocal owner isolation and refresh/revocation remain carried
residuals; source implementation does not prove a human assistant session.

PH3 prompts should build from these delivered workflows, name genuine gaps and
retain acceptance boundaries. Human UAT, grid comfort, latest performance/Settings
acceptance, Apple/offboarding, operational recovery and private prelaunch verification and later public/Live
PROD readiness remain open. No new implementation or rollout follows from this
review package.

Sources: `app/settings.py`, `app/web/templates/settings.html`,
`app/web/static/settings_cache.js`, `app/subscription_routes.py`,
`app/integration_routes.py`, `app/client_drafts.py`, `docs/STATUS.md`.
