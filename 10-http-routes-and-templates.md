# HTTP routes and Jinja templates

Snapshot: 2026-10-18. Source commit `4bb5c424d6e7d270cdca1479283896be77d581c3` on `main`.
Generated offline from tracked source only. No app import, product-test execution, database query, provider/identity action or deployment. Static counts do not describe executed tests or live routing/database state.

## 180 literal route decorators

Router/include/mount prefixes and runtime registration are not evaluated. `API_ROUTE` retains its literal decorator kind rather than inventing methods. Authorization and feature flags must be reviewed in the named handlers/dependencies; presence is not activation.

| Method kind | Literal path | Handler | Source |
| --- | --- | --- | --- |
| GET | `/archive/export/timecards.csv` | `router.export_timecards` | [`app/archive_routes.py:89`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L89) |
| GET | `/archive/export/mail.csv` | `router.export_mail` | [`app/archive_routes.py:168`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L168) |
| POST | `/settings/archiving/run` | `router.archive_now_action` | [`app/archive_routes.py:223`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L223) |
| GET | `/cases` | `router.case_list` | [`app/case_routes.py:124`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L124) |
| GET | `/cases/mass-edit` | `router.case_mass_edit` | [`app/case_routes.py:245`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L245) |
| POST | `/cases/mass-edit` | `router.case_mass_save` | [`app/case_routes.py:249`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L249) |
| GET | `/cases/new` | `router.new_case` | [`app/case_routes.py:282`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L282) |
| POST | `/cases/new` | `router.create_case` | [`app/case_routes.py:286`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L286) |
| GET | `/cases/{case_id}` | `router.case_detail` | [`app/case_routes.py:326`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L326) |
| GET | `/cases/{case_id}/edit` | `router.edit_case` | [`app/case_routes.py:356`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L356) |
| POST | `/cases/{case_id}/edit` | `router.update_case` | [`app/case_routes.py:360`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L360) |
| POST | `/cases/{case_id}/archive` | `router.archive_case` | [`app/case_routes.py:378`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L378) |
| GET | `/timecards/entries/{entry_id}/cases` | `router.allocations` | [`app/case_routes.py:434`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L434) |
| POST | `/timecards/entries/{entry_id}/cases` | `router.allocation_save` | [`app/case_routes.py:438`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L438) |
| GET | `/archive` | `router.archive` | [`app/case_routes.py:469`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L469) |
| GET | `/legal/policies` | `routes.legal_policies` | [`app/enrollment_routes.py:80`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L80) |
| GET | `/sign-in` | `routes.sign_in` | [`app/enrollment_routes.py:128`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L128) |
| GET | `/sign-up` | `routes.sign_up` | [`app/enrollment_routes.py:132`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L132) |
| GET | `/registration` | `routes.registration` | [`app/enrollment_routes.py:185`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L185) |
| POST | `/registration/ack` | `routes.acknowledge` | [`app/enrollment_routes.py:189`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L189) |
| POST | `/registration/free` | `routes.activate_free` | [`app/enrollment_routes.py:231`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L231) |
| GET | `/settings/security` | `routes.security` | [`app/enrollment_routes.py:306`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L306) |
| POST | `/settings/security/email/revoke` | `routes.revoke_email` | [`app/enrollment_routes.py:310`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L310) |
| POST | `/auth/email/start` | `routes.email_start` | [`app/enrollment_routes.py:512`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L512) |
| POST | `/settings/security/email/start` | `routes.email_link_start` | [`app/enrollment_routes.py:516`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L516) |
| POST | `/auth/email/verify` | `routes.email_verify` | [`app/enrollment_routes.py:690`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L690) |
| POST | `/settings/security/email/verify` | `routes.email_link_verify` | [`app/enrollment_routes.py:694`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L694) |
| GET | `/.well-known/oauth-authorization-server` | `router.server_metadata` | [`app/integration_routes.py:671`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L671) |
| GET | `/.well-known/oauth-protected-resource` | `router.resource_metadata` | [`app/integration_routes.py:693`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L693) |
| GET | `/.well-known/oauth-protected-resource/mcp` | `router.resource_metadata` | [`app/integration_routes.py:694`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L694) |
| GET | `/.well-known/oauth-protected-resource/api/integration` | `router.resource_metadata` | [`app/integration_routes.py:695`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L695) |
| GET | `/oauth/authorize` | `router.authorization_page` | [`app/integration_routes.py:712`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L712) |
| POST | `/oauth/authorize` | `router.authorize` | [`app/integration_routes.py:748`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L748) |
| POST | `/oauth/token` | `router.token` | [`app/integration_routes.py:776`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L776) |
| POST | `/oauth/revoke` | `router.revoke_token` | [`app/integration_routes.py:811`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L811) |
| GET | `/mcp` | `router.no_stream` | [`app/integration_routes.py:844`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L844) |
| DELETE | `/mcp` | `router.no_stream` | [`app/integration_routes.py:845`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L845) |
| POST | `/api/integration/tools/{name}` | `router.api_tool` | [`app/integration_routes.py:864`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L864) |
| POST | `/mcp` | `router.mcp` | [`app/integration_routes.py:891`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L891) |
| GET | `/settings/integrations` | `router.integrations` | [`app/integration_routes.py:1047`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1047) |
| POST | `/settings/integrations/{grant_id}/revoke` | `router.revoke` | [`app/integration_routes.py:1068`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1068) |
| GET | `/client-drafts` | `router.drafts` | [`app/integration_routes.py:1082`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1082) |
| POST | `/internal/sending` | `router.sending_job` | [`app/internal_routes.py:20`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L20) |
| POST | `/internal/archive/cases` | `router.archive_job` | [`app/internal_routes.py:108`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L108) |
| POST | `/internal/archive` | `router.archive_job` | [`app/internal_routes.py:109`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L109) |
| POST | `/internal/mail` | `router.receive_mail` | [`app/internal_routes.py:133`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L133) |
| GET | `/library` | `router.library_list` | [`app/library_routes.py:92`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L92) |
| GET | `/library/new` | `router.new_document` | [`app/library_routes.py:106`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L106) |
| GET | `/quoting/documents/new` | `router.new_document` | [`app/library_routes.py:107`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L107) |
| POST | `/library` | `router.create_document` | [`app/library_routes.py:111`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L111) |
| GET | `/library/{document_id}` | `router.document_detail` | [`app/library_routes.py:119`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L119) |
| POST | `/library/{document_id}/save` | `router.save_document` | [`app/library_routes.py:123`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L123) |
| POST | `/library/{document_id}/upload` | `router.upload_document` | [`app/library_routes.py:130`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L130) |
| POST | `/library/{document_id}/publish` | `router.publish_document` | [`app/library_routes.py:142`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L142) |
| POST | `/library/{document_id}/new-draft` | `router.create_draft` | [`app/library_routes.py:149`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L149) |
| GET | `/library/{document_id}/uploads/{upload_id}` | `router.original_download` | [`app/library_routes.py:155`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L155) |
| GET | `/library/versions/{version_id}/pdf` | `router.pdf_download` | [`app/library_routes.py:166`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L166) |
| GET | `/library/versions/{version_id}/attachment` | `router.attachment_download` | [`app/library_routes.py:172`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L172) |
| GET | `/mail` | `router.mail_list` | [`app/mail_routes.py:108`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L108) |
| GET | `/mail/import` | `router.mail_import_form` | [`app/mail_routes.py:206`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L206) |
| POST | `/mail/import` | `router.mail_import` | [`app/mail_routes.py:210`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L210) |
| GET | `/mail/addresses` | `router.address_list` | [`app/mail_routes.py:268`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L268) |
| POST | `/mail/addresses` | `router.address_create` | [`app/mail_routes.py:272`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L272) |
| POST | `/mail/addresses/{address_id}/revoke` | `router.address_revoke` | [`app/mail_routes.py:297`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L297) |
| GET | `/mail/{message_id}` | `router.mail_detail` | [`app/mail_routes.py:306`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L306) |
| GET | `/mail/{message_id}/attachments/{attachment_id}` | `router.active_attachment` | [`app/mail_routes.py:394`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L394) |
| GET | `/archive/export/mail/{message_id}/attachments/{attachment_id}` | `router.archived_attachment` | [`app/mail_routes.py:398`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L398) |
| GET | `/archive/export/mail-attachments.csv` | `router.attachment_manifest` | [`app/mail_routes.py:402`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L402) |
| GET | `/` | `app.landing` | [`app/main.py:418`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L418) |
| POST | `/contact` | `app.contact_submit` | [`app/main.py:424`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L424) |
| POST | `/auth/local` | `app.local_login` | [`app/main.py:457`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L457) |
| GET | `/auth/google` | `app.google_entry` | [`app/main.py:479`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L479) |
| GET | `/auth/github` | `app.google_entry` | [`app/main.py:480`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L480) |
| POST | `/auth/google` | `app.google_login` | [`app/main.py:484`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L484) |
| POST | `/auth/github` | `app.google_login` | [`app/main.py:485`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L485) |
| GET | `/auth/google/callback` | `app.google_callback` | [`app/main.py:551`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L551) |
| GET | `/auth/github/callback` | `app.google_callback` | [`app/main.py:552`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L552) |
| GET | `/health/live` | `app.live` | [`app/main.py:702`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L702) |
| GET | `/health/ready` | `app.ready` | [`app/main.py:706`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L706) |
| POST | `/auth/logout` | `app.logout` | [`app/main.py:723`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L723) |
| GET | `/dashboard` | `protected.dashboard` | [`app/main.py:738`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L738) |
| GET | `/clients` | `protected.client_list` | [`app/main.py:820`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L820) |
| GET | `/clients/new` | `protected.new_client` | [`app/main.py:887`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L887) |
| POST | `/clients/new` | `protected.create_client` | [`app/main.py:893`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L893) |
| GET | `/clients/{client_id}` | `protected.client_detail` | [`app/main.py:943`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L943) |
| GET | `/clients/{client_id}/edit` | `protected.edit_client` | [`app/main.py:947`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L947) |
| POST | `/clients/{client_id}/edit` | `protected.client_save` | [`app/main.py:953`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L953) |
| POST | `/clients/{client_id}/projects` | `protected.project_save` | [`app/main.py:965`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L965) |
| POST | `/clients/{client_id}/contacts` | `protected.contact_save` | [`app/main.py:981`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L981) |
| POST | `/clients/{client_id}/contract` | `protected.contract_confirm` | [`app/main.py:996`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L996) |
| GET | `/clients/{client_id}/sources/{reference_id}` | `protected.client_source_download` | [`app/main.py:1022`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1022) |
| GET | `/timecards` | `protected.timecard_list` | [`app/main.py:1029`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1029) |
| POST | `/timecards/save` | `protected.timecard_save` | [`app/main.py:1252`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1252) |
| POST | `/timecards/remove-drafts` | `protected.remove_timecard_drafts` | [`app/main.py:1286`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1286) |
| POST | `/timecards/add-project` | `protected.add_timecard_project` | [`app/main.py:1309`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1309) |
| POST | `/timecards/{card_id}/finalize` | `protected.timecard_finalize` | [`app/main.py:1327`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1327) |
| POST | `/timecards/{card_id}/reopen` | `protected.timecard_reopen` | [`app/main.py:1344`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1344) |
| POST | `/timecards/{card_id}/duplicate` | `protected.duplicate` | [`app/main.py:1354`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1354) |
| GET | `/billing` | `protected.invoice_list` | [`app/main.py:1415`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1415) |
| POST | `/billing/create` | `protected.invoice_create` | [`app/main.py:1419`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1419) |
| GET | `/billing/{invoice_id}` | `protected.invoice_detail` | [`app/main.py:1439`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1439) |
| GET | `/billing/{invoice_id}/pdf` | `protected.invoice_pdf` | [`app/main.py:1461`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1461) |
| POST | `/billing/{invoice_id}/{operation}` | `protected.invoice_action` | [`app/main.py:1479`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1479) |
| GET | `/credit-memos/{memo_id}` | `protected.credit_memo_detail` | [`app/main.py:1522`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1522) |
| GET | `/credit-memos/{memo_id}/pdf` | `protected.credit_memo_pdf` | [`app/main.py:1528`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1528) |
| POST | `/payments/{payment_id}/reverse` | `protected.payment_reverse` | [`app/main.py:1542`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1542) |
| GET | `/reports` | `protected.reports_page` | [`app/main.py:1552`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1552) |
| GET | `/reports/export.csv` | `protected.csv_export` | [`app/main.py:1561`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1561) |
| GET | `/settings` | `protected.settings_page` | [`app/main.py:1620`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1620) |
| POST | `/settings/limits` | `protected.save_limits` | [`app/main.py:1624`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1624) |
| POST | `/settings/records` | `protected.save_record_limits` | [`app/main.py:1633`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1633) |
| GET | `/lookups/{kind}` | `protected.lookup_page` | [`app/main.py:1638`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1638) |
| POST | `/settings` | `protected.save_settings` | [`app/main.py:1679`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1679) |
| GET | `/audit` | `protected.audit_page` | [`app/main.py:1689`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1689) |
| POST | `/privacy/preferences` | `router.save_preferences` | [`app/privacy.py:74`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L74) |
| GET | `/project-billing/{project_id}` | `router.detail` | [`app/project_billing_routes.py:55`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L55) |
| POST | `/project-billing/{project_id}/{operation}` | `router.action` | [`app/project_billing_routes.py:59`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L59) |
| GET | `/projects` | `router.project_list` | [`app/project_routes.py:146`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L146) |
| GET | `/projects/new` | `router.project_new` | [`app/project_routes.py:220`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L220) |
| GET | `/projects/{project_id}/edit` | `router.project_edit` | [`app/project_routes.py:224`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L224) |
| POST | `/projects` | `router.project_create` | [`app/project_routes.py:274`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L274) |
| POST | `/projects/{project_id}` | `router.project_update` | [`app/project_routes.py:278`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L278) |
| POST | `/projects/{project_id}/archive` | `router.project_archive` | [`app/project_routes.py:282`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L282) |
| GET | `/projects/{project_id}/agreements/{agreement_id}` | `router.agreement_download` | [`app/project_routes.py:326`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L326) |
| GET | `/sending/proposals` | `router.index` | [`app/proposal_sending_routes.py:37`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L37) |
| GET | `/sending/proposals/prepare/{source}/{artifact_id}` | `router.prepare_form` | [`app/proposal_sending_routes.py:45`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L45) |
| POST | `/sending/proposals/prepare/{source}/{artifact_id}/review` | `router.prepare` | [`app/proposal_sending_routes.py:49`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L49) |
| GET | `/sending/proposals/{delivery_id}` | `router.review_form` | [`app/proposal_sending_routes.py:69`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L69) |
| POST | `/sending/proposals/{delivery_id}/edit` | `router.edit` | [`app/proposal_sending_routes.py:73`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L73) |
| POST | `/sending/proposals/{delivery_id}/dispatch` | `router.dispatch` | [`app/proposal_sending_routes.py:81`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L81) |
| POST | `/sending/proposals/{delivery_id}/stop` | `router.stop` | [`app/proposal_sending_routes.py:99`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L99) |
| GET | `/sending/proposals/{delivery_id}/attachment` | `router.attachment` | [`app/proposal_sending_routes.py:105`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L105) |
| GET | `/quoting` | `router.index` | [`app/quoting_routes.py:147`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L147) |
| GET | `/quoting/new` | `router.new` | [`app/quoting_routes.py:162`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L162) |
| POST | `/quoting/new` | `router.create` | [`app/quoting_routes.py:191`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L191) |
| GET | `/quoting/{quote_id}` | `router.detail` | [`app/quoting_routes.py:195`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L195) |
| GET | `/quoting/{quote_id}/edit` | `router.edit` | [`app/quoting_routes.py:203`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L203) |
| POST | `/quoting/{quote_id}/edit` | `router.update` | [`app/quoting_routes.py:207`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L207) |
| POST | `/quoting/{quote_id}/publish` | `router.publish` | [`app/quoting_routes.py:214`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L214) |
| POST | `/quoting/{quote_id}/revise` | `router.revise` | [`app/quoting_routes.py:223`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L223) |
| POST | `/quoting/{quote_id}/archive` | `router.archive` | [`app/quoting_routes.py:231`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L231) |
| GET | `/quoting/{quote_id}/pdf` | `router.download` | [`app/quoting_routes.py:236`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L236) |
| GET | `/search` | `routes.workspace_search` | [`app/search_routes.py:12`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/search_routes.py#L12) |
| GET | `/sending/deliveries/{delivery_id}/follow-up/review` | `router.followup_review` | [`app/sending_dispatch_routes.py:22`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L22) |
| POST | `/sending/deliveries/{delivery_id}/follow-up/dispatch` | `router.followup_dispatch` | [`app/sending_dispatch_routes.py:33`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L33) |
| POST | `/sending/deliveries/{delivery_id}/dispatch` | `router.dispatch` | [`app/sending_dispatch_routes.py:59`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L59) |
| GET | `/sending` | `router.index` | [`app/sending_routes.py:99`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L99) |
| GET | `/sending/prepare/{invoice_id}` | `router.prepare_form` | [`app/sending_routes.py:103`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L103) |
| POST | `/sending/prepare/{invoice_id}/review` | `router.review` | [`app/sending_routes.py:107`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L107) |
| POST | `/sending/prepare/{invoice_id}/edit` | `router.edit` | [`app/sending_routes.py:116`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L116) |
| POST | `/sending/prepare/{invoice_id}` | `router.prepare` | [`app/sending_routes.py:120`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L120) |
| POST | `/sending/templates` | `router.templates` | [`app/sending_routes.py:139`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L139) |
| POST | `/sending/plans/{plan_id}/stop` | `router.stop` | [`app/sending_routes.py:155`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L155) |
| POST | `/sending/stop-all` | `router.stop_all` | [`app/sending_routes.py:162`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L162) |
| POST | `/sending/resume` | `router.resume` | [`app/sending_routes.py:169`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L169) |
| POST | `/sending/deliveries/{delivery_id}/retry` | `router.retry` | [`app/sending_routes.py:176`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L176) |
| GET | `/settings/subscription/checkout` | `routes.checkout_return` | [`app/subscription_payment_routes.py:92`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L92) |
| GET | `/settings/subscription/checkout/{operation_id}` | `routes.checkout_page` | [`app/subscription_payment_routes.py:106`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L106) |
| POST | `/settings/subscription/checkout` | `routes.checkout` | [`app/subscription_payment_routes.py:128`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L128) |
| POST | `/settings/subscription/provider/verify` | `routes.catalog` | [`app/subscription_payment_routes.py:153`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L153) |
| POST | `/settings/subscription/portal` | `routes.portal` | [`app/subscription_payment_routes.py:164`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L164) |
| POST | `/settings/subscription/checkout/reconcile` | `routes.reconcile_checkout` | [`app/subscription_payment_routes.py:180`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L180) |
| POST | `/settings/subscription/cancel` | `routes.cancel` | [`app/subscription_payment_routes.py:199`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L199) |
| POST | `/settings/subscription/change/preview` | `routes.change_preview` | [`app/subscription_payment_routes.py:219`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L219) |
| POST | `/settings/subscription/renewal/check` | `routes.renewal_check` | [`app/subscription_payment_routes.py:276`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L276) |
| POST | `/settings/subscription/retention/preview` | `routes.retention_preview` | [`app/subscription_payment_routes.py:293`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L293) |
| POST | `/settings/subscription/retention/confirm` | `routes.retention_confirm` | [`app/subscription_payment_routes.py:328`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L328) |
| POST | `/settings/subscription/retention/reconcile` | `routes.retention_reconcile` | [`app/subscription_payment_routes.py:349`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L349) |
| POST | `/settings/subscription/change/confirm` | `routes.change_confirm` | [`app/subscription_payment_routes.py:368`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L368) |
| POST | `/subscriptions/paddle/webhook` | `routes.webhook` | [`app/subscription_payment_routes.py:395`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L395) |
| GET | `/settings/subscription` | `routes.subscription` | [`app/subscription_routes.py:110`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L110) |
| POST | `/settings/subscription/preview` | `routes.preview` | [`app/subscription_routes.py:114`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L114) |
| POST | `/settings/subscription/free` | `routes.enroll` | [`app/subscription_routes.py:133`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L133) |
| GET | `/timecards/import` | `router.import_form` | [`app/time_import_routes.py:115`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L115) |
| GET | `/timecards/contributions` | `router.contribution_list` | [`app/time_import_routes.py:119`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L119) |
| GET | `/timecards/contributions/{contribution_id}` | `router.contribution_form` | [`app/time_import_routes.py:206`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L206) |
| POST | `/timecards/contributions/{contribution_id}` | `router.correct_contribution` | [`app/time_import_routes.py:213`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L213) |
| POST | `/timecards/import` | `router.preview_file` | [`app/time_import_routes.py:271`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L271) |
| POST | `/timecards/import/commit` | `router.commit_file` | [`app/time_import_routes.py:296`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L296) |
| POST | `/privacy/usage` | `router.collect_usage` | [`app/usage.py:42`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/usage.py#L42) |

## 90 Jinja HTML templates

| Template | Source |
| --- | --- |
| account_security.html | [`app/web/templates/account_security.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/account_security.html) |
| archive.html | [`app/web/templates/archive.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/archive.html) |
| archived_timecard.html | [`app/web/templates/archived_timecard.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/archived_timecard.html) |
| assistant_connection_guide.html | [`app/web/templates/assistant_connection_guide.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/assistant_connection_guide.html) |
| audit.html | [`app/web/templates/audit.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/audit.html) |
| auth_challenge.html | [`app/web/templates/auth_challenge.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_challenge.html) |
| auth_layout.html | [`app/web/templates/auth_layout.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_layout.html) |
| auth_methods.html | [`app/web/templates/auth_methods.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_methods.html) |
| auth_notice.html | [`app/web/templates/auth_notice.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_notice.html) |
| auth_notice_fields.html | [`app/web/templates/auth_notice_fields.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_notice_fields.html) |
| auth_provider_button.html | [`app/web/templates/auth_provider_button.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_provider_button.html) |
| auth_provider_forms.html | [`app/web/templates/auth_provider_forms.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_provider_forms.html) |
| base.html | [`app/web/templates/base.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/base.html) |
| billing.html | [`app/web/templates/billing.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/billing.html) |
| capacity_prompt.html | [`app/web/templates/capacity_prompt.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/capacity_prompt.html) |
| case_allocations.html | [`app/web/templates/case_allocations.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_allocations.html) |
| case_detail.html | [`app/web/templates/case_detail.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_detail.html) |
| case_form.html | [`app/web/templates/case_form.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_form.html) |
| case_mass_edit.html | [`app/web/templates/case_mass_edit.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_mass_edit.html) |
| case_mass_edit_content.html | [`app/web/templates/case_mass_edit_content.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_mass_edit_content.html) |
| cases.html | [`app/web/templates/cases.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/cases.html) |
| client_detail.html | [`app/web/templates/client_detail.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/client_detail.html) |
| client_drafts.html | [`app/web/templates/client_drafts.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/client_drafts.html) |
| client_form.html | [`app/web/templates/client_form.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/client_form.html) |
| clients.html | [`app/web/templates/clients.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/clients.html) |
| clock.html | [`app/web/templates/clock.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/clock.html) |
| components.html | [`app/web/templates/components.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/components.html) |
| contact_form.html | [`app/web/templates/contact_form.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/contact_form.html) |
| cookie_preferences.html | [`app/web/templates/cookie_preferences.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/cookie_preferences.html) |
| credit_memo.html | [`app/web/templates/credit_memo.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/credit_memo.html) |
| credit_memo_pdf.html | [`app/web/templates/credit_memo_pdf.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/credit_memo_pdf.html) |
| dashboard.html | [`app/web/templates/dashboard.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/dashboard.html) |
| dashboard_detail.html | [`app/web/templates/dashboard_detail.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/dashboard_detail.html) |
| email/invitation.html | [`app/web/templates/email/invitation.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/email/invitation.html) |
| error.html | [`app/web/templates/error.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/error.html) |
| flexfields.html | [`app/web/templates/flexfields.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/flexfields.html) |
| help.html | [`app/web/templates/help.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/help.html) |
| invoice.html | [`app/web/templates/invoice.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/invoice.html) |
| landing.html | [`app/web/templates/landing.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/landing.html) |
| landing_info.html | [`app/web/templates/landing_info.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/landing_info.html) |
| legal_policies.html | [`app/web/templates/legal_policies.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/legal_policies.html) |
| legal_policy_content.html | [`app/web/templates/legal_policy_content.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/legal_policy_content.html) |
| library.html | [`app/web/templates/library.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/library.html) |
| library_document.html | [`app/web/templates/library_document.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/library_document.html) |
| library_document_pdf.html | [`app/web/templates/library_document_pdf.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/library_document_pdf.html) |
| lookup.html | [`app/web/templates/lookup.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/lookup.html) |
| lookup_fragment.html | [`app/web/templates/lookup_fragment.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/lookup_fragment.html) |
| mail.html | [`app/web/templates/mail.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail.html) |
| mail_addresses.html | [`app/web/templates/mail_addresses.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail_addresses.html) |
| mail_assignment.html | [`app/web/templates/mail_assignment.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail_assignment.html) |
| mail_detail.html | [`app/web/templates/mail_detail.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail_detail.html) |
| mail_import.html | [`app/web/templates/mail_import.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail_import.html) |
| navigation_icons.html | [`app/web/templates/navigation_icons.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/navigation_icons.html) |
| privacy_controls.html | [`app/web/templates/privacy_controls.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/privacy_controls.html) |
| project_billing.html | [`app/web/templates/project_billing.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/project_billing.html) |
| project_form.html | [`app/web/templates/project_form.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/project_form.html) |
| projects.html | [`app/web/templates/projects.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/projects.html) |
| proposal_sending.html | [`app/web/templates/proposal_sending.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/proposal_sending.html) |
| proposal_sending_prepare.html | [`app/web/templates/proposal_sending_prepare.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/proposal_sending_prepare.html) |
| proposal_sending_readiness.html | [`app/web/templates/proposal_sending_readiness.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/proposal_sending_readiness.html) |
| proposal_sending_review.html | [`app/web/templates/proposal_sending_review.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/proposal_sending_review.html) |
| public_plans.html | [`app/web/templates/public_plans.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/public_plans.html) |
| quote_detail.html | [`app/web/templates/quote_detail.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/quote_detail.html) |
| quote_form.html | [`app/web/templates/quote_form.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/quote_form.html) |
| quote_pdf.html | [`app/web/templates/quote_pdf.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/quote_pdf.html) |
| quoting.html | [`app/web/templates/quoting.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/quoting.html) |
| registration.html | [`app/web/templates/registration.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/registration.html) |
| reports.html | [`app/web/templates/reports.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/reports.html) |
| search.html | [`app/web/templates/search.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/search.html) |
| sending.html | [`app/web/templates/sending.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending.html) |
| sending_followup_review.html | [`app/web/templates/sending_followup_review.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending_followup_review.html) |
| sending_prepare.html | [`app/web/templates/sending_prepare.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending_prepare.html) |
| sending_readiness.html | [`app/web/templates/sending_readiness.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending_readiness.html) |
| sending_review.html | [`app/web/templates/sending_review.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending_review.html) |
| settings.html | [`app/web/templates/settings.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/settings.html) |
| settings_integrations.html | [`app/web/templates/settings_integrations.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/settings_integrations.html) |
| sign_in.html | [`app/web/templates/sign_in.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sign_in.html) |
| sign_up.html | [`app/web/templates/sign_up.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sign_up.html) |
| statement.html | [`app/web/templates/statement.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/statement.html) |
| subscription.html | [`app/web/templates/subscription.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription.html) |
| subscription_account.html | [`app/web/templates/subscription_account.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_account.html) |
| subscription_change_review.html | [`app/web/templates/subscription_change_review.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_change_review.html) |
| subscription_checkout.html | [`app/web/templates/subscription_checkout.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_checkout.html) |
| subscription_command.html | [`app/web/templates/subscription_command.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_command.html) |
| subscription_payment_controls.html | [`app/web/templates/subscription_payment_controls.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_payment_controls.html) |
| subscription_portal.html | [`app/web/templates/subscription_portal.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_portal.html) |
| subscription_retention_review.html | [`app/web/templates/subscription_retention_review.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_retention_review.html) |
| time_import.html | [`app/web/templates/time_import.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/time_import.html) |
| timecards.html | [`app/web/templates/timecards.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/timecards.html) |
| workspace_search_dialog.html | [`app/web/templates/workspace_search_dialog.html`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/workspace_search_dialog.html) |
