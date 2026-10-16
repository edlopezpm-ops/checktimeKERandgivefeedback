# 05 — Integrations and external effects

**Dated engineering snapshot: 16 October 2026.** This chapter describes the implementation and evidence available at the HOC pause. It is not a new specification, a provider setup instruction, or permission to perform external actions.

**Source baseline:** `C:/Users/edlop/OneDrive/Documents/VS Code/timeker-PH2-quoting`, documentation HEAD `48e854ff2107dffb217dfe7c487b1b9d36a7f41d`; deployed feature source `dbf73e52ca03726e7903dc74ef27e40339c06936`. References below use repository-relative `file:line` pointers at this snapshot. Canonical decisions and current sections take precedence over historical sections of the same files.

**Current environment:** isolated Stage at `https://stage-timeker.aekr.io`; Worker `9a1cfc5f-73ec-4856-b3bb-ea9a2817168c`, Container application version 20, database head `ph3_006_quoting_library`. Production was not changed. The HOC pause stops engineering work; it does not stop deployed runtimes, provider webhooks, existing schedules, or third-party processing. Operational shutdown would require a separate explicit action and authority.

## 1. Integration map and authority boundaries

| Surface | Purpose and effect | Current boundary | Primary source |
| --- | --- | --- | --- |
| Google/GitHub OAuth and managed email authentication | Establish a verified human identity; resolve or allocate the permitted workspace | Stage has the bounded public admission profile. Production remains the existing separate Google-only deployment. Linking requires proof of the current account and the provider identity. | `app/enrollment_routes.py:513`, `app/email_auth.py:101`, `app/social_auth.py`; `docs/DECISIONS.md:877` and `docs/DECISIONS.md:914` |
| Delegated OAuth + MCP/HTTP tools | Give an explicitly approved client a narrow grant to actual workspace records | Fixed registered clients, explicit owner consent, scoped tokens; no assistant-selected tenant | `app/integration_auth.py:24`, `app/integration_routes.py:61`, `docs/DECISIONS.md:487` |
| Time import | Turn a bounded JSON/CSV file into reviewed Draft contributions | Native owner preview and confirmation; no automatic finalization or invoice issuance | `app/time_import.py:15`, `app/time_import_routes.py:271`, `app/time_commands.py:424` |
| Authentication email | Deliver OTP/confirmation through the managed identity provider | Supabase Auth owns its CAPTCHA verification and separate SMTP configuration | `app/email_auth.py:101`, `docs/OPERATIONS.md:337` |
| Public support contact | Deliver one user-submitted support message to the fixed operator destination | Stage delivery is disabled; durable abuse controls and a private Worker path | `app/contact.py:25`, `deploy/cloudflare/wrangler.jsonc:36` |
| Business Sending | Deliver an owner-reviewed immutable attachment | Cloudflare REST transport; collections and commercial proposals have separate business models | `app/sending.py:213`, `app/proposal_sending.py:139` |
| Inbound Mail | Retain an imported or routed correspondence record and attachments | Not an inbox-reading connector; Stage capture is disabled | `app/mail_service.py:201`, `app/internal_routes.py:129`, `deploy/cloudflare/wrangler.jsonc:37` |
| Paddle | Sell a timeKER SaaS subscription and reconcile verified provider events | Sandbox on Stage. Live merchant launch remains separately gated. | `app/paddle.py:17`, `app/subscription_billing.py:726`, `docs/OPERATIONS.md:226` |

These are different authorities. An authenticated session does not authorize an email. A connected assistant does not receive unrestricted owner powers. A saved draft does not authorize dispatch. A successful provider request is not agreement acceptance, invoice payment, delivery into a recipient's inbox, or human UAT.

## 2. Delegated OAuth and the MCP/API implementation

### 2.1 Surfaces and actual protocol subset

The same tool service is exposed through `POST /mcp` and `POST /api/integration/tools/{name}`. OAuth metadata is available through the authorization-server and protected-resource discovery routes. The owner manages grants at `/settings/integrations`; grant revocation is an owner/CSRF-protected POST. Sources: `app/integration_routes.py:669`, `app/integration_routes.py:692`, `app/integration_routes.py:842`, `app/integration_routes.py:862`, `app/integration_routes.py:889`, `app/integration_routes.py:1045`, `app/integration_routes.py:1066`.

The MCP implementation is a **finite, stateless JSON Streamable HTTP subset**, rather than a general streaming server. It accepts protocol versions `2025-03-26`, `2025-06-18`, and `2025-11-25`. The request must use JSON and advertise both `application/json` and `text/event-stream` in Accept; the implementation returns finite JSON. Authenticated GET/DELETE on `/mcp` return 405. There is no SSE/session stream, dynamic registration, resources/prompts catalog, hosted inference engine, or arbitrary remote execution. Supported methods are `initialize`, `ping`, `tools/list`, and `tools/call`; initialized/cancelled notifications return 202. The initialized capabilities advertise tools only. The body limit is 32 KiB, and unknown/invalid JSON-RPC shapes are rejected. Sources: `app/integration_routes.py:45`, `app/integration_routes.py:607`, `app/integration_routes.py:842`, `app/integration_routes.py:889`, `app/integration_routes.py:933`, `app/integration_routes.py:944`; decision `docs/DECISIONS.md:487`.

The server explicitly labels business text as untrusted data. Client names, case descriptions, notes and tool output cannot grant permission or instruct the service to bypass a check. The initial server instruction requires explicit dates, exact minutes and selection; writes remain Draft. This is a service boundary, not a claim that every model or client will interpret text safely. Sources: `app/integration_routes.py:47`, `app/integration_routes.py:958`.

### 2.2 Eight scopes and fifteen tools

The catalog is filtered by the granted scopes. Schema validation rejects extra arguments and requires the documented types, UUIDs, dates, limits and optimistic versions. Tool annotations identify read-only/destructive/idempotent behavior and declare a closed world. Sources: `app/integration_auth.py:24`, `app/integration_routes.py:61`, `app/integration_routes.py:217`, `app/integration_routes.py:257`.

| Scope | Tools | Permitted result and limits |
| --- | --- | --- |
| `clients:read` | `search_clients` | Search actual client records and their project identities. |
| `clients:draft` | `create_client_draft` | Create a proposed client for native review; does not publish an active client. |
| `cases:read` | `list_open_cases`, `get_case` | Read actual owned cases and their current versions; a case is not evidence of hours worked. |
| `cases:write` | `create_case`, `edit_case`, `close_case` | Explicitly create/change/close a case linked to real owned client/project records. Closing a case creates no time or bill. |
| `time:read` | `list_time_entries` | Read actual entries for an explicit client and week, including contribution/version information. |
| `time:write` | `create_time_entry`, `edit_time_entry`, `delete_time_entry` | Create or correct only this connection's Draft contribution with explicit minutes, confirmation and versions. It cannot finalize the timecard or remove another source's minutes. |
| `bills:read` | `list_bills`, `get_bill`, `list_credit_memos` | Read retained statement/credit summaries and lines. Issuer bank settings are excluded; no issue, void, payment or send tool exists. |
| `dashboard:read` | `get_week_summary` | Summarize actual owner records for the explicitly supplied week. |

There are no Quoting/Library publishing tools, commercial dispatch tools, subscription purchase tools, credentials tools, mailbox-reading tools or autonomous collection tools in this catalog. Their absence is relevant when reviewing any client capability claim.

### 2.3 Consent, token lifecycle and workspace selection

Registered clients are operator-controlled JSON descriptors, not caller-created clients. Public clients use authorization code with mandatory PKCE S256 and token endpoint authentication `none`. Redirects must be fixed HTTPS URLs without wildcards, fragments, user information or an injected issuer query. Resources are the canonical same-origin `/mcp` or `/api/integration` audiences. Authorization validates response type, client, redirect, requested scopes, state, challenge and resource before displaying the validated callback host and selected scope consent. A normal owner session is required to allow the native consent POST. Sources: `app/integration_auth.py:106`, `app/integration_auth.py:147`, `app/integration_auth.py:192`, `app/integration_auth.py:197`, `app/integration_auth.py:299`, `app/integration_routes.py:710`, `app/integration_routes.py:746`.

Authorization codes expire after five minutes; access tokens last ten minutes; grants and refresh authority are bounded to thirty days. Credentials are opaque values whose digests are retained in tenant-local tables. Their tenant component is only a routing selector: the trusted registry resolves it, and the service verifies the digest, active owner, grant, client, resource, scope, expiry and revoked/used state before accessing business data. The client cannot supply a free-form schema or obtain another workspace by editing a token selector. Sources: `app/integration_auth.py:34`, `app/integration_auth.py:70`, `app/integration_auth.py:86`, `app/integration_auth.py:231`, `app/integration_auth.py:254`, `app/integration_auth.py:313`, `app/integration_auth.py:323`, `app/integration_auth.py:336`, `app/integration_auth.py:497`.

Code replay revokes the associated grant. Refresh credentials rotate, and reuse is handled as replay rather than silently extending authority. Revocation is available through the OAuth endpoint and the owner's settings. The implementation keeps revocation/replay effects committed when returning the relevant OAuth error. The authorization response also carries issuer identity for the shared callback use case. Sources: `app/integration_auth.py:349`, `app/integration_auth.py:410`, `app/integration_auth.py:447`, `app/integration_auth.py:484`, `app/integration_routes.py:774`, `app/integration_routes.py:809`; `docs/DECISIONS.md:519`.

Writes require `confirmed: true` and a bounded `idempotency_key`. A durable receipt is bound to the source/grant and command content; a conflicting reuse returns a conflict. Optimistic versions and the same domain services used by native UI protect concurrent changes. A server accepting `confirmed: true` proves only that the request supplied that assertion; client UI must still obtain the human confirmation required by its product contract. Sources: `app/integration_routes.py:55`, `app/integration_routes.py:515`, `app/integration_routes.py:589`; `app/time_commands.py:28`.

### 2.4 Evidence and pending client work

The portable private connection package and scoped server are implemented. Local authorization, tool, isolation, import and replay tests exist, and hosted denial/issuer compatibility checks were retained. **Normal human OAuth Allow, actual client tool discovery, actual two-tenant platform reads, and refresh/revocation through the real client remain pending.** OpenAI is the preferred first client, not a claim of a completed connection; no Dot, voice or general platform support is claimed. Sources: `docs/STATUS.md:601`, `docs/DECISIONS.md:519`; tests `tests/integration/test_delegated_integration.py` and `tests/unit/test_integration_contracts.py`.

Resume work should use the normal owner-controlled OAuth consent flow. Do not extract cookies/tokens, copy a session across environments, or replace client E2E with a synthetic bearer request and call it an actual connection.

## 3. Time import and source-bound contributions

The import schema is `timeker.daily-time-import.v1`. Uploads accept strict UTF-8 JSON or CSV, bounded to 256 KiB and 200 entries. Records identify actual client/project UUIDs, work date, integer minutes, description and a stable source record ID; optional case allocations are bounded and must sum within the parent entry. JSON permits an explicit IANA timezone and otherwise uses the schema's UTC default; this is not an invitation to infer a user's timezone from prose. Duplicate JSON fields, excessive depth, non-finite values, duplicate source IDs and ambiguous headers/cells are rejected. Sources: `app/time_import.py:15`, `app/time_import.py:139`, `app/time_import.py:164`, `app/time_import.py:220`.

The native workflow is upload → server preview → explicit commit. The signed confirmation binds owner, tenant and session revision, expires after fifteen minutes, and is revalidated against current records/versions. The commit is atomic and replay-aware. Existing/manual/other-connection contributions remain distinguishable; correcting or deleting one contribution must not erase another source's work. Draft imports do not finalize a card, infer unrecorded time, issue an invoice or change a payment. Sources: `app/time_import_routes.py:29`, `app/time_import_routes.py:35`, `app/time_import_routes.py:271`, `app/time_import_routes.py:296`, `app/time_import_routes.py:301`, `app/time_commands.py:424`, `app/time_commands.py:556`; decision `docs/DECISIONS.md:471`.

## 4. Email is three outbound channels, not one shared capability

### 4.1 Managed authentication email

`SupabaseEmail` calls the configured provider's `/auth/v1/otp`, `/resend`, `/verify`, and `/user` endpoints. The app uses its Auth publishable key, not the provider's service-role database authority. OTP sends carry the provider CAPTCHA token; Supabase consumes/verifies that token, so the application must not consume it first in a duplicate verification. Public account creation is separately gated. After verification, the code fetches fresh `/user` proof, requires a confirmed, non-anonymous matching email and a valid subject UUID, and only then constructs the identity proof. Requests use bounded timeouts/responses and do not follow redirects or inherit proxy configuration. Sources: `app/email_auth.py:101`, `app/email_auth.py:110`, `app/email_auth.py:128`, `app/email_auth.py:152`.

The managed provider's SMTP setup is separate from business Sending. The reviewed Stage configuration uses Cloudflare SMTP over implicit TLS on port 465; the application is not a generic SMTP client and does not carry that SMTP credential. Authentication messages establish proof of address, not an account's entitlement to a workspace. Durable admission, existing-identity matching, bounded slot allocation and current notice handling remain application checks. Sources: `docs/OPERATIONS.md:337`, `docs/OPERATIONS.md:357`, `HOSTING.md:372`.

Owner-controlled OTP retrieval, normal authentication and fresh Google/GitHub linking remain human gates. This dossier contains no codes, mailbox contents, credentials, session cookies or approval of those actions.

### 4.2 Public support contact

Support delivery is a separate channel to the fixed operator mailbox. It cannot choose an arbitrary business recipient or attach an issued statement. The form is bounded, validates CSRF and the contact CAPTCHA action, uses a honeypot, and reserves a durable attempt before external delivery. Session/address/network digests, cooldowns and day/hour limits are abuse controls rather than analytics. The private `timeker-mail.internal/send` outbound path is implemented by the production Worker; a request exception after reservation becomes uncertain rather than causing an automatic duplicate send. Sources: `app/contact.py:25`, `app/contact.py` admission/delivery methods; `deploy/cloudflare/src/production.ts:63`.

Stage currently has `TIMEKER_CONTACT_DELIVERY=disabled` and does not gain the production contact binding merely because business Sending is configured. A contact preview or a successful CAPTCHA is not delivery evidence. Source: `deploy/cloudflare/wrangler.jsonc:36`.

### 4.3 Business outbound: Collections

The retained Collections workflow starts from an owned **issued immutable invoice PDF**, freezes the attachment identity/checksum, and renders editable recipient/subject/body templates for owner review. Optional follow-ups require explicit opt-in and bounded intervals/counts. Payment, void, plan stop and stop-all state block future sends; resume enables future eligible plans rather than reviving stopped history. Failed delivery retry is explicit and bounded; uncertain acceptance is not a retryable failure. Sources: `app/sending.py:145`, `app/sending.py:193`, `app/sending.py:213`, `app/sending.py:287`, `app/sending.py:314`, `app/sending.py:328`, `app/sending.py:340`, `app/sending.py:347`, `app/sending_routes.py:97`.

Every provider attempt has a durable claim committed before network I/O. An interrupted request therefore leaves uncertainty instead of pretending nothing happened. The provider adapter validates a pinned Cloudflare endpoint, immutable PDF hash, recipient and bounded request/response sizes. A generic HTTP 2xx is insufficient: the response must prove the exact requested recipient in its supported result classification. Diagnostic logs exclude message content, addresses, PDFs, tokens and raw provider replies. Sources: `app/sending.py:544`, `app/sending_transport.py:18`; tests `tests/integration/test_sending_dispatch.py`, `tests/integration/test_sending_isolation.py`, `tests/unit/test_sending_transport.py`.

The internal batch endpoint is machine-authenticated, checks both availability and jobs enablement, selects actual eligible owners server-side, and caps a batch at twenty deliveries. It does not expose a caller-selected owner or recipient. **Stage jobs are false and the Stage entrypoint configures no Sending cron.** The historical two-message Stage rehearsal authorized those two messages only; it authorizes no further messages. Sources: `app/internal_routes.py:20`, `app/internal_routes.py:42`, `deploy/cloudflare/wrangler.jsonc:55`, `docs/OPERATIONS.md:252`.

### 4.4 Business outbound: Quoting and agreements

The new `/sending/proposals` framework is independent of Collections/payment rules. It selects an owned published HLE artifact or a published working Library version; every working source is Case-bound, with Project/Client derived from that Case. Reusable case-less templates cannot be sent as working documents. A duration-only HLE does not require a contract. Prepare and Review save a draft; they do not send email. The exact immutable attachment, revision, filename, MIME type, SHA-256 and Case/source identity are frozen with the draft. Library publication explicitly selects the saved-text PDF or the original uploaded PDF/DOCX/TXT/Markdown bytes. Sources: `app/proposal_sending.py:100`, `app/proposal_sending.py:139`, `app/library.py` frozen-artifact resolver; `docs/OPERATIONS.md:71`.

The recipient, subject and message remain editable before claim. Confirm and send requires a fresh review digest and explicit confirmation. A double click cannot create a second accepted claim. States retain draft/sent/failed/uncertain/stopped history; there are at most four total attempts. Only a definitive failed result can be explicitly retried. An uncertain or already sent delivery is blocked from dispatch. Stop is sticky for future claims and cannot recall a message already handed to the provider. No recurring commercial chase, invoice issuance, payment recording, signature or acceptance inference is added. Sources: `app/proposal_sending.py:25`, `app/proposal_sending.py:173`, `app/proposal_sending.py:181`, `app/proposal_sending.py:193`, `app/proposal_sending.py:227`, `app/proposal_sending_routes.py:80`.

The email budget is **5 MiB after encoding**, not a promise that any 5 MiB upload is sendable. Preflight measures serialized REST bytes and a conservative MIME estimate including base64 line folding, text/HTML and 64 KiB header/boundary reserve. Oversize delivery is rejected before a durable attempt is consumed. The provider response must be HTTP 200, `success: true`, and contain exactly the requested recipient once across delivered/queued/bounce/suppression classes. A queue result means accepted for delivery, not that a human read or signed anything; bounces/suppression are failed, malformed/ambiguous responses are uncertain. Sources: `app/proposal_sending_transport.py:17`, `app/proposal_sending_transport.py:38`, `app/proposal_sending_transport.py:65`.

This feature is unavailable in production through `commercial_documents_available`. Actual dispatch additionally requires Sending availability and a configured enabled provider. Draft review works with transport disabled. Current tests use fake adapters; this delivery performed **no real commercial email send**. Sources: `app/config.py:202`, `app/config.py:206`, `app/proposal_sending_transport.py:60`; `tests/integration/test_proposal_sending.py`, `tests/e2e/test_proposal_sending_browser.py`.

## 5. Inbound correspondence and archive

Manual `.eml` import and optional routed capture retain correspondence; they are not outgoing email and do not connect a user's existing mailbox. The parser bounds raw/decoded files to 5 MiB, body to 1 MiB, MIME parts to 100 and recursion to ten; header/filename handling is bounded and HTML becomes safe plain text rather than executed content. Attachments are authenticated downloads, not executable previews or remote fetches. Source: `app/mail_service.py:23`, `app/mail_service.py:29`, `app/mail_service.py:58`, `app/mail_service.py:66`; owner routes `app/mail_routes.py:214`, `app/mail_routes.py:402`.

Capture uses an opaque tagged recipient and HMAC-authenticated private ingress. Signatures bind timestamp, exact route, recipient and raw-body digest with a five-minute window. The service resolves an active owned capture address instead of trusting a caller-selected tenant. The production entrypoint has `email` and archive `scheduled` handlers; the Stage entrypoint does not. Capture is currently disabled in Stage. Sources: `app/internal_routes.py:82`, `app/internal_routes.py:129`, `deploy/cloudflare/src/internal.ts:19`, `deploy/cloudflare/src/production.ts:67`, `deploy/cloudflare/wrangler.jsonc:37`.

Six-month archiving is a visibility/retention policy, not a backup or physical storage reduction. It retains rows and attachment manifests; protected correspondence remains part of encrypted database/backup custody. A future restore must reconcile mail/address and external-event state rather than assume that hiding old screens deleted the data. Source: `docs/OPERATIONS.md:720`; `app/archiving.py`.

## 6. Paddle subscription lifecycle and external payment effects

### 6.1 What Paddle bills

Paddle bills the owner's **timeKER SaaS subscription**, not the owner's clients. Client invoices, manual payment tracking, credits and immutable statement PDFs remain application business records. Stage uses the separate Sandbox origin, catalog, API key, public token and signing secret. The Free/Solo/Pro entitlement catalog and archived-over-limit selection are application rules; an arbitrary browser checkout event cannot grant paid access. Sources: `app/paddle.py:17`, `app/subscriptions.py`, `app/subscription_billing.py:99`, `docs/DECISIONS.md:636`.

Live mode exists as an explicitly gated production capability: canonical production origin, onboarding prerequisites, Live enablement, independent Live keys, four price mappings, verified catalog and mode-compatible retained history are required. Missing historical mode markers mean Sandbox; changing credentials cannot convert those records into Live history. Demo tenants cannot perform Live billing. Merchant launch and production activation remain pending. Sources: `app/paddle.py:242`, `app/paddle.py:660`, `app/subscription_billing.py:184`, `docs/OPERATIONS.md:226`, `docs/DECISIONS.md:836`.

### 6.2 Checkout, webhook and entitlement proof

Checkout starts with an owned durable operation key and explicit renewal authority. The service prevents overlapping reserved/uncertain monetary effects. Closing an overlay is not cancellation; a pending checkout is resumed/reconciled rather than duplicated. Checkout return GETs and SDK success messages do not grant entitlement. The app fetches provider transaction/subscription proof, validates tenant/checkout custom binding, customer/subscription IDs, exact price mapping, completed status and credible paid period, and only then updates the entitlement. Sources: `app/subscription_billing.py:99`, `app/subscription_billing.py:201`, `app/subscription_billing.py:338`, `app/subscription_billing.py:400`, `app/subscription_billing.py:454`, `app/subscription_billing.py:584`; `app/subscription_payment_routes.py:92`.

Webhook verification uses the unchanged raw body, bounded to 100 KiB. It validates the Paddle `ts`/`h1` format, a five-second timestamp tolerance and HMAC before decoding/applying an event. Signed receipt IDs and content digests make replay explicit; contradictory duplicate payloads are not treated as a fresh event. The service independently fetches current provider evidence, validates deployment/mode/tenant binding and handles stale/out-of-order events before changing local state. Sources: `app/paddle.py:183`, `app/subscription_payment_routes.py:395`, `app/subscription_billing.py:630`, `app/subscription_billing.py:726`.

Signature timing requires a correct host clock. A delivery retry has a new valid provider signature; the durable event identity, rather than accepting an old signature indefinitely, provides idempotency.

### 6.3 Changes, cancellation, grace and uncertainty

Plan change uses a current provider preview, retained review binding, explicit confirmation and idempotent operation reservation. Downgrade includes an owner-selected retained client/project inventory rather than silent data destruction. Optional retention uses a configured, validated fixed discount with bounded eligibility and one retained claim; cancellation remains available when the offer is unavailable. Cancellation is explicitly at the paid-period end. Read-only renewal reconciliation remains possible while another mutation is uncertain. Sources: `app/subscription_billing.py:536`, `app/subscription_billing.py:1028`, `app/subscription_billing.py:1085`, `app/subscription_billing.py:1214`, `app/subscription_billing.py:1294`, `app/subscription_billing.py:1419`, `app/subscription_billing.py:1589`; `app/paddle.py:544`.

Failed renewal grace is seven days from the earliest verified failure for the unpaid period; repeated events cannot keep extending it. Network/malformed-provider ambiguity is recorded as uncertain and blocks another monetary effect until reconciliation. There is no automatic blind replay merely because a request timed out. Sources: `app/subscription_billing.py:43`, `app/subscription_billing.py:388`, `app/subscription_billing.py:908`, `app/subscription_billing.py:921`.

Actual retained evidence covers the first Sandbox Solo-monthly test-card purchase, signed completed event, paid-period entitlement and authenticated portal; Solo-to-Pro proration was previewed. Annual checkout, 3DS, confirmed plan changes, retention, cancellation and failed-renewal grace have synthetic coverage, not completed real provider journeys. Source: `docs/STATUS.md:595`. No Live charge or merchant production readiness is claimed.

## 7. Review and resume checklist for external effects

Before resuming any integration work, resolve the current source/receipt baseline and the specific HOC authority. Then distinguish read-only provider metadata, normal human proof, reversible native drafts and irreversible external effects. Require fresh review for sending, billing mutations, OAuth grants or provider-console changes. Use fake adapters and disposable databases for engineering checks; keep real provider messages, signed callbacks and user-controlled identity steps in their separately authorized lanes.

Retain uncertainty rather than manufacture success. Provider acceptance is not inbox delivery; read-only metadata is not a completed human flow; a local isolation test is not a real-client cross-tenant test; a Stage deployment is not a production release or product acceptance. Canonical pending gates and privacy boundaries remain in `docs/STATUS.md:634`, `docs/OPERATIONS.md:226`, `docs/legal/PRIVACY_DISCOVERY.md:143`, and `docs/legal/PRIVACY_DISCOVERY.md:182`.

**Pause result:** no command in this chapter has been executed as part of dossier preparation. No mailbox, token, secret value, live contract payload, provider configuration, database or external recipient was accessed or changed for this chapter.
