# 07 — Security, privacy, quality and evidence

Source snapshot: **2026-10-18**, PH3 commit
`9fc9eebdaf9f52170530c8a28d34f6c8cd612c64`.
PH2 is administratively closed and PH3 source is prepared. Await the owner's
feature prompts; continue the existing Stage. One future reviewed production
candidate must contain PH2 plus authorized PH3 changes.
[Current continuation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/CONTINUE.md#L1).

This chapter separates implemented controls, retained source-bound engineering
results and open acceptance/operational gates. The public documentation refresh
ran no product test, security scan, database/provider operation, authentication,
restore or deployment. It provides no new security certification or legal opinion.
[Closure and limits](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L1).

## 1. Trust boundaries

The browser, direct identity providers, managed email provider, Cloudflare edge,
application, tenant runtime role, operator/migrator, assistant client, outbound
provider and subscription provider are distinct actors. CAPTCHA is a bounded
anti-bot check; identity proof, tenant selection, authorization, business intent
and permission for an external effect remain separate decisions.

One owner/user belongs to one private workspace. Browser/model-supplied UUIDs,
email addresses, forwarded headers or tool text cannot choose a trusted tenant.
The server selects a retained descriptor from immutable identity/token proof,
then checks local owner/binding state. No default-workspace fallback, runtime DDL,
email-based merge or shared-owner/team model is implemented.
[Principal boundary](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/auth.py#L51),
[tenant registry](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/tenancy.py#L1),
[admission](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L142).

## 2. Browser sessions and request policy

| Control | Implemented behavior | Interpretation |
| --- | --- | --- |
| Signed session | Hosted host-only `__Host-timeker-session`, one-hour lifetime, Secure/HttpOnly/SameSite=Lax | Signature protects integrity; cookie content is not encrypted storage |
| Session validity | Current active owner, selected tenant, canonical association, session revision and provider binding | Old session state cannot override revocation or admission |
| Browser mutation | CSRF token, same-origin checks and bounded form parsing | Valid identity does not authorize an unconfirmed business change |
| Callback correlation | Provider state/nonce/proof and exact flow intent | Callback GET is not an ordinary CSRF-exempt business writer |
| Host/origin | Explicit trusted hosts and canonical hosted HTTPS | Development login is rejected on hosted profiles |
| Response protection | CSP, frame denial, nosniff, referrer/permission policy and hosted HSTS | Required provider origins remain narrowly scoped |
| Native recovery | Bounded browser HTML or machine JSON errors | Generic feedback does not prove the precise internal cause |

[Session construction](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L160),
[response middleware](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L195),
[form/CSRF validation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/auth.py#L109).
Provider tokens, OTPs, private records and financial documents do not belong in
signed cookies. Do not copy a PROD session into Stage or a separate assistant.

Private owner HTML, PDFs, JSON and sensitive responses remain private/no-store.
The performance increment deliberately adds caching only for successful known
public static GET/HEAD files with exact startup content versions; those responses
do not renew a session cookie. Unversioned public files revalidate. Unknown/wrong
versions and errors do not inherit immutable public policy.
[Static classifier](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/static_assets.py#L15),
[response policy](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L255).

Settings Clear cache explicitly refetches 22 known public app files with reload/
omit semantics, bounded concurrency and timeout. It preserves sign-in, settings,
records and unsaved forms; it does not erase all browser/site caches or reload
unsaved work. This is separate from private-data cache policy.
[Retained feature evidence](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L82).

## 3. Authentication and anti-abuse

Direct Google/GitHub starts require CSRF and the shared authentication CAPTCHA.
Social verification checks provider success, expected action and canonical
hostname; unavailable/invalid proof fails closed. Email passes its CAPTCHA to
Supabase for provider-side consumption, avoiding a local-then-provider replay.
[Social CAPTCHA](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/bot_check.py#L13),
[email CAPTCHA](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/email_auth.py#L128).

Immutable issuer/subject binding, exact local owner checks and explicit dual-proof
linking prevent an unverified email match from merging accounts. Registration
notice capture, fresh authentication, retained acknowledgment and first-plan
activation remain distinct. Codes/consent are supplied by the human owner.
[Linking](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L225),
[notice acceptance](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment.py#L237).

The social callback has a broad failure boundary. Historical CSRF/CSP corrections
and `AUTH_PROVIDER_NOT_LINKED` source branches do not identify every reported
rejection. Diagnosis needs fresh normal reproduction plus sanitized correlation,
not token dumps, copied sessions or guessed OAuth-console causes.
[Callback failures](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L662).

Public admission uses finite operator-prepared slots. Reservations retain exact
identity/slot IDs through partial failures; conflicted/nonempty/quarantined slots
fail closed and are not recycled by an ordinary request. Directory readiness is
fresh, server-side metadata verification, not a model-selected workspace or an
unbounded auto-provisioning promise.
[Reservation lifecycle](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L142),
[negative/isolation test source](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_public_admission.py#L186).

## 4. Database and financial invariants

PostgreSQL runtime roles remain nonowner and restricted to their own schema.
Operator/migrator authority is separate from runtime and disposable-test DDL
ownership. Row locks, version checks, audit records and database guard functions
preserve state transitions and immutable artifacts. Tenant selection alone is
not a replacement for real role/grant and reciprocal-isolation checks.
[Runtime role tests](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_public_admission.py#L216).

Durations use integer minutes and money uses Decimal/PostgreSQL NUMERIC. Weekly
contract dates/timezones are explicit business data. Templates do not calculate
money or invent taxes, rates or identifiers. Unknown commercial/legal fields stay
unknown until the owner supplies an approved factual source.
[Models](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/models.py#L83),
[product rules](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/AGENTS.md#L1).

Issuance freezes a JSON snapshot, PDF bytes and checksum. An issued document is
not edited in place. Full cancellation creates its retained immutable credit
memo while preserving the original artifact; it does not execute a client refund.
Payment tracking is explicit and separate from provider subscription billing.
[Issue](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/billing.py#L396),
[cancellation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/billing.py#L658).

Statement/commercial Sending claim uncertainty durably before provider I/O.
Interrupted or ambiguous acceptance is not blindly replayed. Owner Stop, current
eligibility, payment/void rules and versioned review remain effect boundaries.
No transport guarantee is invented to make a test or status appear successful.
[Statement dispatch](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/sending.py#L513),
[commercial dispatch](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/proposal_sending.py#L230).

## 5. Encryption and retained content

Live sensitive payment settings use a deployment-provided Fernet key, kept out of
source and diagnostic output. At issuance, payment instructions may be frozen in
private JSON/PDF artifacts; those individual immutable artifacts are not all
Fernet-wrapped. Restricted access, environment/database/backup custody and actual
operational encryption must be assessed separately.
[Payment-setting encryption](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/settings.py#L138),
[issued snapshot construction](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/billing.py#L325).

A successful encrypted snapshot/decrypt/hash/TOC check is not a hosted restore.
Off-host custody, key custody, backup cadence, tenant recovery, retention/rights/
holds, RPO/RTO and selected budgets remain P2-03. Local evidence retention is not
an off-host backup or an accepted recovery service level.
[Operational residual](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L33).

## 6. Imports, uploads and PDF rendering

| Input/artifact | Bounded behavior | Remaining limit |
| --- | --- | --- |
| Time JSON/CSV | Strict UTF-8/shape, 256 KiB/200 rows, source IDs, versions, reviewed Draft commit | No automatic authorization/finalization/billing |
| EML | 5 MiB raw, bounded headers/body/MIME depth/parts, escaped retained text | Untrusted correspondence; sender fields are not authentication |
| Mail/project attachments | Bounded immutable bytes, safe download name, forced attachment/no-store | No malware-scanning or active-content safety guarantee |
| Private Library | Bounded original files/text and versioned immutable publication | PDF is not falsely presented as editable converted text |
| Generated PDFs | Controlled templates and URL fetch denial | Valid output still needs totals/text/layout evidence when affected |

[Import bounds](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/time_import.py#L14),
[mail parser](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/mail_service.py#L23),
[project files](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/project_attachments.py#L18),
[Library bounds](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/library.py#L24),
[PDF asset denial](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/pdf.py#L13).

Downloads recheck owner, tenant and parent association. Binary content is not
rendered inline as trusted active material or emitted to diagnostics. CSV exports
neutralize spreadsheet formula prefixes. Retained issued/published bytes and
archive markers continue to constrain direct and indirect access paths.

Archive is one-way retained/export-only state, not disposal. The Case-only daily
02:17 UTC Stage job is configured for 90-day closed Cases, with no observed scheduled
execution. It does not activate scheduled Sending or a new timecard/mail schedule.
[Archive service](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/archiving.py#L60),
[Stage scheduler](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/src/index.ts#L63).

## 7. Diagnostic logs versus business audit

Python standard logging produces structured production JSON and readable local
output. Fixed event names and a strict typed safe-field allowlist retain UTC,
severity, request/execution UUID, route template, method, status, duration/count
and terminal outcome. Unsupported values and exception details are redacted.
[Safe fields/format](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/logging.py#L32).

Do not log OAuth/OTP material, cookies, authorization headers, raw URLs/query
strings, credentials, client/contact names, email/IP addresses, tax/bank details,
time descriptions, line text, contract notes or PDF bytes. Root/access/SQL and
third-party log streams are suppressed or replaced; raw provider debug logging
would bypass the intended boundary. Logging failure cannot change a committed
business result.
[Logger configuration](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/logging.py#L81),
[failure isolation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/logging.py#L104).

Business audit is a separate private transactional database record with owner-only
history. Its authorized business metadata can include personal/business data;
diagnostic redaction does not imply that the business database contains no PII.
Review both custody domains when changing data handling.
[Audit service](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/audit.py#L1).

## 8. Privacy, policy acknowledgment and legal limits

Terms/Privacy/catalog notice versions bind to an eligible successful identity
flow or explicit registration Continue action. Page views, failed proof and
link-only actions do not accept a new policy for someone. Optional tracking
preferences remain separate from required functional authentication/security.
[Notice contract](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment.py#L179).

Privacy choices use a separately signed host-only preference cookie with 180-day
lifetime. GPC/DNT refusal takes priority. Optional measurement remains disabled;
no active marketing vendor or global regulatory compliance is asserted. Withdrawal
of nonessential choices does not remove required session protection.
[Preferences](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/privacy.py#L13),
[optional measurement](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/usage.py#L1).

Owner/controller/entity facts, legal retention/rights/holds/disposal, transfer
assessments and commercial launch facts remain decisions for the appropriate
release boundary. A support form, privacy page, Sandbox payment or versioned
acknowledgment is not a worldwide compliance conclusion. Older canonical prose
must be interpreted with its stated environment/date and current STATUS/source;
legacy production-only descriptions do not erase later delivered Stage features.
[Discovery record](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/legal/PRIVACY_DISCOVERY.md#L1).

## 9. Current retained quality evidence

| Evidence | Recorded result | Exact scope/limit |
| --- | --- | --- |
| Base performance source `3e1d564ff56cafbd133533c784afa5e4780e5f53` | 2,153 backend and 296 browser cases; six static checks | Full r2 selections on that source; separate denominators, not an additive feature count |
| Settings source `e282985ea74e89e1665351c22f91706498495e93` | Eight backend/four browser cases; seven static checks | Fresh focused follow-up; unchanged core inherits base evidence only |
| Migration 009 | Nine schemas, 495 snapshot tables, 486 unchanged business-table fingerprints | Three reviewed indexes; retained roles/grants/guards/sequences/quarantines; not a restore |
| Isolation at that migration | 72 reciprocal 42501 denials before/after; 36 guards/schema | Source/role/schema-bound engineering proof, not human workspace UAT |
| Last Stage 29 release | Strict Docker release/readback, 31 GETs/15 matching assets, live/ready 200 | Dated public/asset proof; not continuous monitoring or current authenticated feature acceptance |
| Administrative closure | Archive/Git/document/clone checks; bounded Full Audit with observations | Documentation/custody assurance, with inherited/reduced review context |
| Generic scaffold validator | F1-A FAIL on unchanged required root `AGENTS.md` | Minor compatibility concern retained; no scaffold PASS claimed |

[Source-bound results](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L80),
[migration preservation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L102),
[release registry](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L12),
[closure verification and scaffold concern](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/PHASE2_CLOSEOUT.md#L77).

Backend evidence includes migration, immutable PDF/payment and logging/redaction
cases; browser selections use synthetic records and affected accessibility/native
flows. The base run retained seven backend/two browser warnings. Earlier failed
runs, fixture-authority problems, the corrected missed-await defect and the
Settings no-JavaScript fallback failure remain attributed without PASS credit.
Later successful attempts do not erase those source-specific failures.
[Retained failures](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L112).

The backend's disposable DDL-owner fixture is explicitly bounded, with elevated
role flags false. Browser and separate isolation fixtures preserve nonowner
boundaries. Test authority is not hosted runtime authority. Earlier local
restore/capacity exercises do not establish hosted RPO/RTO or sustained capacity.
[Fixture limits](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L98),
[local restore test source](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/tests/integration/test_recovery_rehearsal.py#L401).

## 10. What PH3 must still establish

P2-01 requires actual external-client OAuth/discovery/two-owner isolation/token
lifecycle. P2-02 requires human Stage authentication and business UAT. P2-03
requires adopted and verified operations/recovery. EXT-01 through EXT-05 retain
Apple/offboarding, remaining Sandbox lifecycle, commercial UAT, Sending decisions
and the final combined production candidate. Latest feature/perceptual acceptance
and actual scheduled Case execution remain open.
[Single residual queue](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L27).

No fresh full product suite, repository security scan, human UAT, hosted restore,
Live merchant proof or production readiness is created by this dossier update.
Future prompts should name a bounded measurable gap, expected actor/credential,
synthetic data, meaningful negative cases and evidence required for acceptance.
Do not treat a source inventory, mock, public 200, provider acceptance or backup
hash as proof of an unrelated gate. Preserve current money/isolation/immutability
contracts and one future separately authorized PH2+PH3 production release.
