# Production baseline and Stage differences

Snapshot: 2026-10-16. Stage analysis commit `48e854ff2107dffb217dfe7c487b1b9d36a7f41d`; original production repository main `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609`.
This comparison reads Git tree metadata and public repository documentation only. It performs no HTTP, database, deploy or provider action. It is not a production runtime re-verification.

## Exact environment distinction

| Area | Original production | Isolated Stage |
| --- | --- | --- |
| Origin | `https://timeker.aekr.io` | `https://stage-timeker.aekr.io` |
| Repository | `edlopezpm-ops/timeKER` | `edlopezpm-ops/timeker-PH2` |
| Source branch | main baseline above; unchanged | codex/ph3-onboarding-auth; later pause edits are documentation only |
| Last documented runtime source | a672c8f95bb54c61b6fdb7686f96161cd3491e8c, verified2026-10-12 | dbf73e52ca03726e7903dc74ef27e40339c06936, verified2026-10-16 |
| Worker | 01c92dfa-5632-4a33-b2ab-5ffba2c0ce32 | 9a1cfc5f-73ec-4856-b3bb-ea9a2817168c |
| Deployment | 3d2ab253-130c-4601-a1ad-73f98942b605 | 7ad0ff03-c344-4cad-be59-409d3e490813 |
| Container application | a0301688-9b57-483e-9d50-5d2eb9ceedd7, configuration12 | a0343dd5-a04b-4e30-b5da-98a373bf4990, application/running instance20 |
| Last image SHA-256 | a5445f4403161b0d81804db3ad0ac9afac55ac44a591389f3fd83af778ef008a | 9b04918f1171f93c5e7b6009c114846ba8b7f36390e2e3ad3e27cc879944f426 |
| PostgreSQL | Dedicated production project; two retained fixed schemas documented at a82d43cf6120 | Separate Stage project; nine actual runtime schemas at ph3_006_quoting_library |
| Authentication | Original Google-only allowlisted owner admission | Google/GitHub/managed email plus immutable identities, finite public signup and reviewed linking |
| Core v1 features | Clients, Projects/Cases, weekly timecards, statements/PDF, manual payments, reports, private Mail/archive/agreement custody | Preserved and extended through the later increments |
| Original Phase2 additions | Not introduced into original production by Stage work | Full cancellation credit memos, strict imports/contributions, proposed clients and scoped API/MCP |
| Subscription product | No Phase3 cutover performed | Free/Solo/Pro capacity, explicit registration and Paddle Sandbox |
| Quoting/Library | Not shipped into production | Case-bound HLE, editable document starters, templates/uploads and immutable publications |
| Outbound service statements | On-demand download/manual delivery | Separate reviewed statement and commercial Sending; scheduled jobs off |
| Optional usage | Source merged but runtime activation remains OFF in last documented state | Optional and disabled in retained configuration |
| Pause | Service remains as is; no production change | Engineering improvements paused until explicit HOC resume; service not shut down |

The original source main hash is not the same thing as the last deployed production source. The hosting registry explicitly records that later optional-measurement source was not activated. Do not replace this distinction with an assumption that Git push deploys the service.

Sources: original `HOSTING.md:8`, original `docs/STATUS.md:13`, original `docs/STATUS.md:39`; Stage `HOSTING.md:9`, `docs/STATUS.md:3`, current `CONTINUE.md`. Production source hashes and runtime identities are dated registry facts, not freshly queried provider state.

## Future release implications

A production push is not a simple rename of the Stage Worker. The owner must select the candidate and approve environment-specific flags, immutable legacy owner identity bootstrap, migrations/grants/backups for every retained schema, provider/secret custody, public admission inventory, accepted data/retention rules and actual UAT. Existing production runtime overrides need reconciliation against the intended source configuration. Preserve issued business artifacts and do not seed/copy Stage fixtures into production.

A historical production draft integration package may predate the current authentication and commercial additions. Its existence does not prove parity with the Stage analysis commit. This dossier neither rebuilds that candidate nor updates/merges/deploys a production PR. The current HOC pause prevents starting that work automatically.

## Tracked tree comparison

Original tracked paths: **230**; Stage tracked paths at analysis commit: **414**.
Different path counts: Different source bytes: **86**, Stage only: **184**.

The following table is a static source comparison, not a migration prescription, release patch or declaration that every changed file should be copied. Existing project history/ADRs and environment-specific configuration must be reconciled deliberately. Credential values and actual data are not present in this table.

| Path | Source relationship |
| --- | --- |
| `.dockerignore` | Different source bytes |
| `.env.example` | Different source bytes |
| `.gitignore` | Different source bytes |
| `AGENTS.md` | Different source bytes |
| `Dockerfile` | Different source bytes |
| `HOSTING.md` | Different source bytes |
| `PROJECT_MAP.md` | Different source bytes |
| `README.md` | Different source bytes |
| `alembic/env.py` | Different source bytes |
| `alembic/versions/ph2_001_credit_memos.py` | Stage only |
| `alembic/versions/ph2_002_time_commands.py` | Stage only |
| `alembic/versions/ph2_003_integrations.py` | Stage only |
| `alembic/versions/ph3_001_subscriptions.py` | Stage only |
| `alembic/versions/ph3_002_sandbox_billing.py` | Stage only |
| `alembic/versions/ph3_003_onboarding_auth.py` | Stage only |
| `alembic/versions/ph3_004_sending.py` | Stage only |
| `alembic/versions/ph3_005_public_admission.py` | Stage only |
| `alembic/versions/ph3_006_quoting_library.py` | Stage only |
| `app/admission.py` | Stage only |
| `app/admission_models.py` | Stage only |
| `app/admission_operations.py` | Stage only |
| `app/auth.py` | Different source bytes |
| `app/billing.py` | Different source bytes |
| `app/case_routes.py` | Different source bytes |
| `app/cases.py` | Different source bytes |
| `app/cli.py` | Different source bytes |
| `app/client_drafts.py` | Stage only |
| `app/clients.py` | Different source bytes |
| `app/config.py` | Different source bytes |
| `app/credit_memo_models.py` | Stage only |
| `app/db.py` | Different source bytes |
| `app/email_auth.py` | Stage only |
| `app/enrollment.py` | Stage only |
| `app/enrollment_models.py` | Stage only |
| `app/enrollment_routes.py` | Stage only |
| `app/integration_auth.py` | Stage only |
| `app/integration_models.py` | Stage only |
| `app/integration_routes.py` | Stage only |
| `app/internal_routes.py` | Different source bytes |
| `app/library.py` | Stage only |
| `app/library_models.py` | Stage only |
| `app/library_routes.py` | Stage only |
| `app/logging.py` | Different source bytes |
| `app/lookups.py` | Different source bytes |
| `app/main.py` | Different source bytes |
| `app/models.py` | Different source bytes |
| `app/paddle.py` | Stage only |
| `app/pdf.py` | Different source bytes |
| `app/project_routes.py` | Different source bytes |
| `app/proposal_sending.py` | Stage only |
| `app/proposal_sending_models.py` | Stage only |
| `app/proposal_sending_routes.py` | Stage only |
| `app/proposal_sending_transport.py` | Stage only |
| `app/quoting.py` | Stage only |
| `app/quoting_models.py` | Stage only |
| `app/quoting_routes.py` | Stage only |
| `app/sending.py` | Stage only |
| `app/sending_dispatch_routes.py` | Stage only |
| `app/sending_models.py` | Stage only |
| `app/sending_routes.py` | Stage only |
| `app/sending_transport.py` | Stage only |
| `app/social_auth.py` | Stage only |
| `app/subscription_billing.py` | Stage only |
| `app/subscription_billing_models.py` | Stage only |
| `app/subscription_models.py` | Stage only |
| `app/subscription_payment_routes.py` | Stage only |
| `app/subscription_routes.py` | Stage only |
| `app/subscriptions.py` | Stage only |
| `app/tenancy.py` | Different source bytes |
| `app/time_command_models.py` | Stage only |
| `app/time_commands.py` | Stage only |
| `app/time_import.py` | Stage only |
| `app/time_import_routes.py` | Stage only |
| `app/timecards.py` | Different source bytes |
| `app/web/static/app.css` | Different source bytes |
| `app/web/static/app.js` | Different source bytes |
| `app/web/static/auth_challenge.js` | Stage only |
| `app/web/static/github-invertocat.svg` | Stage only |
| `app/web/static/google-g.png` | Stage only |
| `app/web/static/google-sans-OFL.txt` | Stage only |
| `app/web/static/google-sans-medium.ttf` | Stage only |
| `app/web/static/paddle_checkout.css` | Stage only |
| `app/web/static/paddle_checkout.js` | Stage only |
| `app/web/templates/account_security.html` | Stage only |
| `app/web/templates/archive.html` | Different source bytes |
| `app/web/templates/assistant_connection_guide.html` | Stage only |
| `app/web/templates/auth_challenge.html` | Stage only |
| `app/web/templates/auth_layout.html` | Stage only |
| `app/web/templates/auth_methods.html` | Stage only |
| `app/web/templates/auth_notice.html` | Stage only |
| `app/web/templates/auth_notice_fields.html` | Stage only |
| `app/web/templates/auth_provider_button.html` | Stage only |
| `app/web/templates/auth_provider_forms.html` | Stage only |
| `app/web/templates/base.html` | Different source bytes |
| `app/web/templates/billing.html` | Different source bytes |
| `app/web/templates/capacity_prompt.html` | Stage only |
| `app/web/templates/case_detail.html` | Different source bytes |
| `app/web/templates/case_form.html` | Different source bytes |
| `app/web/templates/client_detail.html` | Different source bytes |
| `app/web/templates/client_drafts.html` | Stage only |
| `app/web/templates/client_form.html` | Different source bytes |
| `app/web/templates/credit_memo.html` | Stage only |
| `app/web/templates/credit_memo_pdf.html` | Stage only |
| `app/web/templates/email/invitation.html` | Stage only |
| `app/web/templates/error.html` | Different source bytes |
| `app/web/templates/help.html` | Different source bytes |
| `app/web/templates/invoice.html` | Different source bytes |
| `app/web/templates/landing.html` | Different source bytes |
| `app/web/templates/landing_info.html` | Different source bytes |
| `app/web/templates/legal_policies.html` | Stage only |
| `app/web/templates/legal_policy_content.html` | Stage only |
| `app/web/templates/library.html` | Stage only |
| `app/web/templates/library_document.html` | Stage only |
| `app/web/templates/library_document_pdf.html` | Stage only |
| `app/web/templates/lookup.html` | Different source bytes |
| `app/web/templates/mail_import.html` | Different source bytes |
| `app/web/templates/navigation_icons.html` | Different source bytes |
| `app/web/templates/project_form.html` | Different source bytes |
| `app/web/templates/proposal_sending.html` | Stage only |
| `app/web/templates/proposal_sending_prepare.html` | Stage only |
| `app/web/templates/proposal_sending_readiness.html` | Stage only |
| `app/web/templates/proposal_sending_review.html` | Stage only |
| `app/web/templates/public_plans.html` | Stage only |
| `app/web/templates/quote_detail.html` | Stage only |
| `app/web/templates/quote_form.html` | Stage only |
| `app/web/templates/quote_pdf.html` | Stage only |
| `app/web/templates/quoting.html` | Stage only |
| `app/web/templates/registration.html` | Stage only |
| `app/web/templates/sending.html` | Stage only |
| `app/web/templates/sending_followup_review.html` | Stage only |
| `app/web/templates/sending_prepare.html` | Stage only |
| `app/web/templates/sending_readiness.html` | Stage only |
| `app/web/templates/sending_review.html` | Stage only |
| `app/web/templates/settings.html` | Different source bytes |
| `app/web/templates/settings_integrations.html` | Stage only |
| `app/web/templates/sign_in.html` | Stage only |
| `app/web/templates/sign_up.html` | Stage only |
| `app/web/templates/subscription.html` | Stage only |
| `app/web/templates/subscription_account.html` | Stage only |
| `app/web/templates/subscription_change_review.html` | Stage only |
| `app/web/templates/subscription_checkout.html` | Stage only |
| `app/web/templates/subscription_command.html` | Stage only |
| `app/web/templates/subscription_payment_controls.html` | Stage only |
| `app/web/templates/subscription_portal.html` | Stage only |
| `app/web/templates/subscription_retention_review.html` | Stage only |
| `app/web/templates/time_import.html` | Stage only |
| `app/web/templates/timecards.html` | Different source bytes |
| `app/workspace_operations.py` | Stage only |
| `deploy/cloudflare/FOOTER_RELEASE.md` | Different source bytes |
| `deploy/cloudflare/README.md` | Different source bytes |
| `deploy/cloudflare/STAGE_RELEASE.md` | Stage only |
| `deploy/cloudflare/VERIFICATION.md` | Different source bytes |
| `deploy/cloudflare/package-lock.json` | Different source bytes |
| `deploy/cloudflare/package.json` | Different source bytes |
| `deploy/cloudflare/src/contact.ts` | Different source bytes |
| `deploy/cloudflare/src/index.ts` | Different source bytes |
| `deploy/cloudflare/src/internal.ts` | Different source bytes |
| `deploy/cloudflare/src/production-proxy.ts` | Stage only |
| `deploy/cloudflare/src/production.ts` | Stage only |
| `deploy/cloudflare/src/proxy.ts` | Different source bytes |
| `deploy/cloudflare/test/paddle.test.mjs` | Stage only |
| `deploy/cloudflare/test/production.test.mjs` | Stage only |
| `deploy/cloudflare/test/proxy.test.mjs` | Different source bytes |
| `deploy/cloudflare/test/sending.test.mjs` | Stage only |
| `deploy/cloudflare/tsconfig.json` | Different source bytes |
| `deploy/cloudflare/worker-configuration.d.ts` | Different source bytes |
| `deploy/cloudflare/worker-production-configuration.d.ts` | Stage only |
| `deploy/cloudflare/wrangler.jsonc` | Different source bytes |
| `deploy/cloudflare/wrangler.production.jsonc` | Stage only |
| `deploy/postgres/README.md` | Different source bytes |
| `deploy/supabase/stage-auth-code.html` | Stage only |
| `deploy/supabase/stage-auth-invitation.html` | Stage only |
| `docs/DECISIONS.md` | Different source bytes |
| `docs/DEPLOYMENT.md` | Different source bytes |
| `docs/OPERATIONS.md` | Different source bytes |
| `docs/PROJECT_BRIEF.md` | Different source bytes |
| `docs/STATUS.md` | Different source bytes |
| `docs/design/DESIGN_SPEC.md` | Different source bytes |
| `docs/design/EXPANSION_DISCOVERY.md` | Different source bytes |
| `docs/email/assets/timeker-wordmark.png` | Stage only |
| `docs/email/invitation-preview.html` | Stage only |
| `docs/legal/LANDING_COPY.md` | Different source bytes |
| `docs/legal/PRIVACY_DISCOVERY.md` | Different source bytes |
| `integrations/README.md` | Stage only |
| `integrations/timeker-stage/assets/logo.svg` | Stage only |
| `integrations/timeker-stage/mcp.json` | Stage only |
| `integrations/timeker-stage/plugin.json` | Stage only |
| `integrations/timeker-stage/skills/timeker/SKILL.md` | Stage only |
| `scripts/postgres-runtime-grants.sql` | Different source bytes |
| `scripts/render_invitation.py` | Stage only |
| `tests/conftest.py` | Different source bytes |
| `tests/e2e/conftest.py` | Different source bytes |
| `tests/e2e/test_archive_browser.py` | Different source bytes |
| `tests/e2e/test_credit_memos_browser.py` | Stage only |
| `tests/e2e/test_delegated_oauth_browser.py` | Stage only |
| `tests/e2e/test_live_checkout_browser.py` | Stage only |
| `tests/e2e/test_oauth_csp_browser.py` | Different source bytes |
| `tests/e2e/test_onboarding_browser.py` | Stage only |
| `tests/e2e/test_paddle_overlay_browser.py` | Stage only |
| `tests/e2e/test_proposal_sending_browser.py` | Stage only |
| `tests/e2e/test_quoting_library_browser.py` | Stage only |
| `tests/e2e/test_quoting_lookup_browser.py` | Stage only |
| `tests/e2e/test_sending_browser.py` | Stage only |
| `tests/e2e/test_sending_manual_followup_browser.py` | Stage only |
| `tests/e2e/test_shared_auth_challenge.py` | Stage only |
| `tests/e2e/test_subscription_browser.py` | Stage only |
| `tests/e2e/test_time_import_browser.py` | Stage only |
| `tests/e2e/test_timecard_selection.py` | Different source bytes |
| `tests/integration/test_archiving.py` | Different source bytes |
| `tests/integration/test_auth_get_sessions.py` | Stage only |
| `tests/integration/test_auth_notice.py` | Stage only |
| `tests/integration/test_credit_memos.py` | Stage only |
| `tests/integration/test_delegated_integration.py` | Stage only |
| `tests/integration/test_email_start_retries.py` | Stage only |
| `tests/integration/test_hardening.py` | Different source bytes |
| `tests/integration/test_library.py` | Stage only |
| `tests/integration/test_live_billing.py` | Stage only |
| `tests/integration/test_migrations.py` | Different source bytes |
| `tests/integration/test_onboarding_auth.py` | Stage only |
| `tests/integration/test_project_attachments_migration.py` | Different source bytes |
| `tests/integration/test_proposal_sending.py` | Stage only |
| `tests/integration/test_public_admission.py` | Stage only |
| `tests/integration/test_quoting.py` | Stage only |
| `tests/integration/test_quoting_routes.py` | Stage only |
| `tests/integration/test_recovery_rehearsal.py` | Stage only |
| `tests/integration/test_sending_dispatch.py` | Stage only |
| `tests/integration/test_sending_isolation.py` | Stage only |
| `tests/integration/test_sending_manual_followup.py` | Stage only |
| `tests/integration/test_sending_routes.py` | Stage only |
| `tests/integration/test_social_auth.py` | Stage only |
| `tests/integration/test_subscription_billing.py` | Stage only |
| `tests/integration/test_subscription_capacity.py` | Stage only |
| `tests/integration/test_subscription_domain.py` | Stage only |
| `tests/integration/test_subscription_http.py` | Stage only |
| `tests/integration/test_subscription_payments_http.py` | Stage only |
| `tests/integration/test_subscription_retention.py` | Stage only |
| `tests/integration/test_tenancy.py` | Different source bytes |
| `tests/integration/test_tenancy_capacity.py` | Stage only |
| `tests/integration/test_tenant_demo.py` | Different source bytes |
| `tests/integration/test_time_commands.py` | Stage only |
| `tests/integration/test_time_import_http.py` | Stage only |
| `tests/integration/test_usage_browser_flow.py` | Different source bytes |
| `tests/integration/test_workspace_operations.py` | Stage only |
| `tests/test_project_billing.py` | Different source bytes |
| `tests/test_sending.py` | Stage only |
| `tests/test_tenancy_config.py` | Different source bytes |
| `tests/unit/__init__.py` | Stage only |
| `tests/unit/test_email_auth.py` | Stage only |
| `tests/unit/test_integration_contracts.py` | Stage only |
| `tests/unit/test_invitation_template.py` | Stage only |
| `tests/unit/test_library.py` | Stage only |
| `tests/unit/test_live_templates.py` | Stage only |
| `tests/unit/test_logging.py` | Different source bytes |
| `tests/unit/test_onboarding_templates.py` | Stage only |
| `tests/unit/test_paddle.py` | Stage only |
| `tests/unit/test_paddle_templates.py` | Stage only |
| `tests/unit/test_production_capabilities.py` | Stage only |
| `tests/unit/test_proposal_sending.py` | Stage only |
| `tests/unit/test_proposal_sending_transport.py` | Stage only |
| `tests/unit/test_public_admission_proof.py` | Stage only |
| `tests/unit/test_quoting.py` | Stage only |
| `tests/unit/test_quoting_routes.py` | Stage only |
| `tests/unit/test_retention.py` | Stage only |
| `tests/unit/test_sending_templates.py` | Stage only |
| `tests/unit/test_sending_transport.py` | Stage only |
| `tests/unit/test_social_auth_proof.py` | Stage only |
| `tests/unit/test_subscription_templates.py` | Stage only |
| `tests/unit/test_subscriptions.py` | Stage only |
| `tests/unit/test_templates.py` | Different source bytes |
| `tests/unit/test_time_import.py` | Stage only |
