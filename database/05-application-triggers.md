# Every application trigger

Source `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64`; migration head `ph3_009_read_indexes`. Extracted on 2026-10-18 from a new empty PostgreSQL 18.4 database after all 26 Alembic migrations. `timeker_reference` is a synthetic documentation schema, not a hosted schema name. No seed, business-row query or hosted connection ran.


61 explicitly application-defined triggers:57 ordinary and 4 constraint triggers.
The4 constraint triggers are DEFERRABLE INITIALLY DEFERRED. Enabled code `O` means
normal/origin firing. Native FK implementation triggers are separately inventoried
in [internal triggers](06-internal-triggers-and-other-objects.md).

| Table | Trigger | Function | Constraint / deferred |
| --- | --- | --- | --- |
| [admission_identities](02-tables-and-layouts.md#admission_identities) | `admission_identity_history` | [timeker_admission_history_guard](04-functions-and-procedures.md#timeker_admission_history_guard) | — |
| [audit_events](02-tables-and-layouts.md#audit_events) | `audit_guard` | [timeker_artifact_guard](04-functions-and-procedures.md#timeker_artifact_guard) | — |
| [case_time_allocations](02-tables-and-layouts.md#case_time_allocations) | `allocation_contribution_guard` | [timeker_allocation_contribution_guard](04-functions-and-procedures.md#timeker_allocation_contribution_guard) | — |
| [case_time_allocations](02-tables-and-layouts.md#case_time_allocations) | `allocation_guard` | [timeker_allocation_guard](04-functions-and-procedures.md#timeker_allocation_guard) | — |
| [cases](02-tables-and-layouts.md#cases) | `case_archive_status_guard` | [timeker_case_archive_status_guard](04-functions-and-procedures.md#timeker_case_archive_status_guard) | — |
| [cases](02-tables-and-layouts.md#cases) | `case_guard` | [timeker_case_guard](04-functions-and-procedures.md#timeker_case_guard) | — |
| [cases](02-tables-and-layouts.md#cases) | `commercial_case_guard` | [timeker_commercial_case_guard](04-functions-and-procedures.md#timeker_commercial_case_guard) | — |
| [clients](02-tables-and-layouts.md#clients) | `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |
| [credit_memos](02-tables-and-layouts.md#credit_memos) | `credit_memo_guard` | [timeker_credit_memo_guard](04-functions-and-procedures.md#timeker_credit_memo_guard) | — |
| [credit_memos](02-tables-and-layouts.md#credit_memos) | `credit_memo_invoice_check` | [timeker_credit_memo_final_guard](04-functions-and-procedures.md#timeker_credit_memo_final_guard) | `credit_memo_invoice_check` / initially deferred |
| [email_auth_challenges](02-tables-and-layouts.md#email_auth_challenges) | `email_challenge_history` | [timeker_registration_history_guard](04-functions-and-procedures.md#timeker_registration_history_guard) | — |
| [invoice_artifacts](02-tables-and-layouts.md#invoice_artifacts) | `artifact_guard` | [timeker_artifact_guard](04-functions-and-procedures.md#timeker_artifact_guard) | — |
| [invoice_lines](02-tables-and-layouts.md#invoice_lines) | `line_guard` | [timeker_line_guard](04-functions-and-procedures.md#timeker_line_guard) | — |
| [invoice_time_entries](02-tables-and-layouts.md#invoice_time_entries) | `internal_billing_guard` | [timeker_internal_billing_guard](04-functions-and-procedures.md#timeker_internal_billing_guard) | — |
| [invoices](02-tables-and-layouts.md#invoices) | `invoice_credit_memo_check` | [timeker_credit_memo_final_guard](04-functions-and-procedures.md#timeker_credit_memo_final_guard) | `invoice_credit_memo_check` / initially deferred |
| [invoices](02-tables-and-layouts.md#invoices) | `invoice_guard` | [timeker_invoice_guard](04-functions-and-procedures.md#timeker_invoice_guard) | — |
| [invoices](02-tables-and-layouts.md#invoices) | `issued_artifact_check` | [timeker_issued_artifact_check](04-functions-and-procedures.md#timeker_issued_artifact_check) | `issued_artifact_check` / initially deferred |
| [invoices](02-tables-and-layouts.md#invoices) | `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |
| [library_document_versions](02-tables-and-layouts.md#library_document_versions) | `library_version_guard` | [timeker_library_guard](04-functions-and-procedures.md#timeker_library_guard) | — |
| [library_documents](02-tables-and-layouts.md#library_documents) | `library_document_guard` | [timeker_library_guard](04-functions-and-procedures.md#timeker_library_guard) | — |
| [library_documents](02-tables-and-layouts.md#library_documents) | `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |
| [library_uploads](02-tables-and-layouts.md#library_uploads) | `library_upload_guard` | [timeker_library_guard](04-functions-and-procedures.md#timeker_library_guard) | — |
| [mail_addresses](02-tables-and-layouts.md#mail_addresses) | `mail_address_guard` | [timeker_mail_guard](04-functions-and-procedures.md#timeker_mail_guard) | — |
| [mail_attachments](02-tables-and-layouts.md#mail_attachments) | `mail_attachment_guard` | [timeker_mail_attachment_guard](04-functions-and-procedures.md#timeker_mail_attachment_guard) | — |
| [mail_messages](02-tables-and-layouts.md#mail_messages) | `archive_mail_guard` | [timeker_archive_guard](04-functions-and-procedures.md#timeker_archive_guard) | — |
| [mail_messages](02-tables-and-layouts.md#mail_messages) | `mail_message_guard` | [timeker_mail_guard](04-functions-and-procedures.md#timeker_mail_guard) | — |
| [owner_identities](02-tables-and-layouts.md#owner_identities) | `identity_binding_history` | [timeker_registration_history_guard](04-functions-and-procedures.md#timeker_registration_history_guard) | — |
| [owner_registrations](02-tables-and-layouts.md#owner_registrations) | `registration_acceptance_history` | [timeker_registration_history_guard](04-functions-and-procedures.md#timeker_registration_history_guard) | — |
| [payments](02-tables-and-layouts.md#payments) | `payment_guard` | [timeker_payment_guard](04-functions-and-procedures.md#timeker_payment_guard) | — |
| [project_agreements](02-tables-and-layouts.md#project_agreements) | `project_agreement_guard` | [timeker_project_agreement_guard](04-functions-and-procedures.md#timeker_project_agreement_guard) | — |
| [projects](02-tables-and-layouts.md#projects) | `allocated_project_guard` | [timeker_allocated_parent_guard](04-functions-and-procedures.md#timeker_allocated_parent_guard) | — |
| [projects](02-tables-and-layouts.md#projects) | `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |
| [projects](02-tables-and-layouts.md#projects) | `project_billing_guard` | [timeker_project_billing_guard](04-functions-and-procedures.md#timeker_project_billing_guard) | — |
| [proposal_sending_attempts](02-tables-and-layouts.md#proposal_sending_attempts) | `proposal_attempt_guard` | [timeker_proposal_sending_guard](04-functions-and-procedures.md#timeker_proposal_sending_guard) | — |
| [proposal_sending_deliveries](02-tables-and-layouts.md#proposal_sending_deliveries) | `proposal_delivery_guard` | [timeker_proposal_sending_guard](04-functions-and-procedures.md#timeker_proposal_sending_guard) | — |
| [public_email_challenges](02-tables-and-layouts.md#public_email_challenges) | `public_email_challenge_history` | [timeker_admission_history_guard](04-functions-and-procedures.md#timeker_admission_history_guard) | — |
| [quote_artifacts](02-tables-and-layouts.md#quote_artifacts) | `quote_artifact_guard` | [timeker_quote_guard](04-functions-and-procedures.md#timeker_quote_guard) | — |
| [quote_lines](02-tables-and-layouts.md#quote_lines) | `quote_line_guard` | [timeker_quote_guard](04-functions-and-procedures.md#timeker_quote_guard) | — |
| [quote_revisions](02-tables-and-layouts.md#quote_revisions) | `quote_revision_guard` | [timeker_quote_guard](04-functions-and-procedures.md#timeker_quote_guard) | — |
| [quotes](02-tables-and-layouts.md#quotes) | `quote_root_guard` | [timeker_quote_guard](04-functions-and-procedures.md#timeker_quote_guard) | — |
| [sending_attempts](02-tables-and-layouts.md#sending_attempts) | `sending_attempt_history` | [timeker_sending_guard](04-functions-and-procedures.md#timeker_sending_guard) | — |
| [sending_deliveries](02-tables-and-layouts.md#sending_deliveries) | `sending_delivery_history` | [timeker_sending_guard](04-functions-and-procedures.md#timeker_sending_guard) | — |
| [sending_plans](02-tables-and-layouts.md#sending_plans) | `sending_plan_history` | [timeker_sending_guard](04-functions-and-procedures.md#timeker_sending_guard) | — |
| [subscription_billing_accounts](02-tables-and-layouts.md#subscription_billing_accounts) | `subscription_billing_account_history` | [timeker_subscription_billing_guard](04-functions-and-procedures.md#timeker_subscription_billing_guard) | — |
| [subscription_billing_events](02-tables-and-layouts.md#subscription_billing_events) | `subscription_billing_event_history` | [timeker_subscription_billing_guard](04-functions-and-procedures.md#timeker_subscription_billing_guard) | — |
| [subscription_billing_operations](02-tables-and-layouts.md#subscription_billing_operations) | `subscription_billing_operation_history` | [timeker_subscription_billing_guard](04-functions-and-procedures.md#timeker_subscription_billing_guard) | — |
| [subscription_operations](02-tables-and-layouts.md#subscription_operations) | `subscription_operation_history` | [timeker_subscription_history_guard](04-functions-and-procedures.md#timeker_subscription_history_guard) | — |
| [time_contributions](02-tables-and-layouts.md#time_contributions) | `contribution_allocation_check` | [timeker_contribution_allocation_check](04-functions-and-procedures.md#timeker_contribution_allocation_check) | `contribution_allocation_check` / initially deferred |
| [time_contributions](02-tables-and-layouts.md#time_contributions) | `contribution_guard` | [timeker_contribution_guard](04-functions-and-procedures.md#timeker_contribution_guard) | — |
| [time_entries](02-tables-and-layouts.md#time_entries) | `entry_allocation_guard` | [timeker_allocated_entry_guard](04-functions-and-procedures.md#timeker_allocated_entry_guard) | — |
| [time_entries](02-tables-and-layouts.md#time_entries) | `entry_contribution_guard` | [timeker_entry_contribution_guard](04-functions-and-procedures.md#timeker_entry_contribution_guard) | — |
| [time_entries](02-tables-and-layouts.md#time_entries) | `entry_guard` | [timeker_entry_guard](04-functions-and-procedures.md#timeker_entry_guard) | — |
| [time_import_records](02-tables-and-layouts.md#time_import_records) | `time_import_record_guard` | [timeker_time_operation_guard](04-functions-and-procedures.md#timeker_time_operation_guard) | — |
| [time_operations](02-tables-and-layouts.md#time_operations) | `time_operation_guard` | [timeker_time_operation_guard](04-functions-and-procedures.md#timeker_time_operation_guard) | — |
| [timecards](02-tables-and-layouts.md#timecards) | `allocated_card_guard` | [timeker_allocated_parent_guard](04-functions-and-procedures.md#timeker_allocated_parent_guard) | — |
| [timecards](02-tables-and-layouts.md#timecards) | `archive_card_guard` | [timeker_archive_guard](04-functions-and-procedures.md#timeker_archive_guard) | — |
| [timecards](02-tables-and-layouts.md#timecards) | `internal_card_guard` | [timeker_internal_card_guard](04-functions-and-procedures.md#timeker_internal_card_guard) | — |
| [timecards](02-tables-and-layouts.md#timecards) | `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |
| [timecards](02-tables-and-layouts.md#timecards) | `timecard_void_restriction` | [timeker_timecard_void_restriction](04-functions-and-procedures.md#timeker_timecard_void_restriction) | — |
| [workspace_admissions](02-tables-and-layouts.md#workspace_admissions) | `admission_allocation_history` | [timeker_admission_history_guard](04-functions-and-procedures.md#timeker_admission_history_guard) | — |
| [workspace_subscriptions](02-tables-and-layouts.md#workspace_subscriptions) | `subscription_assignment_history` | [timeker_subscription_history_guard](04-functions-and-procedures.md#timeker_subscription_history_guard) | — |

## admission_identities.admission_identity_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER admission_identity_history BEFORE DELETE OR UPDATE ON admission_identities FOR EACH ROW EXECUTE FUNCTION timeker_admission_history_guard();
```

## audit_events.audit_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER audit_guard BEFORE DELETE OR UPDATE ON audit_events FOR EACH ROW EXECUTE FUNCTION timeker_artifact_guard();
```

## case_time_allocations.allocation_contribution_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER allocation_contribution_guard BEFORE DELETE OR UPDATE ON case_time_allocations FOR EACH ROW EXECUTE FUNCTION timeker_allocation_contribution_guard();
```

## case_time_allocations.allocation_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER allocation_guard BEFORE INSERT OR DELETE OR UPDATE ON case_time_allocations FOR EACH ROW EXECUTE FUNCTION timeker_allocation_guard();
```

## cases.case_archive_status_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER case_archive_status_guard BEFORE INSERT OR UPDATE ON cases FOR EACH ROW EXECUTE FUNCTION timeker_case_archive_status_guard();
```

## cases.case_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER case_guard BEFORE INSERT OR DELETE OR UPDATE ON cases FOR EACH ROW EXECUTE FUNCTION timeker_case_guard();
```

## cases.commercial_case_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER commercial_case_guard BEFORE UPDATE ON cases FOR EACH ROW EXECUTE FUNCTION timeker_commercial_case_guard();
```

## clients.object_id_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER object_id_guard BEFORE UPDATE ON clients FOR EACH ROW EXECUTE FUNCTION timeker_object_id_guard();
```

## credit_memos.credit_memo_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER credit_memo_guard BEFORE INSERT OR DELETE OR UPDATE ON credit_memos FOR EACH ROW EXECUTE FUNCTION timeker_credit_memo_guard();
```

## credit_memos.credit_memo_invoice_check

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE CONSTRAINT TRIGGER credit_memo_invoice_check AFTER INSERT ON credit_memos DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION timeker_credit_memo_final_guard();
```

## email_auth_challenges.email_challenge_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER email_challenge_history BEFORE DELETE OR UPDATE ON email_auth_challenges FOR EACH ROW EXECUTE FUNCTION timeker_registration_history_guard();
```

## invoice_artifacts.artifact_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER artifact_guard BEFORE DELETE OR UPDATE ON invoice_artifacts FOR EACH ROW EXECUTE FUNCTION timeker_artifact_guard();
```

## invoice_lines.line_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER line_guard BEFORE INSERT OR DELETE OR UPDATE ON invoice_lines FOR EACH ROW EXECUTE FUNCTION timeker_line_guard();
```

## invoice_time_entries.internal_billing_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER internal_billing_guard BEFORE INSERT OR UPDATE ON invoice_time_entries FOR EACH ROW EXECUTE FUNCTION timeker_internal_billing_guard();
```

## invoices.invoice_credit_memo_check

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE CONSTRAINT TRIGGER invoice_credit_memo_check AFTER INSERT OR UPDATE ON invoices DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION timeker_credit_memo_final_guard();
```

## invoices.invoice_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER invoice_guard BEFORE INSERT OR DELETE OR UPDATE ON invoices FOR EACH ROW EXECUTE FUNCTION timeker_invoice_guard();
```

## invoices.issued_artifact_check

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE CONSTRAINT TRIGGER issued_artifact_check AFTER INSERT OR UPDATE ON invoices DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION timeker_issued_artifact_check();
```

## invoices.object_id_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER object_id_guard BEFORE UPDATE ON invoices FOR EACH ROW EXECUTE FUNCTION timeker_object_id_guard();
```

## library_document_versions.library_version_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER library_version_guard BEFORE INSERT OR DELETE OR UPDATE ON library_document_versions FOR EACH ROW EXECUTE FUNCTION timeker_library_guard();
```

## library_documents.library_document_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER library_document_guard BEFORE INSERT OR DELETE OR UPDATE ON library_documents FOR EACH ROW EXECUTE FUNCTION timeker_library_guard();
```

## library_documents.object_id_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER object_id_guard BEFORE UPDATE ON library_documents FOR EACH ROW EXECUTE FUNCTION timeker_object_id_guard();
```

## library_uploads.library_upload_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER library_upload_guard BEFORE INSERT OR DELETE OR UPDATE ON library_uploads FOR EACH ROW EXECUTE FUNCTION timeker_library_guard();
```

## mail_addresses.mail_address_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER mail_address_guard BEFORE INSERT OR UPDATE ON mail_addresses FOR EACH ROW EXECUTE FUNCTION timeker_mail_guard();
```

## mail_attachments.mail_attachment_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER mail_attachment_guard BEFORE INSERT OR DELETE OR UPDATE ON mail_attachments FOR EACH ROW EXECUTE FUNCTION timeker_mail_attachment_guard();
```

## mail_messages.archive_mail_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER archive_mail_guard BEFORE DELETE OR UPDATE ON mail_messages FOR EACH ROW EXECUTE FUNCTION timeker_archive_guard();
```

## mail_messages.mail_message_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER mail_message_guard BEFORE INSERT OR UPDATE ON mail_messages FOR EACH ROW EXECUTE FUNCTION timeker_mail_guard();
```

## owner_identities.identity_binding_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER identity_binding_history BEFORE DELETE OR UPDATE ON owner_identities FOR EACH ROW EXECUTE FUNCTION timeker_registration_history_guard();
```

## owner_registrations.registration_acceptance_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER registration_acceptance_history BEFORE DELETE OR UPDATE ON owner_registrations FOR EACH ROW EXECUTE FUNCTION timeker_registration_history_guard();
```

## payments.payment_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER payment_guard BEFORE DELETE OR UPDATE ON payments FOR EACH ROW EXECUTE FUNCTION timeker_payment_guard();
```

## project_agreements.project_agreement_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER project_agreement_guard BEFORE INSERT OR DELETE OR UPDATE ON project_agreements FOR EACH ROW EXECUTE FUNCTION timeker_project_agreement_guard();
```

## projects.allocated_project_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER allocated_project_guard BEFORE UPDATE ON projects FOR EACH ROW EXECUTE FUNCTION timeker_allocated_parent_guard();
```

## projects.object_id_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER object_id_guard BEFORE UPDATE ON projects FOR EACH ROW EXECUTE FUNCTION timeker_object_id_guard();
```

## projects.project_billing_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER project_billing_guard BEFORE UPDATE ON projects FOR EACH ROW EXECUTE FUNCTION timeker_project_billing_guard();
```

## proposal_sending_attempts.proposal_attempt_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER proposal_attempt_guard BEFORE INSERT OR DELETE OR UPDATE ON proposal_sending_attempts FOR EACH ROW EXECUTE FUNCTION timeker_proposal_sending_guard();
```

## proposal_sending_deliveries.proposal_delivery_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER proposal_delivery_guard BEFORE INSERT OR DELETE OR UPDATE ON proposal_sending_deliveries FOR EACH ROW EXECUTE FUNCTION timeker_proposal_sending_guard();
```

## public_email_challenges.public_email_challenge_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER public_email_challenge_history BEFORE DELETE OR UPDATE ON public_email_challenges FOR EACH ROW EXECUTE FUNCTION timeker_admission_history_guard();
```

## quote_artifacts.quote_artifact_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER quote_artifact_guard BEFORE INSERT OR DELETE OR UPDATE ON quote_artifacts FOR EACH ROW EXECUTE FUNCTION timeker_quote_guard();
```

## quote_lines.quote_line_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER quote_line_guard BEFORE INSERT OR DELETE OR UPDATE ON quote_lines FOR EACH ROW EXECUTE FUNCTION timeker_quote_guard();
```

## quote_revisions.quote_revision_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER quote_revision_guard BEFORE INSERT OR DELETE OR UPDATE ON quote_revisions FOR EACH ROW EXECUTE FUNCTION timeker_quote_guard();
```

## quotes.quote_root_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER quote_root_guard BEFORE INSERT OR DELETE OR UPDATE ON quotes FOR EACH ROW EXECUTE FUNCTION timeker_quote_guard();
```

## sending_attempts.sending_attempt_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER sending_attempt_history BEFORE INSERT OR DELETE OR UPDATE ON sending_attempts FOR EACH ROW EXECUTE FUNCTION timeker_sending_guard();
```

## sending_deliveries.sending_delivery_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER sending_delivery_history BEFORE INSERT OR DELETE OR UPDATE ON sending_deliveries FOR EACH ROW EXECUTE FUNCTION timeker_sending_guard();
```

## sending_plans.sending_plan_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER sending_plan_history BEFORE INSERT OR DELETE OR UPDATE ON sending_plans FOR EACH ROW EXECUTE FUNCTION timeker_sending_guard();
```

## subscription_billing_accounts.subscription_billing_account_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER subscription_billing_account_history BEFORE DELETE OR UPDATE ON subscription_billing_accounts FOR EACH ROW EXECUTE FUNCTION timeker_subscription_billing_guard();
```

## subscription_billing_events.subscription_billing_event_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER subscription_billing_event_history BEFORE DELETE OR UPDATE ON subscription_billing_events FOR EACH ROW EXECUTE FUNCTION timeker_subscription_billing_guard();
```

## subscription_billing_operations.subscription_billing_operation_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER subscription_billing_operation_history BEFORE DELETE OR UPDATE ON subscription_billing_operations FOR EACH ROW EXECUTE FUNCTION timeker_subscription_billing_guard();
```

## subscription_operations.subscription_operation_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER subscription_operation_history BEFORE DELETE OR UPDATE ON subscription_operations FOR EACH ROW EXECUTE FUNCTION timeker_subscription_history_guard();
```

## time_contributions.contribution_allocation_check

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE CONSTRAINT TRIGGER contribution_allocation_check AFTER INSERT OR UPDATE ON time_contributions DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION timeker_contribution_allocation_check();
```

## time_contributions.contribution_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER contribution_guard BEFORE INSERT OR DELETE OR UPDATE ON time_contributions FOR EACH ROW EXECUTE FUNCTION timeker_contribution_guard();
```

## time_entries.entry_allocation_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER entry_allocation_guard BEFORE DELETE OR UPDATE ON time_entries FOR EACH ROW EXECUTE FUNCTION timeker_allocated_entry_guard();
```

## time_entries.entry_contribution_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER entry_contribution_guard BEFORE DELETE OR UPDATE ON time_entries FOR EACH ROW EXECUTE FUNCTION timeker_entry_contribution_guard();
```

## time_entries.entry_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER entry_guard BEFORE INSERT OR DELETE OR UPDATE ON time_entries FOR EACH ROW EXECUTE FUNCTION timeker_entry_guard();
```

## time_import_records.time_import_record_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER time_import_record_guard BEFORE DELETE OR UPDATE ON time_import_records FOR EACH ROW EXECUTE FUNCTION timeker_time_operation_guard();
```

## time_operations.time_operation_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER time_operation_guard BEFORE DELETE OR UPDATE ON time_operations FOR EACH ROW EXECUTE FUNCTION timeker_time_operation_guard();
```

## timecards.allocated_card_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER allocated_card_guard BEFORE UPDATE ON timecards FOR EACH ROW EXECUTE FUNCTION timeker_allocated_parent_guard();
```

## timecards.archive_card_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER archive_card_guard BEFORE DELETE OR UPDATE ON timecards FOR EACH ROW EXECUTE FUNCTION timeker_archive_guard();
```

## timecards.internal_card_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER internal_card_guard BEFORE INSERT OR UPDATE ON timecards FOR EACH ROW EXECUTE FUNCTION timeker_internal_card_guard();
```

## timecards.object_id_guard

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER object_id_guard BEFORE UPDATE ON timecards FOR EACH ROW EXECUTE FUNCTION timeker_object_id_guard();
```

## timecards.timecard_void_restriction

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER timecard_void_restriction BEFORE INSERT OR UPDATE ON timecards FOR EACH ROW EXECUTE FUNCTION timeker_timecard_void_restriction();
```

## workspace_admissions.admission_allocation_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER admission_allocation_history BEFORE DELETE OR UPDATE ON workspace_admissions FOR EACH ROW EXECUTE FUNCTION timeker_admission_history_guard();
```

## workspace_subscriptions.subscription_assignment_history

Enabled: `O`; internal: `false`; function schema: `timeker_reference`.

```sql
CREATE TRIGGER subscription_assignment_history BEFORE DELETE OR UPDATE ON workspace_subscriptions FOR EACH ROW EXECUTE FUNCTION timeker_subscription_history_guard();
```
