# All functions and stored procedures

Candidate source `4bb5c424d6e7d270cdca1479283896be77d581c3`; migration head `ph3_009_read_indexes`. Structural reference inherited from the original 2026-10-18 empty PostgreSQL18.4 reconstruction at `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` after 26 migrations. Exactly 45 structural input blobs are unchanged at the candidate. No database connection, migration or DDL replay was rerun in this refresh. `timeker_reference` is synthetic, not a hosted schema name; no business rows or hosted catalog are included.


## Inventory and execution semantics

All 36 are PL/pgSQL trigger functions (`prokind=f`, zero arguments, `RETURNS trigger`).
No application stored procedures (`prokind=p`) or ordinary callable business
functions exist in this reference schema. This does not inventory provider/system
routines or move Python service logic into PostgreSQL.

Every function is SECURITY INVOKER, VOLATILE, CALLED ON NULL INPUT and PARALLEL
UNSAFE in the native catalog. Every search_path is pinned to `pg_catalog`, the
installed private schema, then `pg_temp`. Exact final definitions follow; earlier
migration definitions can be superseded or dynamically patched. Hosted runtime
grants/revocations are separate operator steps; `pg_dump --no-privileges` omits
ACL statements and must not be used as a hosted permission template.

| Function | Bound application triggers | PUBLIC EXECUTE after migrations only |
| --- | --- | --- |
| [timeker_admission_history_guard](#timeker_admission_history_guard) | 3 | No |
| [timeker_allocated_entry_guard](#timeker_allocated_entry_guard) | 1 | Yes |
| [timeker_allocated_parent_guard](#timeker_allocated_parent_guard) | 2 | Yes |
| [timeker_allocation_contribution_guard](#timeker_allocation_contribution_guard) | 1 | No |
| [timeker_allocation_guard](#timeker_allocation_guard) | 1 | No |
| [timeker_archive_guard](#timeker_archive_guard) | 2 | Yes |
| [timeker_artifact_guard](#timeker_artifact_guard) | 2 | Yes |
| [timeker_case_archive_status_guard](#timeker_case_archive_status_guard) | 1 | No |
| [timeker_case_guard](#timeker_case_guard) | 1 | No |
| [timeker_commercial_case_guard](#timeker_commercial_case_guard) | 1 | No |
| [timeker_contribution_allocation_check](#timeker_contribution_allocation_check) | 1 | No |
| [timeker_contribution_guard](#timeker_contribution_guard) | 1 | No |
| [timeker_credit_memo_final_guard](#timeker_credit_memo_final_guard) | 2 | No |
| [timeker_credit_memo_guard](#timeker_credit_memo_guard) | 1 | No |
| [timeker_entry_contribution_guard](#timeker_entry_contribution_guard) | 1 | No |
| [timeker_entry_guard](#timeker_entry_guard) | 1 | No |
| [timeker_internal_billing_guard](#timeker_internal_billing_guard) | 1 | No |
| [timeker_internal_card_guard](#timeker_internal_card_guard) | 1 | No |
| [timeker_invoice_guard](#timeker_invoice_guard) | 1 | No |
| [timeker_issued_artifact_check](#timeker_issued_artifact_check) | 1 | Yes |
| [timeker_library_guard](#timeker_library_guard) | 3 | No |
| [timeker_line_guard](#timeker_line_guard) | 1 | No |
| [timeker_mail_attachment_guard](#timeker_mail_attachment_guard) | 1 | No |
| [timeker_mail_guard](#timeker_mail_guard) | 2 | No |
| [timeker_object_id_guard](#timeker_object_id_guard) | 5 | No |
| [timeker_payment_guard](#timeker_payment_guard) | 1 | Yes |
| [timeker_project_agreement_guard](#timeker_project_agreement_guard) | 1 | No |
| [timeker_project_billing_guard](#timeker_project_billing_guard) | 1 | No |
| [timeker_proposal_sending_guard](#timeker_proposal_sending_guard) | 2 | No |
| [timeker_quote_guard](#timeker_quote_guard) | 4 | No |
| [timeker_registration_history_guard](#timeker_registration_history_guard) | 3 | No |
| [timeker_sending_guard](#timeker_sending_guard) | 3 | No |
| [timeker_subscription_billing_guard](#timeker_subscription_billing_guard) | 3 | No |
| [timeker_subscription_history_guard](#timeker_subscription_history_guard) | 2 | No |
| [timeker_time_operation_guard](#timeker_time_operation_guard) | 2 | No |
| [timeker_timecard_void_restriction](#timeker_timecard_void_restriction) | 1 | No |

## timeker_admission_history_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_005_public_admission.py#L62).

Bindings: `admission_identities.admission_identity_history`, `public_email_challenges.public_email_challenge_history`, `workspace_admissions.admission_allocation_history`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_admission_history_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Admission history is retained'; END IF;
      IF TG_TABLE_NAME='workspace_admissions' THEN
        IF (to_jsonb(NEW)-'state'-'updated_at') IS DISTINCT FROM (to_jsonb(OLD)-'state'-'updated_at')
           OR NOT (OLD.state='reserved' AND NEW.state IN ('active','blocked')) THEN
          RAISE EXCEPTION 'Workspace reservation is immutable and cannot be reassigned';
        END IF;
      ELSIF TG_TABLE_NAME='admission_identities' THEN
        IF (to_jsonb(NEW)-'state'-'updated_at') IS DISTINCT FROM (to_jsonb(OLD)-'state'-'updated_at')
           OR NOT ((OLD.state='pending' AND NEW.state IN ('active','blocked'))
             OR (OLD.state='active' AND NEW.state IN ('blocked','revoked'))
             OR (OLD.state='blocked' AND NEW.state='revoked')) THEN
          RAISE EXCEPTION 'Global identity is immutable and cannot be reassigned';
        END IF;
      ELSE
        IF (to_jsonb(NEW)-'state'-'attempts'-'updated_at') IS DISTINCT FROM
           (to_jsonb(OLD)-'state'-'attempts'-'updated_at')
           OR NOT ((OLD.state='reserved' AND NEW.state IN ('ready','uncertain','failed') AND NEW.attempts=OLD.attempts)
             OR (OLD.state IN ('ready','uncertain') AND NEW.state='verifying' AND NEW.attempts=OLD.attempts+1)
             OR (OLD.state='verifying' AND NEW.state IN ('ready','consumed','failed') AND NEW.attempts=OLD.attempts)) THEN
          RAISE EXCEPTION 'Public challenge proof, attempts and terminal states are retained';
        END IF;
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_allocated_entry_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e672c40fa912_cases_and_allocations.py#L121).

Bindings: `time_entries.entry_allocation_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_allocated_entry_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE allocated integer;
    BEGIN
      SELECT COALESCE(sum(minutes),0) INTO allocated FROM case_time_allocations WHERE entry_id=OLD.id;
      IF allocated > 0 THEN
        IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Remove allocations before removing entry'; END IF;
        IF NEW.minutes < allocated OR ROW(NEW.timecard_id,NEW.project_id,NEW.work_date)
          IS DISTINCT FROM ROW(OLD.timecard_id,OLD.project_id,OLD.work_date)
        THEN RAISE EXCEPTION 'Allocated entry identity and minutes must be preserved'; END IF;
      END IF;
      IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      RETURN NEW;
    END $function$
```

## timeker_allocated_parent_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e672c40fa912_cases_and_allocations.py#L137).

Bindings: `projects.allocated_project_guard`, `timecards.allocated_card_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_allocated_parent_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_TABLE_NAME='timecards' THEN
        IF ROW(NEW.owner_id,NEW.client_id) IS DISTINCT FROM ROW(OLD.owner_id,OLD.client_id)
          AND EXISTS(SELECT 1 FROM time_entries e JOIN case_time_allocations a ON a.entry_id=e.id
                     WHERE e.timecard_id=OLD.id)
        THEN RAISE EXCEPTION 'Allocated timecard identity is immutable'; END IF;
      ELSE
        IF NEW.client_id IS DISTINCT FROM OLD.client_id AND
          (EXISTS(SELECT 1 FROM cases WHERE project_id=OLD.id) OR
           EXISTS(SELECT 1 FROM time_entries e JOIN case_time_allocations a ON a.entry_id=e.id
                  WHERE e.project_id=OLD.id))
        THEN RAISE EXCEPTION 'Case project client is immutable'; END IF;
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_allocation_contribution_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L116).

Bindings: `case_time_allocations.allocation_contribution_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_allocation_contribution_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE attributed INTEGER;
    BEGIN
      SELECT COALESCE(sum(minutes),0) INTO attributed FROM time_contributions
        WHERE entry_id=OLD.entry_id AND case_id=OLD.case_id;
      IF attributed>0 AND (TG_OP='DELETE' OR NEW.minutes<attributed OR
          (NEW.entry_id,NEW.case_id) IS DISTINCT FROM (OLD.entry_id,OLD.case_id))
      THEN RAISE EXCEPTION 'Correct contributions before reducing their case allocation'; END IF;
      IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      RETURN NEW;
    END $function$
```

## timeker_allocation_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L154).

Bindings: `case_time_allocations.allocation_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_allocation_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE item record; linked_case record; selected_entry uuid; allocated integer;
    BEGIN
      IF TG_OP='UPDATE' AND ROW(NEW.entry_id,NEW.case_id,NEW.actor_id) IS DISTINCT FROM
          ROW(OLD.entry_id,OLD.case_id,OLD.actor_id)
      THEN RAISE EXCEPTION 'Allocation identity is immutable'; END IF;
      selected_entry := CASE WHEN TG_OP='DELETE' THEN OLD.entry_id ELSE NEW.entry_id END;
      PERFORM c.id FROM clients c JOIN timecards t ON t.client_id=c.id
        JOIN time_entries e ON e.timecard_id=t.id WHERE e.id=selected_entry FOR UPDATE OF c;
      PERFORM t.id FROM timecards t JOIN time_entries e ON e.timecard_id=t.id
        WHERE e.id=selected_entry FOR UPDATE OF t;
      SELECT e.minutes,e.project_id,t.client_id,t.owner_id,t.status,
        c.status AS client_status,p.status AS project_status INTO item
        FROM time_entries e JOIN timecards t ON t.id=e.timecard_id
        JOIN clients c ON c.id=t.client_id JOIN projects p ON p.id=e.project_id
        WHERE e.id=selected_entry FOR UPDATE OF e;
      IF NOT FOUND OR item.status <> 'Draft' OR item.client_status <> 'active' OR
         item.project_status <> 'active' OR
         EXISTS(SELECT 1 FROM invoice_time_entries WHERE entry_id=selected_entry)
      THEN RAISE EXCEPTION 'Only unreserved draft allocations can change'; END IF;
      SELECT * INTO linked_case FROM cases
        WHERE id=CASE WHEN TG_OP='DELETE' THEN OLD.case_id ELSE NEW.case_id END FOR SHARE;
      IF NOT FOUND OR linked_case.archived_at IS NOT NULL OR
         linked_case.client_id IS DISTINCT FROM item.client_id OR
         linked_case.owner_id IS DISTINCT FROM item.owner_id OR
         (linked_case.project_id IS NOT NULL AND linked_case.project_id <> item.project_id)
      THEN RAISE EXCEPTION 'Allocation case must match its editable parent'; END IF;

      IF linked_case.status='Closed' AND (TG_OP='INSERT' OR NEW.minutes>OLD.minutes) THEN
        RAISE EXCEPTION 'Reopen Closed cases before adding time allocations'; END IF;
          IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      IF NEW.actor_id IS DISTINCT FROM item.owner_id OR NOT EXISTS
        (SELECT 1 FROM users WHERE id=NEW.actor_id AND active AND role='owner')
      THEN RAISE EXCEPTION 'Allocation requires the active owner'; END IF;
      SELECT COALESCE(sum(minutes),0) INTO allocated FROM case_time_allocations
        WHERE entry_id=selected_entry AND id <> NEW.id;
      IF allocated + NEW.minutes > item.minutes
      THEN RAISE EXCEPTION 'Case allocations exceed parent minutes'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_archive_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py#L119).

Bindings: `mail_messages.archive_mail_guard`, `timecards.archive_card_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_archive_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_OP='DELETE' THEN
        IF OLD.archived_at IS NOT NULL THEN RAISE EXCEPTION 'Archived records are retained'; END IF;
        RETURN OLD;
      END IF;
      IF OLD.archived_at IS NOT NULL AND NEW.archived_at IS DISTINCT FROM OLD.archived_at THEN
        RAISE EXCEPTION 'Archive markers are permanent';
      END IF;
      RETURN NEW;
    END; $function$
```

## timeker_artifact_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c46f2f62a011_immutable_artifacts.py#L33).

Bindings: `audit_events.audit_guard`, `invoice_artifacts.artifact_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_artifact_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN RAISE EXCEPTION 'Artifact or audit history is immutable'; END $function$
```

## timeker_case_archive_status_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L315).

Bindings: `cases.case_archive_status_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_case_archive_status_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF NEW.archived_at IS NOT NULL AND NEW.status<>'Closed' THEN
        RAISE EXCEPTION 'Only Closed cases can be archived'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_case_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L105).

Bindings: `cases.case_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_case_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Archive cases to retain their history'; END IF;
      IF TG_OP='UPDATE' THEN
        IF ROW(NEW.client_id,NEW.owner_id,NEW.number,NEW.legacy_number,NEW.opened_at) IS DISTINCT FROM
           ROW(OLD.client_id,OLD.owner_id,OLD.number,OLD.legacy_number,OLD.opened_at)
        THEN RAISE EXCEPTION 'Case identity is immutable'; END IF;
        IF OLD.archived_at IS NOT NULL AND ROW(NEW.project_id,NEW.title,NEW.description,NEW.case_type,NEW.status)
           IS DISTINCT FROM ROW(OLD.project_id,OLD.title,OLD.description,OLD.case_type,OLD.status)
        THEN RAISE EXCEPTION 'Reactivate archived cases before editing'; END IF;
        IF NEW.project_id IS DISTINCT FROM OLD.project_id AND
           EXISTS(SELECT 1 FROM case_time_allocations WHERE case_id=OLD.id)
        THEN RAISE EXCEPTION 'Allocated case project is immutable'; END IF;
        IF NEW.project_id IS DISTINCT FROM OLD.project_id AND
           (EXISTS(SELECT 1 FROM mail_messages WHERE case_id=OLD.id) OR
            EXISTS(SELECT 1 FROM mail_addresses WHERE case_id=OLD.id))
        THEN RAISE EXCEPTION 'Mail-linked case project is immutable'; END IF;
      END IF;
      IF NEW.project_id IS NULL OR NOT EXISTS
        (SELECT 1 FROM projects WHERE id=NEW.project_id AND client_id=NEW.client_id)
      THEN RAISE EXCEPTION 'Case project must belong to its client'; END IF;
      IF TG_OP='INSERT' AND NOT EXISTS
        (SELECT 1 FROM users WHERE id=NEW.owner_id AND active AND role='owner')
      THEN RAISE EXCEPTION 'Case requires an active owner'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_commercial_case_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py#L430).

Bindings: `cases.commercial_case_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_commercial_case_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF (NEW.owner_id,NEW.client_id,NEW.project_id) IS DISTINCT FROM (OLD.owner_id,OLD.client_id,OLD.project_id)
        AND (EXISTS(SELECT 1 FROM quote_revisions WHERE case_id=OLD.id)
          OR EXISTS(SELECT 1 FROM library_documents WHERE case_id=OLD.id)) THEN
        RAISE EXCEPTION 'Retained commercial documents preserve their case, project and client'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_contribution_allocation_check

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L129).

Bindings: `time_contributions.contribution_allocation_check`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_contribution_allocation_check()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE attributed INTEGER; allocated INTEGER;
    BEGIN
      IF NEW.case_id IS NULL OR NEW.entry_id IS NULL THEN RETURN NEW; END IF;
      SELECT COALESCE(sum(minutes),0) INTO attributed FROM time_contributions
        WHERE entry_id=NEW.entry_id AND case_id=NEW.case_id;
      SELECT COALESCE(sum(minutes),0) INTO allocated FROM case_time_allocations
        WHERE entry_id=NEW.entry_id AND case_id=NEW.case_id;
      IF attributed>allocated THEN RAISE EXCEPTION 'Attributed case minutes require their allocation'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_contribution_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L70).

Bindings: `time_contributions.contribution_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_contribution_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE card_record RECORD; entry_record RECORD; attributed INTEGER;
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Contribution history is retained'; END IF;
      SELECT * INTO card_record FROM timecards WHERE id=NEW.timecard_id FOR UPDATE;
      IF card_record.id IS NULL OR card_record.owner_id<>NEW.actor_id OR card_record.status<>'Draft'
      THEN RAISE EXCEPTION 'Only owned Draft contributions can change'; END IF;
      IF TG_OP='UPDATE' AND (NEW.actor_id,NEW.source,NEW.source_item_id,NEW.import_record_id,NEW.timecard_id,
          NEW.project_id,NEW.work_date,NEW.case_id) IS DISTINCT FROM
          (OLD.actor_id,OLD.source,OLD.source_item_id,OLD.import_record_id,OLD.timecard_id,OLD.project_id,OLD.work_date,OLD.case_id)
      THEN RAISE EXCEPTION 'Contribution provenance is immutable'; END IF;
      IF NEW.import_record_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM time_import_records
          WHERE id=NEW.import_record_id AND actor_id=NEW.actor_id AND source=NEW.source)
      THEN RAISE EXCEPTION 'Contribution import identity mismatch'; END IF;
      IF NEW.entry_id IS NOT NULL THEN
        SELECT * INTO entry_record FROM time_entries WHERE id=NEW.entry_id FOR UPDATE;
        IF entry_record.id IS NULL OR entry_record.timecard_id<>NEW.timecard_id OR
           entry_record.project_id<>NEW.project_id OR entry_record.work_date<>NEW.work_date OR
           EXISTS(SELECT 1 FROM invoice_time_entries WHERE entry_id=NEW.entry_id)
        THEN RAISE EXCEPTION 'Contribution parent is unavailable'; END IF;
        SELECT COALESCE(sum(minutes),0) INTO attributed FROM time_contributions
          WHERE entry_id=NEW.entry_id AND id<>NEW.id;
        IF attributed+NEW.minutes>entry_record.minutes
        THEN RAISE EXCEPTION 'Contributions exceed parent minutes'; END IF;
      END IF;
      IF NEW.case_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM cases c
          WHERE c.id=NEW.case_id AND c.owner_id=NEW.actor_id AND
                c.client_id=card_record.client_id AND c.project_id=NEW.project_id)
      THEN RAISE EXCEPTION 'Contribution case parent mismatch'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_credit_memo_final_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py#L74).

Bindings: `credit_memos.credit_memo_invoice_check`, `invoices.invoice_credit_memo_check`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_credit_memo_final_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE original invoices%ROWTYPE; target uuid;
    BEGIN
      IF TG_TABLE_NAME='invoices' THEN
        IF NEW.status <> 'Void' OR NEW.issued_at IS NULL THEN RETURN NEW; END IF;
        IF TG_OP='UPDATE' AND OLD.status='Void' THEN RETURN NEW; END IF;
        target := NEW.id;
      ELSE target := NEW.invoice_id; END IF;
      SELECT * INTO original FROM invoices WHERE id=target;
      IF original.status <> 'Void' OR original.issued_at IS NULL OR NOT EXISTS (
        SELECT 1 FROM credit_memos WHERE invoice_id=target AND currency=original.currency
          AND total=original.total AND reason=original.void_reason
      ) THEN RAISE EXCEPTION 'Issued void and credit memo must commit together'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_credit_memo_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py#L40).

Bindings: `credit_memos.credit_memo_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_credit_memo_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE original invoices%ROWTYPE;
    BEGIN
      IF TG_OP IN ('UPDATE','DELETE') THEN
        RAISE EXCEPTION 'Credit memos and their artifacts are immutable';
      END IF;
      IF NOT EXISTS (SELECT 1 FROM users WHERE id=NEW.actor_id AND active AND role='owner') THEN
        RAISE EXCEPTION 'Credit memo requires an active owner';
      END IF;
      SELECT * INTO original FROM invoices WHERE id=NEW.invoice_id FOR UPDATE;
      IF NOT FOUND OR original.issued_at IS NULL OR original.status NOT IN ('Issued','Sent') THEN
        RAISE EXCEPTION 'Credit memo requires an issued statement';
      END IF;
      IF NEW.currency IS DISTINCT FROM original.currency OR NEW.total IS DISTINCT FROM original.total
        OR NEW.snapshot->'original' IS DISTINCT FROM
            (original.snapshot - 'payment_instructions' - 'appendix')
        OR NEW.snapshot->>'original_invoice_id' IS DISTINCT FROM original.id::text
        OR NEW.snapshot->>'original_number' IS DISTINCT FROM original.number
        OR NEW.snapshot->>'kind' IS DISTINCT FROM 'credit_memo'
        OR NEW.snapshot->>'number' IS DISTINCT FROM NEW.number
        OR NEW.snapshot->>'reason' IS DISTINCT FROM NEW.reason
        OR NEW.snapshot->>'issue_date' IS DISTINCT FROM NEW.issue_date::text
        OR (NEW.snapshot->>'credit_total')::numeric IS DISTINCT FROM NEW.total
        OR NEW.snapshot->>'original_sha256' IS DISTINCT FROM
            (SELECT sha256 FROM invoice_artifacts WHERE invoice_id=original.id)
      THEN RAISE EXCEPTION 'Credit memo must freeze the full original credit'; END IF;
      IF EXISTS (SELECT 1 FROM payments WHERE invoice_id=original.id AND reversed_at IS NULL) THEN
        RAISE EXCEPTION 'Reverse payments before issuing a credit memo';
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_entry_contribution_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L103).

Bindings: `time_entries.entry_contribution_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_entry_contribution_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE attributed INTEGER;
    BEGIN
      SELECT COALESCE(sum(minutes),0) INTO attributed FROM time_contributions WHERE entry_id=OLD.id;
      IF attributed>0 AND (TG_OP='DELETE' OR NEW.minutes<attributed OR
          (NEW.timecard_id,NEW.project_id,NEW.work_date) IS DISTINCT FROM
          (OLD.timecard_id,OLD.project_id,OLD.work_date))
      THEN RAISE EXCEPTION 'Correct contributions before reducing their parent'; END IF;
      IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      RETURN NEW;
    END $function$
```

## timeker_entry_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L210).

Bindings: `time_entries.entry_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_entry_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE card_state text; card_client uuid; project_client uuid; monday date; card_internal boolean;
    BEGIN
      PERFORM id FROM timecards WHERE id IN
        (CASE WHEN TG_OP <> 'INSERT' THEN OLD.timecard_id END,
         CASE WHEN TG_OP <> 'DELETE' THEN NEW.timecard_id END) ORDER BY id FOR UPDATE;
      IF TG_OP <> 'INSERT' AND
        (EXISTS(SELECT 1 FROM timecards WHERE id=OLD.timecard_id AND status <> 'Draft') OR
         EXISTS(SELECT 1 FROM invoice_time_entries WHERE entry_id=OLD.id))
      THEN RAISE EXCEPTION 'Finalized or reserved entries are immutable'; END IF;
      IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      SELECT status,client_id,week_start,is_internal INTO card_state,card_client,monday,card_internal
        FROM timecards WHERE id=NEW.timecard_id;
      IF card_state <> 'Draft' THEN RAISE EXCEPTION 'Finalized entries are immutable'; END IF;
      SELECT client_id INTO project_client FROM projects WHERE id=NEW.project_id;
      
      IF card_internal THEN
        IF NEW.project_id IS NOT NULL OR NEW.billable OR NEW.rate_override IS NOT NULL THEN
          RAISE EXCEPTION 'Internal time is projectless and nonbillable'; END IF;
      ELSIF NEW.project_id IS NULL OR card_client IS DISTINCT FROM project_client THEN
        RAISE EXCEPTION 'Entry project must match timecard';
      END IF;
    
      IF NEW.work_date < monday OR NEW.work_date > monday+6 THEN
        RAISE EXCEPTION 'Entry date must match timecard'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_internal_billing_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L306).

Bindings: `invoice_time_entries.internal_billing_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_internal_billing_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF EXISTS(SELECT 1 FROM time_entries e JOIN timecards c ON c.id=e.timecard_id
        WHERE e.id=NEW.entry_id AND c.is_internal) THEN
        RAISE EXCEPTION 'Internal productivity time cannot be reserved for billing'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_internal_card_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L287).

Bindings: `timecards.internal_card_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_internal_card_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_OP='UPDATE' AND (NEW.is_internal,NEW.client_id,NEW.owner_id,NEW.week_start)
        IS DISTINCT FROM (OLD.is_internal,OLD.client_id,OLD.owner_id,OLD.week_start) THEN
        RAISE EXCEPTION 'Timecard scope is retained'; END IF;
      IF NEW.is_internal THEN
        IF NEW.status='Invoiced' OR EXISTS(SELECT 1 FROM time_entries WHERE timecard_id=NEW.id AND (billable OR project_id IS NOT NULL)) THEN
          RAISE EXCEPTION 'Internal time cannot be invoiced or billable'; END IF;
        IF NEW.internal_case_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM cases
          WHERE id=NEW.internal_case_id AND owner_id=NEW.owner_id
          AND (NEW.client_id IS NULL OR client_id=NEW.client_id)) THEN
          RAISE EXCEPTION 'Internal case must belong to the owner and selected client'; END IF;
      END IF;
      IF TG_OP='UPDATE' AND OLD.status<>'Draft' AND (NEW.flexfields,NEW.internal_case_id) IS DISTINCT FROM (OLD.flexfields,OLD.internal_case_id) THEN
        RAISE EXCEPTION 'Finalized metadata is retained'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_invoice_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py#L116).

Bindings: `invoices.invoice_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_invoice_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE p projects%ROWTYPE; c clients%ROWTYPE; claim uuid;
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Invoice history cannot be deleted'; END IF;
      IF TG_OP='UPDATE' THEN
        IF ROW(NEW.fixed_fee_project_id,NEW.manual_extra_project_id,NEW.manual_extra_reference)
          IS DISTINCT FROM ROW(OLD.fixed_fee_project_id,OLD.manual_extra_project_id,OLD.manual_extra_reference)
        THEN RAISE EXCEPTION 'Project charge identity is immutable'; END IF;
        IF OLD.issued_at IS NOT NULL AND
          ROW(NEW.client_id,NEW.number,NEW.period_start,NEW.period_end,NEW.issue_date,
              NEW.currency,NEW.subtotal,NEW.adjustments,NEW.total,NEW.snapshot,NEW.issued_at)
          IS DISTINCT FROM
          ROW(OLD.client_id,OLD.number,OLD.period_start,OLD.period_end,OLD.issue_date,
              OLD.currency,OLD.subtotal,OLD.adjustments,OLD.total,OLD.snapshot,OLD.issued_at)
        THEN RAISE EXCEPTION 'Issued financial snapshot is immutable'; END IF;
        IF OLD.status='Void' AND NEW IS DISTINCT FROM OLD THEN
          RAISE EXCEPTION 'Voided statement is immutable'; END IF;
        IF OLD.issued_at IS NOT NULL AND NEW.status NOT IN ('Issued','Sent','Void') THEN
          RAISE EXCEPTION 'Issued status cannot return to draft'; END IF;
        IF OLD.issued_at IS NOT NULL OR NEW.status='Void' THEN RETURN NEW; END IF;
      END IF;
      IF NEW.status IN ('Issued','Sent') AND NEW.issued_at IS NULL THEN
        RAISE EXCEPTION 'Issued status requires issuance'; END IF;
      IF EXISTS(SELECT 1 FROM invoice_lines l JOIN projects pr ON pr.id=l.project_id
        WHERE l.invoice_id=NEW.id AND (pr.client_id IS DISTINCT FROM NEW.client_id OR
          NEW.currency IS DISTINCT FROM coalesce(pr.budget_currency,
            (SELECT currency FROM clients WHERE id=pr.client_id))))
      THEN RAISE EXCEPTION 'Statement project, client and currency must remain consistent'; END IF;
      claim := coalesce(NEW.fixed_fee_project_id,NEW.manual_extra_project_id);
      IF claim IS NOT NULL THEN
        SELECT * INTO p FROM projects WHERE id=claim FOR NO KEY UPDATE;
        SELECT * INTO c FROM clients WHERE id=p.client_id;
        IF p.client_id IS DISTINCT FROM NEW.client_id OR p.status<>'active' OR c.status<>'active'
          OR NOT p.billable OR NEW.currency IS DISTINCT FROM coalesce(p.budget_currency,c.currency)
        THEN RAISE EXCEPTION 'Project charge requires an active matching project, client and currency'; END IF;
        IF NEW.fixed_fee_project_id IS NOT NULL AND
          (p.project_type NOT IN ('fixed_fee','on_demand_support_ff') OR p.project_type IS NULL OR p.budget_amount IS NULL)
        THEN RAISE EXCEPTION 'Fixed fee requires a fixed-fee project and stated budget'; END IF;
        IF NEW.manual_extra_project_id IS NOT NULL AND NOT p.allow_overbilling THEN
          RAISE EXCEPTION 'Additional charges require project authorization'; END IF;
      END IF;
      IF coalesce((NEW.adjustments->>'other')::numeric,0)>0 AND EXISTS
        (SELECT 1 FROM invoice_lines l JOIN projects pr ON pr.id=l.project_id WHERE l.invoice_id=NEW.id
         AND (l.basis<>'time' OR pr.budget_amount IS NOT NULL OR l.charge_metadata->>'budget_amount' IS NOT NULL))
      THEN RAISE EXCEPTION 'Project additional charges require an explicit charge'; END IF;
      IF TG_OP='UPDATE' AND NEW.issued_at IS NOT NULL THEN
        IF NEW.fixed_fee_project_id IS NOT NULL AND EXISTS
          (SELECT 1 FROM invoice_lines WHERE invoice_id=NEW.id AND amount IS DISTINCT FROM p.budget_amount)
        THEN RAISE EXCEPTION 'Fixed-fee statement must equal the full project fee'; END IF;
        IF NEW.subtotal IS DISTINCT FROM (SELECT coalesce(sum(amount),0) FROM invoice_lines WHERE invoice_id=NEW.id)
        THEN RAISE EXCEPTION 'Statement subtotal must match its lines'; END IF;
        IF claim IS NOT NULL AND (SELECT count(*) FROM invoice_lines WHERE invoice_id=NEW.id)<>1
        THEN RAISE EXCEPTION 'Project fee statements require exactly one charge line'; END IF;
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_issued_artifact_check

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c46f2f62a011_immutable_artifacts.py#L68).

Bindings: `invoices.issued_artifact_check`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_issued_artifact_check()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF NEW.issued_at IS NOT NULL AND NOT EXISTS (SELECT 1 FROM invoice_artifacts WHERE invoice_id=NEW.id)
      THEN RAISE EXCEPTION 'Issued invoice requires a frozen artifact'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_library_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L95).

Bindings: `library_document_versions.library_version_guard`, `library_documents.library_document_guard`, `library_uploads.library_upload_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_library_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE document_row library_documents%ROWTYPE;
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Library sources and versions are retained'; END IF;
      IF TG_TABLE_NAME='library_documents' THEN
        IF NOT EXISTS(SELECT 1 FROM users WHERE id=NEW.owner_id AND active AND role='owner') THEN
          RAISE EXCEPTION 'An active document owner is required'; END IF;
        IF NOT NEW.is_template AND NOT EXISTS(
          SELECT 1 FROM cases c JOIN projects p ON p.id=c.project_id
          WHERE c.id=NEW.case_id AND c.owner_id=NEW.owner_id AND c.client_id=NEW.client_id
          AND c.project_id=NEW.project_id AND p.client_id=c.client_id) THEN
          RAISE EXCEPTION 'Working documents require their owned case, project and client'; END IF;
        IF NEW.source_upload_id IS NOT NULL AND NOT EXISTS(
          SELECT 1 FROM library_uploads WHERE id=NEW.source_upload_id AND document_id=NEW.id) THEN
          RAISE EXCEPTION 'A document source must belong to that document'; END IF;
        IF TG_OP='INSERT' AND (NEW.status<>'draft' OR NEW.revision<>1) THEN
          RAISE EXCEPTION 'New documents start as first drafts'; END IF;
        IF TG_OP='UPDATE' THEN
          IF (to_jsonb(NEW)-ARRAY['updated_at','title','kind','status','content','source_upload_id','revision','flexfields']) IS DISTINCT FROM
            (to_jsonb(OLD)-ARRAY['updated_at','title','kind','status','content','source_upload_id','revision','flexfields']) THEN
            RAISE EXCEPTION 'Document ownership, case and template identity are retained'; END IF;
          IF OLD.status='frozen' AND (NEW.status<>'draft' OR NEW.revision<>OLD.revision+1 OR
            (to_jsonb(NEW)-ARRAY['updated_at','status','revision']) IS DISTINCT FROM
            (to_jsonb(OLD)-ARRAY['updated_at','status','revision'])) THEN
            RAISE EXCEPTION 'Published documents require an explicit new draft before editing'; END IF;
          IF OLD.status='draft' AND NEW.status='draft' AND NEW.revision<>OLD.revision+1 THEN
            RAISE EXCEPTION 'Document edits advance their draft revision'; END IF;
          IF OLD.status='draft' AND NEW.status='frozen' AND (NEW.revision<>OLD.revision OR NOT EXISTS(
            SELECT 1 FROM library_document_versions WHERE document_id=NEW.id AND snapshot->>'title'=NEW.title
            AND snapshot->>'content'=NEW.content AND source_upload_id IS NOT DISTINCT FROM NEW.source_upload_id)) THEN
            RAISE EXCEPTION 'Publication requires a frozen version of the current document'; END IF;
        END IF;
        RETURN NEW;
      END IF;
      IF TG_OP='UPDATE' THEN RAISE EXCEPTION 'Library uploads and versions are immutable'; END IF;
      SELECT * INTO document_row FROM library_documents WHERE id=NEW.document_id FOR UPDATE;
      IF document_row.id IS NULL OR document_row.status<>'draft' THEN
        RAISE EXCEPTION 'Library sources and publication require an editable draft'; END IF;
      IF TG_TABLE_NAME='library_uploads' THEN
        IF NEW.uploaded_by<>document_row.owner_id THEN RAISE EXCEPTION 'Upload owner mismatch'; END IF;
      ELSE
        IF NEW.owner_id<>document_row.owner_id
          OR NEW.snapshot->>'case_id' IS DISTINCT FROM document_row.case_id::text
          OR NEW.snapshot->>'client_id' IS DISTINCT FROM document_row.client_id::text
          OR NEW.snapshot->>'project_id' IS DISTINCT FROM document_row.project_id::text
          OR NEW.snapshot->>'is_template' IS DISTINCT FROM document_row.is_template::text
          OR NEW.source_upload_id IS DISTINCT FROM document_row.source_upload_id
          OR (NEW.source_upload_id IS NOT NULL AND NOT EXISTS(
            SELECT 1 FROM library_uploads WHERE id=NEW.source_upload_id AND document_id=NEW.document_id))
          OR substring(NEW.pdf_bytes FROM 1 FOR 5)<>convert_to('%PDF-','UTF8') THEN
          RAISE EXCEPTION 'Library versions freeze their exact owned source and case'; END IF;
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_line_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py#L176).

Bindings: `invoice_lines.line_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_line_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE p projects%ROWTYPE; i invoices%ROWTYPE; reserved numeric; c_currency text;
    BEGIN
      PERFORM id FROM invoices WHERE id IN
        (CASE WHEN TG_OP<>'INSERT' THEN OLD.invoice_id END,
         CASE WHEN TG_OP<>'DELETE' THEN NEW.invoice_id END) ORDER BY id FOR UPDATE;
      IF TG_OP<>'INSERT' AND EXISTS(SELECT 1 FROM invoices WHERE id=OLD.invoice_id AND (status<>'Draft' OR issued_at IS NOT NULL))
      THEN RAISE EXCEPTION 'Issued lines are immutable'; END IF;
      IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      SELECT * INTO i FROM invoices WHERE id=NEW.invoice_id;
      IF i.status<>'Draft' OR i.issued_at IS NOT NULL THEN RAISE EXCEPTION 'Issued lines are immutable'; END IF;
      SELECT * INTO p FROM projects WHERE id=NEW.project_id FOR NO KEY UPDATE;
      SELECT currency INTO c_currency FROM clients WHERE id=p.client_id;
      IF p.client_id IS DISTINCT FROM i.client_id OR (NEW.basis<>'time' AND (p.status<>'active' OR NOT p.billable))
        OR i.currency IS DISTINCT FROM coalesce(p.budget_currency,c_currency)
      THEN RAISE EXCEPTION 'Statement line project and currency must match client'; END IF;
      IF NEW.basis='time' AND (p.project_type IN ('fixed_fee','on_demand_support_ff') OR i.fixed_fee_project_id IS NOT NULL OR i.manual_extra_project_id IS NOT NULL)
      THEN RAISE EXCEPTION 'Hourly lines require an hourly statement and project'; END IF;
      IF NEW.basis='fixed_fee' AND
        (i.fixed_fee_project_id IS DISTINCT FROM p.id OR p.budget_amount IS DISTINCT FROM NEW.amount)
      THEN RAISE EXCEPTION 'Fixed-fee line must reserve the stated project fee'; END IF;
      IF NEW.basis='manual_extra' AND
        (i.manual_extra_project_id IS DISTINCT FROM p.id OR NOT p.allow_overbilling OR NEW.amount<=0
         OR coalesce(length(btrim(NEW.charge_metadata->>'reason')),0) NOT BETWEEN 1 AND 2000
         OR NEW.charge_metadata->>'reference' IS DISTINCT FROM i.manual_extra_reference)
      THEN RAISE EXCEPTION 'Additional charge requires authorization, reason and matching reference'; END IF;
      IF NEW.basis IN ('fixed_fee','manual_extra') AND EXISTS
        (SELECT 1 FROM invoice_lines WHERE invoice_id=i.id AND id<>NEW.id)
      THEN RAISE EXCEPTION 'Project fee statement must contain one charge'; END IF;
      SELECT coalesce(sum(l.amount),0) INTO reserved FROM invoice_lines l JOIN invoices parent ON parent.id=l.invoice_id
        WHERE l.project_id=p.id AND parent.status<>'Void' AND l.basis<>'manual_extra' AND l.id<>NEW.id;
      IF NEW.basis<>'manual_extra' AND p.budget_amount IS NOT NULL AND reserved+NEW.amount>p.budget_amount
      THEN RAISE EXCEPTION 'Project budget would be exceeded'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_mail_attachment_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f710bc319ae2_mail_attachment_custody.py#L36).

Bindings: `mail_attachments.mail_attachment_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_mail_attachment_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE parent mail_messages%ROWTYPE; retained_count integer; retained_size bigint;
    BEGIN
      IF TG_OP IN ('UPDATE','DELETE') THEN
        RAISE EXCEPTION 'Mail attachments are retained and immutable';
      END IF;
      SELECT * INTO parent FROM mail_messages WHERE id=NEW.message_id;
      IF NOT FOUND THEN RAISE EXCEPTION 'Attachment parent is unavailable'; END IF;
      PERFORM id FROM users WHERE id=parent.owner_id AND active AND role='owner' FOR NO KEY UPDATE;
      IF NOT FOUND THEN RAISE EXCEPTION 'Attachment requires an active owner'; END IF;
      PERFORM id FROM clients WHERE id=parent.client_id FOR UPDATE;
      SELECT * INTO parent FROM mail_messages WHERE id=NEW.message_id FOR UPDATE;
      IF NOT FOUND THEN RAISE EXCEPTION 'Attachment parent is unavailable'; END IF;
      SELECT count(*),coalesce(sum(size),0) INTO retained_count,retained_size
        FROM mail_attachments WHERE message_id=NEW.message_id;
      IF retained_count >= parent.attachment_count OR retained_count >= 100 OR
         retained_size + NEW.size > 5242880
      THEN RAISE EXCEPTION 'Attachment custody bounds exceeded'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_mail_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py#L38).

Bindings: `mail_addresses.mail_address_guard`, `mail_messages.mail_message_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_mail_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_OP='UPDATE' THEN
        IF TG_TABLE_NAME='mail_messages' AND
           (to_jsonb(NEW)-'archived_at'-'updated_at') IS DISTINCT FROM
           (to_jsonb(OLD)-'archived_at'-'updated_at') THEN
          RAISE EXCEPTION 'Registered mail content is immutable';
        ELSIF TG_TABLE_NAME='mail_addresses' THEN
          IF (to_jsonb(NEW)-'revoked_at'-'updated_at') IS DISTINCT FROM
             (to_jsonb(OLD)-'revoked_at'-'updated_at') OR
             (OLD.revoked_at IS NOT NULL AND NEW.revoked_at IS DISTINCT FROM OLD.revoked_at) THEN
            RAISE EXCEPTION 'Capture address binding is immutable';
          END IF;
        END IF;
        RETURN NEW;
      END IF;
      PERFORM id FROM users WHERE id=NEW.owner_id AND active AND role='owner' FOR NO KEY UPDATE;
      IF NOT FOUND THEN RAISE EXCEPTION 'Mail requires an active owner'; END IF;
      PERFORM id FROM clients WHERE id=NEW.client_id FOR UPDATE;
      IF NEW.project_id IS NOT NULL AND NOT EXISTS
        (SELECT 1 FROM projects WHERE id=NEW.project_id AND client_id=NEW.client_id) THEN
        RAISE EXCEPTION 'Mail project association is invalid';
      END IF;
      IF NEW.case_id IS NOT NULL AND NOT EXISTS
        (SELECT 1 FROM cases WHERE id=NEW.case_id AND client_id=NEW.client_id
         AND owner_id=NEW.owner_id AND (project_id IS NULL OR project_id=NEW.project_id) FOR SHARE) THEN
        RAISE EXCEPTION 'Mail case association is invalid';
      END IF;
      RETURN NEW;
    END; $function$
```

## timeker_object_id_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L323).

Bindings: `clients.object_id_guard`, `invoices.object_id_guard`, `library_documents.object_id_guard`, `projects.object_id_guard`, `timecards.object_id_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_object_id_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF NEW.object_id IS DISTINCT FROM OLD.object_id THEN RAISE EXCEPTION 'Record numbers are retained'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_payment_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e3b42aea781a_parent_guards_and_sessions.py#L46).

Bindings: `payments.payment_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_payment_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Payment history is immutable'; END IF;
      IF ROW(NEW.invoice_id,NEW.paid_at,NEW.amount,NEW.currency,NEW.method,NEW.reference,NEW.note,NEW.created_by)
        IS DISTINCT FROM ROW(OLD.invoice_id,OLD.paid_at,OLD.amount,OLD.currency,OLD.method,OLD.reference,OLD.note,OLD.created_by)
        OR OLD.reversed_at IS NOT NULL
      THEN RAISE EXCEPTION 'Payment financial record is immutable'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_project_agreement_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a82d43cf6120_project_workflow_and_agreements.py#L38).

Bindings: `project_agreements.project_agreement_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_project_agreement_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE client_uuid uuid;
    BEGIN
      IF TG_OP IN ('UPDATE','DELETE') THEN
        RAISE EXCEPTION 'Project agreements are retained and immutable';
      END IF;
      IF NOT EXISTS(SELECT 1 FROM users WHERE id=NEW.uploaded_by AND active AND role='owner') THEN
        RAISE EXCEPTION 'Project agreement requires an active owner';
      END IF;
      SELECT client_id INTO client_uuid FROM projects WHERE id=NEW.project_id;
      PERFORM id FROM clients WHERE id=client_uuid AND status='active' FOR UPDATE;
      IF NOT FOUND THEN RAISE EXCEPTION 'Project agreement requires an active client'; END IF;
      PERFORM id FROM projects WHERE id=NEW.project_id AND client_id=client_uuid FOR UPDATE;
      IF NOT FOUND THEN RAISE EXCEPTION 'Project agreement is unavailable'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_project_billing_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py#L86).

Bindings: `projects.project_billing_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_project_billing_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE reserved numeric; has_base boolean;
    BEGIN
      IF NEW.client_id IS DISTINCT FROM OLD.client_id THEN
        RAISE EXCEPTION 'Project client binding is immutable';
      END IF;
      IF NEW.project_type IS DISTINCT FROM OLD.project_type AND EXISTS
        (SELECT 1 FROM invoice_lines WHERE project_id=OLD.id) THEN
        RAISE EXCEPTION 'Billed project type is immutable';
      END IF;
      IF ROW(NEW.budget_amount,NEW.budget_currency) IS DISTINCT FROM ROW(OLD.budget_amount,OLD.budget_currency)
        AND EXISTS(SELECT 1 FROM invoices WHERE fixed_fee_project_id=OLD.id AND status<>'Void')
      THEN RAISE EXCEPTION 'Active fixed-fee statement freezes the project fee'; END IF;
      SELECT coalesce(sum(l.amount),0), count(*)>0 INTO reserved,has_base
        FROM invoice_lines l JOIN invoices i ON i.id=l.invoice_id
        WHERE l.project_id=OLD.id AND i.status<>'Void' AND l.basis<>'manual_extra';
      IF (has_base AND OLD.budget_amount IS NOT NULL AND NEW.budget_amount IS NULL)
        OR (NEW.budget_amount IS NOT NULL AND NEW.budget_amount < reserved) THEN
        RAISE EXCEPTION 'Project budget cannot fall below reserved base charges';
      END IF;
      IF NEW.budget_currency IS NOT NULL AND EXISTS
        (SELECT 1 FROM invoice_lines l JOIN invoices i ON i.id=l.invoice_id
         WHERE l.project_id=OLD.id AND i.status<>'Void' AND i.currency<>NEW.budget_currency) THEN
        RAISE EXCEPTION 'Project budget currency must match active statements';
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_proposal_sending_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py#L441).

Bindings: `proposal_sending_attempts.proposal_attempt_guard`, `proposal_sending_deliveries.proposal_delivery_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_proposal_sending_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE source_owner uuid; source_case uuid; source_revision uuid; source_number integer;
      source_kind text; source_bytes bytea; source_digest text; source_filename text; source_type text;
      library_row library_document_versions%ROWTYPE; parent_row proposal_sending_deliveries%ROWTYPE;
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Commercial delivery history is retained'; END IF;
      IF TG_TABLE_NAME='proposal_sending_attempts' THEN
        SELECT * INTO parent_row FROM proposal_sending_deliveries WHERE id=NEW.delivery_id;
        IF parent_row.id IS NULL OR NEW.number<>parent_row.attempt_count THEN
          RAISE EXCEPTION 'An attempt must match its claimed delivery'; END IF;
        IF TG_OP='INSERT' THEN
          IF NEW.state<>'uncertain' OR NEW.code<>'claimed' OR NEW.completed_at IS NOT NULL
            OR parent_row.state<>'uncertain' OR parent_row.last_code<>'claimed' THEN
            RAISE EXCEPTION 'Attempts start with a durable uncertain claim'; END IF;
        ELSIF OLD.completed_at IS NOT NULL OR OLD.state<>'uncertain' OR OLD.code<>'claimed'
          OR NEW.completed_at IS NULL OR
          (to_jsonb(NEW)-ARRAY['updated_at','state','code','completed_at']) IS DISTINCT FROM
          (to_jsonb(OLD)-ARRAY['updated_at','state','code','completed_at']) THEN
          RAISE EXCEPTION 'Completed commercial attempts are immutable'; END IF;
        RETURN NEW;
      END IF;
      IF TG_OP='INSERT' THEN
        IF NEW.state<>'draft' OR NEW.attempt_count<>0 OR NEW.confirmed_at IS NOT NULL
          OR NEW.sent_at IS NOT NULL OR NEW.stopped_at IS NOT NULL OR NOT EXISTS(
          SELECT 1 FROM users WHERE id=NEW.owner_id AND active AND role='owner') THEN
          RAISE EXCEPTION 'Commercial deliveries start as owner-reviewed drafts'; END IF;
        IF NEW.quote_artifact_id IS NOT NULL THEN
          SELECT a.owner_id,r.case_id,r.id,r.number,'hle',a.pdf_bytes,a.sha256,a.filename,'application/pdf'
            INTO source_owner,source_case,source_revision,source_number,source_kind,source_bytes,source_digest,source_filename,source_type
            FROM quote_artifacts a JOIN quote_revisions r ON r.id=a.revision_id
            WHERE a.id=NEW.quote_artifact_id AND r.status='published';
        ELSE
          SELECT * INTO library_row FROM library_document_versions WHERE id=NEW.library_version_id;
          source_owner=library_row.owner_id; source_case=(library_row.snapshot->>'case_id')::uuid;
          source_revision=library_row.id; source_number=library_row.number; source_kind=library_row.snapshot->>'kind';
          IF library_row.snapshot->>'attachment_format'='original' THEN
            SELECT payload,sha256,filename,content_type INTO source_bytes,source_digest,source_filename,source_type
              FROM library_uploads WHERE id=library_row.source_upload_id AND document_id=library_row.document_id;
          ELSE
            source_bytes=library_row.pdf_bytes; source_digest=library_row.pdf_sha256;
            source_filename=library_row.filename; source_type='application/pdf';
          END IF;
        END IF;
        IF source_owner IS DISTINCT FROM NEW.owner_id OR source_case IS DISTINCT FROM NEW.case_id
          OR source_revision IS DISTINCT FROM NEW.artifact_revision_id OR source_number IS DISTINCT FROM NEW.revision_number
          OR source_kind IS DISTINCT FROM NEW.document_kind OR source_bytes IS DISTINCT FROM NEW.attachment_bytes
          OR source_digest IS DISTINCT FROM NEW.attachment_sha256 OR source_filename IS DISTINCT FROM NEW.attachment_filename
          OR source_type IS DISTINCT FROM NEW.attachment_content_type OR NOT EXISTS(
            SELECT 1 FROM cases WHERE id=NEW.case_id AND owner_id=NEW.owner_id) THEN
          RAISE EXCEPTION 'Commercial delivery must bind the exact published owned artifact'; END IF;
      ELSE
        IF (to_jsonb(NEW)-ARRAY['updated_at','version','recipient','subject','body','state','attempt_count',
              'last_code','confirmed_at','sent_at','stopped_at']) IS DISTINCT FROM
            (to_jsonb(OLD)-ARRAY['updated_at','version','recipient','subject','body','state','attempt_count',
              'last_code','confirmed_at','sent_at','stopped_at'])
          OR (OLD.stopped_at IS NOT NULL AND NEW.stopped_at IS DISTINCT FROM OLD.stopped_at)
          OR (OLD.attempt_count>0 AND (NEW.recipient,NEW.subject,NEW.body) IS DISTINCT FROM (OLD.recipient,OLD.subject,OLD.body)) THEN
          RAISE EXCEPTION 'Commercial source, message and terminal stop history are immutable'; END IF;
        IF NEW.attempt_count=OLD.attempt_count+1 THEN
          IF OLD.state NOT IN ('draft','failed') OR OLD.stopped_at IS NOT NULL OR NEW.state<>'uncertain'
            OR NEW.last_code<>'claimed' OR NEW.confirmed_at IS NULL
            OR (NEW.recipient,NEW.subject,NEW.body) IS DISTINCT FROM (OLD.recipient,OLD.subject,OLD.body) THEN
            RAISE EXCEPTION 'A delivery needs a fresh reviewed claim before provider dispatch'; END IF;
        ELSIF NEW.attempt_count<>OLD.attempt_count OR NEW.confirmed_at IS DISTINCT FROM OLD.confirmed_at OR NOT (
          (OLD.state='draft' AND NEW.state='draft' AND OLD.attempt_count=0 AND OLD.stopped_at IS NULL) OR
          (OLD.state IN ('draft','failed') AND NEW.state='stopped' AND NEW.stopped_at IS NOT NULL) OR
          (OLD.state='uncertain' AND NEW.state IN ('sent','failed','uncertain')) OR
          (OLD.state IN ('sent','uncertain') AND NEW.state=OLD.state AND NEW.stopped_at IS NOT NULL)) THEN
          RAISE EXCEPTION 'Commercial delivery transitions require explicit conservative retry or stop'; END IF;
      END IF;
      IF (NEW.state='sent') IS DISTINCT FROM (NEW.sent_at IS NOT NULL) THEN
        RAISE EXCEPTION 'Commercial sent state requires its retained timestamp'; END IF;
      RETURN NEW;
    END $function$
```

## timeker_quote_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py#L20).

Bindings: `quote_artifacts.quote_artifact_guard`, `quote_lines.quote_line_guard`, `quote_revisions.quote_revision_guard`, `quotes.quote_root_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_quote_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE root_row quotes%ROWTYPE; revision_row quote_revisions%ROWTYPE;
    BEGIN
      IF TG_TABLE_NAME='quotes' THEN
        IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Estimates are retained; archive instead'; END IF;
        IF NOT EXISTS(SELECT 1 FROM users WHERE id=NEW.owner_id AND active AND role='owner') THEN
          RAISE EXCEPTION 'An active estimate owner is required'; END IF;
        IF TG_OP='UPDATE' AND (
          (to_jsonb(NEW)-ARRAY['updated_at','version','archived_at']) IS DISTINCT FROM
          (to_jsonb(OLD)-ARRAY['updated_at','version','archived_at']) OR
          (OLD.archived_at IS NOT NULL AND NEW.archived_at IS DISTINCT FROM OLD.archived_at)) THEN
          RAISE EXCEPTION 'Estimate identity and retained archive are immutable'; END IF;
        RETURN NEW;
      END IF;
      IF TG_TABLE_NAME='quote_revisions' THEN
        IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Estimate revisions are retained'; END IF;
        SELECT * INTO root_row FROM quotes WHERE id=NEW.quote_id FOR UPDATE;
        IF root_row.id IS NULL OR root_row.archived_at IS NOT NULL OR NOT EXISTS(
          SELECT 1 FROM cases c JOIN projects p ON p.id=c.project_id JOIN clients k ON k.id=c.client_id
          JOIN users u ON u.id=c.owner_id
          WHERE c.id=NEW.case_id AND c.owner_id=root_row.owner_id AND u.active AND u.role='owner'
          AND c.client_id=NEW.client_id AND c.project_id=NEW.project_id AND p.client_id=c.client_id
          AND c.archived_at IS NULL AND p.status='active' AND k.status='active') THEN
          RAISE EXCEPTION 'An estimate requires its owned case, project and client'; END IF;
        IF TG_OP='INSERT' THEN
          IF NEW.status<>'draft' OR (NEW.parent_revision_id IS NOT NULL AND NOT EXISTS(
            SELECT 1 FROM quote_revisions WHERE id=NEW.parent_revision_id AND quote_id=NEW.quote_id AND status='published')) THEN
            RAISE EXCEPTION 'New estimate revisions start as drafts'; END IF;
        ELSE
          IF OLD.status='published' OR
            (to_jsonb(NEW)-ARRAY['updated_at','version','status','title','prepared_for','case_id','project_id','client_id',
              'preset','currency','assumptions','exclusions','valid_until','flexfields']) IS DISTINCT FROM
            (to_jsonb(OLD)-ARRAY['updated_at','version','status','title','prepared_for','case_id','project_id','client_id',
              'preset','currency','assumptions','exclusions','valid_until','flexfields']) THEN
            RAISE EXCEPTION 'Published estimate revisions and their lineage are immutable'; END IF;
          IF EXISTS(SELECT 1 FROM quote_artifacts WHERE revision_id=NEW.id) AND
            (to_jsonb(NEW)-ARRAY['updated_at','version','status']) IS DISTINCT FROM
            (to_jsonb(OLD)-ARRAY['updated_at','version','status']) THEN
            RAISE EXCEPTION 'A frozen estimate cannot change before publication'; END IF;
          IF NEW.status='published' AND (NOT EXISTS(
            SELECT 1 FROM quote_artifacts WHERE revision_id=NEW.id AND owner_id=root_row.owner_id)
            OR NOT EXISTS(SELECT 1 FROM quote_lines WHERE revision_id=NEW.id)) THEN
            RAISE EXCEPTION 'Publication requires a frozen artifact and estimate lines'; END IF;
        END IF;
        RETURN NEW;
      END IF;
      SELECT * INTO revision_row FROM quote_revisions WHERE id=COALESCE(NEW.revision_id,OLD.revision_id);
      SELECT * INTO root_row FROM quotes WHERE id=revision_row.quote_id FOR UPDATE;
      IF TG_TABLE_NAME='quote_artifacts' THEN
        IF TG_OP<>'INSERT' THEN RAISE EXCEPTION 'Published estimate artifacts are immutable'; END IF;
        IF revision_row.status<>'draft' OR root_row.owner_id<>NEW.owner_id OR root_row.archived_at IS NOT NULL
          OR NOT EXISTS(SELECT 1 FROM users WHERE id=NEW.owner_id AND active AND role='owner')
          OR NOT EXISTS(SELECT 1 FROM quote_lines WHERE revision_id=NEW.revision_id)
          OR NEW.snapshot->>'revision_id' IS DISTINCT FROM NEW.revision_id::text
          OR NEW.snapshot->>'owner_id' IS DISTINCT FROM NEW.owner_id::text
          OR NEW.snapshot->>'case_id' IS DISTINCT FROM revision_row.case_id::text
          OR NEW.snapshot->>'client_id' IS DISTINCT FROM revision_row.client_id::text
          OR NEW.snapshot->>'project_id' IS DISTINCT FROM revision_row.project_id::text
          OR NEW.snapshot->>'revision_number' IS DISTINCT FROM revision_row.number::text
          OR substring(NEW.pdf_bytes FROM 1 FOR 5)<>convert_to('%PDF-','UTF8') THEN
          RAISE EXCEPTION 'A published estimate must freeze the exact owned revision'; END IF;
        RETURN NEW;
      END IF;
      IF revision_row.id IS NULL OR revision_row.status<>'draft' OR root_row.archived_at IS NOT NULL
        OR EXISTS(SELECT 1 FROM quote_artifacts WHERE revision_id=revision_row.id) THEN
        RAISE EXCEPTION 'Published or archived estimate lines cannot change'; END IF;
      IF TG_OP='UPDATE' AND (NEW.revision_id<>OLD.revision_id OR NEW.id<>OLD.id OR NEW.created_at<>OLD.created_at) THEN
        RAISE EXCEPTION 'Estimate lines cannot move between revisions'; END IF;
      IF TG_OP<>'DELETE' AND NEW.pricing_model IS NOT NULL AND revision_row.currency IS NULL THEN
        RAISE EXCEPTION 'Priced estimates require an explicit currency'; END IF;
      IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      RETURN NEW;
    END $function$
```

## timeker_registration_history_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_003_onboarding_auth.py#L62).

Bindings: `email_auth_challenges.email_challenge_history`, `owner_identities.identity_binding_history`, `owner_registrations.registration_acceptance_history`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_registration_history_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_OP='DELETE' OR TG_TABLE_NAME='owner_registrations' THEN
        RAISE EXCEPTION 'Account identity and registration history are retained';
      END IF;
      IF TG_TABLE_NAME='owner_identities' THEN
        IF (NEW.id,NEW.owner_id,NEW.issuer,NEW.subject,NEW.verified_email,NEW.created_at)
           IS DISTINCT FROM
           (OLD.id,OLD.owner_id,OLD.issuer,OLD.subject,OLD.verified_email,OLD.created_at)
           OR OLD.revoked_at IS NOT NULL OR NEW.revoked_at IS NULL THEN
          RAISE EXCEPTION 'Identity binding is immutable; only explicit revocation is permitted';
        END IF;
      ELSE
        IF (NEW.id,NEW.owner_id,NEW.session_digest,NEW.intent,NEW.offer,NEW.created_at,NEW.expires_at)
           IS DISTINCT FROM
           (OLD.id,OLD.owner_id,OLD.session_digest,OLD.intent,OLD.offer,OLD.created_at,OLD.expires_at)
           OR NOT (
             (OLD.state='reserved' AND NEW.state IN ('ready','failed') AND NEW.attempts=OLD.attempts) OR
             (OLD.state='ready' AND NEW.state='verifying' AND NEW.attempts=OLD.attempts+1) OR
             (OLD.state='ready' AND NEW.state='failed' AND NEW.attempts=OLD.attempts) OR
             (OLD.state='verifying' AND NEW.state IN ('ready','consumed','failed') AND NEW.attempts=OLD.attempts)
           ) THEN
          RAISE EXCEPTION 'Challenge identity, bounded attempts and terminal states are retained';
        END IF;
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_sending_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_004_sending.py#L89).

Bindings: `sending_attempts.sending_attempt_history`, `sending_deliveries.sending_delivery_history`, `sending_plans.sending_plan_history`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_sending_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    DECLARE plan_row sending_plans; invoice_row invoices; artifact_row invoice_artifacts;
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Sending authority and history are retained'; END IF;
      IF TG_TABLE_NAME='sending_plans' THEN
        IF TG_OP='INSERT' THEN
          SELECT * INTO invoice_row FROM invoices WHERE id=NEW.invoice_id FOR UPDATE;
          SELECT * INTO artifact_row FROM invoice_artifacts WHERE id=NEW.artifact_id;
          IF invoice_row.status NOT IN ('Issued','Sent') OR invoice_row.issued_at IS NULL
            OR invoice_row.voided_at IS NOT NULL OR invoice_row.snapshot IS NULL
            OR artifact_row.id IS NULL OR artifact_row.invoice_id<>NEW.invoice_id
            OR artifact_row.sha256<>NEW.artifact_sha256
            OR NOT EXISTS(SELECT 1 FROM users WHERE id=NEW.owner_id AND active AND role='owner')
            OR (SELECT count(*) FROM users WHERE active AND role='owner')<>1 THEN
            RAISE EXCEPTION 'Sending requires the sole owner and a matching valid issued artifact';
          END IF;
        ELSIF (to_jsonb(NEW)-ARRAY['updated_at','stopped_at','stop_reason']) IS DISTINCT FROM
              (to_jsonb(OLD)-ARRAY['updated_at','stopped_at','stop_reason'])
           OR OLD.stopped_at IS NOT NULL OR NEW.stopped_at IS NULL OR NEW.stop_reason IS NULL THEN
          RAISE EXCEPTION 'Confirmed sending authority is immutable; stop is one way';
        END IF;
      ELSIF TG_TABLE_NAME='sending_deliveries' THEN
        SELECT * INTO plan_row FROM sending_plans WHERE id=NEW.plan_id;
        IF plan_row.id IS NULL OR plan_row.owner_id<>NEW.owner_id OR NEW.sequence>plan_row.followup_max
           OR (NEW.state='sent') IS DISTINCT FROM (NEW.sent_at IS NOT NULL) THEN
          RAISE EXCEPTION 'Delivery owner, sequence and terminal timestamp must match';
        END IF;
        IF TG_OP='INSERT' THEN
          IF NEW.state<>'pending' OR NEW.attempt_count<>0 OR plan_row.stopped_at IS NOT NULL
            OR (NEW.sequence>0 AND NOT EXISTS(SELECT 1 FROM sending_deliveries
              WHERE plan_id=NEW.plan_id AND sequence=NEW.sequence-1 AND state='sent')) THEN
            RAISE EXCEPTION 'Delivery creation requires an active authorized sequence';
          END IF;
        ELSIF (to_jsonb(NEW)-ARRAY['updated_at','state','sent_at','failure_code','attempt_count'])
              IS DISTINCT FROM (to_jsonb(OLD)-ARRAY['updated_at','state','sent_at','failure_code','attempt_count'])
          OR NOT (
            (OLD.state='pending' AND NEW.state='uncertain' AND NEW.attempt_count=OLD.attempt_count+1) OR
            (OLD.state='pending' AND NEW.state='stopped' AND NEW.attempt_count=OLD.attempt_count) OR
            (OLD.state='failed' AND NEW.state IN ('pending','stopped') AND NEW.attempt_count=OLD.attempt_count) OR
            (OLD.state='uncertain' AND NEW.state IN ('sent','failed','uncertain','stopped') AND NEW.attempt_count=OLD.attempt_count)
          ) THEN RAISE EXCEPTION 'Delivery history and conservative retry transitions are retained'; END IF;
      ELSIF TG_TABLE_NAME='sending_attempts' THEN
        IF TG_OP='INSERT' THEN
          IF NEW.state<>'uncertain' OR NEW.code<>'claimed' OR NEW.completed_at IS NOT NULL THEN
            RAISE EXCEPTION 'Attempts begin with a durable uncertain claim';
          END IF;
        ELSIF (to_jsonb(NEW)-ARRAY['updated_at','state','code','provider_reference','completed_at'])
              IS DISTINCT FROM (to_jsonb(OLD)-ARRAY['updated_at','state','code','provider_reference','completed_at'])
          OR OLD.state<>'uncertain' OR OLD.completed_at IS NOT NULL OR NEW.completed_at IS NULL THEN
          RAISE EXCEPTION 'Sending attempt history is immutable after completion';
        END IF;
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_subscription_billing_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_002_sandbox_billing.py#L97).

Bindings: `subscription_billing_accounts.subscription_billing_account_history`, `subscription_billing_events.subscription_billing_event_history`, `subscription_billing_operations.subscription_billing_operation_history`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_subscription_billing_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_OP='DELETE' OR TG_TABLE_NAME='subscription_billing_events' THEN
        RAISE EXCEPTION 'Sandbox billing authority and receipts are retained';
      END IF;
      IF TG_TABLE_NAME='subscription_billing_operations' THEN
        IF OLD.state IN ('confirmed','failed') OR
           (NEW.id,NEW.owner_id,NEW.key_digest,NEW.payload_digest,NEW.action,NEW.intent,NEW.created_at)
           IS DISTINCT FROM
           (OLD.id,OLD.owner_id,OLD.key_digest,OLD.payload_digest,OLD.action,OLD.intent,OLD.created_at) OR
           (OLD.transaction_id IS NOT NULL AND NEW.transaction_id IS DISTINCT FROM OLD.transaction_id) THEN
          RAISE EXCEPTION 'Sandbox operation identity and terminal results are immutable';
        END IF;
      ELSE
        IF (NEW.id,NEW.owner_id,NEW.customer_id,NEW.subscription_id,NEW.checkout_id,NEW.created_at)
           IS DISTINCT FROM
           (OLD.id,OLD.owner_id,OLD.customer_id,OLD.subscription_id,OLD.checkout_id,OLD.created_at) OR
           NEW.paid_through < OLD.paid_through OR NOT OLD.current THEN
          RAISE EXCEPTION 'Sandbox binding and proven payment history are immutable';
        END IF;
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_subscription_history_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_001_subscriptions.py#L43).

Bindings: `subscription_operations.subscription_operation_history`, `workspace_subscriptions.subscription_assignment_history`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_subscription_history_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF TG_TABLE_NAME='subscription_operations' OR TG_OP='DELETE' THEN
        RAISE EXCEPTION 'Subscription authority and operation history are retained';
      END IF;
      IF (NEW.id,NEW.owner_id,NEW.created_at) IS DISTINCT FROM (OLD.id,OLD.owner_id,OLD.created_at) THEN
        RAISE EXCEPTION 'Subscription workspace ownership is immutable';
      END IF;
      RETURN NEW;
    END $function$
```

## timeker_time_operation_guard

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py#L142).

Bindings: `time_import_records.time_import_record_guard`, `time_operations.time_operation_guard`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_time_operation_guard()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN RAISE EXCEPTION 'Time operation and import identities are immutable'; END $function$
```

## timeker_timecard_void_restriction

[Final body source](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py#L94).

Bindings: `timecards.timecard_void_restriction`.

```sql
CREATE OR REPLACE FUNCTION timeker_reference.timeker_timecard_void_restriction()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
AS $function$
    BEGIN
      IF NEW.status='Voided' AND (TG_OP='INSERT' OR OLD.status IS DISTINCT FROM 'Voided') THEN
        RAISE EXCEPTION 'Only issued statements can be voided';
      END IF;
      RETURN NEW;
    END $function$
```
