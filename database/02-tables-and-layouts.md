# All tables and complete layouts

Candidate source `4bb5c424d6e7d270cdca1479283896be77d581c3`; migration head `ph3_009_read_indexes`. Structural reference inherited from the original 2026-10-18 empty PostgreSQL18.4 reconstruction at `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` after 26 migrations. Exactly 45 structural input blobs are unchanged at the candidate. No database connection, migration or DDL replay was rerun in this refresh. `timeker_reference` is synthetic, not a hosted schema name; no business rows or hosted catalog are included.


All names below are relative to the synthetic reference schema. SQL server defaults,
identity generation and Python client defaults are deliberately separate. `—` means
absent; NULL allowed is explicit. Identity `a` means GENERATED ALWAYS, `d` BY DEFAULT.
Collations, ordinal positions and all constraints also appear in [catalog.json](catalog.json).
All tables are permanent ordinary tables, without RLS or partition keys in this build.

## Table index

| Domain | Exact tables |
| --- | --- |
| Owner, settings and audit | [users](#users), [app_settings](#app_settings), [audit_events](#audit_events), [contact_attempts](#contact_attempts) |
| Clients, projects and cases | [clients](#clients), [contacts](#contacts), [client_source_references](#client_source_references), [projects](#projects), [project_agreements](#project_agreements), [cases](#cases) |
| Work records and time commands | [timecards](#timecards), [time_entries](#time_entries), [case_time_allocations](#case_time_allocations), [time_contributions](#time_contributions), [time_import_records](#time_import_records), [time_operations](#time_operations) |
| Statements and payments | [invoices](#invoices), [invoice_lines](#invoice_lines), [invoice_time_entries](#invoice_time_entries), [invoice_artifacts](#invoice_artifacts), [payments](#payments), [credit_memos](#credit_memos) |
| Delegated integrations | [integration_grants](#integration_grants), [integration_codes](#integration_codes), [integration_tokens](#integration_tokens), [integration_operations](#integration_operations), [client_drafts](#client_drafts) |
| Plans and provider billing | [workspace_subscriptions](#workspace_subscriptions), [subscription_operations](#subscription_operations), [subscription_billing_accounts](#subscription_billing_accounts), [subscription_billing_operations](#subscription_billing_operations), [subscription_billing_events](#subscription_billing_events) |
| Enrollment and central directory | [owner_identities](#owner_identities), [owner_registrations](#owner_registrations), [email_auth_challenges](#email_auth_challenges), [workspace_admissions](#workspace_admissions), [admission_identities](#admission_identities), [public_email_challenges](#public_email_challenges) |
| Statement Sending | [sending_preferences](#sending_preferences), [sending_plans](#sending_plans), [sending_deliveries](#sending_deliveries), [sending_attempts](#sending_attempts) |
| Quoting, library and commercial Sending | [quotes](#quotes), [quote_revisions](#quote_revisions), [quote_lines](#quote_lines), [quote_artifacts](#quote_artifacts), [library_documents](#library_documents), [library_uploads](#library_uploads), [library_document_versions](#library_document_versions), [proposal_sending_deliveries](#proposal_sending_deliveries), [proposal_sending_attempts](#proposal_sending_attempts) |
| Mail custody | [mail_messages](#mail_messages), [mail_addresses](#mail_addresses), [mail_attachments](#mail_attachments) |
| Migration bookkeeping | [alembic_version](#alembic_version) |

## admission_identities

Mapped class `AdmissionIdentity`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L26).

10 columns; 15 catalog constraints; 4 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `tenant_id` | `uuid` | No | UNIQUE | — | — | — | — |
| 5 | `owner_id` | `uuid` | No | UNIQUE | — | — | — | — |
| 6 | `identity_id` | `uuid` | No | UNIQUE | — | — | — | — |
| 7 | `issuer` | `character varying(255)` | No | UNIQUE | — | — | — | — |
| 8 | `subject` | `character varying(255)` | No | UNIQUE | — | — | — | — |
| 9 | `verified_email` | `character varying(254)` | No | — | — | — | — | — |
| 10 | `state` | `character varying(12)` | No | — | — | — | `'pending'` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `admission_identities_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `admission_identities_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `admission_identities_identity_id_not_null` | NOT NULL | `NOT NULL identity_id` | No |
| `admission_identities_issuer_not_null` | NOT NULL | `NOT NULL issuer` | No |
| `admission_identities_issuer_subject_key` | UNIQUE | `UNIQUE (issuer, subject)` | No |
| `admission_identities_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `admission_identities_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `admission_identities_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['pending'::character varying, 'active'::character varying, 'blocked'::character varying, 'revoked'::character varying]::text[]))` | No |
| `admission_identities_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `admission_identities_subject_not_null` | NOT NULL | `NOT NULL subject` | No |
| `admission_identities_tenant_id_identity_id_key` | UNIQUE | `UNIQUE (tenant_id, identity_id)` | No |
| `admission_identities_tenant_id_not_null` | NOT NULL | `NOT NULL tenant_id` | No |
| `admission_identities_tenant_id_owner_id_issuer_key` | UNIQUE | `UNIQUE (tenant_id, owner_id, issuer)` | No |
| `admission_identities_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `admission_identities_verified_email_not_null` | NOT NULL | `NOT NULL verified_email` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `admission_identities_issuer_subject_key` | `CREATE UNIQUE INDEX admission_identities_issuer_subject_key ON timeker_reference.admission_identities USING btree (issuer, subject)` |
| `admission_identities_pkey` | `CREATE UNIQUE INDEX admission_identities_pkey ON timeker_reference.admission_identities USING btree (id)` |
| `admission_identities_tenant_id_identity_id_key` | `CREATE UNIQUE INDEX admission_identities_tenant_id_identity_id_key ON timeker_reference.admission_identities USING btree (tenant_id, identity_id)` |
| `admission_identities_tenant_id_owner_id_issuer_key` | `CREATE UNIQUE INDEX admission_identities_tenant_id_owner_id_issuer_key ON timeker_reference.admission_identities USING btree (tenant_id, owner_id, issuer)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `admission_identity_history` | [timeker_admission_history_guard](04-functions-and-procedures.md#timeker_admission_history_guard) | — |

## alembic_version

Alembic migration metadata; not a mapped application entity.

1 columns; 2 catalog constraints; 1 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `version_num` | `character varying(32)` | No | PK | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `alembic_version_pkc` | PRIMARY KEY | `PRIMARY KEY (version_num)` | No |
| `alembic_version_version_num_not_null` | NOT NULL | `NOT NULL version_num` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `alembic_version_pkc` | `CREATE UNIQUE INDEX alembic_version_pkc ON timeker_reference.alembic_version USING btree (version_num)` |

### Application triggers

None.

## app_settings

Mapped class `AppSettings`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L404).

6 columns; 7 catalog constraints; 2 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `key` | `character varying(30)` | No | UNIQUE | — | — | — | — |
| 2 | `value` | `jsonb` | No | — | — | — | `Python callable: dict` | — |
| 3 | `encrypted_value` | `bytea` | Yes | — | — | — | — | — |
| 4 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 5 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 6 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `app_settings_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `app_settings_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `app_settings_key_key` | UNIQUE | `UNIQUE (key)` | No |
| `app_settings_key_not_null` | NOT NULL | `NOT NULL key` | No |
| `app_settings_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `app_settings_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `app_settings_value_not_null` | NOT NULL | `NOT NULL value` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `app_settings_key_key` | `CREATE UNIQUE INDEX app_settings_key_key ON timeker_reference.app_settings USING btree (key)` |
| `app_settings_pkey` | `CREATE UNIQUE INDEX app_settings_pkey ON timeker_reference.app_settings USING btree (id)` |

### Application triggers

None.

## audit_events

Mapped class `Audit`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L394).

9 columns; 10 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `actor_id` | `uuid` | Yes | FK | — | — | — | — |
| 2 | `request_id` | `uuid` | No | — | — | — | — | — |
| 3 | `event_type` | `character varying(60)` | No | — | — | — | — | — |
| 4 | `entity_type` | `character varying(30)` | No | — | — | — | — | — |
| 5 | `entity_id` | `uuid` | No | — | — | — | — | — |
| 6 | `details` | `jsonb` | No | — | — | — | `Python callable: dict` | — |
| 7 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 8 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 9 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `audit_events_actor_id_fkey` | FOREIGN KEY | `FOREIGN KEY (actor_id) REFERENCES users(id)` | No |
| `audit_events_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `audit_events_details_not_null` | NOT NULL | `NOT NULL details` | No |
| `audit_events_entity_id_not_null` | NOT NULL | `NOT NULL entity_id` | No |
| `audit_events_entity_type_not_null` | NOT NULL | `NOT NULL entity_type` | No |
| `audit_events_event_type_not_null` | NOT NULL | `NOT NULL event_type` | No |
| `audit_events_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `audit_events_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `audit_events_request_id_not_null` | NOT NULL | `NOT NULL request_id` | No |
| `audit_events_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `audit_events_pkey` | `CREATE UNIQUE INDEX audit_events_pkey ON timeker_reference.audit_events USING btree (id)` |
| `ix_audit_events_created_id` | `CREATE INDEX ix_audit_events_created_id ON timeker_reference.audit_events USING btree (created_at DESC, id)` |
| `ix_audit_events_entity_id` | `CREATE INDEX ix_audit_events_entity_id ON timeker_reference.audit_events USING btree (entity_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `audit_guard` | [timeker_artifact_guard](04-functions-and-procedures.md#timeker_artifact_guard) | — |

## case_time_allocations

Mapped class `CaseTimeAllocation`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L266).

8 columns; 14 catalog constraints; 4 indexes; 2 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `entry_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `case_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 6 | `minutes` | `integer` | No | — | — | — | — | — |
| 7 | `actor_id` | `uuid` | No | FK | — | — | — | — |
| 8 | `version` | `integer` | No | — | — | — | `1` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `case_time_allocations_actor_id_fkey` | FOREIGN KEY | `FOREIGN KEY (actor_id) REFERENCES users(id)` | No |
| `case_time_allocations_actor_id_not_null` | NOT NULL | `NOT NULL actor_id` | No |
| `case_time_allocations_case_id_fkey` | FOREIGN KEY | `FOREIGN KEY (case_id) REFERENCES cases(id)` | No |
| `case_time_allocations_case_id_not_null` | NOT NULL | `NOT NULL case_id` | No |
| `case_time_allocations_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `case_time_allocations_entry_id_case_id_key` | UNIQUE | `UNIQUE (entry_id, case_id)` | No |
| `case_time_allocations_entry_id_fkey` | FOREIGN KEY | `FOREIGN KEY (entry_id) REFERENCES time_entries(id)` | No |
| `case_time_allocations_entry_id_not_null` | NOT NULL | `NOT NULL entry_id` | No |
| `case_time_allocations_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `case_time_allocations_minutes_check` | CHECK | `CHECK (minutes >= 1 AND minutes <= 1440)` | No |
| `case_time_allocations_minutes_not_null` | NOT NULL | `NOT NULL minutes` | No |
| `case_time_allocations_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `case_time_allocations_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `case_time_allocations_version_not_null` | NOT NULL | `NOT NULL version` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `case_time_allocations_entry_id_case_id_key` | `CREATE UNIQUE INDEX case_time_allocations_entry_id_case_id_key ON timeker_reference.case_time_allocations USING btree (entry_id, case_id)` |
| `case_time_allocations_pkey` | `CREATE UNIQUE INDEX case_time_allocations_pkey ON timeker_reference.case_time_allocations USING btree (id)` |
| `ix_case_time_allocations_case_id` | `CREATE INDEX ix_case_time_allocations_case_id ON timeker_reference.case_time_allocations USING btree (case_id)` |
| `ix_case_time_allocations_entry_id` | `CREATE INDEX ix_case_time_allocations_entry_id ON timeker_reference.case_time_allocations USING btree (entry_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `allocation_contribution_guard` | [timeker_allocation_contribution_guard](04-functions-and-procedures.md#timeker_allocation_contribution_guard) | — |
| `allocation_guard` | [timeker_allocation_guard](04-functions-and-procedures.md#timeker_allocation_guard) | — |

## cases

Mapped class `Case`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L233).

18 columns; 23 catalog constraints; 7 indexes; 3 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `client_id` | `uuid` | No | FK | — | — | — | — |
| 5 | `project_id` | `uuid` | No | FK | — | — | — | — |
| 6 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 7 | `legacy_number` | `character varying(30)` | Yes | — | — | — | — | — |
| 8 | `title` | `character varying(200)` | No | — | — | — | — | — |
| 9 | `description` | `text` | Yes | — | — | — | — | — |
| 10 | `status` | `character varying(20)` | No | — | — | — | `'Open'` | — |
| 11 | `opened_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 12 | `resolved_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 13 | `closed_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 14 | `archived_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 15 | `version` | `integer` | No | — | — | — | `1` | — |
| 16 | `number` | `bigint` | No | UNIQUE | — | `a` | — | — |
| 17 | `case_type` | `character varying(20)` | No | — | — | — | — | — |
| 18 | `flexfields` | `jsonb` | No | — | `'{}'::jsonb` | — | `Python callable: dict` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `case_description_length` | CHECK | `CHECK (description IS NULL OR char_length(description) <= 500)` | No |
| `case_number_range` | CHECK | `CHECK (number >= 10001)` | No |
| `case_type_allowed` | CHECK | `CHECK (case_type::text = ANY (ARRAY['Issue'::character varying, 'Consulting'::character varying, 'Dev Services'::character varying, 'Design'::character varying, 'Services'::character varying]::text[]))` | No |
| `cases_case_type_not_null` | NOT NULL | `NOT NULL case_type` | No |
| `cases_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `cases_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `cases_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `cases_flexfields_not_null` | NOT NULL | `NOT NULL flexfields` | No |
| `cases_flexfields_valid` | CHECK | `CHECK (jsonb_typeof(flexfields) = 'object'::text AND (flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb AND (NOT flexfields ? 'flexfield1'::text OR (flexfields -> 'flexfield1'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield1'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield1'::text) <= 250) AND (NOT flexfields ? 'flexfield2'::text OR (flexfields -> 'flexfield2'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield2'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield2'::text) <= 250) AND (NOT flexfields ? 'flexfield3'::text OR (flexfields -> 'flexfield3'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield3'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield3'::text) <= 250) AND (NOT flexfields ? 'flexfield4'::text OR (flexfields -> 'flexfield4'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield4'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield4'::text) <= 250) AND (NOT flexfields ? 'flexfield5'::text OR (flexfields -> 'flexfield5'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield5'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield5'::text) <= 250) AND (NOT flexfields ? 'flexfield6'::text OR (flexfields -> 'flexfield6'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield6'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield6'::text) <= 250) AND (NOT flexfields ? 'flexfield7'::text OR (flexfields -> 'flexfield7'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield7'::text) = 'string'::text AND (flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text) AND (NOT flexfields ? 'flexfield8'::text OR (flexfields -> 'flexfield8'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield8'::text) = 'string'::text AND (flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))` | No |
| `cases_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `cases_number_key` | UNIQUE | `UNIQUE (number)` | No |
| `cases_number_not_null` | NOT NULL | `NOT NULL number` | No |
| `cases_opened_at_not_null` | NOT NULL | `NOT NULL opened_at` | No |
| `cases_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `cases_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `cases_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `cases_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `cases_project_id_not_null` | NOT NULL | `NOT NULL project_id` | No |
| `cases_status_check` | CHECK | `CHECK (status::text = ANY (ARRAY['Open'::character varying, 'In progress'::character varying, 'Waiting'::character varying, 'Resolved'::character varying, 'Closed'::character varying]::text[]))` | No |
| `cases_status_not_null` | NOT NULL | `NOT NULL status` | No |
| `cases_title_not_null` | NOT NULL | `NOT NULL title` | No |
| `cases_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `cases_version_not_null` | NOT NULL | `NOT NULL version` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `cases_number_key` | `CREATE UNIQUE INDEX cases_number_key ON timeker_reference.cases USING btree (number)` |
| `cases_pkey` | `CREATE UNIQUE INDEX cases_pkey ON timeker_reference.cases USING btree (id)` |
| `ix_cases_archived_at` | `CREATE INDEX ix_cases_archived_at ON timeker_reference.cases USING btree (archived_at)` |
| `ix_cases_client_id` | `CREATE INDEX ix_cases_client_id ON timeker_reference.cases USING btree (client_id)` |
| `ix_cases_owner_id` | `CREATE INDEX ix_cases_owner_id ON timeker_reference.cases USING btree (owner_id)` |
| `ix_cases_project_id` | `CREATE INDEX ix_cases_project_id ON timeker_reference.cases USING btree (project_id)` |
| `ix_cases_status` | `CREATE INDEX ix_cases_status ON timeker_reference.cases USING btree (status)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `case_archive_status_guard` | [timeker_case_archive_status_guard](04-functions-and-procedures.md#timeker_case_archive_status_guard) | — |
| `case_guard` | [timeker_case_guard](04-functions-and-procedures.md#timeker_case_guard) | — |
| `commercial_case_guard` | [timeker_commercial_case_guard](04-functions-and-procedures.md#timeker_commercial_case_guard) | — |

## client_drafts

Mapped class `ClientDraft`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L79).

6 columns; 8 catalog constraints; 2 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 5 | `payload` | `jsonb` | No | — | — | — | — | — |
| 6 | `version` | `integer` | No | — | — | — | `1` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `client_drafts_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `client_drafts_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `client_drafts_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `client_drafts_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `client_drafts_payload_not_null` | NOT NULL | `NOT NULL payload` | No |
| `client_drafts_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `client_drafts_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `client_drafts_version_not_null` | NOT NULL | `NOT NULL version` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `client_drafts_pkey` | `CREATE UNIQUE INDEX client_drafts_pkey ON timeker_reference.client_drafts USING btree (id)` |
| `ix_client_drafts_owner_id` | `CREATE INDEX ix_client_drafts_owner_id ON timeker_reference.client_drafts USING btree (owner_id)` |

### Application triggers

None.

## client_source_references

Mapped class `ClientSourceReference`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L153).

10 columns; 12 catalog constraints; 2 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `client_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `uploaded_by` | `uuid` | No | FK | — | — | — | — |
| 6 | `filename` | `character varying(180)` | No | — | — | — | — | — |
| 7 | `media_type` | `character varying(80)` | No | — | — | — | — | — |
| 8 | `content` | `bytea` | Yes | — | — | — | — | — |
| 9 | `url` | `text` | Yes | — | — | — | — | — |
| 10 | `sha256` | `character varying(64)` | Yes | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `client_source_payload` | CHECK | `CHECK (content IS NOT NULL AND url IS NULL AND octet_length(content) >= 1 AND octet_length(content) <= 5242880 AND sha256::text ~ '^[0-9a-f]{64}$'::text OR content IS NULL AND url IS NOT NULL AND length(url) >= 1 AND length(url) <= 2048 AND sha256 IS NULL)` | No |
| `client_source_references_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `client_source_references_client_id_key` | UNIQUE | `UNIQUE (client_id)` | No |
| `client_source_references_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `client_source_references_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `client_source_references_filename_not_null` | NOT NULL | `NOT NULL filename` | No |
| `client_source_references_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `client_source_references_media_type_not_null` | NOT NULL | `NOT NULL media_type` | No |
| `client_source_references_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `client_source_references_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `client_source_references_uploaded_by_fkey` | FOREIGN KEY | `FOREIGN KEY (uploaded_by) REFERENCES users(id)` | No |
| `client_source_references_uploaded_by_not_null` | NOT NULL | `NOT NULL uploaded_by` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `client_source_references_client_id_key` | `CREATE UNIQUE INDEX client_source_references_client_id_key ON timeker_reference.client_source_references USING btree (client_id)` |
| `client_source_references_pkey` | `CREATE UNIQUE INDEX client_source_references_pkey ON timeker_reference.client_source_references USING btree (id)` |

### Application triggers

None.

## clients

Mapped class `Client`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L69).

20 columns; 26 catalog constraints; 5 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `code` | `character varying(30)` | No | UNIQUE | — | — | — | — |
| 2 | `legal_name` | `character varying(200)` | No | — | — | — | — | — |
| 3 | `display_name` | `character varying(120)` | No | — | — | — | — | — |
| 4 | `country_code` | `character varying(2)` | No | — | — | — | — | — |
| 5 | `status` | `character varying(20)` | No | — | `'draft'::character varying` | — | `'draft'` | — |
| 6 | `timezone` | `character varying(80)` | No | — | — | — | `'UTC'` | — |
| 7 | `language` | `character varying(2)` | No | — | — | — | `'en'` | — |
| 8 | `currency` | `character varying(3)` | No | — | — | — | `'USD'` | — |
| 9 | `rate` | `numeric(14,2)` | No | — | — | — | — | — |
| 10 | `weekly_limit_minutes` | `integer` | Yes | — | — | — | — | — |
| 11 | `payment_terms_days` | `integer` | No | — | — | — | `15` | — |
| 12 | `profile` | `jsonb` | No | — | — | — | `Python callable: dict` | — |
| 13 | `contract` | `jsonb` | No | — | — | — | `Python callable: dict` | — |
| 14 | `archived_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 15 | `version` | `integer` | No | — | — | — | `1` | — |
| 16 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 17 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 18 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 19 | `object_id` | `bigint` | No | UNIQUE | — | `a` | — | — |
| 20 | `flexfields` | `jsonb` | No | — | `'{}'::jsonb` | — | `Python callable: dict` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `client_status_allowed` | CHECK | `CHECK (status::text = ANY (ARRAY['draft'::character varying, 'active'::character varying, 'archived'::character varying]::text[]))` | No |
| `clients_check` | CHECK | `CHECK (rate >= 0::numeric AND payment_terms_days >= 0)` | No |
| `clients_code_key` | UNIQUE | `UNIQUE (code)` | No |
| `clients_code_not_null` | NOT NULL | `NOT NULL code` | No |
| `clients_contract_not_null` | NOT NULL | `NOT NULL contract` | No |
| `clients_country_code_not_null` | NOT NULL | `NOT NULL country_code` | No |
| `clients_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `clients_currency_not_null` | NOT NULL | `NOT NULL currency` | No |
| `clients_display_name_not_null` | NOT NULL | `NOT NULL display_name` | No |
| `clients_flexfields_not_null` | NOT NULL | `NOT NULL flexfields` | No |
| `clients_flexfields_valid` | CHECK | `CHECK (jsonb_typeof(flexfields) = 'object'::text AND (flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb AND (NOT flexfields ? 'flexfield1'::text OR (flexfields -> 'flexfield1'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield1'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield1'::text) <= 250) AND (NOT flexfields ? 'flexfield2'::text OR (flexfields -> 'flexfield2'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield2'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield2'::text) <= 250) AND (NOT flexfields ? 'flexfield3'::text OR (flexfields -> 'flexfield3'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield3'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield3'::text) <= 250) AND (NOT flexfields ? 'flexfield4'::text OR (flexfields -> 'flexfield4'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield4'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield4'::text) <= 250) AND (NOT flexfields ? 'flexfield5'::text OR (flexfields -> 'flexfield5'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield5'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield5'::text) <= 250) AND (NOT flexfields ? 'flexfield6'::text OR (flexfields -> 'flexfield6'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield6'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield6'::text) <= 250) AND (NOT flexfields ? 'flexfield7'::text OR (flexfields -> 'flexfield7'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield7'::text) = 'string'::text AND (flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text) AND (NOT flexfields ? 'flexfield8'::text OR (flexfields -> 'flexfield8'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield8'::text) = 'string'::text AND (flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))` | No |
| `clients_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `clients_language_check` | CHECK | `CHECK (language::text = ANY (ARRAY['es'::character varying, 'en'::character varying]::text[]))` | No |
| `clients_language_not_null` | NOT NULL | `NOT NULL language` | No |
| `clients_legal_name_not_null` | NOT NULL | `NOT NULL legal_name` | No |
| `clients_object_id_key` | UNIQUE | `UNIQUE (object_id)` | No |
| `clients_object_id_not_null` | NOT NULL | `NOT NULL object_id` | No |
| `clients_payment_terms_days_not_null` | NOT NULL | `NOT NULL payment_terms_days` | No |
| `clients_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `clients_profile_not_null` | NOT NULL | `NOT NULL profile` | No |
| `clients_rate_not_null` | NOT NULL | `NOT NULL rate` | No |
| `clients_status_not_null` | NOT NULL | `NOT NULL status` | No |
| `clients_timezone_not_null` | NOT NULL | `NOT NULL timezone` | No |
| `clients_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `clients_version_not_null` | NOT NULL | `NOT NULL version` | No |
| `clients_weekly_limit_minutes_check` | CHECK | `CHECK (weekly_limit_minutes IS NULL OR weekly_limit_minutes >= 0 AND weekly_limit_minutes <= 10080)` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `clients_code_key` | `CREATE UNIQUE INDEX clients_code_key ON timeker_reference.clients USING btree (code)` |
| `clients_object_id_key` | `CREATE UNIQUE INDEX clients_object_id_key ON timeker_reference.clients USING btree (object_id)` |
| `clients_pkey` | `CREATE UNIQUE INDEX clients_pkey ON timeker_reference.clients USING btree (id)` |
| `ix_clients_display_name` | `CREATE INDEX ix_clients_display_name ON timeker_reference.clients USING btree (display_name)` |
| `ix_clients_status` | `CREATE INDEX ix_clients_status ON timeker_reference.clients USING btree (status)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |

## contact_attempts

Mapped class `ContactAttempt`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L33).

7 columns; 9 catalog constraints; 2 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | — | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 3 | `session_digest` | `character varying(64)` | No | — | — | — | — | — |
| 4 | `address_digest` | `character varying(64)` | No | — | — | — | — | — |
| 5 | `network_digest` | `character varying(64)` | No | — | — | — | — | — |
| 6 | `payload_digest` | `character varying(64)` | No | — | — | — | — | — |
| 7 | `status` | `character varying(12)` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `contact_attempts_address_digest_not_null` | NOT NULL | `NOT NULL address_digest` | No |
| `contact_attempts_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `contact_attempts_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `contact_attempts_network_digest_not_null` | NOT NULL | `NOT NULL network_digest` | No |
| `contact_attempts_payload_digest_not_null` | NOT NULL | `NOT NULL payload_digest` | No |
| `contact_attempts_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `contact_attempts_session_digest_not_null` | NOT NULL | `NOT NULL session_digest` | No |
| `contact_attempts_status_check` | CHECK | `CHECK (status::text = ANY (ARRAY['reserved'::character varying, 'accepted'::character varying, 'uncertain'::character varying]::text[]))` | No |
| `contact_attempts_status_not_null` | NOT NULL | `NOT NULL status` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `contact_attempts_pkey` | `CREATE UNIQUE INDEX contact_attempts_pkey ON timeker_reference.contact_attempts USING btree (id)` |
| `ix_contact_attempts_created_at` | `CREATE INDEX ix_contact_attempts_created_at ON timeker_reference.contact_attempts USING btree (created_at)` |

### Application triggers

None.

## contacts

Mapped class `Contact`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L99).

12 columns; 11 catalog constraints; 2 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `client_id` | `uuid` | No | FK | — | — | — | — |
| 2 | `name` | `character varying(100)` | No | — | — | — | — | — |
| 3 | `title` | `character varying(100)` | Yes | — | — | — | — | — |
| 4 | `email` | `character varying(254)` | Yes | — | — | — | — | — |
| 5 | `phone` | `character varying(50)` | Yes | — | — | — | — | — |
| 6 | `contact_type` | `character varying(40)` | No | — | — | — | `'general'` | — |
| 7 | `may_request_work` | `boolean` | No | — | — | — | `False` | — |
| 8 | `may_approve_hours` | `boolean` | No | — | — | — | `False` | — |
| 9 | `active` | `boolean` | No | — | — | — | `True` | — |
| 10 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 11 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 12 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `contacts_active_not_null` | NOT NULL | `NOT NULL active` | No |
| `contacts_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `contacts_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `contacts_contact_type_not_null` | NOT NULL | `NOT NULL contact_type` | No |
| `contacts_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `contacts_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `contacts_may_approve_hours_not_null` | NOT NULL | `NOT NULL may_approve_hours` | No |
| `contacts_may_request_work_not_null` | NOT NULL | `NOT NULL may_request_work` | No |
| `contacts_name_not_null` | NOT NULL | `NOT NULL name` | No |
| `contacts_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `contacts_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `contacts_pkey` | `CREATE UNIQUE INDEX contacts_pkey ON timeker_reference.contacts USING btree (id)` |
| `ix_contacts_client_id` | `CREATE INDEX ix_contacts_client_id ON timeker_reference.contacts USING btree (client_id)` |

### Application triggers

None.

## credit_memos

Mapped class `CreditMemo`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/credit_memo_models.py#L14).

15 columns; 25 catalog constraints; 3 indexes; 2 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `invoice_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `number` | `character varying(60)` | No | UNIQUE | — | — | — | — |
| 6 | `actor_id` | `uuid` | No | FK | — | — | — | — |
| 7 | `issue_date` | `date` | No | — | — | — | — | — |
| 8 | `currency` | `character varying(3)` | No | — | — | — | — | — |
| 9 | `total` | `numeric(14,2)` | No | — | — | — | — | — |
| 10 | `reason` | `text` | No | — | — | — | — | — |
| 11 | `snapshot` | `jsonb` | No | — | — | — | — | — |
| 12 | `filename` | `character varying(180)` | No | — | — | — | — | — |
| 13 | `pdf_bytes` | `bytea` | No | — | — | — | — | — |
| 14 | `sha256` | `character varying(64)` | No | — | — | — | — | — |
| 15 | `renderer_version` | `character varying(40)` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `credit_memo_invoice_check` | CONSTRAINT TRIGGER | `TRIGGER DEFERRABLE INITIALLY DEFERRED` | Initially deferred |
| `credit_memos_actor_id_fkey` | FOREIGN KEY | `FOREIGN KEY (actor_id) REFERENCES users(id)` | No |
| `credit_memos_actor_id_not_null` | NOT NULL | `NOT NULL actor_id` | No |
| `credit_memos_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `credit_memos_currency_not_null` | NOT NULL | `NOT NULL currency` | No |
| `credit_memos_filename_not_null` | NOT NULL | `NOT NULL filename` | No |
| `credit_memos_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `credit_memos_invoice_id_fkey` | FOREIGN KEY | `FOREIGN KEY (invoice_id) REFERENCES invoices(id)` | No |
| `credit_memos_invoice_id_key` | UNIQUE | `UNIQUE (invoice_id)` | No |
| `credit_memos_invoice_id_not_null` | NOT NULL | `NOT NULL invoice_id` | No |
| `credit_memos_issue_date_not_null` | NOT NULL | `NOT NULL issue_date` | No |
| `credit_memos_number_key` | UNIQUE | `UNIQUE (number)` | No |
| `credit_memos_number_not_null` | NOT NULL | `NOT NULL number` | No |
| `credit_memos_pdf_bytes_check` | CHECK | `CHECK (octet_length(pdf_bytes) > 0)` | No |
| `credit_memos_pdf_bytes_not_null` | NOT NULL | `NOT NULL pdf_bytes` | No |
| `credit_memos_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `credit_memos_reason_check` | CHECK | `CHECK (length(btrim(reason)) >= 1 AND length(btrim(reason)) <= 2000)` | No |
| `credit_memos_reason_not_null` | NOT NULL | `NOT NULL reason` | No |
| `credit_memos_renderer_version_not_null` | NOT NULL | `NOT NULL renderer_version` | No |
| `credit_memos_sha256_check` | CHECK | `CHECK (sha256::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `credit_memos_sha256_not_null` | NOT NULL | `NOT NULL sha256` | No |
| `credit_memos_snapshot_not_null` | NOT NULL | `NOT NULL snapshot` | No |
| `credit_memos_total_check` | CHECK | `CHECK (total >= 0::numeric)` | No |
| `credit_memos_total_not_null` | NOT NULL | `NOT NULL total` | No |
| `credit_memos_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `credit_memos_invoice_id_key` | `CREATE UNIQUE INDEX credit_memos_invoice_id_key ON timeker_reference.credit_memos USING btree (invoice_id)` |
| `credit_memos_number_key` | `CREATE UNIQUE INDEX credit_memos_number_key ON timeker_reference.credit_memos USING btree (number)` |
| `credit_memos_pkey` | `CREATE UNIQUE INDEX credit_memos_pkey ON timeker_reference.credit_memos USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `credit_memo_guard` | [timeker_credit_memo_guard](04-functions-and-procedures.md#timeker_credit_memo_guard) | — |
| `credit_memo_invoice_check` | [timeker_credit_memo_final_guard](04-functions-and-procedures.md#timeker_credit_memo_final_guard) | `credit_memo_invoice_check` |

## email_auth_challenges

Mapped class `EmailAuthChallenge`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L42).

10 columns; 16 catalog constraints; 1 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 3 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 4 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 5 | `session_digest` | `character varying(64)` | No | — | — | — | — | — |
| 6 | `intent` | `character varying(12)` | No | — | — | — | — | — |
| 7 | `offer` | `character varying(20)` | No | — | — | — | — | — |
| 8 | `state` | `character varying(12)` | No | — | — | — | — | — |
| 9 | `attempts` | `integer` | No | — | — | — | `0` | — |
| 10 | `expires_at` | `timestamp with time zone` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `email_auth_challenges_attempts_check` | CHECK | `CHECK (attempts >= 0 AND attempts <= 6)` | No |
| `email_auth_challenges_attempts_not_null` | NOT NULL | `NOT NULL attempts` | No |
| `email_auth_challenges_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `email_auth_challenges_expires_at_not_null` | NOT NULL | `NOT NULL expires_at` | No |
| `email_auth_challenges_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `email_auth_challenges_intent_check` | CHECK | `CHECK (intent::text = ANY (ARRAY['signin'::character varying, 'signup'::character varying, 'link'::character varying]::text[]))` | No |
| `email_auth_challenges_intent_not_null` | NOT NULL | `NOT NULL intent` | No |
| `email_auth_challenges_offer_not_null` | NOT NULL | `NOT NULL offer` | No |
| `email_auth_challenges_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `email_auth_challenges_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `email_auth_challenges_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `email_auth_challenges_session_digest_check` | CHECK | `CHECK (session_digest::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `email_auth_challenges_session_digest_not_null` | NOT NULL | `NOT NULL session_digest` | No |
| `email_auth_challenges_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['reserved'::character varying, 'ready'::character varying, 'verifying'::character varying, 'consumed'::character varying, 'failed'::character varying]::text[]))` | No |
| `email_auth_challenges_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `email_auth_challenges_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `email_auth_challenges_pkey` | `CREATE UNIQUE INDEX email_auth_challenges_pkey ON timeker_reference.email_auth_challenges USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `email_challenge_history` | [timeker_registration_history_guard](04-functions-and-procedures.md#timeker_registration_history_guard) | — |

## integration_codes

Mapped class `IntegrationCode`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L33).

11 columns; 13 catalog constraints; 3 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `grant_id` | `uuid` | No | FK | — | — | — | — |
| 5 | `digest` | `character varying(64)` | No | UNIQUE | — | — | — | — |
| 6 | `redirect_uri` | `character varying(1000)` | No | — | — | — | — | — |
| 7 | `code_challenge` | `character varying(128)` | No | — | — | — | — | — |
| 8 | `code_challenge_method` | `character varying(10)` | No | — | — | — | `'S256'` | — |
| 9 | `scope` | `character varying(500)` | No | — | — | — | — | — |
| 10 | `expires_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 11 | `used_at` | `timestamp with time zone` | Yes | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `integration_codes_code_challenge_method_not_null` | NOT NULL | `NOT NULL code_challenge_method` | No |
| `integration_codes_code_challenge_not_null` | NOT NULL | `NOT NULL code_challenge` | No |
| `integration_codes_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `integration_codes_digest_key` | UNIQUE | `UNIQUE (digest)` | No |
| `integration_codes_digest_not_null` | NOT NULL | `NOT NULL digest` | No |
| `integration_codes_expires_at_not_null` | NOT NULL | `NOT NULL expires_at` | No |
| `integration_codes_grant_id_fkey` | FOREIGN KEY | `FOREIGN KEY (grant_id) REFERENCES integration_grants(id)` | No |
| `integration_codes_grant_id_not_null` | NOT NULL | `NOT NULL grant_id` | No |
| `integration_codes_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `integration_codes_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `integration_codes_redirect_uri_not_null` | NOT NULL | `NOT NULL redirect_uri` | No |
| `integration_codes_scope_not_null` | NOT NULL | `NOT NULL scope` | No |
| `integration_codes_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `integration_codes_digest_key` | `CREATE UNIQUE INDEX integration_codes_digest_key ON timeker_reference.integration_codes USING btree (digest)` |
| `integration_codes_pkey` | `CREATE UNIQUE INDEX integration_codes_pkey ON timeker_reference.integration_codes USING btree (id)` |
| `ix_integration_codes_grant_id` | `CREATE INDEX ix_integration_codes_grant_id ON timeker_reference.integration_codes USING btree (grant_id)` |

### Application triggers

None.

## integration_grants

Mapped class `IntegrationGrant`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L21).

11 columns; 12 catalog constraints; 2 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 5 | `tenant_id` | `uuid` | No | — | — | — | — | — |
| 6 | `client_id` | `character varying(120)` | No | — | — | — | — | — |
| 7 | `label` | `character varying(120)` | No | — | — | — | — | — |
| 8 | `scopes` | `jsonb` | No | — | — | — | — | — |
| 9 | `resource` | `character varying(300)` | No | — | — | — | — | — |
| 10 | `expires_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 11 | `revoked_at` | `timestamp with time zone` | Yes | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `integration_grants_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `integration_grants_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `integration_grants_expires_at_not_null` | NOT NULL | `NOT NULL expires_at` | No |
| `integration_grants_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `integration_grants_label_not_null` | NOT NULL | `NOT NULL label` | No |
| `integration_grants_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `integration_grants_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `integration_grants_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `integration_grants_resource_not_null` | NOT NULL | `NOT NULL resource` | No |
| `integration_grants_scopes_not_null` | NOT NULL | `NOT NULL scopes` | No |
| `integration_grants_tenant_id_not_null` | NOT NULL | `NOT NULL tenant_id` | No |
| `integration_grants_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `integration_grants_pkey` | `CREATE UNIQUE INDEX integration_grants_pkey ON timeker_reference.integration_grants USING btree (id)` |
| `ix_integration_grants_owner_id` | `CREATE INDEX ix_integration_grants_owner_id ON timeker_reference.integration_grants USING btree (owner_id)` |

### Application triggers

None.

## integration_operations

Mapped class `IntegrationOperation`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L69).

8 columns; 11 catalog constraints; 3 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `grant_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `key_digest` | `character varying(64)` | No | UNIQUE | — | — | — | — |
| 6 | `payload_digest` | `character varying(64)` | No | — | — | — | — | — |
| 7 | `tool` | `character varying(60)` | No | — | — | — | — | — |
| 8 | `result` | `jsonb` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `integration_operations_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `integration_operations_grant_id_fkey` | FOREIGN KEY | `FOREIGN KEY (grant_id) REFERENCES integration_grants(id)` | No |
| `integration_operations_grant_id_key_digest_key` | UNIQUE | `UNIQUE (grant_id, key_digest)` | No |
| `integration_operations_grant_id_not_null` | NOT NULL | `NOT NULL grant_id` | No |
| `integration_operations_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `integration_operations_key_digest_not_null` | NOT NULL | `NOT NULL key_digest` | No |
| `integration_operations_payload_digest_not_null` | NOT NULL | `NOT NULL payload_digest` | No |
| `integration_operations_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `integration_operations_result_not_null` | NOT NULL | `NOT NULL result` | No |
| `integration_operations_tool_not_null` | NOT NULL | `NOT NULL tool` | No |
| `integration_operations_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `integration_operations_grant_id_key_digest_key` | `CREATE UNIQUE INDEX integration_operations_grant_id_key_digest_key ON timeker_reference.integration_operations USING btree (grant_id, key_digest)` |
| `integration_operations_pkey` | `CREATE UNIQUE INDEX integration_operations_pkey ON timeker_reference.integration_operations USING btree (id)` |
| `ix_integration_operations_grant_id` | `CREATE INDEX ix_integration_operations_grant_id ON timeker_reference.integration_operations USING btree (grant_id)` |

### Application triggers

None.

## integration_tokens

Mapped class `IntegrationToken`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L51).

10 columns; 13 catalog constraints; 4 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `grant_id` | `uuid` | No | FK | — | — | — | — |
| 5 | `digest` | `character varying(64)` | No | UNIQUE | — | — | — | — |
| 6 | `kind` | `character varying(10)` | No | — | — | — | — | — |
| 7 | `scope` | `character varying(500)` | No | — | — | — | — | — |
| 8 | `client_id` | `character varying(120)` | No | — | — | — | — | — |
| 9 | `expires_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 10 | `used_at` | `timestamp with time zone` | Yes | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `integration_tokens_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `integration_tokens_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `integration_tokens_digest_key` | UNIQUE | `UNIQUE (digest)` | No |
| `integration_tokens_digest_not_null` | NOT NULL | `NOT NULL digest` | No |
| `integration_tokens_expires_at_not_null` | NOT NULL | `NOT NULL expires_at` | No |
| `integration_tokens_grant_id_fkey` | FOREIGN KEY | `FOREIGN KEY (grant_id) REFERENCES integration_grants(id)` | No |
| `integration_tokens_grant_id_not_null` | NOT NULL | `NOT NULL grant_id` | No |
| `integration_tokens_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `integration_tokens_kind_check` | CHECK | `CHECK (kind::text = ANY (ARRAY['access'::character varying, 'refresh'::character varying]::text[]))` | No |
| `integration_tokens_kind_not_null` | NOT NULL | `NOT NULL kind` | No |
| `integration_tokens_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `integration_tokens_scope_not_null` | NOT NULL | `NOT NULL scope` | No |
| `integration_tokens_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `integration_tokens_digest_key` | `CREATE UNIQUE INDEX integration_tokens_digest_key ON timeker_reference.integration_tokens USING btree (digest)` |
| `integration_tokens_pkey` | `CREATE UNIQUE INDEX integration_tokens_pkey ON timeker_reference.integration_tokens USING btree (id)` |
| `ix_integration_tokens_expires_at` | `CREATE INDEX ix_integration_tokens_expires_at ON timeker_reference.integration_tokens USING btree (expires_at)` |
| `ix_integration_tokens_grant_id` | `CREATE INDEX ix_integration_tokens_grant_id ON timeker_reference.integration_tokens USING btree (grant_id)` |

### Application triggers

None.

## invoice_artifacts

Mapped class `Artifact`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L371).

8 columns; 11 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `invoice_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `filename` | `character varying(150)` | No | — | — | — | — | — |
| 3 | `pdf_bytes` | `bytea` | No | — | — | — | — | — |
| 4 | `sha256` | `character varying(64)` | No | — | — | — | — | — |
| 5 | `renderer_version` | `character varying(40)` | No | — | — | — | — | — |
| 6 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 7 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 8 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `invoice_artifacts_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `invoice_artifacts_filename_not_null` | NOT NULL | `NOT NULL filename` | No |
| `invoice_artifacts_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `invoice_artifacts_invoice_id_fkey` | FOREIGN KEY | `FOREIGN KEY (invoice_id) REFERENCES invoices(id)` | No |
| `invoice_artifacts_invoice_id_key` | UNIQUE | `UNIQUE (invoice_id)` | No |
| `invoice_artifacts_invoice_id_not_null` | NOT NULL | `NOT NULL invoice_id` | No |
| `invoice_artifacts_pdf_bytes_not_null` | NOT NULL | `NOT NULL pdf_bytes` | No |
| `invoice_artifacts_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `invoice_artifacts_renderer_version_not_null` | NOT NULL | `NOT NULL renderer_version` | No |
| `invoice_artifacts_sha256_not_null` | NOT NULL | `NOT NULL sha256` | No |
| `invoice_artifacts_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `invoice_artifacts_invoice_id_key` | `CREATE UNIQUE INDEX invoice_artifacts_invoice_id_key ON timeker_reference.invoice_artifacts USING btree (invoice_id)` |
| `invoice_artifacts_pkey` | `CREATE UNIQUE INDEX invoice_artifacts_pkey ON timeker_reference.invoice_artifacts USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `artifact_guard` | [timeker_artifact_guard](04-functions-and-procedures.md#timeker_artifact_guard) | — |

## invoice_lines

Mapped class `InvoiceLine`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L341).

13 columns; 17 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `invoice_id` | `uuid` | No | FK | — | — | — | — |
| 2 | `project_id` | `uuid` | No | FK | — | — | — | — |
| 3 | `description` | `character varying(200)` | No | — | — | — | — | — |
| 4 | `service_period` | `character varying(40)` | No | — | — | — | — | — |
| 5 | `quantity_minutes` | `integer` | No | — | — | — | — | — |
| 6 | `unit_rate` | `numeric(14,2)` | No | — | — | — | — | — |
| 7 | `amount` | `numeric(14,2)` | No | — | — | — | — | — |
| 8 | `sort_order` | `integer` | No | — | — | — | — | — |
| 9 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 10 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 11 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 12 | `basis` | `character varying(20)` | No | — | `'time'::character varying` | — | `'time'` | — |
| 13 | `charge_metadata` | `jsonb` | No | — | `'{}'::jsonb` | — | `Python callable: dict` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `invoice_line_basis_values` | CHECK | `CHECK (amount >= 0::numeric AND amount <= 9999999999.99 AND (basis::text = 'time'::text AND quantity_minutes > 0 AND unit_rate >= 0::numeric OR (basis::text = ANY (ARRAY['fixed_fee'::character varying, 'manual_extra'::character varying]::text[])) AND quantity_minutes = 0 AND unit_rate = 0::numeric))` | No |
| `invoice_lines_amount_not_null` | NOT NULL | `NOT NULL amount` | No |
| `invoice_lines_basis_not_null` | NOT NULL | `NOT NULL basis` | No |
| `invoice_lines_charge_metadata_not_null` | NOT NULL | `NOT NULL charge_metadata` | No |
| `invoice_lines_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `invoice_lines_description_not_null` | NOT NULL | `NOT NULL description` | No |
| `invoice_lines_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `invoice_lines_invoice_id_fkey` | FOREIGN KEY | `FOREIGN KEY (invoice_id) REFERENCES invoices(id)` | No |
| `invoice_lines_invoice_id_not_null` | NOT NULL | `NOT NULL invoice_id` | No |
| `invoice_lines_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `invoice_lines_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `invoice_lines_project_id_not_null` | NOT NULL | `NOT NULL project_id` | No |
| `invoice_lines_quantity_minutes_not_null` | NOT NULL | `NOT NULL quantity_minutes` | No |
| `invoice_lines_service_period_not_null` | NOT NULL | `NOT NULL service_period` | No |
| `invoice_lines_sort_order_not_null` | NOT NULL | `NOT NULL sort_order` | No |
| `invoice_lines_unit_rate_not_null` | NOT NULL | `NOT NULL unit_rate` | No |
| `invoice_lines_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `invoice_lines_pkey` | `CREATE UNIQUE INDEX invoice_lines_pkey ON timeker_reference.invoice_lines USING btree (id)` |
| `ix_invoice_lines_invoice_id` | `CREATE INDEX ix_invoice_lines_invoice_id ON timeker_reference.invoice_lines USING btree (invoice_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `line_guard` | [timeker_line_guard](04-functions-and-procedures.md#timeker_line_guard) | — |

## invoice_time_entries

Mapped class `Reservation`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L365).

2 columns; 5 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `entry_id` | `uuid` | No | FK, PK | — | — | — | — |
| 2 | `invoice_id` | `uuid` | No | FK | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `invoice_time_entries_entry_id_fkey` | FOREIGN KEY | `FOREIGN KEY (entry_id) REFERENCES time_entries(id)` | No |
| `invoice_time_entries_entry_id_not_null` | NOT NULL | `NOT NULL entry_id` | No |
| `invoice_time_entries_invoice_id_fkey` | FOREIGN KEY | `FOREIGN KEY (invoice_id) REFERENCES invoices(id)` | No |
| `invoice_time_entries_invoice_id_not_null` | NOT NULL | `NOT NULL invoice_id` | No |
| `invoice_time_entries_pkey` | PRIMARY KEY | `PRIMARY KEY (entry_id)` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `invoice_time_entries_pkey` | `CREATE UNIQUE INDEX invoice_time_entries_pkey ON timeker_reference.invoice_time_entries USING btree (entry_id)` |
| `ix_invoice_time_entries_invoice_id` | `CREATE INDEX ix_invoice_time_entries_invoice_id ON timeker_reference.invoice_time_entries USING btree (invoice_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `internal_billing_guard` | [timeker_internal_billing_guard](04-functions-and-procedures.md#timeker_internal_billing_guard) | — |

## invoices

Mapped class `Invoice`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L280).

25 columns; 30 catalog constraints; 9 indexes; 4 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `client_id` | `uuid` | No | FK | — | — | — | — |
| 2 | `number` | `character varying(60)` | No | UNIQUE | — | — | — | — |
| 3 | `period_start` | `date` | No | — | — | — | — | — |
| 4 | `period_end` | `date` | No | — | — | — | — | — |
| 5 | `issue_date` | `date` | Yes | — | — | — | — | — |
| 6 | `delivered_at` | `date` | Yes | — | — | — | — | — |
| 7 | `due_date` | `date` | Yes | — | — | — | — | — |
| 8 | `status` | `character varying(20)` | No | — | — | — | `'Draft'` | — |
| 9 | `currency` | `character varying(3)` | No | — | — | — | — | — |
| 10 | `subtotal` | `numeric(14,2)` | No | — | — | — | — | — |
| 11 | `adjustments` | `jsonb` | No | — | — | — | `Python callable: dict` | — |
| 12 | `total` | `numeric(14,2)` | No | — | — | — | — | — |
| 13 | `snapshot` | `jsonb` | Yes | — | — | — | — | — |
| 14 | `issued_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 15 | `voided_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 16 | `void_reason` | `text` | Yes | — | — | — | — | — |
| 17 | `version` | `integer` | No | — | — | — | `1` | — |
| 18 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 19 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 20 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 21 | `fixed_fee_project_id` | `uuid` | Yes | FK | — | — | — | — |
| 22 | `manual_extra_project_id` | `uuid` | Yes | FK | — | — | — | — |
| 23 | `manual_extra_reference` | `character varying(200)` | Yes | — | — | — | — | — |
| 24 | `object_id` | `bigint` | No | UNIQUE | — | `a` | — | — |
| 25 | `flexfields` | `jsonb` | No | — | `'{}'::jsonb` | — | `Python callable: dict` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `fk_invoices_fixed_fee_project_id` | FOREIGN KEY | `FOREIGN KEY (fixed_fee_project_id) REFERENCES projects(id)` | No |
| `fk_invoices_manual_extra_project_id` | FOREIGN KEY | `FOREIGN KEY (manual_extra_project_id) REFERENCES projects(id)` | No |
| `invoice_credit_memo_check` | CONSTRAINT TRIGGER | `TRIGGER DEFERRABLE INITIALLY DEFERRED` | Initially deferred |
| `invoice_extra_reference_pair` | CHECK | `CHECK (manual_extra_project_id IS NULL AND manual_extra_reference IS NULL OR manual_extra_project_id IS NOT NULL AND manual_extra_reference IS NOT NULL AND length(btrim(manual_extra_reference::text)) > 0)` | No |
| `invoice_single_charge_kind` | CHECK | `CHECK (fixed_fee_project_id IS NULL OR manual_extra_project_id IS NULL)` | No |
| `invoices_adjustments_not_null` | NOT NULL | `NOT NULL adjustments` | No |
| `invoices_check` | CHECK | `CHECK ((status::text <> ALL (ARRAY['Issued'::character varying, 'Sent'::character varying]::text[])) OR snapshot IS NOT NULL AND issued_at IS NOT NULL)` | No |
| `invoices_check1` | CHECK | `CHECK (period_end >= period_start)` | No |
| `invoices_check2` | CHECK | `CHECK (total >= 0::numeric AND subtotal >= 0::numeric)` | No |
| `invoices_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `invoices_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `invoices_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `invoices_currency_not_null` | NOT NULL | `NOT NULL currency` | No |
| `invoices_flexfields_not_null` | NOT NULL | `NOT NULL flexfields` | No |
| `invoices_flexfields_valid` | CHECK | `CHECK (jsonb_typeof(flexfields) = 'object'::text AND (flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb AND (NOT flexfields ? 'flexfield1'::text OR (flexfields -> 'flexfield1'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield1'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield1'::text) <= 250) AND (NOT flexfields ? 'flexfield2'::text OR (flexfields -> 'flexfield2'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield2'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield2'::text) <= 250) AND (NOT flexfields ? 'flexfield3'::text OR (flexfields -> 'flexfield3'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield3'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield3'::text) <= 250) AND (NOT flexfields ? 'flexfield4'::text OR (flexfields -> 'flexfield4'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield4'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield4'::text) <= 250) AND (NOT flexfields ? 'flexfield5'::text OR (flexfields -> 'flexfield5'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield5'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield5'::text) <= 250) AND (NOT flexfields ? 'flexfield6'::text OR (flexfields -> 'flexfield6'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield6'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield6'::text) <= 250) AND (NOT flexfields ? 'flexfield7'::text OR (flexfields -> 'flexfield7'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield7'::text) = 'string'::text AND (flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text) AND (NOT flexfields ? 'flexfield8'::text OR (flexfields -> 'flexfield8'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield8'::text) = 'string'::text AND (flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))` | No |
| `invoices_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `invoices_number_key` | UNIQUE | `UNIQUE (number)` | No |
| `invoices_number_not_null` | NOT NULL | `NOT NULL number` | No |
| `invoices_object_id_key` | UNIQUE | `UNIQUE (object_id)` | No |
| `invoices_object_id_not_null` | NOT NULL | `NOT NULL object_id` | No |
| `invoices_period_end_not_null` | NOT NULL | `NOT NULL period_end` | No |
| `invoices_period_start_not_null` | NOT NULL | `NOT NULL period_start` | No |
| `invoices_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `invoices_status_check` | CHECK | `CHECK (status::text = ANY (ARRAY['Draft'::character varying, 'Issued'::character varying, 'Sent'::character varying, 'Void'::character varying]::text[]))` | No |
| `invoices_status_not_null` | NOT NULL | `NOT NULL status` | No |
| `invoices_subtotal_not_null` | NOT NULL | `NOT NULL subtotal` | No |
| `invoices_total_not_null` | NOT NULL | `NOT NULL total` | No |
| `invoices_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `invoices_version_not_null` | NOT NULL | `NOT NULL version` | No |
| `issued_artifact_check` | CONSTRAINT TRIGGER | `TRIGGER DEFERRABLE INITIALLY DEFERRED` | Initially deferred |

### Indexes

| Name | SQL |
| --- | --- |
| `invoices_number_key` | `CREATE UNIQUE INDEX invoices_number_key ON timeker_reference.invoices USING btree (number)` |
| `invoices_object_id_key` | `CREATE UNIQUE INDEX invoices_object_id_key ON timeker_reference.invoices USING btree (object_id)` |
| `invoices_pkey` | `CREATE UNIQUE INDEX invoices_pkey ON timeker_reference.invoices USING btree (id)` |
| `ix_invoices_client_id` | `CREATE INDEX ix_invoices_client_id ON timeker_reference.invoices USING btree (client_id)` |
| `ix_invoices_created_id` | `CREATE INDEX ix_invoices_created_id ON timeker_reference.invoices USING btree (created_at DESC, id)` |
| `ix_invoices_due_date` | `CREATE INDEX ix_invoices_due_date ON timeker_reference.invoices USING btree (due_date)` |
| `ix_invoices_status` | `CREATE INDEX ix_invoices_status ON timeker_reference.invoices USING btree (status)` |
| `uq_active_fixed_fee_project` | `CREATE UNIQUE INDEX uq_active_fixed_fee_project ON timeker_reference.invoices USING btree (fixed_fee_project_id) WHERE ((fixed_fee_project_id IS NOT NULL) AND ((status)::text <> 'Void'::text))` |
| `uq_active_manual_extra_reference` | `CREATE UNIQUE INDEX uq_active_manual_extra_reference ON timeker_reference.invoices USING btree (manual_extra_project_id, manual_extra_reference) WHERE ((manual_extra_project_id IS NOT NULL) AND ((status)::text <> 'Void'::text))` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `invoice_credit_memo_check` | [timeker_credit_memo_final_guard](04-functions-and-procedures.md#timeker_credit_memo_final_guard) | `invoice_credit_memo_check` |
| `invoice_guard` | [timeker_invoice_guard](04-functions-and-procedures.md#timeker_invoice_guard) | — |
| `issued_artifact_check` | [timeker_issued_artifact_check](04-functions-and-procedures.md#timeker_issued_artifact_check) | `issued_artifact_check` |
| `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |

## library_document_versions

Mapped class `LibraryDocumentVersion`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L68).

14 columns; 21 catalog constraints; 4 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `document_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 3 | `number` | `integer` | No | UNIQUE | — | — | — | — |
| 4 | `snapshot` | `jsonb` | No | — | — | — | — | — |
| 5 | `source_upload_id` | `uuid` | Yes | FK | — | — | — | — |
| 6 | `pdf_bytes` | `bytea` | No | — | — | — | — | — |
| 7 | `pdf_size` | `integer` | No | — | — | — | — | — |
| 8 | `pdf_sha256` | `character varying(64)` | No | — | — | — | — | — |
| 9 | `filename` | `character varying(180)` | No | — | — | — | — | — |
| 10 | `renderer_version` | `character varying(80)` | No | — | — | — | — | — |
| 11 | `published_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 12 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 13 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 14 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `library_document_versions_check` | CHECK | `CHECK (pdf_size >= 1 AND pdf_size <= 5242880 AND octet_length(pdf_bytes) = pdf_size)` | No |
| `library_document_versions_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `library_document_versions_document_id_fkey` | FOREIGN KEY | `FOREIGN KEY (document_id) REFERENCES library_documents(id)` | No |
| `library_document_versions_document_id_not_null` | NOT NULL | `NOT NULL document_id` | No |
| `library_document_versions_document_id_number_key` | UNIQUE | `UNIQUE (document_id, number)` | No |
| `library_document_versions_filename_not_null` | NOT NULL | `NOT NULL filename` | No |
| `library_document_versions_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `library_document_versions_number_check` | CHECK | `CHECK (number > 0)` | No |
| `library_document_versions_number_not_null` | NOT NULL | `NOT NULL number` | No |
| `library_document_versions_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `library_document_versions_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `library_document_versions_pdf_bytes_not_null` | NOT NULL | `NOT NULL pdf_bytes` | No |
| `library_document_versions_pdf_sha256_check` | CHECK | `CHECK (pdf_sha256::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `library_document_versions_pdf_sha256_not_null` | NOT NULL | `NOT NULL pdf_sha256` | No |
| `library_document_versions_pdf_size_not_null` | NOT NULL | `NOT NULL pdf_size` | No |
| `library_document_versions_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `library_document_versions_published_at_not_null` | NOT NULL | `NOT NULL published_at` | No |
| `library_document_versions_renderer_version_not_null` | NOT NULL | `NOT NULL renderer_version` | No |
| `library_document_versions_snapshot_not_null` | NOT NULL | `NOT NULL snapshot` | No |
| `library_document_versions_source_upload_id_fkey` | FOREIGN KEY | `FOREIGN KEY (source_upload_id) REFERENCES library_uploads(id)` | No |
| `library_document_versions_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_library_document_versions_document_id` | `CREATE INDEX ix_library_document_versions_document_id ON timeker_reference.library_document_versions USING btree (document_id)` |
| `ix_library_document_versions_owner_id` | `CREATE INDEX ix_library_document_versions_owner_id ON timeker_reference.library_document_versions USING btree (owner_id)` |
| `library_document_versions_document_id_number_key` | `CREATE UNIQUE INDEX library_document_versions_document_id_number_key ON timeker_reference.library_document_versions USING btree (document_id, number)` |
| `library_document_versions_pkey` | `CREATE UNIQUE INDEX library_document_versions_pkey ON timeker_reference.library_document_versions USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `library_version_guard` | [timeker_library_guard](04-functions-and-procedures.md#timeker_library_guard) | — |

## library_documents

Mapped class `LibraryDocument`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L26).

17 columns; 25 catalog constraints; 6 indexes; 2 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 2 | `title` | `character varying(180)` | No | — | — | — | — | — |
| 3 | `kind` | `character varying(16)` | No | — | — | — | — | — |
| 4 | `status` | `character varying(12)` | No | — | — | — | `'draft'` | — |
| 5 | `content` | `text` | No | — | — | — | `''` | — |
| 6 | `is_template` | `boolean` | No | — | — | — | `False` | — |
| 7 | `case_id` | `uuid` | Yes | FK | — | — | — | — |
| 8 | `client_id` | `uuid` | Yes | FK | — | — | — | — |
| 9 | `project_id` | `uuid` | Yes | FK | — | — | — | — |
| 10 | `source_template` | `character varying(40)` | Yes | — | — | — | — | — |
| 11 | `source_upload_id` | `uuid` | Yes | — | — | — | — | — |
| 12 | `revision` | `integer` | No | — | — | — | `1` | — |
| 13 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 14 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 15 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 16 | `object_id` | `bigint` | No | UNIQUE | — | `a` | — | — |
| 17 | `flexfields` | `jsonb` | No | — | `'{}'::jsonb` | — | `Python callable: dict` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `library_documents_case_id_fkey` | FOREIGN KEY | `FOREIGN KEY (case_id) REFERENCES cases(id)` | No |
| `library_documents_check` | CHECK | `CHECK (is_template AND case_id IS NULL AND client_id IS NULL AND project_id IS NULL OR NOT is_template AND case_id IS NOT NULL AND client_id IS NOT NULL AND project_id IS NOT NULL)` | No |
| `library_documents_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `library_documents_content_check` | CHECK | `CHECK (length(content) <= 100000)` | No |
| `library_documents_content_not_null` | NOT NULL | `NOT NULL content` | No |
| `library_documents_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `library_documents_flexfields_not_null` | NOT NULL | `NOT NULL flexfields` | No |
| `library_documents_flexfields_valid` | CHECK | `CHECK (jsonb_typeof(flexfields) = 'object'::text AND (flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb AND (NOT flexfields ? 'flexfield1'::text OR (flexfields -> 'flexfield1'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield1'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield1'::text) <= 250) AND (NOT flexfields ? 'flexfield2'::text OR (flexfields -> 'flexfield2'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield2'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield2'::text) <= 250) AND (NOT flexfields ? 'flexfield3'::text OR (flexfields -> 'flexfield3'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield3'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield3'::text) <= 250) AND (NOT flexfields ? 'flexfield4'::text OR (flexfields -> 'flexfield4'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield4'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield4'::text) <= 250) AND (NOT flexfields ? 'flexfield5'::text OR (flexfields -> 'flexfield5'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield5'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield5'::text) <= 250) AND (NOT flexfields ? 'flexfield6'::text OR (flexfields -> 'flexfield6'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield6'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield6'::text) <= 250) AND (NOT flexfields ? 'flexfield7'::text OR (flexfields -> 'flexfield7'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield7'::text) = 'string'::text AND (flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text) AND (NOT flexfields ? 'flexfield8'::text OR (flexfields -> 'flexfield8'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield8'::text) = 'string'::text AND (flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))` | No |
| `library_documents_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `library_documents_is_template_not_null` | NOT NULL | `NOT NULL is_template` | No |
| `library_documents_kind_check` | CHECK | `CHECK (kind::text = ANY (ARRAY['msa'::character varying, 'sow'::character varying, 'sla'::character varying, 'custom'::character varying]::text[]))` | No |
| `library_documents_kind_not_null` | NOT NULL | `NOT NULL kind` | No |
| `library_documents_object_id_key` | UNIQUE | `UNIQUE (object_id)` | No |
| `library_documents_object_id_not_null` | NOT NULL | `NOT NULL object_id` | No |
| `library_documents_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `library_documents_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `library_documents_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `library_documents_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `library_documents_revision_check` | CHECK | `CHECK (revision > 0)` | No |
| `library_documents_revision_not_null` | NOT NULL | `NOT NULL revision` | No |
| `library_documents_status_check` | CHECK | `CHECK (status::text = ANY (ARRAY['draft'::character varying, 'frozen'::character varying]::text[]))` | No |
| `library_documents_status_not_null` | NOT NULL | `NOT NULL status` | No |
| `library_documents_title_check` | CHECK | `CHECK (length(btrim(title::text)) >= 1 AND length(btrim(title::text)) <= 180)` | No |
| `library_documents_title_not_null` | NOT NULL | `NOT NULL title` | No |
| `library_documents_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_library_documents_case_id` | `CREATE INDEX ix_library_documents_case_id ON timeker_reference.library_documents USING btree (case_id)` |
| `ix_library_documents_client_id` | `CREATE INDEX ix_library_documents_client_id ON timeker_reference.library_documents USING btree (client_id)` |
| `ix_library_documents_owner_id` | `CREATE INDEX ix_library_documents_owner_id ON timeker_reference.library_documents USING btree (owner_id)` |
| `ix_library_documents_project_id` | `CREATE INDEX ix_library_documents_project_id ON timeker_reference.library_documents USING btree (project_id)` |
| `library_documents_object_id_key` | `CREATE UNIQUE INDEX library_documents_object_id_key ON timeker_reference.library_documents USING btree (object_id)` |
| `library_documents_pkey` | `CREATE UNIQUE INDEX library_documents_pkey ON timeker_reference.library_documents USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `library_document_guard` | [timeker_library_guard](04-functions-and-procedures.md#timeker_library_guard) | — |
| `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |

## library_uploads

Mapped class `LibraryUpload`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L52).

10 columns; 16 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `document_id` | `uuid` | No | FK | — | — | — | — |
| 2 | `uploaded_by` | `uuid` | No | FK | — | — | — | — |
| 3 | `filename` | `character varying(180)` | No | — | — | — | — | — |
| 4 | `content_type` | `character varying(128)` | No | — | — | — | — | — |
| 5 | `size` | `integer` | No | — | — | — | — | — |
| 6 | `sha256` | `character varying(64)` | No | — | — | — | — | — |
| 7 | `payload` | `bytea` | No | — | — | — | — | — |
| 8 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 9 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 10 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `library_uploads_check` | CHECK | `CHECK (size >= 1 AND size <= 5242880 AND octet_length(payload) = size)` | No |
| `library_uploads_content_type_not_null` | NOT NULL | `NOT NULL content_type` | No |
| `library_uploads_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `library_uploads_document_id_fkey` | FOREIGN KEY | `FOREIGN KEY (document_id) REFERENCES library_documents(id)` | No |
| `library_uploads_document_id_not_null` | NOT NULL | `NOT NULL document_id` | No |
| `library_uploads_filename_check` | CHECK | `CHECK (length(btrim(filename::text)) >= 1 AND length(btrim(filename::text)) <= 180)` | No |
| `library_uploads_filename_not_null` | NOT NULL | `NOT NULL filename` | No |
| `library_uploads_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `library_uploads_payload_not_null` | NOT NULL | `NOT NULL payload` | No |
| `library_uploads_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `library_uploads_sha256_check` | CHECK | `CHECK (sha256::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `library_uploads_sha256_not_null` | NOT NULL | `NOT NULL sha256` | No |
| `library_uploads_size_not_null` | NOT NULL | `NOT NULL size` | No |
| `library_uploads_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `library_uploads_uploaded_by_fkey` | FOREIGN KEY | `FOREIGN KEY (uploaded_by) REFERENCES users(id)` | No |
| `library_uploads_uploaded_by_not_null` | NOT NULL | `NOT NULL uploaded_by` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_library_uploads_document_id` | `CREATE INDEX ix_library_uploads_document_id ON timeker_reference.library_uploads USING btree (document_id)` |
| `library_uploads_pkey` | `CREATE UNIQUE INDEX library_uploads_pkey ON timeker_reference.library_uploads USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `library_upload_guard` | [timeker_library_guard](04-functions-and-procedures.md#timeker_library_guard) | — |

## mail_addresses

Mapped class `MailAddress`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L49).

9 columns; 12 catalog constraints; 6 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 2 | `client_id` | `uuid` | No | FK | — | — | — | — |
| 3 | `project_id` | `uuid` | Yes | FK | — | — | — | — |
| 4 | `case_id` | `uuid` | Yes | FK | — | — | — | — |
| 5 | `token_digest` | `character varying(64)` | No | UNIQUE | — | — | — | — |
| 6 | `revoked_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 7 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 8 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 9 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `mail_addresses_case_id_fkey` | FOREIGN KEY | `FOREIGN KEY (case_id) REFERENCES cases(id)` | No |
| `mail_addresses_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `mail_addresses_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `mail_addresses_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `mail_addresses_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `mail_addresses_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `mail_addresses_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `mail_addresses_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `mail_addresses_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `mail_addresses_token_digest_key` | UNIQUE | `UNIQUE (token_digest)` | No |
| `mail_addresses_token_digest_not_null` | NOT NULL | `NOT NULL token_digest` | No |
| `mail_addresses_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_mail_addresses_case_id` | `CREATE INDEX ix_mail_addresses_case_id ON timeker_reference.mail_addresses USING btree (case_id)` |
| `ix_mail_addresses_client_id` | `CREATE INDEX ix_mail_addresses_client_id ON timeker_reference.mail_addresses USING btree (client_id)` |
| `ix_mail_addresses_owner_id` | `CREATE INDEX ix_mail_addresses_owner_id ON timeker_reference.mail_addresses USING btree (owner_id)` |
| `ix_mail_addresses_project_id` | `CREATE INDEX ix_mail_addresses_project_id ON timeker_reference.mail_addresses USING btree (project_id)` |
| `mail_addresses_pkey` | `CREATE UNIQUE INDEX mail_addresses_pkey ON timeker_reference.mail_addresses USING btree (id)` |
| `mail_addresses_token_digest_key` | `CREATE UNIQUE INDEX mail_addresses_token_digest_key ON timeker_reference.mail_addresses USING btree (token_digest)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `mail_address_guard` | [timeker_mail_guard](04-functions-and-procedures.md#timeker_mail_guard) | — |

## mail_attachments

Mapped class `MailAttachment`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L64).

10 columns; 17 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `message_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `position` | `integer` | No | UNIQUE | — | — | — | — |
| 3 | `filename` | `character varying(180)` | No | — | — | — | — | — |
| 4 | `declared_content_type` | `character varying(128)` | No | — | — | — | `'application/octet-stream'` | — |
| 5 | `size` | `integer` | No | — | — | — | — | — |
| 6 | `sha256` | `character varying(64)` | No | — | — | — | — | — |
| 7 | `payload` | `bytea` | No | — | — | — | — | — |
| 8 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 9 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 10 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `mail_attachments_check` | CHECK | `CHECK (size >= 0 AND size <= 5242880 AND octet_length(payload) = size)` | No |
| `mail_attachments_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `mail_attachments_declared_content_type_not_null` | NOT NULL | `NOT NULL declared_content_type` | No |
| `mail_attachments_filename_check` | CHECK | `CHECK (length(btrim(filename::text)) >= 1 AND length(btrim(filename::text)) <= 180)` | No |
| `mail_attachments_filename_not_null` | NOT NULL | `NOT NULL filename` | No |
| `mail_attachments_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `mail_attachments_message_id_fkey` | FOREIGN KEY | `FOREIGN KEY (message_id) REFERENCES mail_messages(id)` | No |
| `mail_attachments_message_id_not_null` | NOT NULL | `NOT NULL message_id` | No |
| `mail_attachments_message_id_position_key` | UNIQUE | `UNIQUE (message_id, "position")` | No |
| `mail_attachments_payload_not_null` | NOT NULL | `NOT NULL payload` | No |
| `mail_attachments_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `mail_attachments_position_check` | CHECK | `CHECK ("position" >= 1 AND "position" <= 100)` | No |
| `mail_attachments_position_not_null` | NOT NULL | `NOT NULL "position"` | No |
| `mail_attachments_sha256_check` | CHECK | `CHECK (sha256::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `mail_attachments_sha256_not_null` | NOT NULL | `NOT NULL sha256` | No |
| `mail_attachments_size_not_null` | NOT NULL | `NOT NULL size` | No |
| `mail_attachments_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_mail_attachments_message_id` | `CREATE INDEX ix_mail_attachments_message_id ON timeker_reference.mail_attachments USING btree (message_id)` |
| `mail_attachments_message_id_position_key` | `CREATE UNIQUE INDEX mail_attachments_message_id_position_key ON timeker_reference.mail_attachments USING btree (message_id, "position")` |
| `mail_attachments_pkey` | `CREATE UNIQUE INDEX mail_attachments_pkey ON timeker_reference.mail_attachments USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `mail_attachment_guard` | [timeker_mail_attachment_guard](04-functions-and-procedures.md#timeker_mail_attachment_guard) | — |

## mail_messages

Mapped class `MailMessage`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L22).

20 columns; 24 catalog constraints; 9 indexes; 2 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `client_id` | `uuid` | No | FK | — | — | — | — |
| 3 | `project_id` | `uuid` | Yes | FK | — | — | — | — |
| 4 | `case_id` | `uuid` | Yes | FK | — | — | — | — |
| 5 | `message_id` | `character varying(998)` | Yes | — | — | — | — | — |
| 6 | `sha256` | `character varying(64)` | No | UNIQUE | — | — | — | — |
| 7 | `subject` | `character varying(998)` | No | — | — | — | — | — |
| 8 | `sender` | `character varying(2000)` | No | — | — | — | — | — |
| 9 | `recipients` | `character varying(4000)` | No | — | — | — | — | — |
| 10 | `body` | `text` | No | — | — | — | — | — |
| 11 | `message_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 12 | `received_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 13 | `archived_basis_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 14 | `archive_basis_source` | `character varying(20)` | No | — | — | — | — | — |
| 15 | `archived_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 16 | `source` | `character varying(10)` | No | — | — | — | — | — |
| 17 | `attachment_count` | `integer` | No | — | — | — | — | — |
| 18 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 19 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 20 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `mail_messages_archive_basis_source_check` | CHECK | `CHECK (archive_basis_source::text = ANY (ARRAY['receipt'::character varying, 'owner_import'::character varying]::text[]))` | No |
| `mail_messages_archive_basis_source_not_null` | NOT NULL | `NOT NULL archive_basis_source` | No |
| `mail_messages_archived_basis_at_not_null` | NOT NULL | `NOT NULL archived_basis_at` | No |
| `mail_messages_attachment_count_check` | CHECK | `CHECK (attachment_count >= 0 AND attachment_count <= 100)` | No |
| `mail_messages_attachment_count_not_null` | NOT NULL | `NOT NULL attachment_count` | No |
| `mail_messages_body_not_null` | NOT NULL | `NOT NULL body` | No |
| `mail_messages_case_id_fkey` | FOREIGN KEY | `FOREIGN KEY (case_id) REFERENCES cases(id)` | No |
| `mail_messages_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `mail_messages_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `mail_messages_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `mail_messages_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `mail_messages_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `mail_messages_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `mail_messages_owner_id_sha256_key` | UNIQUE | `UNIQUE (owner_id, sha256)` | No |
| `mail_messages_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `mail_messages_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `mail_messages_received_at_not_null` | NOT NULL | `NOT NULL received_at` | No |
| `mail_messages_recipients_not_null` | NOT NULL | `NOT NULL recipients` | No |
| `mail_messages_sender_not_null` | NOT NULL | `NOT NULL sender` | No |
| `mail_messages_sha256_not_null` | NOT NULL | `NOT NULL sha256` | No |
| `mail_messages_source_check` | CHECK | `CHECK (source::text = ANY (ARRAY['import'::character varying, 'capture'::character varying]::text[]))` | No |
| `mail_messages_source_not_null` | NOT NULL | `NOT NULL source` | No |
| `mail_messages_subject_not_null` | NOT NULL | `NOT NULL subject` | No |
| `mail_messages_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_mail_messages_archived_at` | `CREATE INDEX ix_mail_messages_archived_at ON timeker_reference.mail_messages USING btree (archived_at)` |
| `ix_mail_messages_archived_basis_at` | `CREATE INDEX ix_mail_messages_archived_basis_at ON timeker_reference.mail_messages USING btree (archived_basis_at)` |
| `ix_mail_messages_case_id` | `CREATE INDEX ix_mail_messages_case_id ON timeker_reference.mail_messages USING btree (case_id)` |
| `ix_mail_messages_client_id` | `CREATE INDEX ix_mail_messages_client_id ON timeker_reference.mail_messages USING btree (client_id)` |
| `ix_mail_messages_owner_id` | `CREATE INDEX ix_mail_messages_owner_id ON timeker_reference.mail_messages USING btree (owner_id)` |
| `ix_mail_messages_owner_received_id` | `CREATE INDEX ix_mail_messages_owner_received_id ON timeker_reference.mail_messages USING btree (owner_id, received_at DESC, id) WHERE (archived_at IS NULL)` |
| `ix_mail_messages_project_id` | `CREATE INDEX ix_mail_messages_project_id ON timeker_reference.mail_messages USING btree (project_id)` |
| `mail_messages_owner_id_sha256_key` | `CREATE UNIQUE INDEX mail_messages_owner_id_sha256_key ON timeker_reference.mail_messages USING btree (owner_id, sha256)` |
| `mail_messages_pkey` | `CREATE UNIQUE INDEX mail_messages_pkey ON timeker_reference.mail_messages USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `archive_mail_guard` | [timeker_archive_guard](04-functions-and-procedures.md#timeker_archive_guard) | — |
| `mail_message_guard` | [timeker_mail_guard](04-functions-and-procedures.md#timeker_mail_guard) | — |

## owner_identities

Mapped class `OwnerIdentity`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L12).

8 columns; 12 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 3 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 4 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 5 | `issuer` | `character varying(255)` | No | UNIQUE | — | — | — | — |
| 6 | `subject` | `character varying(255)` | No | UNIQUE | — | — | — | — |
| 7 | `verified_email` | `character varying(254)` | No | — | — | — | — | — |
| 8 | `revoked_at` | `timestamp with time zone` | Yes | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `owner_identities_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `owner_identities_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `owner_identities_issuer_not_null` | NOT NULL | `NOT NULL issuer` | No |
| `owner_identities_issuer_subject_key` | UNIQUE | `UNIQUE (issuer, subject)` | No |
| `owner_identities_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `owner_identities_owner_id_issuer_key` | UNIQUE | `UNIQUE (owner_id, issuer)` | No |
| `owner_identities_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `owner_identities_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `owner_identities_subject_check` | CHECK | `CHECK (length(subject::text) >= 1 AND length(subject::text) <= 255)` | No |
| `owner_identities_subject_not_null` | NOT NULL | `NOT NULL subject` | No |
| `owner_identities_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `owner_identities_verified_email_not_null` | NOT NULL | `NOT NULL verified_email` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `owner_identities_issuer_subject_key` | `CREATE UNIQUE INDEX owner_identities_issuer_subject_key ON timeker_reference.owner_identities USING btree (issuer, subject)` |
| `owner_identities_owner_id_issuer_key` | `CREATE UNIQUE INDEX owner_identities_owner_id_issuer_key ON timeker_reference.owner_identities USING btree (owner_id, issuer)` |
| `owner_identities_pkey` | `CREATE UNIQUE INDEX owner_identities_pkey ON timeker_reference.owner_identities USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `identity_binding_history` | [timeker_registration_history_guard](04-functions-and-procedures.md#timeker_registration_history_guard) | — |

## owner_registrations

Mapped class `OwnerRegistration`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L26).

9 columns; 13 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 3 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 4 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 5 | `terms_version` | `character varying(60)` | No | UNIQUE | — | — | — | — |
| 6 | `privacy_version` | `character varying(60)` | No | UNIQUE | — | — | — | — |
| 7 | `catalog_version` | `character varying(60)` | No | UNIQUE | — | — | — | — |
| 8 | `offer` | `character varying(20)` | No | — | — | — | — | — |
| 9 | `accepted_at` | `timestamp with time zone` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `owner_registrations_accepted_at_not_null` | NOT NULL | `NOT NULL accepted_at` | No |
| `owner_registrations_catalog_version_not_null` | NOT NULL | `NOT NULL catalog_version` | No |
| `owner_registrations_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `owner_registrations_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `owner_registrations_offer_check` | CHECK | `CHECK (offer::text = ANY (ARRAY['free'::character varying, 'solo_monthly'::character varying, 'solo_annual'::character varying, 'pro_monthly'::character varying, 'pro_annual'::character varying]::text[]))` | No |
| `owner_registrations_offer_not_null` | NOT NULL | `NOT NULL offer` | No |
| `owner_registrations_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `owner_registrations_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `owner_registrations_owner_id_terms_version_privacy_version__key` | UNIQUE | `UNIQUE (owner_id, terms_version, privacy_version, catalog_version)` | No |
| `owner_registrations_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `owner_registrations_privacy_version_not_null` | NOT NULL | `NOT NULL privacy_version` | No |
| `owner_registrations_terms_version_not_null` | NOT NULL | `NOT NULL terms_version` | No |
| `owner_registrations_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `owner_registrations_owner_id_terms_version_privacy_version__key` | `CREATE UNIQUE INDEX owner_registrations_owner_id_terms_version_privacy_version__key ON timeker_reference.owner_registrations USING btree (owner_id, terms_version, privacy_version, catalog_version)` |
| `owner_registrations_pkey` | `CREATE UNIQUE INDEX owner_registrations_pkey ON timeker_reference.owner_registrations USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `registration_acceptance_history` | [timeker_registration_history_guard](04-functions-and-procedures.md#timeker_registration_history_guard) | — |

## payments

Mapped class `Payment`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L380).

12 columns; 13 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `invoice_id` | `uuid` | No | FK | — | — | — | — |
| 2 | `paid_at` | `date` | No | — | — | — | — | — |
| 3 | `amount` | `numeric(14,2)` | No | — | — | — | — | — |
| 4 | `currency` | `character varying(3)` | No | — | — | — | — | — |
| 5 | `method` | `character varying(40)` | No | — | — | — | — | — |
| 6 | `reference` | `character varying(200)` | Yes | — | — | — | — | — |
| 7 | `note` | `text` | Yes | — | — | — | — | — |
| 8 | `created_by` | `uuid` | No | FK | — | — | — | — |
| 9 | `reversed_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 10 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 11 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 12 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `payments_amount_check` | CHECK | `CHECK (amount > 0::numeric)` | No |
| `payments_amount_not_null` | NOT NULL | `NOT NULL amount` | No |
| `payments_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `payments_created_by_fkey` | FOREIGN KEY | `FOREIGN KEY (created_by) REFERENCES users(id)` | No |
| `payments_created_by_not_null` | NOT NULL | `NOT NULL created_by` | No |
| `payments_currency_not_null` | NOT NULL | `NOT NULL currency` | No |
| `payments_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `payments_invoice_id_fkey` | FOREIGN KEY | `FOREIGN KEY (invoice_id) REFERENCES invoices(id)` | No |
| `payments_invoice_id_not_null` | NOT NULL | `NOT NULL invoice_id` | No |
| `payments_method_not_null` | NOT NULL | `NOT NULL method` | No |
| `payments_paid_at_not_null` | NOT NULL | `NOT NULL paid_at` | No |
| `payments_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `payments_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_payments_invoice_id` | `CREATE INDEX ix_payments_invoice_id ON timeker_reference.payments USING btree (invoice_id)` |
| `payments_pkey` | `CREATE UNIQUE INDEX payments_pkey ON timeker_reference.payments USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `payment_guard` | [timeker_payment_guard](04-functions-and-procedures.md#timeker_payment_guard) | — |

## project_agreements

Mapped class `ProjectAgreement`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L169).

9 columns; 16 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `project_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 3 | `uploaded_by` | `uuid` | No | FK | — | — | — | — |
| 4 | `filename` | `character varying(180)` | No | — | — | — | — | — |
| 5 | `size` | `integer` | No | — | — | — | — | — |
| 6 | `sha256` | `character varying(64)` | No | — | — | — | — | — |
| 7 | `payload` | `bytea` | No | — | — | — | — | — |
| 8 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 9 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `project_agreements_check` | CHECK | `CHECK (size >= 1 AND size <= 5242880 AND octet_length(payload) = size)` | No |
| `project_agreements_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `project_agreements_filename_check` | CHECK | `CHECK (length(btrim(filename::text)) >= 1 AND length(btrim(filename::text)) <= 180)` | No |
| `project_agreements_filename_not_null` | NOT NULL | `NOT NULL filename` | No |
| `project_agreements_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `project_agreements_payload_not_null` | NOT NULL | `NOT NULL payload` | No |
| `project_agreements_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `project_agreements_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `project_agreements_project_id_key` | UNIQUE | `UNIQUE (project_id)` | No |
| `project_agreements_project_id_not_null` | NOT NULL | `NOT NULL project_id` | No |
| `project_agreements_sha256_check` | CHECK | `CHECK (sha256::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `project_agreements_sha256_not_null` | NOT NULL | `NOT NULL sha256` | No |
| `project_agreements_size_not_null` | NOT NULL | `NOT NULL size` | No |
| `project_agreements_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `project_agreements_uploaded_by_fkey` | FOREIGN KEY | `FOREIGN KEY (uploaded_by) REFERENCES users(id)` | No |
| `project_agreements_uploaded_by_not_null` | NOT NULL | `NOT NULL uploaded_by` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `project_agreements_pkey` | `CREATE UNIQUE INDEX project_agreements_pkey ON timeker_reference.project_agreements USING btree (id)` |
| `project_agreements_project_id_key` | `CREATE UNIQUE INDEX project_agreements_project_id_key ON timeker_reference.project_agreements USING btree (project_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `project_agreement_guard` | [timeker_project_agreement_guard](04-functions-and-procedures.md#timeker_project_agreement_guard) | — |

## projects

Mapped class `Project`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L112).

18 columns; 21 catalog constraints; 4 indexes; 3 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `client_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `code` | `character varying(30)` | No | UNIQUE | — | — | — | — |
| 3 | `name` | `character varying(150)` | No | — | — | — | — | — |
| 4 | `description` | `text` | Yes | — | — | — | — | — |
| 5 | `status` | `character varying(20)` | No | — | `'draft'::character varying` | — | `'draft'` | — |
| 6 | `billable` | `boolean` | No | — | — | — | `True` | — |
| 7 | `rate_override` | `numeric(14,2)` | Yes | — | — | — | — | — |
| 8 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 9 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 10 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 11 | `project_type` | `character varying(40)` | Yes | — | — | — | — | — |
| 12 | `budget_amount` | `numeric(14,2)` | Yes | — | — | — | — | — |
| 13 | `budget_currency` | `character varying(3)` | Yes | — | — | — | — | — |
| 14 | `agreement_type` | `character varying(10)` | Yes | — | — | — | — | — |
| 15 | `agreement_reference` | `character varying(200)` | Yes | — | — | — | — | — |
| 16 | `allow_overbilling` | `boolean` | No | — | `false` | — | `False` | — |
| 17 | `object_id` | `bigint` | No | UNIQUE | — | `a` | — | — |
| 18 | `flexfields` | `jsonb` | No | — | `'{}'::jsonb` | — | `Python callable: dict` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `project_agreement_pair` | CHECK | `CHECK (agreement_type IS NULL AND agreement_reference IS NULL OR agreement_type IS NOT NULL AND agreement_reference IS NOT NULL AND (agreement_type::text = ANY (ARRAY['Contract'::character varying, 'SAL'::character varying, 'SOW'::character varying]::text[])) AND length(btrim(agreement_reference::text)) > 0)` | No |
| `project_budget_pair` | CHECK | `CHECK (budget_amount IS NULL AND budget_currency IS NULL OR budget_amount IS NOT NULL AND budget_currency IS NOT NULL AND budget_amount >= 0::numeric AND budget_amount <= 9999999999.99 AND budget_currency::text ~ '^[A-Z]{3}$'::text)` | No |
| `project_status_allowed` | CHECK | `CHECK (status::text = ANY (ARRAY['draft'::character varying, 'active'::character varying, 'closed'::character varying, 'archived'::character varying]::text[]))` | No |
| `project_type_allowed` | CHECK | `CHECK (project_type IS NULL OR (project_type::text = ANY (ARRAY['time_and_materials'::character varying, 'fixed_fee'::character varying, 'on_call_support'::character varying, 'on_demand_support_tm'::character varying, 'on_demand_support_ff'::character varying]::text[])))` | No |
| `projects_allow_overbilling_not_null` | NOT NULL | `NOT NULL allow_overbilling` | No |
| `projects_billable_not_null` | NOT NULL | `NOT NULL billable` | No |
| `projects_client_id_code_key` | UNIQUE | `UNIQUE (client_id, code)` | No |
| `projects_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `projects_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `projects_code_not_null` | NOT NULL | `NOT NULL code` | No |
| `projects_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `projects_flexfields_not_null` | NOT NULL | `NOT NULL flexfields` | No |
| `projects_flexfields_valid` | CHECK | `CHECK (jsonb_typeof(flexfields) = 'object'::text AND (flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb AND (NOT flexfields ? 'flexfield1'::text OR (flexfields -> 'flexfield1'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield1'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield1'::text) <= 250) AND (NOT flexfields ? 'flexfield2'::text OR (flexfields -> 'flexfield2'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield2'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield2'::text) <= 250) AND (NOT flexfields ? 'flexfield3'::text OR (flexfields -> 'flexfield3'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield3'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield3'::text) <= 250) AND (NOT flexfields ? 'flexfield4'::text OR (flexfields -> 'flexfield4'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield4'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield4'::text) <= 250) AND (NOT flexfields ? 'flexfield5'::text OR (flexfields -> 'flexfield5'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield5'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield5'::text) <= 250) AND (NOT flexfields ? 'flexfield6'::text OR (flexfields -> 'flexfield6'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield6'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield6'::text) <= 250) AND (NOT flexfields ? 'flexfield7'::text OR (flexfields -> 'flexfield7'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield7'::text) = 'string'::text AND (flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text) AND (NOT flexfields ? 'flexfield8'::text OR (flexfields -> 'flexfield8'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield8'::text) = 'string'::text AND (flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))` | No |
| `projects_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `projects_name_not_null` | NOT NULL | `NOT NULL name` | No |
| `projects_object_id_key` | UNIQUE | `UNIQUE (object_id)` | No |
| `projects_object_id_not_null` | NOT NULL | `NOT NULL object_id` | No |
| `projects_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `projects_rate_override_check` | CHECK | `CHECK (rate_override IS NULL OR rate_override >= 0::numeric)` | No |
| `projects_status_not_null` | NOT NULL | `NOT NULL status` | No |
| `projects_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_projects_client_id` | `CREATE INDEX ix_projects_client_id ON timeker_reference.projects USING btree (client_id)` |
| `projects_client_id_code_key` | `CREATE UNIQUE INDEX projects_client_id_code_key ON timeker_reference.projects USING btree (client_id, code)` |
| `projects_object_id_key` | `CREATE UNIQUE INDEX projects_object_id_key ON timeker_reference.projects USING btree (object_id)` |
| `projects_pkey` | `CREATE UNIQUE INDEX projects_pkey ON timeker_reference.projects USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `allocated_project_guard` | [timeker_allocated_parent_guard](04-functions-and-procedures.md#timeker_allocated_parent_guard) | — |
| `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |
| `project_billing_guard` | [timeker_project_billing_guard](04-functions-and-procedures.md#timeker_project_billing_guard) | — |

## proposal_sending_attempts

Mapped class `ProposalSendingAttempt`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L58).

8 columns; 12 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `delivery_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `number` | `integer` | No | UNIQUE | — | — | — | — |
| 3 | `state` | `character varying(12)` | No | — | — | — | — | — |
| 4 | `code` | `character varying(40)` | No | — | — | — | — | — |
| 5 | `completed_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 6 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 7 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 8 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `proposal_sending_attempts_code_not_null` | NOT NULL | `NOT NULL code` | No |
| `proposal_sending_attempts_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `proposal_sending_attempts_delivery_id_fkey` | FOREIGN KEY | `FOREIGN KEY (delivery_id) REFERENCES proposal_sending_deliveries(id)` | No |
| `proposal_sending_attempts_delivery_id_not_null` | NOT NULL | `NOT NULL delivery_id` | No |
| `proposal_sending_attempts_delivery_id_number_key` | UNIQUE | `UNIQUE (delivery_id, number)` | No |
| `proposal_sending_attempts_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `proposal_sending_attempts_number_check` | CHECK | `CHECK (number >= 1 AND number <= 4)` | No |
| `proposal_sending_attempts_number_not_null` | NOT NULL | `NOT NULL number` | No |
| `proposal_sending_attempts_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `proposal_sending_attempts_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['sent'::character varying, 'failed'::character varying, 'uncertain'::character varying]::text[]))` | No |
| `proposal_sending_attempts_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `proposal_sending_attempts_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_proposal_sending_attempts_delivery_id` | `CREATE INDEX ix_proposal_sending_attempts_delivery_id ON timeker_reference.proposal_sending_attempts USING btree (delivery_id)` |
| `proposal_sending_attempts_delivery_id_number_key` | `CREATE UNIQUE INDEX proposal_sending_attempts_delivery_id_number_key ON timeker_reference.proposal_sending_attempts USING btree (delivery_id, number)` |
| `proposal_sending_attempts_pkey` | `CREATE UNIQUE INDEX proposal_sending_attempts_pkey ON timeker_reference.proposal_sending_attempts USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `proposal_attempt_guard` | [timeker_proposal_sending_guard](04-functions-and-procedures.md#timeker_proposal_sending_guard) | — |

## proposal_sending_deliveries

Mapped class `ProposalSendingDelivery`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L22).

25 columns; 32 catalog constraints; 5 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `case_id` | `uuid` | No | FK | — | — | — | — |
| 3 | `quote_artifact_id` | `uuid` | Yes | FK | — | — | — | — |
| 4 | `library_version_id` | `uuid` | Yes | FK | — | — | — | — |
| 5 | `artifact_revision_id` | `uuid` | No | — | — | — | — | — |
| 6 | `revision_number` | `integer` | No | — | — | — | — | — |
| 7 | `document_kind` | `character varying(12)` | No | — | — | — | — | — |
| 8 | `attachment_filename` | `character varying(180)` | No | — | — | — | — | — |
| 9 | `attachment_content_type` | `character varying(100)` | No | — | — | — | — | — |
| 10 | `attachment_bytes` | `bytea` | No | — | — | — | — | — |
| 11 | `attachment_sha256` | `character varying(64)` | No | — | — | — | — | — |
| 12 | `recipient` | `character varying(254)` | No | — | — | — | — | — |
| 13 | `subject` | `character varying(200)` | No | — | — | — | — | — |
| 14 | `body` | `text` | No | — | — | — | — | — |
| 15 | `operation_key` | `uuid` | No | UNIQUE | — | — | — | — |
| 16 | `version` | `integer` | No | — | — | — | `1` | — |
| 17 | `state` | `character varying(12)` | No | — | — | — | `'draft'` | — |
| 18 | `attempt_count` | `integer` | No | — | — | — | `0` | — |
| 19 | `last_code` | `character varying(40)` | Yes | — | — | — | — | — |
| 20 | `confirmed_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 21 | `sent_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 22 | `stopped_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 23 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 24 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 25 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `proposal_sending_deliveries_artifact_revision_id_not_null` | NOT NULL | `NOT NULL artifact_revision_id` | No |
| `proposal_sending_deliveries_attachment_bytes_check` | CHECK | `CHECK (octet_length(attachment_bytes) >= 1 AND octet_length(attachment_bytes) <= 5242880)` | No |
| `proposal_sending_deliveries_attachment_bytes_not_null` | NOT NULL | `NOT NULL attachment_bytes` | No |
| `proposal_sending_deliveries_attachment_content_type_not_null` | NOT NULL | `NOT NULL attachment_content_type` | No |
| `proposal_sending_deliveries_attachment_filename_not_null` | NOT NULL | `NOT NULL attachment_filename` | No |
| `proposal_sending_deliveries_attachment_sha256_check` | CHECK | `CHECK (attachment_sha256::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `proposal_sending_deliveries_attachment_sha256_not_null` | NOT NULL | `NOT NULL attachment_sha256` | No |
| `proposal_sending_deliveries_attempt_count_not_null` | NOT NULL | `NOT NULL attempt_count` | No |
| `proposal_sending_deliveries_body_check` | CHECK | `CHECK (char_length(body) >= 1 AND char_length(body) <= 12000)` | No |
| `proposal_sending_deliveries_body_not_null` | NOT NULL | `NOT NULL body` | No |
| `proposal_sending_deliveries_case_id_fkey` | FOREIGN KEY | `FOREIGN KEY (case_id) REFERENCES cases(id)` | No |
| `proposal_sending_deliveries_case_id_not_null` | NOT NULL | `NOT NULL case_id` | No |
| `proposal_sending_deliveries_check` | CHECK | `CHECK ((quote_artifact_id IS NOT NULL) <> (library_version_id IS NOT NULL))` | No |
| `proposal_sending_deliveries_check1` | CHECK | `CHECK (revision_number >= 1 AND version >= 1 AND attempt_count >= 0 AND attempt_count <= 4)` | No |
| `proposal_sending_deliveries_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `proposal_sending_deliveries_document_kind_check` | CHECK | `CHECK (document_kind::text = ANY (ARRAY['hle'::character varying, 'msa'::character varying, 'sow'::character varying, 'sla'::character varying, 'custom'::character varying]::text[]))` | No |
| `proposal_sending_deliveries_document_kind_not_null` | NOT NULL | `NOT NULL document_kind` | No |
| `proposal_sending_deliveries_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `proposal_sending_deliveries_library_version_id_fkey` | FOREIGN KEY | `FOREIGN KEY (library_version_id) REFERENCES library_document_versions(id)` | No |
| `proposal_sending_deliveries_operation_key_not_null` | NOT NULL | `NOT NULL operation_key` | No |
| `proposal_sending_deliveries_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `proposal_sending_deliveries_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `proposal_sending_deliveries_owner_id_operation_key_key` | UNIQUE | `UNIQUE (owner_id, operation_key)` | No |
| `proposal_sending_deliveries_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `proposal_sending_deliveries_quote_artifact_id_fkey` | FOREIGN KEY | `FOREIGN KEY (quote_artifact_id) REFERENCES quote_artifacts(id)` | No |
| `proposal_sending_deliveries_recipient_not_null` | NOT NULL | `NOT NULL recipient` | No |
| `proposal_sending_deliveries_revision_number_not_null` | NOT NULL | `NOT NULL revision_number` | No |
| `proposal_sending_deliveries_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['draft'::character varying, 'sent'::character varying, 'failed'::character varying, 'uncertain'::character varying, 'stopped'::character varying]::text[]))` | No |
| `proposal_sending_deliveries_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `proposal_sending_deliveries_subject_not_null` | NOT NULL | `NOT NULL subject` | No |
| `proposal_sending_deliveries_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `proposal_sending_deliveries_version_not_null` | NOT NULL | `NOT NULL version` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_proposal_sending_deliveries_case_id` | `CREATE INDEX ix_proposal_sending_deliveries_case_id ON timeker_reference.proposal_sending_deliveries USING btree (case_id)` |
| `ix_proposal_sending_deliveries_owner_id` | `CREATE INDEX ix_proposal_sending_deliveries_owner_id ON timeker_reference.proposal_sending_deliveries USING btree (owner_id)` |
| `ix_proposal_sending_deliveries_state` | `CREATE INDEX ix_proposal_sending_deliveries_state ON timeker_reference.proposal_sending_deliveries USING btree (state)` |
| `proposal_sending_deliveries_owner_id_operation_key_key` | `CREATE UNIQUE INDEX proposal_sending_deliveries_owner_id_operation_key_key ON timeker_reference.proposal_sending_deliveries USING btree (owner_id, operation_key)` |
| `proposal_sending_deliveries_pkey` | `CREATE UNIQUE INDEX proposal_sending_deliveries_pkey ON timeker_reference.proposal_sending_deliveries USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `proposal_delivery_guard` | [timeker_proposal_sending_guard](04-functions-and-procedures.md#timeker_proposal_sending_guard) | — |

## public_email_challenges

Mapped class `PublicEmailChallenge`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L43).

13 columns; 19 catalog constraints; 5 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `destination` | `text` | No | — | — | — | — | — |
| 5 | `address_digest` | `character varying(64)` | No | — | — | — | — | — |
| 6 | `session_digest` | `character varying(64)` | No | — | — | — | — | — |
| 7 | `network_digest` | `character varying(64)` | No | — | — | — | — | — |
| 8 | `intent` | `character varying(12)` | No | — | — | — | — | — |
| 9 | `offer` | `character varying(20)` | No | — | — | — | — | — |
| 10 | `return_to` | `character varying(30)` | No | — | — | — | `''` | — |
| 11 | `state` | `character varying(12)` | No | — | — | — | `'reserved'` | — |
| 12 | `attempts` | `integer` | No | — | — | — | `0` | — |
| 13 | `expires_at` | `timestamp with time zone` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `public_email_challenges_address_digest_not_null` | NOT NULL | `NOT NULL address_digest` | No |
| `public_email_challenges_attempts_check` | CHECK | `CHECK (attempts >= 0 AND attempts <= 6)` | No |
| `public_email_challenges_attempts_not_null` | NOT NULL | `NOT NULL attempts` | No |
| `public_email_challenges_check` | CHECK | `CHECK (address_digest::text ~ '^[0-9a-f]{64}$'::text AND session_digest::text ~ '^[0-9a-f]{64}$'::text AND network_digest::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `public_email_challenges_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `public_email_challenges_destination_not_null` | NOT NULL | `NOT NULL destination` | No |
| `public_email_challenges_expires_at_not_null` | NOT NULL | `NOT NULL expires_at` | No |
| `public_email_challenges_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `public_email_challenges_intent_check` | CHECK | `CHECK (intent::text = ANY (ARRAY['signin'::character varying, 'signup'::character varying]::text[]))` | No |
| `public_email_challenges_intent_not_null` | NOT NULL | `NOT NULL intent` | No |
| `public_email_challenges_network_digest_not_null` | NOT NULL | `NOT NULL network_digest` | No |
| `public_email_challenges_offer_not_null` | NOT NULL | `NOT NULL offer` | No |
| `public_email_challenges_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `public_email_challenges_return_to_check` | CHECK | `CHECK (return_to::text = ANY (ARRAY[''::character varying, '/settings/security'::character varying]::text[]))` | No |
| `public_email_challenges_return_to_not_null` | NOT NULL | `NOT NULL return_to` | No |
| `public_email_challenges_session_digest_not_null` | NOT NULL | `NOT NULL session_digest` | No |
| `public_email_challenges_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['reserved'::character varying, 'ready'::character varying, 'uncertain'::character varying, 'verifying'::character varying, 'consumed'::character varying, 'failed'::character varying]::text[]))` | No |
| `public_email_challenges_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `public_email_challenges_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_public_email_challenges_address_digest` | `CREATE INDEX ix_public_email_challenges_address_digest ON timeker_reference.public_email_challenges USING btree (address_digest)` |
| `ix_public_email_challenges_expires_at` | `CREATE INDEX ix_public_email_challenges_expires_at ON timeker_reference.public_email_challenges USING btree (expires_at)` |
| `ix_public_email_challenges_network_digest` | `CREATE INDEX ix_public_email_challenges_network_digest ON timeker_reference.public_email_challenges USING btree (network_digest)` |
| `ix_public_email_challenges_session_digest` | `CREATE INDEX ix_public_email_challenges_session_digest ON timeker_reference.public_email_challenges USING btree (session_digest)` |
| `public_email_challenges_pkey` | `CREATE UNIQUE INDEX public_email_challenges_pkey ON timeker_reference.public_email_challenges USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `public_email_challenge_history` | [timeker_admission_history_guard](04-functions-and-procedures.md#timeker_admission_history_guard) | — |

## quote_artifacts

Mapped class `QuoteArtifact`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L105).

12 columns; 19 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `revision_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 3 | `snapshot` | `jsonb` | No | — | — | — | — | — |
| 4 | `filename` | `character varying(180)` | No | — | — | — | — | — |
| 5 | `pdf_bytes` | `bytea` | No | — | — | — | — | — |
| 6 | `size` | `integer` | No | — | — | — | — | — |
| 7 | `sha256` | `character varying(64)` | No | — | — | — | — | — |
| 8 | `renderer_version` | `character varying(80)` | No | — | — | — | — | — |
| 9 | `published_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 10 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 11 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 12 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `quote_artifacts_check` | CHECK | `CHECK (size >= 1 AND size <= 5242880 AND octet_length(pdf_bytes) = size)` | No |
| `quote_artifacts_check1` | CHECK | `CHECK (sha256::text ~ '^[0-9a-f]{64}$'::text AND jsonb_typeof(snapshot) = 'object'::text)` | No |
| `quote_artifacts_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `quote_artifacts_filename_check` | CHECK | `CHECK (length(btrim(filename::text)) >= 1 AND length(btrim(filename::text)) <= 180)` | No |
| `quote_artifacts_filename_not_null` | NOT NULL | `NOT NULL filename` | No |
| `quote_artifacts_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `quote_artifacts_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `quote_artifacts_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `quote_artifacts_pdf_bytes_not_null` | NOT NULL | `NOT NULL pdf_bytes` | No |
| `quote_artifacts_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `quote_artifacts_published_at_not_null` | NOT NULL | `NOT NULL published_at` | No |
| `quote_artifacts_renderer_version_not_null` | NOT NULL | `NOT NULL renderer_version` | No |
| `quote_artifacts_revision_id_fkey` | FOREIGN KEY | `FOREIGN KEY (revision_id) REFERENCES quote_revisions(id)` | No |
| `quote_artifacts_revision_id_key` | UNIQUE | `UNIQUE (revision_id)` | No |
| `quote_artifacts_revision_id_not_null` | NOT NULL | `NOT NULL revision_id` | No |
| `quote_artifacts_sha256_not_null` | NOT NULL | `NOT NULL sha256` | No |
| `quote_artifacts_size_not_null` | NOT NULL | `NOT NULL size` | No |
| `quote_artifacts_snapshot_not_null` | NOT NULL | `NOT NULL snapshot` | No |
| `quote_artifacts_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_quote_artifacts_owner_id` | `CREATE INDEX ix_quote_artifacts_owner_id ON timeker_reference.quote_artifacts USING btree (owner_id)` |
| `quote_artifacts_pkey` | `CREATE UNIQUE INDEX quote_artifacts_pkey ON timeker_reference.quote_artifacts USING btree (id)` |
| `quote_artifacts_revision_id_key` | `CREATE UNIQUE INDEX quote_artifacts_revision_id_key ON timeker_reference.quote_artifacts USING btree (revision_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `quote_artifact_guard` | [timeker_quote_guard](04-functions-and-procedures.md#timeker_quote_guard) | — |

## quote_lines

Mapped class `QuoteLine`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L79).

12 columns; 16 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `revision_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `position` | `integer` | No | UNIQUE | — | — | — | — |
| 3 | `label` | `character varying(500)` | No | — | — | — | — | — |
| 4 | `scope_type` | `character varying(12)` | No | — | — | — | `'task'` | — |
| 5 | `min_minutes` | `integer` | No | — | — | — | — | — |
| 6 | `max_minutes` | `integer` | No | — | — | — | — | — |
| 7 | `pricing_model` | `character varying(30)` | Yes | — | — | — | — | — |
| 8 | `unit_rate` | `numeric(14,2)` | Yes | — | — | — | — | — |
| 9 | `fixed_amount` | `numeric(14,2)` | Yes | — | — | — | — | — |
| 10 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 11 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 12 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `quote_lines_check` | CHECK | `CHECK ("position" >= 0 AND "position" <= 99 AND length(btrim(label::text)) >= 1 AND length(btrim(label::text)) <= 500)` | No |
| `quote_lines_check1` | CHECK | `CHECK (min_minutes >= 0 AND min_minutes <= 5256000 AND max_minutes >= min_minutes AND max_minutes <= 5256000)` | No |
| `quote_lines_check2` | CHECK | `CHECK (pricing_model IS NULL AND unit_rate IS NULL AND fixed_amount IS NULL OR pricing_model IS NOT NULL AND pricing_model::text = 'time_and_materials'::text AND unit_rate >= 0::numeric AND unit_rate <= 9999999999.99 AND unit_rate IS NOT NULL AND fixed_amount IS NULL OR pricing_model IS NOT NULL AND pricing_model::text = 'fixed_fee'::text AND fixed_amount >= 0::numeric AND fixed_amount <= 9999999999.99 AND fixed_amount IS NOT NULL AND unit_rate IS NULL)` | No |
| `quote_lines_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `quote_lines_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `quote_lines_label_not_null` | NOT NULL | `NOT NULL label` | No |
| `quote_lines_max_minutes_not_null` | NOT NULL | `NOT NULL max_minutes` | No |
| `quote_lines_min_minutes_not_null` | NOT NULL | `NOT NULL min_minutes` | No |
| `quote_lines_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `quote_lines_position_not_null` | NOT NULL | `NOT NULL "position"` | No |
| `quote_lines_revision_id_fkey` | FOREIGN KEY | `FOREIGN KEY (revision_id) REFERENCES quote_revisions(id)` | No |
| `quote_lines_revision_id_not_null` | NOT NULL | `NOT NULL revision_id` | No |
| `quote_lines_revision_id_position_key` | UNIQUE | `UNIQUE (revision_id, "position")` | No |
| `quote_lines_scope_type_check` | CHECK | `CHECK (scope_type::text = ANY (ARRAY['task'::character varying, 'case'::character varying, 'project'::character varying]::text[]))` | No |
| `quote_lines_scope_type_not_null` | NOT NULL | `NOT NULL scope_type` | No |
| `quote_lines_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_quote_lines_revision_id` | `CREATE INDEX ix_quote_lines_revision_id ON timeker_reference.quote_lines USING btree (revision_id)` |
| `quote_lines_pkey` | `CREATE UNIQUE INDEX quote_lines_pkey ON timeker_reference.quote_lines USING btree (id)` |
| `quote_lines_revision_id_position_key` | `CREATE UNIQUE INDEX quote_lines_revision_id_position_key ON timeker_reference.quote_lines USING btree (revision_id, "position")` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `quote_line_guard` | [timeker_quote_guard](04-functions-and-procedures.md#timeker_quote_guard) | — |

## quote_revisions

Mapped class `QuoteRevision`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L46).

19 columns; 29 catalog constraints; 7 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `quote_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `parent_revision_id` | `uuid` | Yes | FK | — | — | — | — |
| 3 | `number` | `integer` | No | UNIQUE | — | — | — | — |
| 4 | `status` | `character varying(12)` | No | — | — | — | `'draft'` | — |
| 5 | `title` | `character varying(200)` | No | — | — | — | — | — |
| 6 | `prepared_for` | `character varying(200)` | Yes | — | — | — | — | — |
| 7 | `case_id` | `uuid` | No | FK | — | — | — | — |
| 8 | `client_id` | `uuid` | No | FK | — | — | — | — |
| 9 | `project_id` | `uuid` | No | FK | — | — | — | — |
| 10 | `preset` | `character varying(30)` | No | — | — | — | `'quick_effort'` | — |
| 11 | `currency` | `character varying(3)` | Yes | — | — | — | — | — |
| 12 | `assumptions` | `text` | Yes | — | — | — | — | — |
| 13 | `exclusions` | `text` | Yes | — | — | — | — | — |
| 14 | `valid_until` | `date` | Yes | — | — | — | — | — |
| 15 | `version` | `integer` | No | — | — | — | `1` | — |
| 16 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 17 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 18 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 19 | `flexfields` | `jsonb` | No | — | `'{}'::jsonb` | — | `Python callable: dict` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `quote_revisions_assumptions_check` | CHECK | `CHECK (assumptions IS NULL OR length(assumptions) <= 20000)` | No |
| `quote_revisions_case_id_fkey` | FOREIGN KEY | `FOREIGN KEY (case_id) REFERENCES cases(id)` | No |
| `quote_revisions_case_id_not_null` | NOT NULL | `NOT NULL case_id` | No |
| `quote_revisions_check` | CHECK | `CHECK (number >= 1 AND number <= 100 AND version > 0)` | No |
| `quote_revisions_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `quote_revisions_client_id_not_null` | NOT NULL | `NOT NULL client_id` | No |
| `quote_revisions_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `quote_revisions_currency_check` | CHECK | `CHECK (currency IS NULL OR currency::text ~ '^[A-Z]{3}$'::text)` | No |
| `quote_revisions_exclusions_check` | CHECK | `CHECK (exclusions IS NULL OR length(exclusions) <= 20000)` | No |
| `quote_revisions_flexfields_not_null` | NOT NULL | `NOT NULL flexfields` | No |
| `quote_revisions_flexfields_valid` | CHECK | `CHECK (jsonb_typeof(flexfields) = 'object'::text AND (flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb AND (NOT flexfields ? 'flexfield1'::text OR (flexfields -> 'flexfield1'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield1'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield1'::text) <= 250) AND (NOT flexfields ? 'flexfield2'::text OR (flexfields -> 'flexfield2'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield2'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield2'::text) <= 250) AND (NOT flexfields ? 'flexfield3'::text OR (flexfields -> 'flexfield3'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield3'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield3'::text) <= 250) AND (NOT flexfields ? 'flexfield4'::text OR (flexfields -> 'flexfield4'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield4'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield4'::text) <= 250) AND (NOT flexfields ? 'flexfield5'::text OR (flexfields -> 'flexfield5'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield5'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield5'::text) <= 250) AND (NOT flexfields ? 'flexfield6'::text OR (flexfields -> 'flexfield6'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield6'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield6'::text) <= 250) AND (NOT flexfields ? 'flexfield7'::text OR (flexfields -> 'flexfield7'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield7'::text) = 'string'::text AND (flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text) AND (NOT flexfields ? 'flexfield8'::text OR (flexfields -> 'flexfield8'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield8'::text) = 'string'::text AND (flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))` | No |
| `quote_revisions_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `quote_revisions_number_not_null` | NOT NULL | `NOT NULL number` | No |
| `quote_revisions_parent_revision_id_fkey` | FOREIGN KEY | `FOREIGN KEY (parent_revision_id) REFERENCES quote_revisions(id)` | No |
| `quote_revisions_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `quote_revisions_prepared_for_check` | CHECK | `CHECK (prepared_for IS NULL OR length(prepared_for::text) <= 200)` | No |
| `quote_revisions_preset_check` | CHECK | `CHECK (preset::text = ANY (ARRAY['quick_effort'::character varying, 'time_and_materials'::character varying, 'fixed_fee'::character varying]::text[]))` | No |
| `quote_revisions_preset_not_null` | NOT NULL | `NOT NULL preset` | No |
| `quote_revisions_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `quote_revisions_project_id_not_null` | NOT NULL | `NOT NULL project_id` | No |
| `quote_revisions_quote_id_fkey` | FOREIGN KEY | `FOREIGN KEY (quote_id) REFERENCES quotes(id)` | No |
| `quote_revisions_quote_id_not_null` | NOT NULL | `NOT NULL quote_id` | No |
| `quote_revisions_quote_id_number_key` | UNIQUE | `UNIQUE (quote_id, number)` | No |
| `quote_revisions_status_check` | CHECK | `CHECK (status::text = ANY (ARRAY['draft'::character varying, 'published'::character varying]::text[]))` | No |
| `quote_revisions_status_not_null` | NOT NULL | `NOT NULL status` | No |
| `quote_revisions_title_check` | CHECK | `CHECK (length(btrim(title::text)) >= 1 AND length(btrim(title::text)) <= 200)` | No |
| `quote_revisions_title_not_null` | NOT NULL | `NOT NULL title` | No |
| `quote_revisions_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `quote_revisions_version_not_null` | NOT NULL | `NOT NULL version` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_quote_revisions_case_id` | `CREATE INDEX ix_quote_revisions_case_id ON timeker_reference.quote_revisions USING btree (case_id)` |
| `ix_quote_revisions_client_id` | `CREATE INDEX ix_quote_revisions_client_id ON timeker_reference.quote_revisions USING btree (client_id)` |
| `ix_quote_revisions_project_id` | `CREATE INDEX ix_quote_revisions_project_id ON timeker_reference.quote_revisions USING btree (project_id)` |
| `ix_quote_revisions_quote_id` | `CREATE INDEX ix_quote_revisions_quote_id ON timeker_reference.quote_revisions USING btree (quote_id)` |
| `quote_one_draft` | `CREATE UNIQUE INDEX quote_one_draft ON timeker_reference.quote_revisions USING btree (quote_id) WHERE ((status)::text = 'draft'::text)` |
| `quote_revisions_pkey` | `CREATE UNIQUE INDEX quote_revisions_pkey ON timeker_reference.quote_revisions USING btree (id)` |
| `quote_revisions_quote_id_number_key` | `CREATE UNIQUE INDEX quote_revisions_quote_id_number_key ON timeker_reference.quote_revisions USING btree (quote_id, number)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `quote_revision_guard` | [timeker_quote_guard](04-functions-and-procedures.md#timeker_quote_guard) | — |

## quotes

Mapped class `Quote`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L30).

9 columns; 13 catalog constraints; 5 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `number` | `bigint` | No | UNIQUE | — | `a` | — | — |
| 3 | `operation_key` | `uuid` | No | UNIQUE | — | — | `Python callable: uuid4` | — |
| 4 | `create_digest` | `character varying(64)` | No | — | — | — | — | — |
| 5 | `archived_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 6 | `version` | `integer` | No | — | — | — | `1` | — |
| 7 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 8 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 9 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `quotes_check` | CHECK | `CHECK (number > 0 AND version > 0 AND create_digest::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `quotes_create_digest_not_null` | NOT NULL | `NOT NULL create_digest` | No |
| `quotes_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `quotes_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `quotes_number_key` | UNIQUE | `UNIQUE (number)` | No |
| `quotes_number_not_null` | NOT NULL | `NOT NULL number` | No |
| `quotes_operation_key_not_null` | NOT NULL | `NOT NULL operation_key` | No |
| `quotes_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `quotes_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `quotes_owner_id_operation_key_key` | UNIQUE | `UNIQUE (owner_id, operation_key)` | No |
| `quotes_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `quotes_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `quotes_version_not_null` | NOT NULL | `NOT NULL version` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_quotes_archived_at` | `CREATE INDEX ix_quotes_archived_at ON timeker_reference.quotes USING btree (archived_at)` |
| `ix_quotes_owner_id` | `CREATE INDEX ix_quotes_owner_id ON timeker_reference.quotes USING btree (owner_id)` |
| `quotes_number_key` | `CREATE UNIQUE INDEX quotes_number_key ON timeker_reference.quotes USING btree (number)` |
| `quotes_owner_id_operation_key_key` | `CREATE UNIQUE INDEX quotes_owner_id_operation_key_key ON timeker_reference.quotes USING btree (owner_id, operation_key)` |
| `quotes_pkey` | `CREATE UNIQUE INDEX quotes_pkey ON timeker_reference.quotes USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `quote_root_guard` | [timeker_quote_guard](04-functions-and-procedures.md#timeker_quote_guard) | — |

## sending_attempts

Mapped class `SendingAttempt`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L72).

9 columns; 12 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `delivery_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `number` | `integer` | No | UNIQUE | — | — | — | — |
| 6 | `state` | `character varying(12)` | No | — | — | — | — | — |
| 7 | `code` | `character varying(40)` | No | — | — | — | — | — |
| 8 | `provider_reference` | `character varying(200)` | Yes | — | — | — | — | — |
| 9 | `completed_at` | `timestamp with time zone` | Yes | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `sending_attempts_code_not_null` | NOT NULL | `NOT NULL code` | No |
| `sending_attempts_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `sending_attempts_delivery_id_fkey` | FOREIGN KEY | `FOREIGN KEY (delivery_id) REFERENCES sending_deliveries(id)` | No |
| `sending_attempts_delivery_id_not_null` | NOT NULL | `NOT NULL delivery_id` | No |
| `sending_attempts_delivery_id_number_key` | UNIQUE | `UNIQUE (delivery_id, number)` | No |
| `sending_attempts_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `sending_attempts_number_check` | CHECK | `CHECK (number >= 1 AND number <= 4)` | No |
| `sending_attempts_number_not_null` | NOT NULL | `NOT NULL number` | No |
| `sending_attempts_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `sending_attempts_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['sent'::character varying, 'failed'::character varying, 'stopped'::character varying, 'uncertain'::character varying]::text[]))` | No |
| `sending_attempts_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `sending_attempts_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_sending_attempts_delivery_id` | `CREATE INDEX ix_sending_attempts_delivery_id ON timeker_reference.sending_attempts USING btree (delivery_id)` |
| `sending_attempts_delivery_id_number_key` | `CREATE UNIQUE INDEX sending_attempts_delivery_id_number_key ON timeker_reference.sending_attempts USING btree (delivery_id, number)` |
| `sending_attempts_pkey` | `CREATE UNIQUE INDEX sending_attempts_pkey ON timeker_reference.sending_attempts USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `sending_attempt_history` | [timeker_sending_guard](04-functions-and-procedures.md#timeker_sending_guard) | — |

## sending_deliveries

Mapped class `SendingDelivery`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L55).

11 columns; 15 catalog constraints; 6 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 5 | `plan_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 6 | `sequence` | `integer` | No | UNIQUE | — | — | — | — |
| 7 | `state` | `character varying(12)` | No | — | — | — | `'pending'` | — |
| 8 | `scheduled_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 9 | `sent_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 10 | `failure_code` | `character varying(40)` | Yes | — | — | — | — | — |
| 11 | `attempt_count` | `integer` | No | — | — | — | `0` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `sending_deliveries_attempt_count_not_null` | NOT NULL | `NOT NULL attempt_count` | No |
| `sending_deliveries_check` | CHECK | `CHECK (sequence >= 0 AND sequence <= 6 AND attempt_count >= 0 AND attempt_count <= 4)` | No |
| `sending_deliveries_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `sending_deliveries_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `sending_deliveries_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `sending_deliveries_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `sending_deliveries_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `sending_deliveries_plan_id_fkey` | FOREIGN KEY | `FOREIGN KEY (plan_id) REFERENCES sending_plans(id)` | No |
| `sending_deliveries_plan_id_not_null` | NOT NULL | `NOT NULL plan_id` | No |
| `sending_deliveries_plan_id_sequence_key` | UNIQUE | `UNIQUE (plan_id, sequence)` | No |
| `sending_deliveries_scheduled_at_not_null` | NOT NULL | `NOT NULL scheduled_at` | No |
| `sending_deliveries_sequence_not_null` | NOT NULL | `NOT NULL sequence` | No |
| `sending_deliveries_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['pending'::character varying, 'sent'::character varying, 'failed'::character varying, 'stopped'::character varying, 'uncertain'::character varying]::text[]))` | No |
| `sending_deliveries_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `sending_deliveries_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_sending_deliveries_owner_id` | `CREATE INDEX ix_sending_deliveries_owner_id ON timeker_reference.sending_deliveries USING btree (owner_id)` |
| `ix_sending_deliveries_plan_id` | `CREATE INDEX ix_sending_deliveries_plan_id ON timeker_reference.sending_deliveries USING btree (plan_id)` |
| `ix_sending_deliveries_scheduled_at` | `CREATE INDEX ix_sending_deliveries_scheduled_at ON timeker_reference.sending_deliveries USING btree (scheduled_at)` |
| `ix_sending_deliveries_state` | `CREATE INDEX ix_sending_deliveries_state ON timeker_reference.sending_deliveries USING btree (state)` |
| `sending_deliveries_pkey` | `CREATE UNIQUE INDEX sending_deliveries_pkey ON timeker_reference.sending_deliveries USING btree (id)` |
| `sending_deliveries_plan_id_sequence_key` | `CREATE UNIQUE INDEX sending_deliveries_plan_id_sequence_key ON timeker_reference.sending_deliveries USING btree (plan_id, sequence)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `sending_delivery_history` | [timeker_sending_guard](04-functions-and-procedures.md#timeker_sending_guard) | — |

## sending_plans

Mapped class `SendingPlan`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L31).

16 columns; 22 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 5 | `invoice_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 6 | `artifact_id` | `uuid` | No | FK | — | — | — | — |
| 7 | `artifact_sha256` | `character varying(64)` | No | — | — | — | — | — |
| 8 | `recipient` | `character varying(254)` | No | — | — | — | — | — |
| 9 | `subject` | `character varying(200)` | No | — | — | — | — | — |
| 10 | `body` | `text` | No | — | — | — | — | — |
| 11 | `followup_subject` | `character varying(200)` | No | — | — | — | — | — |
| 12 | `followup_body` | `text` | No | — | — | — | — | — |
| 13 | `followup_interval_days` | `integer` | No | — | — | — | — | — |
| 14 | `followup_max` | `integer` | No | — | — | — | — | — |
| 15 | `stopped_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 16 | `stop_reason` | `character varying(30)` | Yes | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `sending_plans_artifact_id_fkey` | FOREIGN KEY | `FOREIGN KEY (artifact_id) REFERENCES invoice_artifacts(id)` | No |
| `sending_plans_artifact_id_not_null` | NOT NULL | `NOT NULL artifact_id` | No |
| `sending_plans_artifact_sha256_check` | CHECK | `CHECK (artifact_sha256::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `sending_plans_artifact_sha256_not_null` | NOT NULL | `NOT NULL artifact_sha256` | No |
| `sending_plans_body_not_null` | NOT NULL | `NOT NULL body` | No |
| `sending_plans_check` | CHECK | `CHECK (followup_max = 0 AND followup_interval_days = 0 OR followup_max > 0 AND followup_interval_days >= 1 AND followup_interval_days <= 90)` | No |
| `sending_plans_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `sending_plans_followup_body_not_null` | NOT NULL | `NOT NULL followup_body` | No |
| `sending_plans_followup_interval_days_not_null` | NOT NULL | `NOT NULL followup_interval_days` | No |
| `sending_plans_followup_max_check` | CHECK | `CHECK (followup_max >= 0 AND followup_max <= 6)` | No |
| `sending_plans_followup_max_not_null` | NOT NULL | `NOT NULL followup_max` | No |
| `sending_plans_followup_subject_not_null` | NOT NULL | `NOT NULL followup_subject` | No |
| `sending_plans_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `sending_plans_invoice_id_fkey` | FOREIGN KEY | `FOREIGN KEY (invoice_id) REFERENCES invoices(id)` | No |
| `sending_plans_invoice_id_key` | UNIQUE | `UNIQUE (invoice_id)` | No |
| `sending_plans_invoice_id_not_null` | NOT NULL | `NOT NULL invoice_id` | No |
| `sending_plans_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `sending_plans_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `sending_plans_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `sending_plans_recipient_not_null` | NOT NULL | `NOT NULL recipient` | No |
| `sending_plans_subject_not_null` | NOT NULL | `NOT NULL subject` | No |
| `sending_plans_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_sending_plans_owner_id` | `CREATE INDEX ix_sending_plans_owner_id ON timeker_reference.sending_plans USING btree (owner_id)` |
| `sending_plans_invoice_id_key` | `CREATE UNIQUE INDEX sending_plans_invoice_id_key ON timeker_reference.sending_plans USING btree (invoice_id)` |
| `sending_plans_pkey` | `CREATE UNIQUE INDEX sending_plans_pkey ON timeker_reference.sending_plans USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `sending_plan_history` | [timeker_sending_guard](04-functions-and-procedures.md#timeker_sending_guard) | — |

## sending_preferences

Mapped class `SendingPreferences`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L21).

9 columns; 12 catalog constraints; 2 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `paused` | `boolean` | No | — | — | — | `False` | — |
| 6 | `initial_subject` | `character varying(200)` | No | — | — | — | — | — |
| 7 | `initial_body` | `text` | No | — | — | — | — | — |
| 8 | `followup_subject` | `character varying(200)` | No | — | — | — | — | — |
| 9 | `followup_body` | `text` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `sending_preferences_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `sending_preferences_followup_body_not_null` | NOT NULL | `NOT NULL followup_body` | No |
| `sending_preferences_followup_subject_not_null` | NOT NULL | `NOT NULL followup_subject` | No |
| `sending_preferences_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `sending_preferences_initial_body_not_null` | NOT NULL | `NOT NULL initial_body` | No |
| `sending_preferences_initial_subject_not_null` | NOT NULL | `NOT NULL initial_subject` | No |
| `sending_preferences_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `sending_preferences_owner_id_key` | UNIQUE | `UNIQUE (owner_id)` | No |
| `sending_preferences_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `sending_preferences_paused_not_null` | NOT NULL | `NOT NULL paused` | No |
| `sending_preferences_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `sending_preferences_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `sending_preferences_owner_id_key` | `CREATE UNIQUE INDEX sending_preferences_owner_id_key ON timeker_reference.sending_preferences USING btree (owner_id)` |
| `sending_preferences_pkey` | `CREATE UNIQUE INDEX sending_preferences_pkey ON timeker_reference.sending_preferences USING btree (id)` |

### Application triggers

None.

## subscription_billing_accounts

Mapped class `BillingAccount`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L24).

22 columns; 24 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `integer` | No | PK | — | `d` | — | — |
| 2 | `current` | `boolean` | No | — | — | — | `True` | — |
| 3 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 4 | `customer_id` | `character varying(30)` | No | — | — | — | — | — |
| 5 | `subscription_id` | `character varying(30)` | No | UNIQUE | — | — | — | — |
| 6 | `checkout_id` | `uuid` | No | FK | — | — | — | — |
| 7 | `provider_status` | `character varying(12)` | No | — | — | — | — | — |
| 8 | `provider_offer` | `character varying(20)` | No | — | — | — | — | — |
| 9 | `entitlement_offer` | `character varying(20)` | No | — | — | — | — | — |
| 10 | `paid_through` | `timestamp with time zone` | No | — | — | — | — | — |
| 11 | `proven_period_start` | `timestamp with time zone` | No | — | — | — | — | — |
| 12 | `past_due_since` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 13 | `failed_period_start` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 14 | `failed_transaction_id` | `character varying(30)` | Yes | — | — | — | — | — |
| 15 | `provider_updated_at` | `timestamp with time zone` | No | — | — | — | — | — |
| 16 | `pending_offer` | `character varying(20)` | Yes | — | — | — | — | — |
| 17 | `pending_effective_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 18 | `pending_selection` | `jsonb` | Yes | — | — | — | — | — |
| 19 | `requires_selection` | `boolean` | No | — | — | — | `False` | — |
| 20 | `version` | `integer` | No | — | — | — | `1` | — |
| 21 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 22 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `subscription_billing_accounts_check` | CHECK | `CHECK (id > 0 AND version > 0)` | No |
| `subscription_billing_accounts_check1` | CHECK | `CHECK (paid_through > proven_period_start)` | No |
| `subscription_billing_accounts_check2` | CHECK | `CHECK (customer_id::text ~ '^ctm_[a-z0-9]{26}$'::text AND subscription_id::text ~ '^sub_[a-z0-9]{26}$'::text)` | No |
| `subscription_billing_accounts_checkout_id_fkey` | FOREIGN KEY | `FOREIGN KEY (checkout_id) REFERENCES subscription_billing_operations(id)` | No |
| `subscription_billing_accounts_checkout_id_not_null` | NOT NULL | `NOT NULL checkout_id` | No |
| `subscription_billing_accounts_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `subscription_billing_accounts_current_not_null` | NOT NULL | `NOT NULL current` | No |
| `subscription_billing_accounts_customer_id_not_null` | NOT NULL | `NOT NULL customer_id` | No |
| `subscription_billing_accounts_entitlement_offer_not_null` | NOT NULL | `NOT NULL entitlement_offer` | No |
| `subscription_billing_accounts_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `subscription_billing_accounts_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `subscription_billing_accounts_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `subscription_billing_accounts_paid_through_not_null` | NOT NULL | `NOT NULL paid_through` | No |
| `subscription_billing_accounts_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `subscription_billing_accounts_proven_period_start_not_null` | NOT NULL | `NOT NULL proven_period_start` | No |
| `subscription_billing_accounts_provider_offer_not_null` | NOT NULL | `NOT NULL provider_offer` | No |
| `subscription_billing_accounts_provider_status_check` | CHECK | `CHECK (provider_status::text = ANY (ARRAY['active'::character varying, 'canceled'::character varying, 'past_due'::character varying, 'paused'::character varying, 'trialing'::character varying]::text[]))` | No |
| `subscription_billing_accounts_provider_status_not_null` | NOT NULL | `NOT NULL provider_status` | No |
| `subscription_billing_accounts_provider_updated_at_not_null` | NOT NULL | `NOT NULL provider_updated_at` | No |
| `subscription_billing_accounts_requires_selection_not_null` | NOT NULL | `NOT NULL requires_selection` | No |
| `subscription_billing_accounts_subscription_id_key` | UNIQUE | `UNIQUE (subscription_id)` | No |
| `subscription_billing_accounts_subscription_id_not_null` | NOT NULL | `NOT NULL subscription_id` | No |
| `subscription_billing_accounts_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `subscription_billing_accounts_version_not_null` | NOT NULL | `NOT NULL version` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `subscription_billing_accounts_pkey` | `CREATE UNIQUE INDEX subscription_billing_accounts_pkey ON timeker_reference.subscription_billing_accounts USING btree (id)` |
| `subscription_billing_accounts_subscription_id_key` | `CREATE UNIQUE INDEX subscription_billing_accounts_subscription_id_key ON timeker_reference.subscription_billing_accounts USING btree (subscription_id)` |
| `subscription_billing_current_owner` | `CREATE UNIQUE INDEX subscription_billing_current_owner ON timeker_reference.subscription_billing_accounts USING btree (owner_id) WHERE current` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `subscription_billing_account_history` | [timeker_subscription_billing_guard](04-functions-and-procedures.md#timeker_subscription_billing_guard) | — |

## subscription_billing_events

Mapped class `BillingEvent`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L89).

8 columns; 12 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `provider_event_id` | `character varying(30)` | No | UNIQUE | — | — | — | — |
| 3 | `raw_digest` | `character varying(64)` | No | — | — | — | — | — |
| 4 | `event_type` | `character varying(80)` | No | — | — | — | — | — |
| 5 | `outcome` | `character varying(24)` | No | — | — | — | — | — |
| 6 | `facts` | `jsonb` | No | — | — | — | — | — |
| 7 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 8 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `subscription_billing_events_check` | CHECK | `CHECK (provider_event_id::text ~ '^evt_[a-z0-9]{26}$'::text AND raw_digest::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `subscription_billing_events_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `subscription_billing_events_event_type_not_null` | NOT NULL | `NOT NULL event_type` | No |
| `subscription_billing_events_facts_check` | CHECK | `CHECK (jsonb_typeof(facts) = 'object'::text)` | No |
| `subscription_billing_events_facts_not_null` | NOT NULL | `NOT NULL facts` | No |
| `subscription_billing_events_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `subscription_billing_events_outcome_not_null` | NOT NULL | `NOT NULL outcome` | No |
| `subscription_billing_events_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `subscription_billing_events_provider_event_id_key` | UNIQUE | `UNIQUE (provider_event_id)` | No |
| `subscription_billing_events_provider_event_id_not_null` | NOT NULL | `NOT NULL provider_event_id` | No |
| `subscription_billing_events_raw_digest_not_null` | NOT NULL | `NOT NULL raw_digest` | No |
| `subscription_billing_events_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `subscription_billing_events_pkey` | `CREATE UNIQUE INDEX subscription_billing_events_pkey ON timeker_reference.subscription_billing_events USING btree (id)` |
| `subscription_billing_events_provider_event_id_key` | `CREATE UNIQUE INDEX subscription_billing_events_provider_event_id_key ON timeker_reference.subscription_billing_events USING btree (provider_event_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `subscription_billing_event_history` | [timeker_subscription_billing_guard](04-functions-and-procedures.md#timeker_subscription_billing_guard) | — |

## subscription_billing_operations

Mapped class `BillingOperation`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L71).

11 columns; 17 catalog constraints; 3 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 3 | `key_digest` | `character varying(64)` | No | UNIQUE | — | — | — | — |
| 4 | `payload_digest` | `character varying(64)` | No | — | — | — | — | — |
| 5 | `action` | `character varying(30)` | No | — | — | — | — | — |
| 6 | `state` | `character varying(12)` | No | — | — | — | `'reserved'` | — |
| 7 | `intent` | `jsonb` | No | — | — | — | — | — |
| 8 | `transaction_id` | `character varying(30)` | Yes | UNIQUE | — | — | — | — |
| 9 | `result` | `jsonb` | No | — | — | — | `Python callable: dict` | — |
| 10 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 11 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `subscription_billing_operations_action_not_null` | NOT NULL | `NOT NULL action` | No |
| `subscription_billing_operations_check` | CHECK | `CHECK (key_digest::text ~ '^[0-9a-f]{64}$'::text AND payload_digest::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `subscription_billing_operations_check1` | CHECK | `CHECK (jsonb_typeof(intent) = 'object'::text AND jsonb_typeof(result) = 'object'::text)` | No |
| `subscription_billing_operations_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `subscription_billing_operations_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `subscription_billing_operations_intent_not_null` | NOT NULL | `NOT NULL intent` | No |
| `subscription_billing_operations_key_digest_not_null` | NOT NULL | `NOT NULL key_digest` | No |
| `subscription_billing_operations_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `subscription_billing_operations_owner_id_key_digest_key` | UNIQUE | `UNIQUE (owner_id, key_digest)` | No |
| `subscription_billing_operations_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `subscription_billing_operations_payload_digest_not_null` | NOT NULL | `NOT NULL payload_digest` | No |
| `subscription_billing_operations_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `subscription_billing_operations_result_not_null` | NOT NULL | `NOT NULL result` | No |
| `subscription_billing_operations_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['reserved'::character varying, 'confirmed'::character varying, 'uncertain'::character varying, 'failed'::character varying]::text[]))` | No |
| `subscription_billing_operations_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `subscription_billing_operations_transaction_id_key` | UNIQUE | `UNIQUE (transaction_id)` | No |
| `subscription_billing_operations_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `subscription_billing_operations_owner_id_key_digest_key` | `CREATE UNIQUE INDEX subscription_billing_operations_owner_id_key_digest_key ON timeker_reference.subscription_billing_operations USING btree (owner_id, key_digest)` |
| `subscription_billing_operations_pkey` | `CREATE UNIQUE INDEX subscription_billing_operations_pkey ON timeker_reference.subscription_billing_operations USING btree (id)` |
| `subscription_billing_operations_transaction_id_key` | `CREATE UNIQUE INDEX subscription_billing_operations_transaction_id_key ON timeker_reference.subscription_billing_operations USING btree (transaction_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `subscription_billing_operation_history` | [timeker_subscription_billing_guard](04-functions-and-procedures.md#timeker_subscription_billing_guard) | — |

## subscription_operations

Mapped class `SubscriptionOperation`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L37).

8 columns; 13 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 3 | `key_digest` | `character varying(64)` | No | UNIQUE | — | — | — | — |
| 4 | `payload_digest` | `character varying(64)` | No | — | — | — | — | — |
| 5 | `action` | `character varying(80)` | No | — | — | — | — | — |
| 6 | `result` | `jsonb` | No | — | — | — | — | — |
| 7 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 8 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `subscription_operations_action_not_null` | NOT NULL | `NOT NULL action` | No |
| `subscription_operations_check` | CHECK | `CHECK (key_digest::text ~ '^[0-9a-f]{64}$'::text AND payload_digest::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `subscription_operations_check1` | CHECK | `CHECK (length(action::text) >= 1 AND length(action::text) <= 80 AND jsonb_typeof(result) = 'object'::text)` | No |
| `subscription_operations_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `subscription_operations_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `subscription_operations_key_digest_not_null` | NOT NULL | `NOT NULL key_digest` | No |
| `subscription_operations_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `subscription_operations_owner_id_key_digest_key` | UNIQUE | `UNIQUE (owner_id, key_digest)` | No |
| `subscription_operations_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `subscription_operations_payload_digest_not_null` | NOT NULL | `NOT NULL payload_digest` | No |
| `subscription_operations_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `subscription_operations_result_not_null` | NOT NULL | `NOT NULL result` | No |
| `subscription_operations_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `subscription_operations_owner_id_key_digest_key` | `CREATE UNIQUE INDEX subscription_operations_owner_id_key_digest_key ON timeker_reference.subscription_operations USING btree (owner_id, key_digest)` |
| `subscription_operations_pkey` | `CREATE UNIQUE INDEX subscription_operations_pkey ON timeker_reference.subscription_operations USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `subscription_operation_history` | [timeker_subscription_history_guard](04-functions-and-procedures.md#timeker_subscription_history_guard) | — |

## time_contributions

Mapped class `TimeContribution`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L26).

15 columns; 24 catalog constraints; 4 indexes; 2 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `actor_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `source` | `character varying(100)` | No | UNIQUE | — | — | — | — |
| 6 | `source_item_id` | `character varying(128)` | No | UNIQUE | — | — | — | — |
| 7 | `import_record_id` | `uuid` | Yes | FK | — | — | — | — |
| 8 | `timecard_id` | `uuid` | No | FK | — | — | — | — |
| 9 | `project_id` | `uuid` | No | FK | — | — | — | — |
| 10 | `work_date` | `date` | No | — | — | — | — | — |
| 11 | `entry_id` | `uuid` | Yes | FK | — | — | — | — |
| 12 | `case_id` | `uuid` | Yes | FK | — | — | — | — |
| 13 | `minutes` | `integer` | No | — | — | — | — | — |
| 14 | `description` | `text` | No | — | — | — | `''` | — |
| 15 | `version` | `integer` | No | — | — | — | `1` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `contribution_allocation_check` | CONSTRAINT TRIGGER | `TRIGGER DEFERRABLE INITIALLY DEFERRED` | Initially deferred |
| `time_contributions_actor_id_fkey` | FOREIGN KEY | `FOREIGN KEY (actor_id) REFERENCES users(id)` | No |
| `time_contributions_actor_id_not_null` | NOT NULL | `NOT NULL actor_id` | No |
| `time_contributions_actor_id_source_source_item_id_key` | UNIQUE | `UNIQUE (actor_id, source, source_item_id)` | No |
| `time_contributions_case_id_fkey` | FOREIGN KEY | `FOREIGN KEY (case_id) REFERENCES cases(id)` | No |
| `time_contributions_check` | CHECK | `CHECK (minutes = 0 OR entry_id IS NOT NULL)` | No |
| `time_contributions_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `time_contributions_description_check` | CHECK | `CHECK (char_length(description) <= 2000)` | No |
| `time_contributions_description_not_null` | NOT NULL | `NOT NULL description` | No |
| `time_contributions_entry_id_fkey` | FOREIGN KEY | `FOREIGN KEY (entry_id) REFERENCES time_entries(id)` | No |
| `time_contributions_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `time_contributions_import_record_id_fkey` | FOREIGN KEY | `FOREIGN KEY (import_record_id) REFERENCES time_import_records(id)` | No |
| `time_contributions_minutes_check` | CHECK | `CHECK (minutes >= 0 AND minutes <= 1440)` | No |
| `time_contributions_minutes_not_null` | NOT NULL | `NOT NULL minutes` | No |
| `time_contributions_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `time_contributions_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `time_contributions_project_id_not_null` | NOT NULL | `NOT NULL project_id` | No |
| `time_contributions_source_item_id_not_null` | NOT NULL | `NOT NULL source_item_id` | No |
| `time_contributions_source_not_null` | NOT NULL | `NOT NULL source` | No |
| `time_contributions_timecard_id_fkey` | FOREIGN KEY | `FOREIGN KEY (timecard_id) REFERENCES timecards(id)` | No |
| `time_contributions_timecard_id_not_null` | NOT NULL | `NOT NULL timecard_id` | No |
| `time_contributions_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `time_contributions_version_not_null` | NOT NULL | `NOT NULL version` | No |
| `time_contributions_work_date_not_null` | NOT NULL | `NOT NULL work_date` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_time_contributions_entry_id` | `CREATE INDEX ix_time_contributions_entry_id ON timeker_reference.time_contributions USING btree (entry_id)` |
| `ix_time_contributions_timecard_id` | `CREATE INDEX ix_time_contributions_timecard_id ON timeker_reference.time_contributions USING btree (timecard_id)` |
| `time_contributions_actor_id_source_source_item_id_key` | `CREATE UNIQUE INDEX time_contributions_actor_id_source_source_item_id_key ON timeker_reference.time_contributions USING btree (actor_id, source, source_item_id)` |
| `time_contributions_pkey` | `CREATE UNIQUE INDEX time_contributions_pkey ON timeker_reference.time_contributions USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `contribution_allocation_check` | [timeker_contribution_allocation_check](04-functions-and-procedures.md#timeker_contribution_allocation_check) | `contribution_allocation_check` |
| `contribution_guard` | [timeker_contribution_guard](04-functions-and-procedures.md#timeker_contribution_guard) | — |

## time_entries

Mapped class `TimeEntry`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L215).

11 columns; 13 catalog constraints; 5 indexes; 3 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `timecard_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `project_id` | `uuid` | Yes | FK, UNIQUE | — | — | — | — |
| 3 | `work_date` | `date` | No | UNIQUE | — | — | — | — |
| 4 | `minutes` | `integer` | No | — | — | — | — | — |
| 5 | `category` | `character varying(40)` | No | — | — | — | `'consulting'` | — |
| 6 | `description` | `text` | Yes | — | — | — | — | — |
| 7 | `billable` | `boolean` | No | — | — | — | `True` | — |
| 8 | `rate_override` | `numeric(14,2)` | Yes | — | — | — | — | — |
| 9 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 10 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 11 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `time_entries_billable_not_null` | NOT NULL | `NOT NULL billable` | No |
| `time_entries_category_not_null` | NOT NULL | `NOT NULL category` | No |
| `time_entries_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `time_entries_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `time_entries_minutes_check` | CHECK | `CHECK (minutes >= 1 AND minutes <= 1440)` | No |
| `time_entries_minutes_not_null` | NOT NULL | `NOT NULL minutes` | No |
| `time_entries_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `time_entries_project_id_fkey` | FOREIGN KEY | `FOREIGN KEY (project_id) REFERENCES projects(id)` | No |
| `time_entries_timecard_id_fkey` | FOREIGN KEY | `FOREIGN KEY (timecard_id) REFERENCES timecards(id)` | No |
| `time_entries_timecard_id_not_null` | NOT NULL | `NOT NULL timecard_id` | No |
| `time_entries_timecard_id_project_id_work_date_key` | UNIQUE | `UNIQUE (timecard_id, project_id, work_date)` | No |
| `time_entries_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `time_entries_work_date_not_null` | NOT NULL | `NOT NULL work_date` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_time_entries_timecard_id` | `CREATE INDEX ix_time_entries_timecard_id ON timeker_reference.time_entries USING btree (timecard_id)` |
| `ix_time_entries_work_date` | `CREATE INDEX ix_time_entries_work_date ON timeker_reference.time_entries USING btree (work_date)` |
| `time_entries_pkey` | `CREATE UNIQUE INDEX time_entries_pkey ON timeker_reference.time_entries USING btree (id)` |
| `time_entries_timecard_id_project_id_work_date_key` | `CREATE UNIQUE INDEX time_entries_timecard_id_project_id_work_date_key ON timeker_reference.time_entries USING btree (timecard_id, project_id, work_date)` |
| `time_entry_internal_day` | `CREATE UNIQUE INDEX time_entry_internal_day ON timeker_reference.time_entries USING btree (timecard_id, work_date) WHERE (project_id IS NULL)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `entry_allocation_guard` | [timeker_allocated_entry_guard](04-functions-and-procedures.md#timeker_allocated_entry_guard) | — |
| `entry_contribution_guard` | [timeker_entry_contribution_guard](04-functions-and-procedures.md#timeker_entry_contribution_guard) | — |
| `entry_guard` | [timeker_entry_guard](04-functions-and-procedures.md#timeker_entry_guard) | — |

## time_import_records

Mapped class `TimeImportRecord`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L13).

8 columns; 12 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `actor_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `source` | `character varying(100)` | No | UNIQUE | — | — | — | — |
| 6 | `source_record_id` | `character varying(128)` | No | UNIQUE | — | — | — | — |
| 7 | `batch_id` | `character varying(128)` | No | — | — | — | — | — |
| 8 | `payload_hash` | `character varying(64)` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `time_import_records_actor_id_fkey` | FOREIGN KEY | `FOREIGN KEY (actor_id) REFERENCES users(id)` | No |
| `time_import_records_actor_id_not_null` | NOT NULL | `NOT NULL actor_id` | No |
| `time_import_records_actor_id_source_source_record_id_key` | UNIQUE | `UNIQUE (actor_id, source, source_record_id)` | No |
| `time_import_records_batch_id_not_null` | NOT NULL | `NOT NULL batch_id` | No |
| `time_import_records_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `time_import_records_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `time_import_records_payload_hash_check` | CHECK | `CHECK (payload_hash::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `time_import_records_payload_hash_not_null` | NOT NULL | `NOT NULL payload_hash` | No |
| `time_import_records_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `time_import_records_source_not_null` | NOT NULL | `NOT NULL source` | No |
| `time_import_records_source_record_id_not_null` | NOT NULL | `NOT NULL source_record_id` | No |
| `time_import_records_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `time_import_records_actor_id_source_source_record_id_key` | `CREATE UNIQUE INDEX time_import_records_actor_id_source_source_record_id_key ON timeker_reference.time_import_records USING btree (actor_id, source, source_record_id)` |
| `time_import_records_pkey` | `CREATE UNIQUE INDEX time_import_records_pkey ON timeker_reference.time_import_records USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `time_import_record_guard` | [timeker_time_operation_guard](04-functions-and-procedures.md#timeker_time_operation_guard) | — |

## time_operations

Mapped class `TimeOperation`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L49).

9 columns; 14 catalog constraints; 2 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `actor_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 5 | `source` | `character varying(100)` | No | UNIQUE | — | — | — | — |
| 6 | `idempotency_key` | `character varying(128)` | No | UNIQUE | — | — | — | — |
| 7 | `payload_hash` | `character varying(64)` | No | — | — | — | — | — |
| 8 | `operation` | `character varying(20)` | No | — | — | — | — | — |
| 9 | `result` | `jsonb` | No | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `time_operations_actor_id_fkey` | FOREIGN KEY | `FOREIGN KEY (actor_id) REFERENCES users(id)` | No |
| `time_operations_actor_id_not_null` | NOT NULL | `NOT NULL actor_id` | No |
| `time_operations_actor_id_source_idempotency_key_key` | UNIQUE | `UNIQUE (actor_id, source, idempotency_key)` | No |
| `time_operations_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `time_operations_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `time_operations_idempotency_key_not_null` | NOT NULL | `NOT NULL idempotency_key` | No |
| `time_operations_operation_check` | CHECK | `CHECK (operation::text = ANY (ARRAY['create'::character varying, 'edit'::character varying, 'delete'::character varying, 'import'::character varying]::text[]))` | No |
| `time_operations_operation_not_null` | NOT NULL | `NOT NULL operation` | No |
| `time_operations_payload_hash_check` | CHECK | `CHECK (payload_hash::text ~ '^[0-9a-f]{64}$'::text)` | No |
| `time_operations_payload_hash_not_null` | NOT NULL | `NOT NULL payload_hash` | No |
| `time_operations_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `time_operations_result_not_null` | NOT NULL | `NOT NULL result` | No |
| `time_operations_source_not_null` | NOT NULL | `NOT NULL source` | No |
| `time_operations_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `time_operations_actor_id_source_idempotency_key_key` | `CREATE UNIQUE INDEX time_operations_actor_id_source_idempotency_key_key ON timeker_reference.time_operations USING btree (actor_id, source, idempotency_key)` |
| `time_operations_pkey` | `CREATE UNIQUE INDEX time_operations_pkey ON timeker_reference.time_operations USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `time_operation_guard` | [timeker_time_operation_guard](04-functions-and-procedures.md#timeker_time_operation_guard) | — |

## timecards

Mapped class `Timecard`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L184).

17 columns; 22 catalog constraints; 8 indexes; 5 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `owner_id` | `uuid` | No | FK, UNIQUE | — | — | — | — |
| 2 | `client_id` | `uuid` | Yes | FK, UNIQUE | — | — | — | — |
| 3 | `week_start` | `date` | No | UNIQUE | — | — | — | — |
| 4 | `status` | `character varying(20)` | No | — | — | — | `'Draft'` | — |
| 5 | `total_minutes` | `integer` | No | — | — | — | `0` | — |
| 6 | `finalized_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 7 | `cap_override_reason` | `text` | Yes | — | — | — | — | — |
| 8 | `cap_override_reference` | `character varying(200)` | Yes | — | — | — | — | — |
| 9 | `version` | `integer` | No | — | — | — | `1` | — |
| 10 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 11 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 12 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 13 | `archived_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 14 | `object_id` | `bigint` | No | UNIQUE | — | `a` | — | — |
| 15 | `flexfields` | `jsonb` | No | — | `'{}'::jsonb` | — | `Python callable: dict` | — |
| 16 | `is_internal` | `boolean` | No | UNIQUE | `false` | — | `False` | — |
| 17 | `internal_case_id` | `uuid` | Yes | FK | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `timecard_internal_scope` | CHECK | `CHECK (is_internal OR client_id IS NOT NULL AND internal_case_id IS NULL)` | No |
| `timecard_owner_client_week_kind` | UNIQUE | `UNIQUE (owner_id, client_id, week_start, is_internal)` | No |
| `timecards_client_id_fkey` | FOREIGN KEY | `FOREIGN KEY (client_id) REFERENCES clients(id)` | No |
| `timecards_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `timecards_flexfields_not_null` | NOT NULL | `NOT NULL flexfields` | No |
| `timecards_flexfields_valid` | CHECK | `CHECK (jsonb_typeof(flexfields) = 'object'::text AND (flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb AND (NOT flexfields ? 'flexfield1'::text OR (flexfields -> 'flexfield1'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield1'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield1'::text) <= 250) AND (NOT flexfields ? 'flexfield2'::text OR (flexfields -> 'flexfield2'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield2'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield2'::text) <= 250) AND (NOT flexfields ? 'flexfield3'::text OR (flexfields -> 'flexfield3'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield3'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield3'::text) <= 250) AND (NOT flexfields ? 'flexfield4'::text OR (flexfields -> 'flexfield4'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield4'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield4'::text) <= 250) AND (NOT flexfields ? 'flexfield5'::text OR (flexfields -> 'flexfield5'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield5'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield5'::text) <= 250) AND (NOT flexfields ? 'flexfield6'::text OR (flexfields -> 'flexfield6'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield6'::text) = 'string'::text AND char_length(flexfields ->> 'flexfield6'::text) <= 250) AND (NOT flexfields ? 'flexfield7'::text OR (flexfields -> 'flexfield7'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield7'::text) = 'string'::text AND (flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text) AND (NOT flexfields ? 'flexfield8'::text OR (flexfields -> 'flexfield8'::text) = 'null'::jsonb OR jsonb_typeof(flexfields -> 'flexfield8'::text) = 'string'::text AND (flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))` | No |
| `timecards_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `timecards_internal_case_id_fkey` | FOREIGN KEY | `FOREIGN KEY (internal_case_id) REFERENCES cases(id)` | No |
| `timecards_is_internal_not_null` | NOT NULL | `NOT NULL is_internal` | No |
| `timecards_object_id_key` | UNIQUE | `UNIQUE (object_id)` | No |
| `timecards_object_id_not_null` | NOT NULL | `NOT NULL object_id` | No |
| `timecards_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `timecards_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `timecards_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `timecards_status_check` | CHECK | `CHECK (status::text = ANY (ARRAY['Draft'::character varying, 'Finalized'::character varying, 'Invoiced'::character varying, 'Voided'::character varying]::text[]))` | No |
| `timecards_status_not_null` | NOT NULL | `NOT NULL status` | No |
| `timecards_total_minutes_check` | CHECK | `CHECK (total_minutes >= 0 AND total_minutes <= 10080)` | No |
| `timecards_total_minutes_not_null` | NOT NULL | `NOT NULL total_minutes` | No |
| `timecards_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `timecards_version_not_null` | NOT NULL | `NOT NULL version` | No |
| `timecards_week_start_check` | CHECK | `CHECK (EXTRACT(isodow FROM week_start) = 1::numeric)` | No |
| `timecards_week_start_not_null` | NOT NULL | `NOT NULL week_start` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `ix_timecards_archived_at` | `CREATE INDEX ix_timecards_archived_at ON timeker_reference.timecards USING btree (archived_at)` |
| `ix_timecards_client_id` | `CREATE INDEX ix_timecards_client_id ON timeker_reference.timecards USING btree (client_id)` |
| `ix_timecards_status` | `CREATE INDEX ix_timecards_status ON timeker_reference.timecards USING btree (status)` |
| `ix_timecards_week_start` | `CREATE INDEX ix_timecards_week_start ON timeker_reference.timecards USING btree (week_start)` |
| `timecard_internal_personal_week` | `CREATE UNIQUE INDEX timecard_internal_personal_week ON timeker_reference.timecards USING btree (owner_id, week_start) WHERE (is_internal AND (client_id IS NULL))` |
| `timecard_owner_client_week_kind` | `CREATE UNIQUE INDEX timecard_owner_client_week_kind ON timeker_reference.timecards USING btree (owner_id, client_id, week_start, is_internal)` |
| `timecards_object_id_key` | `CREATE UNIQUE INDEX timecards_object_id_key ON timeker_reference.timecards USING btree (object_id)` |
| `timecards_pkey` | `CREATE UNIQUE INDEX timecards_pkey ON timeker_reference.timecards USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `allocated_card_guard` | [timeker_allocated_parent_guard](04-functions-and-procedures.md#timeker_allocated_parent_guard) | — |
| `archive_card_guard` | [timeker_archive_guard](04-functions-and-procedures.md#timeker_archive_guard) | — |
| `internal_card_guard` | [timeker_internal_card_guard](04-functions-and-procedures.md#timeker_internal_card_guard) | — |
| `object_id_guard` | [timeker_object_id_guard](04-functions-and-procedures.md#timeker_object_id_guard) | — |
| `timecard_void_restriction` | [timeker_timecard_void_restriction](04-functions-and-procedures.md#timeker_timecard_void_restriction) | — |

## users

Mapped class `User`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L59).

9 columns; 10 catalog constraints; 2 indexes; 0 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `email` | `character varying(254)` | No | UNIQUE | — | — | — | — |
| 2 | `display_name` | `character varying(100)` | No | — | — | — | — | — |
| 3 | `role` | `character varying(20)` | No | — | — | — | `'owner'` | — |
| 4 | `active` | `boolean` | No | — | — | — | `True` | — |
| 5 | `last_login_at` | `timestamp with time zone` | Yes | — | — | — | — | — |
| 6 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 7 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 8 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 9 | `session_revision` | `integer` | No | — | — | — | `0` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `users_active_not_null` | NOT NULL | `NOT NULL active` | No |
| `users_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `users_display_name_not_null` | NOT NULL | `NOT NULL display_name` | No |
| `users_email_key` | UNIQUE | `UNIQUE (email)` | No |
| `users_email_not_null` | NOT NULL | `NOT NULL email` | No |
| `users_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `users_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `users_role_not_null` | NOT NULL | `NOT NULL role` | No |
| `users_session_revision_not_null` | NOT NULL | `NOT NULL session_revision` | No |
| `users_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `users_email_key` | `CREATE UNIQUE INDEX users_email_key ON timeker_reference.users USING btree (email)` |
| `users_pkey` | `CREATE UNIQUE INDEX users_pkey ON timeker_reference.users USING btree (id)` |

### Application triggers

None.

## workspace_admissions

Mapped class `WorkspaceAdmission`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L12).

9 columns; 15 catalog constraints; 5 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `uuid` | No | PK | — | — | `Python callable: uuid4` | — |
| 2 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 3 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 4 | `slot_id` | `uuid` | No | UNIQUE | — | — | — | — |
| 5 | `owner_id` | `uuid` | No | UNIQUE | — | — | — | — |
| 6 | `email` | `character varying(254)` | No | UNIQUE | — | — | — | — |
| 7 | `issuer` | `character varying(255)` | No | UNIQUE | — | — | — | — |
| 8 | `subject` | `character varying(255)` | No | UNIQUE | — | — | — | — |
| 9 | `state` | `character varying(12)` | No | — | — | — | `'reserved'` | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `workspace_admissions_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `workspace_admissions_email_key` | UNIQUE | `UNIQUE (email)` | No |
| `workspace_admissions_email_not_null` | NOT NULL | `NOT NULL email` | No |
| `workspace_admissions_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `workspace_admissions_issuer_not_null` | NOT NULL | `NOT NULL issuer` | No |
| `workspace_admissions_issuer_subject_key` | UNIQUE | `UNIQUE (issuer, subject)` | No |
| `workspace_admissions_owner_id_key` | UNIQUE | `UNIQUE (owner_id)` | No |
| `workspace_admissions_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `workspace_admissions_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `workspace_admissions_slot_id_key` | UNIQUE | `UNIQUE (slot_id)` | No |
| `workspace_admissions_slot_id_not_null` | NOT NULL | `NOT NULL slot_id` | No |
| `workspace_admissions_state_check` | CHECK | `CHECK (state::text = ANY (ARRAY['reserved'::character varying, 'active'::character varying, 'blocked'::character varying]::text[]))` | No |
| `workspace_admissions_state_not_null` | NOT NULL | `NOT NULL state` | No |
| `workspace_admissions_subject_not_null` | NOT NULL | `NOT NULL subject` | No |
| `workspace_admissions_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `workspace_admissions_email_key` | `CREATE UNIQUE INDEX workspace_admissions_email_key ON timeker_reference.workspace_admissions USING btree (email)` |
| `workspace_admissions_issuer_subject_key` | `CREATE UNIQUE INDEX workspace_admissions_issuer_subject_key ON timeker_reference.workspace_admissions USING btree (issuer, subject)` |
| `workspace_admissions_owner_id_key` | `CREATE UNIQUE INDEX workspace_admissions_owner_id_key ON timeker_reference.workspace_admissions USING btree (owner_id)` |
| `workspace_admissions_pkey` | `CREATE UNIQUE INDEX workspace_admissions_pkey ON timeker_reference.workspace_admissions USING btree (id)` |
| `workspace_admissions_slot_id_key` | `CREATE UNIQUE INDEX workspace_admissions_slot_id_key ON timeker_reference.workspace_admissions USING btree (slot_id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `admission_allocation_history` | [timeker_admission_history_guard](04-functions-and-procedures.md#timeker_admission_history_guard) | — |

## workspace_subscriptions

Mapped class `WorkspaceSubscription`; [Source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L13).

8 columns; 12 catalog constraints; 1 indexes; 1 application triggers.

| # | Column | PostgreSQL type | NULL allowed | Key membership | SQL DEFAULT | Identity | Python insert default | Python on update |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | `id` | `integer` | No | PK | — | — | `1` | — |
| 2 | `owner_id` | `uuid` | No | FK | — | — | — | — |
| 3 | `plan_code` | `character varying(12)` | No | — | — | — | — | — |
| 4 | `catalog_revision` | `character varying(60)` | No | — | — | — | — | — |
| 5 | `version` | `integer` | No | — | — | — | `1` | — |
| 6 | `created_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | — |
| 7 | `updated_at` | `timestamp with time zone` | No | — | — | — | `Python callable: <lambda>` | `Python callable: <lambda>` |
| 8 | `access_expires_at` | `timestamp with time zone` | Yes | — | — | — | — | — |

### Constraints

| Name | Kind | Definition | Deferred |
| --- | --- | --- | --- |
| `workspace_subscriptions_catalog_revision_not_null` | NOT NULL | `NOT NULL catalog_revision` | No |
| `workspace_subscriptions_check` | CHECK | `CHECK (version > 0 AND length(catalog_revision::text) >= 1 AND length(catalog_revision::text) <= 60)` | No |
| `workspace_subscriptions_created_at_not_null` | NOT NULL | `NOT NULL created_at` | No |
| `workspace_subscriptions_id_check` | CHECK | `CHECK (id = 1)` | No |
| `workspace_subscriptions_id_not_null` | NOT NULL | `NOT NULL id` | No |
| `workspace_subscriptions_owner_id_fkey` | FOREIGN KEY | `FOREIGN KEY (owner_id) REFERENCES users(id)` | No |
| `workspace_subscriptions_owner_id_not_null` | NOT NULL | `NOT NULL owner_id` | No |
| `workspace_subscriptions_pkey` | PRIMARY KEY | `PRIMARY KEY (id)` | No |
| `workspace_subscriptions_plan_code_check` | CHECK | `CHECK (plan_code::text = ANY (ARRAY['free'::character varying, 'solo'::character varying, 'pro'::character varying]::text[]))` | No |
| `workspace_subscriptions_plan_code_not_null` | NOT NULL | `NOT NULL plan_code` | No |
| `workspace_subscriptions_updated_at_not_null` | NOT NULL | `NOT NULL updated_at` | No |
| `workspace_subscriptions_version_not_null` | NOT NULL | `NOT NULL version` | No |

### Indexes

| Name | SQL |
| --- | --- |
| `workspace_subscriptions_pkey` | `CREATE UNIQUE INDEX workspace_subscriptions_pkey ON timeker_reference.workspace_subscriptions USING btree (id)` |

### Application triggers

| Trigger | Function | Constraint |
| --- | --- | --- |
| `subscription_assignment_history` | [timeker_subscription_history_guard](04-functions-and-procedures.md#timeker_subscription_history_guard) | — |
