# Complete Python module and symbol index

Source `4bb5c424d6e7d270cdca1479283896be77d581c3`. Generated from tracked source with Python AST, without importing
or executing application code. Test definitions/source hashes are already complete
in [dossier chapter12](../12-source-map-tests-and-manifest.md).

| Inventory | Count |
| --- | --- |
| python modules | 118 |
| app python modules | 90 |
| migration python modules | 27 |
| script python modules | 1 |
| class declarations | 103 |
| function and async declarations | 945 |
| syntactic call sites | 13150 |
| internal declared import edges | 438 |
| app literal route decorators | 180 |

SHA-256 values cover raw inspected checkout bytes. Git blob line endings can
differ (CRLF versus LF); the canonical [source manifest](../source-snapshot-manifest.json)
records raw hashes and Git blob IDs separately. A raw checkout hash is not
asserted to be the hash of normalized Git blob content.

## What this index establishes

Every production/support Python module under `app/`, `alembic/` and `scripts/`
has a source hash, all class/function declaration locations, parameter names,
import declarations, literal route decorators and syntactic call sites in the
[JSON index](module-symbol-call-index.json). Call arguments/default literals and
function bodies are omitted. A call site establishes syntax, not its dynamic
target, reachability, execution order, transaction ownership or successful runtime.
Receiver aliases, callbacks, DI/contextvars and dynamic dispatch need source
tracing; the manual diagrams explain those boundaries. Constructor/decorator/
annotation/default calls also appear. Nested qualification is lexical only.

The [full declared-import diagram](declared-imports.mmd) is a searchable Mermaid
source, not an execution flowchart. An import can be conditional or delayed.
No test or live coverage conclusion follows from any count here.

## Module navigation

| Module/source | Classes | Functions | Call sites | Declared internal imports |
| --- | --- | --- | --- | --- |
| [alembic.env](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/env.py#L1) | 0 | 1 | 15 | `app.admission_models`, `app.config`, `app.credit_memo_models`, `app.enrollment_models`, `app.integration_models`, `app.library_models`, `app.mail_models`, `app.models`, `app.proposal_sending_models`, `app.quoting_models`, `app.sending_models`, `app.subscription_billing_models`, `app.subscription_models`, `app.time_command_models` |
| [alembic.versions.3f3c0f09ecf4_mail_custody_and_six_month_archive](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py#L1) | 0 | 2 | 132 | — |
| [alembic.versions.7e416c6444fe_baseline](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/7e416c6444fe_baseline.py#L1) | 0 | 2 | 426 | — |
| [alembic.versions.a10d45de891c_issued_status_guard](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a10d45de891c_issued_status_guard.py#L1) | 0 | 2 | 1 | — |
| [alembic.versions.a82d43cf6120_project_workflow_and_agreements](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a82d43cf6120_project_workflow_and_agreements.py#L1) | 0 | 2 | 46 | — |
| [alembic.versions.b07c9d621a30_pin_guard_schema](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/b07c9d621a30_pin_guard_schema.py#L1) | 0 | 2 | 5 | — |
| [alembic.versions.c41894d13cb7_project_commercial_metadata](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c41894d13cb7_project_commercial_metadata.py#L1) | 0 | 2 | 20 | — |
| [alembic.versions.c46f2f62a011_immutable_artifacts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c46f2f62a011_immutable_artifacts.py#L1) | 0 | 2 | 3 | — |
| [alembic.versions.d3517d81ce20_contact_reservations](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d3517d81ce20_contact_reservations.py#L1) | 0 | 2 | 18 | — |
| [alembic.versions.d529b08f14a2_project_billing](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py#L1) | 0 | 3 | 60 | — |
| [alembic.versions.e3b42aea781a_parent_guards_and_sessions](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e3b42aea781a_parent_guards_and_sessions.py#L1) | 0 | 2 | 7 | — |
| [alembic.versions.e640ab7230cd_case_identity_and_types](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L1) | 0 | 5 | 57 | — |
| [alembic.versions.e672c40fa912_cases_and_allocations](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e672c40fa912_cases_and_allocations.py#L1) | 0 | 3 | 65 | — |
| [alembic.versions.f409a1ac1700_parent_lock_guards](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f409a1ac1700_parent_lock_guards.py#L1) | 0 | 2 | 1 | — |
| [alembic.versions.f710bc319ae2_mail_attachment_custody](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f710bc319ae2_mail_attachment_custody.py#L1) | 0 | 2 | 44 | — |
| [alembic.versions.ph2_001_credit_memos](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py#L1) | 0 | 2 | 57 | — |
| [alembic.versions.ph2_002_time_commands](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L1) | 0 | 3 | 99 | — |
| [alembic.versions.ph2_003_integrations](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_003_integrations.py#L1) | 0 | 3 | 96 | — |
| [alembic.versions.ph3_001_subscriptions](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_001_subscriptions.py#L1) | 0 | 2 | 58 | — |
| [alembic.versions.ph3_002_sandbox_billing](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_002_sandbox_billing.py#L1) | 0 | 2 | 125 | — |
| [alembic.versions.ph3_003_onboarding_auth](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_003_onboarding_auth.py#L1) | 0 | 3 | 71 | — |
| [alembic.versions.ph3_004_sending](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_004_sending.py#L1) | 0 | 3 | 116 | — |
| [alembic.versions.ph3_005_public_admission](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_005_public_admission.py#L1) | 0 | 3 | 87 | — |
| [alembic.versions.ph3_006_quoting_library](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py#L1) | 0 | 3 | 54 | — |
| [alembic.versions.ph3_007_work_records](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L1) | 0 | 4 | 111 | — |
| [alembic.versions.ph3_008_client_lifecycle](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_008_client_lifecycle.py#L1) | 0 | 2 | 15 | — |
| [alembic.versions.ph3_009_read_indexes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_009_read_indexes.py#L1) | 0 | 2 | 13 | — |
| [app.__init__](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/__init__.py) | 0 | 0 | 0 | — |
| [app.admission](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L1) | 1 | 20 | 280 | `app.admission_models`, `app.domain`, `app.enrollment`, `app.enrollment_models`, `app.models`, `app.subscription_models` |
| [app.admission_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L1) | 3 | 0 | 50 | `app.models` |
| [app.admission_operations](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_operations.py#L1) | 0 | 3 | 80 | `app.admission`, `app.admission_models`, `app.enrollment_models`, `app.models` |
| [app.archive_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L1) | 0 | 8 | 79 | `app.archiving`, `app.domain`, `app.mail_models`, `app.models` |
| [app.archiving](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L1) | 0 | 7 | 136 | `app.domain`, `app.mail_models`, `app.models`, `app.work_lifecycle` |
| [app.audit](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/audit.py#L1) | 0 | 1 | 4 | `app.models` |
| [app.auth](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L1) | 1 | 8 | 73 | `app.enrollment`, `app.models` |
| [app.billing](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L1) | 0 | 28 | 399 | `app.audit`, `app.credit_memo_models`, `app.domain`, `app.flexfields`, `app.models`, `app.pdf`, `app.project_terms`, `app.repositories`, `app.sending` |
| [app.bot_check](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/bot_check.py#L1) | 0 | 1 | 16 | `app.config` |
| [app.case_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L1) | 0 | 23 | 273 | `app.archiving`, `app.auth`, `app.cases`, `app.forms`, `app.lookups`, `app.mail_models`, `app.models`, `app.pagination`, `app.repositories` |
| [app.cases](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L1) | 0 | 7 | 143 | `app.archiving`, `app.audit`, `app.domain`, `app.flexfields`, `app.forms`, `app.mail_models`, `app.models`, `app.pagination`, `app.repositories`, `app.time_command_models`, `app.work_lifecycle` |
| [app.cli](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cli.py#L1) | 0 | 1 | 69 | `app.admission_operations`, `app.billing`, `app.config`, `app.db`, `app.demo`, `app.logging`, `app.seed`, `app.tenancy`, `app.workspace_operations` |
| [app.client_drafts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_drafts.py#L1) | 0 | 2 | 28 | `app.audit`, `app.domain`, `app.integration_models`, `app.models`, `app.repositories` |
| [app.client_sources](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L1) | 0 | 6 | 66 | `app.audit`, `app.auth`, `app.forms`, `app.mail_service`, `app.models`, `app.repositories` |
| [app.clients](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L1) | 0 | 7 | 188 | `app.archiving`, `app.audit`, `app.domain`, `app.flexfields`, `app.forms`, `app.models`, `app.project_terms`, `app.repositories`, `app.subscriptions`, `app.work_lifecycle` |
| [app.config](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L1) | 1 | 7 | 106 | `app.integration_auth`, `app.paddle` |
| [app.contact](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L1) | 1 | 10 | 120 | `app.auth`, `app.bot_check`, `app.models` |
| [app.credit_memo_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/credit_memo_models.py#L1) | 1 | 0 | 24 | `app.models` |
| [app.dashboard](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/dashboard.py#L1) | 0 | 2 | 99 | `app.domain`, `app.models` |
| [app.db](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L1) | 0 | 2 | 7 | — |
| [app.demo](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/demo.py#L1) | 0 | 1 | 49 | `app.billing`, `app.clients`, `app.domain`, `app.models`, `app.seed`, `app.timecards` |
| [app.domain](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L1) | 1 | 6 | 38 | — |
| [app.email_auth](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L1) | 2 | 14 | 144 | `app.domain`, `app.enrollment`, `app.enrollment_models`, `app.models` |
| [app.enrollment](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L1) | 0 | 15 | 104 | `app.audit`, `app.domain`, `app.enrollment_models`, `app.models`, `app.subscription_models`, `app.subscriptions` |
| [app.enrollment_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L1) | 3 | 0 | 44 | `app.models` |
| [app.enrollment_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L1) | 0 | 25 | 387 | `app.admission`, `app.auth`, `app.domain`, `app.email_auth`, `app.enrollment`, `app.enrollment_models`, `app.integration_auth`, `app.models`, `app.social_auth`, `app.subscriptions`, `app.tenancy` |
| [app.flexfields](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/flexfields.py#L1) | 0 | 2 | 28 | `app.audit`, `app.forms` |
| [app.forms](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L1) | 1 | 5 | 58 | `app.domain` |
| [app.integration_auth](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L1) | 9 | 48 | 207 | `app.audit`, `app.enrollment`, `app.integration_models`, `app.models` |
| [app.integration_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L1) | 5 | 4 | 60 | `app.models` |
| [app.integration_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1) | 0 | 29 | 495 | `app.archiving`, `app.audit`, `app.auth`, `app.cases`, `app.client_drafts`, `app.credit_memo_models`, `app.domain`, `app.forms`, `app.integration_auth`, `app.integration_models`, `app.models`, `app.repositories`, `app.tenancy`, `app.time_command_models`, `app.time_commands` |
| [app.internal_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L1) | 0 | 5 | 89 | `app.archiving`, `app.domain`, `app.logging`, `app.mail_models`, `app.mail_service`, `app.models`, `app.sending`, `app.sending_transport` |
| [app.library](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L1) | 0 | 14 | 223 | `app.audit`, `app.domain`, `app.flexfields`, `app.forms`, `app.library_models`, `app.mail_service`, `app.models`, `app.pdf` |
| [app.library_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L1) | 3 | 0 | 66 | `app.models` |
| [app.library_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L1) | 0 | 18 | 139 | `app.auth`, `app.forms`, `app.library`, `app.library_models`, `app.lookups`, `app.models`, `app.pagination` |
| [app.logging](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L1) | 1 | 5 | 36 | — |
| [app.lookups](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L1) | 0 | 6 | 85 | `app.domain`, `app.models`, `app.settings` |
| [app.mail_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L1) | 3 | 0 | 68 | `app.models` |
| [app.mail_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L1) | 0 | 19 | 193 | `app.archive_routes`, `app.archiving`, `app.auth`, `app.domain`, `app.forms`, `app.lookups`, `app.mail_models`, `app.mail_service`, `app.models`, `app.pagination` |
| [app.mail_service](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L1) | 1 | 13 | 152 | `app.archiving`, `app.audit`, `app.domain`, `app.forms`, `app.mail_models`, `app.models`, `app.repositories` |
| [app.main](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1) | 1 | 68 | 857 | `app.admission`, `app.archive_routes`, `app.archiving`, `app.auth`, `app.billing`, `app.bot_check`, `app.case_routes`, `app.client_sources`, `app.clients`, `app.config`, `app.credit_memo_models`, `app.dashboard`, `app.domain`, `app.enrollment`, `app.enrollment_models`, `app.enrollment_routes`, `app.flexfields`, `app.forms`, `app.integration_auth`, `app.integration_routes`, `app.internal_routes`, `app.library_routes`, `app.logging`, `app.lookups`, `app.mail_routes`, `app.models`, `app.pagination`, `app.privacy`, `app.project_billing_routes`, `app.project_routes`, `app.proposal_sending_routes`, `app.quoting_routes`, `app.reference_choices`, `app.reports`, `app.repositories`, `app.search_routes`, `app.sending_dispatch_routes`, `app.sending_routes`, `app.settings`, `app.social_auth`, `app.static_assets`, `app.subscription_payment_routes`, `app.subscription_routes`, `app.subscriptions`, `app.tenancy`, `app.time_import_routes`, `app.timecards`, `app.usage`, `app.work_history` |
| [app.models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L1) | 20 | 0 | 339 | — |
| [app.paddle](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L1) | 5 | 40 | 310 | `app.domain` |
| [app.pagination](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L1) | 1 | 6 | 38 | `app.settings` |
| [app.pdf](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pdf.py#L1) | 0 | 2 | 21 | `app.domain`, `app.logging` |
| [app.privacy](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L1) | 1 | 6 | 37 | `app.auth` |
| [app.project_attachments](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_attachments.py#L1) | 0 | 4 | 49 | `app.audit`, `app.auth`, `app.forms`, `app.mail_service`, `app.models`, `app.repositories` |
| [app.project_billing_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L1) | 0 | 6 | 41 | `app.auth`, `app.billing`, `app.domain`, `app.forms`, `app.models`, `app.pagination`, `app.project_terms` |
| [app.project_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L1) | 0 | 14 | 144 | `app.auth`, `app.clients`, `app.domain`, `app.forms`, `app.lookups`, `app.models`, `app.pagination`, `app.project_attachments`, `app.project_terms`, `app.record_references`, `app.repositories`, `app.subscriptions`, `app.work_history` |
| [app.project_terms](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_terms.py#L1) | 0 | 1 | 12 | `app.domain`, `app.forms` |
| [app.proposal_sending](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L1) | 2 | 15 | 154 | `app.audit`, `app.domain`, `app.library`, `app.models`, `app.pagination`, `app.proposal_sending_models`, `app.proposal_sending_transport`, `app.quoting`, `app.repositories` |
| [app.proposal_sending_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L1) | 2 | 0 | 57 | `app.models` |
| [app.proposal_sending_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L1) | 0 | 13 | 71 | `app.auth`, `app.proposal_sending`, `app.proposal_sending_transport` |
| [app.proposal_sending_transport](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L1) | 2 | 9 | 68 | `app.domain`, `app.proposal_sending` |
| [app.quoting](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L1) | 0 | 28 | 344 | `app.audit`, `app.domain`, `app.flexfields`, `app.models`, `app.pagination`, `app.quoting_models`, `app.repositories` |
| [app.quoting_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L1) | 4 | 0 | 88 | `app.models` |
| [app.quoting_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L1) | 0 | 21 | 147 | `app.auth`, `app.cases`, `app.domain`, `app.flexfields`, `app.forms`, `app.lookups`, `app.models`, `app.pdf`, `app.quoting`, `app.quoting_models` |
| [app.record_references](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/record_references.py#L1) | 0 | 2 | 5 | — |
| [app.reference_choices](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reference_choices.py#L1) | 0 | 4 | 21 | — |
| [app.reports](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reports.py#L1) | 0 | 5 | 108 | `app.archiving`, `app.billing`, `app.domain`, `app.models`, `app.pagination`, `app.project_terms` |
| [app.repositories](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/repositories.py#L1) | 0 | 3 | 28 | `app.archiving`, `app.domain`, `app.models` |
| [app.search_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/search_routes.py#L1) | 0 | 2 | 9 | `app.workspace_search` |
| [app.seed](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/seed.py#L1) | 0 | 1 | 33 | `app.audit`, `app.models` |
| [app.sending](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L1) | 2 | 24 | 290 | `app.audit`, `app.billing`, `app.domain`, `app.models`, `app.pagination`, `app.repositories`, `app.sending_models` |
| [app.sending_dispatch_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L1) | 0 | 5 | 27 | `app.auth`, `app.sending`, `app.sending_routes`, `app.sending_transport` |
| [app.sending_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L1) | 4 | 0 | 65 | `app.models` |
| [app.sending_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L1) | 0 | 18 | 100 | `app.auth`, `app.domain`, `app.forms`, `app.sending` |
| [app.sending_transport](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_transport.py#L1) | 1 | 3 | 51 | `app.config`, `app.sending` |
| [app.settings](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L1) | 0 | 8 | 99 | `app.audit`, `app.clients`, `app.domain`, `app.forms`, `app.models`, `app.repositories` |
| [app.social_auth](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/social_auth.py#L1) | 1 | 3 | 36 | `app.domain`, `app.enrollment` |
| [app.static_assets](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/static_assets.py#L1) | 1 | 3 | 24 | — |
| [app.subscription_billing](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1) | 0 | 48 | 695 | `app.audit`, `app.domain`, `app.forms`, `app.models`, `app.paddle`, `app.repositories`, `app.subscription_billing_models`, `app.subscription_models`, `app.subscriptions`, `app.work_lifecycle` |
| [app.subscription_billing_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L1) | 3 | 0 | 78 | `app.models` |
| [app.subscription_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L1) | 2 | 0 | 32 | `app.models` |
| [app.subscription_payment_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L1) | 0 | 19 | 193 | `app.auth`, `app.domain`, `app.forms`, `app.paddle`, `app.subscription_billing`, `app.subscription_billing_models`, `app.subscriptions` |
| [app.subscription_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L1) | 0 | 7 | 62 | `app.auth`, `app.domain`, `app.forms`, `app.subscription_billing`, `app.subscriptions` |
| [app.subscriptions](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L1) | 2 | 17 | 197 | `app.audit`, `app.domain`, `app.models`, `app.repositories`, `app.subscription_models`, `app.work_lifecycle` |
| [app.tenancy](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L1) | 7 | 20 | 206 | `app.admission_models`, `app.admission_operations`, `app.config`, `app.contact`, `app.db`, `app.integration_auth` |
| [app.tenant_demo](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenant_demo.py#L1) | 0 | 1 | 75 | `app.archiving`, `app.audit`, `app.billing`, `app.cases`, `app.clients`, `app.domain`, `app.mail_service`, `app.models`, `app.project_terms`, `app.tenancy`, `app.timecards` |
| [app.time_command_models](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L1) | 3 | 0 | 50 | `app.models` |
| [app.time_commands](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L1) | 0 | 17 | 291 | `app.archiving`, `app.audit`, `app.domain`, `app.models`, `app.repositories`, `app.time_command_models`, `app.time_import` |
| [app.time_import](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L1) | 0 | 11 | 106 | `app.domain` |
| [app.time_import_routes](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L1) | 0 | 14 | 146 | `app.archiving`, `app.auth`, `app.domain`, `app.models`, `app.repositories`, `app.time_command_models`, `app.time_commands`, `app.time_import` |
| [app.timecards](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L1) | 0 | 7 | 173 | `app.archiving`, `app.audit`, `app.domain`, `app.models`, `app.repositories`, `app.time_command_models` |
| [app.usage](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/usage.py#L1) | 1 | 4 | 36 | `app.logging`, `app.privacy` |
| [app.work_history](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_history.py#L1) | 0 | 3 | 45 | `app.models`, `app.pagination` |
| [app.work_lifecycle](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L1) | 0 | 6 | 56 | `app.archiving`, `app.forms`, `app.models` |
| [app.workspace_operations](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L1) | 1 | 14 | 207 | `app.admission`, `app.admission_operations`, `app.db`, `app.tenancy` |
| [app.workspace_search](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_search.py#L1) | 0 | 3 | 93 | `app.archiving`, `app.models`, `app.quoting_models`, `app.record_references` |
| [scripts.render_invitation](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/scripts/render_invitation.py#L1) | 0 | 2 | 29 | — |

## alembic.env

[alembic/env.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/env.py#L1); exact source SHA-256 `77776dbcf4097173c6ffac8af501b6ef1fd69fed77dd1f217815c4eb564e7334`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `migrate_connection` | function | `connection` | [25–28](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/env.py#L25) |

</details>

## alembic.versions.3f3c0f09ecf4_mail_custody_and_six_month_archive

[alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py#L1); exact source SHA-256 `5546dbd4d323183823febd3ca212dd74e83b7d2081710cd2f5056d1648c72c88`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–175](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py#L13) |
| `downgrade` | function | — | [179–202](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py#L179) |

</details>

## alembic.versions.7e416c6444fe_baseline

[alembic/versions/7e416c6444fe_baseline.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/7e416c6444fe_baseline.py#L1); exact source SHA-256 `8570667b383600a021ec36cdab00f2a3851c50dc5aad8ec5d742fad45b91d0c7`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [14–319](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/7e416c6444fe_baseline.py#L14) |
| `downgrade` | function | — | [323–353](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/7e416c6444fe_baseline.py#L323) |

</details>

## alembic.versions.a10d45de891c_issued_status_guard

[alembic/versions/a10d45de891c_issued_status_guard.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a10d45de891c_issued_status_guard.py#L1); exact source SHA-256 `96a89b00f181fbed439d78cce295958bf6be88033b39b9f40f1b26f9653bfcf2`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [11–46](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a10d45de891c_issued_status_guard.py#L11) |
| `downgrade` | function | — | [49–51](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a10d45de891c_issued_status_guard.py#L49) |

</details>

## alembic.versions.a82d43cf6120_project_workflow_and_agreements

[alembic/versions/a82d43cf6120_project_workflow_and_agreements.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a82d43cf6120_project_workflow_and_agreements.py#L1); exact source SHA-256 `73649633d2736af6891f91024d3f61491b40d5e285ba16ba326f7c00efc4a0a9`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a82d43cf6120_project_workflow_and_agreements.py#L13) |
| `downgrade` | function | — | [66–82](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a82d43cf6120_project_workflow_and_agreements.py#L66) |

</details>

## alembic.versions.b07c9d621a30_pin_guard_schema

[alembic/versions/b07c9d621a30_pin_guard_schema.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/b07c9d621a30_pin_guard_schema.py#L1); exact source SHA-256 `3d3412bd0df933a257df60ba61d1c0458a7d0dd8f21441aeb108414ed2eff7ab`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–28](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/b07c9d621a30_pin_guard_schema.py#L13) |
| `downgrade` | function | — | [31–33](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/b07c9d621a30_pin_guard_schema.py#L31) |

</details>

## alembic.versions.c41894d13cb7_project_commercial_metadata

[alembic/versions/c41894d13cb7_project_commercial_metadata.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c41894d13cb7_project_commercial_metadata.py#L1); exact source SHA-256 `335cd2864120a186f11cbbce4e2906f2e1ab22f71edfb2013d0f354aa9f29bce`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–38](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c41894d13cb7_project_commercial_metadata.py#L13) |
| `downgrade` | function | — | [41–51](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c41894d13cb7_project_commercial_metadata.py#L41) |

</details>

## alembic.versions.c46f2f62a011_immutable_artifacts

[alembic/versions/c46f2f62a011_immutable_artifacts.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c46f2f62a011_immutable_artifacts.py#L1); exact source SHA-256 `e101d2922ca2f5d842055548cf57ae49539763eb1433bb35af6a22a1f3645f55`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [11–76](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c46f2f62a011_immutable_artifacts.py#L11) |
| `downgrade` | function | — | [79–96](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c46f2f62a011_immutable_artifacts.py#L79) |

</details>

## alembic.versions.d3517d81ce20_contact_reservations

[alembic/versions/d3517d81ce20_contact_reservations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d3517d81ce20_contact_reservations.py#L1); exact source SHA-256 `7642340c9545f651c410f986d11e93d973c0f71faded34a590ce0e5bbaf422d7`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–25](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d3517d81ce20_contact_reservations.py#L13) |
| `downgrade` | function | — | [28–29](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d3517d81ce20_contact_reservations.py#L28) |

</details>

## alembic.versions.d529b08f14a2_project_billing

[alembic/versions/d529b08f14a2_project_billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py#L1); exact source SHA-256 `8cde2a842be37f6e2edeb2388398e5772b94335b2bc251a2d7e40a64799a54ad`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_pin` | function | `names` | [17–25](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py#L17) |
| `upgrade` | function | — | [28–212](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py#L28) |
| `downgrade` | function | — | [215–248](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py#L215) |

</details>

## alembic.versions.e3b42aea781a_parent_guards_and_sessions

[alembic/versions/e3b42aea781a_parent_guards_and_sessions.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e3b42aea781a_parent_guards_and_sessions.py#L1); exact source SHA-256 `2514f05093a597f52a618b2141526e137755c5c728e32704b749ebfce97eedc4`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–57](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e3b42aea781a_parent_guards_and_sessions.py#L13) |
| `downgrade` | function | — | [60–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e3b42aea781a_parent_guards_and_sessions.py#L60) |

</details>

## alembic.versions.e640ab7230cd_case_identity_and_types

[alembic/versions/e640ab7230cd_case_identity_and_types.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L1); exact source SHA-256 `6a50cd2b360207042a7f5c31c9326d89cb4318e20efdbd7f5cda78c19c5163fd`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_empty_preflight` | function | — | [13–20](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L13) |
| `_pin` | function | — | [23–30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L23) |
| `_mail_case_lock` | function | `enabled` | [33–75](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L33) |
| `upgrade` | function | — | [78–133](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L78) |
| `downgrade` | function | — | [136–178](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L136) |

</details>

## alembic.versions.e672c40fa912_cases_and_allocations

[alembic/versions/e672c40fa912_cases_and_allocations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e672c40fa912_cases_and_allocations.py#L1); exact source SHA-256 `c342d896866a8bf90e98f8c432050cb5979550ed3181137970fc326e223037a9`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `entity_columns` | function | — | [13–18](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e672c40fa912_cases_and_allocations.py#L13) |
| `upgrade` | function | — | [21–169](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e672c40fa912_cases_and_allocations.py#L21) |
| `downgrade` | function | — | [172–185](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e672c40fa912_cases_and_allocations.py#L172) |

</details>

## alembic.versions.f409a1ac1700_parent_lock_guards

[alembic/versions/f409a1ac1700_parent_lock_guards.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f409a1ac1700_parent_lock_guards.py#L1); exact source SHA-256 `4cee6118c21cb895b9c1a183739ac1837e4ece5331af376c59255a68911c340a`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [11–43](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f409a1ac1700_parent_lock_guards.py#L11) |
| `downgrade` | function | — | [46–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f409a1ac1700_parent_lock_guards.py#L46) |

</details>

## alembic.versions.f710bc319ae2_mail_attachment_custody

[alembic/versions/f710bc319ae2_mail_attachment_custody.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f710bc319ae2_mail_attachment_custody.py#L1); exact source SHA-256 `bac187ef38a608d5c794e8495e383c42dfb69ea8d6ea8645dd4a4f52baea2a7a`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–65](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f710bc319ae2_mail_attachment_custody.py#L13) |
| `downgrade` | function | — | [68–74](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f710bc319ae2_mail_attachment_custody.py#L68) |

</details>

## alembic.versions.ph2_001_credit_memos

[alembic/versions/ph2_001_credit_memos.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py#L1); exact source SHA-256 `c8d79b29322e46bb5d68a04bfa6953e32fdb7526ca3aac4c6fc6db45c502dbf7`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [14–115](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py#L14) |
| `downgrade` | function | — | [118–129](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py#L118) |

</details>

## alembic.versions.ph2_002_time_commands

[alembic/versions/ph2_002_time_commands.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L1); exact source SHA-256 `2760dd9b1efc7a4bba705468d8915204bae2068c1a49ac681c60ff3b800b986c`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_entity` | function | — | [14–19](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L14) |
| `upgrade` | function | — | [22–163](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L22) |
| `downgrade` | function | — | [166–190](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L166) |

</details>

## alembic.versions.ph2_003_integrations

[alembic/versions/ph2_003_integrations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_003_integrations.py#L1); exact source SHA-256 `aaca02a6e9db2e2515393e1ba12264574f305a1cbd332f8527f956958451360c`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `entity_columns` | function | — | [14–19](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_003_integrations.py#L14) |
| `upgrade` | function | — | [22–81](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_003_integrations.py#L22) |
| `downgrade` | function | — | [84–104](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_003_integrations.py#L84) |

</details>

## alembic.versions.ph3_001_subscriptions

[alembic/versions/ph3_001_subscriptions.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_001_subscriptions.py#L1); exact source SHA-256 `8a671d6355bd80b43239596e94fa94dc8f7ede7835e52d168a8a429498096d8a`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [14–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_001_subscriptions.py#L14) |
| `downgrade` | function | — | [66–82](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_001_subscriptions.py#L66) |

</details>

## alembic.versions.ph3_002_sandbox_billing

[alembic/versions/ph3_002_sandbox_billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_002_sandbox_billing.py#L1); exact source SHA-256 `ad8af64c3f14f8143d02dc9efe767ce68402639399166a22e916fa341e4cef09`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [14–132](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_002_sandbox_billing.py#L14) |
| `downgrade` | function | — | [135–158](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_002_sandbox_billing.py#L135) |

</details>

## alembic.versions.ph3_003_onboarding_auth

[alembic/versions/ph3_003_onboarding_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_003_onboarding_auth.py#L1); exact source SHA-256 `8b4d28cf64781e7cd198f5769733f143ffe12d21186d08737d3962d92138a0d2`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `common` | function | — | [13–19](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_003_onboarding_auth.py#L13) |
| `upgrade` | function | — | [22–102](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_003_onboarding_auth.py#L22) |
| `downgrade` | function | — | [105–113](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_003_onboarding_auth.py#L105) |

</details>

## alembic.versions.ph3_004_sending

[alembic/versions/ph3_004_sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_004_sending.py#L1); exact source SHA-256 `e269d73e8a835f46987e4ea304a25f6b5bdb89bfa3eba0541a1ebb765debc24e`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `common` | function | — | [13–18](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_004_sending.py#L13) |
| `upgrade` | function | — | [21–156](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_004_sending.py#L21) |
| `downgrade` | function | — | [159–169](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_004_sending.py#L159) |

</details>

## alembic.versions.ph3_005_public_admission

[alembic/versions/ph3_005_public_admission.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_005_public_admission.py#L1); exact source SHA-256 `59036e375d5875b42d8de8d134b71d5ed8ed7056df122b4f2ac6df4d272ea2bc`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `common` | function | — | [13–18](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_005_public_admission.py#L13) |
| `upgrade` | function | — | [21–99](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_005_public_admission.py#L21) |
| `downgrade` | function | — | [102–110](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_005_public_admission.py#L102) |

</details>

## alembic.versions.ph3_006_quoting_library

[alembic/versions/ph3_006_quoting_library.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py#L1); exact source SHA-256 `8a851a397894f99dedb11fa3a322346327ca22407f209ee3f6647d371b58bd38`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `create_tables` | function | — | [13–278](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py#L13) |
| `upgrade` | function | — | [281–525](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py#L281) |
| `downgrade` | function | — | [528–544](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py#L528) |

</details>

## alembic.versions.ph3_007_work_records

[alembic/versions/ph3_007_work_records.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L1); exact source SHA-256 `5de9f8aee0166f1eed32abdec3000f9633d41dd6aecb0256057d6a46638c41b3`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `entry_guard` | function | `internal` | [194–230](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L194) |
| `flexfields_constraint` | function | — | [234–242](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L234) |
| `upgrade` | function | — | [245–336](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L245) |
| `downgrade` | function | — | [339–372](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L339) |

</details>

## alembic.versions.ph3_008_client_lifecycle

[alembic/versions/ph3_008_client_lifecycle.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_008_client_lifecycle.py#L1); exact source SHA-256 `9f2e5027dabe0256522c224b412453d79d64df9fee7f9ff570f3bd7f4ceac1d8`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–25](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_008_client_lifecycle.py#L13) |
| `downgrade` | function | — | [28–34](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_008_client_lifecycle.py#L28) |

</details>

## alembic.versions.ph3_009_read_indexes

[alembic/versions/ph3_009_read_indexes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_009_read_indexes.py#L1); exact source SHA-256 `95e6579d5993aa015445e91f56a073125f227e2728f0f11451ef46bceff5355b`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `upgrade` | function | — | [13–20](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_009_read_indexes.py#L13) |
| `downgrade` | function | — | [23–26](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_009_read_indexes.py#L23) |

</details>

## app.__init__

[app/__init__.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/__init__.py); exact source SHA-256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.

No class/function declarations.

## app.admission

[app/admission.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L1); exact source SHA-256 `0c1b63f9debbed17322fc79f529014f2cdd3834044949b6c0e7ecec3706a78b8`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `AdmissionError` | class | — | [23–30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L23) |
| `AdmissionError.__init__` | function | `self`, `code` | [24–30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L24) |
| `_lock` | function | `db` | [33–34](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L33) |
| `_proof` | function | `issuer`, `subject`, `email` | [37–41](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L37) |
| `_provider_proof` | function | `registry`, `issuer`, `subject`, `email` | [44–50](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L44) |
| `_fault` | function | `callback`, `phase` | [53–55](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L53) |
| `identity_record` | function | `registry`, `issuer`, `subject` | [58–61](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L58) |
| `_local_identity` | function | `tenant`, `locator` | [64–74](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L64) |
| `resolve_identity` | function | `registry`, `issuer`, `subject` | [77–89](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L77) |
| `_initialize` | function | `registry`, `allocation`, `locator`, `request_id` | [92–128](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L92) |
| `_initialization_readback` | function | `registry`, `allocation`, `locator` | [131–139](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L131) |
| `admit` | function | `registry`, `issuer`, `subject`, `email`, `signup`, `request_id`, `fault` | [142–207](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L142) |
| `fresh_owner` | function | `db`, `tenant`, `owner_id`, `proof` | [210–222](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L210) |
| `link_identity` | function | `registry`, `tenant`, `owner_id`, `proof`, `issuer`, `subject`, `email`, `request_id`, `fault` | [225–263](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L225) |
| `revoke_identity` | function | `registry`, `tenant`, `owner_id`, `identity_id`, `proof`, `request_id`, `fault` | [266–313](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L266) |
| `challenge_digest` | function | `settings`, `purpose`, `value` | [316–319](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L316) |
| `reserve_public_email` | function | `registry`, `email`, `nonce`, `intent`, `offer`, `return_to`, `network` | [322–348](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L322) |
| `public_email_delivery` | function | `registry`, `identifier`, `accepted` | [351–358](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L351) |
| `pending_public_email` | function | `registry`, `identifier`, `nonce`, `email`, `intent`, `offer`, `return_to` | [361–375](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L361) |
| `claim_public_email` | function | `registry`, `identifier`, `nonce` | [378–398](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L378) |
| `finish_public_email` | function | `registry`, `identifier`, `nonce`, `succeeded` | [401–407](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L401) |

</details>

## app.admission_models

[app/admission_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L1); exact source SHA-256 `dc8149b178ca17241e5617b149a7e759618f4501b4f4fa3f37ac9ae929fa6d82`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `WorkspaceAdmission` | class | — | [12–23](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L12) |
| `AdmissionIdentity` | class | — | [26–40](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L26) |
| `PublicEmailChallenge` | class | — | [43–61](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L43) |

</details>

## app.admission_operations

[app/admission_operations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_operations.py#L1); exact source SHA-256 `fac6b66ace9f8ed864c1d5e51ed619308e9c5619ffe0dde61d93e6b060443dd5`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `synchronize_identities` | function | `registry`, `apply` | [15–76](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_operations.py#L15) |
| `apply_directory_grants` | function | `connection`, `registry` | [79–87](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_operations.py#L79) |
| `verify_admission_readiness` | function | `registry` | [90–142](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_operations.py#L90) |

</details>

## app.archive_routes

[app/archive_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L1); exact source SHA-256 `e7593836df627b8b0d79783de66434ae99d242e5ed8fc3872b45b3dc7b5020bf`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `export_range` | function | `start`, `end` | [19–26](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L19) |
| `csv_cell` | function | `value` | [29–40](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L29) |
| `_csv_rows` | function | `db`, `query`, `headings` | [43–64](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L43) |
| `_export` | function | `request`, `query`, `headings`, `filename` | [67–83](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L67) |
| `build_router` | function | `page`, `mutate` | [86–232](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L86) |
| `build_router.export_timecards` | async_function | `request`, `start`, `end` | [90–166](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L90) |
| `build_router.export_mail` | async_function | `request`, `start`, `end` | [169–221](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L169) |
| `build_router.archive_now_action` | async_function | `request` | [224–230](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L224) |

</details>

## app.archiving

[app/archiving.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L1); exact source SHA-256 `7be273c2ef6b70b70443949756e8110d705453433b3e7b47b4d7d072ed968430`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `cutoff_months` | function | `value`, `months` | [17–21](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L17) |
| `archive_now` | function | `now` | [24–28](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L24) |
| `card_is_archived` | function | `card`, `client`, `now` | [31–35](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L31) |
| `active_card_predicate` | function | `now` | [38–42](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L38) |
| `mail_is_archived` | function | `message`, `now` | [45–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L45) |
| `active_mail_predicate` | function | `now` | [51–57](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L51) |
| `run_archive` | function | `db`, `actor`, `request_id`, `now`, `cases_only` | [60–184](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L60) |

</details>

## app.audit

[app/audit.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/audit.py#L1); exact source SHA-256 `a46e464b8db010fd3ef47b7d931b99744ced06a6c15e356d074a77eb9806d5a8`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `record` | function | `db`, `actor`, `action`, `entity`, `request_id` | [8–19](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/audit.py#L8) |

</details>

## app.auth

[app/auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L1); exact source SHA-256 `580faa0592f9be8133db78a3e18eb7227838a3e99813b8f55a88eec2c498941b`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `EnrollmentRequired` | class | — | [13–16](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L13) |
| `EnrollmentRequired.__init__` | function | `self`, `destination` | [14–16](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L14) |
| `authenticate` | function | `db`, `settings`, `claims` | [19–33](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L19) |
| `authenticate_identity` | function | `db`, `settings`, `owner_id`, `issuer`, `subject` | [36–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L36) |
| `principal` | function | `request`, `pending` | [51–84](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L51) |
| `owner` | function | `request` | [87–100](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L87) |
| `csrf_token` | function | `request` | [103–106](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L103) |
| `checked_form` | async_function | `request` | [109–117](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L109) |
| `verify_csrf` | function | `request`, `token` | [120–126](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L120) |

</details>

## app.billing

[app/billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L1); exact source SHA-256 `26c868e306e9dc9c1e7129b17680d73cc18313d9594bda01e90ec68181e616e9`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_new_invoice` | function | `db`, `client_id`, `currency`, `start`, `end`, `prefix` | [34–52](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L34) |
| `_project_snapshot` | function | `project` | [55–62](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L55) |
| `project_billing_summary` | function | `db`, `project_id` | [65–92](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L65) |
| `_charge_project` | function | `db`, `actor`, `project_id`, `historical_time` | [95–106](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L95) |
| `set_project_overbilling` | function | `db`, `actor`, `project_id`, `allowed`, `request_id` | [109–115](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L109) |
| `create_fixed_fee_draft` | function | `db`, `actor`, `project_id`, `start`, `end`, `prefix`, `request_id` | [118–147](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L118) |
| `create_manual_extra_draft` | function | `db`, `actor`, `project_id`, `start`, `end`, `amount`, `reason`, `reference`, `prefix`, `request_id` | [150–198](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L150) |
| `create_draft` | function | `db`, `actor`, `client_id`, `start`, `end`, `prefix`, `request_id` | [201–283](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L201) |
| `adjust_draft` | function | `db`, `actor`, `invoice_id`, `data`, `request_id` | [286–322](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L286) |
| `build_snapshot` | function | `db`, `invoice`, `issued`, `encryption_key` | [325–393](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L325) |
| `issue` | function | `db`, `actor`, `invoice_id`, `request_id`, `encryption_key` | [396–455](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L396) |
| `artifact_bytes` | function | `db`, `invoice_id`, `encryption_key` | [458–472](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L458) |
| `payment_totals` | function | `db`, `invoice_ids` | [475–485](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L475) |
| `paid_amount` | function | `db`, `invoice_id`, `paid_totals` | [488–495](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L488) |
| `balance` | function | `db`, `invoice`, `paid_totals` | [498–501](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L498) |
| `display_status` | function | `db`, `invoice`, `today`, `paid_totals` | [504–516](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L504) |
| `invoice_values` | function | `db`, `invoices`, `paid_totals`, `today` | [519–531](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L519) |
| `listing_query` | function | `status` | [534–548](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L534) |
| `mark_sent` | function | `db`, `actor`, `invoice_id`, `delivered`, `request_id` | [551–561](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L551) |
| `correct_due` | function | `db`, `actor`, `invoice_id`, `due`, `reason`, `request_id` | [564–569](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L564) |
| `pay` | function | `db`, `actor`, `invoice_id`, `data`, `request_id` | [572–605](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L572) |
| `reverse_payment` | function | `db`, `actor`, `payment_id`, `reason`, `request_id` | [608–615](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L608) |
| `_cancellation_owner` | function | `db`, `actor`, `reason` | [618–625](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L618) |
| `_release_invoice` | function | `db`, `actor`, `invoice`, `reason`, `request_id`, `action` | [628–651](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L628) |
| `credit_memo_for_invoice` | function | `db`, `invoice_id` | [654–655](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L654) |
| `void` | function | `db`, `actor`, `invoice_id`, `reason`, `request_id`, `prefix` | [658–721](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L658) |
| `cancel_draft` | function | `db`, `actor`, `invoice_id`, `reason`, `request_id` | [724–733](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L724) |
| `credit_memo_bytes` | function | `db`, `memo_id` | [736–746](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L736) |

</details>

## app.bot_check

[app/bot_check.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/bot_check.py#L1); exact source SHA-256 `2863beef71e5ac4791e71a3561aa8380acee689150a41c12f87a3a7765a45b2f`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `verify_sign_in` | async_function | `settings`, `token`, `transport`, `action` | [13–36](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/bot_check.py#L13) |

</details>

## app.case_routes

[app/case_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L1); exact source SHA-256 `2dcabe45643897df4b3088b3bf5454de0ccb375be775c42281ef3299a60532f0`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `build_router` | function | `page`, `mutate` | [20–546](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L20) |
| `build_router.mass_edit_page` | function | `request`, `values`, `errors` | [23–57](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L23) |
| `build_router.quoting_context` | function | `request`, `values` | [59–70](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L59) |
| `build_router.case_form` | function | `request`, `client_id`, `case_id`, `form_values`, `errors` | [72–122](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L72) |
| `build_router.case_list` | async_function | `request`, `q`, `status`, `client_id`, `project_id`, `archived`, `closed`, `sort`, `direction`, `p` | [125–243](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L125) |
| `build_router.case_mass_edit` | async_function | `request` | [246–247](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L246) |
| `build_router.case_mass_save` | async_function | `request` | [250–280](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L250) |
| `build_router.case_mass_save.action` | function | `db`, `actor`, `data`, `rid` | [253–271](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L253) |
| `build_router.new_case` | async_function | `request`, `client_id` | [283–284](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L283) |
| `build_router.create_case` | async_function | `request` | [287–324](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L287) |
| `build_router.create_case.action` | function | `db`, `actor`, `data`, `rid` | [296–301](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L296) |
| `build_router.create_case.error` | function | `form`, `errors` | [303–308](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L303) |
| `build_router.create_case.destination` | function | `item` | [310–320](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L310) |
| `build_router.case_detail` | async_function | `request`, `case_id` | [327–354](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L327) |
| `build_router.edit_case` | async_function | `request`, `case_id` | [357–358](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L357) |
| `build_router.update_case` | async_function | `request`, `case_id` | [361–376](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L361) |
| `build_router.update_case.action` | function | `db`, `actor`, `data`, `rid` | [366–368](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L366) |
| `build_router.archive_case` | async_function | `request`, `case_id` | [379–387](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L379) |
| `build_router.allocation_page` | function | `request`, `entry_id`, `form_values`, `errors` | [389–432](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L389) |
| `build_router.allocations` | async_function | `request`, `entry_id` | [435–436](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L435) |
| `build_router.allocation_save` | async_function | `request`, `entry_id` | [439–467](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L439) |
| `build_router.allocation_save.action` | function | `db`, `actor`, `data`, `rid` | [444–460](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L444) |
| `build_router.archive` | async_function | `request` | [470–544](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L470) |

</details>

## app.cases

[app/cases.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L1); exact source SHA-256 `ae33205efa12b46fd85037f8c0479f1788786059c84eb782a0c6843412cbe8fa`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_owner` | function | `db`, `actor` | [32–35](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L32) |
| `owned_case` | function | `db`, `actor`, `case_id`, `lock` | [38–46](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L38) |
| `save_case` | function | `db`, `actor`, `client_id`, `data`, `case_id`, `request_id` | [49–133](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L49) |
| `archive_case` | function | `db`, `actor`, `case_id`, `expected_version`, `request_id`, `confirmed` | [136–147](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L136) |
| `mass_update` | function | `db`, `actor`, `project_id`, `rows`, `confirmed_close`, `request_id` | [150–191](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L150) |
| `set_allocation` | function | `db`, `actor`, `entry_id`, `case_id`, `minutes`, `expected_version`, `request_id` | [194–256](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L194) |
| `case_activity` | function | `db`, `actor`, `case_id`, `number` | [259–293](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L259) |

</details>

## app.cli

[app/cli.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cli.py#L1); exact source SHA-256 `120e5b1dddb256335bb8eb2336ce6bc45e4ed9855aac0de14c36c65366556db9`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `main` | function | — | [24–139](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cli.py#L24) |

</details>

## app.client_drafts

[app/client_drafts.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_drafts.py#L1); exact source SHA-256 `c25a759c44732499616f26187c931b3e76af2831f8630a3474af979eb6ce900d`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `validate_draft` | function | `data` | [23–50](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_drafts.py#L23) |
| `create_draft` | function | `db`, `actor`, `data`, `request_id` | [53–68](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_drafts.py#L53) |

</details>

## app.client_sources

[app/client_sources.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L1); exact source SHA-256 `08efd63c7b78a3bdd3a14eaab8d93d8abe69185fc4bfb2556f06811ad27825e3`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `safe_link` | function | `value` | [27–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L27) |
| `uploaded_form` | async_function | `request` | [42–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L42) |
| `uploaded_form.receive` | async_function | — | [52–53](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L52) |
| `source_for` | function | `db`, `client_id` | [66–67](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L66) |
| `save` | function | `db`, `actor`, `client_id`, `data`, `upload`, `request_id` | [70–104](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L70) |
| `download` | function | `db`, `actor`, `client_id`, `reference_id` | [107–127](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L107) |

</details>

## app.clients

[app/clients.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L1); exact source SHA-256 `c66d4e32e0fd354150af5717ac1d952464ff2688d5596c55767f7e691fdcfddf`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `text` | function | `value`, `maximum`, `required` | [19–23](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L19) |
| `_client_transition` | function | `db`, `actor`, `client`, `status`, `activation_data`, `confirmed` | [26–45](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L26) |
| `update_client` | function | `db`, `actor`, `data`, `entity_id`, `request_id`, `operation_key` | [48–166](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L48) |
| `archive_client` | function | `db`, `actor`, `entity_id`, `request_id`, `desired_status`, `expected_version`, `operation_key`, `confirmed` | [169–213](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L169) |
| `save_project` | function | `db`, `actor`, `client_id`, `data`, `project_id`, `request_id`, `operation_key` | [216–325](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L216) |
| `save_contact` | function | `db`, `actor`, `client_id`, `data`, `contact_id`, `request_id` | [328–343](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L328) |
| `missing_fields` | function | `client` | [346–347](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L346) |

</details>

## app.config

[app/config.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L1); exact source SHA-256 `0cdf336021c1e0aa9f57eeddaa2890f8923b186eeb90184f8fa5d6610a8712d0`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `Settings` | class | — | [14–249](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L14) |
| `Settings.__post_init__` | function | `self` | [65–200](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L65) |
| `Settings.enrollment_active` | function | `self` | [203–204](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L203) |
| `Settings.hosted` | function | `self` | [207–208](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L207) |
| `Settings.commercial_documents_available` | function | `self` | [211–212](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L211) |
| `Settings.sending_available` | function | `self` | [215–216](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L215) |
| `Settings.sending_enabled` | function | `self` | [219–220](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L219) |
| `Settings.from_env` | function | `cls` | [223–249](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L223) |

</details>

## app.contact

[app/contact.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L1); exact source SHA-256 `1a643a8dc3f1be76778d16d29fa4f8544072d2e111f423550dfd528d99b357f3`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `ContactService` | class | — | [31–193](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L31) |
| `ContactService.__init__` | function | `self`, `settings`, `factory`, `secret` | [32–36](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L32) |
| `ContactService.digest` | function | `self`, `purpose`, `value` | [38–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L38) |
| `ContactService.token` | function | `self`, `request` | [41–44](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L41) |
| `ContactService.retry_after` | function | `self`, `request` | [46–56](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L46) |
| `ContactService.identity` | function | `self`, `request`, `form` | [58–75](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L58) |
| `ContactService.admit` | function | `self`, `identifier`, `session`, `address`, `network`, `payload`, `reserve`, `now` | [77–137](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L77) |
| `ContactService.deliver` | async_function | `self`, `email`, `message`, `identifier` | [139–149](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L139) |
| `ContactService.submit` | async_function | `self`, `request` | [151–187](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L151) |
| `ContactService.complete` | function | `self`, `identifier`, `status` | [189–193](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L189) |
| `contact_form` | async_function | `request` | [196–215](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/contact.py#L196) |

</details>

## app.credit_memo_models

[app/credit_memo_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/credit_memo_models.py#L1); exact source SHA-256 `19971f8d366cdab98e7ccd0fd44926c5b7b89b6061eda5d65a13eae88f1dddfe`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `CreditMemo` | class | — | [14–33](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/credit_memo_models.py#L14) |

</details>

## app.dashboard

[app/dashboard.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/dashboard.py#L1); exact source SHA-256 `f243a01ee9e431b11365c6b3cac7a1acdfbffb6a081de90df0f374cdb23526c4`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_contributions` | function | `daily`, `start`, `today` | [11–21](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/dashboard.py#L11) |
| `work_overview` | function | `db`, `owner_id`, `today` | [24–79](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/dashboard.py#L24) |

</details>

## app.db

[app/db.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L1); exact source SHA-256 `fd7fef0f3511e94d740eb2878349e0a02f0fb2c0382b1eae9a06007bd44adf50`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `session_factory` | function | `url`, `pool_size`, `expected_role`, `expected_schema` | [9–29](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L9) |
| `session_factory.verify_fixed_identity` | function | `connection`, `_record` | [22–27](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L22) |

</details>

## app.demo

[app/demo.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/demo.py#L1); exact source SHA-256 `0d6001f34d760b3c9bff4e60d72ab73da21405adfadf82d45d216f25eb846aeb`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `seed_demo` | function | `db`, `settings` | [15–142](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/demo.py#L15) |

</details>

## app.domain

[app/domain.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L1); exact source SHA-256 `d63afdf63d9fd40f45426f2c88482f74185efc361225ad6ea195d8ae21dddb70`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `DomainError` | class | — | [9–10](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L9) |
| `parse_duration` | function | `raw` | [13–31](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L13) |
| `money` | function | `raw`, `signed` | [34–45](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L34) |
| `line_amount` | function | `minutes`, `rate` | [48–49](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L48) |
| `week_start` | function | `value`, `zone` | [52–57](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L52) |
| `hours` | function | `minutes` | [60–61](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L60) |
| `business_today` | function | `zone` | [64–67](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/domain.py#L64) |

</details>

## app.email_auth

[app/email_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L1); exact source SHA-256 `db24f443e5512f013277a3b075dd66d846cf1cf6988e4aa6b96f5b91ce642067`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `EmailAuthError` | class | — | [19–21](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L19) |
| `EmailAuthError.__init__` | function | `self` | [20–21](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L20) |
| `delivery_mode` | function | `value` | [24–27](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L24) |
| `preview_token` | function | `settings`, `identifier`, `nonce`, `email` | [34–49](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L34) |
| `preview_email` | function | `settings`, `token`, `identifier`, `nonce` | [52–66](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L52) |
| `recent_preview` | function | `settings`, `token`, `identifier`, `nonce`, `email` | [69–77](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L69) |
| `opaque_route` | function | `settings`, `tenant_id` | [80–86](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L80) |
| `route_identifier` | function | `settings`, `value` | [89–98](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L89) |
| `SupabaseEmail` | class | — | [101–173](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L101) |
| `SupabaseEmail.__init__` | function | `self`, `settings`, `transport` | [102–108](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L102) |
| `SupabaseEmail._request` | async_function | `self`, `method`, `path`, `data`, `token` | [110–126](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L110) |
| `SupabaseEmail.send` | async_function | `self`, `email`, `captcha`, `delivery`, `public_signup` | [128–150](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L128) |
| `SupabaseEmail.verify` | async_function | `self`, `email`, `code` | [152–173](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L152) |
| `digest` | function | `value` | [176–177](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L176) |
| `reserve` | function | `db`, `owner_id`, `session_nonce`, `intent`, `selected_offer` | [180–208](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L180) |
| `locked_challenge` | function | `db`, `identifier`, `nonce`, `states` | [211–228](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L211) |

</details>

## app.enrollment

[app/enrollment.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L1); exact source SHA-256 `9e42373a0670371700bcc8b3d772b434406ff0cee01ac5145343f6b0529b9661`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `offer` | function | `value` | [24–27](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L24) |
| `identity_proof` | function | `issuer`, `subject`, `email` | [30–43](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L30) |
| `bound_identity` | function | `db`, `owner_id`, `issuer`, `subject` | [46–54](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L46) |
| `bind_identity` | function | `db`, `owner_id`, `issuer`, `subject`, `email`, `request_id`, `independent_owner_proof`, `identity_id` | [57–87](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L57) |
| `registration` | function | `db`, `owner_id` | [90–98](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L90) |
| `acknowledged` | function | `db`, `owner_id` | [101–108](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L101) |
| `active_plan` | function | `db`, `owner_id` | [111–123](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L111) |
| `workspace_ready` | function | `db`, `owner_id` | [126–141](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L126) |
| `bootstrap_email_identity` | function | `db`, `settings`, `owner_id`, `provider_user_id`, `email`, `request_id` | [144–154](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L144) |
| `revoke_identity` | function | `db`, `owner_id`, `identity_id`, `request_id` | [157–176](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L157) |
| `current_notice` | function | — | [179–185](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L179) |
| `captured_notice` | function | `values` | [188–193](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L188) |
| `_record_registration` | function | `db`, `owner_id`, `issuer`, `subject`, `email`, `selected`, `acceptance_method`, `notice_revision`, `request_id` | [196–215](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L196) |
| `accept_registration` | function | `db`, `owner_id`, `issuer`, `subject`, `email`, `chosen_offer`, `data`, `request_id` | [218–234](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L218) |
| `accept_sign_in_notice` | function | `db`, `owner_id`, `issuer`, `subject`, `email`, `flow`, `request_id` | [237–245](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L237) |

</details>

## app.enrollment_models

[app/enrollment_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L1); exact source SHA-256 `cc28a549353c52c5c0abbdbceb0db19c88bf4774ba2fddc5c20dd6f37a2a1c0d`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `OwnerIdentity` | class | — | [12–23](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L12) |
| `OwnerRegistration` | class | — | [26–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L26) |
| `EmailAuthChallenge` | class | — | [42–56](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L42) |

</details>

## app.enrollment_routes

[app/enrollment_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L1); exact source SHA-256 `a3998de8ce63ad635412b853fc8667d8dae65947706ef076d81d5bd3d00cf0ff`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `closed_return` | function | `value` | [20–23](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L20) |
| `selected_flow` | function | `request`, `values`, `mode` | [26–33](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L26) |
| `issue_session` | function | `request`, `user`, `tenant`, `issuer`, `subject`, `pending`, `return_to` | [36–55](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L36) |
| `registration_destination` | function | `request`, `ready`, `fallback` | [58–61](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L58) |
| `fresh` | function | `request` | [64–66](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L64) |
| `account_form` | async_function | `request`, `allowed` | [69–74](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L69) |
| `router` | function | `page` | [77–698](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L77) |
| `router.legal_policies` | async_function | `request` | [81–88](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L81) |
| `router.enabled` | function | `request` | [90–92](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L90) |
| `router.auth_page` | function | `request`, `mode`, `values`, `errors`, `status_code`, `show_challenge` | [94–126](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L94) |
| `router.sign_in` | async_function | `request` | [129–130](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L129) |
| `router.sign_up` | async_function | `request` | [133–134](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L133) |
| `router.registration_page` | function | `request`, `errors`, `status_code` | [136–183](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L136) |
| `router.registration` | async_function | `request` | [186–187](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L186) |
| `router.acknowledge` | async_function | `request` | [190–229](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L190) |
| `router.activate_free` | async_function | `request` | [232–261](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L232) |
| `router.security_page` | function | `request`, `errors`, `status_code` | [263–304](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L263) |
| `router.security` | async_function | `request` | [307–308](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L307) |
| `router.revoke_email` | async_function | `request` | [311–357](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L311) |
| `router.start_email` | async_function | `request`, `linking` | [359–510](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L359) |
| `router.email_start` | async_function | `request` | [513–514](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L513) |
| `router.email_link_start` | async_function | `request` | [517–518](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L517) |
| `router.verify_email` | async_function | `request`, `linking` | [520–688](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L520) |
| `router.email_verify` | async_function | `request` | [691–692](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L691) |
| `router.email_link_verify` | async_function | `request` | [695–696](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L695) |

</details>

## app.flexfields

[app/flexfields.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/flexfields.py#L1); exact source SHA-256 `1882b10eb980459912e06a76ef747209b799f60d9ab59987b6ecd8c74cc511b0`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `normalize` | function | `data` | [14–47](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/flexfields.py#L14) |
| `apply_flexfields` | function | `db`, `actor_id`, `entity`, `data`, `request_id` | [50–58](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/flexfields.py#L50) |

</details>

## app.forms

[app/forms.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L1); exact source SHA-256 `0853ec143e8042173756d54f0a4ae23ee12e208c6a3ce6cf8a53021498c263d3`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `FormError` | class | — | [9–12](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L9) |
| `FormError.__init__` | function | `self`, `errors` | [10–12](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L10) |
| `normalize_client_code` | function | `value` | [15–19](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L15) |
| `client_activation_errors` | function | `data` | [22–27](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L22) |
| `validate_client` | function | `data` | [30–93](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L30) |
| `validate_week` | function | `data` | [96–116](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L96) |

</details>

## app.integration_auth

[app/integration_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L1); exact source SHA-256 `954d534e609376db32270c4592e3da28824515e7104a12b719912effad2456c6`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `IntegrationError` | class | — | [56–59](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L56) |
| `IntegrationError.__init__` | function | `self`, `code`, `status` | [57–59](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L57) |
| `integration_path` | function | `path` | [62–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L62) |
| `digest` | function | `value` | [66–67](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L66) |
| `parse_credential` | function | `raw`, `kind` | [70–79](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L70) |
| `new_credential` | function | `kind`, `tenant_id`, `identifier` | [82–83](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L82) |
| `request_tenant` | function | `registry`, `authorization_header` | [86–94](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L86) |
| `credential_tenant` | function | `registry`, `raw`, `kind` | [97–102](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L97) |
| `RegisteredClient` | class | — | [106–135](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L106) |
| `RegisteredClient.get_client_id` | function | `self` | [111–112](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L111) |
| `RegisteredClient.get_default_redirect_uri` | function | `self` | [114–115](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L114) |
| `RegisteredClient.get_allowed_scope` | function | `self`, `scope` | [117–120](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L117) |
| `RegisteredClient.check_redirect_uri` | function | `self`, `redirect_uri` | [122–123](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L122) |
| `RegisteredClient.check_client_secret` | function | `self`, `_secret` | [125–126](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L125) |
| `RegisteredClient.check_endpoint_auth_method` | function | `self`, `method`, `endpoint` | [128–129](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L128) |
| `RegisteredClient.check_response_type` | function | `self`, `response_type` | [131–132](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L131) |
| `RegisteredClient.check_grant_type` | function | `self`, `grant_type` | [134–135](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L134) |
| `authorization_form_origin` | function | `redirect_uri` | [138–144](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L138) |
| `registered_clients` | function | `settings` | [147–189](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L147) |
| `resources` | function | `settings` | [192–194](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L192) |
| `validate_authorization` | function | `data`, `settings` | [197–217](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L197) |
| `authorization_resume` | function | `request` | [220–228](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L220) |
| `grant_owner` | function | `db`, `grant`, `tenant`, `registry` | [231–251](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L231) |
| `authenticate_access` | function | `db`, `tenant`, `registry`, `raw`, `resource`, `scope`, `lock` | [254–279](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L254) |
| `AdapterRequest` | class | — | [282–293](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L282) |
| `AdapterRequest.__init__` | function | `self`, `method`, `uri`, `data` | [283–285](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L283) |
| `AdapterRequest.form` | function | `self` | [288–289](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L288) |
| `AdapterRequest.args` | function | `self` | [292–293](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L292) |
| `S256Challenge` | class | — | [296–304](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L296) |
| `S256Challenge.validate_code_challenge` | function | `self`, `grant`, `redirect_uri` | [299–304](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L299) |
| `CodeGrant` | class | — | [307–378](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L307) |
| `CodeGrant.generate_authorization_code` | function | `self` | [310–311](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L310) |
| `CodeGrant.save_authorization_code` | function | `self`, `code`, `request` | [313–347](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L313) |
| `CodeGrant.query_authorization_code` | function | `self`, `code`, `client` | [349–372](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L349) |
| `CodeGrant.authenticate_user` | function | `self`, `_code` | [374–375](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L374) |
| `CodeGrant.delete_authorization_code` | function | `self`, `authorization_code` | [377–378](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L377) |
| `RotatingRefreshGrant` | class | — | [381–419](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L381) |
| `RotatingRefreshGrant.authenticate_refresh_token` | function | `self`, `raw` | [385–413](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L385) |
| `RotatingRefreshGrant.authenticate_user` | function | `self`, `_token` | [415–416](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L415) |
| `RotatingRefreshGrant.revoke_old_credential` | function | `self`, `refresh_token` | [418–419](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L418) |
| `AdapterResponse` | class | — | [423–442](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L423) |
| `AdapterResponse.__iter__` | function | `self` | [430–433](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L430) |
| `AdapterResponse.location` | function | `self` | [436–437](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L436) |
| `AdapterResponse.location` | function | `self`, `value` | [440–442](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L440) |
| `TrustedIssuerParameter` | class | — | [446–450](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L446) |
| `TrustedIssuerParameter.get_issuer` | function | `self` | [449–450](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L449) |
| `IntegrationAuthorizationServer` | class | — | [453–531](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L453) |
| `IntegrationAuthorizationServer.__init__` | function | `self`, `db`, `tenant`, `registry`, `request_id` | [456–464](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L456) |
| `IntegrationAuthorizationServer.query_client` | function | `self`, `client_id` | [466–467](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L466) |
| `IntegrationAuthorizationServer.create_oauth2_request` | function | `self`, `request` | [469–470](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L469) |
| `IntegrationAuthorizationServer.handle_response` | function | `self`, `status`, `body`, `headers` | [472–473](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L472) |
| `IntegrationAuthorizationServer.send_signal` | function | `self`, `_name` | [475–476](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L475) |
| `IntegrationAuthorizationServer.current_owner` | function | `self` | [478–482](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L478) |
| `IntegrationAuthorizationServer.revoke` | function | `self`, `grant`, `action` | [484–487](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L484) |
| `IntegrationAuthorizationServer.generate_credentials` | function | `self` | [489–502](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L489) |
| `IntegrationAuthorizationServer.save_token` | function | `self`, `token`, `request` | [504–531](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L504) |
| `oauth_request` | function | `method`, `settings`, `path`, `data` | [534–539](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L534) |

</details>

## app.integration_models

[app/integration_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L1); exact source SHA-256 `b34fd0f5ae069977ba78b800f18b7329b9a86ce420592d0a4bc17c4efff9766b`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `IntegrationGrant` | class | — | [21–30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L21) |
| `IntegrationCode` | class | — | [33–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L33) |
| `IntegrationCode.get_redirect_uri` | function | `self` | [44–45](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L44) |
| `IntegrationCode.get_scope` | function | `self` | [47–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L47) |
| `IntegrationToken` | class | — | [51–66](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L51) |
| `IntegrationToken.get_scope` | function | `self` | [62–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L62) |
| `IntegrationToken.check_client` | function | `self`, `client` | [65–66](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L65) |
| `IntegrationOperation` | class | — | [69–76](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L69) |
| `ClientDraft` | class | — | [79–84](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L79) |

</details>

## app.integration_routes

[app/integration_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1); exact source SHA-256 `a6c558527b3dc3030bd885c78027008a3670520d35383f3305ab9b57056a2996`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `field` | function | `kind` | [50–51](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L50) |
| `validate_arguments` | function | `name`, `arguments` | [217–254](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L217) |
| `tool_catalog` | function | `allowed` | [257–281](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L257) |
| `case_summary` | function | `case` | [284–295](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L284) |
| `bill_summary` | function | `invoice` | [298–309](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L298) |
| `read_tool` | function | `db`, `actor`, `name`, `args`, `grant` | [312–512](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L312) |
| `write_tool` | function | `db`, `actor`, `name`, `args`, `grant`, `request_id` | [515–588](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L515) |
| `call_tool` | function | `db`, `tenant`, `registry`, `raw`, `resource`, `name`, `arguments`, `request_id` | [591–606](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L591) |
| `bounded_body` | async_function | `request` | [609–615](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L609) |
| `check_origin` | function | `request` | [618–621](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L618) |
| `enabled` | function | `request` | [624–626](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L624) |
| `bearer` | function | `request` | [629–633](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L629) |
| `rejected` | function | `request`, `error` | [636–646](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L636) |
| `oauth_form` | async_function | `request` | [649–665](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L649) |
| `public_router` | function | `page` | [668–1041](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L668) |
| `public_router.server_metadata` | async_function | `request` | [672–691](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L672) |
| `public_router.resource_metadata` | async_function | `request` | [696–710](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L696) |
| `public_router.authorization_page` | async_function | `request` | [713–746](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L713) |
| `public_router.authorize` | async_function | `request` | [749–774](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L749) |
| `public_router.token` | async_function | `request` | [777–809](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L777) |
| `public_router.revoke_token` | async_function | `request` | [812–842](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L812) |
| `public_router.no_stream` | async_function | `request` | [846–862](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L846) |
| `public_router.api_tool` | async_function | `request`, `name` | [865–889](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L865) |
| `public_router.mcp` | async_function | `request` | [892–1039](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L892) |
| `owner_router` | function | `page`, `mutate` | [1044–1095](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1044) |
| `owner_router.integrations` | async_function | `request` | [1048–1066](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1048) |
| `owner_router.revoke` | async_function | `request`, `grant_id` | [1069–1080](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1069) |
| `owner_router.revoke.action` | function | `db`, `actor`, `_form`, `request_id` | [1070–1076](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1070) |
| `owner_router.drafts` | async_function | `request` | [1083–1093](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1083) |

</details>

## app.internal_routes

[app/internal_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L1); exact source SHA-256 `ab16a622f5f44b9a211d020a3f8d1e0ce5919cddfef8e1c7a36755d3178fcc6f`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `sending_job` | async_function | `request` | [21–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L21) |
| `_sending_batch` | function | `registry`, `request_id` | [42–79](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L42) |
| `authenticated_body` | async_function | `request`, `limit` | [82–105](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L82) |
| `archive_job` | async_function | `request` | [110–130](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L110) |
| `receive_mail` | async_function | `request` | [134–194](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L134) |

</details>

## app.library

[app/library.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L1); exact source SHA-256 `65aa0bbabbafcf7aa8aaac5dd431ec5928e033cb81906c982d559e954bfddc81`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `authorize` | function | `db`, `actor` | [118–121](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L118) |
| `document` | function | `db`, `actor`, `document_id`, `lock` | [124–132](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L124) |
| `_active_case` | function | `db`, `actor`, `value` | [135–149](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L135) |
| `_fields` | function | `db`, `actor`, `data` | [152–176](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L152) |
| `create` | function | `db`, `actor`, `data`, `request_id` | [179–219](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L179) |
| `_draft` | function | `row`, `revision` | [222–226](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L222) |
| `save` | function | `db`, `actor`, `document_id`, `data`, `request_id` | [229–240](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L229) |
| `inspect_upload` | function | `filename`, `payload` | [243–286](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L243) |
| `upload` | function | `db`, `actor`, `document_id`, `revision`, `filename`, `payload`, `request_id` | [289–301](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L289) |
| `_source` | function | `db`, `row` | [304–310](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L304) |
| `publish` | function | `db`, `actor`, `document_id`, `revision`, `request_id`, `attachment_format` | [313–354](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L313) |
| `new_draft` | function | `db`, `actor`, `document_id`, `revision`, `request_id` | [357–365](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L357) |
| `frozen_artifact` | function | `db`, `actor`, `version_id` | [368–394](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L368) |
| `verify_payload` | function | `payload`, `size`, `checksum` | [397–400](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L397) |

</details>

## app.library_models

[app/library_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L1); exact source SHA-256 `31cf9525e21fa7e711b6dfd0ace11a7a06752f63f6339e6be77a1feb3cbec7dc`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `LibraryDocument` | class | — | [26–49](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L26) |
| `LibraryUpload` | class | — | [52–65](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L52) |
| `LibraryDocumentVersion` | class | — | [68–86](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L68) |

</details>

## app.library_routes

[app/library_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L1); exact source SHA-256 `0e47b3b14946e5353d186abb908661db1e47d0c0613ba4aa44cf23e0782f3c69`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_form` | async_function | `request`, `file` | [20–40](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L20) |
| `_form.receive` | async_function | — | [28–29](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L28) |
| `_download` | function | `payload`, `filename`, `content_type` | [43–47](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L43) |
| `build_router` | function | `page`, `mutate`, `scoped_config` | [50–178](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L50) |
| `build_router.available` | function | `request` | [51–53](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L51) |
| `build_router.composer` | function | `request`, `document_id`, `values`, `errors` | [57–90](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L57) |
| `build_router.library_list` | async_function | `request`, `q`, `p` | [93–104](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L93) |
| `build_router.new_document` | async_function | `request` | [108–109](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L108) |
| `build_router.create_document` | async_function | `request` | [112–117](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L112) |
| `build_router.document_detail` | async_function | `request`, `document_id` | [120–121](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L120) |
| `build_router.save_document` | async_function | `request`, `document_id` | [124–128](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L124) |
| `build_router.upload_document` | async_function | `request`, `document_id` | [131–140](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L131) |
| `build_router.upload_document.attach` | function | `db`, `actor`, `data`, `rid` | [134–137](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L134) |
| `build_router.publish_document` | async_function | `request`, `document_id` | [143–147](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L143) |
| `build_router.create_draft` | async_function | `request`, `document_id` | [150–153](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L150) |
| `build_router.original_download` | async_function | `request`, `document_id`, `upload_id` | [156–164](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L156) |
| `build_router.pdf_download` | async_function | `request`, `version_id` | [167–170](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L167) |
| `build_router.attachment_download` | async_function | `request`, `version_id` | [173–176](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L173) |

</details>

## app.logging

[app/logging.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L1); exact source SHA-256 `3d18cb7338c745f175a95901a58b0f7f329b8857dfc26d3f74e10665f4e9d676`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `safe_fields` | function | `fields` | [32–58](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L32) |
| `SafeFormatter` | class | — | [61–78](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L61) |
| `SafeFormatter.__init__` | function | `self`, `production` | [62–64](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L62) |
| `SafeFormatter.format` | function | `self`, `record` | [66–78](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L66) |
| `configure` | function | `production` | [81–101](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L81) |
| `event` | function | `name` | [104–109](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L104) |

</details>

## app.lookups

[app/lookups.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L1); exact source SHA-256 `b433ba638ec9a5cf88f904492c54725ed33dc8e8fb3bcbb0b33154c124988c43`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_id` | function | `value` | [17–21](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L17) |
| `_page` | function | `value` | [24–28](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L24) |
| `is_lookup` | function | `values` | [31–32](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L31) |
| `lookup_state` | function | `values`, `field` | [35–45](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L35) |
| `selection_page` | function | `db`, `actor`, `kind`, `selected`, `client_id`, `project_id`, `active`, `all_clients`, `exclude_closed`, `search`, `page`, `tools_open` | [48–167](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L48) |
| `selection_page.label` | function | `row` | [140–145](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L140) |

</details>

## app.mail_models

[app/mail_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L1); exact source SHA-256 `de5d6203acc78fd54236b653bc379b2c0a1950844aca06abe872799d7d5104ed`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `MailMessage` | class | — | [22–46](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L22) |
| `MailAddress` | class | — | [49–56](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L49) |
| `MailAttachment` | class | — | [64–81](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L64) |

</details>

## app.mail_routes

[app/mail_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L1); exact source SHA-256 `15720d79d8dceb63a7e459db75ed8d0645aeba528f42e7c926012505ddbff942`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_utc` | function | `value` | [24–29](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L24) |
| `_ids` | function | `data` | [32–43](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L32) |
| `_uploaded_form` | async_function | `request` | [46–70](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L46) |
| `_uploaded_form.receive` | async_function | — | [57–58](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L57) |
| `build_router` | function | `page`, `mutate` | [73–448](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L73) |
| `build_router.choices` | function | `request`, `db`, `values`, `active` | [77–93](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L77) |
| `build_router.import_form` | function | `request`, `values`, `errors` | [95–106](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L95) |
| `build_router.mail_list` | async_function | `request`, `client_id`, `project_id`, `case_id`, `case_ref`, `q`, `p` | [109–204](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L109) |
| `build_router.mail_import_form` | async_function | `request` | [207–208](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L207) |
| `build_router.mail_import` | async_function | `request` | [211–237](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L211) |
| `build_router.address_page` | function | `request`, `values`, `errors`, `address_once` | [239–266](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L239) |
| `build_router.address_list` | async_function | `request` | [269–270](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L269) |
| `build_router.address_create` | async_function | `request` | [273–295](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L273) |
| `build_router.address_revoke` | async_function | `request`, `address_id` | [298–304](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L298) |
| `build_router.mail_detail` | async_function | `request`, `message_id` | [307–355](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L307) |
| `build_router.attachment_response` | function | `request`, `message_id`, `attachment_id`, `archived` | [357–392](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L357) |
| `build_router.active_attachment` | async_function | `request`, `message_id`, `attachment_id` | [395–396](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L395) |
| `build_router.archived_attachment` | async_function | `request`, `message_id`, `attachment_id` | [399–400](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L399) |
| `build_router.attachment_manifest` | async_function | `request`, `start`, `end` | [403–446](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L403) |

</details>

## app.mail_service

[app/mail_service.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L1); exact source SHA-256 `29f109c355d2e985a2e1ac97819b23e98443c2cd969cfcba73b9737bbbac71f1`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_PlainHTML` | class | — | [29–47](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L29) |
| `_PlainHTML.__init__` | function | `self` | [30–33](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L30) |
| `_PlainHTML.handle_starttag` | function | `self`, `tag`, `attrs` | [35–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L35) |
| `_PlainHTML.handle_endtag` | function | `self`, `tag` | [41–43](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L41) |
| `_PlainHTML.handle_data` | function | `self`, `data` | [45–47](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L45) |
| `_header` | function | `message`, `name`, `maximum` | [50–55](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L50) |
| `safe_filename` | function | `value`, `position` | [58–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L58) |
| `parse_message` | function | `raw`, `include_attachments` | [66–164](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L66) |
| `_owner` | function | `db`, `actor` | [167–177](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L167) |
| `validate_assignment` | function | `db`, `actor`, `client_id`, `project_id`, `case_id` | [180–198](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L180) |
| `ingest` | function | `db`, `actor`, `raw`, `client_id`, `project_id`, `case_id`, `source`, `request_id`, `historical_received` | [201–278](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L201) |
| `create_address` | function | `db`, `actor`, `client_id`, `project_id`, `case_id`, `request_id` | [281–293](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L281) |
| `resolve_address` | function | `db`, `token` | [296–311](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L296) |
| `revoke_address` | function | `db`, `actor`, `address_id`, `request_id` | [314–324](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_service.py#L314) |

</details>

## app.main

[app/main.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1); exact source SHA-256 `e919301265bf35ab18507a49ff4953a16ffae9958d2843b65f94c4af21e4ed23`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `RateLimiter` | class | — | [95–115](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L95) |
| `RateLimiter.__init__` | function | `self` | [96–97](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L96) |
| `RateLimiter.check` | function | `self`, `request`, `action`, `limit` | [99–115](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L99) |
| `create_app` | function | `config` | [118–1736](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L118) |
| `create_app.lifespan` | async_function | `app` | [127–135](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L127) |
| `create_app.request_context` | async_function | `request`, `call_next` | [196–281](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L196) |
| `create_app.page` | function | `request`, `name`, `status_code` | [283–330](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L283) |
| `create_app.http_error` | async_function | `request`, `error` | [333–356](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L333) |
| `create_app.domain_error` | async_function | `request`, `error` | [359–364](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L359) |
| `create_app.validation_error` | async_function | `request`, `error` | [367–377](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L367) |
| `create_app.mutate` | async_function | `request`, `action`, `destination`, `on_error`, `form`, `success` | [379–416](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L379) |
| `create_app.mutate.transact` | function | — | [391–393](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L391) |
| `create_app.landing` | async_function | `request` | [419–422](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L419) |
| `create_app.contact_submit` | async_function | `request` | [425–455](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L425) |
| `create_app.local_login` | async_function | `request` | [458–477](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L458) |
| `create_app.google_entry` | async_function | — | [481–482](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L481) |
| `create_app.google_login` | async_function | `request` | [486–549](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L486) |
| `create_app.google_callback` | async_function | `request` | [553–564](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L553) |
| `create_app.complete_provider_callback` | async_function | `request`, `provider` | [566–700](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L566) |
| `create_app.live` | async_function | — | [703–704](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L703) |
| `create_app.ready` | async_function | — | [707–714](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L707) |
| `create_app.authorized` | function | `request` | [716–719](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L716) |
| `create_app.logout` | async_function | `request` | [724–736](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L724) |
| `create_app.dashboard` | function | `request`, `detail`, `rhythm`, `outstanding_p`, `this_week_p`, `drafts_p`, `unbilled_p`, `overdue_p` | [739–818](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L739) |
| `create_app.dashboard.dashboard_page_url` | function | `number`, `parameter` | [779–786](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L779) |
| `create_app.client_list` | function | `request`, `q`, `status`, `sort`, `p` | [821–870](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L821) |
| `create_app.client_form_error` | function | `request`, `form`, `errors`, `client_id` | [872–885](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L872) |
| `create_app.new_client` | function | `request` | [888–891](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L888) |
| `create_app.create_client` | async_function | `request` | [894–903](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L894) |
| `create_app.client_detail_page` | function | `request`, `client_id`, `form_values`, `errors` | [905–941](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L905) |
| `create_app.client_detail` | function | `request`, `client_id` | [944–945](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L944) |
| `create_app.edit_client` | function | `request`, `client_id` | [948–951](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L948) |
| `create_app.client_save` | async_function | `request`, `client_id` | [954–963](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L954) |
| `create_app.project_save` | async_function | `request`, `client_id` | [966–979](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L966) |
| `create_app.contact_save` | async_function | `request`, `client_id` | [982–994](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L982) |
| `create_app.contract_confirm` | async_function | `request`, `client_id` | [997–1020](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L997) |
| `create_app.contract_confirm.action` | function | `db`, `actor`, `data`, `rid` | [1005–1010](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1005) |
| `create_app.client_source_download` | function | `request`, `client_id`, `reference_id` | [1023–1027](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1023) |
| `create_app.timecard_list` | function | `request`, `client_id`, `week`, `status`, `p`, `q`, `view`, `internal`, `projects` | [1030–1211](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1030) |
| `create_app.week_form_error` | async_function | `request`, `form`, `errors`, `card_id` | [1213–1232](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1213) |
| `create_app.submitted_week_rows` | function | `data` | [1234–1240](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1234) |
| `create_app.saved_week_url` | function | `card`, `history`, `rows` | [1242–1250](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1242) |
| `create_app.timecard_save` | async_function | `request` | [1253–1284](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1253) |
| `create_app.timecard_save.action` | function | `db`, `actor`, `data`, `rid` | [1258–1275](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1258) |
| `create_app.remove_timecard_drafts` | async_function | `request` | [1287–1307](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1287) |
| `create_app.remove_timecard_drafts.action` | function | `db`, `actor`, `data`, `rid` | [1291–1301](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1291) |
| `create_app.add_timecard_project` | async_function | `request` | [1310–1325](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1310) |
| `create_app.timecard_finalize` | async_function | `request`, `card_id` | [1328–1342](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1328) |
| `create_app.timecard_reopen` | async_function | `request`, `card_id` | [1345–1352](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1345) |
| `create_app.duplicate` | async_function | `request`, `card_id` | [1355–1360](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1355) |
| `create_app.render_billing` | function | `request`, `q`, `status`, `p`, `form_values` | [1362–1413](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1362) |
| `create_app.invoice_list` | function | `request`, `q`, `status`, `p` | [1416–1417](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1416) |
| `create_app.invoice_create` | async_function | `request` | [1420–1437](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1420) |
| `create_app.invoice_detail` | function | `request`, `invoice_id` | [1440–1459](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1440) |
| `create_app.invoice_pdf` | function | `request`, `invoice_id`, `download` | [1462–1477](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1462) |
| `create_app.invoice_action` | async_function | `request`, `invoice_id`, `operation` | [1480–1520](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1480) |
| `create_app.invoice_action.action` | function | `db`, `actor`, `data`, `rid` | [1481–1518](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1481) |
| `create_app.credit_memo_detail` | function | `request`, `memo_id` | [1523–1526](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1523) |
| `create_app.credit_memo_pdf` | function | `request`, `memo_id`, `download` | [1529–1540](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1529) |
| `create_app.payment_reverse` | async_function | `request`, `payment_id` | [1543–1550](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1543) |
| `create_app.reports_page` | function | `request` | [1553–1559](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1553) |
| `create_app.csv_export` | function | `request` | [1562–1597](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1562) |
| `create_app.render_settings` | function | `request`, `limit_values`, `limit_errors`, `record_values`, `record_errors` | [1599–1618](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1599) |
| `create_app.settings_page` | function | `request` | [1621–1622](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1621) |
| `create_app.save_limits` | async_function | `request` | [1625–1631](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1625) |
| `create_app.save_record_limits` | async_function | `request` | [1634–1636](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1634) |
| `create_app.lookup_page` | function | `request`, `kind`, `field`, `search`, `p`, `selected`, `client_id`, `project_id`, `active`, `required`, `all_clients`, `exclude_closed` | [1639–1677](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1639) |
| `create_app.save_settings` | async_function | `request` | [1680–1687](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1680) |
| `create_app.audit_page` | function | `request`, `p` | [1690–1694](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1690) |

</details>

## app.models

[app/models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L1); exact source SHA-256 `4dc6233d743ffd43bea41585e6423c5b80a89a96b497155f88774182f88b8b70`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `Base` | class | — | [29–30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L29) |
| `ContactAttempt` | class | — | [33–44](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L33) |
| `Entity` | class | — | [47–56](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L47) |
| `User` | class | — | [59–66](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L59) |
| `Client` | class | — | [69–96](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L69) |
| `Contact` | class | — | [99–109](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L99) |
| `Project` | class | — | [112–150](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L112) |
| `ClientSourceReference` | class | — | [153–166](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L153) |
| `ProjectAgreement` | class | — | [169–181](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L169) |
| `Timecard` | class | — | [184–212](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L184) |
| `TimeEntry` | class | — | [215–230](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L215) |
| `Case` | class | — | [233–263](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L233) |
| `CaseTimeAllocation` | class | — | [266–277](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L266) |
| `Invoice` | class | — | [280–338](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L280) |
| `InvoiceLine` | class | — | [341–362](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L341) |
| `Reservation` | class | — | [365–368](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L365) |
| `Artifact` | class | — | [371–377](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L371) |
| `Payment` | class | — | [380–391](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L380) |
| `Audit` | class | — | [394–401](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L394) |
| `AppSettings` | class | — | [404–408](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L404) |

</details>

## app.paddle

[app/paddle.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L1); exact source SHA-256 `a4a84895a0aa041e02de95d24358f7cb6fbf006b1b0ff3c4f95f1646e0d1a367`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `PaddleError` | class | — | [73–98](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L73) |
| `PaddleError.__init__` | function | `self`, `code`, `status_code`, `provider_code`, `live` | [76–98](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L76) |
| `PaddleUnavailable` | class | — | [101–103](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L101) |
| `PaddleUnavailable.__init__` | function | `self`, `live` | [102–103](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L102) |
| `PaddleUncertain` | class | — | [106–110](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L106) |
| `PaddleUncertain.__init__` | function | `self`, `live` | [109–110](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L109) |
| `_object` | function | `pairs` | [113–119](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L113) |
| `_constant` | function | `_value` | [122–123](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L122) |
| `_decimal` | function | `value` | [126–130](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L126) |
| `_json` | function | `raw` | [133–138](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L133) |
| `_rejection` | function | `response`, `live` | [141–150](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L141) |
| `_id` | function | `value`, `prefix` | [153–156](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L153) |
| `_date` | function | `value` | [159–166](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L159) |
| `_url` | function | `value` | [169–180](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L169) |
| `verify_webhook` | function | `raw`, `signature`, `secret`, `now` | [183–239](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L183) |
| `PaddleSandbox` | class | — | [242–665](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L242) |
| `PaddleSandbox.__init__` | function | `self`, `settings`, `transport` | [248–305](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L248) |
| `PaddleSandbox._request` | async_function | `self`, `method`, `path`, `payload`, `mutation` | [307–342](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L307) |
| `PaddleSandbox._offer` | function | `self`, `offer` | [344–347](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L344) |
| `PaddleSandbox.validated_price` | async_function | `self`, `offer` | [349–353](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L349) |
| `PaddleSandbox._price` | function | `self`, `data`, `offer`, `active` | [355–370](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L355) |
| `PaddleSandbox._items` | function | `self`, `data`, `price_id` | [372–388](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L372) |
| `PaddleSandbox._subscription` | function | `self`, `data`, `identifier`, `price_id`, `preview` | [390–397](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L390) |
| `PaddleSandbox.get_subscription` | async_function | `self`, `identifier` | [399–403](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L399) |
| `PaddleSandbox.get_transaction` | async_function | `self`, `identifier` | [405–425](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L405) |
| `PaddleSandbox._checkout_url` | function | `self`, `value`, `identifier` | [427–439](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L427) |
| `PaddleSandbox.create_checkout` | async_function | `self`, `checkout_uuid`, `tenant_uuid`, `offer` | [441–470](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L441) |
| `PaddleSandbox.portal` | async_function | `self`, `customer_id`, `subscription_id` | [472–501](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L472) |
| `PaddleSandbox._portal_url` | function | `self`, `value`, `action`, `subscription_id` | [503–521](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L503) |
| `PaddleSandbox._change` | async_function | `self`, `identifier`, `offer`, `mode`, `preview` | [523–544](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L523) |
| `PaddleSandbox.preview_change` | async_function | `self`, `subscription_id`, `offer`, `proration_billing_mode` | [546–547](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L546) |
| `PaddleSandbox.change_subscription` | async_function | `self`, `subscription_id`, `offer`, `proration_billing_mode` | [549–550](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L549) |
| `PaddleSandbox.validated_retention_discount` | async_function | `self` | [552–578](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L552) |
| `PaddleSandbox._retention` | async_function | `self`, `identifier`, `offer`, `preview`, `expected` | [580–613](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L580) |
| `PaddleSandbox.preview_retention` | async_function | `self`, `identifier`, `offer` | [615–616](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L615) |
| `PaddleSandbox.apply_retention` | async_function | `self`, `identifier`, `offer`, `expected` | [618–619](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L618) |
| `PaddleSandbox.cancel_at_period_end` | async_function | `self`, `identifier` | [621–637](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L621) |
| `PaddleSandbox._error` | function | `self`, `code` | [640–641](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L640) |
| `PaddleSandbox._uncertain` | function | `self` | [643–644](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L643) |
| `PaddleSandbox._unavailable` | function | `self` | [646–647](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L646) |
| `PaddleSandbox._id` | function | `self`, `value`, `prefix` | [649–653](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L649) |
| `PaddleSandbox._date` | function | `self`, `value` | [655–659](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L655) |
| `PaddleSandbox._url` | function | `self`, `value` | [661–665](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L661) |
| `PaddleLive` | class | — | [668–672](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L668) |
| `provider_from_settings` | function | `settings`, `transport` | [675–677](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L675) |

</details>

## app.pagination

[app/pagination.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L1); exact source SHA-256 `517df621a3f89da8a75e231315773fed84e74f94532106b7035759972eb1040e`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `record_page_size` | function | `db` | [11–16](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L11) |
| `Page` | class | — | [20–32](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L20) |
| `Page.pages` | function | `self` | [27–28](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L27) |
| `Page.offset` | function | `self` | [31–32](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L31) |
| `page_bounds` | function | `total`, `number`, `size` | [35–42](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L35) |
| `paginate` | function | `db`, `query`, `number`, `size`, `scalars` | [45–59](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L45) |
| `page_url` | function | `request`, `number`, `parameter`, `target`, `path` | [62–65](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L62) |

</details>

## app.pdf

[app/pdf.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pdf.py#L1); exact source SHA-256 `daff94ba6dd182472ecc7f37277cef2042d3433e0922cebc7cc7dcc74c25fda9`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `deny_asset` | function | `url` | [13–14](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pdf.py#L13) |
| `render` | function | `snapshot`, `template` | [17–49](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pdf.py#L17) |

</details>

## app.privacy

[app/privacy.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L1); exact source SHA-256 `11d50b154251250dd54a601713c34ccd86a9ea235aba38738989b5c232ade569`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `privacy_signal` | function | `request` | [18–20](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L18) |
| `PrivacyPreferences` | class | — | [23–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L23) |
| `PrivacyPreferences.__init__` | function | `self`, `secret_key`, `hosted`, `demo` | [24–35](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L24) |
| `PrivacyPreferences.read` | function | `self`, `request` | [37–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L37) |
| `PrivacyPreferences.context` | function | `self`, `request` | [50–63](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L50) |
| `preference_message` | function | `choice`, `signal` | [66–71](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L66) |
| `save_preferences` | async_function | `request` | [75–125](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/privacy.py#L75) |

</details>

## app.project_attachments

[app/project_attachments.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_attachments.py#L1); exact source SHA-256 `ba5e96917ba2bed7b6dd84dc2791405ba26d18faf411f1db211ce34135b045bc`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `uploaded_form` | async_function | `request` | [21–43](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_attachments.py#L21) |
| `uploaded_form.receive` | async_function | — | [32–33](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_attachments.py#L32) |
| `attach` | function | `db`, `actor`, `project_id`, `filename`, `payload`, `request_id` | [46–77](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_attachments.py#L46) |
| `download` | function | `db`, `actor`, `project_id`, `agreement_id` | [80–100](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_attachments.py#L80) |

</details>

## app.project_billing_routes

[app/project_billing_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L1); exact source SHA-256 `62692b3b21d2fb75a27266b9219877b15a69f8be4041bc8aaa05a46c99b41f02`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_period` | function | `data` | [18–30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L18) |
| `build_router` | function | `page`, `mutate`, `config` | [33–110](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L33) |
| `build_router.render` | function | `request`, `project_id`, `values`, `errors` | [36–53](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L36) |
| `build_router.detail` | async_function | `request`, `project_id` | [56–57](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L56) |
| `build_router.action` | async_function | `request`, `project_id`, `operation` | [60–108](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L60) |
| `build_router.action.save` | function | `db`, `actor`, `data`, `rid` | [61–101](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L61) |

</details>

## app.project_routes

[app/project_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L1); exact source SHA-256 `4d11b4729383c7bd67cbbcf30cf0c9d4a006966dd2eb319adb9def82e4018411`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_validated_project` | function | `db`, `actor`, `data`, `request_id`, `project_id` | [22–56](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L22) |
| `_week` | function | `value` | [59–64](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L59) |
| `build_router` | function | `page`, `mutate` | [67–331](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L67) |
| `build_router.render_form` | function | `request`, `project_id`, `form_values`, `errors` | [70–144](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L70) |
| `build_router.project_list` | async_function | `request`, `client_id`, `status`, `q`, `p` | [147–218](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L147) |
| `build_router.project_new` | async_function | `request` | [221–222](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L221) |
| `build_router.project_edit` | async_function | `request`, `project_id` | [225–226](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L225) |
| `build_router.save` | async_function | `request`, `project_id` | [228–272](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L228) |
| `build_router.save.action` | function | `db`, `actor`, `data`, `request_id` | [236–263](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L236) |
| `build_router.project_create` | async_function | `request` | [275–276](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L275) |
| `build_router.project_update` | async_function | `request`, `project_id` | [279–280](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L279) |
| `build_router.project_archive` | async_function | `request`, `project_id` | [283–324](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L283) |
| `build_router.project_archive.action` | function | `db`, `actor`, `data`, `request_id` | [284–317](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L284) |
| `build_router.agreement_download` | async_function | `request`, `project_id`, `agreement_id` | [327–329](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L327) |

</details>

## app.project_terms

[app/project_terms.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_terms.py#L1); exact source SHA-256 `afca055671b6d0459ecfd931b078fb5eddb78efe10568d0bf2d15d5a270df107`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `project_terms` | function | `project`, `client`, `data` | [17–58](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_terms.py#L17) |

</details>

## app.proposal_sending

[app/proposal_sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L1); exact source SHA-256 `29362e637a348ac241d3c1af6ad70e785fcb94a3a5949e2b9ae1b280f67bfac8`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `ProposalMessage` | class | — | [39–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L39) |
| `ProposalResult` | class | — | [52–54](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L52) |
| `normalize_result` | function | `value` | [57–62](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L57) |
| `validate_message` | function | `recipient`, `subject`, `body` | [65–75](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L65) |
| `validate_attachment` | function | `filename`, `content_type`, `payload`, `sha256` | [78–90](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L78) |
| `_owner` | function | `db`, `actor`, `lock` | [93–97](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L93) |
| `published_source` | function | `db`, `actor`, `source`, `artifact_id` | [100–136](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L100) |
| `prepare` | function | `db`, `actor`, `source`, `artifact_id`, `recipient`, `subject`, `body`, `operation_key`, `request_id` | [139–162](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L139) |
| `owned_delivery` | function | `db`, `actor`, `delivery_id`, `lock` | [165–170](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L165) |
| `review_digest` | function | `delivery` | [173–178](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L173) |
| `revise` | function | `db`, `actor`, `delivery_id`, `recipient`, `subject`, `body`, `expected_version`, `request_id` | [181–190](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L181) |
| `stop` | function | `db`, `actor`, `delivery_id`, `request_id` | [193–200](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L193) |
| `history` | function | `db`, `actor`, `number` | [203–209](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L203) |
| `attempts` | function | `db`, `actor`, `delivery_id` | [212–215](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L212) |
| `delivery_message` | function | `delivery`, `attempt_number` | [218–221](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L218) |
| `delivery_budget` | function | `delivery`, `sender` | [224–227](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L224) |
| `dispatch_delivery` | function | `factory`, `actor`, `delivery_id`, `transport`, `confirmed`, `expected_review_digest`, `retry`, `request_id`, `sender` | [230–277](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L230) |

</details>

## app.proposal_sending_models

[app/proposal_sending_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L1); exact source SHA-256 `78a724d0ecfc1db0ce5ad8b333680ae0bdbe5ad64c1b38e5b5df74bbd82c0d41`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `ProposalSendingDelivery` | class | — | [22–55](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L22) |
| `ProposalSendingAttempt` | class | — | [58–69](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L58) |

</details>

## app.proposal_sending_routes

[app/proposal_sending_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L1); exact source SHA-256 `c66cdb170dfbfb3ea3b417e340b691d5091c52d5d9353f8ca13ef7980f60c5d0`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_utc` | function | `value` | [16–17](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L16) |
| `build_router` | function | `page`, `mutate`, `config` | [20–116](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L20) |
| `build_router.available` | async_function | — | [21–23](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L21) |
| `build_router.preparation` | function | `request`, `source`, `artifact_id`, `values`, `errors` | [27–35](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L27) |
| `build_router.index` | async_function | `request`, `p` | [38–43](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L38) |
| `build_router.prepare_form` | async_function | `request`, `source`, `artifact_id` | [46–47](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L46) |
| `build_router.prepare` | async_function | `request`, `source`, `artifact_id` | [50–56](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L50) |
| `build_router.review` | function | `request`, `delivery_id`, `values`, `errors` | [58–67](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L58) |
| `build_router.review_form` | async_function | `request`, `delivery_id` | [70–71](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L70) |
| `build_router.edit` | async_function | `request`, `delivery_id` | [74–79](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L74) |
| `build_router.dispatch` | async_function | `request`, `delivery_id` | [82–97](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L82) |
| `build_router.stop` | async_function | `request`, `delivery_id` | [100–103](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L100) |
| `build_router.attachment` | async_function | `request`, `delivery_id` | [106–114](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L106) |

</details>

## app.proposal_sending_transport

[app/proposal_sending_transport.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L1); exact source SHA-256 `46bb13a7e8d59a19ced5ac8c95b032449b070125f783d339a3339085be55d89b`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `MessageBudget` | class | — | [22–30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L22) |
| `MessageBudget.ready` | function | `self` | [29–30](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L29) |
| `_encoded_size` | function | `size` | [33–35](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L33) |
| `prepared_payload` | function | `message`, `sender` | [38–53](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L38) |
| `message_budget` | function | `message`, `sender` | [56–57](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L56) |
| `configured` | function | `config` | [60–62](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L60) |
| `classify_response` | function | `status`, `raw`, `recipient` | [65–91](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L65) |
| `CloudflareProposalSending` | class | — | [94–126](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L94) |
| `CloudflareProposalSending.__init__` | function | `self`, `config` | [95–101](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L95) |
| `CloudflareProposalSending.__call__` | function | `self`, `message` | [103–126](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L103) |
| `transport_from_settings` | function | `config` | [129–132](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L129) |

</details>

## app.quoting

[app/quoting.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L1); exact source SHA-256 `6f5cc3ee39a9056a3485b0d4f5c3bb2a10b409548aaf6680ff770db64eb2627e`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_text` | function | `value`, `maximum`, `label`, `required` | [38–46](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L38) |
| `_minutes` | function | `value` | [49–58](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L49) |
| `normalize_line` | function | `data` | [61–82](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L61) |
| `totals` | function | `lines` | [85–107](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L85) |
| `normalize` | function | `data`, `default_currency` | [110–143](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L110) |
| `_owner` | function | `db`, `actor` | [146–149](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L146) |
| `_identifier` | function | `value`, `label` | [152–156](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L152) |
| `_context` | function | `db`, `actor`, `data`, `lock` | [159–174](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L159) |
| `get_quote` | function | `db`, `actor`, `quote_id`, `lock` | [177–182](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L177) |
| `_revision` | function | `db`, `actor`, `revision_id`, `lock` | [185–189](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L185) |
| `_editable` | function | `quote`, `revision`, `expected_version` | [192–196](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L192) |
| `_lines` | function | `db`, `revision_id` | [199–201](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L199) |
| `_assign` | function | `db`, `revision`, `values`, `context` | [204–213](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L204) |
| `create` | function | `db`, `actor`, `data`, `operation_key`, `request_id` | [216–241](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L216) |
| `update` | function | `db`, `actor`, `revision_id`, `data`, `expected_version`, `request_id` | [244–257](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L244) |
| `_data` | function | `revision`, `lines` | [260–262](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L260) |
| `revise` | function | `db`, `actor`, `revision_id`, `expected_version`, `request_id` | [265–288](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L265) |
| `_json` | function | `value` | [291–300](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L291) |
| `snapshot` | function | `db`, `actor`, `revision_id` | [303–315](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L303) |
| `publish` | function | `db`, `actor`, `revision_id`, `expected_version`, `renderer`, `request_id` | [318–344](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L318) |
| `archive` | function | `db`, `actor`, `quote_id`, `expected_version`, `request_id` | [347–355](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L347) |
| `published_artifact` | function | `db`, `actor`, `artifact_id` | [358–369](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L358) |
| `view` | function | `db`, `actor`, `quote_id`, `revision_id` | [372–383](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L372) |
| `_listing` | function | `db`, `actor`, `include_archived`, `case_id`, `q` | [386–401](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L386) |
| `_list_views` | function | `db`, `actor`, `identifiers` | [404–432](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L404) |
| `list_quotes` | function | `db`, `actor`, `include_archived`, `case_id`, `q`, `limit`, `offset` | [435–440](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L435) |
| `count_quotes` | function | `db`, `actor`, `include_archived`, `case_id`, `q` | [443–445](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L443) |
| `quote_page` | function | `db`, `actor`, `number`, `include_archived`, `case_id`, `q` | [448–455](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L448) |

</details>

## app.quoting_models

[app/quoting_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L1); exact source SHA-256 `24910fd16be91df9e117f6ead470e3e9dde084045d257ba7061f4b1e6a888991`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `Quote` | class | — | [30–43](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L30) |
| `QuoteRevision` | class | — | [46–76](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L46) |
| `QuoteLine` | class | — | [79–102](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L79) |
| `QuoteArtifact` | class | — | [105–120](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L105) |

</details>

## app.quoting_routes

[app/quoting_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L1); exact source SHA-256 `ab8760856e4958cf91b9ebe47b2a2a844c11f26dd63503f1045a07db9da6c37a`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `estimate_minutes` | function | `value` | [22–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L22) |
| `row_count` | function | `values` | [42–49](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L42) |
| `estimate_data` | function | `values` | [52–86](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L52) |
| `revision_values` | function | `item` | [89–100](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L89) |
| `build_router` | function | `page`, `mutate`, `config` | [103–252](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L103) |
| `build_router.available` | function | — | [104–106](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L104) |
| `build_router.render_form` | function | `request`, `quote_id`, `revision_id`, `values`, `errors` | [110–145](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L110) |
| `build_router.index` | async_function | `request`, `q`, `case_id`, `archived`, `p` | [148–160](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L148) |
| `build_router.new` | async_function | `request` | [163–164](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L163) |
| `build_router.save` | async_function | `request`, `quote_id`, `revision_id`, `form` | [166–189](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L166) |
| `build_router.save.change` | function | `db`, `actor`, `values`, `rid` | [180–185](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L180) |
| `build_router.create` | async_function | `request` | [192–193](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L192) |
| `build_router.detail` | async_function | `request`, `quote_id`, `revision_id` | [196–201](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L196) |
| `build_router.edit` | async_function | `request`, `quote_id`, `revision_id` | [204–205](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L204) |
| `build_router.update` | async_function | `request`, `quote_id` | [208–212](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L208) |
| `build_router.publish` | async_function | `request`, `quote_id` | [215–221](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L215) |
| `build_router.publish.action` | function | `db`, `actor`, `data`, `rid` | [216–220](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L216) |
| `build_router.revise` | async_function | `request`, `quote_id` | [224–229](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L224) |
| `build_router.revise.action` | function | `db`, `actor`, `data`, `rid` | [225–228](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L225) |
| `build_router.archive` | async_function | `request`, `quote_id` | [232–234](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L232) |
| `build_router.download` | async_function | `request`, `quote_id`, `revision_id` | [237–250](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L237) |

</details>

## app.record_references

[app/record_references.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/record_references.py#L1); exact source SHA-256 `e7ab56e18f6a30fe9f29f795e200e670017f8480b31d829ef5b7cd73217a10b5`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `project_reference` | function | `object_id` | [9–12](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/record_references.py#L9) |
| `project_object_id` | function | `query` | [15–21](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/record_references.py#L15) |

</details>

## app.reference_choices

[app/reference_choices.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reference_choices.py#L1); exact source SHA-256 `ba1637bfe2df15d46350e8593e7e9e5119404585c3c5ead2fbec0a7ba57e1529`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_countries` | function | — | [13–20](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reference_choices.py#L13) |
| `_currencies` | function | — | [24–26](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reference_choices.py#L24) |
| `_timezones` | function | — | [30–31](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reference_choices.py#L30) |
| `reference_choices` | function | `name` | [34–42](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reference_choices.py#L34) |

</details>

## app.reports

[app/reports.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reports.py#L1); exact source SHA-256 `1e1509b7c6e1df4cb059bbe0845c91a5e409188c4a09b3f295ba654bd75cd87f`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `report` | function | `db`, `paid_totals` | [17–78](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reports.py#L17) |
| `aging_bucket` | function | `due`, `today` | [81–91](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reports.py#L81) |
| `report_pages` | function | `db`, `monthly_number`, `aging_number` | [94–105](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reports.py#L94) |
| `dashboard_details` | function | `db`, `actor`, `paid_totals`, `only` | [108–255](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reports.py#L108) |
| `billing_metrics` | function | `db`, `paid_totals` | [258–291](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reports.py#L258) |

</details>

## app.repositories

[app/repositories.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/repositories.py#L1); exact source SHA-256 `561396ae7d6ee6728b19a86baeb88d8f591ce819e289062c41b89adc90fe7cd8`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `require` | function | `db`, `model`, `entity_id`, `lock` | [12–19](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/repositories.py#L12) |
| `lock_card` | function | `db`, `card_id`, `owner_id` | [22–32](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/repositories.py#L22) |
| `lock_invoice` | function | `db`, `invoice_id` | [35–54](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/repositories.py#L35) |

</details>

## app.search_routes

[app/search_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/search_routes.py#L1); exact source SHA-256 `3374521b6ac5d6e26c55f176d2ce1e3bf735e90286960e49681bf2d74674c541`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `router` | function | `page`, `config` | [9–25](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/search_routes.py#L9) |
| `router.workspace_search` | async_function | `request`, `q` | [13–23](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/search_routes.py#L13) |

</details>

## app.seed

[app/seed.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/seed.py#L1); exact source SHA-256 `4009105e059783c2584b5d0e8fe3cd8b67f91847615c01d111690bb659503bde`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `seed` | function | `db`, `settings`, `profile`, `source` | [15–102](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/seed.py#L15) |

</details>

## app.sending

[app/sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L1); exact source SHA-256 `54109ad28c289bbfcb415fd556c002c4cdb651a292a09e737fa18dace0ad547b`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `OutboundMessage` | class | — | [65–73](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L65) |
| `DeliveryResult` | class | — | [77–80](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L77) |
| `_now` | function | `value` | [83–87](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L83) |
| `_owner` | function | `db`, `owner_id`, `lock` | [90–103](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L90) |
| `preferences` | function | `db`, `owner_id`, `lock` | [106–117](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L106) |
| `validate_template` | function | `subject`, `body` | [120–133](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L120) |
| `validate_recipient` | function | `recipient` | [136–143](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L136) |
| `validate_followups` | function | `followup_interval_days`, `followup_max` | [146–155](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L146) |
| `_values` | function | `db`, `invoice` | [158–166](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L158) |
| `render_templates` | function | `db`, `owner_id`, `invoice_id`, `subject`, `body` | [169–181](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L169) |
| `update_templates` | function | `db`, `owner_id`, `initial_subject`, `initial_body`, `followup_subject`, `followup_body`, `request_id` | [184–191](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L184) |
| `_artifact` | function | `db`, `invoice`, `expected_id`, `expected_sha` | [194–211](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L194) |
| `prepare` | function | `db`, `owner_id`, `invoice_id`, `recipient`, `artifact_sha256`, `subject`, `body`, `confirmed`, `followup_subject`, `followup_body`, `followup_interval_days`, `followup_max`, `request_id`, `now` | [214–285](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L214) |
| `_stop` | function | `db`, `owner_id`, `plan`, `reason`, `request_id`, `now` | [288–301](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L288) |
| `stop_plan` | function | `db`, `owner_id`, `plan_id`, `request_id` | [304–312](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L304) |
| `stop_for_invoice` | function | `db`, `owner_id`, `invoice_id`, `reason`, `request_id` | [315–326](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L315) |
| `stop_all` | function | `db`, `owner_id`, `request_id` | [329–338](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L329) |
| `resume` | function | `db`, `owner_id`, `request_id` | [341–345](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L341) |
| `retry` | function | `db`, `owner_id`, `delivery_id`, `request_id`, `now` | [348–367](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L348) |
| `dashboard` | function | `db`, `owner_id`, `plan_number`, `eligible_number` | [370–400](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L370) |
| `_locked_delivery` | function | `db`, `owner_id`, `delivery_id` | [403–413](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L403) |
| `due_deliveries` | function | `db`, `owner_id`, `now`, `limit` | [416–436](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L416) |
| `_blocked` | function | `db`, `prefs`, `invoice`, `plan` | [439–452](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L439) |
| `_manual_followup_context` | function | `db`, `owner_id`, `prefs`, `invoice`, `plan`, `delivery` | [455–496](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L455) |
| `manual_followup_preview` | function | `db`, `owner_id`, `delivery_id` | [499–510](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L499) |
| `dispatch_delivery` | function | `factory`, `owner_id`, `delivery_id`, `transport`, `request_id`, `now`, `manual_followup`, `expected_review_digest` | [513–665](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L513) |

</details>

## app.sending_dispatch_routes

[app/sending_dispatch_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L1); exact source SHA-256 `10e6ca799e17cb6f3acc8fe474f21159c262e3987664cdb18fe13ac5a3a544aa`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `build_router` | function | `config`, `page` | [13–82](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L13) |
| `build_router.enabled` | function | — | [16–20](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L16) |
| `build_router.followup_review` | async_function | `request`, `delivery_id` | [23–31](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L23) |
| `build_router.followup_dispatch` | async_function | `request`, `delivery_id` | [34–57](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L34) |
| `build_router.dispatch` | async_function | `request`, `delivery_id` | [60–80](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L60) |

</details>

## app.sending_models

[app/sending_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L1); exact source SHA-256 `5e2540ac381f7f85016700bab1639187f86609a342f4c3ba62d8f519a7f738b7`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `SendingPreferences` | class | — | [21–28](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L21) |
| `SendingPlan` | class | — | [31–52](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L31) |
| `SendingDelivery` | class | — | [55–69](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L55) |
| `SendingAttempt` | class | — | [72–84](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L72) |

</details>

## app.sending_routes

[app/sending_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L1); exact source SHA-256 `96d134fa87766a80ef46a7df7f0eee545cf4d75114e4251dfbfcd1de525f5392`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_utc` | function | `value` | [14–15](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L14) |
| `_followups` | function | `values` | [18–28](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L18) |
| `build_router` | function | `page`, `mutate`, `config` | [31–183](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L31) |
| `build_router.sending_available` | async_function | — | [32–34](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L32) |
| `build_router.dashboard` | function | `request`, `values`, `errors` | [38–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L38) |
| `build_router.preparation` | function | `request`, `invoice_id`, `values`, `errors`, `review` | [50–97](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L50) |
| `build_router.index` | async_function | `request` | [100–101](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L100) |
| `build_router.prepare_form` | async_function | `request`, `invoice_id` | [104–105](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L104) |
| `build_router.review` | async_function | `request`, `invoice_id` | [108–114](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L108) |
| `build_router.edit` | async_function | `request`, `invoice_id` | [117–118](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L117) |
| `build_router.prepare` | async_function | `request`, `invoice_id` | [121–137](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L121) |
| `build_router.prepare.save` | function | `db`, `actor`, `data`, `rid` | [122–131](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L122) |
| `build_router.templates` | async_function | `request` | [140–153](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L140) |
| `build_router.templates.save` | function | `db`, `actor`, `data`, `rid` | [141–147](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L141) |
| `build_router.stop` | async_function | `request`, `plan_id` | [156–160](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L156) |
| `build_router.stop_all` | async_function | `request` | [163–167](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L163) |
| `build_router.resume` | async_function | `request` | [170–174](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L170) |
| `build_router.retry` | async_function | `request`, `delivery_id` | [177–181](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L177) |

</details>

## app.sending_transport

[app/sending_transport.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_transport.py#L1); exact source SHA-256 `87566951cfe2a1a38bf78650b4322281a9d3fc579293264fa276c8815bc6a74f`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `CloudflareSending` | class | — | [19–110](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_transport.py#L19) |
| `CloudflareSending.__init__` | function | `self`, `config` | [20–29](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_transport.py#L20) |
| `CloudflareSending.__call__` | function | `self`, `message` | [31–110](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_transport.py#L31) |
| `transport_from_settings` | function | `config` | [113–116](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_transport.py#L113) |

</details>

## app.settings

[app/settings.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L1); exact source SHA-256 `7653208aa42c2d40c40485f6b6b86c7a9ae574d9a11ec85a2118d843d4ba30f3`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `preferences` | function | `db` | [16–28](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L16) |
| `lookup_limits` | function | `db` | [31–41](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L31) |
| `lookup_limits.bounded` | function | `key`, `maximum` | [34–38](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L34) |
| `_locked_preferences` | function | `db` | [44–50](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L44) |
| `save_lookup_limits` | function | `db`, `actor`, `data`, `request_id` | [53–68](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L53) |
| `save_record_limits` | function | `db`, `actor`, `data`, `request_id` | [71–80](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L71) |
| `save_issuer` | function | `db`, `actor`, `config`, `data`, `request_id` | [83–149](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L83) |
| `confirm_contract` | function | `db`, `actor`, `client_id`, `data`, `request_id` | [152–163](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L152) |

</details>

## app.social_auth

[app/social_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/social_auth.py#L1); exact source SHA-256 `16ca8368511d60857cd3ca928b469d996f52fa0a1a28fea463df1794a1dbbbc9`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `SocialAuthError` | class | — | [12–14](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/social_auth.py#L12) |
| `SocialAuthError.__init__` | function | `self` | [13–14](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/social_auth.py#L13) |
| `configured_providers` | function | `settings`, `identities` | [17–25](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/social_auth.py#L17) |
| `github_identity` | async_function | `token`, `admitted_emails`, `transport`, `allow_unadmitted` | [28–76](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/social_auth.py#L28) |

</details>

## app.static_assets

[app/static_assets.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/static_assets.py#L1); exact source SHA-256 `be5f61745af96e9a730b826367c3d94db0db62bb070e5bca7f1d9b98adf58d46`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `StaticAssets` | class | — | [15–56](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/static_assets.py#L15) |
| `StaticAssets.from_directory` | function | `cls`, `directory` | [21–35](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/static_assets.py#L21) |
| `StaticAssets.url` | function | `self`, `name` | [37–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/static_assets.py#L37) |
| `StaticAssets.cache_control` | function | `self`, `path`, `query_string`, `method`, `status_code` | [41–56](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/static_assets.py#L41) |

</details>

## app.subscription_billing

[app/subscription_billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1); exact source SHA-256 `53936d4dbf846483aafecf2fe7daa91e9807f3f0e3ad697fd7f345619178fbd7`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_date` | function | `value` | [49–60](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L49) |
| `_id` | function | `value`, `prefix` | [63–66](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L63) |
| `_period` | function | `data` | [69–75](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L69) |
| `_offer` | function | `data`, `prices` | [78–96](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L78) |
| `_proof` | function | `transaction`, `subscription`, `prices`, `tenant_id`, `checkout_id`, `initial` | [99–140](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L99) |
| `_fingerprint` | function | `settings` | [143–158](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L143) |
| `_account` | function | `db`, `actor` | [161–169](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L161) |
| `_configured` | function | `settings` | [172–177](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L172) |
| `_provider` | function | `settings` | [180–181](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L180) |
| `_mode_compatible` | function | `db`, `settings` | [184–191](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L184) |
| `_require_mode` | function | `db`, `settings` | [194–198](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L194) |
| `_pending_checkout` | function | `db`, `actor`, `account`, `exclude` | [201–221](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L201) |
| `billing_view` | function | `db`, `actor`, `settings` | [224–294](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L224) |
| `_require_verified` | function | `db`, `actor`, `settings` | [297–299](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L297) |
| `verify_catalog` | async_function | `tenant`, `actor`, `settings` | [302–325](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L302) |
| `_receipt` | function | `operation`, `replayed` | [328–335](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L328) |
| `_reserve` | function | `db`, `actor`, `action`, `key`, `intent` | [338–385](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L338) |
| `_record_failure` | function | `tenant`, `actor`, `identifier`, `error` | [388–397](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L388) |
| `start_checkout` | async_function | `tenant`, `actor`, `settings`, `operation_key`, `offer`, `renewal_authorized` | [400–439](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L400) |
| `owner_portal` | async_function | `tenant`, `actor`, `settings` | [442–451](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L442) |
| `reconcile_checkout` | async_function | `tenant`, `actor`, `settings`, `checkout_id` | [454–510](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L454) |
| `_inventory_version` | function | `db` | [513–533](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L513) |
| `_retained_selection` | function | `db`, `actor`, `plan_code`, `client_ids`, `project_ids`, `expected_version` | [536–546](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L536) |
| `_apply_selection` | function | `db`, `actor`, `plan_code`, `saved` | [549–594](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L549) |
| `_set_entitlement` | function | `db`, `actor`, `account`, `proof`, `initial`, `upgrade` | [597–631](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L597) |
| `_event_receipt` | function | `event`, `replayed` | [634–640](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L634) |
| `_existing_event` | function | `db`, `identifier`, `digest` | [643–647](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L643) |
| `_matching_upgrade` | function | `db`, `account`, `transaction`, `proof` | [650–684](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L650) |
| `_reconcile_effects` | function | `db`, `account`, `subscription`, `prices` | [687–736](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L687) |
| `handle_verified_event` | async_function | `tenant`, `settings`, `event`, `raw_digest` | [739–970](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L739) |
| `_totals` | function | `transaction` | [973–984](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L973) |
| `_direction` | function | `source`, `target` | [987–998](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L987) |
| `_review` | function | `data`, `account`, `target`, `selection`, `instant` | [1001–1038](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1001) |
| `preview_plan_change` | async_function | `tenant`, `actor`, `settings`, `target_offer`, `operation_key`, `expected_version`, `client_ids`, `project_ids` | [1041–1095](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1041) |
| `confirm_plan_change` | async_function | `tenant`, `actor`, `settings`, `review_id`, `operation_key`, `confirmed` | [1098–1191](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1098) |
| `_renewal_history` | function | `db`, `actor`, `account` | [1194–1224](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1194) |
| `check_renewal_status` | async_function | `tenant`, `actor`, `settings`, `operation_key` | [1227–1278](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1227) |
| `_retention_claim` | function | `db`, `actor` | [1281–1291](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1281) |
| `_retention_pending` | function | `db`, `actor` | [1294–1304](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1294) |
| `_retention_account` | function | `db`, `actor`, `settings` | [1307–1326](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1307) |
| `_retention_binding` | function | `data`, `account`, `tenant_id` | [1329–1358](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1329) |
| `_retention_quote` | function | `snapshot`, `account`, `tenant_id`, `instant` | [1361–1429](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1361) |
| `preview_retention` | async_function | `tenant`, `actor`, `settings`, `operation_key` | [1432–1452](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1432) |
| `confirm_retention` | async_function | `tenant`, `actor`, `settings`, `review_id`, `operation_key`, `confirmed` | [1455–1516](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1455) |
| `_retention_effect_matches` | function | `review`, `account`, `data` | [1519–1544](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1519) |
| `_reconcile_retention` | function | `db`, `operation`, `account`, `data` | [1547–1579](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1547) |
| `reconcile_retention` | async_function | `tenant`, `actor`, `settings`, `operation_id` | [1582–1599](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1582) |
| `cancel_renewal` | async_function | `tenant`, `actor`, `settings`, `operation_key`, `confirmed` | [1602–1638](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1602) |

</details>

## app.subscription_billing_models

[app/subscription_billing_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L1); exact source SHA-256 `6d7e872cb2c38646c8eaea8859c0da4412a6bed26ea20d96ab91d6f1e6cbce58`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `BillingAccount` | class | — | [24–68](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L24) |
| `BillingOperation` | class | — | [71–86](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L71) |
| `BillingEvent` | class | — | [89–101](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L89) |

</details>

## app.subscription_models

[app/subscription_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L1); exact source SHA-256 `3a04dfbdcaf1922272d72ac788ef2179160156962dfb64402a40fdcac9501743`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `WorkspaceSubscription` | class | — | [13–34](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L13) |
| `SubscriptionOperation` | class | — | [37–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L37) |

</details>

## app.subscription_payment_routes

[app/subscription_payment_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L1); exact source SHA-256 `a66dd4e3f88a242d7c85a8e2cb9e110f99cd1f43ade1f2cb00dc50029dbef3c0`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `command_form` | async_function | `request`, `allowed`, `lists` | [26–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L26) |
| `owner_router` | function | `page` | [51–389](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L51) |
| `owner_router.error_page` | function | `request`, `error` | [54–68](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L54) |
| `owner_router.checkout_operation` | function | `request`, `identifier`, `transaction_id` | [70–90](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L70) |
| `owner_router.checkout_return` | async_function | `request` | [93–104](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L93) |
| `owner_router.checkout_page` | async_function | `request`, `operation_id` | [107–126](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L107) |
| `owner_router.checkout` | async_function | `request` | [129–151](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L129) |
| `owner_router.catalog` | async_function | `request` | [154–162](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L154) |
| `owner_router.portal` | async_function | `request` | [165–178](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L165) |
| `owner_router.reconcile_checkout` | async_function | `request` | [181–197](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L181) |
| `owner_router.cancel` | async_function | `request` | [200–217](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L200) |
| `owner_router.change_preview` | async_function | `request` | [220–274](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L220) |
| `owner_router.renewal_check` | async_function | `request` | [277–291](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L277) |
| `owner_router.retention_preview` | async_function | `request` | [294–326](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L294) |
| `owner_router.retention_confirm` | async_function | `request` | [329–347](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L329) |
| `owner_router.retention_reconcile` | async_function | `request` | [350–366](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L350) |
| `owner_router.change_confirm` | async_function | `request` | [369–387](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L369) |
| `public_router` | function | — | [392–434](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L392) |
| `public_router.webhook` | async_function | `request` | [396–432](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L396) |

</details>

## app.subscription_routes

[app/subscription_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L1); exact source SHA-256 `122a1bdd40a236c8fbea7d52732291e1f51a895e8f1d4fe6afe29dcffb89920f`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `selection_form` | async_function | `request`, `confirming` | [14–47](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L14) |
| `router` | function | `page`, `mutate` | [50–166](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L50) |
| `router.render` | function | `request`, `view`, `values`, `errors`, `db` | [53–108](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L53) |
| `router.subscription` | async_function | `request` | [111–112](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L111) |
| `router.preview` | async_function | `request` | [115–131](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L115) |
| `router.enroll` | async_function | `request` | [134–164](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L134) |
| `router.enroll.action` | function | `db`, `actor`, `_form`, `request_id` | [146–155](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L146) |

</details>

## app.subscriptions

[app/subscriptions.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L1); exact source SHA-256 `e9cce91ef4287afd5f7cc0931681f9b1359795ca42b036e47c1adcfe4ac5d9fd`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `CapacityError` | class | — | [23–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L23) |
| `CapacityError.__init__` | function | `self`, `plan`, `resource`, `limit` | [26–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L26) |
| `Plan` | class | — | [43–49](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L43) |
| `capacity_lock` | function | `db` | [61–69](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L61) |
| `_owner` | function | `db`, `actor` | [72–75](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L72) |
| `_assignment` | function | `db`, `actor` | [78–88](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L78) |
| `usage` | function | `db` | [91–104](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L91) |
| `require_capacity` | function | `db`, `actor`, `client_delta`, `project_delta` | [107–142](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L107) |
| `_plain` | function | `value` | [145–166](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L145) |
| `_digest` | function | `value` | [169–174](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L169) |
| `_operation_values` | function | `action`, `key`, `payload` | [177–182](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L177) |
| `replay_operation` | function | `db`, `actor`, `action`, `key`, `payload` | [185–200](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L185) |
| `finish_operation` | function | `db`, `actor`, `action`, `key`, `payload`, `result` | [203–227](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L203) |
| `_view` | function | `db`, `actor` | [230–285](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L230) |
| `subscription_view` | function | `db`, `actor` | [288–291](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L288) |
| `_ids` | function | `values`, `label` | [294–303](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L294) |
| `_selection` | function | `view`, `plan_code`, `client_ids`, `project_ids` | [306–342](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L306) |
| `preview_selection` | function | `db`, `actor`, `plan_code`, `client_ids`, `project_ids` | [345–346](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L345) |
| `enroll_free` | function | `db`, `actor`, `operation_key`, `expected_version`, `client_ids`, `project_ids`, `request_id` | [349–439](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L349) |

</details>

## app.tenancy

[app/tenancy.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L1); exact source SHA-256 `93211d39a9a73ac7ff964eec909be76f25f44dd8c3ff139770cb47b8e7f04beb`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `Tenant` | class | — | [54–60](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L54) |
| `PreparedSlot` | class | — | [64–69](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L64) |
| `current_tenant` | function | — | [72–76](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L72) |
| `_email` | function | `value` | [79–87](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L79) |
| `_demo_billing` | function | `settings`, `demo` | [90–95](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L90) |
| `TenantRegistry` | class | — | [98–427](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L98) |
| `TenantRegistry.__init__` | function | `self`, `settings` | [99–292](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L99) |
| `TenantRegistry.refresh_admissions` | function | `self` | [294–317](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L294) |
| `TenantRegistry.resolve_claims` | function | `self`, `claims` | [319–328](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L319) |
| `TenantRegistry.session_tenant` | function | `self`, `session` | [330–336](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L330) |
| `TenantRegistry.bind` | function | `self`, `selected` | [339–346](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L339) |
| `TenantRegistry.ready` | function | `self` | [348–355](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L348) |
| `TenantRegistry._check_databases` | function | `self` | [357–423](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L357) |
| `TenantRegistry.dispose` | function | `self` | [425–427](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L425) |
| `RequestScopedSettings` | class | — | [430–435](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L430) |
| `RequestScopedSettings.__init__` | function | `self`, `registry` | [431–432](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L431) |
| `RequestScopedSettings.__getattr__` | function | `self`, `name` | [434–435](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L434) |
| `DBRouter` | class | — | [438–446](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L438) |
| `DBRouter.__init__` | function | `self`, `registry` | [439–440](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L439) |
| `DBRouter.__call__` | function | `self` | [442–443](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L442) |
| `DBRouter.begin` | function | `self` | [445–446](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L445) |
| `ContactRouter` | class | — | [449–466](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L449) |
| `ContactRouter.__init__` | function | `self`, `registry`, `signing_key` | [450–457](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L450) |
| `ContactRouter.__getattr__` | function | `self`, `name` | [459–466](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L459) |
| `TenantMiddleware` | class | — | [469–511](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L469) |
| `TenantMiddleware.__init__` | function | `self`, `app`, `registry` | [470–471](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L470) |
| `TenantMiddleware.__call__` | async_function | `self`, `scope`, `receive`, `send` | [473–511](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L473) |

</details>

## app.tenant_demo

[app/tenant_demo.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenant_demo.py#L1); exact source SHA-256 `b0d5609aba928c7ecaef018aeb677521af22dd0648165fd63a7c5b85f577a7be`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `seed_tenant_demo` | function | `db`, `registry`, `tenant` | [19–232](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenant_demo.py#L19) |

</details>

## app.time_command_models

[app/time_command_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L1); exact source SHA-256 `5d19880baee473007d13ac2b7e26f390be645bb532efe82adca7310a598a8ddb`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `TimeImportRecord` | class | — | [13–23](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L13) |
| `TimeContribution` | class | — | [26–46](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L26) |
| `TimeOperation` | class | — | [49–61](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L49) |

</details>

## app.time_commands

[app/time_commands.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L1); exact source SHA-256 `0953e5f22da94c48e9f8717c2dd88ecd47223705cd9fd169ebc8fc1fca2435f0`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_owner` | function | `db`, `actor` | [28–31](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L28) |
| `_source` | function | `source` | [34–37](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L34) |
| `_receipt` | function | `db`, `actor`, `source`, `operation_key`, `digest` | [40–59](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L40) |
| `_store_receipt` | function | `db`, `actor`, `source`, `operation_key`, `digest`, `operation`, `result`, `request_id` | [62–74](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L62) |
| `_parents` | function | `db`, `actor`, `row`, `lock`, `open_cases` | [77–100](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L77) |
| `_card` | function | `db`, `actor`, `client`, `start`, `expected_version`, `create` | [103–128](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L103) |
| `_bounds` | function | `db`, `card`, `project_id`, `work_date`, `delta` | [131–141](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L131) |
| `_allocation` | function | `db`, `actor`, `entry`, `case_id`, `delta`, `request_id` | [144–167](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L144) |
| `_result` | function | `db`, `card`, `contribution`, `client`, `delta`, `operation_id` | [170–201](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L170) |
| `_add` | function | `db`, `actor`, `row`, `source`, `source_item_id`, `expected_version`, `request_id`, `open_cases`, `import_record_id` | [204–261](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L204) |
| `add_contribution` | function | `db`, `actor`, `data`, `source`, `request_id` | [264–302](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L264) |
| `_change` | function | `db`, `actor`, `contribution_id`, `data`, `source`, `operation`, `request_id` | [305–398](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L305) |
| `update_contribution` | function | `db`, `actor`, `contribution_id`, `data`, `source`, `request_id` | [401–402](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L401) |
| `delete_contribution` | function | `db`, `actor`, `contribution_id`, `data`, `source`, `request_id` | [405–406](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L405) |
| `execute_time_command` | function | `db`, `actor`, `payload`, `request_id`, `source` | [409–422](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L409) |
| `preview_import` | function | `db`, `actor`, `batch`, `source` | [425–555](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L425) |
| `commit_import` | function | `db`, `actor`, `batch`, `expected_hash`, `expected_versions`, `source`, `request_id` | [558–646](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L558) |

</details>

## app.time_import

[app/time_import.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L1); exact source SHA-256 `b995c8dfdce546fb1a8a245bbdbf3646e823b88dde9c66d8613cdf0e9dbc2ece`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `key` | function | `value`, `label` | [37–42](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L37) |
| `integer` | function | `value`, `label`, `minimum`, `maximum` | [45–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L45) |
| `entry_values` | function | `row`, `external` | [51–79](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L51) |
| `_import_values` | function | `row` | [82–122](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L82) |
| `canonical_batch` | function | `batch` | [125–140](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L125) |
| `payload_hash` | function | `payload` | [143–147](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L143) |
| `_unique_object` | function | `pairs` | [150–156](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L150) |
| `_invalid_constant` | function | `value` | [159–160](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L159) |
| `_integer_constant` | function | `value` | [163–166](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L163) |
| `_load_json` | function | `text` | [169–192](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L169) |
| `parse_upload` | function | `payload`, `format` | [195–234](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L195) |

</details>

## app.time_import_routes

[app/time_import_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L1); exact source SHA-256 `7007db8a0a654b83b3b45c028e70c80d0acb9dec557173f538a3f9d0bf7c16c7`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_signer` | function | `request` | [29–32](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L29) |
| `_binding` | function | `request` | [35–40](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L35) |
| `_bounded_form` | async_function | `request`, `upload` | [43–74](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L43) |
| `_bounded_form.receive` | async_function | — | [53–54](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L53) |
| `build_router` | function | `page` | [77–329](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L77) |
| `build_router.render` | function | `request`, `preview`, `confirmation`, `batch_json`, `errors`, `receipt`, `contributions`, `correction`, `form_values`, `p`, `count`, `entry_filter` | [80–113](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L80) |
| `build_router.import_form` | async_function | `request` | [116–117](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L116) |
| `build_router.contribution_list` | async_function | `request`, `entry_id`, `p` | [120–159](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L120) |
| `build_router.correction_form` | function | `request`, `contribution_id`, `errors`, `form_values` | [161–196](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L161) |
| `build_router.correction_error` | function | `request`, `contribution_id`, `message`, `form` | [198–204](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L198) |
| `build_router.contribution_form` | async_function | `request`, `contribution_id` | [207–211](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L207) |
| `build_router.correct_contribution` | async_function | `request`, `contribution_id` | [214–269](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L214) |
| `build_router.preview_file` | async_function | `request` | [272–294](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L272) |
| `build_router.commit_file` | async_function | `request` | [297–327](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L297) |

</details>

## app.timecards

[app/timecards.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L1); exact source SHA-256 `49d6767b097e3e09ab2aaa32d1b847f6d5c6f63ed4d5fd0cf98c8362af64fa8a`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `selected_week_metrics` | function | `db`, `actor`, `start`, `now` | [20–52](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L20) |
| `save_week` | function | `db`, `actor`, `client_id`, `start`, `rows`, `expected_version`, `request_id`, `is_internal`, `internal_case_id` | [55–233](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L55) |
| `finalize` | function | `db`, `actor`, `card_id`, `expected_version`, `reason`, `reference`, `request_id` | [236–259](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L236) |
| `reopen` | function | `db`, `actor`, `card_id`, `reason`, `request_id` | [262–310](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L262) |
| `void` | function | `db`, `actor`, `card_id`, `reason`, `request_id` | [313–316](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L313) |
| `duplicate_structure` | function | `db`, `actor`, `card_id`, `request_id` | [319–343](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L319) |
| `remove_project_drafts` | function | `db`, `actor`, `client_id`, `start`, `rows`, `selected`, `expected_version`, `request_id` | [346–368](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L346) |

</details>

## app.usage

[app/usage.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/usage.py#L1); exact source SHA-256 `22d85b100c90de845ea1ed37dcf76209c1899d62836e0458030c5d2a3483eae0`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `UsageBudget` | class | — | [27–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/usage.py#L27) |
| `UsageBudget.__init__` | function | `self` | [30–32](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/usage.py#L30) |
| `UsageBudget.admit` | function | `self` | [34–39](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/usage.py#L34) |
| `collect_usage` | async_function | `request` | [43–88](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/usage.py#L43) |
| `collect_usage.reply` | function | `status` | [44–45](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/usage.py#L44) |

</details>

## app.work_history

[app/work_history.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_history.py#L1); exact source SHA-256 `9260dd6c87e1754209db9c9e9c1a5c64403489ca6c237d3dd494cb31903c3b24`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `describe` | function | `audit`, `label` | [41–55](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_history.py#L41) |
| `project_history` | function | `db`, `project_id`, `number`, `with_page` | [58–66](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_history.py#L58) |
| `client_history` | function | `db`, `client_id`, `number`, `with_page` | [69–85](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_history.py#L69) |

</details>

## app.work_lifecycle

[app/work_lifecycle.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L1); exact source SHA-256 `6df2ab2139991026bbe154bb354bdcc4e3f92b2dc0597538df8acf700189477f`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `blocked` | function | `field`, `message` | [10–11](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L10) |
| `confirm_transition` | function | `data`, `status` | [14–18](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L14) |
| `open_timecard` | function | `db`, `client_id`, `project_id`, `case_id` | [21–44](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L21) |
| `require_client_ready` | function | `db`, `client_id`, `closing_project_ids` | [47–62](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L47) |
| `require_project_ready` | function | `db`, `project_id`, `status` | [65–74](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L65) |
| `require_case_ready` | function | `db`, `case_id`, `status` | [77–80](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L77) |

</details>

## app.workspace_operations

[app/workspace_operations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L1); exact source SHA-256 `9aa97fed67ce9d6d269d3595573da2728353449a0fc23ec6af2d5ae7f01d9164`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `WorkspacePreparationError` | class | — | [26–27](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L26) |
| `operation_catalog` | function | `settings` | [30–38](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L30) |
| `_target` | function | `url` | [41–42](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L41) |
| `_native` | function | `connection`, `statement`, `parameters` | [45–48](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L45) |
| `_grants_source` | function | — | [51–68](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L51) |
| `_apply_runtime_grants` | function | `connection`, `schema`, `role`, `source` | [71–78](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L71) |
| `_role_safe` | function | `connection`, `role`, `schemas`, `own_schema` | [81–124](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L81) |
| `_head` | function | `connection`, `schema` | [127–131](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L127) |
| `_empty` | function | `connection`, `schema`, `tables` | [134–140](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L134) |
| `_structure` | function | `connection`, `schema` | [143–171](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L143) |
| `_binding` | function | `slot` | [174–175](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L174) |
| `_verify_slot` | function | `connection`, `slot`, `tables`, `sequences`, `operator`, `others` | [178–220](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L178) |
| `_migrate` | function | `connection` | [223–227](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L223) |
| `_verify_directory` | function | `connection`, `catalog` | [230–238](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L230) |
| `prepare_workspaces` | function | `settings`, `admin_url`, `allow_production` | [241–321](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L241) |

</details>

## app.workspace_search

[app/workspace_search.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_search.py#L1); exact source SHA-256 `4a524b6e2f04f2a310cadf18fdf2a2723dc036bd5ba6c2a8401ec13d4122d096`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `_matches` | function | `query` | [15–16](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_search.py#L15) |
| `search` | function | `db`, `owner_id`, `query`, `quoting_available` | [19–84](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_search.py#L19) |
| `search.items` | function | `index`, `rows` | [25–26](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_search.py#L25) |

</details>

## scripts.render_invitation

[scripts/render_invitation.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/scripts/render_invitation.py#L1); exact source SHA-256 `a40e18aa97da3ea53566d4db18ab8ee6768beb35dd6f762a7aa6f8ffa35fab70`.

<details>
<summary>All declarations and parameter names</summary>

| Qualified declaration | Kind | Parameters | Source |
| --- | --- | --- | --- |
| `render_invitation` | function | `recipient_name`, `inviter_name`, `workspace_name`, `invite_url`, `stage`, `wordmark_src`, `expires_label` | [12–53](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/scripts/render_invitation.py#L12) |
| `main` | function | — | [56–75](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/scripts/render_invitation.py#L56) |

</details>
