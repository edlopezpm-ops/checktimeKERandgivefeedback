# 04 — Authentication, registration and access

Source snapshot: **2026-10-18**, PH3 commit
`9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` on `codex/ph3-stage`.
PH2 is administratively closed at tag `ph2-closeout-2026-10-18`
(commit `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6`). PH3 is prepared and
awaits the owner's feature prompts. The existing Stage continues; one future
reviewed production candidate must combine PH2 and authorized PH3 changes.

This chapter describes source and retained evidence. Preparing this public
reference did not authenticate, send a code, accept an agreement, query a database,
change a provider or deploy. Source readiness is separate from human acceptance.
[Current continuation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/CONTINUE.md#L1) and
[residuals](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L27) govern the handoff.

## 1. Current authentication surface

Google, GitHub and managed Supabase email are implemented sign-in methods.
Their configuration and visibility do not prove that every real owner/provider
combination has completed sign-in, linking and recovery. Apple remains deferred:
there is no implemented Apple runtime adapter/callback or exposed method.

| Capability | Source boundary | Retained Stage state |
| --- | --- | --- |
| Google | OIDC proof through Authlib, configured client and hosted checks | Configured; normal human proof remains required |
| GitHub | OAuth code/state/S256 plus fresh verified API identity | Configured; no repository permission is requested |
| Managed email | Explicit Supabase provider and pinned service configuration | Configured; OTP remains owner-controlled |
| Generic onboarding | Explicit capability; default off | Stage admission uses its retained directory |
| Public signup | Separate flag and finite prepared inventory | Stage only, subject to readiness and available slots |
| Email public signup | Separate capability layered over local admission | Does not follow merely from email sign-in configuration |
| Local login | Explicit development option | Rejected in hosted profiles |
| Apple | Design/deferred work | Unimplemented/unverified |

Definitions: [configuration](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/config.py#L41),
[provider visibility](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/social_auth.py#L17),
[provider registration](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L174).
No current PROD override query accompanies this snapshot; checked-in profiles
and last verified Stage facts must not be presented as fresh production facts.

## 2. Identity and workspace invariants

The product uses one owner/user per private workspace. Clients, Projects and
Cases are business records within it, not additional SaaS members. There is no
implemented team membership, shared-owner account, arbitrary workspace switch or
owner-transfer product.

The authentication key is immutable **issuer + subject**. A verified email is
an identity claim and contact attribute; it is not sufficient authority to merge
accounts or link a different provider. Google uses its OIDC subject, GitHub its
numeric account ID, and managed email the verified provider UUID and fixed issuer.

The central identity directory locates a candidate tenant. Authentication then
rechecks the exact active local identity and active owner. A directory locator
alone cannot authorize a workspace; no unmatched identity falls back to the
default owner's schema.
[Local authentication](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/auth.py#L36),
[directory resolution](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L64) and
[identity validation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment.py#L30) enforce these boundaries.

The legacy generic-off Google compatibility path still checks its configured
allowlist and existing owner row. It is separate from generic admission. A future
production activation requires independently verified immutable-owner coverage;
email matching must not silently bootstrap the new directory.
[Legacy owner check](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/auth.py#L19),
[bootstrap gate](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/OPERATIONS.md#L197).

## 3. Existing owner, new owner and linking are separate flows

| User intent | Required behavior | Evidence still needed |
| --- | --- | --- |
| Existing owner | Sign in through an already linked immutable identity | Human sign-in/recovery on the correct private workspace |
| New owner | Explicit signup, verified proof, available prepared slot, acknowledgment and first-plan activation | Fresh end-to-end admission with a separate fictional owner |
| Add a method | Authenticate existing owner freshly, then prove the new method through Account security | Real dual-proof linking and subsequent sign-in/revocation |
| Recover access | Use a retained linked method or separately authorized operator procedure | Human recovery exercise; no automatic email merge |

An email-only account is not automatically linked when someone later presses
Google on Sign up. The safe supported route is an already linked sign-in, then
Account security and fresh independent proof of the additional provider.
[Admission](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L142) and
[explicit linking](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L225) retain that distinction.

## 4. Entry pages, CSRF and the shared challenge

`/sign-in` and `/sign-up` render distinct native forms. The selected method start
supplies an explicit intent, offer, closed return value and notice versions.
A query-string page view does not allocate a workspace, accept terms or select a
paid subscription. GET provider-start URLs return to the entry flow; POST starts
perform CSRF, origin, form-shape and anti-bot checks.
[Flow selection](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment_routes.py#L20) and
[provider start](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L484) are the source boundaries.

One shared Cloudflare Turnstile widget serves the independent method forms.
Only the chosen form receives its current solved token. Expiration or consumption
requires a new token. The direct social flow verifies success, expected action
and exact canonical hostname server-side; provider errors fail closed.
[Server verification](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/bot_check.py#L13) and
[shared controller](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/web/static/auth_challenge.js#L1).

Managed email deliberately passes the token to Supabase, which owns that CAPTCHA
verification. Consuming the same token locally first would replay it at the
provider. A shared widget is not permission to reuse one token across attempts.
[Email send boundary](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/email_auth.py#L128).

The pre-authentication CSRF value survives a provider-start session reset so a
retained form in another open tab does not lose that token prematurely. Successful
authentication still replaces session state and rotates CSRF. This correction is
source-backed; it does not prove the precise sequence behind an earlier report.
[Pre-auth preservation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L533),
[session issuance](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment_routes.py#L36).

## 5. Google and GitHub proof

Google uses Authlib OIDC discovery and validation, an ID token and verified claims.
GitHub uses code/state/S256 and fixed token/API endpoints; fresh `/user` and
verified email API responses establish its numeric identity. `user:email` is the
requested GitHub scope, without repository access. Provider tokens are transient
backend proof and are not persisted as the app's session or account password.
[Google/GitHub setup](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L174),
[GitHub proof](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/social_auth.py#L28).

The callback validates the exact issuer, routes immutable identities, rechecks
local binding and owner, records only eligible notice evidence, then chooses a
registration, subscription, Account security or Dashboard destination.
[Callback implementation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L566).

The visible recovery message is deliberately broad. Its catch-all covers proof,
linking, routing and operational failures. It cannot by itself prove a particular
OAuth-console error or `AUTH_PROVIDER_NOT_LINKED`. Capacity exhaustion separately
returns bounded temporary-unavailability feedback. Diagnose only with fresh
normal reproduction and sanitized request/event evidence.
[Failure classification](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L662).

## 6. Managed email challenge lifecycle

The app delegates sending and verification to the configured Supabase service.
Existing invited-user confirmation resend and ordinary OTP are explicit delivery
choices. Public provider-account creation requires the separate enabled signup
capability; an existing-account action must not quietly create a new owner.
[Delivery modes](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/email_auth.py#L24).

An OTP verification response is not trusted solely for its embedded user object.
The backend fetches fresh provider `/user` proof, checks confirmed matching email,
rejects anonymous identities and normalizes the provider UUID subject.
[Verification](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/email_auth.py#L152).

Challenges bind purpose, intent/offer, session nonce, expiry and attempt count.
The public-admission path retains encrypted submitted address and keyed session/
network digests in its directory challenge. Fixed-owner challenges remain scoped
to that owner. The stored state is not an OTP vault. The local challenge window
is ten minutes and verification attempts are bounded; stale or consumed proof
must be replaced through a normal new flow.
[Owner challenge](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/email_auth.py#L180),
[public challenge](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L322).

The challenge view exposes only its session's escaped submitted destination.
Repeated start handling preserves a valid pending challenge when appropriate;
ordinary entry-page refresh is not a resend instruction. The user personally
reads and enters codes. Neither this dossier nor an assistant may retrieve an
inbox, extract OTPs or bypass identity proof to complete acceptance.
[Email flow controller](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment_routes.py#L359).

## 7. Versioned acknowledgment and first plan

The entry flow captures exact current notice/Terms/Privacy/catalog versions.
After successful immutable identity proof, the eligible sign-in/signup notice
can create the retained registration acknowledgment. A failed provider flow,
ordinary page view or link-only action does not create that acknowledgment.
[Notice capture and recording](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment.py#L179).

Flows missing the current notice use the explicit Continue registration fallback;
legacy acknowledgment compatibility remains validated by the service. No agent
accepts the notice for a person. Referencing the catalog does not itself buy a
plan, authorize a charge or assert commercial/legal eligibility.
[Registration acceptance](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment.py#L218).

Workspace use requires both acknowledgment and a usable first plan. Free
activation has its own operation key, capacity lock and state checks. Paid plans
use the separate subscription flow. Pending registration may expose the bounded
registration/security/subscription recovery surfaces without granting ordinary
business access.
[Free activation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment_routes.py#L231),
[workspace gate](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/auth.py#L87).

## 8. Account security and revocation

Sensitive linking requires fresh existing-owner context, normally within ten
minutes, plus independent new-method proof. Generic admission reserves the global
subject and checks the local binding. The older fixed-owner compatibility path
has its additional managed-email proof restriction. Email text is never enough.
[Freshness](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment_routes.py#L64),
[social link proof](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L514).

Revocation is explicit and cannot remove the final usable sign-in method through
an ordinary convenience action. Local identity history and directory state are
retained. Reauthentication/session revision and method revocation are separate
from deleting an account, legal offboarding or removing retained financial data.
[Identity revocation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L266),
[local invariant](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/enrollment.py#L157).

## 9. Sessions and owner authorization

Hosted sessions use a signed `__Host-timeker-session` cookie, one-hour lifetime,
Secure/HttpOnly/SameSite=Lax, host-only scope and Path `/`. Signing provides
integrity, not secrecy. The session contains bounded identity/routing state;
provider tokens, OTPs and private business documents do not belong in it.
[Session middleware](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/main.py#L160).

Each protected request checks the actual active owner, selected tenant, canonical
email association, current session revision and retained provider binding where
enrollment is active. Logout is a CSRF-protected POST. Browser business mutations
require session CSRF and same-origin validation; signed machine routes and OAuth
callbacks have their distinct correlation/authentication contracts.
[Principal checks](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/auth.py#L51),
[form validation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/auth.py#L109).

## 10. Finite tenant allocation and readiness

Each workspace has an operator-prepared private PostgreSQL schema and restricted
runtime role. New-owner admission reserves an exact finite slot through the
central directory, initializes that identity in the selected workspace, reads it
back, and activates the retained mapping. Partial failure preserves reservation
identity; retries reconcile it rather than reallocating another owner's slot.
[Reserve/initialize/activate](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L142).

There is no runtime DDL, admin-credential path, schema creation on demand, default
workspace fallback or email-based account merge. Readiness checks actual configured
relations, privileges, role boundaries and prepared inventory. Quarantined schemas
are not routable slots. Nine actual schemas at migration 009 is a historical
verified inventory, not a claim of nine currently free signup slots.
[Registry](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/tenancy.py#L1),
[retained environment](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L36).

## 11. Required PH3 evidence

P2-02 remains normal human Stage sign-in/signup/link/recovery UAT with existing and
newly admitted fictional owners and explicit private-workspace checks. P2-01 adds
actual assistant OAuth/tool discovery and token lifecycle; source/unit tests do
not close those external-client gates. Apple/account deletion/offboarding remain
EXT-01, with real-provider prerequisites and acceptance still open.
[Transferred residuals](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/STATUS.md#L27).

Record the exact client surface, fresh proof, expected destination, durable
readback and accept/reject result. A public page, HTTP 200/303, installed plugin,
expired OTP, generic callback message or prior source receipt is insufficient.
PH3 feature prompts and future production authorization remain separate decisions.
