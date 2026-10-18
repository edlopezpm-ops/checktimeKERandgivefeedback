# 05 — Integrations and external effects

Source snapshot: **2026-10-18**, PH3 commit
`4bb5c424d6e7d270cdca1479283896be77d581c3`.
PH2 is administratively closed; PH3 is prepared on `main` and awaits
owner prompts. Existing Stage continues. One current reviewed production candidate
now carries the owner-approved private PH2 prelaunch; migration/deployment/readback are technically verified. This documentation refresh performed no
provider call, send, charge, database operation, authentication or deployment.
[Continuation](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/CONTINUE.md#L1).

## 1. Distinct integration authorities

| Surface | Implemented boundary | Current acceptance/activation limit |
| --- | --- | --- |
| Google/GitHub/email | User authentication and explicit linking | Normal human proof/UAT remains open |
| OAuth/MCP/API | Delegated, scoped owner business tools | Actual external-client acceptance remains P2-01 |
| Time import | Reviewed bounded JSON/CSV Draft contributions | Does not finalize cards or bill automatically |
| Managed auth email | Supabase-controlled verification delivery | Authentication SMTP is a separate custody domain |
| Support contact | Fixed operator destination and durable abuse controls | Separate environment-specific enablement |
| Statement Sending | Reviewed issued-statement delivery and bounded follow-ups | Scheduled Sending remains disabled |
| Commercial Sending | Explicit selected published quote/document version | Separate ledger/review; no automatic collections |
| Inbound mail | Bounded import or signed capture into an owned context | Capture activation remains separately controlled |
| Paddle | The owner's software subscription | Sandbox proof is not Live merchant readiness |
| Case retention | Signed Stage-only Case archive job | Configured schedule; actual invocation unobserved |

Configuration is not a blanket permission to perform an external effect. Business
intent, current owner authority, immutable artifact/version, provider readiness
and environment-specific gates remain independent.
[Capabilities](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L35).

## 2. Delegated OAuth and the actual MCP subset

The existing application exposes authorization-server/protected-resource metadata,
`/oauth/authorize`, `/oauth/token`, `/oauth/revoke`, `/mcp` and the same bounded
business tools through `/api/integration/tools/{name}`. The bridge reuses the
application's services, ownership checks and transactions; it is not a second
backend or an inference proxy.
[OAuth public router](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L668),
[API transport](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L864).

MCP is a finite stateless JSON Streamable HTTP subset. Supported protocol strings
are `2025-03-26`, `2025-06-18` and `2025-11-25`. The route validates media type,
Accept headers, Origin, protocol, JSON-RPC shape and a 32 KiB body limit. It accepts
bounded initialization, ping, tool discovery/calls and specific notifications.
There is no implemented SSE/session-stream service or automatic client registration.
[MCP constants](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L45),
[request validation](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L891).

### Scopes and tools

| Scope | Exposed tools | Mutation boundary |
| --- | --- | --- |
| `clients:read` | `search_clients` | Read actual owned client/project identities |
| `clients:draft` | `create_client_draft` | Proposed client only; no active publication |
| `cases:read` | `list_open_cases`, `get_case` | Read actual owned Cases |
| `cases:write` | `create_case`, `edit_case`, `close_case` | Confirmed, versioned Case changes |
| `time:read` | `list_time_entries` | Explicit week and actual contribution versions |
| `time:write` | `create_time_entry`, `edit_time_entry`, `delete_time_entry` | This connection's Draft contributions only |
| `bills:read` | `list_bills`, `get_bill`, `list_credit_memos` | Read bounded statements/memos; no issuer-bank settings |
| `dashboard:read` | `get_week_summary` | Recorded data for an explicit week |

These are eight scopes and fifteen tools, not an unrestricted CRUD interface.
No tool finalizes a timecard, issues/voids a statement, records/refunds a payment,
purchases a plan, sends email or grants another owner access.
[Scope definitions](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L24),
[tool catalog](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L61).

### Consent, routing and token lifecycle

Clients are operator-registered with exact fixed HTTPS callbacks; wildcards,
credential-bearing redirects and dynamic public registration are rejected.
Authorization uses code flow with mandatory PKCE S256, bounded state, exact
requested scopes and resource audience. The consent page identifies the selected
client/callback. RFC9207 issuer identification supports the registered shared
callback without weakening redirect matching.
[Client validation](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L147),
[authorization contract](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L197).

Credentials are opaque; database records hold hashes. Their selector can locate
only a fixed trusted tenant descriptor. It does not make a submitted tenant ID,
email or assistant argument authoritative. Each use rechecks the credential hash,
expiry, owner activity, registered client, resource and current grant/scopes.
[Access authentication](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L231).

Access tokens last 600 seconds. Authorization codes last five minutes; grants and
refresh lifetime are bounded to 30 days. Refresh credentials rotate; replay of used
code/refresh material revokes the relevant grant rather than silently renewing it.
Owner revocation is retained and subsequent access fails closed.
[Grant/code lifecycle](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L323),
[refresh replay](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L385),
[token persistence](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L484).

### Confirmed writes and replay

Write calls require `confirmed=true`, stable idempotency identity and relevant
optimistic versions. Time commands preserve source-owned contributions and manual/
other-source minutes. Case/proposed-client operations retain a grant-local key and
canonical payload digest: an exact replay returns the result; a conflicting reuse
fails. A tool result's business text is explicitly untrusted data, not an
instruction or new authorization.
[Write implementation](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L515),
[shared call boundary](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L591).

### Actual client evidence still missing

The private connection package and Settings onboarding exist. Source/local tests
cover protocol, scope, isolation and replay behavior. They do not establish a
completed real ChatGPT/Claude/client connection. OpenAI is the selected first
client in the documented contract; Dot/voice support is not inferred.
[Connection decision](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/DECISIONS.md#L520).

P2-01 requires normal human OAuth Allow, actual tool discovery, bounded reads by
two fictional owners, reciprocal isolation, confirmed idempotent Draft correction,
refresh rotation and revocation stopping the real client's access. Record the
actual host/client surface. Installing a plugin or making a synthetic bearer
request cannot substitute for this evidence.
[Residual P2-01](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L98).

## 3. Reviewed imports and contribution provenance

The canonical import format is `timeker.daily-time-import.v1`, with strict UTF-8
JSON or exact CSV columns, a 256 KiB payload ceiling and 200-entry limit. Stable batch
and source-record IDs bind replay. Entries use actual owned client/project IDs,
explicit work dates, integer minutes and bounded Case allocation; services enforce
timezone, project and weekly-cap rules.
[Import parser](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L1).

Preview exposes labels, totals, conflicts and versions before an atomic Draft-only
commit. Populated-cell conflicts do not silently merge/overwrite manual work.
Contribution corrections retain source provenance and versions. No import infers
authorization, reopens finalized history, overrides contract caps, finalizes a
card, creates an invoice or starts an external send.
[Import contract D054](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/DECISIONS.md#L472).

## 4. Email channels have separate custody

Authentication email belongs to the managed provider. The app requests the
configured verification action; the owner enters the code. Supabase authentication
SMTP credentials must not be extracted or repurposed for outbound business email.
[Managed email](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L101).

Support contact is a separate fixed-operator channel, with bounded user-submitted
content, CSRF, contact-action CAPTCHA, durable quotas and duplicate/uncertain-send
protection. It is not an arbitrary relay or a statement distribution endpoint.
[Contact controller](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L1).

### Statement Sending

Statement Sending selects an eligible issued statement and its retained PDF/hash,
uses reviewed editable templates and recipient, and stores a delivery plan/history.
It does not regenerate or alter issued PDFs, invoice dates/terms, payment records
or receipt dates. Provider acceptance is not client receipt, inbox placement or
payment. Client payment tracking remains manual.
[Statement service](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L1).

A durable uncertain claim is committed before provider I/O. If a result is
ambiguous, the system retains uncertainty instead of automatically trying again.
Known retryable failures have bounded explicit retry; owner Stop, payment and
void eligibility stop applicable follow-ups. Rechecks and locks protect current
eligibility near the effect boundary.
[Stop/retry](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L288),
[dispatch](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L513).

The transport uses separate configured outbound credentials. No undocumented
provider idempotency guarantee is assumed. A scheduled internal endpoint exists,
but `sending_jobs_enabled` remains false in retained Stage configuration. Manual
reviewed dispatch and future scheduled activation are different decisions.
[Transport](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_transport.py#L1),
[job gate](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L20).

### Quoting, Library and commercial Sending

Commercial Sending selects an immutable published quote or Library artifact and
its exact attachment/hash, reviews the addressed content and uses a separate
commercial outbox. HLE publication does not require inventing a contract; working
commercial documents retain their owned Case/project association.
[Commercial service](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L100).

This path has its own review digest, explicit confirmation, attempt history,
uncertain claim and stop/retry rules. Publishing an estimate/document never
sends it automatically, creates time, invoices a client or starts collections.
Authenticated hosted creation/edit/upload/publication/send-review UAT remains
EXT-03; no real customer send is implied by simulated Sent fixture history.
[Commercial dispatch](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L230),
[transport](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L1).

## 5. Inbound correspondence and archive

Manual EML import is owner-only and bounded before parsing. Conservative MIME
size/depth/part limits, escaped text, immutable attachments, sanitized forced
attachment downloads and owner-scoped raw-hash deduplication protect retained
correspondence. Sender, Message-ID and Date are untrusted content, not identity,
work authorization or archive-clock authority.
[Mail parsing/ingestion](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L23).

Optional capture uses a separate signed edge-to-container transport. Timestamp,
route, recipient and body hash are HMAC-bound; input is bounded and expired
signatures fail. Public proxy paths do not expose an open internal relay. A
committed response is different from a redirect or public login page.
[Internal authentication](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L82).

Archive is retained export-only state, not deletion. The existing Stage schedule
is **02:17 UTC daily**, invoking only Case retention for Cases closed at least
90 days. The signed Case endpoint leaves mail/timecard archive scope untouched.
An actual scheduled invocation has not been observed; configured cron is not
execution evidence. Scheduled Sending remains disabled.
[Stage scheduler](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/index.ts#L63),
[Case-only job](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L108),
[retention predicate](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L120).

## 6. Paddle subscription effects

Paddle bills the owner's timeKER subscription. It does not charge that owner's
clients or collect issued service statements. Checkout/portal readiness, signed
webhooks, retained event identity, mode-specific provider records and service
state determine entitlement; a browser success redirect alone is insufficient.
[Provider/webhook boundary](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L183),
[billing service](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1).

The retained real-provider rehearsal covers a first Solo-monthly **Sandbox**
test-card purchase, signed paid event and portal Paid readback. Annual/3DS,
confirmed plan changes, cancellation/retention and failed-renewal/grace still need
bounded real-provider rehearsal. Synthetic Stage capacity and simulated manual
payments are not provider payment evidence.
[Current provider limits](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L130).

Live requires independently configured Live merchant/catalog/credentials/webhooks
and explicit production capabilities. Changing environment name cannot promote
Sandbox credentials/history into Live. Mixed/foreign mode history fails closed;
Live merchant eligibility and general PROD admission remain open gates.
[Mode/capability validation](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L174).

## 7. PH3 external-effect acceptance

Use exact owner-selected scope, actual client/provider mode, fresh human proof,
confirmed recipient/artifact/version and durable readback. Preserve uncertain
results; reconcile before retrying. Do not copy sessions, authentication SMTP,
Sandbox history or synthetic entitlements into production. P2-01/P2-02/P2-03 and
EXT-01 through EXT-05 remain explicit work, not approval-only bookkeeping.
[Current queue](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L94).
