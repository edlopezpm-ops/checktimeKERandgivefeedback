# Security, privacy, quality and evidence

Snapshot date: 2026-10-16. Source-analysis commit: `48e854ff2107dffb217dfe7c487b1b9d36a7f41d` in `timeker-PH2`. This is a dated codebase review chapter. It records implemented controls and observed evidence, not a new security audit or a worldwide compliance finding. Repository-relative source pointers refer to that commit. No tests, authentication, database queries or provider actions were executed to prepare this chapter.

## 1. Trust boundaries

The browser, OAuth provider, managed email authentication service, Cloudflare edge, Python application, database runtime role, database migration/operator role, assistant client and outbound email/payment providers are different actors. Passing one boundary does not grant authority at another. CAPTCHA proves a bounded anti-bot check; OAuth/OTP proves an identity; the identity registry selects a workspace; the active-owner/session revision checks authorize application access; CSRF/origin checks protect browser mutations; business services enforce state and money rules; database roles and guards enforce persisted invariants.

The Stage product permanently uses one owner/user per private workspace. A Client or Project is a business record inside that workspace, not another SaaS member. Team collaboration, member invitations, owner transfer and arbitrary workspace switching are not implemented products. The server resolves the fixed tenant descriptor from the authenticated identity; it does not accept a model- or browser-supplied tenant ID as authority.

Sources: `app/auth.py:50`, `app/tenancy.py:328`, `app/tenancy.py:476`, `docs/DECISIONS.md` D052/D055/D059/D063/D065/D066.

## 2. Browser/session controls

| Control | Implemented behavior | Important interpretation |
| --- | --- | --- |
| Signed session | Starlette signed cookie with one-hour lifetime; hosted name `__Host-timeker-session`, Secure, HttpOnly, SameSite=Lax, Path=/, no Domain | Signed cookies provide integrity, not confidentiality. Do not place tokens, keys or sensitive business content in them. |
| Active identity | Active owner, canonical account identity, tenant descriptor, session revision and current nonrevoked identity are checked | A previously valid cookie cannot override revocation or tenant admission checks. |
| Fresh proof | Sensitive provider linking and relevant enrollment actions require fresh authentication context | Matching email strings alone never link providers or merge workspaces. |
| CSRF/origin | Browser mutation forms require session CSRF plus same-origin validation | Provider callbacks and machine transports have their own correlation/signature contracts. |
| Host validation | Explicit trusted hosts; canonical HTTPS origin on hosted profiles | Development login and permissive test hosts are rejected by hosted settings. |
| Response policy | CSP, frame denial, nosniff, no-store, strict-origin referrer policy, disabled camera/microphone/geolocation, hosted HSTS | Provider/Paddle origins are added only to the routes and modes that need them. |
| Failure responses | Native HTML recovery for browser errors and bounded JSON errors for integration paths | Generic UI errors do not prove a precise internal provider rejection cause. |

Sources: `app/config.py:63`, `app/main.py:139`, `app/main.py:152`, `app/main.py:190`, `app/main.py:257`, `app/auth.py:50`, `app/auth.py:104`.

Local preview uses a different cookie name; demonstration preview has its own cookie namespace. Session cookies or provider tokens must never be copied from PROD into Stage or from one host/client to another. The application does not provide a password vault or password login.

## 3. CAPTCHA and authentication details

One Cloudflare Turnstile widget is shared by the sign-in screen's independent Google, GitHub and email-start forms. Only the selected form receives the solved token. A fresh token is needed after consumption/expiration; a reusable widget does not mean a token can be reused across unrelated actions. The support contact form has a different action/boundary.

`app/bot_check.py:13` sends the secret and submitted token to Cloudflare Siteverify with a ten-second timeout, requires `success is True`, exact action and canonical hostname, and fails closed on unavailable or invalid responses. Hosted settings require real keys and reject testing keys. Neither the token nor the provider response is logged.

Successful immutable provider proof binds to the account registry or reserves a preprepared isolated Stage slot; it cannot fall back into the original owner's workspace. Managed email authentication uses the separate Supabase authentication provider, not the commercial Sending token. The application does not read the user's mailbox or retrieve OTPs. Notice receipt, identity proof, plan activation and purchase remain separate state transitions. Chapter04 explains the complete flows.

Apple currently has design/preparation documentation only. There is no Apple callback/provider adapter, key lifecycle, notification/revocation implementation or complete Settings account-deletion workflow. Removing the email-sign-in control did not implement account deletion. These are concrete absent capabilities, not passed checks.

## 4. Database and transaction protection

One PostgreSQL database per environment hosts private schemas and fixed restricted runtime roles. A separate operator/migrator applies schema changes and exact grants. Runtime code performs no tenant DDL and receives no migration administrator credential. `app/db.py:9` uses bounded pools, zero overflow, pre-ping, ten-second pool timeout, hidden SQL parameters and fixed role/schema verification on connections. Additional tenant pools are deliberately bounded; pool count multiplied by active descriptors and application instances must fit the hosting budget.

The current head is `ph3_006_quoting_library`. Each migrated Stage schema has 32 pinned protective functions and maintained table/sequence ACLs. Central directory tables have a special central-only read/insert/update contract; noncentral shadow tables remain denied. Triggers, immutable columns, foreign-key relationships and service-level locks complement authorization. Runtime SELECT permission on a table is not permission for an owner to view another owner's rows; services still scope business records to the active owner.

Exact minutes are integers. Money uses Python Decimal and PostgreSQL NUMERIC. Technical timestamps are UTC; contract dates/time zones are explicit business inputs. Browser clock decoration has no billing authority. Issued financial snapshots/PDF/checksums cannot be edited; full cancellation produces a retained full credit memo rather than replacing historical bytes. Partial refunds, invented tax/FX and inferred client contract facts are outside the implemented contract.

Sources: `app/domain.py:13`, `app/domain.py:34`, `app/domain.py:48`, `app/db.py:6`, `app/billing.py`, `app/credit_memo_models.py`, `scripts/postgres-runtime-grants.sql`, Alembic revisions through ph3_006. Chapter02 details tables, relationships and state transitions.

## 5. Encryption and retained data

Fernet protects configured sensitive settings and selected encrypted operational payloads under deployment-provided keys. This is not blanket per-column encryption of the database. Issuance intentionally freezes the then-current payment instructions into the owner's private invoice snapshot and PDF. Those immutable artifacts are not individually Fernet-encrypted by that settings mechanism. Database/host/backup custody and access controls must therefore protect the artifacts as well as encryption keys.

The password/secret fields and DSNs are deployment custody, not application diagnostic content. The assistant connector uses opaque token digests with expiry/scopes/rotation/revocation; raw access/refresh values are not public documentation. Admission descriptors contain DSNs/keys and remain protected. Backups of encrypted data without the separately retained keys may be unusable; keys without backups do not provide recovery.

This dossier contains source structure, configuration names, schema and public deployment identity. It does not contain deployment credential values, OTPs, session cookies, provider tokens, production data, real customer PDFs, actual uploaded contracts or database dumps. It is not a source-code backup or a recovery image.

## 6. Imports, binary files and PDF rendering

| Surface | Bounded behavior | Remaining limit |
| --- | --- | --- |
| Time JSON/CSV | Strict schema/columns; 256 KiB, 200 rows; preview and atomic Draft-only commit; retained source IDs/idempotency | No implicit overwrite, finalization, historical reopening, arbitrary XML or FTP. |
| Mail .eml | 5 MiB raw; bounded headers/MIME nesting/parts/text; owner assignment; exact hash deduplication | No active mail HTML, remote content loading, mailbox synchronization or implied sender authentication. |
| Mail attachments | Deferred immutable bytes; explicit private attachment downloads | No malware-scanning guarantee or inline execution. |
| Project agreement | One retained bounded immutable file, owner and parent checks | Existing single-file behavior is distinct from versioned Library documents. |
| Library | 5 MiB originals/PDF, 100k text limit; safe bounded DOCX parsing; PDF/DOCX/TXT/Markdown originals retained | A PDF is not converted into editable text; MIME/extensions are not a malware verdict. |
| Commercial email | Exact chosen published attachment; preflight accounts for encoded provider budget | A valid upload may still exceed the 5 MiB encoded email budget. |
| PDF renderer | Maintained templates, escaped text and restricted asset loading | Do not relax fetching into arbitrary URLs/local files to fix a rendering problem. |

Source pointers: `app/time_import.py`, `app/time_import_routes.py`, `app/mail_service.py`, `app/mail_routes.py`, `app/project_attachments.py:18`, `app/library.py`, `app/library_routes.py`, `app/proposal_sending_transport.py`, `app/pdf.py:13`.

Archiving is export-only visibility handling after the selected six-calendar-month boundary for relevant timecards/Mail. It does not delete rows, reclaim binary storage, resolve legal holds or establish a right-to-erasure implementation. Archived/direct/export paths retain their own guards. CSV exports neutralize formula prefixes. Published commercial history remains retained.

## 7. Logs, audit and observability

`app/logging.py:12` defines a finite diagnostic event vocabulary. `safe_fields` accepts UUIDs, known outcomes/reason/provider labels, registered route templates, finite methods and nonnegative integer status/duration/count fields; other values become `[REDACTED]`. Hosted logging is structured JSON with UTC time. The formatter redacts exception information. Application event emission catches logging failures so they cannot alter an already committed business result.

Root, access, SQL and third-party output are suppressed or replaced with the safe application logger. Worker proxy/lifecycle output is separately sanitized. Do not enable raw access/body/query/header/provider debug logging during authentication diagnosis. Collect path template, UTC time and request ID, not OAuth query strings/state or tokens. A catch-all authentication recovery screen alone cannot identify the exact failure.

Business audit events are persisted in the database transaction and may contain the authorized business metadata needed for accountability. They are not the diagnostic stream. The audit UI is owner-only. Financial issue/cancel/payment/import/publication/Sending/provider changes retain business provenance. The distinction matters: diagnostic redaction does not imply that all private business records contain no personal information.

Sources: `app/logging.py:34`, `app/logging.py:61`, `app/logging.py:81`, `app/logging.py:104`, `app/audit.py`, `app/main.py:190`, `deploy/cloudflare/src/proxy.ts`.

## 8. Privacy and legal UI

The maintained notice links the Terms, Privacy and Cookie policy and captures its revision at the sign-in/signup start. After verified immutable authentication, a versioned acknowledgment is recorded; ordinary page views, a failed proof and link-only actions do not accept a new version. Retained older flows without the current notice use an explicit Continue fallback. Public policies can be viewed/downloaded/printed without JavaScript or sign-in.

Privacy preferences use a separately signed host-only cookie, with a 180-day preference lifetime. Optional usage and marketing are distinct from authentication acknowledgment. GPC/DNT refusal takes priority. Optional usage collection is disabled by current configuration; no active marketing vendor is claimed. Withdrawal and “reject nonessential” behavior do not revoke required functional session security.

Sources: `app/privacy.py:12`, `app/privacy.py:18`, `app/privacy.py:75`, `app/usage.py:43`, `app/enrollment.py`, `app/web/templates/auth_notice.html`, `app/web/templates/legal_policy_content.html`, `docs/DECISIONS.md` D066, `docs/legal/PRIVACY_DISCOVERY.md`.

Chile/USA design sources are documented; worldwide customer intent is not evidence of global legal compliance. Controller/entity, launch-specific policies, processing/retention and commercial facts must be confirmed by the owner at the appropriate release decision. This chapter does not issue a fresh legal opinion. Optional choices must not be silently folded into a generic contractual acknowledgment.

## 9. Actual QA attribution at the pause

| Evidence scope | Recorded result | Freshness and limitation |
| --- | --- | --- |
| Last full backend r3 | 1,784 passed / 1 failed, 0 errors/skips, 909.65s, 7 upstream warnings | Raw receipt remains FAILED. Only failure was an obsolete navigation expectation. |
| Complete subsequent unit run | 761 passed, 9.45s, 1 warning | One assertion-only change; no runtime/integration/migration bytes changed. |
| Consolidated backend gate | 1,785 distinct cases: 917 integration + 107 root backend retained, plus 761 fresh complete units | Disjoint coverage/source/artifact proof verified independently. Not a new all-green full run. |
| Final affected E2E r4 | 32 passed, 0 failures/errors/skips, 78.98s, 1 warning | Synthetic desktop/mobile, keyboard/axe, CSP, no-JS, Case/lookup/publication/email-review coverage. No real mail. |
| Static/template | Ruff PASS; mypy 79 modules PASS; both JS syntax checks PASS; 84 Jinja templates compile | Worker/dependencies unchanged; their suites were not rerun for Quoting. |
| Disposable migrations | base → head → base → head plus Alembic check PASS; 32 guards | Disposable restricted-role PostgreSQL, not hosted data. |
| Stage migration | 9 runtime schemas at006; 396 old table fingerprints unchanged; 81 new tables initially empty; 32 guards/schema; 72 preflight +72 final isolation denials | Separate schema transactions; encrypted backup inventory/hash check, no restore rehearsal. |
| Hosted public proof | 19 GET checks PASS, live/ready200, 7 served source digests match, protected routes303 | No authenticated Quoting/Library/business flow, OTP, consent or email submitted. |
| Browser hosted observation | Transient503 during rollout, then public landing for protected Quoting without session | No completed owner UAT or precise social-provider proof result inferred. |
| Earlier core capacity/recovery | 50 synthetic schemas, 4,900 actual42501 denials; separate actual local restore rehearsal | Historical bounded engineering evidence; not hosted capacity or operational RPO/RTO. |

Canonical evidence: `docs/STATUS.md:3`, `HOSTING.md:9`, `deploy/cloudflare/STAGE_RELEASE.md:1`, `docs/OPERATIONS.md`. Raw private receipts are retained in the operator workspace; they were not copied wholesale to Desktop. Important hashes are included in chapter08.

Earlier failed/aborted runs are retained without PASS credit: absent rendered HLE operation key, UTC display defect, initial mobile focus failure and local sign-in test budgeting, an all-NUL new test restored with original bytes retained and unproven cause, and a denied local carrier rehearsal. These are corrected/attributed histories; they are not a claim that all conceivable bugs are absent.

The task-owned local PostgreSQL cluster is stopped with data retained; temporary Docker registry login was removed after release. No broad backend/browser rerun was justified for this documentation-only pause task. Document verification is a separate offline activity.

## 10. How to assess improvements after HOC resumes

Start with the measurable user failure or operational limit, locate its service/transaction/provider boundary, reproduce against synthetic data, and preserve the current money/isolation/immutability contracts. A route or model inventory proves breadth, not correctness. A passing mock does not prove provider interoperability. A saved plugin does not prove a live authenticated MCP connection. A provider email acceptance does not prove inbox placement. A successful backup check does not prove restore readiness. A Stage deploy does not approve production.

Prioritize the real MCP connection and bounded owner UAT before proposing speculative platform replacement. Any later recommendation should distinguish observed defect, measurable capacity issue, maintainability finding and optional product idea. The pause continuation document defines what may resume and what requires separate PROD authority.
