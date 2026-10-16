# Source map, test catalog and snapshot manifest

Snapshot: 2026-10-16; Stage source-analysis commit `48e854ff2107dffb217dfe7c487b1b9d36a7f41d`.
Generated offline from tracked source. No application import, database connection, provider request, credential read or test execution occurred.
This is a dated review appendix, not a replacement for canonical contracts. Source pointers below refer to this commit.

## Product Python modules

| File | Module responsibility / docstring | Functions (all scopes) | Classes |
| --- | --- | --- | --- |
| `app/__init__.py` | See narrative chapters and source | 0 | 0 |
| `app/admission.py` | Durable admission across the central directory and fixed private-role factories. | 20 | 1 |
| `app/admission_models.py` | Central admission records; never owned by an unverified or invented user. | 0 | 3 |
| `app/admission_operations.py` | Explicit directory reconciliation and read-only admission readiness. | 3 | 0 |
| `app/archive_routes.py` | Owner-only, bounded CSV exports; archived records never hydrate normal screens. | 8 | 0 |
| `app/archiving.py` | One-way, export-only archive markers; financial records remain in PostgreSQL. | 7 | 0 |
| `app/audit.py` | See narrative chapters and source | 1 | 0 |
| `app/auth.py` | Canonical owner authentication with immutable identity and fixed tenant boundaries. | 8 | 1 |
| `app/billing.py` | Transactional invoice reservation, issuance and exact payment accounting. | 25 | 0 |
| `app/bot_check.py` | Verify the sign-in challenge before OAuth. Never log tokens or provider bodies. | 1 | 0 |
| `app/case_routes.py` | Owner-only case and retained-archive screens. | 19 | 0 |
| `app/cases.py` | Owner-scoped work cases and exact-minute attribution, without separate billing. | 6 | 0 |
| `app/cli.py` | Management commands with safe terminal events and no credential output. | 1 | 0 |
| `app/client_drafts.py` | Assistant proposals remain separate from active, billable client records. | 2 | 0 |
| `app/clients.py` | See narrative chapters and source | 6 | 0 |
| `app/config.py` | Explicit environment configuration, validated before serving requests. | 7 | 1 |
| `app/contact.py` | Public support contact: bounded inputs, durable admission and private delivery. | 10 | 1 |
| `app/credit_memo_models.py` | Immutable full-cancellation artifacts, separate from original invoice PDFs. | 0 | 1 |
| `app/db.py` | Database/session boundaries; production never creates tables implicitly. | 2 | 0 |
| `app/demo.py` | Fictional local review dataset; never merge it into an operational database. | 1 | 0 |
| `app/domain.py` | Exact duration, business-week and currency functions. | 6 | 1 |
| `app/email_auth.py` | Fixed Supabase email OTP transport; provider credentials remain transient server memory. | 14 | 2 |
| `app/enrollment.py` | Explicit individual registration; verified identity never assigns a paid tier. | 15 | 0 |
| `app/enrollment_models.py` | Tenant-local explicit registration and immutable external identity bindings. | 0 | 3 |
| `app/enrollment_routes.py` | Explicit same-origin registration and managed email authentication forms. | 25 | 0 |
| `app/forms.py` | Field validation shared by server-rendered editing flows. | 3 | 1 |
| `app/integration_auth.py` | Authlib OAuth code/PKCE adapter and tenant-local revocable delegated credentials. | 48 | 9 |
| `app/integration_models.py` | Tenant-local delegated authority, hashed credentials and retained operation receipts. | 4 | 5 |
| `app/integration_routes.py` | Bounded same-origin OAuth, JSON API and stateless Streamable HTTP MCP adapters. | 29 | 0 |
| `app/internal_routes.py` | Authenticated, bounded edge-to-container jobs; never a public mail relay. | 5 | 0 |
| `app/library.py` | Owner-only document drafts, bounded imports and frozen publication versions. | 14 | 0 |
| `app/library_models.py` | Private editable documents and retained, immutable publication artifacts. | 0 | 3 |
| `app/library_routes.py` | Native owner forms for the private Library and document composer. | 18 | 0 |
| `app/logging.py` | kommiBo-style JSON events with a stricter typed safe-field boundary. | 5 | 1 |
| `app/lookups.py` | Bounded, scoped choices shared by native forms and progressive enhancement. | 6 | 0 |
| `app/mail_models.py` | Private normalized mail and separately loaded extracted attachments. | 0 | 3 |
| `app/mail_routes.py` | Owner mail import, private reading and revocable capture-address management. | 19 | 0 |
| `app/mail_service.py` | Bounded MIME normalization, explicit assignment and idempotent mail custody. | 13 | 1 |
| `app/main.py` | Application factory, security middleware and same-origin route composition. | 59 | 1 |
| `app/models.py` | PostgreSQL domain entities with integer time and fixed precision money. | 0 | 19 |
| `app/paddle.py` | Pinned Paddle environment transports; persisted authority and reconciliation live elsewhere. | 40 | 5 |
| `app/pdf.py` | On-demand escaped PDF generation; no asset URL is allowed. | 2 | 0 |
| `app/privacy.py` | Product-local privacy preferences; optional usage requires a fresh explicit choice. | 6 | 1 |
| `app/project_attachments.py` | One bounded, immutable private agreement per project; download-only custody. | 4 | 0 |
| `app/project_billing_routes.py` | Owner billing controls for an explicitly selected client project. | 6 | 0 |
| `app/project_routes.py` | Owner project screens sharing the existing audited project service. | 14 | 0 |
| `app/project_terms.py` | Project commercial terms shared by editing and explicit billing workflows. | 1 | 0 |
| `app/proposal_sending.py` | Manual commercial document outbox, independent of invoices and collections. | 15 | 2 |
| `app/proposal_sending_models.py` | Separate, retained owner-confirmed commercial document delivery records. | 0 | 2 |
| `app/proposal_sending_routes.py` | Owner-only commercial review and manual delivery; no collection actions. | 13 | 0 |
| `app/proposal_sending_transport.py` | Typed commercial attachments over the existing separately configured sender. | 9 | 2 |
| `app/quoting.py` | Exact-minute estimates; publication never creates time, invoices or agreement acceptance. | 26 | 0 |
| `app/quoting_models.py` | Case-bound estimates and immutable, privately published PDF revisions. | 0 | 4 |
| `app/quoting_routes.py` | Case-bound estimate workbench and native, versioned editing flows. | 21 | 0 |
| `app/reports.py` | Small operational reports, values prepared before template rendering. | 4 | 0 |
| `app/repositories.py` | Shared persistence queries and lock acquisition, never template logic. | 3 | 0 |
| `app/seed.py` | Idempotent supplied private seed and separate deterministic synthetic profile. | 1 | 0 |
| `app/sending.py` | Explicit statement sending with durable claims and conservative delivery uncertainty. | 24 | 2 |
| `app/sending_dispatch_routes.py` | Owner-requested dispatch, with the same tenant and CSRF boundary as Billing. | 5 | 0 |
| `app/sending_models.py` | Retained owner-approved outbound statement plans and delivery history. | 0 | 4 |
| `app/sending_routes.py` | Owner review and controls for explicitly enabled immutable statement delivery. | 18 | 0 |
| `app/sending_transport.py` | Separate outbound transport; never reads authentication SMTP settings. | 3 | 1 |
| `app/settings.py` | See narrative chapters and source | 7 | 0 |
| `app/social_auth.py` | Direct Google and GitHub provider proof and readiness. | 3 | 1 |
| `app/subscription_billing.py` | Verified Paddle Sandbox capacity; browser returns never confer entitlement. | 48 | 0 |
| `app/subscription_billing_models.py` | Sandbox merchant bindings, durable effect intents and verified event receipts. | 0 | 3 |
| `app/subscription_models.py` | Tenant-local capacity assignment and immutable owner operation receipts. | 0 | 2 |
| `app/subscription_payment_routes.py` | Owner-only subscription commands and authenticated environment-pinned event ingress. | 19 | 0 |
| `app/subscription_routes.py` | Single-owner subscription review and explicit, history-preserving Free enrollment. | 7 | 0 |
| `app/subscriptions.py` | Approved catalog and one transactional tenant-wide active-capacity boundary. | 17 | 2 |
| `app/tenancy.py` | Deployment-selected tenants; immutable fixed-role factories and request-local context. | 20 | 7 |
| `app/tenant_demo.py` | Explicit, idempotent fictional dataset for a registered isolated demo tenant. | 1 | 0 |
| `app/time_command_models.py` | Tenant-local source contributions and durable time-operation receipts. | 0 | 3 |
| `app/time_commands.py` | Atomic source-owned Draft time commands shared by imports and integrations. | 17 | 0 |
| `app/time_import.py` | Closed, bounded JSON and CSV time import with a shared canonical schema. | 11 | 0 |
| `app/time_import_routes.py` | Bounded owner upload, exact preview and signed atomic import confirmation. | 14 | 0 |
| `app/timecards.py` | See narrative chapters and source | 5 | 0 |
| `app/usage.py` | Bounded optional category counts in existing sanitized logs, never business data. | 4 | 1 |
| `app/workspace_operations.py` | Explicit, transactional preparation of the protected admission slot inventory. | 14 | 1 |

## Test source catalog

Function counts are static declarations, not executed-case counts. Parametrization expands tests; fixtures/markers/collection affect execution. Refer to chapter07 for actual receipts and failure attribution. No tests were run to generate this appendix.

| Test file | Declared test functions |
| --- | --- |
| `tests/e2e/test_archive_browser.py` | 1 |
| `tests/e2e/test_browser.py` | 4 |
| `tests/e2e/test_case_workflow_browser.py` | 2 |
| `tests/e2e/test_clock.py` | 3 |
| `tests/e2e/test_contact_browser.py` | 2 |
| `tests/e2e/test_cookie_flow_browser.py` | 1 |
| `tests/e2e/test_cookie_preferences_browser.py` | 3 |
| `tests/e2e/test_credit_memos_browser.py` | 2 |
| `tests/e2e/test_delegated_oauth_browser.py` | 4 |
| `tests/e2e/test_live_checkout_browser.py` | 4 |
| `tests/e2e/test_lookups_browser.py` | 2 |
| `tests/e2e/test_mail_attachments_browser.py` | 1 |
| `tests/e2e/test_mail_browser.py` | 1 |
| `tests/e2e/test_oauth_csp_browser.py` | 2 |
| `tests/e2e/test_onboarding_browser.py` | 14 |
| `tests/e2e/test_paddle_overlay_browser.py` | 1 |
| `tests/e2e/test_project_billing_browser.py` | 1 |
| `tests/e2e/test_projects_browser.py` | 2 |
| `tests/e2e/test_proposal_sending_browser.py` | 1 |
| `tests/e2e/test_quoting_library_browser.py` | 3 |
| `tests/e2e/test_quoting_lookup_browser.py` | 1 |
| `tests/e2e/test_sending_browser.py` | 3 |
| `tests/e2e/test_sending_manual_followup_browser.py` | 1 |
| `tests/e2e/test_session_recovery_browser.py` | 1 |
| `tests/e2e/test_shared_auth_challenge.py` | 5 |
| `tests/e2e/test_subscription_browser.py` | 2 |
| `tests/e2e/test_time_import_browser.py` | 1 |
| `tests/e2e/test_timecard_local_clock.py` | 1 |
| `tests/e2e/test_timecard_selection.py` | 4 |
| `tests/e2e/test_ui_refresh_browser.py` | 6 |
| `tests/e2e/test_work_management.py` | 3 |
| `tests/e2e/test_workflow_feedback_browser.py` | 4 |
| `tests/integration/test_archiving.py` | 13 |
| `tests/integration/test_auth_get_sessions.py` | 6 |
| `tests/integration/test_auth_notice.py` | 9 |
| `tests/integration/test_case_lists.py` | 5 |
| `tests/integration/test_case_workflow.py` | 5 |
| `tests/integration/test_cases.py` | 18 |
| `tests/integration/test_cases_migration.py` | 2 |
| `tests/integration/test_contact.py` | 12 |
| `tests/integration/test_credit_memos.py` | 16 |
| `tests/integration/test_delegated_integration.py` | 7 |
| `tests/integration/test_email_start_retries.py` | 16 |
| `tests/integration/test_hardening.py` | 17 |
| `tests/integration/test_internal_jobs.py` | 2 |
| `tests/integration/test_library.py` | 9 |
| `tests/integration/test_live_billing.py` | 4 |
| `tests/integration/test_lookups.py` | 10 |
| `tests/integration/test_mail.py` | 15 |
| `tests/integration/test_mail_attachments.py` | 12 |
| `tests/integration/test_mail_case_reference.py` | 3 |
| `tests/integration/test_migrations.py` | 3 |
| `tests/integration/test_oauth.py` | 1 |
| `tests/integration/test_onboarding_auth.py` | 27 |
| `tests/integration/test_optional_usage.py` | 4 |
| `tests/integration/test_privacy_preferences.py` | 10 |
| `tests/integration/test_project_attachments.py` | 7 |
| `tests/integration/test_project_attachments_migration.py` | 2 |
| `tests/integration/test_project_billing_routes.py` | 1 |
| `tests/integration/test_project_lifecycle_work.py` | 1 |
| `tests/integration/test_projects.py` | 12 |
| `tests/integration/test_proposal_sending.py` | 14 |
| `tests/integration/test_public_admission.py` | 31 |
| `tests/integration/test_quoting.py` | 15 |
| `tests/integration/test_quoting_routes.py` | 10 |
| `tests/integration/test_recovery_rehearsal.py` | 2 |
| `tests/integration/test_routes.py` | 6 |
| `tests/integration/test_save_feedback.py` | 5 |
| `tests/integration/test_sending_dispatch.py` | 12 |
| `tests/integration/test_sending_isolation.py` | 7 |
| `tests/integration/test_sending_manual_followup.py` | 5 |
| `tests/integration/test_sending_routes.py` | 6 |
| `tests/integration/test_session_recovery.py` | 1 |
| `tests/integration/test_social_auth.py` | 9 |
| `tests/integration/test_subscription_billing.py` | 25 |
| `tests/integration/test_subscription_capacity.py` | 15 |
| `tests/integration/test_subscription_domain.py` | 12 |
| `tests/integration/test_subscription_http.py` | 9 |
| `tests/integration/test_subscription_payments_http.py` | 10 |
| `tests/integration/test_subscription_retention.py` | 17 |
| `tests/integration/test_tenancy.py` | 8 |
| `tests/integration/test_tenancy_capacity.py` | 3 |
| `tests/integration/test_tenant_demo.py` | 1 |
| `tests/integration/test_time_commands.py` | 13 |
| `tests/integration/test_time_import_http.py` | 4 |
| `tests/integration/test_ui_refresh.py` | 6 |
| `tests/integration/test_usage_browser_flow.py` | 1 |
| `tests/integration/test_work_forms.py` | 2 |
| `tests/integration/test_workflow.py` | 8 |
| `tests/integration/test_workspace_operations.py` | 14 |
| `tests/test_project_billing.py` | 14 |
| `tests/test_project_billing_reports.py` | 2 |
| `tests/test_sending.py` | 21 |
| `tests/test_tenancy_config.py` | 8 |
| `tests/unit/test_archive_dates.py` | 8 |
| `tests/unit/test_bot_check.py` | 4 |
| `tests/unit/test_domain.py` | 8 |
| `tests/unit/test_email_auth.py` | 12 |
| `tests/unit/test_integration_contracts.py` | 10 |
| `tests/unit/test_invitation_template.py` | 3 |
| `tests/unit/test_library.py` | 9 |
| `tests/unit/test_live_templates.py` | 11 |
| `tests/unit/test_logging.py` | 4 |
| `tests/unit/test_onboarding_templates.py` | 25 |
| `tests/unit/test_paddle.py` | 30 |
| `tests/unit/test_paddle_templates.py` | 8 |
| `tests/unit/test_production_capabilities.py` | 11 |
| `tests/unit/test_proposal_sending.py` | 6 |
| `tests/unit/test_proposal_sending_transport.py` | 8 |
| `tests/unit/test_public_admission_proof.py` | 6 |
| `tests/unit/test_quoting.py` | 8 |
| `tests/unit/test_quoting_routes.py` | 7 |
| `tests/unit/test_retention.py` | 11 |
| `tests/unit/test_sending_templates.py` | 9 |
| `tests/unit/test_sending_transport.py` | 9 |
| `tests/unit/test_social_auth_proof.py` | 8 |
| `tests/unit/test_subscription_templates.py` | 8 |
| `tests/unit/test_subscriptions.py` | 7 |
| `tests/unit/test_templates.py` | 7 |
| `tests/unit/test_time_import.py` | 4 |

## All tracked source paths at snapshot

This manifest includes source/configuration/example/documentation assets tracked in Git only. It excludes ignored private governance, .env files, credentials, local databases, retained receipts, uploaded files and private artifacts. A file hash identifies source bytes; it is not a security verdict or an authorization.

| Path | Bytes | SHA-256 |
| --- | --- | --- |
| `.dockerignore` | 265 | `b77bc6e9de7081e00e50649ffa90084fe9f11e679cf00a31fa6aa3f25342b616` |
| `.env.example` | 2318 | `3bee36cc2391658fa7e58ec694cd1a42d0f72c17db65656c05e86ba9e255c7bb` |
| `.gitignore` | 355 | `4d1eb50795b2ae91bf132e52e3e4c3a154e65aa36025d824669f8cd791ffd59e` |
| `AGENTS.md` | 10083 | `1d7a72077e3bd5d7fe6b06ff25ef724c50ca799533bc3a236ee213dbc785dd8e` |
| `DESIGN_SPEC.md` | 105 | `1dcdc793794f85b6e1eb25da093bf34a2ef05f3a956f75b6f1f9abcf970a2d7e` |
| `Dockerfile` | 1110 | `3cf83750c019082d042b90c966e33b6c90676342c53fcdca8e557a55cfc5d18a` |
| `HOSTING.md` | 32981 | `5c7294ac001e5132c2d984dbdfeb9fcfa4f67867641b30edc476dad38fe8be0c` |
| `PROJECT_BRIEF.md` | 88 | `84c2261f536d103ccb66abee3170dc2dbd22c491de1fa89798f936bc2dc6e1bc` |
| `PROJECT_MAP.md` | 6075 | `76300940165d12405697f842f551bff902b8bf280c7fbef91d6194b98d7ec0d0` |
| `README.md` | 6397 | `24ac340a1e05de9fccdf19f85c69c4f52f707967ecfaad7825b41b9900121f65` |
| `alembic.ini` | 81 | `3b3710b419fc9ad123bed2f66c2339ef6950d80f19be4ea349da7252a65d6109` |
| `alembic/env.py` | 1389 | `77776dbcf4097173c6ffac8af501b6ef1fd69fed77dd1f217815c4eb564e7334` |
| `alembic/script.py.mako` | 336 | `8f879277ac6deaf82170914242d03b74088910182807ba3657fa746fc4e5f36d` |
| `alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py` | 9512 | `5546dbd4d323183823febd3ca212dd74e83b7d2081710cd2f5056d1648c72c88` |
| `alembic/versions/7e416c6444fe_baseline.py` | 17724 | `8570667b383600a021ec36cdab00f2a3851c50dc5aad8ec5d742fad45b91d0c7` |
| `alembic/versions/a10d45de891c_issued_status_guard.py` | 2317 | `96a89b00f181fbed439d78cce295958bf6be88033b39b9f40f1b26f9653bfcf2` |
| `alembic/versions/a82d43cf6120_project_workflow_and_agreements.py` | 3908 | `73649633d2736af6891f91024d3f61491b40d5e285ba16ba326f7c00efc4a0a9` |
| `alembic/versions/b07c9d621a30_pin_guard_schema.py` | 930 | `3d3412bd0df933a257df60ba61d1c0458a7d0dd8f21441aeb108414ed2eff7ab` |
| `alembic/versions/c41894d13cb7_project_commercial_metadata.py` | 2028 | `335cd2864120a186f11cbbce4e2906f2e1ab22f71edfb2013d0f354aa9f29bce` |
| `alembic/versions/c46f2f62a011_immutable_artifacts.py` | 4504 | `e101d2922ca2f5d842055548cf57ae49539763eb1433bb35af6a22a1f3645f55` |
| `alembic/versions/d3517d81ce20_contact_reservations.py` | 990 | `7642340c9545f651c410f986d11e93d973c0f71faded34a590ce0e5bbaf422d7` |
| `alembic/versions/d529b08f14a2_project_billing.py` | 14083 | `8cde2a842be37f6e2edeb2388398e5772b94335b2bc251a2d7e40a64799a54ad` |
| `alembic/versions/e3b42aea781a_parent_guards_and_sessions.py` | 3204 | `2514f05093a597f52a618b2141526e137755c5c728e32704b749ebfce97eedc4` |
| `alembic/versions/e640ab7230cd_case_identity_and_types.py` | 8560 | `6a50cd2b360207042a7f5c31c9326d89cb4318e20efdbd7f5cda78c19c5163fd` |
| `alembic/versions/e672c40fa912_cases_and_allocations.py` | 9693 | `c342d896866a8bf90e98f8c432050cb5979550ed3181137970fc326e223037a9` |
| `alembic/versions/f409a1ac1700_parent_lock_guards.py` | 2346 | `4cee6118c21cb895b9c1a183739ac1837e4ece5331af376c59255a68911c340a` |
| `alembic/versions/f710bc319ae2_mail_attachment_custody.py` | 3847 | `bac187ef38a608d5c794e8495e383c42dfb69ea8d6ea8645dd4a4f52baea2a7a` |
| `alembic/versions/ph2_001_credit_memos.py` | 6674 | `c8d79b29322e46bb5d68a04bfa6953e32fdb7526ca3aac4c6fc6db45c502dbf7` |
| `alembic/versions/ph2_002_time_commands.py` | 10349 | `2760dd9b1efc7a4bba705468d8915204bae2068c1a49ac681c60ff3b800b986c` |
| `alembic/versions/ph2_003_integrations.py` | 4445 | `aaca02a6e9db2e2515393e1ba12264574f305a1cbd332f8527f956958451360c` |
| `alembic/versions/ph3_001_subscriptions.py` | 3849 | `8a671d6355bd80b43239596e94fa94dc8f7ede7835e52d168a8a429498096d8a` |
| `alembic/versions/ph3_002_sandbox_billing.py` | 7851 | `ad8af64c3f14f8143d02dc9efe767ce68402639399166a22e916fa341e4cef09` |
| `alembic/versions/ph3_003_onboarding_auth.py` | 5521 | `8b4d28cf64781e7cd198f5769733f143ffe12d21186d08737d3962d92138a0d2` |
| `alembic/versions/ph3_004_sending.py` | 9470 | `e269d73e8a835f46987e4ea304a25f6b5bdb89bfa3eba0541a1ebb765debc24e` |
| `alembic/versions/ph3_005_public_admission.py` | 6258 | `59036e375d5875b42d8de8d134b71d5ed8ed7056df122b4f2ac6df4d272ea2bc` |
| `alembic/versions/ph3_006_quoting_library.py` | 30675 | `8a851a397894f99dedb11fa3a322346327ca22407f209ee3f6647d371b58bd38` |
| `app/__init__.py` | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| `app/admission.py` | 21225 | `0c1b63f9debbed17322fc79f529014f2cdd3834044949b6c0e7ecec3706a78b8` |
| `app/admission_models.py` | 2817 | `dc8149b178ca17241e5617b149a7e759618f4501b4f4fa3f37ac9ae929fa6d82` |
| `app/admission_operations.py` | 7687 | `c4656667849b9207031c31fcfd6108bed83e1ffcf820227dd60dda7f293fe01a` |
| `app/archive_routes.py` | 8196 | `decc12b7b9fe1b4f32d6de94e25765eea710bc274565e750674b930077055e43` |
| `app/archiving.py` | 5283 | `0619d8426e1a0cb5704f7bf4a3f90d9e29e6d3878fa724135ed2ed6c667a2819` |
| `app/audit.py` | 481 | `a46e464b8db010fd3ef47b7d931b99744ced06a6c15e356d074a77eb9806d5a8` |
| `app/auth.py` | 5267 | `580faa0592f9be8133db78a3e18eb7227838a3e99813b8f55a88eec2c498941b` |
| `app/billing.py` | 29106 | `c70adb6b9f4fd6061c71cd4c071fba90ca043e11a61f86f11718de9b22e0de3b` |
| `app/bot_check.py` | 1494 | `2863beef71e5ac4791e71a3561aa8380acee689150a41c12f87a3a7765a45b2f` |
| `app/case_routes.py` | 19310 | `3482e058e94860334c1338845114e00ccb41f97f87d00ac3ca6ebf48923d27af` |
| `app/cases.py` | 8803 | `ed993cf946754b859f2c0205f8de5a81e92181538b966ba130601e0b8c0df0ec` |
| `app/cli.py` | 6216 | `120e5b1dddb256335bb8eb2336ce6bc45e4ed9855aac0de14c36c65366556db9` |
| `app/client_drafts.py` | 2356 | `c25a759c44732499616f26187c931b3e76af2831f8630a3474af979eb6ce900d` |
| `app/clients.py` | 11871 | `15febee8177eaaa372577dabfbe40efefdf44e8408406537f0b1a12a8487b4b7` |
| `app/config.py` | 13393 | `988fb2cc23e55bc4e9f310992a86d496dfa5f9a543609780591085e63a50446e` |
| `app/contact.py` | 9641 | `1a643a8dc3f1be76778d16d29fa4f8544072d2e111f423550dfd528d99b357f3` |
| `app/credit_memo_models.py` | 1447 | `19971f8d366cdab98e7ccd0fd44926c5b7b89b6061eda5d65a13eae88f1dddfe` |
| `app/db.py` | 1095 | `702d7da59da3394f4a61faadfe15bd37669d9f190768f476deb038b9e0a3529c` |
| `app/demo.py` | 5701 | `023bd11c1405d8918d5df51371ba1cf3c0de8dc5db65eea32d500d86043fca53` |
| `app/domain.py` | 2396 | `d63afdf63d9fd40f45426f2c88482f74185efc361225ad6ea195d8ae21dddb70` |
| `app/email_auth.py` | 8909 | `db24f443e5512f013277a3b075dd66d846cf1cf6988e4aa6b96f5b91ce642067` |
| `app/enrollment.py` | 9966 | `9e42373a0670371700bcc8b3d772b434406ff0cee01ac5145343f6b0529b9661` |
| `app/enrollment_models.py` | 2402 | `cc28a549353c52c5c0abbdbceb0db19c88bf4774ba2fddc5c20dd6f37a2a1c0d` |
| `app/enrollment_routes.py` | 36027 | `a3998de8ce63ad635412b853fc8667d8dae65947706ef076d81d5bd3d00cf0ff` |
| `app/forms.py` | 3413 | `291dbf5e2ef8b85f60614f3e45b5aa076d67f742155d0170e016b026accac56a` |
| `app/integration_auth.py` | 19111 | `954d534e609376db32270c4592e3da28824515e7104a12b719912effad2456c6` |
| `app/integration_models.py` | 3303 | `b34fd0f5ae069977ba78b800f18b7329b9a86ce420592d0a4bc17c4efff9766b` |
| `app/integration_routes.py` | 43426 | `9afdb5af1c39f8918a8300f8af045aedda74adc578ca712fa317cf563c75f9a4` |
| `app/internal_routes.py` | 7640 | `0026cb220069551bc71de14f20cd77931c7ae08443a7223c4efa4c196950eb05` |
| `app/library.py` | 25087 | `d1ca87bbf72daf0535463ae5beb9f0708edbfd4fd9471a22bc64da4ecd0598d7` |
| `app/library_models.py` | 3881 | `4bcdc8b03f8a55377a2faf305239ad5915c6ea863279b4adfac8a0fedb404fde` |
| `app/library_routes.py` | 10355 | `3735e5d4afda5f8543e67c35938308a05133f357f9781afe157e0bc54807d202` |
| `app/logging.py` | 3667 | `3d18cb7338c745f175a95901a58b0f7f329b8857dfc26d3f74e10665f4e9d676` |
| `app/lookups.py` | 5631 | `8c6e37c4b3f9b9e85ad695eac6ec8cdd0c6c088c9d98c6299bb4812eafeb43b6` |
| `app/mail_models.py` | 3468 | `4d340cebd629583f7992cf27588528bada1dbf452b661bfdef8980d800d70836` |
| `app/mail_routes.py` | 18773 | `f8cff75111ba75c739736fe3eb259f7cb40ea94c9a1a7bc1a51727edea8c2dbd` |
| `app/mail_service.py` | 12998 | `29f109c355d2e985a2e1ac97819b23e98443c2cd969cfcba73b9737bbbac71f1` |
| `app/main.py` | 69353 | `8bdc0362dc1ce6adfcf98c7001d210ce1f9ad012881bd44f0bdeba32957542a7` |
| `app/models.py` | 17814 | `4052bee0bbf4d8bc3acf6460692292b65f86636115f2b3418d70dc17bf83d0c5` |
| `app/paddle.py` | 26862 | `81d60d45b1b7a172ced8b663c67f1968f2129ad749610024603ec63d42d8ab48` |
| `app/pdf.py` | 1722 | `daff94ba6dd182472ecc7f37277cef2042d3433e0922cebc7cc7dcc74c25fda9` |
| `app/privacy.py` | 5073 | `11d50b154251250dd54a601713c34ccd86a9ea235aba38738989b5c232ade569` |
| `app/project_attachments.py` | 4084 | `ba5e96917ba2bed7b6dd84dc2791405ba26d18faf411f1db211ce34135b045bc` |
| `app/project_billing_routes.py` | 3899 | `92d5f010816c34addaaad86861267c93760b515686e4bb1a14f1871d4d661bcb` |
| `app/project_routes.py` | 12834 | `66e25893df3b2fba748a89c1eeb837d68fc88aa408f43b54c9d468a9a7dfd978` |
| `app/project_terms.py` | 2507 | `afca055671b6d0459ecfd931b078fb5eddb78efe10568d0bf2d15d5a270df107` |
| `app/proposal_sending.py` | 14038 | `94ac19640ae6be7c51150ccd3d09714f54ae75b05019dc428f1b7a935b0de672` |
| `app/proposal_sending_models.py` | 3364 | `78a724d0ecfc1db0ce5ad8b333680ae0bdbe5ad64c1b38e5b5df74bbd82c0d41` |
| `app/proposal_sending_routes.py` | 6821 | `155ee75729c94af2fb5e31aeeb1e3e76e48c5796dadf9fae9ff3cbb8a6b9f862` |
| `app/proposal_sending_transport.py` | 6006 | `46bb13a7e8d59a19ced5ac8c95b032449b070125f783d339a3339085be55d89b` |
| `app/quoting.py` | 19866 | `861d71c6ffe1a5cc79f27a0411d76a43460ee6fba15cc683c721919547cc7a50` |
| `app/quoting_models.py` | 5789 | `75d77ee63007a0b1af95016b40567c97761ab2aeccc8ceff4ce46698b52d754f` |
| `app/quoting_routes.py` | 13196 | `1b26db9b39d146092c3be1fd4611d379a561c7aa53601b91bf9fa925234faede` |
| `app/reports.py` | 9474 | `46e8831f7fe5735887400671f306c603d716eb144f3100d4e4ec24634b470de8` |
| `app/repositories.py` | 1852 | `0e05eb29a0a02eadf00026a8722d7a92fa520c6963b73c5f2f1bc9bcb4b9f643` |
| `app/seed.py` | 3909 | `d053ae7e8fcf45c815697ecd63df72e9e5a824f33b093890709158e155f43ff3` |
| `app/sending.py` | 26196 | `ae9806a2c8bdbfab15ab705e10f2335f246e56234084abfa4f6d4510bd981c43` |
| `app/sending_dispatch_routes.py` | 3214 | `10e6ca799e17cb6f3acc8fe474f21159c262e3987664cdb18fe13ac5a3a544aa` |
| `app/sending_models.py` | 3659 | `5e2540ac381f7f85016700bab1639187f86609a342f4c3ba62d8f519a7f738b7` |
| `app/sending_routes.py` | 8340 | `e8ef353638514116996be292bbf61ce47b48d5cd4f675d4b3849122381b308a3` |
| `app/sending_transport.py` | 5223 | `87566951cfe2a1a38bf78650b4322281a9d3fc579293264fa276c8815bc6a74f` |
| `app/settings.py` | 5802 | `dfa56091411ade3994148274614b7ae06b13d47cf07dfbef85a85f9bd95d0f54` |
| `app/social_auth.py` | 3159 | `16ca8368511d60857cd3ca928b469d996f52fa0a1a28fea463df1794a1dbbbc9` |
| `app/subscription_billing.py` | 70020 | `f43f87e256c4beca57a47334a910c5af64903495dc07204d5a9cc1bb3265670b` |
| `app/subscription_billing_models.py` | 4422 | `6d7e872cb2c38646c8eaea8859c0da4412a6bed26ea20d96ab91d6f1e6cbce58` |
| `app/subscription_models.py` | 2089 | `3a04dfbdcaf1922272d72ac788ef2179160156962dfb64402a40fdcac9501743` |
| `app/subscription_payment_routes.py` | 20001 | `a66dd4e3f88a242d7c85a8e2cb9e110f99cd1f43ade1f2cb00dc50029dbef3c0` |
| `app/subscription_routes.py` | 6450 | `122a1bdd40a236c8fbea7d52732291e1f51a895e8f1d4fe6afe29dcffb89920f` |
| `app/subscriptions.py` | 16038 | `59ea3a0bedfe2b4994ccad8d23f18a7259ee964e8b1ab227cf1fd0aa866a31c8` |
| `app/tenancy.py` | 23367 | `9a6a3b04135dc157fb035336ba9fc561aaee58b3a9611c1e425e5bc45c7eaa1d` |
| `app/tenant_demo.py` | 8889 | `8069d1a8f9d5e594e6bb897e9308414930201a2b9fc6f546e64d471347024601` |
| `app/time_command_models.py` | 2777 | `5d19880baee473007d13ac2b7e26f390be645bb532efe82adca7310a598a8ddb` |
| `app/time_commands.py` | 25927 | `7fc1e2862a8395717e4455f8d62e891350716e2af2b6d330de0440b8f2b9a8f3` |
| `app/time_import.py` | 9214 | `b995c8dfdce546fb1a8a245bbdbf3646e823b88dde9c66d8613cdf0e9dbc2ece` |
| `app/time_import_routes.py` | 13642 | `7007db8a0a654b83b3b45c028e70c80d0acb9dec557173f538a3f9d0bf7c16c7` |
| `app/timecards.py` | 8685 | `cf87dd236436ba548f447a8cf4800afe0120e88e8678496662c1a8c6bf8ec2c8` |
| `app/usage.py` | 2862 | `22d85b100c90de845ea1ed37dcf76209c1899d62836e0458030c5d2a3483eae0` |
| `app/web/static/AEKR-BANNER-LICENSE.txt` | 1377 | `b249deb3a468f304b956702f1b850666a08d5b883eb53b536cf15adae3af5703` |
| `app/web/static/AEKR-FOOTER-LICENSE.txt` | 745 | `6c0984d9a671a761730ad8157b5f9072053963f904feb4807c9e5e17d944f506` |
| `app/web/static/HTMX_LICENSE` | 655 | `126cfb5670a927207a43f0387ce4cb5f853337116c39a18b02cb8198403d471e` |
| `app/web/static/aekr-banner.png` | 1006315 | `81a60d8e3d28b2e0934cecd22c703af20e2bddd164f68a0888193647c1b816fc` |
| `app/web/static/aekr-mark.svg` | 1139 | `e6adbcafa4a1ad203c41303876588da23bf1c3e54a5e9b841088fbc9b2727b74` |
| `app/web/static/app.css` | 39857 | `8b4fe0ed0ddd46e3809f2afa2a3b926abd78c6c76cf9610a58ce2fbebb4ecb81` |
| `app/web/static/app.js` | 25674 | `bd408e2898d1d3ad7d06446c5564f19f90e814659168d80d4c4791e6aab85578` |
| `app/web/static/auth_challenge.js` | 2650 | `b0ee593f195a693d19c57bfd2df99d579e13103980e13994d50ca3e40ba3bcf1` |
| `app/web/static/contact.js` | 2551 | `419e8c8bdd2159cc76f44752c64a0d90f2a9ea7a8f6066eb33b323e514b1ad69` |
| `app/web/static/favicon.svg` | 264 | `dbfbdd7496e12575e50310ae8aea14eca03e51884da18d66a45125b5527bb895` |
| `app/web/static/github-invertocat.svg` | 1313 | `b5e2f4b3f953f075de7016faa952d6ce3ec7492aa7b32408505ec25857962d89` |
| `app/web/static/google-g.png` | 33661 | `d1ce9c2af0b10a7333abc99bc706f9a6a199e5b65bf3e3009624f076b8638e6a` |
| `app/web/static/google-sans-OFL.txt` | 4396 | `0d6194f5ba9661c627db09279762e664e78d3970f8c2c1dc7696257e542f62c5` |
| `app/web/static/google-sans-medium.ttf` | 4632 | `8ed4ae383dd28799a8b141eebaa16277e9c3b174fbf93728437b87bd15b25dbd` |
| `app/web/static/htmx.min.js` | 51250 | `22283ef68cb7545914f0a88a1bdedc7256a703d1d580c1d255217d0a50d31313` |
| `app/web/static/paddle_checkout.css` | 859 | `72400de6d05511eee436436f8603f44d925ee84c4beca409e76c858afee74a40` |
| `app/web/static/paddle_checkout.js` | 2746 | `af409ab0d037a4a6f1b82655abcc0c82389f12b9050218eab11857ef9e6904bb` |
| `app/web/static/usage.js` | 2970 | `63bf9cd2e1016b15f318ebc7441165b537f0805e9023fbcdb788670eb5e1a6da` |
| `app/web/static/wordmark-monochrome.svg` | 547 | `f1f20a3add773a417e96950435c02eae8c35ae671e60b5d00aa1e7cef86d9277` |
| `app/web/static/wordmark.svg` | 547 | `559cac515e74f6091efb06a3bd4bd145a0d1c87bdf2f33c8ce651a69419d9698` |
| `app/web/templates/account_security.html` | 4533 | `86a32b0ab95ec874a96540361a5c0ce9b98ad1889e4aa1e576cbd50774a5ae50` |
| `app/web/templates/archive.html` | 4509 | `2eaf043d4eed487514b22c70872ca0ddc3626724fe9cd89eadc4be03be086526` |
| `app/web/templates/archived_timecard.html` | 377 | `655930e567de82515af47091b07092b2e62ee4247d5b054f0a24a865fd8aec49` |
| `app/web/templates/assistant_connection_guide.html` | 6974 | `701bc842f26c37c71520e73f32f218cc4dbd3facf6af9667643213745a7403d6` |
| `app/web/templates/audit.html` | 854 | `deb11215a78e2e85dd6c42e906555a623f11831239b0de6f33d3a6db4d23ce96` |
| `app/web/templates/auth_challenge.html` | 537 | `b6e66d0d3683fd4f2a40a5f0418b9debbfc79cd298044a84d36f67a43b3e277d` |
| `app/web/templates/auth_layout.html` | 1137 | `deb965364532a74fa8c2bea8a5eb86cf5108924666746b78d877e8a12821d15d` |
| `app/web/templates/auth_methods.html` | 3145 | `0828303ecd09586d388d5f7d3ac7f6b056598cd049c7316e6d7a459caa426020` |
| `app/web/templates/auth_notice.html` | 458 | `b7c324fe8fe015c376ae0cedde72dc2bc012b10a9602cdb233cc96963990d695` |
| `app/web/templates/auth_notice_fields.html` | 129 | `6b1e0c063294e046adcbde8be9f85ad19421cbbd21e812c33b3656a96eb7e405` |
| `app/web/templates/auth_provider_button.html` | 371 | `641ee52c2665e25ac3684f80e789497cdba0806ad27ad4ed63da5c8f3bd9d2cf` |
| `app/web/templates/auth_provider_forms.html` | 892 | `02e49bd36fe0b3211ed50eacb0adeace049f40a19d74fa904f55dda509557d1a` |
| `app/web/templates/base.html` | 4470 | `32eb2a32c0b265676bc8b1c6ae0ea49499e7ef91551860ceac72e4bd3dc8039d` |
| `app/web/templates/billing.html` | 4478 | `ffda712f70e6cd91263a8f5d98a5ad62d4838c381b0dac43435565907a234c7a` |
| `app/web/templates/capacity_prompt.html` | 2143 | `7045f8dff4e889993bf1bd4a7683090e8c937562492a8bb3180c7e022f078f29` |
| `app/web/templates/case_allocations.html` | 2264 | `f2f76dfae3bd913f75cf3c8ef0f5cb9fe95c7e9d9ad1a7d5d2803788a6e05ab9` |
| `app/web/templates/case_detail.html` | 3137 | `b03bbd82ea9fd0c8c50a707fa61fa9f10295eaacdfab46df12fa1d9a746fff71` |
| `app/web/templates/case_form.html` | 3475 | `a68d72af97821dd725e9d28bf233ce0e12d1d5bf680b50f3d8541cc0486653f4` |
| `app/web/templates/cases.html` | 3591 | `4cfdd82ab30e97f8bc4c76ac6d8baf9d9692c4f74b9cf2b7d470a8c23b38047e` |
| `app/web/templates/client_detail.html` | 5428 | `63f2fa9daca8de23f7eb100e28b177553a435c95279117967f82715c30555642` |
| `app/web/templates/client_drafts.html` | 844 | `231fcb25ed16f59ce3e60ab4243f4fcac6005a2d177c7666aa44670059ebd6f3` |
| `app/web/templates/client_form.html` | 2582 | `a0e4f0dac7b68e3a27f6ec45b2ffed0985c7621a78ef24b7c072151fc5f56b1b` |
| `app/web/templates/clients.html` | 2346 | `dcc5ab2d98da9d0b2b03cda61c228d6ba1d4171a0ce9fa1e98b667042be26c67` |
| `app/web/templates/clock.html` | 905 | `39a5bec237e823308d4f494a6c9157005b09021cd71aea79e83584e3f1d69061` |
| `app/web/templates/components.html` | 4833 | `e2962591f9b0c6da18042453477703b6d4ca7f8625c0723f3b777b0f1aa5c9b4` |
| `app/web/templates/contact_form.html` | 1765 | `8e4c4a5a5b83eaa02191cbe9a21a4eae5f4c92da762be6e0f3e7713e28566791` |
| `app/web/templates/cookie_preferences.html` | 3044 | `3bf524b03c5c49e8e73e0b69220ac720b9bc22aa4862777dca744ebf53618f4a` |
| `app/web/templates/credit_memo.html` | 1069 | `8a3096495b6d972dc7a53a6714807bdda3cb5a04df39663960e5d5474347932c` |
| `app/web/templates/credit_memo_pdf.html` | 3187 | `89fbf822508336ac9bfa52fefcf35a0c0d9f0825e2d526f53a10f31f60bfd157` |
| `app/web/templates/dashboard.html` | 2936 | `fbb69dd64b800ab2df4f6ac9e22ff780dec1dfb2efdd968b0f9fa07eb33c827f` |
| `app/web/templates/email/invitation.html` | 3800 | `34aa22cec3c776c9840b25f945c47f981d7450e6c294b6fd0984c5a7814dafd6` |
| `app/web/templates/error.html` | 875 | `e33ab1435d3ec52a6a48f6dd982d6032c46c9c87381fe9b1dac151e1f1aaeae7` |
| `app/web/templates/help.html` | 19170 | `228da1265fe69444f2bb5e1bb685fcfbc833f47ed4774c78b0aa03ceb6cfe043` |
| `app/web/templates/invoice.html` | 7156 | `5ec7e0b41bf074cd1890f7beae9cdf94c904e863298e46b302745870f0745723` |
| `app/web/templates/landing.html` | 2655 | `75e26d07275e01bb3722acc28cea2d00d0c8566495f8c2ed6e81b2f99e7d3f4f` |
| `app/web/templates/landing_info.html` | 5242 | `7253492892d685bae97387a149b02572e88848974f76721a6354bd1314f4a005` |
| `app/web/templates/legal_policies.html` | 997 | `1edaa0dca643b7465b656eb0c154684ae0e2b8c00fcf0bc10033a189f00e66d4` |
| `app/web/templates/legal_policy_content.html` | 10609 | `cbb2833cef3159a63bb0864cedf864db55ab4c83ebc086c682d59d1dfc37a741` |
| `app/web/templates/library.html` | 2011 | `2cc4f7afbb13e1335c579c1e329f6b849f7c651cf70d2891f17ce965d6e48586` |
| `app/web/templates/library_document.html` | 6007 | `6507ff507ac22519c269b68f0492b337f1132b3a56bc2aad9311196d088194af` |
| `app/web/templates/library_document_pdf.html` | 1015 | `78f467d030c2647d19c846ea5d688ae467208eb743be4657c94ee39eeb55c934` |
| `app/web/templates/lookup.html` | 2950 | `913f862759903257929a9d3137dbaab9091a15ebb8c50946d260a27b4627f6de` |
| `app/web/templates/lookup_fragment.html` | 131 | `9293bc58c28ad53221b7d0df5dc06027936b6e2c51e68e713a30e1e73997adcb` |
| `app/web/templates/mail.html` | 2334 | `d74a6fbe24e5f9e9cec15cc8aa38b87b9926429c2c715fd7633a770bc0a1aff1` |
| `app/web/templates/mail_addresses.html` | 1583 | `01dfcada03278fa140617a66a47a58de0548ec7f981d91e3b862f05691346bdc` |
| `app/web/templates/mail_assignment.html` | 346 | `b4e78b1aa4ed02faad317533f03bd9a2ebf4e7c2af087e7e2143415d1ba1fbb3` |
| `app/web/templates/mail_detail.html` | 2443 | `156ab1c1a388b71999dd91ec3a3bee5d097f220bb843fdd72071106035cbe7e1` |
| `app/web/templates/mail_import.html` | 1638 | `1e3edee1a5a2a3602bd1e3550f8bde882431092aa89a54a8a629e13afd97c267` |
| `app/web/templates/navigation_icons.html` | 2458 | `443d2d9a727045f6a4a1b7ca4f779bde53006b02fa3fcb7076a81b1da2fff2c7` |
| `app/web/templates/privacy_controls.html` | 192 | `4a4007a01f0ef8bee3851d8dda5d8fe5a43f358b3e77dda83347af8be96bb44f` |
| `app/web/templates/project_billing.html` | 4846 | `9aa9e033f8b93181d2661ab176b0ffdb3d92f64839dfbe31a64a65708e051010` |
| `app/web/templates/project_form.html` | 6396 | `78555db7306f017648a2d89c5be7bd219658c77bf9d5341363475a7088b522e2` |
| `app/web/templates/projects.html` | 2712 | `c619b96b3169bb3ea676e37b14b568a733d31b84ed416d4c612d0c5c7275ad02` |
| `app/web/templates/proposal_sending.html` | 1231 | `0197288db2beeb47e5c13c01cfe73505d662e765c2db579af6f91d14cb52a489` |
| `app/web/templates/proposal_sending_prepare.html` | 1614 | `d5014fb114a3845d7553426adfef5eebac2eab34b747f0025528643f18867d7c` |
| `app/web/templates/proposal_sending_readiness.html` | 237 | `ff66bd0775aad025b04c9b9265b6dca8e3cf9e0e1b04ac86e80f8447aabb7318` |
| `app/web/templates/proposal_sending_review.html` | 4003 | `b5a0f98cfdef236e7479b04ab0e10bad5957fce2b4b43f452f3ffe5494208ef9` |
| `app/web/templates/public_plans.html` | 3190 | `34bfd06dd5bcaef0f590416eb0ecb16f904bba5344ca58ccd208045510b31fe3` |
| `app/web/templates/quote_detail.html` | 4402 | `993f3f2cf9b45e6e56ab77f6e8ad0db9cefefe6dcb021569314c577653994953` |
| `app/web/templates/quote_form.html` | 4454 | `8f36b94b9e7d35085448f5515f4231f3e25a419edace223987d6ea56300d0a54` |
| `app/web/templates/quote_pdf.html` | 2513 | `b60782825fc9747bf8140db565388599277dafb7718eaa4dd20660142d53974d` |
| `app/web/templates/quoting.html` | 3954 | `b3e4f587cb354827787361bef68a17a11a5125fac473e12c8fd8859c02b66392` |
| `app/web/templates/registration.html` | 4060 | `376ee84d4ce4f3163d5ca88303a3fae3669bab04d4365541a60c6e7753331629` |
| `app/web/templates/reports.html` | 1617 | `8fbc93e8cbfea2851dc1208189694dc08808d9b9da3249e7fd24b1ee4c83f197` |
| `app/web/templates/sending.html` | 7751 | `b04bcb544265f431c29d908212779d724c62ae7e31679503c5f344d32d528ed2` |
| `app/web/templates/sending_followup_review.html` | 1840 | `da065e3a93e84443cd2cc7f51a63f3f5eb67b8f27a7a061535e6b2d67f69bfa5` |
| `app/web/templates/sending_prepare.html` | 3035 | `4ba65b52f6357e9509ddbcc774079188174161fff007e846a469c28a524e7ba1` |
| `app/web/templates/sending_readiness.html` | 562 | `aa7c4bf4a69c9eb27c077352e6ec9dffdacc543a55145f7f3e29fb366e9241d3` |
| `app/web/templates/sending_review.html` | 2320 | `4649d87acc649b12b7cd8c1cfaef81a925f1ce2a12c74c278657a3671822b74c` |
| `app/web/templates/settings.html` | 6017 | `e83b3b59a61f98ceac1c71107258d19d1024d72358a848e19781ee9d604efacc` |
| `app/web/templates/settings_integrations.html` | 2748 | `b25f804dc0e128dc02509f689ab363ea6fa2fd339a682f1b0a1554926fe0a167` |
| `app/web/templates/sign_in.html` | 571 | `2ecf58d8e8b8e8d1a3442c5ac668279fc9b72babe86651de7bce51cbeb482cf7` |
| `app/web/templates/sign_up.html` | 721 | `6e8319bf937c48fb665f430d0453d4dd4053231e4efbbd4c02bb3f35b0fd45f7` |
| `app/web/templates/statement.html` | 4509 | `29f3c2d0726f07b0726df89d704f4b7f15aa3a519c6053dc7c9eac79025d3c8d` |
| `app/web/templates/subscription.html` | 6736 | `06f9b3e1e16c0ebb72642e64bc0177a1df7148c3d1b218fcd8cc742ac707d09b` |
| `app/web/templates/subscription_account.html` | 11437 | `8b4f127fac864a1881ea76f85a86260d6918f1bc6e73f3f9efcdd6288e42ae57` |
| `app/web/templates/subscription_change_review.html` | 3620 | `c7ddacc6a8276dff8a8be395dc7f7a5bcff72883e63ee95bee8c88f915c1e218` |
| `app/web/templates/subscription_checkout.html` | 3563 | `c18718d308e2dfe11e81c10790830976057ad006b76ec6e5075a1741dfa1872a` |
| `app/web/templates/subscription_command.html` | 419 | `9d1c310eb60635c31c0f224d91324f0e06c42237b31bbac6c639195f479955dc` |
| `app/web/templates/subscription_payment_controls.html` | 3096 | `92ebbd82d0385822d2b5db34eaf030b3076b99a7aba76670cd571d716767170f` |
| `app/web/templates/subscription_portal.html` | 1282 | `63d0a47c1ed9315b8751fa0b02d3ad40d37080a5accfc6cc5f6bf738f72514ad` |
| `app/web/templates/subscription_retention_review.html` | 3588 | `da6c4b2e1d7b70093b21a0111e0c868c075edab22bcb0e7d729343e941d384eb` |
| `app/web/templates/time_import.html` | 7397 | `8185dc0259321855d5b264cacf19229568364e6b70ff68874697c423c974a4f3` |
| `app/web/templates/timecards.html` | 7001 | `bf4d00f117d28955653c7adc254ac6b11330449ff239da08e11e539d61ea3f4c` |
| `app/workspace_operations.py` | 20129 | `9e6c6030e5ca6a366b8f04d4f30d23b1fe5382df0a80073181c69767191defc2` |
| `assets/AEKR-BANNER-LICENSE.txt` | 1377 | `b249deb3a468f304b956702f1b850666a08d5b883eb53b536cf15adae3af5703` |
| `assets/aekr-banner.png` | 1006315 | `81a60d8e3d28b2e0934cecd22c703af20e2bddd164f68a0888193647c1b816fc` |
| `compose.demo.yaml` | 1141 | `5928622b2129b37659b3b5a92e0063453afc9efae6653c6a0cb14d65910cf3ff` |
| `compose.yaml` | 1104 | `3e1999404ed732dc821badd87aee1cbebd0826ac4abc71bc7e93dbd004b1a22a` |
| `deploy/cloudflare/FOOTER_RELEASE.md` | 1523 | `eea548b12b7e397b83e48c41b684d1ffbd3688fe511edafd005b8f26b5f66887` |
| `deploy/cloudflare/README.md` | 6227 | `3e897947cde72f2a23a95b374ee21e35db0246f3d9abe37ab1d83f750a26a2ce` |
| `deploy/cloudflare/STAGE_RELEASE.md` | 26089 | `17e281a62fe2da1f092015363a2c878fb9337c770f1175725bb34af8c3f3e95c` |
| `deploy/cloudflare/VERIFICATION.md` | 1468 | `b2b54576c703b4fd1778a7c8f019bfb46486e65a833682fcff2c7208746e546d` |
| `deploy/cloudflare/package-lock.json` | 65950 | `d38f58d45749157bda291534887be349f0de563497d1746f3973475eee9604f9` |
| `deploy/cloudflare/package.json` | 543 | `a7f3c84c1b3459c76546be02ea683c7f60d034615ae77db97d83a9bba18e692d` |
| `deploy/cloudflare/src/contact.ts` | 3599 | `2ec19fa5f750418b04b0d4823d51dc99dabc87274285dc45a51e0d9ce8a30eba` |
| `deploy/cloudflare/src/index.ts` | 2906 | `a301331be5a7b6a7a6bf7302908f4ebe5f77fb62aeb25b608936387516910014` |
| `deploy/cloudflare/src/internal.ts` | 2868 | `3daceccc63d698d19fa847998384ddae9ee6465b4bb656d238794a1497f15ad2` |
| `deploy/cloudflare/src/production-proxy.ts` | 6166 | `e80a529a383c6c56ac468c67c81fd4ab3aefe274d20f458e68ad46c9476943fa` |
| `deploy/cloudflare/src/production.ts` | 3592 | `1b92a1024b3111fd9f0c1da3d5c5facf7a3551154cfdd54d981e5dcab1992d81` |
| `deploy/cloudflare/src/proxy.ts` | 21248 | `6347729be81eea2ad256ac6869a2a0a054f42fd6dab8828c5b41aea4b5b6ee98` |
| `deploy/cloudflare/test/contact.test.mjs` | 4161 | `431a092817e2f291b4fd9138b8bfe8d4fc05cc8392a15a18c03061ceb8de32a2` |
| `deploy/cloudflare/test/internal.test.mjs` | 2079 | `5c69d1a045a368c32918600d108ba5f4a1c9c33a20a831c9979b6475d75b4112` |
| `deploy/cloudflare/test/paddle.test.mjs` | 9277 | `d68625342cede433525eb4faf54b2e2ae4dbea2c6059539bc4923e2a2f4300fd` |
| `deploy/cloudflare/test/production.test.mjs` | 10011 | `4fdf2dd51f69cf0c67034968e6dccf03440166b97eb4af2566ffd73619231d37` |
| `deploy/cloudflare/test/proxy.test.mjs` | 23350 | `f18f8671a5495b36594f5518954ab3f8e3e9f880bfe8a79cf86b87d26eeb654c` |
| `deploy/cloudflare/test/sending.test.mjs` | 1470 | `9c22661bd0cb7525faa6f26fd3d3b649a7cd4bdb93475aa3f3c8f049dbc5afb7` |
| `deploy/cloudflare/tsconfig.json` | 372 | `35be468245d9e9ad995b8dccc54e347a0b416673dfbc21a3a75c0c8487d0e89a` |
| `deploy/cloudflare/worker-configuration.d.ts` | 627843 | `a5e3eadefbbc50d2504265f7ac55095c4a9ed658e1a1776de4bab973ce065518` |
| `deploy/cloudflare/worker-production-configuration.d.ts` | 3569 | `fe5d0731a189cc12ab29b443429eb21e2572e86cbece2705bf159e3863811e31` |
| `deploy/cloudflare/wrangler.jsonc` | 3156 | `774c46056dab973c7999d6625538d1e4091b26cf41549f1cd09f0ccbc6eead92` |
| `deploy/cloudflare/wrangler.production.jsonc` | 2988 | `ac82ed503a760144ae841b54a7e53d2880af1e82faa2f28f8c2e2dba28c0c674` |
| `deploy/postgres/README.md` | 7591 | `72f54bbd99ebd3ae9a61c455fd38bbcef3a435cd31aece8d09df1c62e86b3350` |
| `deploy/postgres/supabase-ca.crt` | 1390 | `1dcaafbf6fda7f21e34ff35825c1a1354408ea11e5839157e690af851c73453a` |
| `deploy/supabase/stage-auth-code.html` | 1635 | `3f89a005f7cd35516541bcc14d3f736e50b2155705b6ecd5adc131a68f1937f9` |
| `deploy/supabase/stage-auth-invitation.html` | 2047 | `75c6274020fa2744f4f62977b53db875473d53dde4e266bcd77ae1e911bd0d6b` |
| `docs/ARCHITECTURE.md` | 7550 | `00559e74bd63e0f52b05ecef4b0c7d03a6eb698b5d4ebba9c191f09fdbd38ee7` |
| `docs/CONTACT.md` | 4831 | `91f2658bacea8e2ab0005ef8a6aaa39f0e75bafaf3b6be27bf0d0ea76a23b5d6` |
| `docs/DECISIONS.md` | 71275 | `dd96123890dcb5bc8579e11b6a21a7b7c530f67ebdeb7de6ac1da38ef6fdf75a` |
| `docs/DEPLOYMENT.md` | 28306 | `be36487a2d5286947bf99eb7320a32481f8e02fcfebc211c0927f90a6109114a` |
| `docs/MAIL.md` | 5612 | `d863a3116bca8105a034399daf305eeb0e471f31cab7069357191f7dea1e196f` |
| `docs/OPERATIONS.md` | 56423 | `c332782cf6499981471236c8d92e2829827e903f2ef1719c70ee246c5ff23c8f` |
| `docs/PROJECT_BRIEF.md` | 27004 | `15747868c8fb9e36e7a98d21e9d82052428c8bc1d13de623822345d77b34d13c` |
| `docs/SECURITY.md` | 6206 | `d17593256bfb616ef3f7d0b7b40cfb57b8bf8accbc3bfb8509513e90f87686a0` |
| `docs/STATUS.md` | 51724 | `bcf460e32dbe761518a0ef4fccf8aaaa05f3711ae142b6549e023b73fa29a416` |
| `docs/contracts/ALCO_CONTRACT_SOURCE_NOTES.md` | 3769 | `e186d9c2ba0396096560b29bdde3d703d35c88eedfe43da6c304a7f32bca4cfe` |
| `docs/design/DESIGN_SPEC.md` | 25797 | `f66c28019d1258b5f3e023067d20c1d72987d6f5731e1e0a1f29bba1085fb8ea` |
| `docs/design/EXPANSION_DISCOVERY.md` | 64042 | `0ddf620a9c419beae34090c1fb279785aab0379bf7f7e7724be6b3354faf84df` |
| `docs/design/reference/01_landing.png` | 1257131 | `f978f5cf3bcd3ef3303d7c48f7ba191c11cd079115953d850071e97d94ba39f5` |
| `docs/design/reference/02_clients.png` | 1551563 | `ea102adb3a0761627c5e6a960c479a59b2167b2de478267cfcdbf4f1be9d2cb8` |
| `docs/design/reference/03_timecards.png` | 1548579 | `24756269e8054f18bbe81630b42b7abd90886fd7183ae07e7353768c4e70f305` |
| `docs/design/reference/04_billing.png` | 1614190 | `1f84f651021f95149163afd31462954b62e008bfa907f0ec482731d0cad6615e` |
| `docs/design/reference/05_navigation.png` | 1206417 | `c947880b166e5af61fd0c5c78c6a7ba5b0c8db11037ffd1e0ed9871d4388cb08` |
| `docs/email/assets/timeker-wordmark.png` | 10064 | `e88115d67ba119e71f36ded17fae0ccbdcc8ba348210c4388afe7276c24b9f2f` |
| `docs/email/invitation-preview.html` | 16817 | `6eecffbeff2f8367dbd0a686fbcdedadc202722d6cc17491d12f29b991760d1c` |
| `docs/legal/AEKR_PRIVACY_BASELINE.md` | 17663 | `bf321eb4ac83a5bf7551a39a5281f46ec83365b5044fbc35ea405d512cb86e0c` |
| `docs/legal/COOKIE_PREFERENCES.md` | 11053 | `3e114829341c5e1899f6ddd7b15e00b082c711c70dce49390e7d0eab19927119` |
| `docs/legal/LANDING_COPY.md` | 15884 | `e2454d152d471c8b0c9c31d9f73b99be24a25174423136591fdc0f66dd620c26` |
| `docs/legal/PRIVACY_DISCOVERY.md` | 26511 | `c6a242bf83d4cd67ad82be398c4dd2bc5d4b1addcb3ff4a72829827f70873631` |
| `docs/optional-usage-implementation.md` | 9749 | `fbee22bba70be58010101396aa061382c00c15200c5500dd3466da6dc44e92f8` |
| `integrations/README.md` | 3922 | `4e64f12f43d9aa42ea28430d180b8b68c07803a51ecdcd14bbba97e1d5a0f61e` |
| `integrations/timeker-stage/assets/logo.svg` | 264 | `dbfbdd7496e12575e50310ae8aea14eca03e51884da18d66a45125b5527bb895` |
| `integrations/timeker-stage/mcp.json` | 755 | `740350da2c2e4907e30982c7ad7a0cd2f78bfe36533614c608a673e80da082c4` |
| `integrations/timeker-stage/plugin.json` | 1360 | `538b59b1149071a97e5139869191c37634634126065c525fbd330b4a8932e882` |
| `integrations/timeker-stage/skills/timeker/SKILL.md` | 3377 | `35474bc1f387264a5803cf92c1d08baeab0131d09e7074b5d292c8f81edda814` |
| `pyproject.toml` | 1494 | `c506d200c701e09d9222f9f545a3f3065cc68e12f3044ebde59b1c3b6561ca7e` |
| `scripts/dev.ps1` | 846 | `5f7e427d8938fbd93c878397235ffb1d93da90b538ebd3981c6a1c9715d5d5cb` |
| `scripts/mailbox-credential.ps1` | 1022 | `8ea369a6437147c3234623ed5979755ad6ddc51c3c9083ee331b81c77e43ff4e` |
| `scripts/postgres-demo-init.sql` | 227 | `5d6899892a69e7143c05e3160dea3dd37304e9e47dd85cef33160d3e1fcb2c05` |
| `scripts/postgres-init.sql` | 222 | `8935807978bc8a134f4d3217c9331b5e8f12dc9c8cf8bb9f0d89a507cfaaeda2` |
| `scripts/postgres-runtime-grants.sql` | 2589 | `72f56a3de4b95ef02f116645a6d88fed0df2a10df170e41cf4a3b55ff4d18f24` |
| `scripts/render_invitation.py` | 2702 | `a40e18aa97da3ea53566d4db18ab8ee6768beb35dd6f762a7aa6f8ffa35fab70` |
| `tests/conftest.py` | 3284 | `42ccdc44fd65f3897f16db611046713d8636dc828b4b168ed6d94b38dbf8df47` |
| `tests/e2e/AXE_LICENSE` | 16283 | `daccd6f5b8e0fd07c0992116280fcddc77c2a612c4ebeb64d8b114ed9da1a10b` |
| `tests/e2e/README.md` | 637 | `e0147846ca2bca614850837327ea876beb0049a9cabfd331e393bee72032252f` |
| `tests/e2e/axe.min.js` | 652151 | `ba9c5edf12647a66301ff4174e4f154fd9aadea4fc4871815f22be9b61922438` |
| `tests/e2e/conftest.py` | 3290 | `9b351cd7e133b0603f0ffd31421f7cf025e547fd7293c5cd903603e0dc628891` |
| `tests/e2e/test_archive_browser.py` | 5936 | `1ca811a00c90e07f6faa80c205d87709d3eeacdfd9ef598c95d5576f1f8a529c` |
| `tests/e2e/test_browser.py` | 8486 | `75b06faa68541fc1d116b9029f7a86c1c16ac85c5c3b3416509794b330277147` |
| `tests/e2e/test_case_workflow_browser.py` | 5106 | `8881e4d98d4fa058090470988ff56446834535c2c3767cbde347f982373423cc` |
| `tests/e2e/test_clock.py` | 3621 | `c9953115f70defbb624384a9fa8bcf65d7d97714ccf4caef7205cdbe35f14f4a` |
| `tests/e2e/test_contact_browser.py` | 2996 | `9c2521fd49c0f260718850719d0faf226e1c2cf341266b33efbefb40ab8cadca` |
| `tests/e2e/test_cookie_flow_browser.py` | 2132 | `3f213966d09694013db6cd7cd14e2776b21021b234b556709c9a04cf710f823e` |
| `tests/e2e/test_cookie_preferences_browser.py` | 8850 | `74a0310386553d2ae1c579392f44c58e6d409f68adac20b65542466ae79a0f2f` |
| `tests/e2e/test_credit_memos_browser.py` | 3322 | `c8a8455dfa12039a7b7e3943454409f134b063d145b2e77db3e2eea4e4758804` |
| `tests/e2e/test_delegated_oauth_browser.py` | 13641 | `5276cb565f53b498a5022f8930195d9064d893bb45bee3bb65aac8961ffa1590` |
| `tests/e2e/test_live_checkout_browser.py` | 18924 | `2e9000be66ecdebb32b45906d41d2f61643ed31078bc5fece4c90a1f0f66aae7` |
| `tests/e2e/test_lookups_browser.py` | 3937 | `fd1a9f23ba1011d6b97356fad3467ae6d8abcbbf0514377d0aeefcf4ece22a5e` |
| `tests/e2e/test_mail_attachments_browser.py` | 2422 | `c9a937b4b1d2ae473ac2c3fa2c105747ced5bead2dfa31971767e3f514c41d13` |
| `tests/e2e/test_mail_browser.py` | 3679 | `da0b918b3ce78bba64e03b29ee59c39808b97bcff5a7bc23453f91d316a416bc` |
| `tests/e2e/test_oauth_csp_browser.py` | 7400 | `45ebbf4a9f1ce8f8995543c5f7dbb77beeb80e8e3a8cbfe4797a52bc06d652bd` |
| `tests/e2e/test_onboarding_browser.py` | 39414 | `475d7386296161db45fbfca77b74d7f4f5d44d348633ab8f4dd70ddc9be33c72` |
| `tests/e2e/test_paddle_overlay_browser.py` | 7167 | `5bab02f45836c03be23da99d8d83843ce45b53c1a96e219d17a5c27c5c69c678` |
| `tests/e2e/test_project_billing_browser.py` | 3996 | `dc93b71a704b3e047802426b9e6e2986a2e1b2de24ec3fc3fa79516eab626cbe` |
| `tests/e2e/test_projects_browser.py` | 5665 | `178d72bf3f5832ac15c3797e9c932511f0431087566f5e62c87dc53b629fadee` |
| `tests/e2e/test_proposal_sending_browser.py` | 6963 | `410739046fb1f78072ee66b7b973e5ee535630aae7d6592c72e1668dab690c2f` |
| `tests/e2e/test_quoting_library_browser.py` | 13054 | `6f4c0914014fc5d508374794595e2816fc825ae5ceb0dafb82aa2ec76e82c517` |
| `tests/e2e/test_quoting_lookup_browser.py` | 1764 | `e9873ac5642c0dc1ab1dd4d0aeba6a255a16f76e01519ab4d6e3ada00d200afc` |
| `tests/e2e/test_sending_browser.py` | 7444 | `5d8886cba4f372c59d8dfd84ee58a6e56361918b2895f2749cb3f82f9efc5c8b` |
| `tests/e2e/test_sending_manual_followup_browser.py` | 3625 | `2ec4eb2f58a0fc12398373db2c41208a53eb188f65e4f51666ba65ebfd4ad4dc` |
| `tests/e2e/test_session_recovery_browser.py` | 732 | `ea3a8a56007fbe3990ce61b9e5e339cf006fd88edf2cf3fc45d6408b2b986239` |
| `tests/e2e/test_shared_auth_challenge.py` | 13821 | `3070337009d58af35cfd6dc9cdc0cdfd40bfcceebc780c889797a070bc589715` |
| `tests/e2e/test_subscription_browser.py` | 7282 | `535ae43d4fd473950707bff37ac68312cf371666503a334417da5216390cfd83` |
| `tests/e2e/test_time_import_browser.py` | 4991 | `081a5710effa4d7fc7a82c41a0f3a1ffb05428dea6624b9375696b3d479b1a11` |
| `tests/e2e/test_timecard_local_clock.py` | 3547 | `b91e3b9265827f02a32dbbaa732175b8e4fac01de38a72035910f0156a673566` |
| `tests/e2e/test_timecard_selection.py` | 5947 | `360f1bc53a19bbd972d0092ca098f2beff1d01cd6700de3b2f5291a005b9a35a` |
| `tests/e2e/test_ui_refresh_browser.py` | 11130 | `45e99de77319cfd414f45ea5a2179196aa1e31fd73be2fc078be1b015bd38f74` |
| `tests/e2e/test_work_management.py` | 8262 | `f060fe019cdeb665e86bd902b2a1a49d1fb0c4ad5bf37e6f2c552c8a991dd6d0` |
| `tests/e2e/test_workflow_feedback_browser.py` | 4468 | `17fafbb61d641622bd100ccbddb003a007e339ce264fcb7af2607bbdb3f290a7` |
| `tests/integration/test_archiving.py` | 15429 | `5cb854eddcce24a33906739911361e6fe6f0840488ff2aca5a6daef2fff12861` |
| `tests/integration/test_auth_get_sessions.py` | 12843 | `395010bd9eb7342aedbc89db6ba1522e7200a619ece322c881aa3e9cf0c43ead` |
| `tests/integration/test_auth_notice.py` | 17888 | `4a34d5b7e0e90a29bf9ee5f79faa2a010366c400c830de5b61244e19b1a20d43` |
| `tests/integration/test_case_lists.py` | 6997 | `af239a5c34fd570ba03b3982726801022a75147c93cf8e014ca673c4a5f379cf` |
| `tests/integration/test_case_workflow.py` | 5342 | `5a968e5a0c09e4294076837f910453bdc8e6ff3f22d564f19e1dc2668e073a6a` |
| `tests/integration/test_cases.py` | 24887 | `fddac8301cfe5ae42afe0ebb7f2a541167196ef0f4c39042397ee55727a536eb` |
| `tests/integration/test_cases_migration.py` | 4889 | `9d0a63aabeb9ca3f557f71f9f6f02a181cf666849244dd8ce6fc0001a0812d7d` |
| `tests/integration/test_contact.py` | 10687 | `35c3270e36d185c7d1021bb13434ab97f0fc13d92957fadfc13ef2c71e419e79` |
| `tests/integration/test_credit_memos.py` | 14892 | `e7a911fabbbfb2451364493b389689c1f00e82e67c168330075cfac0d7ba6953` |
| `tests/integration/test_delegated_integration.py` | 17144 | `3ad274718d52821f0ed1b537b1bed8207b81a47f5b5d45b72097ca7c010c1016` |
| `tests/integration/test_email_start_retries.py` | 25293 | `04ab05b32d03071a14ffb57fb7aae08cca0ef49b894c97955c36df54abd101a9` |
| `tests/integration/test_hardening.py` | 16574 | `7ce0cce909e3a1b306e5d45c5828ef2fc4f86609c3d440fd77f308504fa68869` |
| `tests/integration/test_internal_jobs.py` | 3242 | `6cf3c2b29a906c4986df0ea976dc7e95f7a9c792fe1d16c22a730a9176757114` |
| `tests/integration/test_library.py` | 12647 | `7528315ac96a5f5db58f3cacf83bcf1f97967a7b20c60256b5e10969bae9c238` |
| `tests/integration/test_live_billing.py` | 9601 | `5baf8d645dee9ba97261d10f4a265f0b257ac4239ab56beb365afcd0ae630e3d` |
| `tests/integration/test_lookups.py` | 7818 | `6e686aa452ac4766708accf489e36969a8acba9d87d299b73caea5dfa46f17a2` |
| `tests/integration/test_mail.py` | 16656 | `97fbeeec5db782d24b2fd42ca571ddb229cc5e60f95cca54d195fda6e1c0f399` |
| `tests/integration/test_mail_attachments.py` | 13364 | `32a1e7f347def64930d9cadf9031bad5c3dec07388f0427cc38e7dba839ea242` |
| `tests/integration/test_mail_case_reference.py` | 3197 | `eaf45678909da7347d6d77e766d478666778b7a7ef33abb1becd58bfce491f5b` |
| `tests/integration/test_migrations.py` | 5618 | `89eda570923fd87372e71271161752748712e9ef702fce89879c7b8be0b326fb` |
| `tests/integration/test_oauth.py` | 4321 | `22087f743f6a3f4465c16f39192159ed4b32c0283484a5c452e0c5228e6aa741` |
| `tests/integration/test_onboarding_auth.py` | 45831 | `20efab7f299b47c81b1150b45fb5719a4f885709ba5a90d34aba2f7cd0f04ed8` |
| `tests/integration/test_optional_usage.py` | 3696 | `ec25c09fcd87ad5e8cec45797b675c36161ae5a4a4436810687ad6a36475ee81` |
| `tests/integration/test_privacy_preferences.py` | 8397 | `f30bcfbc1469363d261cd0128d453c5809e1a71067c2e6a1543b0ad75bc93499` |
| `tests/integration/test_project_attachments.py` | 8757 | `54537e747fba8616d23f2b2cf0c3542b812b3599cc4effcb26940fb15f49eb41` |
| `tests/integration/test_project_attachments_migration.py` | 2332 | `678a70f9825c9408ae99898b02371de1665f39e77998e0c2cb695c56f9da4296` |
| `tests/integration/test_project_billing_routes.py` | 2324 | `3443c9caf81bf93e9c1b02886825971bcea463be88d6ba8b04603fdf018f190b` |
| `tests/integration/test_project_lifecycle_work.py` | 1704 | `610ec0e64995fb10d21da6783081d33e7bbe3c042f01ed59eeda184c9e881576` |
| `tests/integration/test_projects.py` | 13851 | `ef049ff40bdad16f44d145848a8e4c8f6f01078d93ada14c09f2784763ff55a3` |
| `tests/integration/test_proposal_sending.py` | 19303 | `fdee4c06178dc0957fab19816c6a3f4dcecd00ebe9f967f7bdd988522e128b43` |
| `tests/integration/test_public_admission.py` | 57063 | `a9555818900f38cb8c318673d75dcf2cdcac2d4485c5d61d37de9f04599ae5a6` |
| `tests/integration/test_quoting.py` | 14757 | `cfb9191fa9c1942a68f9479e93843889092aaf7b417b4195c3ca6fdc24990530` |
| `tests/integration/test_quoting_routes.py` | 8867 | `d4b671c30a8a6eaa8fd491fc39ac99728cc0024254f093639a652b5348b11253` |
| `tests/integration/test_recovery_rehearsal.py` | 22477 | `f1c4fc1d366183914a522664ccedd5b05d8af95e1c9e02f97c6a6e3911c2fa0e` |
| `tests/integration/test_routes.py` | 4283 | `f4ff8f9a60e3e2c1250083c5ad09d234c8f5be3c60f0f357a2dea12a27a53b59` |
| `tests/integration/test_save_feedback.py` | 5174 | `e74cf8d6cfbb5825515695537f33f85469947b3931c5f1d2698a10eb7d572568` |
| `tests/integration/test_sending_dispatch.py` | 18247 | `1075d4ddb8dfd5712381f1609f3619834eb6e521ea5feccbc6bd9f42a0eb1591` |
| `tests/integration/test_sending_isolation.py` | 14390 | `10aa24af85d504c00b3bf0cc622b42e04923b88635a506dc3d7dcb34cb24935d` |
| `tests/integration/test_sending_manual_followup.py` | 9365 | `193d82cebb3a6d7c18e5740ee686daf56cd029cededfb2684bc29619dbbcaa58` |
| `tests/integration/test_sending_routes.py` | 6869 | `108ece3b0295f7488d7b3b2e295eb66c0d1f6342b4142abfdd726c959d6874e3` |
| `tests/integration/test_session_recovery.py` | 856 | `fffe7ea2851bf157ab016cc2a6292a1e688d7413fd77f9d7eea92c46b5ec75df` |
| `tests/integration/test_social_auth.py` | 16440 | `0c44e8117be5e3f5c6c67e8a1600f8f1260199ec5398a62891640b1633d6f29e` |
| `tests/integration/test_subscription_billing.py` | 45553 | `f98817b452744f4b606fcece8ea36ffde49c46bcd9665114094771bdf7d00218` |
| `tests/integration/test_subscription_capacity.py` | 16978 | `27a3b828e6cea51ab1db28398ac26102b8380d7a766f3a83e62e255cf118999b` |
| `tests/integration/test_subscription_domain.py` | 12523 | `c9e60da17bba247bcb9fdfa35faf3fe9c55e5e9199a7e5d71b054af32101d0c0` |
| `tests/integration/test_subscription_http.py` | 11593 | `e3967f1561a7378c0c2256b4720abfd412a6b0cc16506f108189b28cc8883856` |
| `tests/integration/test_subscription_payments_http.py` | 16127 | `ccb3fe20de185e1af25c62cc1e45e795a6a4374725bb5043dae34c2bd40872ed` |
| `tests/integration/test_subscription_retention.py` | 27434 | `8623c85e0f78408791b1afe7678cbdf920f72b77de55d2afcbfc7f7c2d0514d6` |
| `tests/integration/test_tenancy.py` | 15686 | `a54e95d8a838044a30bcd05cf28134497dc5f1b1d78f0bb4e4ce4febbf0c1b69` |
| `tests/integration/test_tenancy_capacity.py` | 15157 | `fabc34d50cd1669ec4e6fe55012687ea9a82e84430fbd9dc93b0b54921182249` |
| `tests/integration/test_tenant_demo.py` | 4464 | `9bae9cd8b075719b09d926580e58382d43fe80ec91ca50aa1d2ff6886f4217d8` |
| `tests/integration/test_time_commands.py` | 19304 | `65fd5474b2b87fdbde27205d39e49bfe94b319d541306a8f0886e52a2a0e6ab2` |
| `tests/integration/test_time_import_http.py` | 8067 | `05d3c89df2f9e298705595862eaf52693cea2490618e53c65a747413209c52c2` |
| `tests/integration/test_ui_refresh.py` | 4778 | `c0618229b2c1b294bffa9a8b792f1f8fe89299361927d6b347cb09ea8706256f` |
| `tests/integration/test_usage_browser_flow.py` | 5972 | `9d7a68769cd78f6cd18ebe8ec690051a10f3a91209e3eb16f54a56aa270b1ab7` |
| `tests/integration/test_work_forms.py` | 2594 | `fac37c617ed10e1c29d5b71b965dfa1a86067c5cae76b067adbebca246d5c362` |
| `tests/integration/test_workflow.py` | 9533 | `e577487063642bc25f6f768dd5735c7cf7cb676e34812f8f8bdf5c66749e537d` |
| `tests/integration/test_workspace_operations.py` | 20053 | `6e3d83272a06ce20b8c9421999ce1070f14c297b4c671cc45e503eca076f9d21` |
| `tests/test_project_billing.py` | 14729 | `853494215915853ff887354e39ec047b911f1c12459c16b1a503ceb9c7e3ca4b` |
| `tests/test_project_billing_reports.py` | 4685 | `2938dab5146349adea0a7f4856f186c9c8d583a52e9fc82b86631109f61ffb4b` |
| `tests/test_sending.py` | 19831 | `a598938bf5f576bb63df2b6e5e07cef176e9a5f87ee0f65a620310898f38c77b` |
| `tests/test_tenancy_config.py` | 6597 | `76db624cba72396c2a781bd6783338abfe9f0a2a58b9eecd2c02fea6f1146f7e` |
| `tests/unit/__init__.py` | 82 | `92dcce4dd9d428604e749a05163c1c3489e7ed4319edea19067c0dc47b30987a` |
| `tests/unit/test_archive_dates.py` | 3078 | `66199f0b712e16dfefb8b96a3fec17e7c2fb227f97d915c623c67b3cc8f27a2f` |
| `tests/unit/test_bot_check.py` | 2865 | `2d183fe6ea2bc275e1ca569f8c9ca9565f16ac9ccdb9abdde2cd223345211dc7` |
| `tests/unit/test_domain.py` | 2082 | `8c6aa3ba05b8d990b26315964686138bf85479751f7aef4bc712075fb22fdb59` |
| `tests/unit/test_email_auth.py` | 9066 | `d83dbc98b3e589b68d2fb764e083613490a512a43a9a61f50d5a1ffc0061b197` |
| `tests/unit/test_integration_contracts.py` | 9359 | `a2e8d62d722802961ef7d12bbeb621f2c57070b8b3efa657038a6c18c5794ae0` |
| `tests/unit/test_invitation_template.py` | 1780 | `7229845a77abec602a822d638012e1a4c7bcb59c640ed58b321dae372a2fb684` |
| `tests/unit/test_library.py` | 5908 | `e1bc3606f6d179f0003e5bfca3a27bb65abf58c64f188228e28b76700fd1fd2e` |
| `tests/unit/test_live_templates.py` | 10786 | `8d443a9276cc626d3cf1e6a119f1e9d5e905e7362adafb18aa60449278d41c25` |
| `tests/unit/test_logging.py` | 2940 | `dfc10aa7f71812c3a819004c25db2308e9b42f3b752f679d1ce699245aba1f7d` |
| `tests/unit/test_onboarding_templates.py` | 27454 | `c8280132c261f99eb6d7d0262a4cecb669345e5df821a9ae9007c98dcfaa38f4` |
| `tests/unit/test_paddle.py` | 28481 | `e3d2ea3c03f67a84b8b305d7e7be3036b2985a67d9fae11c08a39841166ccad2` |
| `tests/unit/test_paddle_templates.py` | 10263 | `4772215f080857b4a74dce1b909e050611d4ef90561a84bd4e5e252d82a5dadb` |
| `tests/unit/test_production_capabilities.py` | 13802 | `36226071e7a5e8a36b19246e95350713e7563b6b3011bb6790e5c89650e1ed2b` |
| `tests/unit/test_proposal_sending.py` | 3718 | `16b06392ea4d854fc0842b6e15cb833573e312795d46c73a9e3cc1d4a9638b85` |
| `tests/unit/test_proposal_sending_transport.py` | 5818 | `292100edb54eead33012321dfba9a4dae98abf3ebb5976a4bea041ccae5650c7` |
| `tests/unit/test_public_admission_proof.py` | 3605 | `edf627e722d137b0298167f7a9584e78dd431805dc22dad026e7c4c7566c9124` |
| `tests/unit/test_quoting.py` | 4597 | `d88e22fdfcf7b8ef62d8c88bd5c4d8b137437e8e2bb67e6f1810b85e3a5d8d78` |
| `tests/unit/test_quoting_routes.py` | 2341 | `d355df7d268c71d6a88e3bfd876af4f0f8eee31723685cddc265ee1ffec2b0da` |
| `tests/unit/test_retention.py` | 13175 | `5fb40d6befed04ff8fc6098a9b0b163f0839b391a3f1fb5d36cd4d8097b1705b` |
| `tests/unit/test_sending_templates.py` | 7878 | `e4b87352f41ca8e22865d816ab418e3919b7eda0f8e5bae7ea47bceefcefe65a` |
| `tests/unit/test_sending_transport.py` | 7008 | `6ef6b22da8b697b86b4c42ceeca483eb7efd937029003798fc4f528c0e552e54` |
| `tests/unit/test_social_auth_proof.py` | 4612 | `5ad376191d1554e5a6c4c234d52a39f376573793eea450abd2ebd6b139a28fd6` |
| `tests/unit/test_subscription_templates.py` | 8704 | `052e9e07bbc8c406953b05014d75b95469d9c8172f9fd2df32eccdb8c9fa8345` |
| `tests/unit/test_subscriptions.py` | 3823 | `a7fffb8d85d4c207a7e2fed9229985193c65ce2e85082cf7112dd51bbe0b47a2` |
| `tests/unit/test_templates.py` | 7025 | `a566419f55fe27a9ccc354092b0fec509d26dc07b5bba17dfd67de28c634ec2c` |
| `tests/unit/test_time_import.py` | 4146 | `c56578aae99ac65c6291543d6f0a3f3a1ecf6c5919cbe9da217b79f1e27bc511` |
| `tests/usage-browser.mjs` | 6677 | `8c36561ff9b58bbd1371d0857e58cf478bd593b12d05172958e8944926f30ba9` |
| `uv.lock` | 297750 | `048be1b352509730adba10fe9e07e7d45a2128fbc055195afc122e02b4b20e8c` |
