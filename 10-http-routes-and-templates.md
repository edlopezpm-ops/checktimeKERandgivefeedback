# HTTP route and template inventory

Snapshot: 2026-10-16; Stage source-analysis commit `48e854ff2107dffb217dfe7c487b1b9d36a7f41d`.
Generated offline from tracked source. No application import, database connection, provider request, credential read or test execution occurred.
This is a dated review appendix, not a replacement for canonical contracts. Source pointers below refer to this commit.

## Extraction limits

This lists literal Python route decorators and local APIRouter prefixes. It is not a live OpenAPI export: environment gates, mounted static files, generated MCP tools and middleware protection must be read with the narrative chapters. Multiple declarations can be conditional; a route row does not prove production activation.

Literal decorated declarations: **173**.

| Methods | Declared path | Handler | Source |
| --- | --- | --- | --- |
| GET | `/` | `landing` | `app/main.py:395` |
| GET | `/.well-known/oauth-authorization-server` | `server_metadata` | `app/integration_routes.py:670` |
| GET | `/.well-known/oauth-protected-resource` | `resource_metadata` | `app/integration_routes.py:694` |
| GET | `/.well-known/oauth-protected-resource/api/integration` | `resource_metadata` | `app/integration_routes.py:694` |
| GET | `/.well-known/oauth-protected-resource/mcp` | `resource_metadata` | `app/integration_routes.py:694` |
| POST | `/api/integration/tools/{name}` | `api_tool` | `app/integration_routes.py:863` |
| GET | `/archive` | `archive` | `app/case_routes.py:403` |
| GET | `/archive/export/mail-attachments.csv` | `attachment_manifest` | `app/mail_routes.py:411` |
| GET | `/archive/export/mail.csv` | `export_mail` | `app/archive_routes.py:163` |
| GET | `/archive/export/mail/{message_id}/attachments/{attachment_id}` | `archived_attachment` | `app/mail_routes.py:407` |
| GET | `/archive/export/timecards.csv` | `export_timecards` | `app/archive_routes.py:90` |
| GET | `/audit` | `audit_page` | `app/main.py:1499` |
| POST | `/auth/email/start` | `email_start` | `app/enrollment_routes.py:513` |
| POST | `/auth/email/verify` | `email_verify` | `app/enrollment_routes.py:691` |
| GET | `/auth/github` | `google_entry` | `app/main.py:457` |
| POST | `/auth/github` | `google_login` | `app/main.py:462` |
| GET | `/auth/github/callback` | `google_callback` | `app/main.py:529` |
| GET | `/auth/google` | `google_entry` | `app/main.py:457` |
| POST | `/auth/google` | `google_login` | `app/main.py:462` |
| GET | `/auth/google/callback` | `google_callback` | `app/main.py:529` |
| POST | `/auth/local` | `local_login` | `app/main.py:434` |
| POST | `/auth/logout` | `logout` | `app/main.py:700` |
| GET | `/billing` | `invoice_list` | `app/main.py:1237` |
| POST | `/billing/create` | `invoice_create` | `app/main.py:1241` |
| GET | `/billing/{invoice_id}` | `invoice_detail` | `app/main.py:1261` |
| GET | `/billing/{invoice_id}/pdf` | `invoice_pdf` | `app/main.py:1283` |
| POST | `/billing/{invoice_id}/{operation}` | `invoice_action` | `app/main.py:1301` |
| GET | `/cases` | `case_list` | `app/case_routes.py:87` |
| GET | `/cases/new` | `new_case` | `app/case_routes.py:220` |
| POST | `/cases/new` | `create_case` | `app/case_routes.py:224` |
| GET | `/cases/{case_id}` | `case_detail` | `app/case_routes.py:264` |
| POST | `/cases/{case_id}/archive` | `archive_case` | `app/case_routes.py:314` |
| GET | `/cases/{case_id}/edit` | `edit_case` | `app/case_routes.py:292` |
| POST | `/cases/{case_id}/edit` | `update_case` | `app/case_routes.py:296` |
| GET | `/client-drafts` | `drafts` | `app/integration_routes.py:1081` |
| GET | `/clients` | `client_list` | `app/main.py:749` |
| GET | `/clients/new` | `new_client` | `app/main.py:812` |
| POST | `/clients/new` | `create_client` | `app/main.py:818` |
| GET | `/clients/{client_id}` | `client_detail` | `app/main.py:830` |
| POST | `/clients/{client_id}/archive` | `client_archive` | `app/main.py:887` |
| POST | `/clients/{client_id}/contacts` | `contact_save` | `app/main.py:921` |
| POST | `/clients/{client_id}/contract` | `contract_confirm` | `app/main.py:936` |
| GET | `/clients/{client_id}/edit` | `edit_client` | `app/main.py:869` |
| POST | `/clients/{client_id}/edit` | `client_save` | `app/main.py:875` |
| POST | `/clients/{client_id}/projects` | `project_save` | `app/main.py:905` |
| POST | `/contact` | `contact_submit` | `app/main.py:401` |
| GET | `/credit-memos/{memo_id}` | `credit_memo_detail` | `app/main.py:1344` |
| GET | `/credit-memos/{memo_id}/pdf` | `credit_memo_pdf` | `app/main.py:1350` |
| GET | `/dashboard` | `dashboard` | `app/main.py:715` |
| GET | `/health/live` | `live` | `app/main.py:679` |
| GET | `/health/ready` | `ready` | `app/main.py:683` |
| POST | `/internal/archive` | `archive_job` | `app/internal_routes.py:109` |
| POST | `/internal/mail` | `receive_mail` | `app/internal_routes.py:130` |
| POST | `/internal/sending` | `sending_job` | `app/internal_routes.py:21` |
| GET | `/legal/policies` | `legal_policies` | `app/enrollment_routes.py:81` |
| GET | `/library` | `library_list` | `app/library_routes.py:92` |
| POST | `/library` | `create_document` | `app/library_routes.py:110` |
| GET | `/library/new` | `new_document` | `app/library_routes.py:106` |
| GET | `/library/versions/{version_id}/attachment` | `attachment_download` | `app/library_routes.py:171` |
| GET | `/library/versions/{version_id}/pdf` | `pdf_download` | `app/library_routes.py:165` |
| GET | `/library/{document_id}` | `document_detail` | `app/library_routes.py:118` |
| POST | `/library/{document_id}/new-draft` | `create_draft` | `app/library_routes.py:148` |
| POST | `/library/{document_id}/publish` | `publish_document` | `app/library_routes.py:141` |
| POST | `/library/{document_id}/save` | `save_document` | `app/library_routes.py:122` |
| POST | `/library/{document_id}/upload` | `upload_document` | `app/library_routes.py:129` |
| GET | `/library/{document_id}/uploads/{upload_id}` | `original_download` | `app/library_routes.py:154` |
| GET | `/lookups/{kind}` | `lookup_page` | `app/main.py:1450` |
| GET | `/mail` | `mail_list` | `app/mail_routes.py:108` |
| GET | `/mail/addresses` | `address_list` | `app/mail_routes.py:277` |
| POST | `/mail/addresses` | `address_create` | `app/mail_routes.py:281` |
| POST | `/mail/addresses/{address_id}/revoke` | `address_revoke` | `app/mail_routes.py:306` |
| GET | `/mail/import` | `mail_import_form` | `app/mail_routes.py:215` |
| POST | `/mail/import` | `mail_import` | `app/mail_routes.py:219` |
| GET | `/mail/{message_id}` | `mail_detail` | `app/mail_routes.py:315` |
| GET | `/mail/{message_id}/attachments/{attachment_id}` | `active_attachment` | `app/mail_routes.py:403` |
| DELETE | `/mcp` | `no_stream` | `app/integration_routes.py:844` |
| GET | `/mcp` | `no_stream` | `app/integration_routes.py:844` |
| POST | `/mcp` | `mcp` | `app/integration_routes.py:890` |
| GET | `/oauth/authorize` | `authorization_page` | `app/integration_routes.py:711` |
| POST | `/oauth/authorize` | `authorize` | `app/integration_routes.py:747` |
| POST | `/oauth/revoke` | `revoke_token` | `app/integration_routes.py:810` |
| POST | `/oauth/token` | `token` | `app/integration_routes.py:775` |
| POST | `/payments/{payment_id}/reverse` | `payment_reverse` | `app/main.py:1364` |
| POST | `/privacy/preferences` | `save_preferences` | `app/privacy.py:75` |
| POST | `/privacy/usage` | `collect_usage` | `app/usage.py:43` |
| GET | `/project-billing/{project_id}` | `detail` | `app/project_billing_routes.py:48` |
| POST | `/project-billing/{project_id}/{operation}` | `action` | `app/project_billing_routes.py:52` |
| GET | `/projects` | `project_list` | `app/project_routes.py:139` |
| POST | `/projects` | `project_create` | `app/project_routes.py:263` |
| GET | `/projects/new` | `project_new` | `app/project_routes.py:209` |
| POST | `/projects/{project_id}` | `project_update` | `app/project_routes.py:267` |
| GET | `/projects/{project_id}/agreements/{agreement_id}` | `agreement_download` | `app/project_routes.py:314` |
| POST | `/projects/{project_id}/archive` | `project_archive` | `app/project_routes.py:271` |
| GET | `/projects/{project_id}/edit` | `project_edit` | `app/project_routes.py:213` |
| GET | `/quoting` | `index` | `app/quoting_routes.py:147` |
| GET | `/quoting/documents/new` | `new_document` | `app/library_routes.py:106` |
| GET | `/quoting/new` | `new` | `app/quoting_routes.py:161` |
| POST | `/quoting/new` | `create` | `app/quoting_routes.py:190` |
| GET | `/quoting/{quote_id}` | `detail` | `app/quoting_routes.py:194` |
| POST | `/quoting/{quote_id}/archive` | `archive` | `app/quoting_routes.py:230` |
| GET | `/quoting/{quote_id}/edit` | `edit` | `app/quoting_routes.py:202` |
| POST | `/quoting/{quote_id}/edit` | `update` | `app/quoting_routes.py:206` |
| GET | `/quoting/{quote_id}/pdf` | `download` | `app/quoting_routes.py:235` |
| POST | `/quoting/{quote_id}/publish` | `publish` | `app/quoting_routes.py:213` |
| POST | `/quoting/{quote_id}/revise` | `revise` | `app/quoting_routes.py:222` |
| GET | `/registration` | `registration` | `app/enrollment_routes.py:186` |
| POST | `/registration/ack` | `acknowledge` | `app/enrollment_routes.py:190` |
| POST | `/registration/free` | `activate_free` | `app/enrollment_routes.py:232` |
| GET | `/reports` | `reports_page` | `app/main.py:1374` |
| GET | `/reports/export.csv` | `csv_export` | `app/main.py:1380` |
| GET | `/sending` | `index` | `app/sending_routes.py:98` |
| POST | `/sending/deliveries/{delivery_id}/dispatch` | `dispatch` | `app/sending_dispatch_routes.py:60` |
| POST | `/sending/deliveries/{delivery_id}/follow-up/dispatch` | `followup_dispatch` | `app/sending_dispatch_routes.py:34` |
| GET | `/sending/deliveries/{delivery_id}/follow-up/review` | `followup_review` | `app/sending_dispatch_routes.py:23` |
| POST | `/sending/deliveries/{delivery_id}/retry` | `retry` | `app/sending_routes.py:175` |
| POST | `/sending/plans/{plan_id}/stop` | `stop` | `app/sending_routes.py:154` |
| GET | `/sending/prepare/{invoice_id}` | `prepare_form` | `app/sending_routes.py:102` |
| POST | `/sending/prepare/{invoice_id}` | `prepare` | `app/sending_routes.py:119` |
| POST | `/sending/prepare/{invoice_id}/edit` | `edit` | `app/sending_routes.py:115` |
| POST | `/sending/prepare/{invoice_id}/review` | `review` | `app/sending_routes.py:106` |
| GET | `/sending/proposals` | `index` | `app/proposal_sending_routes.py:38` |
| GET | `/sending/proposals/prepare/{source}/{artifact_id}` | `prepare_form` | `app/proposal_sending_routes.py:45` |
| POST | `/sending/proposals/prepare/{source}/{artifact_id}/review` | `prepare` | `app/proposal_sending_routes.py:49` |
| GET | `/sending/proposals/{delivery_id}` | `review_form` | `app/proposal_sending_routes.py:69` |
| GET | `/sending/proposals/{delivery_id}/attachment` | `attachment` | `app/proposal_sending_routes.py:105` |
| POST | `/sending/proposals/{delivery_id}/dispatch` | `dispatch` | `app/proposal_sending_routes.py:81` |
| POST | `/sending/proposals/{delivery_id}/edit` | `edit` | `app/proposal_sending_routes.py:73` |
| POST | `/sending/proposals/{delivery_id}/stop` | `stop` | `app/proposal_sending_routes.py:99` |
| POST | `/sending/resume` | `resume` | `app/sending_routes.py:168` |
| POST | `/sending/stop-all` | `stop_all` | `app/sending_routes.py:161` |
| POST | `/sending/templates` | `templates` | `app/sending_routes.py:138` |
| GET | `/settings` | `settings_page` | `app/main.py:1437` |
| POST | `/settings` | `save_settings` | `app/main.py:1489` |
| POST | `/settings/archiving/run` | `archive_now_action` | `app/archive_routes.py:218` |
| GET | `/settings/integrations` | `integrations` | `app/integration_routes.py:1046` |
| POST | `/settings/integrations/{grant_id}/revoke` | `revoke` | `app/integration_routes.py:1067` |
| POST | `/settings/limits` | `save_limits` | `app/main.py:1441` |
| GET | `/settings/security` | `security` | `app/enrollment_routes.py:307` |
| POST | `/settings/security/email/revoke` | `revoke_email` | `app/enrollment_routes.py:311` |
| POST | `/settings/security/email/start` | `email_link_start` | `app/enrollment_routes.py:517` |
| POST | `/settings/security/email/verify` | `email_link_verify` | `app/enrollment_routes.py:695` |
| GET | `/settings/subscription` | `subscription` | `app/subscription_routes.py:111` |
| POST | `/settings/subscription/cancel` | `cancel` | `app/subscription_payment_routes.py:200` |
| POST | `/settings/subscription/change/confirm` | `change_confirm` | `app/subscription_payment_routes.py:369` |
| POST | `/settings/subscription/change/preview` | `change_preview` | `app/subscription_payment_routes.py:220` |
| GET | `/settings/subscription/checkout` | `checkout_return` | `app/subscription_payment_routes.py:93` |
| POST | `/settings/subscription/checkout` | `checkout` | `app/subscription_payment_routes.py:129` |
| POST | `/settings/subscription/checkout/reconcile` | `reconcile_checkout` | `app/subscription_payment_routes.py:181` |
| GET | `/settings/subscription/checkout/{operation_id}` | `checkout_page` | `app/subscription_payment_routes.py:107` |
| POST | `/settings/subscription/free` | `enroll` | `app/subscription_routes.py:134` |
| POST | `/settings/subscription/portal` | `portal` | `app/subscription_payment_routes.py:165` |
| POST | `/settings/subscription/preview` | `preview` | `app/subscription_routes.py:115` |
| POST | `/settings/subscription/provider/verify` | `catalog` | `app/subscription_payment_routes.py:154` |
| POST | `/settings/subscription/renewal/check` | `renewal_check` | `app/subscription_payment_routes.py:277` |
| POST | `/settings/subscription/retention/confirm` | `retention_confirm` | `app/subscription_payment_routes.py:329` |
| POST | `/settings/subscription/retention/preview` | `retention_preview` | `app/subscription_payment_routes.py:294` |
| POST | `/settings/subscription/retention/reconcile` | `retention_reconcile` | `app/subscription_payment_routes.py:350` |
| GET | `/sign-in` | `sign_in` | `app/enrollment_routes.py:129` |
| GET | `/sign-up` | `sign_up` | `app/enrollment_routes.py:133` |
| POST | `/subscriptions/paddle/webhook` | `webhook` | `app/subscription_payment_routes.py:396` |
| GET | `/timecards` | `timecard_list` | `app/main.py:946` |
| GET | `/timecards/contributions` | `contribution_list` | `app/time_import_routes.py:120` |
| GET | `/timecards/contributions/{contribution_id}` | `contribution_form` | `app/time_import_routes.py:207` |
| POST | `/timecards/contributions/{contribution_id}` | `correct_contribution` | `app/time_import_routes.py:214` |
| GET | `/timecards/entries/{entry_id}/cases` | `allocations` | `app/case_routes.py:368` |
| POST | `/timecards/entries/{entry_id}/cases` | `allocation_save` | `app/case_routes.py:372` |
| GET | `/timecards/import` | `import_form` | `app/time_import_routes.py:116` |
| POST | `/timecards/import` | `preview_file` | `app/time_import_routes.py:272` |
| POST | `/timecards/import/commit` | `commit_file` | `app/time_import_routes.py:297` |
| POST | `/timecards/save` | `timecard_save` | `app/main.py:1107` |
| POST | `/timecards/{card_id}/duplicate` | `duplicate` | `app/main.py:1166` |
| POST | `/timecards/{card_id}/finalize` | `timecard_finalize` | `app/main.py:1139` |
| POST | `/timecards/{card_id}/reopen` | `timecard_reopen` | `app/main.py:1156` |

## Jinja templates

| Template | Bytes |
| --- | --- |
| `app/web/templates/account_security.html` | 4533 |
| `app/web/templates/archive.html` | 4509 |
| `app/web/templates/archived_timecard.html` | 377 |
| `app/web/templates/assistant_connection_guide.html` | 6974 |
| `app/web/templates/audit.html` | 854 |
| `app/web/templates/auth_challenge.html` | 537 |
| `app/web/templates/auth_layout.html` | 1137 |
| `app/web/templates/auth_methods.html` | 3145 |
| `app/web/templates/auth_notice.html` | 458 |
| `app/web/templates/auth_notice_fields.html` | 129 |
| `app/web/templates/auth_provider_button.html` | 371 |
| `app/web/templates/auth_provider_forms.html` | 892 |
| `app/web/templates/base.html` | 4470 |
| `app/web/templates/billing.html` | 4478 |
| `app/web/templates/capacity_prompt.html` | 2143 |
| `app/web/templates/case_allocations.html` | 2264 |
| `app/web/templates/case_detail.html` | 3137 |
| `app/web/templates/case_form.html` | 3475 |
| `app/web/templates/cases.html` | 3591 |
| `app/web/templates/client_detail.html` | 5428 |
| `app/web/templates/client_drafts.html` | 844 |
| `app/web/templates/client_form.html` | 2582 |
| `app/web/templates/clients.html` | 2346 |
| `app/web/templates/clock.html` | 905 |
| `app/web/templates/components.html` | 4833 |
| `app/web/templates/contact_form.html` | 1765 |
| `app/web/templates/cookie_preferences.html` | 3044 |
| `app/web/templates/credit_memo.html` | 1069 |
| `app/web/templates/credit_memo_pdf.html` | 3187 |
| `app/web/templates/dashboard.html` | 2936 |
| `app/web/templates/email/invitation.html` | 3800 |
| `app/web/templates/error.html` | 875 |
| `app/web/templates/help.html` | 19170 |
| `app/web/templates/invoice.html` | 7156 |
| `app/web/templates/landing.html` | 2655 |
| `app/web/templates/landing_info.html` | 5242 |
| `app/web/templates/legal_policies.html` | 997 |
| `app/web/templates/legal_policy_content.html` | 10609 |
| `app/web/templates/library.html` | 2011 |
| `app/web/templates/library_document.html` | 6007 |
| `app/web/templates/library_document_pdf.html` | 1015 |
| `app/web/templates/lookup.html` | 2950 |
| `app/web/templates/lookup_fragment.html` | 131 |
| `app/web/templates/mail.html` | 2334 |
| `app/web/templates/mail_addresses.html` | 1583 |
| `app/web/templates/mail_assignment.html` | 346 |
| `app/web/templates/mail_detail.html` | 2443 |
| `app/web/templates/mail_import.html` | 1638 |
| `app/web/templates/navigation_icons.html` | 2458 |
| `app/web/templates/privacy_controls.html` | 192 |
| `app/web/templates/project_billing.html` | 4846 |
| `app/web/templates/project_form.html` | 6396 |
| `app/web/templates/projects.html` | 2712 |
| `app/web/templates/proposal_sending.html` | 1231 |
| `app/web/templates/proposal_sending_prepare.html` | 1614 |
| `app/web/templates/proposal_sending_readiness.html` | 237 |
| `app/web/templates/proposal_sending_review.html` | 4003 |
| `app/web/templates/public_plans.html` | 3190 |
| `app/web/templates/quote_detail.html` | 4402 |
| `app/web/templates/quote_form.html` | 4454 |
| `app/web/templates/quote_pdf.html` | 2513 |
| `app/web/templates/quoting.html` | 3954 |
| `app/web/templates/registration.html` | 4060 |
| `app/web/templates/reports.html` | 1617 |
| `app/web/templates/sending.html` | 7751 |
| `app/web/templates/sending_followup_review.html` | 1840 |
| `app/web/templates/sending_prepare.html` | 3035 |
| `app/web/templates/sending_readiness.html` | 562 |
| `app/web/templates/sending_review.html` | 2320 |
| `app/web/templates/settings.html` | 6017 |
| `app/web/templates/settings_integrations.html` | 2748 |
| `app/web/templates/sign_in.html` | 571 |
| `app/web/templates/sign_up.html` | 721 |
| `app/web/templates/statement.html` | 4509 |
| `app/web/templates/subscription.html` | 6736 |
| `app/web/templates/subscription_account.html` | 11437 |
| `app/web/templates/subscription_change_review.html` | 3620 |
| `app/web/templates/subscription_checkout.html` | 3563 |
| `app/web/templates/subscription_command.html` | 419 |
| `app/web/templates/subscription_payment_controls.html` | 3096 |
| `app/web/templates/subscription_portal.html` | 1282 |
| `app/web/templates/subscription_retention_review.html` | 3588 |
| `app/web/templates/time_import.html` | 7397 |
| `app/web/templates/timecards.html` | 7001 |
