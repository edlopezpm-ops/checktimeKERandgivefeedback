# 13 — Permanent PROD/Stage repositories and the private prelaunch candidate

Snapshot **2026-10-18**, reviewed candidate `4bb5c424d6e7d270cdca1479283896be77d581c3` on the permanent shared `main` lineage. Permanent repositories are [timeKER-PROD](https://github.com/edlopezpm-ops/timeKER-PROD) and [timeKER-Stage](https://github.com/edlopezpm-ops/timeKER-Stage). They share product lineage while retaining independent databases, configuration, identities and release histories. Phase numbers identify delivery scope, not temporary repositories.

The private PH2 production prelaunch under D076 is technically verified; personal Google/acknowledgment, catalog verification/plan choice and human UAT remain pending. PH3 feature prompts follow this bounded release. Sources: [CONTINUE](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/CONTINUE.md#L1), [D076](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/DECISIONS.md#L1101), [current hosting registry](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L1).

## Candidate ancestry and source identity

The candidate retains original production main `dfb2538ec81d07f1c91fdf2bdc5096d4d0313609` and original draft `4f60d228fb205cff09698b94d6749dd86d76164a` as ancestors, together with the later consolidated Stage lineage. The original draft is not substituted for later work. The candidate's reviewed Git tree is `e0dd4c64d603b3e8c551342395b9683389821f25`; a merge commit is source provenance, not deployment evidence.

Frozen PH2 remains `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6` / `ph2-closeout-2026-10-18`. D076 supersedes the earlier decision to wait for combined PH2+PH3 before any promotion. It does not implement future PH3 prompts or erase open P2/EXT acceptance, recovery, provider and commercial decisions.

## Environment and activation boundaries

| Boundary | Production | Stage |
| --- | --- | --- |
| Canonical URL | https://timeker.aekr.io | https://stage-timeker.aekr.io |
| Repository | timeKER-PROD | timeKER-Stage |
| Actual application evidence | Deployed runtime `5b0fb0d29f506d04e4a6af3ebd8a193089af7214`; container/running version `13`; both retained schemas head009 | Last retained Stage29/source e282985/schema009 evidence |
| Selected prelaunch | Explicit true for the bounded private candidate; source default false | No prelaunch flag activation; existing Stage policy retained |
| Admission | Existing fixed-owner Google path; generic/public/email-public/Stage onboarding false | Separate retained Google/GitHub/managed-email and prepared admission configuration |
| Personal identity | Fresh Google proof and explicit versioned acknowledgment performed by each owner; no operator backfill | Stage identity and acknowledgments are never copied to production |
| Billing provider | Explicit Paddle Sandbox; Live false | Retained Paddle Sandbox; source/provider history stays separate |
| Quoting/Library/Sending workspace | Ordinary production defaults closed; explicit prelaunch permits existing workspace capabilities | Existing delivered features retained |
| Outbound delivery | Sending provider and jobs disabled; visibility does not authorize messages | Scheduled Sending remains disabled; any addressed test needs separate authority |
| Contact/inbound Mail | Preserve current production contact and enabled inbound-capture runtime/domain/routing overrides | Existing separate Stage defaults and bindings retained |
| SQL/configuration | Existing production project, schema/roles, tenant registry, secrets, encrypted settings and issued artifacts preserved | Independent Stage SQL/schema/roles/registry/provider bindings; no copy into PROD |
| Actual release status | Technical backup/preservation, exact local recovery, migration/grants, deployment and canonical health/assets verified; personal flow pending | No Stage deployment belongs to this production promotion |

Sources: [settings validation](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L174), [capabilities](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L203), [edge policy](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/proxy.ts#L131), [checkout template](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_checkout.html#L5), [preserved production custody](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L1), [release checkpoint](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L1).

Production is not a Stage Worker rename. Never copy Stage SQL records, identities, provider bindings, browser sessions, accepted notices, Sandbox purchase history or synthetic plan grants. Existing fixed owners supply personal fresh proof and acknowledgment through the normal registration path. Later generic/public launch still requires complete active-owner identity coverage and prepared admission capacity; Live merchant/catalog/webhook selection and hosted recovery remain separate.

The package refresh made no hosted/database/provider call. Exact production source/schema/Worker/deployment/container/image identities and readback are recorded from retained release receipts below; final source and deployed runtime pins remain distinct. A backup capture or TOC is not hosted restore or recovery acceptance. Dated production infrastructure details are retained without publishing operator author metadata in [HOSTING](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L1); original full registry is pinned at [original PROD main](https://github.com/edlopezpm-ops/timeKER-PROD/blob/dfb2538ec81d07f1c91fdf2bdc5096d4d0313609/HOSTING.md).

## Static Git tree comparison with retained original production main

| Metadata category | Count |
| --- | ---: |
| Original tracked paths at `dfb2538` | 230 |
| Current candidate tracked paths at `4bb5c42` | 506 |
| Shared identical Git blobs | 102 |
| Shared different Git blobs | 128 |
| Candidate-only paths | 276 |
| Original-only paths | 0 |
| Changed/added/removed rows below | 404 |

Immutable `git ls-tree -r` object comparisons and `git diff --shortstat` report: `404 files changed, 56142 insertions(+), 1676 deletions(-)`. These are source metadata, not database records, executed tests, risk/readiness scores or deployed artifacts. The earlier initial PH3 clone's 503-file/500-nonstartup identity check remains historical; it does not describe this later candidate. Current exact counts and raw-byte source hashes are in [chapter12](12-source-map-tests-and-manifest.md).

The 45 migration/model/database/grants inputs match the original empty-schema reconstruction source by Git blob. The complete database catalog is inherited with explicit attribution and no DDL rerun; no hosted structural inventory or recovery is inferred. See [database provenance](database/PROVENANCE.json).

## Complete changed-path metadata

Text links pin line1 of each committed candidate file; binary links pin the blob. Original-only paths, if any, point to the retained original baseline. No private source body, credential or business record is copied into this comparison. These rows are an inventory, not an instruction to replace production files without the reviewed environment release procedure.

| Path | Source relationship |
| --- | --- |
| [.dockerignore](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/.dockerignore#L1) | Different Git blob |
| [.env.example](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/.env.example#L1) | Different Git blob |
| [.gitignore](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/.gitignore#L1) | Different Git blob |
| [AGENTS.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/AGENTS.md#L1) | Different Git blob |
| [CONTINUE.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/CONTINUE.md#L1) | Candidate only |
| [Dockerfile](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/Dockerfile#L1) | Different Git blob |
| [HOSTING.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L1) | Different Git blob |
| [PROJECT_MAP.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/PROJECT_MAP.md#L1) | Different Git blob |
| [README.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/README.md#L1) | Different Git blob |
| [alembic/env.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/env.py#L1) | Different Git blob |
| [alembic/versions/ph2_001_credit_memos.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py#L1) | Candidate only |
| [alembic/versions/ph2_002_time_commands.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L1) | Candidate only |
| [alembic/versions/ph2_003_integrations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_003_integrations.py#L1) | Candidate only |
| [alembic/versions/ph3_001_subscriptions.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_001_subscriptions.py#L1) | Candidate only |
| [alembic/versions/ph3_002_sandbox_billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_002_sandbox_billing.py#L1) | Candidate only |
| [alembic/versions/ph3_003_onboarding_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_003_onboarding_auth.py#L1) | Candidate only |
| [alembic/versions/ph3_004_sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_004_sending.py#L1) | Candidate only |
| [alembic/versions/ph3_005_public_admission.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_005_public_admission.py#L1) | Candidate only |
| [alembic/versions/ph3_006_quoting_library.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py#L1) | Candidate only |
| [alembic/versions/ph3_007_work_records.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L1) | Candidate only |
| [alembic/versions/ph3_008_client_lifecycle.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_008_client_lifecycle.py#L1) | Candidate only |
| [alembic/versions/ph3_009_read_indexes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_009_read_indexes.py#L1) | Candidate only |
| [app/admission.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission.py#L1) | Candidate only |
| [app/admission_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L1) | Candidate only |
| [app/admission_operations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_operations.py#L1) | Candidate only |
| [app/archive_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archive_routes.py#L1) | Different Git blob |
| [app/archiving.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/archiving.py#L1) | Different Git blob |
| [app/auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/auth.py#L1) | Different Git blob |
| [app/billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/billing.py#L1) | Different Git blob |
| [app/case_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/case_routes.py#L1) | Different Git blob |
| [app/cases.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cases.py#L1) | Different Git blob |
| [app/cli.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/cli.py#L1) | Different Git blob |
| [app/client_drafts.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_drafts.py#L1) | Candidate only |
| [app/client_sources.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/client_sources.py#L1) | Candidate only |
| [app/clients.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/clients.py#L1) | Different Git blob |
| [app/config.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L1) | Different Git blob |
| [app/credit_memo_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/credit_memo_models.py#L1) | Candidate only |
| [app/dashboard.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/dashboard.py#L1) | Candidate only |
| [app/data/COPYRIGHT.pycountry.txt](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/data/COPYRIGHT.pycountry.txt#L1) | Candidate only |
| [app/data/LICENSE.pycountry.txt](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/data/LICENSE.pycountry.txt#L1) | Candidate only |
| [app/data/README.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/data/README.md#L1) | Candidate only |
| [app/data/iso_3166-1.json](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/data/iso_3166-1.json#L1) | Candidate only |
| [app/data/iso_4217.json](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/data/iso_4217.json#L1) | Candidate only |
| [app/db.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L1) | Different Git blob |
| [app/demo.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/demo.py#L1) | Different Git blob |
| [app/email_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/email_auth.py#L1) | Candidate only |
| [app/enrollment.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment.py#L1) | Candidate only |
| [app/enrollment_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L1) | Candidate only |
| [app/enrollment_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_routes.py#L1) | Candidate only |
| [app/flexfields.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/flexfields.py#L1) | Candidate only |
| [app/forms.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/forms.py#L1) | Different Git blob |
| [app/integration_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_auth.py#L1) | Candidate only |
| [app/integration_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L1) | Candidate only |
| [app/integration_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_routes.py#L1) | Candidate only |
| [app/internal_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/internal_routes.py#L1) | Different Git blob |
| [app/library.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library.py#L1) | Candidate only |
| [app/library_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L1) | Candidate only |
| [app/library_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_routes.py#L1) | Candidate only |
| [app/logging.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/logging.py#L1) | Different Git blob |
| [app/lookups.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/lookups.py#L1) | Different Git blob |
| [app/mail_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L1) | Different Git blob |
| [app/mail_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_routes.py#L1) | Different Git blob |
| [app/main.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/main.py#L1) | Different Git blob |
| [app/models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L1) | Different Git blob |
| [app/paddle.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/paddle.py#L1) | Candidate only |
| [app/pagination.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pagination.py#L1) | Candidate only |
| [app/pdf.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/pdf.py#L1) | Different Git blob |
| [app/project_billing_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_billing_routes.py#L1) | Different Git blob |
| [app/project_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/project_routes.py#L1) | Different Git blob |
| [app/proposal_sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending.py#L1) | Candidate only |
| [app/proposal_sending_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L1) | Candidate only |
| [app/proposal_sending_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_routes.py#L1) | Candidate only |
| [app/proposal_sending_transport.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_transport.py#L1) | Candidate only |
| [app/quoting.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting.py#L1) | Candidate only |
| [app/quoting_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L1) | Candidate only |
| [app/quoting_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_routes.py#L1) | Candidate only |
| [app/record_references.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/record_references.py#L1) | Candidate only |
| [app/reference_choices.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reference_choices.py#L1) | Candidate only |
| [app/reports.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/reports.py#L1) | Different Git blob |
| [app/repositories.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/repositories.py#L1) | Different Git blob |
| [app/search_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/search_routes.py#L1) | Candidate only |
| [app/seed.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/seed.py#L1) | Different Git blob |
| [app/sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending.py#L1) | Candidate only |
| [app/sending_dispatch_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_dispatch_routes.py#L1) | Candidate only |
| [app/sending_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L1) | Candidate only |
| [app/sending_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_routes.py#L1) | Candidate only |
| [app/sending_transport.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_transport.py#L1) | Candidate only |
| [app/settings.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/settings.py#L1) | Different Git blob |
| [app/social_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/social_auth.py#L1) | Candidate only |
| [app/static_assets.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/static_assets.py#L1) | Candidate only |
| [app/subscription_billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing.py#L1) | Candidate only |
| [app/subscription_billing_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L1) | Candidate only |
| [app/subscription_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L1) | Candidate only |
| [app/subscription_payment_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_payment_routes.py#L1) | Candidate only |
| [app/subscription_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_routes.py#L1) | Candidate only |
| [app/subscriptions.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscriptions.py#L1) | Candidate only |
| [app/tenancy.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L1) | Different Git blob |
| [app/tenant_demo.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenant_demo.py#L1) | Different Git blob |
| [app/time_command_models.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L1) | Candidate only |
| [app/time_commands.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_commands.py#L1) | Candidate only |
| [app/time_import.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import.py#L1) | Candidate only |
| [app/time_import_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_import_routes.py#L1) | Candidate only |
| [app/timecards.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/timecards.py#L1) | Different Git blob |
| [app/web/static/app.css](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/app.css#L1) | Different Git blob |
| [app/web/static/app.js](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/app.js#L1) | Different Git blob |
| [app/web/static/auth_challenge.js](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/auth_challenge.js#L1) | Candidate only |
| [app/web/static/cases.css](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/cases.css#L1) | Candidate only |
| [app/web/static/cases.js](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/cases.js#L1) | Candidate only |
| [app/web/static/github-invertocat.svg](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/github-invertocat.svg#L1) | Candidate only |
| [app/web/static/google-g.png](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/google-g.png) | Candidate only |
| [app/web/static/google-sans-OFL.txt](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/google-sans-OFL.txt#L1) | Candidate only |
| [app/web/static/google-sans-medium.ttf](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/google-sans-medium.ttf) | Candidate only |
| [app/web/static/paddle_checkout.css](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/paddle_checkout.css#L1) | Candidate only |
| [app/web/static/paddle_checkout.js](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/paddle_checkout.js#L1) | Candidate only |
| [app/web/static/settings_cache.js](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/settings_cache.js#L1) | Candidate only |
| [app/web/static/status.css](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/status.css#L1) | Candidate only |
| [app/web/static/timecards.css](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/timecards.css#L1) | Candidate only |
| [app/web/static/timecards.js](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/timecards.js#L1) | Candidate only |
| [app/web/static/workspace.css](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/workspace.css#L1) | Candidate only |
| [app/web/static/workspace.js](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/static/workspace.js#L1) | Candidate only |
| [app/web/templates/account_security.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/account_security.html#L1) | Candidate only |
| [app/web/templates/archive.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/archive.html#L1) | Different Git blob |
| [app/web/templates/archived_timecard.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/archived_timecard.html#L1) | Different Git blob |
| [app/web/templates/assistant_connection_guide.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/assistant_connection_guide.html#L1) | Candidate only |
| [app/web/templates/audit.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/audit.html#L1) | Different Git blob |
| [app/web/templates/auth_challenge.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_challenge.html#L1) | Candidate only |
| [app/web/templates/auth_layout.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_layout.html#L1) | Candidate only |
| [app/web/templates/auth_methods.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_methods.html#L1) | Candidate only |
| [app/web/templates/auth_notice.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_notice.html#L1) | Candidate only |
| [app/web/templates/auth_notice_fields.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_notice_fields.html#L1) | Candidate only |
| [app/web/templates/auth_provider_button.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_provider_button.html#L1) | Candidate only |
| [app/web/templates/auth_provider_forms.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/auth_provider_forms.html#L1) | Candidate only |
| [app/web/templates/base.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/base.html#L1) | Different Git blob |
| [app/web/templates/billing.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/billing.html#L1) | Different Git blob |
| [app/web/templates/capacity_prompt.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/capacity_prompt.html#L1) | Candidate only |
| [app/web/templates/case_allocations.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_allocations.html#L1) | Different Git blob |
| [app/web/templates/case_detail.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_detail.html#L1) | Different Git blob |
| [app/web/templates/case_form.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_form.html#L1) | Different Git blob |
| [app/web/templates/case_mass_edit.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_mass_edit.html#L1) | Candidate only |
| [app/web/templates/case_mass_edit_content.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/case_mass_edit_content.html#L1) | Candidate only |
| [app/web/templates/cases.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/cases.html#L1) | Different Git blob |
| [app/web/templates/client_detail.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/client_detail.html#L1) | Different Git blob |
| [app/web/templates/client_drafts.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/client_drafts.html#L1) | Candidate only |
| [app/web/templates/client_form.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/client_form.html#L1) | Different Git blob |
| [app/web/templates/clients.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/clients.html#L1) | Different Git blob |
| [app/web/templates/components.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/components.html#L1) | Different Git blob |
| [app/web/templates/credit_memo.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/credit_memo.html#L1) | Candidate only |
| [app/web/templates/credit_memo_pdf.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/credit_memo_pdf.html#L1) | Candidate only |
| [app/web/templates/dashboard.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/dashboard.html#L1) | Different Git blob |
| [app/web/templates/dashboard_detail.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/dashboard_detail.html#L1) | Candidate only |
| [app/web/templates/email/invitation.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/email/invitation.html#L1) | Candidate only |
| [app/web/templates/error.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/error.html#L1) | Different Git blob |
| [app/web/templates/flexfields.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/flexfields.html#L1) | Candidate only |
| [app/web/templates/help.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/help.html#L1) | Different Git blob |
| [app/web/templates/invoice.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/invoice.html#L1) | Different Git blob |
| [app/web/templates/landing.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/landing.html#L1) | Different Git blob |
| [app/web/templates/landing_info.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/landing_info.html#L1) | Different Git blob |
| [app/web/templates/legal_policies.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/legal_policies.html#L1) | Candidate only |
| [app/web/templates/legal_policy_content.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/legal_policy_content.html#L1) | Candidate only |
| [app/web/templates/library.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/library.html#L1) | Candidate only |
| [app/web/templates/library_document.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/library_document.html#L1) | Candidate only |
| [app/web/templates/library_document_pdf.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/library_document_pdf.html#L1) | Candidate only |
| [app/web/templates/lookup.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/lookup.html#L1) | Different Git blob |
| [app/web/templates/mail.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail.html#L1) | Different Git blob |
| [app/web/templates/mail_addresses.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail_addresses.html#L1) | Different Git blob |
| [app/web/templates/mail_detail.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail_detail.html#L1) | Different Git blob |
| [app/web/templates/mail_import.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/mail_import.html#L1) | Different Git blob |
| [app/web/templates/navigation_icons.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/navigation_icons.html#L1) | Different Git blob |
| [app/web/templates/project_billing.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/project_billing.html#L1) | Different Git blob |
| [app/web/templates/project_form.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/project_form.html#L1) | Different Git blob |
| [app/web/templates/projects.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/projects.html#L1) | Different Git blob |
| [app/web/templates/proposal_sending.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/proposal_sending.html#L1) | Candidate only |
| [app/web/templates/proposal_sending_prepare.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/proposal_sending_prepare.html#L1) | Candidate only |
| [app/web/templates/proposal_sending_readiness.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/proposal_sending_readiness.html#L1) | Candidate only |
| [app/web/templates/proposal_sending_review.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/proposal_sending_review.html#L1) | Candidate only |
| [app/web/templates/public_plans.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/public_plans.html#L1) | Candidate only |
| [app/web/templates/quote_detail.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/quote_detail.html#L1) | Candidate only |
| [app/web/templates/quote_form.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/quote_form.html#L1) | Candidate only |
| [app/web/templates/quote_pdf.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/quote_pdf.html#L1) | Candidate only |
| [app/web/templates/quoting.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/quoting.html#L1) | Candidate only |
| [app/web/templates/registration.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/registration.html#L1) | Candidate only |
| [app/web/templates/reports.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/reports.html#L1) | Different Git blob |
| [app/web/templates/search.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/search.html#L1) | Candidate only |
| [app/web/templates/sending.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending.html#L1) | Candidate only |
| [app/web/templates/sending_followup_review.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending_followup_review.html#L1) | Candidate only |
| [app/web/templates/sending_prepare.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending_prepare.html#L1) | Candidate only |
| [app/web/templates/sending_readiness.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending_readiness.html#L1) | Candidate only |
| [app/web/templates/sending_review.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sending_review.html#L1) | Candidate only |
| [app/web/templates/settings.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/settings.html#L1) | Different Git blob |
| [app/web/templates/settings_integrations.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/settings_integrations.html#L1) | Candidate only |
| [app/web/templates/sign_in.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sign_in.html#L1) | Candidate only |
| [app/web/templates/sign_up.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/sign_up.html#L1) | Candidate only |
| [app/web/templates/subscription.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription.html#L1) | Candidate only |
| [app/web/templates/subscription_account.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_account.html#L1) | Candidate only |
| [app/web/templates/subscription_change_review.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_change_review.html#L1) | Candidate only |
| [app/web/templates/subscription_checkout.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_checkout.html#L1) | Candidate only |
| [app/web/templates/subscription_command.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_command.html#L1) | Candidate only |
| [app/web/templates/subscription_payment_controls.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_payment_controls.html#L1) | Candidate only |
| [app/web/templates/subscription_portal.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_portal.html#L1) | Candidate only |
| [app/web/templates/subscription_retention_review.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/subscription_retention_review.html#L1) | Candidate only |
| [app/web/templates/time_import.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/time_import.html#L1) | Candidate only |
| [app/web/templates/timecards.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/timecards.html#L1) | Different Git blob |
| [app/web/templates/workspace_search_dialog.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/web/templates/workspace_search_dialog.html#L1) | Candidate only |
| [app/work_history.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_history.py#L1) | Candidate only |
| [app/work_lifecycle.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/work_lifecycle.py#L1) | Candidate only |
| [app/workspace_operations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_operations.py#L1) | Candidate only |
| [app/workspace_search.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/workspace_search.py#L1) | Candidate only |
| [deploy/cloudflare/FOOTER_RELEASE.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/FOOTER_RELEASE.md#L1) | Different Git blob |
| [deploy/cloudflare/README.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/README.md#L1) | Different Git blob |
| [deploy/cloudflare/STAGE_RELEASE.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/STAGE_RELEASE.md#L1) | Candidate only |
| [deploy/cloudflare/VERIFICATION.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/VERIFICATION.md#L1) | Different Git blob |
| [deploy/cloudflare/package-lock.json](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/package-lock.json#L1) | Different Git blob |
| [deploy/cloudflare/package.json](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/package.json#L1) | Different Git blob |
| [deploy/cloudflare/src/contact.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/contact.ts#L1) | Different Git blob |
| [deploy/cloudflare/src/index.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/index.ts#L1) | Different Git blob |
| [deploy/cloudflare/src/internal.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/internal.ts#L1) | Different Git blob |
| [deploy/cloudflare/src/production-proxy.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/production-proxy.ts#L1) | Candidate only |
| [deploy/cloudflare/src/production.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/production.ts#L1) | Candidate only |
| [deploy/cloudflare/src/proxy.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/proxy.ts#L1) | Different Git blob |
| [deploy/cloudflare/src/stage-archive.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/src/stage-archive.ts#L1) | Candidate only |
| [deploy/cloudflare/test/paddle.test.mjs](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/test/paddle.test.mjs#L1) | Candidate only |
| [deploy/cloudflare/test/production.test.mjs](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/test/production.test.mjs#L1) | Candidate only |
| [deploy/cloudflare/test/proxy.test.mjs](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/test/proxy.test.mjs#L1) | Different Git blob |
| [deploy/cloudflare/test/sending.test.mjs](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/test/sending.test.mjs#L1) | Candidate only |
| [deploy/cloudflare/test/stage-archive.test.mjs](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/test/stage-archive.test.mjs#L1) | Candidate only |
| [deploy/cloudflare/tsconfig.json](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/tsconfig.json#L1) | Different Git blob |
| [deploy/cloudflare/worker-configuration.d.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/worker-configuration.d.ts#L1) | Different Git blob |
| [deploy/cloudflare/worker-production-configuration.d.ts](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/worker-production-configuration.d.ts#L1) | Candidate only |
| [deploy/cloudflare/wrangler.jsonc](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/wrangler.jsonc#L1) | Different Git blob |
| [deploy/cloudflare/wrangler.production.jsonc](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/wrangler.production.jsonc#L1) | Candidate only |
| [deploy/postgres/README.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/postgres/README.md#L1) | Different Git blob |
| [deploy/supabase/stage-auth-code.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/supabase/stage-auth-code.html#L1) | Candidate only |
| [deploy/supabase/stage-auth-invitation.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/supabase/stage-auth-invitation.html#L1) | Candidate only |
| [docs/DECISIONS.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/DECISIONS.md#L1) | Different Git blob |
| [docs/DEPLOYMENT.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/DEPLOYMENT.md#L1) | Different Git blob |
| [docs/OPERATIONS.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/OPERATIONS.md#L1) | Different Git blob |
| [docs/PERFORMANCE_ANALYSIS_2026-10-17.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/PERFORMANCE_ANALYSIS_2026-10-17.md#L1) | Candidate only |
| [docs/PERFORMANCE_IMPROVEMENTS_2026-10-17.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/PERFORMANCE_IMPROVEMENTS_2026-10-17.md#L1) | Candidate only |
| [docs/PHASE2_CLOSEOUT.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/PHASE2_CLOSEOUT.md#L1) | Candidate only |
| [docs/PROJECT_BRIEF.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/PROJECT_BRIEF.md#L1) | Different Git blob |
| [docs/STATUS.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L1) | Different Git blob |
| [docs/design/DESIGN_SPEC.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/design/DESIGN_SPEC.md#L1) | Different Git blob |
| [docs/design/EXPANSION_DISCOVERY.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/design/EXPANSION_DISCOVERY.md#L1) | Different Git blob |
| [docs/email/assets/timeker-wordmark.png](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/email/assets/timeker-wordmark.png) | Candidate only |
| [docs/email/invitation-preview.html](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/email/invitation-preview.html#L1) | Candidate only |
| [docs/legal/LANDING_COPY.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/legal/LANDING_COPY.md#L1) | Different Git blob |
| [docs/legal/PRIVACY_DISCOVERY.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/legal/PRIVACY_DISCOVERY.md#L1) | Different Git blob |
| [integrations/README.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/integrations/README.md#L1) | Candidate only |
| [integrations/timeker-stage/assets/logo.svg](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/integrations/timeker-stage/assets/logo.svg#L1) | Candidate only |
| [integrations/timeker-stage/mcp.json](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/integrations/timeker-stage/mcp.json#L1) | Candidate only |
| [integrations/timeker-stage/plugin.json](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/integrations/timeker-stage/plugin.json#L1) | Candidate only |
| [integrations/timeker-stage/skills/timeker/SKILL.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/integrations/timeker-stage/skills/timeker/SKILL.md#L1) | Candidate only |
| [scripts/postgres-runtime-grants.sql](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/scripts/postgres-runtime-grants.sql#L1) | Different Git blob |
| [scripts/render_invitation.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/scripts/render_invitation.py#L1) | Candidate only |
| [tests/conftest.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/conftest.py#L1) | Different Git blob |
| [tests/e2e/conftest.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/conftest.py#L1) | Different Git blob |
| [tests/e2e/test_archive_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_archive_browser.py#L1) | Different Git blob |
| [tests/e2e/test_case_mass_edit_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_case_mass_edit_browser.py#L1) | Candidate only |
| [tests/e2e/test_credit_memos_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_credit_memos_browser.py#L1) | Candidate only |
| [tests/e2e/test_dashboard_detail_pagination_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_dashboard_detail_pagination_browser.py#L1) | Candidate only |
| [tests/e2e/test_dashboard_outstanding_pagination_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_dashboard_outstanding_pagination_browser.py#L1) | Candidate only |
| [tests/e2e/test_delegated_oauth_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_delegated_oauth_browser.py#L1) | Candidate only |
| [tests/e2e/test_ker_navigation_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_ker_navigation_browser.py#L1) | Candidate only |
| [tests/e2e/test_live_checkout_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_live_checkout_browser.py#L1) | Candidate only |
| [tests/e2e/test_oauth_csp_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_oauth_csp_browser.py#L1) | Different Git blob |
| [tests/e2e/test_onboarding_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_onboarding_browser.py#L1) | Candidate only |
| [tests/e2e/test_owner_work_refinements_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_owner_work_refinements_browser.py#L1) | Candidate only |
| [tests/e2e/test_paddle_overlay_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_paddle_overlay_browser.py#L1) | Candidate only |
| [tests/e2e/test_prelaunch_checkout_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_prelaunch_checkout_browser.py#L1) | Candidate only |
| [tests/e2e/test_projects_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_projects_browser.py#L1) | Different Git blob |
| [tests/e2e/test_proposal_sending_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_proposal_sending_browser.py#L1) | Candidate only |
| [tests/e2e/test_quoting_library_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_quoting_library_browser.py#L1) | Candidate only |
| [tests/e2e/test_quoting_lookup_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_quoting_lookup_browser.py#L1) | Candidate only |
| [tests/e2e/test_record_pagination_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_record_pagination_browser.py#L1) | Candidate only |
| [tests/e2e/test_reference_fields_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_reference_fields_browser.py#L1) | Candidate only |
| [tests/e2e/test_sending_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_sending_browser.py#L1) | Candidate only |
| [tests/e2e/test_sending_manual_followup_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_sending_manual_followup_browser.py#L1) | Candidate only |
| [tests/e2e/test_settings_cache_refresh_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_settings_cache_refresh_browser.py#L1) | Candidate only |
| [tests/e2e/test_shared_auth_challenge.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_shared_auth_challenge.py#L1) | Candidate only |
| [tests/e2e/test_stage_refinements.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_stage_refinements.py#L1) | Candidate only |
| [tests/e2e/test_subscription_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_subscription_browser.py#L1) | Candidate only |
| [tests/e2e/test_time_import_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_time_import_browser.py#L1) | Candidate only |
| [tests/e2e/test_timecard_local_clock.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_timecard_local_clock.py#L1) | Different Git blob |
| [tests/e2e/test_timecard_productivity_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_timecard_productivity_browser.py#L1) | Candidate only |
| [tests/e2e/test_timecard_selection.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_timecard_selection.py#L1) | Different Git blob |
| [tests/e2e/test_timecard_week_metrics_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_timecard_week_metrics_browser.py#L1) | Candidate only |
| [tests/e2e/test_ui_refresh_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_ui_refresh_browser.py#L1) | Different Git blob |
| [tests/e2e/test_work_management.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_work_management.py#L1) | Different Git blob |
| [tests/e2e/test_workflow_feedback_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_workflow_feedback_browser.py#L1) | Different Git blob |
| [tests/e2e/test_workspace_search_browser.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/e2e/test_workspace_search_browser.py#L1) | Candidate only |
| [tests/integration/test_archiving.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_archiving.py#L1) | Different Git blob |
| [tests/integration/test_auth_get_sessions.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_auth_get_sessions.py#L1) | Candidate only |
| [tests/integration/test_auth_notice.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_auth_notice.py#L1) | Candidate only |
| [tests/integration/test_case_lists.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_case_lists.py#L1) | Different Git blob |
| [tests/integration/test_case_mass_edit.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_case_mass_edit.py#L1) | Candidate only |
| [tests/integration/test_case_retention.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_case_retention.py#L1) | Candidate only |
| [tests/integration/test_case_workflow.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_case_workflow.py#L1) | Different Git blob |
| [tests/integration/test_cases.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_cases.py#L1) | Different Git blob |
| [tests/integration/test_cases_migration.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_cases_migration.py#L1) | Different Git blob |
| [tests/integration/test_client_codes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_client_codes.py#L1) | Candidate only |
| [tests/integration/test_credit_memos.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_credit_memos.py#L1) | Candidate only |
| [tests/integration/test_dashboard_contribution_scope.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_dashboard_contribution_scope.py#L1) | Candidate only |
| [tests/integration/test_dashboard_detail_pagination.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_dashboard_detail_pagination.py#L1) | Candidate only |
| [tests/integration/test_dashboard_outstanding_pagination.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_dashboard_outstanding_pagination.py#L1) | Candidate only |
| [tests/integration/test_dashboard_performance.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_dashboard_performance.py#L1) | Candidate only |
| [tests/integration/test_delegated_integration.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_delegated_integration.py#L1) | Candidate only |
| [tests/integration/test_email_start_retries.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_email_start_retries.py#L1) | Candidate only |
| [tests/integration/test_financial_query_growth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_financial_query_growth.py#L1) | Candidate only |
| [tests/integration/test_hardening.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_hardening.py#L1) | Different Git blob |
| [tests/integration/test_ker_navigation.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_ker_navigation.py#L1) | Candidate only |
| [tests/integration/test_library.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_library.py#L1) | Candidate only |
| [tests/integration/test_live_billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_live_billing.py#L1) | Candidate only |
| [tests/integration/test_lookups.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_lookups.py#L1) | Different Git blob |
| [tests/integration/test_mail.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_mail.py#L1) | Different Git blob |
| [tests/integration/test_migrations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_migrations.py#L1) | Different Git blob |
| [tests/integration/test_onboarding_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_onboarding_auth.py#L1) | Candidate only |
| [tests/integration/test_owner_work_refinements.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_owner_work_refinements.py#L1) | Candidate only |
| [tests/integration/test_prelaunch_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_prelaunch_auth.py#L1) | Candidate only |
| [tests/integration/test_project_attachments.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_project_attachments.py#L1) | Different Git blob |
| [tests/integration/test_project_attachments_migration.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_project_attachments_migration.py#L1) | Different Git blob |
| [tests/integration/test_project_lifecycle_work.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_project_lifecycle_work.py#L1) | Different Git blob |
| [tests/integration/test_projects.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_projects.py#L1) | Different Git blob |
| [tests/integration/test_proposal_sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_proposal_sending.py#L1) | Candidate only |
| [tests/integration/test_public_admission.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_public_admission.py#L1) | Candidate only |
| [tests/integration/test_quoting.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_quoting.py#L1) | Candidate only |
| [tests/integration/test_quoting_list_performance.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_quoting_list_performance.py#L1) | Candidate only |
| [tests/integration/test_quoting_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_quoting_routes.py#L1) | Candidate only |
| [tests/integration/test_record_fields.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_record_fields.py#L1) | Candidate only |
| [tests/integration/test_record_pagination.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_record_pagination.py#L1) | Candidate only |
| [tests/integration/test_recovery_rehearsal.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_recovery_rehearsal.py#L1) | Candidate only |
| [tests/integration/test_reference_fields.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_reference_fields.py#L1) | Candidate only |
| [tests/integration/test_report_pagination.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_report_pagination.py#L1) | Candidate only |
| [tests/integration/test_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_routes.py#L1) | Different Git blob |
| [tests/integration/test_save_feedback.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_save_feedback.py#L1) | Different Git blob |
| [tests/integration/test_sending_dispatch.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_sending_dispatch.py#L1) | Candidate only |
| [tests/integration/test_sending_isolation.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_sending_isolation.py#L1) | Candidate only |
| [tests/integration/test_sending_manual_followup.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_sending_manual_followup.py#L1) | Candidate only |
| [tests/integration/test_sending_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_sending_routes.py#L1) | Candidate only |
| [tests/integration/test_settings_cache_refresh.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_settings_cache_refresh.py#L1) | Candidate only |
| [tests/integration/test_social_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_social_auth.py#L1) | Candidate only |
| [tests/integration/test_static_asset_cache.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_static_asset_cache.py#L1) | Candidate only |
| [tests/integration/test_subscription_billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_subscription_billing.py#L1) | Candidate only |
| [tests/integration/test_subscription_capacity.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_subscription_capacity.py#L1) | Candidate only |
| [tests/integration/test_subscription_domain.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_subscription_domain.py#L1) | Candidate only |
| [tests/integration/test_subscription_http.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_subscription_http.py#L1) | Candidate only |
| [tests/integration/test_subscription_payments_http.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_subscription_payments_http.py#L1) | Candidate only |
| [tests/integration/test_subscription_retention.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_subscription_retention.py#L1) | Candidate only |
| [tests/integration/test_tenancy.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_tenancy.py#L1) | Different Git blob |
| [tests/integration/test_tenancy_capacity.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_tenancy_capacity.py#L1) | Candidate only |
| [tests/integration/test_tenant_demo.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_tenant_demo.py#L1) | Different Git blob |
| [tests/integration/test_time_commands.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_time_commands.py#L1) | Candidate only |
| [tests/integration/test_time_import_http.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_time_import_http.py#L1) | Candidate only |
| [tests/integration/test_timecard_cross_module.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_timecard_cross_module.py#L1) | Candidate only |
| [tests/integration/test_timecard_productivity.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_timecard_productivity.py#L1) | Candidate only |
| [tests/integration/test_timecard_week_metrics.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_timecard_week_metrics.py#L1) | Candidate only |
| [tests/integration/test_usage_browser_flow.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_usage_browser_flow.py#L1) | Different Git blob |
| [tests/integration/test_workspace_operations.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_workspace_operations.py#L1) | Candidate only |
| [tests/integration/test_workspace_overview_search.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/integration/test_workspace_overview_search.py#L1) | Candidate only |
| [tests/migration_target.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/migration_target.py#L1) | Candidate only |
| [tests/template_assets.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/template_assets.py#L1) | Candidate only |
| [tests/test_project_billing.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/test_project_billing.py#L1) | Different Git blob |
| [tests/test_project_billing_reports.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/test_project_billing_reports.py#L1) | Different Git blob |
| [tests/test_record_references.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/test_record_references.py#L1) | Candidate only |
| [tests/test_sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/test_sending.py#L1) | Candidate only |
| [tests/test_tenancy_config.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/test_tenancy_config.py#L1) | Different Git blob |
| [tests/timecard_history.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/timecard_history.py#L1) | Candidate only |
| [tests/unit/__init__.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/__init__.py#L1) | Candidate only |
| [tests/unit/test_client_code_validation.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_client_code_validation.py#L1) | Candidate only |
| [tests/unit/test_dashboard_calendar.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_dashboard_calendar.py#L1) | Candidate only |
| [tests/unit/test_email_auth.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_email_auth.py#L1) | Candidate only |
| [tests/unit/test_financial_values.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_financial_values.py#L1) | Candidate only |
| [tests/unit/test_flexfields.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_flexfields.py#L1) | Candidate only |
| [tests/unit/test_integration_contracts.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_integration_contracts.py#L1) | Candidate only |
| [tests/unit/test_invitation_template.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_invitation_template.py#L1) | Candidate only |
| [tests/unit/test_ker_navigation.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_ker_navigation.py#L1) | Candidate only |
| [tests/unit/test_library.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_library.py#L1) | Candidate only |
| [tests/unit/test_live_templates.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_live_templates.py#L1) | Candidate only |
| [tests/unit/test_logging.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_logging.py#L1) | Different Git blob |
| [tests/unit/test_migration_target.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_migration_target.py#L1) | Candidate only |
| [tests/unit/test_onboarding_templates.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_onboarding_templates.py#L1) | Candidate only |
| [tests/unit/test_paddle.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_paddle.py#L1) | Candidate only |
| [tests/unit/test_paddle_templates.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_paddle_templates.py#L1) | Candidate only |
| [tests/unit/test_pagination.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_pagination.py#L1) | Candidate only |
| [tests/unit/test_prelaunch_capabilities.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_prelaunch_capabilities.py#L1) | Candidate only |
| [tests/unit/test_production_capabilities.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_production_capabilities.py#L1) | Candidate only |
| [tests/unit/test_proposal_sending.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_proposal_sending.py#L1) | Candidate only |
| [tests/unit/test_proposal_sending_transport.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_proposal_sending_transport.py#L1) | Candidate only |
| [tests/unit/test_public_admission_proof.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_public_admission_proof.py#L1) | Candidate only |
| [tests/unit/test_quote_pagination.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_quote_pagination.py#L1) | Candidate only |
| [tests/unit/test_quoting.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_quoting.py#L1) | Candidate only |
| [tests/unit/test_quoting_routes.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_quoting_routes.py#L1) | Candidate only |
| [tests/unit/test_readiness_worker.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_readiness_worker.py#L1) | Candidate only |
| [tests/unit/test_reference_choices.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_reference_choices.py#L1) | Candidate only |
| [tests/unit/test_retention.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_retention.py#L1) | Candidate only |
| [tests/unit/test_sending_templates.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_sending_templates.py#L1) | Candidate only |
| [tests/unit/test_sending_transport.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_sending_transport.py#L1) | Candidate only |
| [tests/unit/test_settings_cache_refresh.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_settings_cache_refresh.py#L1) | Candidate only |
| [tests/unit/test_social_auth_proof.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_social_auth_proof.py#L1) | Candidate only |
| [tests/unit/test_static_assets.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_static_assets.py#L1) | Candidate only |
| [tests/unit/test_status_palette.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_status_palette.py#L1) | Candidate only |
| [tests/unit/test_subscription_templates.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_subscription_templates.py#L1) | Candidate only |
| [tests/unit/test_subscriptions.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_subscriptions.py#L1) | Candidate only |
| [tests/unit/test_templates.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_templates.py#L1) | Different Git blob |
| [tests/unit/test_time_import.py](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/tests/unit/test_time_import.py#L1) | Candidate only |

<!-- timeker-final-release-evidence -->
## Verified private production release

The bounded private PH2 production prelaunch is technically verified under D076. The deployed runtime is `5b0fb0d29f506d04e4a6af3ebd8a193089af7214`, with both retained production schemas at `ph3_009_read_indexes`. Paddle remains Sandbox; generic/public/email-public/Stage onboarding, Live and Sending jobs remain false. Existing inbound Mail capture remains enabled. Personal fresh Google proof, explicit acknowledgment, owner catalog verification/plan choice and human UAT remain pending. PH3 feature prompts still follow; no future feature prompt has been implemented.

| Technical observation | Verified release fact |
| --- | --- |
| Runtime source | `5b0fb0d29f506d04e4a6af3ebd8a193089af7214` |
| Worker version | `d7618b2e-0ff5-410c-b6db-63482e3ca355` |
| Deployment | `c20208fa-4510-45da-a3ad-f7204fa22645` |
| Container configuration / running versions | `13` / `[13]` |
| Container image digest | `sha256:9323ae9e842b70695b56f83c579dc939d91f8f210b8a39ba31bbaf79aa38b464` |
| Retained production schemas | Both `ph3_009_read_indexes`; no Stage data or identity copy |
| Preservation | All 40 old business-table projections preserved; issued artifact/history/role custody retained |
| Runtime restoration | Original LOGIN attributes restored; TLS verification and four actual reciprocal 42501 denials; no postLOGIN projection drift |
| Production HTTP | `/health/live` 200/status `ok`; `/health/ready` 200/status `ready`; private preview and invitation-only pages; 13 exact raw-source static assets |
| Unsigned webhook | Empty unsigned JSON rejected with HTTP400 and `event_rejected`; no verified billing event applied |
| Stage observation | Two read-only health GETs returned 200; this production rollout did not redeploy Stage |
| Activation | Sandbox/private prelaunch only; generic/public/email-public/Stage onboarding, Live, outbound Sending/jobs remain disabled; existing inbound Mail capture retained |
| Personal actions | Fresh Google/explicit acknowledgment, owner Verify catalog/plan choice and UAT pending |

The exact frozen encrypted backup `95db86b295a7c21c1ac0f64adc70a94d25cc1e7329a92b4f57c35ac14a4cb678` was restored and migrated only in an owned local rehearsal in 8.985 seconds; the local cluster was stopped. This is exact-ciphertext local recovery evidence, without a hosted restore or accepted hosted RPO/RTO claim.

Release verification retains the earlier 2,229 backend-case / 304 browser-case aggregate only at its original source and scope. The final five-template subscription correction freshly reran 429 backend cases including 49 added unit cases, and 13 browser cases including three added browser cases. These are overlapping blocks, not extra counts to sum into the earlier aggregate. The other 239 of 244 packaged runtime files were byte-identical to the prior candidate; 239 describes files, not browser tests. The full earlier backend/browser matrix was not freshly rerun for the final documentation pin. Dossier generation runs no product tests.

GitGuardian remains failed for the known historical transport test fixture: its password is fake, but the fixture references an actual Stage project rather than a placeholder. The signal is retained and is not reported as a passing check. Supabase Preview is SKIPPED because this branch lacks a Supabase Branch association; this does not replace the separately verified production database/readiness evidence.

These are retained release observations at `2026-10-18T16:39:19.019735+00:00`, not continuous monitoring. The final source checkpoint may add release documentation to the deployed runtime; each pin is labeled separately. Canonical authority: [HOSTING.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L1), [docs/STATUS.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/docs/STATUS.md#L1), [CONTINUE.md](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/CONTINUE.md#L1).
<!-- /timeker-final-release-evidence -->

<!-- timeker-final-repository-promotion -->
## Permanent repositories and completed promotion

Both permanent GitHub `main` branches now resolve to `4bb5c424d6e7d270cdca1479283896be77d581c3`, tree `e0dd4c64d603b3e8c551342395b9683389821f25`. The annotated baseline tag `ph2-prelaunch-2026-10-18` peels to the same checkpoint on both repositories. Promotion evidence: [PROD PR](https://github.com/edlopezpm-ops/timeKER-PROD/pull/3) (merged `2026-10-18T16:49:42Z`), [Stage PR](https://github.com/edlopezpm-ops/timeKER-Stage/pull/5) (merged `2026-10-18T16:49:56Z`). The active Stage work branch is `codex/ph3-stage`. Old Stage PRs2/3 are closed with their branches retained; no Stage PR remains open at the recorded handoff. Frozen PH2 remains `39bcde0e99e8993d4de861a9c0c1da56a9e8e9a6`.

The final documentary checkpoint keeps all244 raw runtime-file hashes identical to the tested/deployed runtime `5b0fb0d29f506d04e4a6af3ebd8a193089af7214`. Shared Git lineage does not merge production and Stage databases, provider configuration or identity custody. The permanent repositories remain [timeKER-Stage](https://github.com/edlopezpm-ops/timeKER-Stage) and [timeKER-PROD](https://github.com/edlopezpm-ops/timeKER-PROD); future feature prompts continue on Stage.
<!-- /timeker-final-repository-promotion -->
