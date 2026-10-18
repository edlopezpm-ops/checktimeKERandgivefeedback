# Internal triggers and other database objects

Candidate source `4bb5c424d6e7d270cdca1479283896be77d581c3`; migration head `ph3_009_read_indexes`. Structural reference inherited from the original 2026-10-18 empty PostgreSQL18.4 reconstruction at `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` after 26 migrations. Exactly 45 structural input blobs are unchanged at the candidate. No database connection, migration or DDL replay was rerun in this refresh. `timeker_reference` is synthetic, not a hosted schema name; no business rows or hosted catalog are included.


## Sequences

8 generated sequences back identity/serial columns. No current/last sequence
values were read or exported. These are structural start/bounds/increment settings.

| Sequence | Type | Owned column | Start | Min | Max | Increment | Cache | Cycle |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `cases_number_seq` | `bigint` | `cases.number` | 10001 | 1 | 9223372036854775807 | 1 | 1 | False |
| `clients_object_id_seq` | `bigint` | `clients.object_id` | 1 | 1 | 9223372036854775807 | 1 | 1 | False |
| `invoices_object_id_seq` | `bigint` | `invoices.object_id` | 1 | 1 | 9223372036854775807 | 1 | 1 | False |
| `library_documents_object_id_seq` | `bigint` | `library_documents.object_id` | 1 | 1 | 9223372036854775807 | 1 | 1 | False |
| `projects_object_id_seq` | `bigint` | `projects.object_id` | 1 | 1 | 9223372036854775807 | 1 | 1 | False |
| `quotes_number_seq` | `bigint` | `quotes.number` | 1 | 1 | 9223372036854775807 | 1 | 1 | False |
| `subscription_billing_accounts_id_seq` | `integer` | `subscription_billing_accounts.id` | 1 | 1 | 2147483647 | 1 | 1 | False |
| `timecards_object_id_seq` | `bigint` | `timecards.object_id` | 1 | 1 | 9223372036854775807 | 1 | 1 | False |

## Views, types, RLS and extensions

No views, materialized views, custom enums/domains/ranges, partitioned tables or
RLS policies were produced by the migrations. No table has RLS enabled. Tenant
isolation uses fixed schema/runtime-role boundaries and grants; this count is not
evidence of missing or present hosted provider policies. PostgreSQL row composite
types and automatic array types are implicit, not custom enum/domain declarations.

The fresh PostgreSQL cluster has built-in `plpgsql` extension 1.0 in `pg_catalog`.
No application migration creates an extension. Installed hosted extensions and
provider-owned schemas, tables, views and routines are outside this extraction.

## All internal FK triggers

360 internal triggers =4 PostgreSQL referential-integrity triggers per 90 foreign
keys in this PG18 build. Their generated names/OIDs are installation-specific.
They call built-in `pg_catalog` RI functions, whose implementation is PostgreSQL
itself. Recreate them through the FK constraints, never by manually replaying
these internal trigger definitions. The catalog JSON retains their definitions
and constraint bindings; the schema-only SQL correctly emits FKs instead.

| Table | Generated trigger | Built-in function | FK constraint | Enabled | Deferrable / initially deferred |
| --- | --- | --- | --- | --- | --- |
| `audit_events` | `RI_ConstraintTrigger_c_16469` | `pg_catalog.RI_FKey_check_ins` | `audit_events_actor_id_fkey` | O | False / False |
| `audit_events` | `RI_ConstraintTrigger_c_16470` | `pg_catalog.RI_FKey_check_upd` | `audit_events_actor_id_fkey` | O | False / False |
| `case_time_allocations` | `RI_ConstraintTrigger_c_16804` | `pg_catalog.RI_FKey_check_ins` | `case_time_allocations_entry_id_fkey` | O | False / False |
| `case_time_allocations` | `RI_ConstraintTrigger_c_16805` | `pg_catalog.RI_FKey_check_upd` | `case_time_allocations_entry_id_fkey` | O | False / False |
| `case_time_allocations` | `RI_ConstraintTrigger_c_16809` | `pg_catalog.RI_FKey_check_ins` | `case_time_allocations_case_id_fkey` | O | False / False |
| `case_time_allocations` | `RI_ConstraintTrigger_c_16810` | `pg_catalog.RI_FKey_check_upd` | `case_time_allocations_case_id_fkey` | O | False / False |
| `case_time_allocations` | `RI_ConstraintTrigger_c_16814` | `pg_catalog.RI_FKey_check_ins` | `case_time_allocations_actor_id_fkey` | O | False / False |
| `case_time_allocations` | `RI_ConstraintTrigger_c_16815` | `pg_catalog.RI_FKey_check_upd` | `case_time_allocations_actor_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_16807` | `pg_catalog.RI_FKey_noaction_del` | `case_time_allocations_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_16808` | `pg_catalog.RI_FKey_noaction_upd` | `case_time_allocations_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_16841` | `pg_catalog.RI_FKey_noaction_del` | `mail_addresses_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_16842` | `pg_catalog.RI_FKey_noaction_upd` | `mail_addresses_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_16892` | `pg_catalog.RI_FKey_noaction_del` | `mail_messages_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_16893` | `pg_catalog.RI_FKey_noaction_upd` | `mail_messages_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_17158` | `pg_catalog.RI_FKey_noaction_del` | `time_contributions_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_17159` | `pg_catalog.RI_FKey_noaction_upd` | `time_contributions_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_17803` | `pg_catalog.RI_FKey_noaction_del` | `quote_revisions_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_17804` | `pg_catalog.RI_FKey_noaction_upd` | `quote_revisions_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_17914` | `pg_catalog.RI_FKey_noaction_del` | `library_documents_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_17915` | `pg_catalog.RI_FKey_noaction_upd` | `library_documents_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_18046` | `pg_catalog.RI_FKey_noaction_del` | `proposal_sending_deliveries_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_18047` | `pg_catalog.RI_FKey_noaction_upd` | `proposal_sending_deliveries_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_18198` | `pg_catalog.RI_FKey_noaction_del` | `timecards_internal_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_a_18199` | `pg_catalog.RI_FKey_noaction_upd` | `timecards_internal_case_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_c_16768` | `pg_catalog.RI_FKey_check_ins` | `cases_client_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_c_16769` | `pg_catalog.RI_FKey_check_upd` | `cases_client_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_c_16773` | `pg_catalog.RI_FKey_check_ins` | `cases_project_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_c_16774` | `pg_catalog.RI_FKey_check_upd` | `cases_project_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_c_16778` | `pg_catalog.RI_FKey_check_ins` | `cases_owner_id_fkey` | O | False / False |
| `cases` | `RI_ConstraintTrigger_c_16779` | `pg_catalog.RI_FKey_check_upd` | `cases_owner_id_fkey` | O | False / False |
| `client_drafts` | `RI_ConstraintTrigger_c_17314` | `pg_catalog.RI_FKey_check_ins` | `client_drafts_owner_id_fkey` | O | False / False |
| `client_drafts` | `RI_ConstraintTrigger_c_17315` | `pg_catalog.RI_FKey_check_upd` | `client_drafts_owner_id_fkey` | O | False / False |
| `client_source_references` | `RI_ConstraintTrigger_c_18227` | `pg_catalog.RI_FKey_check_ins` | `client_source_references_client_id_fkey` | O | False / False |
| `client_source_references` | `RI_ConstraintTrigger_c_18228` | `pg_catalog.RI_FKey_check_upd` | `client_source_references_client_id_fkey` | O | False / False |
| `client_source_references` | `RI_ConstraintTrigger_c_18232` | `pg_catalog.RI_FKey_check_ins` | `client_source_references_uploaded_by_fkey` | O | False / False |
| `client_source_references` | `RI_ConstraintTrigger_c_18233` | `pg_catalog.RI_FKey_check_upd` | `client_source_references_uploaded_by_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16489` | `pg_catalog.RI_FKey_noaction_del` | `contacts_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16490` | `pg_catalog.RI_FKey_noaction_upd` | `contacts_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16521` | `pg_catalog.RI_FKey_noaction_del` | `invoices_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16522` | `pg_catalog.RI_FKey_noaction_upd` | `invoices_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16548` | `pg_catalog.RI_FKey_noaction_del` | `projects_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16549` | `pg_catalog.RI_FKey_noaction_upd` | `projects_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16575` | `pg_catalog.RI_FKey_noaction_del` | `timecards_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16576` | `pg_catalog.RI_FKey_noaction_upd` | `timecards_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16766` | `pg_catalog.RI_FKey_noaction_del` | `cases_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16767` | `pg_catalog.RI_FKey_noaction_upd` | `cases_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16846` | `pg_catalog.RI_FKey_noaction_del` | `mail_addresses_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16847` | `pg_catalog.RI_FKey_noaction_upd` | `mail_addresses_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16897` | `pg_catalog.RI_FKey_noaction_del` | `mail_messages_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_16898` | `pg_catalog.RI_FKey_noaction_upd` | `mail_messages_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_17808` | `pg_catalog.RI_FKey_noaction_del` | `quote_revisions_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_17809` | `pg_catalog.RI_FKey_noaction_upd` | `quote_revisions_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_17919` | `pg_catalog.RI_FKey_noaction_del` | `library_documents_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_17920` | `pg_catalog.RI_FKey_noaction_upd` | `library_documents_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_18225` | `pg_catalog.RI_FKey_noaction_del` | `client_source_references_client_id_fkey` | O | False / False |
| `clients` | `RI_ConstraintTrigger_a_18226` | `pg_catalog.RI_FKey_noaction_upd` | `client_source_references_client_id_fkey` | O | False / False |
| `contacts` | `RI_ConstraintTrigger_c_16491` | `pg_catalog.RI_FKey_check_ins` | `contacts_client_id_fkey` | O | False / False |
| `contacts` | `RI_ConstraintTrigger_c_16492` | `pg_catalog.RI_FKey_check_upd` | `contacts_client_id_fkey` | O | False / False |
| `credit_memos` | `RI_ConstraintTrigger_c_17071` | `pg_catalog.RI_FKey_check_ins` | `credit_memos_invoice_id_fkey` | O | False / False |
| `credit_memos` | `RI_ConstraintTrigger_c_17072` | `pg_catalog.RI_FKey_check_upd` | `credit_memos_invoice_id_fkey` | O | False / False |
| `credit_memos` | `RI_ConstraintTrigger_c_17076` | `pg_catalog.RI_FKey_check_ins` | `credit_memos_actor_id_fkey` | O | False / False |
| `credit_memos` | `RI_ConstraintTrigger_c_17077` | `pg_catalog.RI_FKey_check_upd` | `credit_memos_actor_id_fkey` | O | False / False |
| `email_auth_challenges` | `RI_ConstraintTrigger_c_17525` | `pg_catalog.RI_FKey_check_ins` | `email_auth_challenges_owner_id_fkey` | O | False / False |
| `email_auth_challenges` | `RI_ConstraintTrigger_c_17526` | `pg_catalog.RI_FKey_check_upd` | `email_auth_challenges_owner_id_fkey` | O | False / False |
| `integration_codes` | `RI_ConstraintTrigger_c_17246` | `pg_catalog.RI_FKey_check_ins` | `integration_codes_grant_id_fkey` | O | False / False |
| `integration_codes` | `RI_ConstraintTrigger_c_17247` | `pg_catalog.RI_FKey_check_upd` | `integration_codes_grant_id_fkey` | O | False / False |
| `integration_grants` | `RI_ConstraintTrigger_a_17244` | `pg_catalog.RI_FKey_noaction_del` | `integration_codes_grant_id_fkey` | O | False / False |
| `integration_grants` | `RI_ConstraintTrigger_a_17245` | `pg_catalog.RI_FKey_noaction_upd` | `integration_codes_grant_id_fkey` | O | False / False |
| `integration_grants` | `RI_ConstraintTrigger_a_17269` | `pg_catalog.RI_FKey_noaction_del` | `integration_tokens_grant_id_fkey` | O | False / False |
| `integration_grants` | `RI_ConstraintTrigger_a_17270` | `pg_catalog.RI_FKey_noaction_upd` | `integration_tokens_grant_id_fkey` | O | False / False |
| `integration_grants` | `RI_ConstraintTrigger_a_17293` | `pg_catalog.RI_FKey_noaction_del` | `integration_operations_grant_id_fkey` | O | False / False |
| `integration_grants` | `RI_ConstraintTrigger_a_17294` | `pg_catalog.RI_FKey_noaction_upd` | `integration_operations_grant_id_fkey` | O | False / False |
| `integration_grants` | `RI_ConstraintTrigger_c_17221` | `pg_catalog.RI_FKey_check_ins` | `integration_grants_owner_id_fkey` | O | False / False |
| `integration_grants` | `RI_ConstraintTrigger_c_17222` | `pg_catalog.RI_FKey_check_upd` | `integration_grants_owner_id_fkey` | O | False / False |
| `integration_operations` | `RI_ConstraintTrigger_c_17295` | `pg_catalog.RI_FKey_check_ins` | `integration_operations_grant_id_fkey` | O | False / False |
| `integration_operations` | `RI_ConstraintTrigger_c_17296` | `pg_catalog.RI_FKey_check_upd` | `integration_operations_grant_id_fkey` | O | False / False |
| `integration_tokens` | `RI_ConstraintTrigger_c_17271` | `pg_catalog.RI_FKey_check_ins` | `integration_tokens_grant_id_fkey` | O | False / False |
| `integration_tokens` | `RI_ConstraintTrigger_c_17272` | `pg_catalog.RI_FKey_check_upd` | `integration_tokens_grant_id_fkey` | O | False / False |
| `invoice_artifacts` | `RI_ConstraintTrigger_a_17591` | `pg_catalog.RI_FKey_noaction_del` | `sending_plans_artifact_id_fkey` | O | False / False |
| `invoice_artifacts` | `RI_ConstraintTrigger_a_17592` | `pg_catalog.RI_FKey_noaction_upd` | `sending_plans_artifact_id_fkey` | O | False / False |
| `invoice_artifacts` | `RI_ConstraintTrigger_c_16607` | `pg_catalog.RI_FKey_check_ins` | `invoice_artifacts_invoice_id_fkey` | O | False / False |
| `invoice_artifacts` | `RI_ConstraintTrigger_c_16608` | `pg_catalog.RI_FKey_check_upd` | `invoice_artifacts_invoice_id_fkey` | O | False / False |
| `invoice_lines` | `RI_ConstraintTrigger_c_16629` | `pg_catalog.RI_FKey_check_ins` | `invoice_lines_invoice_id_fkey` | O | False / False |
| `invoice_lines` | `RI_ConstraintTrigger_c_16630` | `pg_catalog.RI_FKey_check_upd` | `invoice_lines_invoice_id_fkey` | O | False / False |
| `invoice_lines` | `RI_ConstraintTrigger_c_16634` | `pg_catalog.RI_FKey_check_ins` | `invoice_lines_project_id_fkey` | O | False / False |
| `invoice_lines` | `RI_ConstraintTrigger_c_16635` | `pg_catalog.RI_FKey_check_upd` | `invoice_lines_project_id_fkey` | O | False / False |
| `invoice_time_entries` | `RI_ConstraintTrigger_c_16706` | `pg_catalog.RI_FKey_check_ins` | `invoice_time_entries_entry_id_fkey` | O | False / False |
| `invoice_time_entries` | `RI_ConstraintTrigger_c_16707` | `pg_catalog.RI_FKey_check_upd` | `invoice_time_entries_entry_id_fkey` | O | False / False |
| `invoice_time_entries` | `RI_ConstraintTrigger_c_16711` | `pg_catalog.RI_FKey_check_ins` | `invoice_time_entries_invoice_id_fkey` | O | False / False |
| `invoice_time_entries` | `RI_ConstraintTrigger_c_16712` | `pg_catalog.RI_FKey_check_upd` | `invoice_time_entries_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_16605` | `pg_catalog.RI_FKey_noaction_del` | `invoice_artifacts_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_16606` | `pg_catalog.RI_FKey_noaction_upd` | `invoice_artifacts_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_16627` | `pg_catalog.RI_FKey_noaction_del` | `invoice_lines_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_16628` | `pg_catalog.RI_FKey_noaction_upd` | `invoice_lines_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_16660` | `pg_catalog.RI_FKey_noaction_del` | `payments_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_16661` | `pg_catalog.RI_FKey_noaction_upd` | `payments_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_16709` | `pg_catalog.RI_FKey_noaction_del` | `invoice_time_entries_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_16710` | `pg_catalog.RI_FKey_noaction_upd` | `invoice_time_entries_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_17069` | `pg_catalog.RI_FKey_noaction_del` | `credit_memos_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_17070` | `pg_catalog.RI_FKey_noaction_upd` | `credit_memos_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_17586` | `pg_catalog.RI_FKey_noaction_del` | `sending_plans_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_a_17587` | `pg_catalog.RI_FKey_noaction_upd` | `sending_plans_invoice_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_c_16523` | `pg_catalog.RI_FKey_check_ins` | `invoices_client_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_c_16524` | `pg_catalog.RI_FKey_check_upd` | `invoices_client_id_fkey` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_c_16932` | `pg_catalog.RI_FKey_check_ins` | `fk_invoices_fixed_fee_project_id` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_c_16933` | `pg_catalog.RI_FKey_check_upd` | `fk_invoices_fixed_fee_project_id` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_c_16937` | `pg_catalog.RI_FKey_check_ins` | `fk_invoices_manual_extra_project_id` | O | False / False |
| `invoices` | `RI_ConstraintTrigger_c_16938` | `pg_catalog.RI_FKey_check_upd` | `fk_invoices_manual_extra_project_id` | O | False / False |
| `library_document_versions` | `RI_ConstraintTrigger_a_18056` | `pg_catalog.RI_FKey_noaction_del` | `proposal_sending_deliveries_library_version_id_fkey` | O | False / False |
| `library_document_versions` | `RI_ConstraintTrigger_a_18057` | `pg_catalog.RI_FKey_noaction_upd` | `proposal_sending_deliveries_library_version_id_fkey` | O | False / False |
| `library_document_versions` | `RI_ConstraintTrigger_c_17991` | `pg_catalog.RI_FKey_check_ins` | `library_document_versions_document_id_fkey` | O | False / False |
| `library_document_versions` | `RI_ConstraintTrigger_c_17992` | `pg_catalog.RI_FKey_check_upd` | `library_document_versions_document_id_fkey` | O | False / False |
| `library_document_versions` | `RI_ConstraintTrigger_c_17996` | `pg_catalog.RI_FKey_check_ins` | `library_document_versions_owner_id_fkey` | O | False / False |
| `library_document_versions` | `RI_ConstraintTrigger_c_17997` | `pg_catalog.RI_FKey_check_upd` | `library_document_versions_owner_id_fkey` | O | False / False |
| `library_document_versions` | `RI_ConstraintTrigger_c_18001` | `pg_catalog.RI_FKey_check_ins` | `library_document_versions_source_upload_id_fkey` | O | False / False |
| `library_document_versions` | `RI_ConstraintTrigger_c_18002` | `pg_catalog.RI_FKey_check_upd` | `library_document_versions_source_upload_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_a_17953` | `pg_catalog.RI_FKey_noaction_del` | `library_uploads_document_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_a_17954` | `pg_catalog.RI_FKey_noaction_upd` | `library_uploads_document_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_a_17989` | `pg_catalog.RI_FKey_noaction_del` | `library_document_versions_document_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_a_17990` | `pg_catalog.RI_FKey_noaction_upd` | `library_document_versions_document_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_c_17911` | `pg_catalog.RI_FKey_check_ins` | `library_documents_owner_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_c_17912` | `pg_catalog.RI_FKey_check_upd` | `library_documents_owner_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_c_17916` | `pg_catalog.RI_FKey_check_ins` | `library_documents_case_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_c_17917` | `pg_catalog.RI_FKey_check_upd` | `library_documents_case_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_c_17921` | `pg_catalog.RI_FKey_check_ins` | `library_documents_client_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_c_17922` | `pg_catalog.RI_FKey_check_upd` | `library_documents_client_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_c_17926` | `pg_catalog.RI_FKey_check_ins` | `library_documents_project_id_fkey` | O | False / False |
| `library_documents` | `RI_ConstraintTrigger_c_17927` | `pg_catalog.RI_FKey_check_upd` | `library_documents_project_id_fkey` | O | False / False |
| `library_uploads` | `RI_ConstraintTrigger_a_17999` | `pg_catalog.RI_FKey_noaction_del` | `library_document_versions_source_upload_id_fkey` | O | False / False |
| `library_uploads` | `RI_ConstraintTrigger_a_18000` | `pg_catalog.RI_FKey_noaction_upd` | `library_document_versions_source_upload_id_fkey` | O | False / False |
| `library_uploads` | `RI_ConstraintTrigger_c_17955` | `pg_catalog.RI_FKey_check_ins` | `library_uploads_document_id_fkey` | O | False / False |
| `library_uploads` | `RI_ConstraintTrigger_c_17956` | `pg_catalog.RI_FKey_check_upd` | `library_uploads_document_id_fkey` | O | False / False |
| `library_uploads` | `RI_ConstraintTrigger_c_17960` | `pg_catalog.RI_FKey_check_ins` | `library_uploads_uploaded_by_fkey` | O | False / False |
| `library_uploads` | `RI_ConstraintTrigger_c_17961` | `pg_catalog.RI_FKey_check_upd` | `library_uploads_uploaded_by_fkey` | O | False / False |
| `mail_addresses` | `RI_ConstraintTrigger_c_16843` | `pg_catalog.RI_FKey_check_ins` | `mail_addresses_case_id_fkey` | O | False / False |
| `mail_addresses` | `RI_ConstraintTrigger_c_16844` | `pg_catalog.RI_FKey_check_upd` | `mail_addresses_case_id_fkey` | O | False / False |
| `mail_addresses` | `RI_ConstraintTrigger_c_16848` | `pg_catalog.RI_FKey_check_ins` | `mail_addresses_client_id_fkey` | O | False / False |
| `mail_addresses` | `RI_ConstraintTrigger_c_16849` | `pg_catalog.RI_FKey_check_upd` | `mail_addresses_client_id_fkey` | O | False / False |
| `mail_addresses` | `RI_ConstraintTrigger_c_16853` | `pg_catalog.RI_FKey_check_ins` | `mail_addresses_owner_id_fkey` | O | False / False |
| `mail_addresses` | `RI_ConstraintTrigger_c_16854` | `pg_catalog.RI_FKey_check_upd` | `mail_addresses_owner_id_fkey` | O | False / False |
| `mail_addresses` | `RI_ConstraintTrigger_c_16858` | `pg_catalog.RI_FKey_check_ins` | `mail_addresses_project_id_fkey` | O | False / False |
| `mail_addresses` | `RI_ConstraintTrigger_c_16859` | `pg_catalog.RI_FKey_check_upd` | `mail_addresses_project_id_fkey` | O | False / False |
| `mail_attachments` | `RI_ConstraintTrigger_c_16999` | `pg_catalog.RI_FKey_check_ins` | `mail_attachments_message_id_fkey` | O | False / False |
| `mail_attachments` | `RI_ConstraintTrigger_c_17000` | `pg_catalog.RI_FKey_check_upd` | `mail_attachments_message_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_a_16997` | `pg_catalog.RI_FKey_noaction_del` | `mail_attachments_message_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_a_16998` | `pg_catalog.RI_FKey_noaction_upd` | `mail_attachments_message_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_c_16894` | `pg_catalog.RI_FKey_check_ins` | `mail_messages_case_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_c_16895` | `pg_catalog.RI_FKey_check_upd` | `mail_messages_case_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_c_16899` | `pg_catalog.RI_FKey_check_ins` | `mail_messages_client_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_c_16900` | `pg_catalog.RI_FKey_check_upd` | `mail_messages_client_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_c_16904` | `pg_catalog.RI_FKey_check_ins` | `mail_messages_owner_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_c_16905` | `pg_catalog.RI_FKey_check_upd` | `mail_messages_owner_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_c_16909` | `pg_catalog.RI_FKey_check_ins` | `mail_messages_project_id_fkey` | O | False / False |
| `mail_messages` | `RI_ConstraintTrigger_c_16910` | `pg_catalog.RI_FKey_check_upd` | `mail_messages_project_id_fkey` | O | False / False |
| `owner_identities` | `RI_ConstraintTrigger_c_17479` | `pg_catalog.RI_FKey_check_ins` | `owner_identities_owner_id_fkey` | O | False / False |
| `owner_identities` | `RI_ConstraintTrigger_c_17480` | `pg_catalog.RI_FKey_check_upd` | `owner_identities_owner_id_fkey` | O | False / False |
| `owner_registrations` | `RI_ConstraintTrigger_c_17501` | `pg_catalog.RI_FKey_check_ins` | `owner_registrations_owner_id_fkey` | O | False / False |
| `owner_registrations` | `RI_ConstraintTrigger_c_17502` | `pg_catalog.RI_FKey_check_upd` | `owner_registrations_owner_id_fkey` | O | False / False |
| `payments` | `RI_ConstraintTrigger_c_16657` | `pg_catalog.RI_FKey_check_ins` | `payments_created_by_fkey` | O | False / False |
| `payments` | `RI_ConstraintTrigger_c_16658` | `pg_catalog.RI_FKey_check_upd` | `payments_created_by_fkey` | O | False / False |
| `payments` | `RI_ConstraintTrigger_c_16662` | `pg_catalog.RI_FKey_check_ins` | `payments_invoice_id_fkey` | O | False / False |
| `payments` | `RI_ConstraintTrigger_c_16663` | `pg_catalog.RI_FKey_check_upd` | `payments_invoice_id_fkey` | O | False / False |
| `project_agreements` | `RI_ConstraintTrigger_c_17029` | `pg_catalog.RI_FKey_check_ins` | `project_agreements_project_id_fkey` | O | False / False |
| `project_agreements` | `RI_ConstraintTrigger_c_17030` | `pg_catalog.RI_FKey_check_upd` | `project_agreements_project_id_fkey` | O | False / False |
| `project_agreements` | `RI_ConstraintTrigger_c_17034` | `pg_catalog.RI_FKey_check_ins` | `project_agreements_uploaded_by_fkey` | O | False / False |
| `project_agreements` | `RI_ConstraintTrigger_c_17035` | `pg_catalog.RI_FKey_check_upd` | `project_agreements_uploaded_by_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16632` | `pg_catalog.RI_FKey_noaction_del` | `invoice_lines_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16633` | `pg_catalog.RI_FKey_noaction_upd` | `invoice_lines_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16685` | `pg_catalog.RI_FKey_noaction_del` | `time_entries_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16686` | `pg_catalog.RI_FKey_noaction_upd` | `time_entries_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16771` | `pg_catalog.RI_FKey_noaction_del` | `cases_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16772` | `pg_catalog.RI_FKey_noaction_upd` | `cases_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16856` | `pg_catalog.RI_FKey_noaction_del` | `mail_addresses_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16857` | `pg_catalog.RI_FKey_noaction_upd` | `mail_addresses_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16907` | `pg_catalog.RI_FKey_noaction_del` | `mail_messages_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16908` | `pg_catalog.RI_FKey_noaction_upd` | `mail_messages_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16930` | `pg_catalog.RI_FKey_noaction_del` | `fk_invoices_fixed_fee_project_id` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16931` | `pg_catalog.RI_FKey_noaction_upd` | `fk_invoices_fixed_fee_project_id` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16935` | `pg_catalog.RI_FKey_noaction_del` | `fk_invoices_manual_extra_project_id` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_16936` | `pg_catalog.RI_FKey_noaction_upd` | `fk_invoices_manual_extra_project_id` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_17027` | `pg_catalog.RI_FKey_noaction_del` | `project_agreements_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_17028` | `pg_catalog.RI_FKey_noaction_upd` | `project_agreements_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_17148` | `pg_catalog.RI_FKey_noaction_del` | `time_contributions_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_17149` | `pg_catalog.RI_FKey_noaction_upd` | `time_contributions_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_17813` | `pg_catalog.RI_FKey_noaction_del` | `quote_revisions_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_17814` | `pg_catalog.RI_FKey_noaction_upd` | `quote_revisions_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_17924` | `pg_catalog.RI_FKey_noaction_del` | `library_documents_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_a_17925` | `pg_catalog.RI_FKey_noaction_upd` | `library_documents_project_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_c_16550` | `pg_catalog.RI_FKey_check_ins` | `projects_client_id_fkey` | O | False / False |
| `projects` | `RI_ConstraintTrigger_c_16551` | `pg_catalog.RI_FKey_check_upd` | `projects_client_id_fkey` | O | False / False |
| `proposal_sending_attempts` | `RI_ConstraintTrigger_c_18082` | `pg_catalog.RI_FKey_check_ins` | `proposal_sending_attempts_delivery_id_fkey` | O | False / False |
| `proposal_sending_attempts` | `RI_ConstraintTrigger_c_18083` | `pg_catalog.RI_FKey_check_upd` | `proposal_sending_attempts_delivery_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_a_18080` | `pg_catalog.RI_FKey_noaction_del` | `proposal_sending_attempts_delivery_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_a_18081` | `pg_catalog.RI_FKey_noaction_upd` | `proposal_sending_attempts_delivery_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_c_18043` | `pg_catalog.RI_FKey_check_ins` | `proposal_sending_deliveries_owner_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_c_18044` | `pg_catalog.RI_FKey_check_upd` | `proposal_sending_deliveries_owner_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_c_18048` | `pg_catalog.RI_FKey_check_ins` | `proposal_sending_deliveries_case_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_c_18049` | `pg_catalog.RI_FKey_check_upd` | `proposal_sending_deliveries_case_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_c_18053` | `pg_catalog.RI_FKey_check_ins` | `proposal_sending_deliveries_quote_artifact_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_c_18054` | `pg_catalog.RI_FKey_check_upd` | `proposal_sending_deliveries_quote_artifact_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_c_18058` | `pg_catalog.RI_FKey_check_ins` | `proposal_sending_deliveries_library_version_id_fkey` | O | False / False |
| `proposal_sending_deliveries` | `RI_ConstraintTrigger_c_18059` | `pg_catalog.RI_FKey_check_upd` | `proposal_sending_deliveries_library_version_id_fkey` | O | False / False |
| `quote_artifacts` | `RI_ConstraintTrigger_a_18051` | `pg_catalog.RI_FKey_noaction_del` | `proposal_sending_deliveries_quote_artifact_id_fkey` | O | False / False |
| `quote_artifacts` | `RI_ConstraintTrigger_a_18052` | `pg_catalog.RI_FKey_noaction_upd` | `proposal_sending_deliveries_quote_artifact_id_fkey` | O | False / False |
| `quote_artifacts` | `RI_ConstraintTrigger_c_17877` | `pg_catalog.RI_FKey_check_ins` | `quote_artifacts_revision_id_fkey` | O | False / False |
| `quote_artifacts` | `RI_ConstraintTrigger_c_17878` | `pg_catalog.RI_FKey_check_upd` | `quote_artifacts_revision_id_fkey` | O | False / False |
| `quote_artifacts` | `RI_ConstraintTrigger_c_17882` | `pg_catalog.RI_FKey_check_ins` | `quote_artifacts_owner_id_fkey` | O | False / False |
| `quote_artifacts` | `RI_ConstraintTrigger_c_17883` | `pg_catalog.RI_FKey_check_upd` | `quote_artifacts_owner_id_fkey` | O | False / False |
| `quote_lines` | `RI_ConstraintTrigger_c_17847` | `pg_catalog.RI_FKey_check_ins` | `quote_lines_revision_id_fkey` | O | False / False |
| `quote_lines` | `RI_ConstraintTrigger_c_17848` | `pg_catalog.RI_FKey_check_upd` | `quote_lines_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_a_17798` | `pg_catalog.RI_FKey_noaction_del` | `quote_revisions_parent_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_a_17799` | `pg_catalog.RI_FKey_noaction_upd` | `quote_revisions_parent_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_a_17845` | `pg_catalog.RI_FKey_noaction_del` | `quote_lines_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_a_17846` | `pg_catalog.RI_FKey_noaction_upd` | `quote_lines_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_a_17875` | `pg_catalog.RI_FKey_noaction_del` | `quote_artifacts_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_a_17876` | `pg_catalog.RI_FKey_noaction_upd` | `quote_artifacts_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17795` | `pg_catalog.RI_FKey_check_ins` | `quote_revisions_quote_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17796` | `pg_catalog.RI_FKey_check_upd` | `quote_revisions_quote_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17800` | `pg_catalog.RI_FKey_check_ins` | `quote_revisions_parent_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17801` | `pg_catalog.RI_FKey_check_upd` | `quote_revisions_parent_revision_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17805` | `pg_catalog.RI_FKey_check_ins` | `quote_revisions_case_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17806` | `pg_catalog.RI_FKey_check_upd` | `quote_revisions_case_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17810` | `pg_catalog.RI_FKey_check_ins` | `quote_revisions_client_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17811` | `pg_catalog.RI_FKey_check_upd` | `quote_revisions_client_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17815` | `pg_catalog.RI_FKey_check_ins` | `quote_revisions_project_id_fkey` | O | False / False |
| `quote_revisions` | `RI_ConstraintTrigger_c_17816` | `pg_catalog.RI_FKey_check_upd` | `quote_revisions_project_id_fkey` | O | False / False |
| `quotes` | `RI_ConstraintTrigger_a_17793` | `pg_catalog.RI_FKey_noaction_del` | `quote_revisions_quote_id_fkey` | O | False / False |
| `quotes` | `RI_ConstraintTrigger_a_17794` | `pg_catalog.RI_FKey_noaction_upd` | `quote_revisions_quote_id_fkey` | O | False / False |
| `quotes` | `RI_ConstraintTrigger_c_17759` | `pg_catalog.RI_FKey_check_ins` | `quotes_owner_id_fkey` | O | False / False |
| `quotes` | `RI_ConstraintTrigger_c_17760` | `pg_catalog.RI_FKey_check_upd` | `quotes_owner_id_fkey` | O | False / False |
| `sending_attempts` | `RI_ConstraintTrigger_c_17647` | `pg_catalog.RI_FKey_check_ins` | `sending_attempts_delivery_id_fkey` | O | False / False |
| `sending_attempts` | `RI_ConstraintTrigger_c_17648` | `pg_catalog.RI_FKey_check_upd` | `sending_attempts_delivery_id_fkey` | O | False / False |
| `sending_deliveries` | `RI_ConstraintTrigger_a_17645` | `pg_catalog.RI_FKey_noaction_del` | `sending_attempts_delivery_id_fkey` | O | False / False |
| `sending_deliveries` | `RI_ConstraintTrigger_a_17646` | `pg_catalog.RI_FKey_noaction_upd` | `sending_attempts_delivery_id_fkey` | O | False / False |
| `sending_deliveries` | `RI_ConstraintTrigger_c_17617` | `pg_catalog.RI_FKey_check_ins` | `sending_deliveries_owner_id_fkey` | O | False / False |
| `sending_deliveries` | `RI_ConstraintTrigger_c_17618` | `pg_catalog.RI_FKey_check_upd` | `sending_deliveries_owner_id_fkey` | O | False / False |
| `sending_deliveries` | `RI_ConstraintTrigger_c_17622` | `pg_catalog.RI_FKey_check_ins` | `sending_deliveries_plan_id_fkey` | O | False / False |
| `sending_deliveries` | `RI_ConstraintTrigger_c_17623` | `pg_catalog.RI_FKey_check_upd` | `sending_deliveries_plan_id_fkey` | O | False / False |
| `sending_plans` | `RI_ConstraintTrigger_a_17620` | `pg_catalog.RI_FKey_noaction_del` | `sending_deliveries_plan_id_fkey` | O | False / False |
| `sending_plans` | `RI_ConstraintTrigger_a_17621` | `pg_catalog.RI_FKey_noaction_upd` | `sending_deliveries_plan_id_fkey` | O | False / False |
| `sending_plans` | `RI_ConstraintTrigger_c_17583` | `pg_catalog.RI_FKey_check_ins` | `sending_plans_owner_id_fkey` | O | False / False |
| `sending_plans` | `RI_ConstraintTrigger_c_17584` | `pg_catalog.RI_FKey_check_upd` | `sending_plans_owner_id_fkey` | O | False / False |
| `sending_plans` | `RI_ConstraintTrigger_c_17588` | `pg_catalog.RI_FKey_check_ins` | `sending_plans_invoice_id_fkey` | O | False / False |
| `sending_plans` | `RI_ConstraintTrigger_c_17589` | `pg_catalog.RI_FKey_check_upd` | `sending_plans_invoice_id_fkey` | O | False / False |
| `sending_plans` | `RI_ConstraintTrigger_c_17593` | `pg_catalog.RI_FKey_check_ins` | `sending_plans_artifact_id_fkey` | O | False / False |
| `sending_plans` | `RI_ConstraintTrigger_c_17594` | `pg_catalog.RI_FKey_check_upd` | `sending_plans_artifact_id_fkey` | O | False / False |
| `sending_preferences` | `RI_ConstraintTrigger_c_17552` | `pg_catalog.RI_FKey_check_ins` | `sending_preferences_owner_id_fkey` | O | False / False |
| `sending_preferences` | `RI_ConstraintTrigger_c_17553` | `pg_catalog.RI_FKey_check_upd` | `sending_preferences_owner_id_fkey` | O | False / False |
| `subscription_billing_accounts` | `RI_ConstraintTrigger_c_17426` | `pg_catalog.RI_FKey_check_ins` | `subscription_billing_accounts_owner_id_fkey` | O | False / False |
| `subscription_billing_accounts` | `RI_ConstraintTrigger_c_17427` | `pg_catalog.RI_FKey_check_upd` | `subscription_billing_accounts_owner_id_fkey` | O | False / False |
| `subscription_billing_accounts` | `RI_ConstraintTrigger_c_17431` | `pg_catalog.RI_FKey_check_ins` | `subscription_billing_accounts_checkout_id_fkey` | O | False / False |
| `subscription_billing_accounts` | `RI_ConstraintTrigger_c_17432` | `pg_catalog.RI_FKey_check_upd` | `subscription_billing_accounts_checkout_id_fkey` | O | False / False |
| `subscription_billing_operations` | `RI_ConstraintTrigger_a_17429` | `pg_catalog.RI_FKey_noaction_del` | `subscription_billing_accounts_checkout_id_fkey` | O | False / False |
| `subscription_billing_operations` | `RI_ConstraintTrigger_a_17430` | `pg_catalog.RI_FKey_noaction_upd` | `subscription_billing_accounts_checkout_id_fkey` | O | False / False |
| `subscription_billing_operations` | `RI_ConstraintTrigger_c_17391` | `pg_catalog.RI_FKey_check_ins` | `subscription_billing_operations_owner_id_fkey` | O | False / False |
| `subscription_billing_operations` | `RI_ConstraintTrigger_c_17392` | `pg_catalog.RI_FKey_check_upd` | `subscription_billing_operations_owner_id_fkey` | O | False / False |
| `subscription_operations` | `RI_ConstraintTrigger_c_17359` | `pg_catalog.RI_FKey_check_ins` | `subscription_operations_owner_id_fkey` | O | False / False |
| `subscription_operations` | `RI_ConstraintTrigger_c_17360` | `pg_catalog.RI_FKey_check_upd` | `subscription_operations_owner_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17135` | `pg_catalog.RI_FKey_check_ins` | `time_contributions_actor_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17136` | `pg_catalog.RI_FKey_check_upd` | `time_contributions_actor_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17140` | `pg_catalog.RI_FKey_check_ins` | `time_contributions_import_record_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17141` | `pg_catalog.RI_FKey_check_upd` | `time_contributions_import_record_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17145` | `pg_catalog.RI_FKey_check_ins` | `time_contributions_timecard_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17146` | `pg_catalog.RI_FKey_check_upd` | `time_contributions_timecard_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17150` | `pg_catalog.RI_FKey_check_ins` | `time_contributions_project_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17151` | `pg_catalog.RI_FKey_check_upd` | `time_contributions_project_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17155` | `pg_catalog.RI_FKey_check_ins` | `time_contributions_entry_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17156` | `pg_catalog.RI_FKey_check_upd` | `time_contributions_entry_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17160` | `pg_catalog.RI_FKey_check_ins` | `time_contributions_case_id_fkey` | O | False / False |
| `time_contributions` | `RI_ConstraintTrigger_c_17161` | `pg_catalog.RI_FKey_check_upd` | `time_contributions_case_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_a_16704` | `pg_catalog.RI_FKey_noaction_del` | `invoice_time_entries_entry_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_a_16705` | `pg_catalog.RI_FKey_noaction_upd` | `invoice_time_entries_entry_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_a_16802` | `pg_catalog.RI_FKey_noaction_del` | `case_time_allocations_entry_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_a_16803` | `pg_catalog.RI_FKey_noaction_upd` | `case_time_allocations_entry_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_a_17153` | `pg_catalog.RI_FKey_noaction_del` | `time_contributions_entry_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_a_17154` | `pg_catalog.RI_FKey_noaction_upd` | `time_contributions_entry_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_c_16687` | `pg_catalog.RI_FKey_check_ins` | `time_entries_project_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_c_16688` | `pg_catalog.RI_FKey_check_upd` | `time_entries_project_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_c_16692` | `pg_catalog.RI_FKey_check_ins` | `time_entries_timecard_id_fkey` | O | False / False |
| `time_entries` | `RI_ConstraintTrigger_c_16693` | `pg_catalog.RI_FKey_check_upd` | `time_entries_timecard_id_fkey` | O | False / False |
| `time_import_records` | `RI_ConstraintTrigger_a_17138` | `pg_catalog.RI_FKey_noaction_del` | `time_contributions_import_record_id_fkey` | O | False / False |
| `time_import_records` | `RI_ConstraintTrigger_a_17139` | `pg_catalog.RI_FKey_noaction_upd` | `time_contributions_import_record_id_fkey` | O | False / False |
| `time_import_records` | `RI_ConstraintTrigger_c_17106` | `pg_catalog.RI_FKey_check_ins` | `time_import_records_actor_id_fkey` | O | False / False |
| `time_import_records` | `RI_ConstraintTrigger_c_17107` | `pg_catalog.RI_FKey_check_upd` | `time_import_records_actor_id_fkey` | O | False / False |
| `time_operations` | `RI_ConstraintTrigger_c_17187` | `pg_catalog.RI_FKey_check_ins` | `time_operations_actor_id_fkey` | O | False / False |
| `time_operations` | `RI_ConstraintTrigger_c_17188` | `pg_catalog.RI_FKey_check_upd` | `time_operations_actor_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_a_16690` | `pg_catalog.RI_FKey_noaction_del` | `time_entries_timecard_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_a_16691` | `pg_catalog.RI_FKey_noaction_upd` | `time_entries_timecard_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_a_17143` | `pg_catalog.RI_FKey_noaction_del` | `time_contributions_timecard_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_a_17144` | `pg_catalog.RI_FKey_noaction_upd` | `time_contributions_timecard_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_c_16577` | `pg_catalog.RI_FKey_check_ins` | `timecards_client_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_c_16578` | `pg_catalog.RI_FKey_check_upd` | `timecards_client_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_c_16582` | `pg_catalog.RI_FKey_check_ins` | `timecards_owner_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_c_16583` | `pg_catalog.RI_FKey_check_upd` | `timecards_owner_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_c_18200` | `pg_catalog.RI_FKey_check_ins` | `timecards_internal_case_id_fkey` | O | False / False |
| `timecards` | `RI_ConstraintTrigger_c_18201` | `pg_catalog.RI_FKey_check_upd` | `timecards_internal_case_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16467` | `pg_catalog.RI_FKey_noaction_del` | `audit_events_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16468` | `pg_catalog.RI_FKey_noaction_upd` | `audit_events_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16580` | `pg_catalog.RI_FKey_noaction_del` | `timecards_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16581` | `pg_catalog.RI_FKey_noaction_upd` | `timecards_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16655` | `pg_catalog.RI_FKey_noaction_del` | `payments_created_by_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16656` | `pg_catalog.RI_FKey_noaction_upd` | `payments_created_by_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16776` | `pg_catalog.RI_FKey_noaction_del` | `cases_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16777` | `pg_catalog.RI_FKey_noaction_upd` | `cases_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16812` | `pg_catalog.RI_FKey_noaction_del` | `case_time_allocations_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16813` | `pg_catalog.RI_FKey_noaction_upd` | `case_time_allocations_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16851` | `pg_catalog.RI_FKey_noaction_del` | `mail_addresses_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16852` | `pg_catalog.RI_FKey_noaction_upd` | `mail_addresses_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16902` | `pg_catalog.RI_FKey_noaction_del` | `mail_messages_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_16903` | `pg_catalog.RI_FKey_noaction_upd` | `mail_messages_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17032` | `pg_catalog.RI_FKey_noaction_del` | `project_agreements_uploaded_by_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17033` | `pg_catalog.RI_FKey_noaction_upd` | `project_agreements_uploaded_by_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17074` | `pg_catalog.RI_FKey_noaction_del` | `credit_memos_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17075` | `pg_catalog.RI_FKey_noaction_upd` | `credit_memos_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17104` | `pg_catalog.RI_FKey_noaction_del` | `time_import_records_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17105` | `pg_catalog.RI_FKey_noaction_upd` | `time_import_records_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17133` | `pg_catalog.RI_FKey_noaction_del` | `time_contributions_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17134` | `pg_catalog.RI_FKey_noaction_upd` | `time_contributions_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17185` | `pg_catalog.RI_FKey_noaction_del` | `time_operations_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17186` | `pg_catalog.RI_FKey_noaction_upd` | `time_operations_actor_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17219` | `pg_catalog.RI_FKey_noaction_del` | `integration_grants_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17220` | `pg_catalog.RI_FKey_noaction_upd` | `integration_grants_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17312` | `pg_catalog.RI_FKey_noaction_del` | `client_drafts_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17313` | `pg_catalog.RI_FKey_noaction_upd` | `client_drafts_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17333` | `pg_catalog.RI_FKey_noaction_del` | `workspace_subscriptions_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17334` | `pg_catalog.RI_FKey_noaction_upd` | `workspace_subscriptions_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17357` | `pg_catalog.RI_FKey_noaction_del` | `subscription_operations_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17358` | `pg_catalog.RI_FKey_noaction_upd` | `subscription_operations_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17389` | `pg_catalog.RI_FKey_noaction_del` | `subscription_billing_operations_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17390` | `pg_catalog.RI_FKey_noaction_upd` | `subscription_billing_operations_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17424` | `pg_catalog.RI_FKey_noaction_del` | `subscription_billing_accounts_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17425` | `pg_catalog.RI_FKey_noaction_upd` | `subscription_billing_accounts_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17477` | `pg_catalog.RI_FKey_noaction_del` | `owner_identities_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17478` | `pg_catalog.RI_FKey_noaction_upd` | `owner_identities_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17499` | `pg_catalog.RI_FKey_noaction_del` | `owner_registrations_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17500` | `pg_catalog.RI_FKey_noaction_upd` | `owner_registrations_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17523` | `pg_catalog.RI_FKey_noaction_del` | `email_auth_challenges_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17524` | `pg_catalog.RI_FKey_noaction_upd` | `email_auth_challenges_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17550` | `pg_catalog.RI_FKey_noaction_del` | `sending_preferences_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17551` | `pg_catalog.RI_FKey_noaction_upd` | `sending_preferences_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17581` | `pg_catalog.RI_FKey_noaction_del` | `sending_plans_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17582` | `pg_catalog.RI_FKey_noaction_upd` | `sending_plans_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17615` | `pg_catalog.RI_FKey_noaction_del` | `sending_deliveries_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17616` | `pg_catalog.RI_FKey_noaction_upd` | `sending_deliveries_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17757` | `pg_catalog.RI_FKey_noaction_del` | `quotes_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17758` | `pg_catalog.RI_FKey_noaction_upd` | `quotes_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17880` | `pg_catalog.RI_FKey_noaction_del` | `quote_artifacts_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17881` | `pg_catalog.RI_FKey_noaction_upd` | `quote_artifacts_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17909` | `pg_catalog.RI_FKey_noaction_del` | `library_documents_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17910` | `pg_catalog.RI_FKey_noaction_upd` | `library_documents_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17958` | `pg_catalog.RI_FKey_noaction_del` | `library_uploads_uploaded_by_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17959` | `pg_catalog.RI_FKey_noaction_upd` | `library_uploads_uploaded_by_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17994` | `pg_catalog.RI_FKey_noaction_del` | `library_document_versions_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_17995` | `pg_catalog.RI_FKey_noaction_upd` | `library_document_versions_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_18041` | `pg_catalog.RI_FKey_noaction_del` | `proposal_sending_deliveries_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_18042` | `pg_catalog.RI_FKey_noaction_upd` | `proposal_sending_deliveries_owner_id_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_18230` | `pg_catalog.RI_FKey_noaction_del` | `client_source_references_uploaded_by_fkey` | O | False / False |
| `users` | `RI_ConstraintTrigger_a_18231` | `pg_catalog.RI_FKey_noaction_upd` | `client_source_references_uploaded_by_fkey` | O | False / False |
| `workspace_subscriptions` | `RI_ConstraintTrigger_c_17335` | `pg_catalog.RI_FKey_check_ins` | `workspace_subscriptions_owner_id_fkey` | O | False / False |
| `workspace_subscriptions` | `RI_ConstraintTrigger_c_17336` | `pg_catalog.RI_FKey_check_upd` | `workspace_subscriptions_owner_id_fkey` | O | False / False |
