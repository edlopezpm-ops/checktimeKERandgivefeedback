-- DOCUMENTATION REFERENCE ONLY: empty local reconstruction, not hosted DDL/ACLs.
--
-- PostgreSQL database dump
--


-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: timeker_reference; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA timeker_reference;


--
-- Name: timeker_admission_history_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_admission_history_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_allocated_entry_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_allocated_entry_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_allocated_parent_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_allocated_parent_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_allocation_contribution_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_allocation_contribution_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    DECLARE attributed INTEGER;
    BEGIN
      SELECT COALESCE(sum(minutes),0) INTO attributed FROM time_contributions
        WHERE entry_id=OLD.entry_id AND case_id=OLD.case_id;
      IF attributed>0 AND (TG_OP='DELETE' OR NEW.minutes<attributed OR
          (NEW.entry_id,NEW.case_id) IS DISTINCT FROM (OLD.entry_id,OLD.case_id))
      THEN RAISE EXCEPTION 'Correct contributions before reducing their case allocation'; END IF;
      IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_allocation_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_allocation_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_archive_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_archive_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF TG_OP='DELETE' THEN
        IF OLD.archived_at IS NOT NULL THEN RAISE EXCEPTION 'Archived records are retained'; END IF;
        RETURN OLD;
      END IF;
      IF OLD.archived_at IS NOT NULL AND NEW.archived_at IS DISTINCT FROM OLD.archived_at THEN
        RAISE EXCEPTION 'Archive markers are permanent';
      END IF;
      RETURN NEW;
    END; $$;


--
-- Name: timeker_artifact_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_artifact_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN RAISE EXCEPTION 'Artifact or audit history is immutable'; END $$;


--
-- Name: timeker_case_archive_status_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_case_archive_status_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF NEW.archived_at IS NOT NULL AND NEW.status<>'Closed' THEN
        RAISE EXCEPTION 'Only Closed cases can be archived'; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_case_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_case_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_commercial_case_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_commercial_case_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF (NEW.owner_id,NEW.client_id,NEW.project_id) IS DISTINCT FROM (OLD.owner_id,OLD.client_id,OLD.project_id)
        AND (EXISTS(SELECT 1 FROM quote_revisions WHERE case_id=OLD.id)
          OR EXISTS(SELECT 1 FROM library_documents WHERE case_id=OLD.id)) THEN
        RAISE EXCEPTION 'Retained commercial documents preserve their case, project and client'; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_contribution_allocation_check(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_contribution_allocation_check() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    DECLARE attributed INTEGER; allocated INTEGER;
    BEGIN
      IF NEW.case_id IS NULL OR NEW.entry_id IS NULL THEN RETURN NEW; END IF;
      SELECT COALESCE(sum(minutes),0) INTO attributed FROM time_contributions
        WHERE entry_id=NEW.entry_id AND case_id=NEW.case_id;
      SELECT COALESCE(sum(minutes),0) INTO allocated FROM case_time_allocations
        WHERE entry_id=NEW.entry_id AND case_id=NEW.case_id;
      IF attributed>allocated THEN RAISE EXCEPTION 'Attributed case minutes require their allocation'; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_contribution_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_contribution_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_credit_memo_final_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_credit_memo_final_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_credit_memo_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_credit_memo_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_entry_contribution_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_entry_contribution_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    DECLARE attributed INTEGER;
    BEGIN
      SELECT COALESCE(sum(minutes),0) INTO attributed FROM time_contributions WHERE entry_id=OLD.id;
      IF attributed>0 AND (TG_OP='DELETE' OR NEW.minutes<attributed OR
          (NEW.timecard_id,NEW.project_id,NEW.work_date) IS DISTINCT FROM
          (OLD.timecard_id,OLD.project_id,OLD.work_date))
      THEN RAISE EXCEPTION 'Correct contributions before reducing their parent'; END IF;
      IF TG_OP='DELETE' THEN RETURN OLD; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_entry_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_entry_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_internal_billing_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_internal_billing_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF EXISTS(SELECT 1 FROM time_entries e JOIN timecards c ON c.id=e.timecard_id
        WHERE e.id=NEW.entry_id AND c.is_internal) THEN
        RAISE EXCEPTION 'Internal productivity time cannot be reserved for billing'; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_internal_card_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_internal_card_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_invoice_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_invoice_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_issued_artifact_check(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_issued_artifact_check() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF NEW.issued_at IS NOT NULL AND NOT EXISTS (SELECT 1 FROM invoice_artifacts WHERE invoice_id=NEW.id)
      THEN RAISE EXCEPTION 'Issued invoice requires a frozen artifact'; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_library_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_library_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_line_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_line_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_mail_attachment_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_mail_attachment_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_mail_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_mail_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END; $$;


--
-- Name: timeker_object_id_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_object_id_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF NEW.object_id IS DISTINCT FROM OLD.object_id THEN RAISE EXCEPTION 'Record numbers are retained'; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_payment_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_payment_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF TG_OP='DELETE' THEN RAISE EXCEPTION 'Payment history is immutable'; END IF;
      IF ROW(NEW.invoice_id,NEW.paid_at,NEW.amount,NEW.currency,NEW.method,NEW.reference,NEW.note,NEW.created_by)
        IS DISTINCT FROM ROW(OLD.invoice_id,OLD.paid_at,OLD.amount,OLD.currency,OLD.method,OLD.reference,OLD.note,OLD.created_by)
        OR OLD.reversed_at IS NOT NULL
      THEN RAISE EXCEPTION 'Payment financial record is immutable'; END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_project_agreement_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_project_agreement_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_project_billing_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_project_billing_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_proposal_sending_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_proposal_sending_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_quote_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_quote_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_registration_history_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_registration_history_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_sending_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_sending_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_subscription_billing_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_subscription_billing_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
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
    END $$;


--
-- Name: timeker_subscription_history_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_subscription_history_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF TG_TABLE_NAME='subscription_operations' OR TG_OP='DELETE' THEN
        RAISE EXCEPTION 'Subscription authority and operation history are retained';
      END IF;
      IF (NEW.id,NEW.owner_id,NEW.created_at) IS DISTINCT FROM (OLD.id,OLD.owner_id,OLD.created_at) THEN
        RAISE EXCEPTION 'Subscription workspace ownership is immutable';
      END IF;
      RETURN NEW;
    END $$;


--
-- Name: timeker_time_operation_guard(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_time_operation_guard() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN RAISE EXCEPTION 'Time operation and import identities are immutable'; END $$;


--
-- Name: timeker_timecard_void_restriction(); Type: FUNCTION; Schema: timeker_reference; Owner: -
--

CREATE FUNCTION timeker_reference.timeker_timecard_void_restriction() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'pg_catalog', 'timeker_reference', 'pg_temp'
    AS $$
    BEGIN
      IF NEW.status='Voided' AND (TG_OP='INSERT' OR OLD.status IS DISTINCT FROM 'Voided') THEN
        RAISE EXCEPTION 'Only issued statements can be voided';
      END IF;
      RETURN NEW;
    END $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admission_identities; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.admission_identities (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    tenant_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    identity_id uuid NOT NULL,
    issuer character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    verified_email character varying(254) NOT NULL,
    state character varying(12) NOT NULL,
    CONSTRAINT admission_identities_state_check CHECK (((state)::text = ANY ((ARRAY['pending'::character varying, 'active'::character varying, 'blocked'::character varying, 'revoked'::character varying])::text[])))
);


--
-- Name: alembic_version; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: app_settings; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.app_settings (
    key character varying(30) NOT NULL,
    value jsonb NOT NULL,
    encrypted_value bytea,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: audit_events; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.audit_events (
    actor_id uuid,
    request_id uuid NOT NULL,
    event_type character varying(60) NOT NULL,
    entity_type character varying(30) NOT NULL,
    entity_id uuid NOT NULL,
    details jsonb NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: case_time_allocations; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.case_time_allocations (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    entry_id uuid NOT NULL,
    case_id uuid NOT NULL,
    minutes integer NOT NULL,
    actor_id uuid NOT NULL,
    version integer NOT NULL,
    CONSTRAINT case_time_allocations_minutes_check CHECK (((minutes >= 1) AND (minutes <= 1440)))
);


--
-- Name: cases; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.cases (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    client_id uuid NOT NULL,
    project_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    legacy_number character varying(30),
    title character varying(200) NOT NULL,
    description text,
    status character varying(20) NOT NULL,
    opened_at timestamp with time zone NOT NULL,
    resolved_at timestamp with time zone,
    closed_at timestamp with time zone,
    archived_at timestamp with time zone,
    version integer NOT NULL,
    number bigint NOT NULL,
    case_type character varying(20) NOT NULL,
    flexfields jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT case_description_length CHECK (((description IS NULL) OR (char_length(description) <= 500))),
    CONSTRAINT case_number_range CHECK ((number >= 10001)),
    CONSTRAINT case_type_allowed CHECK (((case_type)::text = ANY ((ARRAY['Issue'::character varying, 'Consulting'::character varying, 'Dev Services'::character varying, 'Design'::character varying, 'Services'::character varying])::text[]))),
    CONSTRAINT cases_flexfields_valid CHECK (((jsonb_typeof(flexfields) = 'object'::text) AND ((flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb) AND ((NOT (flexfields ? 'flexfield1'::text)) OR ((flexfields -> 'flexfield1'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield1'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield1'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield2'::text)) OR ((flexfields -> 'flexfield2'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield2'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield2'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield3'::text)) OR ((flexfields -> 'flexfield3'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield3'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield3'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield4'::text)) OR ((flexfields -> 'flexfield4'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield4'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield4'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield5'::text)) OR ((flexfields -> 'flexfield5'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield5'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield5'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield6'::text)) OR ((flexfields -> 'flexfield6'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield6'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield6'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield7'::text)) OR ((flexfields -> 'flexfield7'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield7'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))) AND ((NOT (flexfields ? 'flexfield8'::text)) OR ((flexfields -> 'flexfield8'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield8'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))))),
    CONSTRAINT cases_status_check CHECK (((status)::text = ANY ((ARRAY['Open'::character varying, 'In progress'::character varying, 'Waiting'::character varying, 'Resolved'::character varying, 'Closed'::character varying])::text[])))
);


--
-- Name: cases_number_seq; Type: SEQUENCE; Schema: timeker_reference; Owner: -
--

ALTER TABLE timeker_reference.cases ALTER COLUMN number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME timeker_reference.cases_number_seq
    START WITH 10001
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: client_drafts; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.client_drafts (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    owner_id uuid NOT NULL,
    payload jsonb NOT NULL,
    version integer NOT NULL
);


--
-- Name: client_source_references; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.client_source_references (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    client_id uuid NOT NULL,
    uploaded_by uuid NOT NULL,
    filename character varying(180) NOT NULL,
    media_type character varying(80) NOT NULL,
    content bytea,
    url text,
    sha256 character varying(64),
    CONSTRAINT client_source_payload CHECK ((((content IS NOT NULL) AND (url IS NULL) AND ((octet_length(content) >= 1) AND (octet_length(content) <= 5242880)) AND ((sha256)::text ~ '^[0-9a-f]{64}$'::text)) OR ((content IS NULL) AND (url IS NOT NULL) AND ((length(url) >= 1) AND (length(url) <= 2048)) AND (sha256 IS NULL))))
);


--
-- Name: clients; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.clients (
    code character varying(30) NOT NULL,
    legal_name character varying(200) NOT NULL,
    display_name character varying(120) NOT NULL,
    country_code character varying(2) NOT NULL,
    status character varying(20) DEFAULT 'draft'::character varying NOT NULL,
    timezone character varying(80) NOT NULL,
    language character varying(2) NOT NULL,
    currency character varying(3) NOT NULL,
    rate numeric(14,2) NOT NULL,
    weekly_limit_minutes integer,
    payment_terms_days integer NOT NULL,
    profile jsonb NOT NULL,
    contract jsonb NOT NULL,
    archived_at timestamp with time zone,
    version integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    object_id bigint NOT NULL,
    flexfields jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT client_status_allowed CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'active'::character varying, 'archived'::character varying])::text[]))),
    CONSTRAINT clients_check CHECK (((rate >= (0)::numeric) AND (payment_terms_days >= 0))),
    CONSTRAINT clients_flexfields_valid CHECK (((jsonb_typeof(flexfields) = 'object'::text) AND ((flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb) AND ((NOT (flexfields ? 'flexfield1'::text)) OR ((flexfields -> 'flexfield1'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield1'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield1'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield2'::text)) OR ((flexfields -> 'flexfield2'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield2'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield2'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield3'::text)) OR ((flexfields -> 'flexfield3'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield3'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield3'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield4'::text)) OR ((flexfields -> 'flexfield4'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield4'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield4'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield5'::text)) OR ((flexfields -> 'flexfield5'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield5'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield5'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield6'::text)) OR ((flexfields -> 'flexfield6'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield6'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield6'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield7'::text)) OR ((flexfields -> 'flexfield7'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield7'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))) AND ((NOT (flexfields ? 'flexfield8'::text)) OR ((flexfields -> 'flexfield8'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield8'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))))),
    CONSTRAINT clients_language_check CHECK (((language)::text = ANY ((ARRAY['es'::character varying, 'en'::character varying])::text[]))),
    CONSTRAINT clients_weekly_limit_minutes_check CHECK (((weekly_limit_minutes IS NULL) OR ((weekly_limit_minutes >= 0) AND (weekly_limit_minutes <= 10080))))
);


--
-- Name: clients_object_id_seq; Type: SEQUENCE; Schema: timeker_reference; Owner: -
--

ALTER TABLE timeker_reference.clients ALTER COLUMN object_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME timeker_reference.clients_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contact_attempts; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.contact_attempts (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    session_digest character varying(64) NOT NULL,
    address_digest character varying(64) NOT NULL,
    network_digest character varying(64) NOT NULL,
    payload_digest character varying(64) NOT NULL,
    status character varying(12) NOT NULL,
    CONSTRAINT contact_attempts_status_check CHECK (((status)::text = ANY ((ARRAY['reserved'::character varying, 'accepted'::character varying, 'uncertain'::character varying])::text[])))
);


--
-- Name: contacts; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.contacts (
    client_id uuid NOT NULL,
    name character varying(100) NOT NULL,
    title character varying(100),
    email character varying(254),
    phone character varying(50),
    contact_type character varying(40) NOT NULL,
    may_request_work boolean NOT NULL,
    may_approve_hours boolean NOT NULL,
    active boolean NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: credit_memos; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.credit_memos (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    invoice_id uuid NOT NULL,
    number character varying(60) NOT NULL,
    actor_id uuid NOT NULL,
    issue_date date NOT NULL,
    currency character varying(3) NOT NULL,
    total numeric(14,2) NOT NULL,
    reason text NOT NULL,
    snapshot jsonb NOT NULL,
    filename character varying(180) NOT NULL,
    pdf_bytes bytea NOT NULL,
    sha256 character varying(64) NOT NULL,
    renderer_version character varying(40) NOT NULL,
    CONSTRAINT credit_memos_pdf_bytes_check CHECK ((octet_length(pdf_bytes) > 0)),
    CONSTRAINT credit_memos_reason_check CHECK (((length(btrim(reason)) >= 1) AND (length(btrim(reason)) <= 2000))),
    CONSTRAINT credit_memos_sha256_check CHECK (((sha256)::text ~ '^[0-9a-f]{64}$'::text)),
    CONSTRAINT credit_memos_total_check CHECK ((total >= (0)::numeric))
);


--
-- Name: email_auth_challenges; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.email_auth_challenges (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    session_digest character varying(64) NOT NULL,
    intent character varying(12) NOT NULL,
    offer character varying(20) NOT NULL,
    state character varying(12) NOT NULL,
    attempts integer NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT email_auth_challenges_attempts_check CHECK (((attempts >= 0) AND (attempts <= 6))),
    CONSTRAINT email_auth_challenges_intent_check CHECK (((intent)::text = ANY ((ARRAY['signin'::character varying, 'signup'::character varying, 'link'::character varying])::text[]))),
    CONSTRAINT email_auth_challenges_session_digest_check CHECK (((session_digest)::text ~ '^[0-9a-f]{64}$'::text)),
    CONSTRAINT email_auth_challenges_state_check CHECK (((state)::text = ANY ((ARRAY['reserved'::character varying, 'ready'::character varying, 'verifying'::character varying, 'consumed'::character varying, 'failed'::character varying])::text[])))
);


--
-- Name: integration_codes; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.integration_codes (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    grant_id uuid NOT NULL,
    digest character varying(64) NOT NULL,
    redirect_uri character varying(1000) NOT NULL,
    code_challenge character varying(128) NOT NULL,
    code_challenge_method character varying(10) NOT NULL,
    scope character varying(500) NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    used_at timestamp with time zone
);


--
-- Name: integration_grants; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.integration_grants (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    owner_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    client_id character varying(120) NOT NULL,
    label character varying(120) NOT NULL,
    scopes jsonb NOT NULL,
    resource character varying(300) NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    revoked_at timestamp with time zone
);


--
-- Name: integration_operations; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.integration_operations (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    grant_id uuid NOT NULL,
    key_digest character varying(64) NOT NULL,
    payload_digest character varying(64) NOT NULL,
    tool character varying(60) NOT NULL,
    result jsonb NOT NULL
);


--
-- Name: integration_tokens; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.integration_tokens (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    grant_id uuid NOT NULL,
    digest character varying(64) NOT NULL,
    kind character varying(10) NOT NULL,
    scope character varying(500) NOT NULL,
    client_id character varying(120) NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    used_at timestamp with time zone,
    CONSTRAINT integration_tokens_kind_check CHECK (((kind)::text = ANY ((ARRAY['access'::character varying, 'refresh'::character varying])::text[])))
);


--
-- Name: invoice_artifacts; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.invoice_artifacts (
    invoice_id uuid NOT NULL,
    filename character varying(150) NOT NULL,
    pdf_bytes bytea NOT NULL,
    sha256 character varying(64) NOT NULL,
    renderer_version character varying(40) NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: invoice_lines; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.invoice_lines (
    invoice_id uuid NOT NULL,
    project_id uuid NOT NULL,
    description character varying(200) NOT NULL,
    service_period character varying(40) NOT NULL,
    quantity_minutes integer NOT NULL,
    unit_rate numeric(14,2) NOT NULL,
    amount numeric(14,2) NOT NULL,
    sort_order integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    basis character varying(20) DEFAULT 'time'::character varying NOT NULL,
    charge_metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT invoice_line_basis_values CHECK ((((amount >= (0)::numeric) AND (amount <= 9999999999.99)) AND ((((basis)::text = 'time'::text) AND (quantity_minutes > 0) AND (unit_rate >= (0)::numeric)) OR (((basis)::text = ANY ((ARRAY['fixed_fee'::character varying, 'manual_extra'::character varying])::text[])) AND (quantity_minutes = 0) AND (unit_rate = (0)::numeric)))))
);


--
-- Name: invoice_time_entries; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.invoice_time_entries (
    entry_id uuid NOT NULL,
    invoice_id uuid NOT NULL
);


--
-- Name: invoices; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.invoices (
    client_id uuid NOT NULL,
    number character varying(60) NOT NULL,
    period_start date NOT NULL,
    period_end date NOT NULL,
    issue_date date,
    delivered_at date,
    due_date date,
    status character varying(20) NOT NULL,
    currency character varying(3) NOT NULL,
    subtotal numeric(14,2) NOT NULL,
    adjustments jsonb NOT NULL,
    total numeric(14,2) NOT NULL,
    snapshot jsonb,
    issued_at timestamp with time zone,
    voided_at timestamp with time zone,
    void_reason text,
    version integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    fixed_fee_project_id uuid,
    manual_extra_project_id uuid,
    manual_extra_reference character varying(200),
    object_id bigint NOT NULL,
    flexfields jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT invoice_extra_reference_pair CHECK ((((manual_extra_project_id IS NULL) AND (manual_extra_reference IS NULL)) OR ((manual_extra_project_id IS NOT NULL) AND (manual_extra_reference IS NOT NULL) AND (length(btrim((manual_extra_reference)::text)) > 0)))),
    CONSTRAINT invoice_single_charge_kind CHECK (((fixed_fee_project_id IS NULL) OR (manual_extra_project_id IS NULL))),
    CONSTRAINT invoices_check CHECK ((((status)::text <> ALL ((ARRAY['Issued'::character varying, 'Sent'::character varying])::text[])) OR ((snapshot IS NOT NULL) AND (issued_at IS NOT NULL)))),
    CONSTRAINT invoices_check1 CHECK ((period_end >= period_start)),
    CONSTRAINT invoices_check2 CHECK (((total >= (0)::numeric) AND (subtotal >= (0)::numeric))),
    CONSTRAINT invoices_flexfields_valid CHECK (((jsonb_typeof(flexfields) = 'object'::text) AND ((flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb) AND ((NOT (flexfields ? 'flexfield1'::text)) OR ((flexfields -> 'flexfield1'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield1'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield1'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield2'::text)) OR ((flexfields -> 'flexfield2'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield2'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield2'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield3'::text)) OR ((flexfields -> 'flexfield3'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield3'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield3'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield4'::text)) OR ((flexfields -> 'flexfield4'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield4'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield4'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield5'::text)) OR ((flexfields -> 'flexfield5'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield5'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield5'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield6'::text)) OR ((flexfields -> 'flexfield6'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield6'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield6'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield7'::text)) OR ((flexfields -> 'flexfield7'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield7'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))) AND ((NOT (flexfields ? 'flexfield8'::text)) OR ((flexfields -> 'flexfield8'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield8'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))))),
    CONSTRAINT invoices_status_check CHECK (((status)::text = ANY ((ARRAY['Draft'::character varying, 'Issued'::character varying, 'Sent'::character varying, 'Void'::character varying])::text[])))
);


--
-- Name: invoices_object_id_seq; Type: SEQUENCE; Schema: timeker_reference; Owner: -
--

ALTER TABLE timeker_reference.invoices ALTER COLUMN object_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME timeker_reference.invoices_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: library_document_versions; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.library_document_versions (
    document_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    number integer NOT NULL,
    snapshot jsonb NOT NULL,
    source_upload_id uuid,
    pdf_bytes bytea NOT NULL,
    pdf_size integer NOT NULL,
    pdf_sha256 character varying(64) NOT NULL,
    filename character varying(180) NOT NULL,
    renderer_version character varying(80) NOT NULL,
    published_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT library_document_versions_check CHECK ((((pdf_size >= 1) AND (pdf_size <= 5242880)) AND (octet_length(pdf_bytes) = pdf_size))),
    CONSTRAINT library_document_versions_number_check CHECK ((number > 0)),
    CONSTRAINT library_document_versions_pdf_sha256_check CHECK (((pdf_sha256)::text ~ '^[0-9a-f]{64}$'::text))
);


--
-- Name: library_documents; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.library_documents (
    owner_id uuid NOT NULL,
    title character varying(180) NOT NULL,
    kind character varying(16) NOT NULL,
    status character varying(12) NOT NULL,
    content text NOT NULL,
    is_template boolean NOT NULL,
    case_id uuid,
    client_id uuid,
    project_id uuid,
    source_template character varying(40),
    source_upload_id uuid,
    revision integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    object_id bigint NOT NULL,
    flexfields jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT library_documents_check CHECK (((is_template AND (case_id IS NULL) AND (client_id IS NULL) AND (project_id IS NULL)) OR ((NOT is_template) AND (case_id IS NOT NULL) AND (client_id IS NOT NULL) AND (project_id IS NOT NULL)))),
    CONSTRAINT library_documents_content_check CHECK ((length(content) <= 100000)),
    CONSTRAINT library_documents_flexfields_valid CHECK (((jsonb_typeof(flexfields) = 'object'::text) AND ((flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb) AND ((NOT (flexfields ? 'flexfield1'::text)) OR ((flexfields -> 'flexfield1'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield1'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield1'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield2'::text)) OR ((flexfields -> 'flexfield2'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield2'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield2'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield3'::text)) OR ((flexfields -> 'flexfield3'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield3'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield3'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield4'::text)) OR ((flexfields -> 'flexfield4'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield4'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield4'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield5'::text)) OR ((flexfields -> 'flexfield5'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield5'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield5'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield6'::text)) OR ((flexfields -> 'flexfield6'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield6'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield6'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield7'::text)) OR ((flexfields -> 'flexfield7'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield7'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))) AND ((NOT (flexfields ? 'flexfield8'::text)) OR ((flexfields -> 'flexfield8'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield8'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))))),
    CONSTRAINT library_documents_kind_check CHECK (((kind)::text = ANY ((ARRAY['msa'::character varying, 'sow'::character varying, 'sla'::character varying, 'custom'::character varying])::text[]))),
    CONSTRAINT library_documents_revision_check CHECK ((revision > 0)),
    CONSTRAINT library_documents_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'frozen'::character varying])::text[]))),
    CONSTRAINT library_documents_title_check CHECK (((length(btrim((title)::text)) >= 1) AND (length(btrim((title)::text)) <= 180)))
);


--
-- Name: library_documents_object_id_seq; Type: SEQUENCE; Schema: timeker_reference; Owner: -
--

ALTER TABLE timeker_reference.library_documents ALTER COLUMN object_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME timeker_reference.library_documents_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: library_uploads; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.library_uploads (
    document_id uuid NOT NULL,
    uploaded_by uuid NOT NULL,
    filename character varying(180) NOT NULL,
    content_type character varying(128) NOT NULL,
    size integer NOT NULL,
    sha256 character varying(64) NOT NULL,
    payload bytea NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT library_uploads_check CHECK ((((size >= 1) AND (size <= 5242880)) AND (octet_length(payload) = size))),
    CONSTRAINT library_uploads_filename_check CHECK (((length(btrim((filename)::text)) >= 1) AND (length(btrim((filename)::text)) <= 180))),
    CONSTRAINT library_uploads_sha256_check CHECK (((sha256)::text ~ '^[0-9a-f]{64}$'::text))
);


--
-- Name: mail_addresses; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.mail_addresses (
    owner_id uuid NOT NULL,
    client_id uuid NOT NULL,
    project_id uuid,
    case_id uuid,
    token_digest character varying(64) NOT NULL,
    revoked_at timestamp with time zone,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: mail_attachments; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.mail_attachments (
    message_id uuid NOT NULL,
    "position" integer NOT NULL,
    filename character varying(180) NOT NULL,
    declared_content_type character varying(128) NOT NULL,
    size integer NOT NULL,
    sha256 character varying(64) NOT NULL,
    payload bytea NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT mail_attachments_check CHECK ((((size >= 0) AND (size <= 5242880)) AND (octet_length(payload) = size))),
    CONSTRAINT mail_attachments_filename_check CHECK (((length(btrim((filename)::text)) >= 1) AND (length(btrim((filename)::text)) <= 180))),
    CONSTRAINT mail_attachments_position_check CHECK ((("position" >= 1) AND ("position" <= 100))),
    CONSTRAINT mail_attachments_sha256_check CHECK (((sha256)::text ~ '^[0-9a-f]{64}$'::text))
);


--
-- Name: mail_messages; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.mail_messages (
    owner_id uuid NOT NULL,
    client_id uuid NOT NULL,
    project_id uuid,
    case_id uuid,
    message_id character varying(998),
    sha256 character varying(64) NOT NULL,
    subject character varying(998) NOT NULL,
    sender character varying(2000) NOT NULL,
    recipients character varying(4000) NOT NULL,
    body text NOT NULL,
    message_at timestamp with time zone,
    received_at timestamp with time zone NOT NULL,
    archived_basis_at timestamp with time zone NOT NULL,
    archive_basis_source character varying(20) NOT NULL,
    archived_at timestamp with time zone,
    source character varying(10) NOT NULL,
    attachment_count integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT mail_messages_archive_basis_source_check CHECK (((archive_basis_source)::text = ANY ((ARRAY['receipt'::character varying, 'owner_import'::character varying])::text[]))),
    CONSTRAINT mail_messages_attachment_count_check CHECK (((attachment_count >= 0) AND (attachment_count <= 100))),
    CONSTRAINT mail_messages_source_check CHECK (((source)::text = ANY ((ARRAY['import'::character varying, 'capture'::character varying])::text[])))
);


--
-- Name: owner_identities; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.owner_identities (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    issuer character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    verified_email character varying(254) NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT owner_identities_subject_check CHECK (((length((subject)::text) >= 1) AND (length((subject)::text) <= 255)))
);


--
-- Name: owner_registrations; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.owner_registrations (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    terms_version character varying(60) NOT NULL,
    privacy_version character varying(60) NOT NULL,
    catalog_version character varying(60) NOT NULL,
    offer character varying(20) NOT NULL,
    accepted_at timestamp with time zone NOT NULL,
    CONSTRAINT owner_registrations_offer_check CHECK (((offer)::text = ANY ((ARRAY['free'::character varying, 'solo_monthly'::character varying, 'solo_annual'::character varying, 'pro_monthly'::character varying, 'pro_annual'::character varying])::text[])))
);


--
-- Name: payments; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.payments (
    invoice_id uuid NOT NULL,
    paid_at date NOT NULL,
    amount numeric(14,2) NOT NULL,
    currency character varying(3) NOT NULL,
    method character varying(40) NOT NULL,
    reference character varying(200),
    note text,
    created_by uuid NOT NULL,
    reversed_at timestamp with time zone,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT payments_amount_check CHECK ((amount > (0)::numeric))
);


--
-- Name: project_agreements; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.project_agreements (
    id uuid NOT NULL,
    project_id uuid NOT NULL,
    uploaded_by uuid NOT NULL,
    filename character varying(180) NOT NULL,
    size integer NOT NULL,
    sha256 character varying(64) NOT NULL,
    payload bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT project_agreements_check CHECK ((((size >= 1) AND (size <= 5242880)) AND (octet_length(payload) = size))),
    CONSTRAINT project_agreements_filename_check CHECK (((length(btrim((filename)::text)) >= 1) AND (length(btrim((filename)::text)) <= 180))),
    CONSTRAINT project_agreements_sha256_check CHECK (((sha256)::text ~ '^[0-9a-f]{64}$'::text))
);


--
-- Name: projects; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.projects (
    client_id uuid NOT NULL,
    code character varying(30) NOT NULL,
    name character varying(150) NOT NULL,
    description text,
    status character varying(20) DEFAULT 'draft'::character varying NOT NULL,
    billable boolean NOT NULL,
    rate_override numeric(14,2),
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    project_type character varying(40),
    budget_amount numeric(14,2),
    budget_currency character varying(3),
    agreement_type character varying(10),
    agreement_reference character varying(200),
    allow_overbilling boolean DEFAULT false NOT NULL,
    object_id bigint NOT NULL,
    flexfields jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT project_agreement_pair CHECK ((((agreement_type IS NULL) AND (agreement_reference IS NULL)) OR ((agreement_type IS NOT NULL) AND (agreement_reference IS NOT NULL) AND ((agreement_type)::text = ANY ((ARRAY['Contract'::character varying, 'SAL'::character varying, 'SOW'::character varying])::text[])) AND (length(btrim((agreement_reference)::text)) > 0)))),
    CONSTRAINT project_budget_pair CHECK ((((budget_amount IS NULL) AND (budget_currency IS NULL)) OR ((budget_amount IS NOT NULL) AND (budget_currency IS NOT NULL) AND ((budget_amount >= (0)::numeric) AND (budget_amount <= 9999999999.99)) AND ((budget_currency)::text ~ '^[A-Z]{3}$'::text)))),
    CONSTRAINT project_status_allowed CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'active'::character varying, 'closed'::character varying, 'archived'::character varying])::text[]))),
    CONSTRAINT project_type_allowed CHECK (((project_type IS NULL) OR ((project_type)::text = ANY ((ARRAY['time_and_materials'::character varying, 'fixed_fee'::character varying, 'on_call_support'::character varying, 'on_demand_support_tm'::character varying, 'on_demand_support_ff'::character varying])::text[])))),
    CONSTRAINT projects_flexfields_valid CHECK (((jsonb_typeof(flexfields) = 'object'::text) AND ((flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb) AND ((NOT (flexfields ? 'flexfield1'::text)) OR ((flexfields -> 'flexfield1'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield1'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield1'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield2'::text)) OR ((flexfields -> 'flexfield2'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield2'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield2'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield3'::text)) OR ((flexfields -> 'flexfield3'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield3'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield3'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield4'::text)) OR ((flexfields -> 'flexfield4'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield4'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield4'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield5'::text)) OR ((flexfields -> 'flexfield5'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield5'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield5'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield6'::text)) OR ((flexfields -> 'flexfield6'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield6'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield6'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield7'::text)) OR ((flexfields -> 'flexfield7'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield7'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))) AND ((NOT (flexfields ? 'flexfield8'::text)) OR ((flexfields -> 'flexfield8'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield8'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))))),
    CONSTRAINT projects_rate_override_check CHECK (((rate_override IS NULL) OR (rate_override >= (0)::numeric)))
);


--
-- Name: projects_object_id_seq; Type: SEQUENCE; Schema: timeker_reference; Owner: -
--

ALTER TABLE timeker_reference.projects ALTER COLUMN object_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME timeker_reference.projects_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: proposal_sending_attempts; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.proposal_sending_attempts (
    delivery_id uuid NOT NULL,
    number integer NOT NULL,
    state character varying(12) NOT NULL,
    code character varying(40) NOT NULL,
    completed_at timestamp with time zone,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT proposal_sending_attempts_number_check CHECK (((number >= 1) AND (number <= 4))),
    CONSTRAINT proposal_sending_attempts_state_check CHECK (((state)::text = ANY ((ARRAY['sent'::character varying, 'failed'::character varying, 'uncertain'::character varying])::text[])))
);


--
-- Name: proposal_sending_deliveries; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.proposal_sending_deliveries (
    owner_id uuid NOT NULL,
    case_id uuid NOT NULL,
    quote_artifact_id uuid,
    library_version_id uuid,
    artifact_revision_id uuid NOT NULL,
    revision_number integer NOT NULL,
    document_kind character varying(12) NOT NULL,
    attachment_filename character varying(180) NOT NULL,
    attachment_content_type character varying(100) NOT NULL,
    attachment_bytes bytea NOT NULL,
    attachment_sha256 character varying(64) NOT NULL,
    recipient character varying(254) NOT NULL,
    subject character varying(200) NOT NULL,
    body text NOT NULL,
    operation_key uuid NOT NULL,
    version integer NOT NULL,
    state character varying(12) NOT NULL,
    attempt_count integer NOT NULL,
    last_code character varying(40),
    confirmed_at timestamp with time zone,
    sent_at timestamp with time zone,
    stopped_at timestamp with time zone,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT proposal_sending_deliveries_attachment_bytes_check CHECK (((octet_length(attachment_bytes) >= 1) AND (octet_length(attachment_bytes) <= 5242880))),
    CONSTRAINT proposal_sending_deliveries_attachment_sha256_check CHECK (((attachment_sha256)::text ~ '^[0-9a-f]{64}$'::text)),
    CONSTRAINT proposal_sending_deliveries_body_check CHECK (((char_length(body) >= 1) AND (char_length(body) <= 12000))),
    CONSTRAINT proposal_sending_deliveries_check CHECK (((quote_artifact_id IS NOT NULL) <> (library_version_id IS NOT NULL))),
    CONSTRAINT proposal_sending_deliveries_check1 CHECK (((revision_number >= 1) AND (version >= 1) AND ((attempt_count >= 0) AND (attempt_count <= 4)))),
    CONSTRAINT proposal_sending_deliveries_document_kind_check CHECK (((document_kind)::text = ANY ((ARRAY['hle'::character varying, 'msa'::character varying, 'sow'::character varying, 'sla'::character varying, 'custom'::character varying])::text[]))),
    CONSTRAINT proposal_sending_deliveries_state_check CHECK (((state)::text = ANY ((ARRAY['draft'::character varying, 'sent'::character varying, 'failed'::character varying, 'uncertain'::character varying, 'stopped'::character varying])::text[])))
);


--
-- Name: public_email_challenges; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.public_email_challenges (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    destination text NOT NULL,
    address_digest character varying(64) NOT NULL,
    session_digest character varying(64) NOT NULL,
    network_digest character varying(64) NOT NULL,
    intent character varying(12) NOT NULL,
    offer character varying(20) NOT NULL,
    return_to character varying(30) NOT NULL,
    state character varying(12) NOT NULL,
    attempts integer NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT public_email_challenges_attempts_check CHECK (((attempts >= 0) AND (attempts <= 6))),
    CONSTRAINT public_email_challenges_check CHECK ((((address_digest)::text ~ '^[0-9a-f]{64}$'::text) AND ((session_digest)::text ~ '^[0-9a-f]{64}$'::text) AND ((network_digest)::text ~ '^[0-9a-f]{64}$'::text))),
    CONSTRAINT public_email_challenges_intent_check CHECK (((intent)::text = ANY ((ARRAY['signin'::character varying, 'signup'::character varying])::text[]))),
    CONSTRAINT public_email_challenges_return_to_check CHECK (((return_to)::text = ANY ((ARRAY[''::character varying, '/settings/security'::character varying])::text[]))),
    CONSTRAINT public_email_challenges_state_check CHECK (((state)::text = ANY ((ARRAY['reserved'::character varying, 'ready'::character varying, 'uncertain'::character varying, 'verifying'::character varying, 'consumed'::character varying, 'failed'::character varying])::text[])))
);


--
-- Name: quote_artifacts; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.quote_artifacts (
    revision_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    snapshot jsonb NOT NULL,
    filename character varying(180) NOT NULL,
    pdf_bytes bytea NOT NULL,
    size integer NOT NULL,
    sha256 character varying(64) NOT NULL,
    renderer_version character varying(80) NOT NULL,
    published_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT quote_artifacts_check CHECK ((((size >= 1) AND (size <= 5242880)) AND (octet_length(pdf_bytes) = size))),
    CONSTRAINT quote_artifacts_check1 CHECK ((((sha256)::text ~ '^[0-9a-f]{64}$'::text) AND (jsonb_typeof(snapshot) = 'object'::text))),
    CONSTRAINT quote_artifacts_filename_check CHECK (((length(btrim((filename)::text)) >= 1) AND (length(btrim((filename)::text)) <= 180)))
);


--
-- Name: quote_lines; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.quote_lines (
    revision_id uuid NOT NULL,
    "position" integer NOT NULL,
    label character varying(500) NOT NULL,
    scope_type character varying(12) NOT NULL,
    min_minutes integer NOT NULL,
    max_minutes integer NOT NULL,
    pricing_model character varying(30),
    unit_rate numeric(14,2),
    fixed_amount numeric(14,2),
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT quote_lines_check CHECK (((("position" >= 0) AND ("position" <= 99)) AND ((length(btrim((label)::text)) >= 1) AND (length(btrim((label)::text)) <= 500)))),
    CONSTRAINT quote_lines_check1 CHECK ((((min_minutes >= 0) AND (min_minutes <= 5256000)) AND ((max_minutes >= min_minutes) AND (max_minutes <= 5256000)))),
    CONSTRAINT quote_lines_check2 CHECK ((((pricing_model IS NULL) AND (unit_rate IS NULL) AND (fixed_amount IS NULL)) OR ((pricing_model IS NOT NULL) AND ((pricing_model)::text = 'time_and_materials'::text) AND ((unit_rate >= (0)::numeric) AND (unit_rate <= 9999999999.99)) AND (unit_rate IS NOT NULL) AND (fixed_amount IS NULL)) OR ((pricing_model IS NOT NULL) AND ((pricing_model)::text = 'fixed_fee'::text) AND ((fixed_amount >= (0)::numeric) AND (fixed_amount <= 9999999999.99)) AND (fixed_amount IS NOT NULL) AND (unit_rate IS NULL)))),
    CONSTRAINT quote_lines_scope_type_check CHECK (((scope_type)::text = ANY ((ARRAY['task'::character varying, 'case'::character varying, 'project'::character varying])::text[])))
);


--
-- Name: quote_revisions; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.quote_revisions (
    quote_id uuid NOT NULL,
    parent_revision_id uuid,
    number integer NOT NULL,
    status character varying(12) NOT NULL,
    title character varying(200) NOT NULL,
    prepared_for character varying(200),
    case_id uuid NOT NULL,
    client_id uuid NOT NULL,
    project_id uuid NOT NULL,
    preset character varying(30) NOT NULL,
    currency character varying(3),
    assumptions text,
    exclusions text,
    valid_until date,
    version integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    flexfields jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT quote_revisions_assumptions_check CHECK (((assumptions IS NULL) OR (length(assumptions) <= 20000))),
    CONSTRAINT quote_revisions_check CHECK ((((number >= 1) AND (number <= 100)) AND (version > 0))),
    CONSTRAINT quote_revisions_currency_check CHECK (((currency IS NULL) OR ((currency)::text ~ '^[A-Z]{3}$'::text))),
    CONSTRAINT quote_revisions_exclusions_check CHECK (((exclusions IS NULL) OR (length(exclusions) <= 20000))),
    CONSTRAINT quote_revisions_flexfields_valid CHECK (((jsonb_typeof(flexfields) = 'object'::text) AND ((flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb) AND ((NOT (flexfields ? 'flexfield1'::text)) OR ((flexfields -> 'flexfield1'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield1'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield1'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield2'::text)) OR ((flexfields -> 'flexfield2'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield2'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield2'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield3'::text)) OR ((flexfields -> 'flexfield3'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield3'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield3'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield4'::text)) OR ((flexfields -> 'flexfield4'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield4'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield4'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield5'::text)) OR ((flexfields -> 'flexfield5'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield5'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield5'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield6'::text)) OR ((flexfields -> 'flexfield6'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield6'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield6'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield7'::text)) OR ((flexfields -> 'flexfield7'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield7'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))) AND ((NOT (flexfields ? 'flexfield8'::text)) OR ((flexfields -> 'flexfield8'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield8'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))))),
    CONSTRAINT quote_revisions_prepared_for_check CHECK (((prepared_for IS NULL) OR (length((prepared_for)::text) <= 200))),
    CONSTRAINT quote_revisions_preset_check CHECK (((preset)::text = ANY ((ARRAY['quick_effort'::character varying, 'time_and_materials'::character varying, 'fixed_fee'::character varying])::text[]))),
    CONSTRAINT quote_revisions_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'published'::character varying])::text[]))),
    CONSTRAINT quote_revisions_title_check CHECK (((length(btrim((title)::text)) >= 1) AND (length(btrim((title)::text)) <= 200)))
);


--
-- Name: quotes; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.quotes (
    owner_id uuid NOT NULL,
    number bigint NOT NULL,
    operation_key uuid NOT NULL,
    create_digest character varying(64) NOT NULL,
    archived_at timestamp with time zone,
    version integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT quotes_check CHECK (((number > 0) AND (version > 0) AND ((create_digest)::text ~ '^[0-9a-f]{64}$'::text)))
);


--
-- Name: quotes_number_seq; Type: SEQUENCE; Schema: timeker_reference; Owner: -
--

ALTER TABLE timeker_reference.quotes ALTER COLUMN number ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME timeker_reference.quotes_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sending_attempts; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.sending_attempts (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    delivery_id uuid NOT NULL,
    number integer NOT NULL,
    state character varying(12) NOT NULL,
    code character varying(40) NOT NULL,
    provider_reference character varying(200),
    completed_at timestamp with time zone,
    CONSTRAINT sending_attempts_number_check CHECK (((number >= 1) AND (number <= 4))),
    CONSTRAINT sending_attempts_state_check CHECK (((state)::text = ANY ((ARRAY['sent'::character varying, 'failed'::character varying, 'stopped'::character varying, 'uncertain'::character varying])::text[])))
);


--
-- Name: sending_deliveries; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.sending_deliveries (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    owner_id uuid NOT NULL,
    plan_id uuid NOT NULL,
    sequence integer NOT NULL,
    state character varying(12) NOT NULL,
    scheduled_at timestamp with time zone NOT NULL,
    sent_at timestamp with time zone,
    failure_code character varying(40),
    attempt_count integer NOT NULL,
    CONSTRAINT sending_deliveries_check CHECK ((((sequence >= 0) AND (sequence <= 6)) AND ((attempt_count >= 0) AND (attempt_count <= 4)))),
    CONSTRAINT sending_deliveries_state_check CHECK (((state)::text = ANY ((ARRAY['pending'::character varying, 'sent'::character varying, 'failed'::character varying, 'stopped'::character varying, 'uncertain'::character varying])::text[])))
);


--
-- Name: sending_plans; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.sending_plans (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    owner_id uuid NOT NULL,
    invoice_id uuid NOT NULL,
    artifact_id uuid NOT NULL,
    artifact_sha256 character varying(64) NOT NULL,
    recipient character varying(254) NOT NULL,
    subject character varying(200) NOT NULL,
    body text NOT NULL,
    followup_subject character varying(200) NOT NULL,
    followup_body text NOT NULL,
    followup_interval_days integer NOT NULL,
    followup_max integer NOT NULL,
    stopped_at timestamp with time zone,
    stop_reason character varying(30),
    CONSTRAINT sending_plans_artifact_sha256_check CHECK (((artifact_sha256)::text ~ '^[0-9a-f]{64}$'::text)),
    CONSTRAINT sending_plans_check CHECK ((((followup_max = 0) AND (followup_interval_days = 0)) OR ((followup_max > 0) AND ((followup_interval_days >= 1) AND (followup_interval_days <= 90))))),
    CONSTRAINT sending_plans_followup_max_check CHECK (((followup_max >= 0) AND (followup_max <= 6)))
);


--
-- Name: sending_preferences; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.sending_preferences (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    owner_id uuid NOT NULL,
    paused boolean NOT NULL,
    initial_subject character varying(200) NOT NULL,
    initial_body text NOT NULL,
    followup_subject character varying(200) NOT NULL,
    followup_body text NOT NULL
);


--
-- Name: subscription_billing_accounts; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.subscription_billing_accounts (
    id integer NOT NULL,
    current boolean NOT NULL,
    owner_id uuid NOT NULL,
    customer_id character varying(30) NOT NULL,
    subscription_id character varying(30) NOT NULL,
    checkout_id uuid NOT NULL,
    provider_status character varying(12) NOT NULL,
    provider_offer character varying(20) NOT NULL,
    entitlement_offer character varying(20) NOT NULL,
    paid_through timestamp with time zone NOT NULL,
    proven_period_start timestamp with time zone NOT NULL,
    past_due_since timestamp with time zone,
    failed_period_start timestamp with time zone,
    failed_transaction_id character varying(30),
    provider_updated_at timestamp with time zone NOT NULL,
    pending_offer character varying(20),
    pending_effective_at timestamp with time zone,
    pending_selection jsonb,
    requires_selection boolean NOT NULL,
    version integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT subscription_billing_accounts_check CHECK (((id > 0) AND (version > 0))),
    CONSTRAINT subscription_billing_accounts_check1 CHECK ((paid_through > proven_period_start)),
    CONSTRAINT subscription_billing_accounts_check2 CHECK ((((customer_id)::text ~ '^ctm_[a-z0-9]{26}$'::text) AND ((subscription_id)::text ~ '^sub_[a-z0-9]{26}$'::text))),
    CONSTRAINT subscription_billing_accounts_provider_status_check CHECK (((provider_status)::text = ANY ((ARRAY['active'::character varying, 'canceled'::character varying, 'past_due'::character varying, 'paused'::character varying, 'trialing'::character varying])::text[])))
);


--
-- Name: subscription_billing_accounts_id_seq; Type: SEQUENCE; Schema: timeker_reference; Owner: -
--

ALTER TABLE timeker_reference.subscription_billing_accounts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME timeker_reference.subscription_billing_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: subscription_billing_events; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.subscription_billing_events (
    id uuid NOT NULL,
    provider_event_id character varying(30) NOT NULL,
    raw_digest character varying(64) NOT NULL,
    event_type character varying(80) NOT NULL,
    outcome character varying(24) NOT NULL,
    facts jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT subscription_billing_events_check CHECK ((((provider_event_id)::text ~ '^evt_[a-z0-9]{26}$'::text) AND ((raw_digest)::text ~ '^[0-9a-f]{64}$'::text))),
    CONSTRAINT subscription_billing_events_facts_check CHECK ((jsonb_typeof(facts) = 'object'::text))
);


--
-- Name: subscription_billing_operations; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.subscription_billing_operations (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    key_digest character varying(64) NOT NULL,
    payload_digest character varying(64) NOT NULL,
    action character varying(30) NOT NULL,
    state character varying(12) NOT NULL,
    intent jsonb NOT NULL,
    transaction_id character varying(30),
    result jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT subscription_billing_operations_check CHECK ((((key_digest)::text ~ '^[0-9a-f]{64}$'::text) AND ((payload_digest)::text ~ '^[0-9a-f]{64}$'::text))),
    CONSTRAINT subscription_billing_operations_check1 CHECK (((jsonb_typeof(intent) = 'object'::text) AND (jsonb_typeof(result) = 'object'::text))),
    CONSTRAINT subscription_billing_operations_state_check CHECK (((state)::text = ANY ((ARRAY['reserved'::character varying, 'confirmed'::character varying, 'uncertain'::character varying, 'failed'::character varying])::text[])))
);


--
-- Name: subscription_operations; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.subscription_operations (
    id uuid NOT NULL,
    owner_id uuid NOT NULL,
    key_digest character varying(64) NOT NULL,
    payload_digest character varying(64) NOT NULL,
    action character varying(80) NOT NULL,
    result jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT subscription_operations_check CHECK ((((key_digest)::text ~ '^[0-9a-f]{64}$'::text) AND ((payload_digest)::text ~ '^[0-9a-f]{64}$'::text))),
    CONSTRAINT subscription_operations_check1 CHECK ((((length((action)::text) >= 1) AND (length((action)::text) <= 80)) AND (jsonb_typeof(result) = 'object'::text)))
);


--
-- Name: time_contributions; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.time_contributions (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    actor_id uuid NOT NULL,
    source character varying(100) NOT NULL,
    source_item_id character varying(128) NOT NULL,
    import_record_id uuid,
    timecard_id uuid NOT NULL,
    project_id uuid NOT NULL,
    work_date date NOT NULL,
    entry_id uuid,
    case_id uuid,
    minutes integer NOT NULL,
    description text NOT NULL,
    version integer NOT NULL,
    CONSTRAINT time_contributions_check CHECK (((minutes = 0) OR (entry_id IS NOT NULL))),
    CONSTRAINT time_contributions_description_check CHECK ((char_length(description) <= 2000)),
    CONSTRAINT time_contributions_minutes_check CHECK (((minutes >= 0) AND (minutes <= 1440)))
);


--
-- Name: time_entries; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.time_entries (
    timecard_id uuid NOT NULL,
    project_id uuid,
    work_date date NOT NULL,
    minutes integer NOT NULL,
    category character varying(40) NOT NULL,
    description text,
    billable boolean NOT NULL,
    rate_override numeric(14,2),
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT time_entries_minutes_check CHECK (((minutes >= 1) AND (minutes <= 1440)))
);


--
-- Name: time_import_records; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.time_import_records (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    actor_id uuid NOT NULL,
    source character varying(100) NOT NULL,
    source_record_id character varying(128) NOT NULL,
    batch_id character varying(128) NOT NULL,
    payload_hash character varying(64) NOT NULL,
    CONSTRAINT time_import_records_payload_hash_check CHECK (((payload_hash)::text ~ '^[0-9a-f]{64}$'::text))
);


--
-- Name: time_operations; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.time_operations (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    actor_id uuid NOT NULL,
    source character varying(100) NOT NULL,
    idempotency_key character varying(128) NOT NULL,
    payload_hash character varying(64) NOT NULL,
    operation character varying(20) NOT NULL,
    result jsonb NOT NULL,
    CONSTRAINT time_operations_operation_check CHECK (((operation)::text = ANY ((ARRAY['create'::character varying, 'edit'::character varying, 'delete'::character varying, 'import'::character varying])::text[]))),
    CONSTRAINT time_operations_payload_hash_check CHECK (((payload_hash)::text ~ '^[0-9a-f]{64}$'::text))
);


--
-- Name: timecards; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.timecards (
    owner_id uuid NOT NULL,
    client_id uuid,
    week_start date NOT NULL,
    status character varying(20) NOT NULL,
    total_minutes integer NOT NULL,
    finalized_at timestamp with time zone,
    cap_override_reason text,
    cap_override_reference character varying(200),
    version integer NOT NULL,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    archived_at timestamp with time zone,
    object_id bigint NOT NULL,
    flexfields jsonb DEFAULT '{}'::jsonb NOT NULL,
    is_internal boolean DEFAULT false NOT NULL,
    internal_case_id uuid,
    CONSTRAINT timecard_internal_scope CHECK ((is_internal OR ((client_id IS NOT NULL) AND (internal_case_id IS NULL)))),
    CONSTRAINT timecards_flexfields_valid CHECK (((jsonb_typeof(flexfields) = 'object'::text) AND ((flexfields - ARRAY['flexfield1'::text, 'flexfield2'::text, 'flexfield3'::text, 'flexfield4'::text, 'flexfield5'::text, 'flexfield6'::text, 'flexfield7'::text, 'flexfield8'::text]) = '{}'::jsonb) AND ((NOT (flexfields ? 'flexfield1'::text)) OR ((flexfields -> 'flexfield1'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield1'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield1'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield2'::text)) OR ((flexfields -> 'flexfield2'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield2'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield2'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield3'::text)) OR ((flexfields -> 'flexfield3'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield3'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield3'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield4'::text)) OR ((flexfields -> 'flexfield4'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield4'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield4'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield5'::text)) OR ((flexfields -> 'flexfield5'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield5'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield5'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield6'::text)) OR ((flexfields -> 'flexfield6'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield6'::text)) = 'string'::text) AND (char_length((flexfields ->> 'flexfield6'::text)) <= 250))) AND ((NOT (flexfields ? 'flexfield7'::text)) OR ((flexfields -> 'flexfield7'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield7'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield7'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))) AND ((NOT (flexfields ? 'flexfield8'::text)) OR ((flexfields -> 'flexfield8'::text) = 'null'::jsonb) OR ((jsonb_typeof((flexfields -> 'flexfield8'::text)) = 'string'::text) AND ((flexfields ->> 'flexfield8'::text) ~ '^-?[0-9]{1,14}([.][0-9]{1,5})?$'::text))))),
    CONSTRAINT timecards_status_check CHECK (((status)::text = ANY ((ARRAY['Draft'::character varying, 'Finalized'::character varying, 'Invoiced'::character varying, 'Voided'::character varying])::text[]))),
    CONSTRAINT timecards_total_minutes_check CHECK (((total_minutes >= 0) AND (total_minutes <= 10080))),
    CONSTRAINT timecards_week_start_check CHECK ((EXTRACT(isodow FROM week_start) = (1)::numeric))
);


--
-- Name: timecards_object_id_seq; Type: SEQUENCE; Schema: timeker_reference; Owner: -
--

ALTER TABLE timeker_reference.timecards ALTER COLUMN object_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME timeker_reference.timecards_object_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.users (
    email character varying(254) NOT NULL,
    display_name character varying(100) NOT NULL,
    role character varying(20) NOT NULL,
    active boolean NOT NULL,
    last_login_at timestamp with time zone,
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    session_revision integer NOT NULL
);


--
-- Name: workspace_admissions; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.workspace_admissions (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    slot_id uuid NOT NULL,
    owner_id uuid NOT NULL,
    email character varying(254) NOT NULL,
    issuer character varying(255) NOT NULL,
    subject character varying(255) NOT NULL,
    state character varying(12) NOT NULL,
    CONSTRAINT workspace_admissions_state_check CHECK (((state)::text = ANY ((ARRAY['reserved'::character varying, 'active'::character varying, 'blocked'::character varying])::text[])))
);


--
-- Name: workspace_subscriptions; Type: TABLE; Schema: timeker_reference; Owner: -
--

CREATE TABLE timeker_reference.workspace_subscriptions (
    id integer NOT NULL,
    owner_id uuid NOT NULL,
    plan_code character varying(12) NOT NULL,
    catalog_revision character varying(60) NOT NULL,
    version integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    access_expires_at timestamp with time zone,
    CONSTRAINT workspace_subscriptions_check CHECK (((version > 0) AND ((length((catalog_revision)::text) >= 1) AND (length((catalog_revision)::text) <= 60)))),
    CONSTRAINT workspace_subscriptions_id_check CHECK ((id = 1)),
    CONSTRAINT workspace_subscriptions_plan_code_check CHECK (((plan_code)::text = ANY ((ARRAY['free'::character varying, 'solo'::character varying, 'pro'::character varying])::text[])))
);


--
-- Name: admission_identities admission_identities_issuer_subject_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.admission_identities
    ADD CONSTRAINT admission_identities_issuer_subject_key UNIQUE (issuer, subject);


--
-- Name: admission_identities admission_identities_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.admission_identities
    ADD CONSTRAINT admission_identities_pkey PRIMARY KEY (id);


--
-- Name: admission_identities admission_identities_tenant_id_identity_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.admission_identities
    ADD CONSTRAINT admission_identities_tenant_id_identity_id_key UNIQUE (tenant_id, identity_id);


--
-- Name: admission_identities admission_identities_tenant_id_owner_id_issuer_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.admission_identities
    ADD CONSTRAINT admission_identities_tenant_id_owner_id_issuer_key UNIQUE (tenant_id, owner_id, issuer);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: app_settings app_settings_key_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.app_settings
    ADD CONSTRAINT app_settings_key_key UNIQUE (key);


--
-- Name: app_settings app_settings_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.app_settings
    ADD CONSTRAINT app_settings_pkey PRIMARY KEY (id);


--
-- Name: audit_events audit_events_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.audit_events
    ADD CONSTRAINT audit_events_pkey PRIMARY KEY (id);


--
-- Name: case_time_allocations case_time_allocations_entry_id_case_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.case_time_allocations
    ADD CONSTRAINT case_time_allocations_entry_id_case_id_key UNIQUE (entry_id, case_id);


--
-- Name: case_time_allocations case_time_allocations_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.case_time_allocations
    ADD CONSTRAINT case_time_allocations_pkey PRIMARY KEY (id);


--
-- Name: cases cases_number_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.cases
    ADD CONSTRAINT cases_number_key UNIQUE (number);


--
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: client_drafts client_drafts_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.client_drafts
    ADD CONSTRAINT client_drafts_pkey PRIMARY KEY (id);


--
-- Name: client_source_references client_source_references_client_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.client_source_references
    ADD CONSTRAINT client_source_references_client_id_key UNIQUE (client_id);


--
-- Name: client_source_references client_source_references_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.client_source_references
    ADD CONSTRAINT client_source_references_pkey PRIMARY KEY (id);


--
-- Name: clients clients_code_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.clients
    ADD CONSTRAINT clients_code_key UNIQUE (code);


--
-- Name: clients clients_object_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.clients
    ADD CONSTRAINT clients_object_id_key UNIQUE (object_id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contact_attempts contact_attempts_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.contact_attempts
    ADD CONSTRAINT contact_attempts_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: credit_memos credit_memos_invoice_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.credit_memos
    ADD CONSTRAINT credit_memos_invoice_id_key UNIQUE (invoice_id);


--
-- Name: credit_memos credit_memos_number_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.credit_memos
    ADD CONSTRAINT credit_memos_number_key UNIQUE (number);


--
-- Name: credit_memos credit_memos_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.credit_memos
    ADD CONSTRAINT credit_memos_pkey PRIMARY KEY (id);


--
-- Name: email_auth_challenges email_auth_challenges_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.email_auth_challenges
    ADD CONSTRAINT email_auth_challenges_pkey PRIMARY KEY (id);


--
-- Name: integration_codes integration_codes_digest_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_codes
    ADD CONSTRAINT integration_codes_digest_key UNIQUE (digest);


--
-- Name: integration_codes integration_codes_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_codes
    ADD CONSTRAINT integration_codes_pkey PRIMARY KEY (id);


--
-- Name: integration_grants integration_grants_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_grants
    ADD CONSTRAINT integration_grants_pkey PRIMARY KEY (id);


--
-- Name: integration_operations integration_operations_grant_id_key_digest_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_operations
    ADD CONSTRAINT integration_operations_grant_id_key_digest_key UNIQUE (grant_id, key_digest);


--
-- Name: integration_operations integration_operations_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_operations
    ADD CONSTRAINT integration_operations_pkey PRIMARY KEY (id);


--
-- Name: integration_tokens integration_tokens_digest_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_tokens
    ADD CONSTRAINT integration_tokens_digest_key UNIQUE (digest);


--
-- Name: integration_tokens integration_tokens_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_tokens
    ADD CONSTRAINT integration_tokens_pkey PRIMARY KEY (id);


--
-- Name: invoice_artifacts invoice_artifacts_invoice_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_artifacts
    ADD CONSTRAINT invoice_artifacts_invoice_id_key UNIQUE (invoice_id);


--
-- Name: invoice_artifacts invoice_artifacts_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_artifacts
    ADD CONSTRAINT invoice_artifacts_pkey PRIMARY KEY (id);


--
-- Name: invoice_lines invoice_lines_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_lines
    ADD CONSTRAINT invoice_lines_pkey PRIMARY KEY (id);


--
-- Name: invoice_time_entries invoice_time_entries_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_time_entries
    ADD CONSTRAINT invoice_time_entries_pkey PRIMARY KEY (entry_id);


--
-- Name: invoices invoices_number_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoices
    ADD CONSTRAINT invoices_number_key UNIQUE (number);


--
-- Name: invoices invoices_object_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoices
    ADD CONSTRAINT invoices_object_id_key UNIQUE (object_id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: library_document_versions library_document_versions_document_id_number_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_document_versions
    ADD CONSTRAINT library_document_versions_document_id_number_key UNIQUE (document_id, number);


--
-- Name: library_document_versions library_document_versions_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_document_versions
    ADD CONSTRAINT library_document_versions_pkey PRIMARY KEY (id);


--
-- Name: library_documents library_documents_object_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_documents
    ADD CONSTRAINT library_documents_object_id_key UNIQUE (object_id);


--
-- Name: library_documents library_documents_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_documents
    ADD CONSTRAINT library_documents_pkey PRIMARY KEY (id);


--
-- Name: library_uploads library_uploads_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_uploads
    ADD CONSTRAINT library_uploads_pkey PRIMARY KEY (id);


--
-- Name: mail_addresses mail_addresses_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_addresses
    ADD CONSTRAINT mail_addresses_pkey PRIMARY KEY (id);


--
-- Name: mail_addresses mail_addresses_token_digest_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_addresses
    ADD CONSTRAINT mail_addresses_token_digest_key UNIQUE (token_digest);


--
-- Name: mail_attachments mail_attachments_message_id_position_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_attachments
    ADD CONSTRAINT mail_attachments_message_id_position_key UNIQUE (message_id, "position");


--
-- Name: mail_attachments mail_attachments_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_attachments
    ADD CONSTRAINT mail_attachments_pkey PRIMARY KEY (id);


--
-- Name: mail_messages mail_messages_owner_id_sha256_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_messages
    ADD CONSTRAINT mail_messages_owner_id_sha256_key UNIQUE (owner_id, sha256);


--
-- Name: mail_messages mail_messages_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_messages
    ADD CONSTRAINT mail_messages_pkey PRIMARY KEY (id);


--
-- Name: owner_identities owner_identities_issuer_subject_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.owner_identities
    ADD CONSTRAINT owner_identities_issuer_subject_key UNIQUE (issuer, subject);


--
-- Name: owner_identities owner_identities_owner_id_issuer_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.owner_identities
    ADD CONSTRAINT owner_identities_owner_id_issuer_key UNIQUE (owner_id, issuer);


--
-- Name: owner_identities owner_identities_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.owner_identities
    ADD CONSTRAINT owner_identities_pkey PRIMARY KEY (id);


--
-- Name: owner_registrations owner_registrations_owner_id_terms_version_privacy_version__key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.owner_registrations
    ADD CONSTRAINT owner_registrations_owner_id_terms_version_privacy_version__key UNIQUE (owner_id, terms_version, privacy_version, catalog_version);


--
-- Name: owner_registrations owner_registrations_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.owner_registrations
    ADD CONSTRAINT owner_registrations_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: project_agreements project_agreements_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.project_agreements
    ADD CONSTRAINT project_agreements_pkey PRIMARY KEY (id);


--
-- Name: project_agreements project_agreements_project_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.project_agreements
    ADD CONSTRAINT project_agreements_project_id_key UNIQUE (project_id);


--
-- Name: projects projects_client_id_code_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.projects
    ADD CONSTRAINT projects_client_id_code_key UNIQUE (client_id, code);


--
-- Name: projects projects_object_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.projects
    ADD CONSTRAINT projects_object_id_key UNIQUE (object_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: proposal_sending_attempts proposal_sending_attempts_delivery_id_number_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_attempts
    ADD CONSTRAINT proposal_sending_attempts_delivery_id_number_key UNIQUE (delivery_id, number);


--
-- Name: proposal_sending_attempts proposal_sending_attempts_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_attempts
    ADD CONSTRAINT proposal_sending_attempts_pkey PRIMARY KEY (id);


--
-- Name: proposal_sending_deliveries proposal_sending_deliveries_owner_id_operation_key_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_deliveries
    ADD CONSTRAINT proposal_sending_deliveries_owner_id_operation_key_key UNIQUE (owner_id, operation_key);


--
-- Name: proposal_sending_deliveries proposal_sending_deliveries_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_deliveries
    ADD CONSTRAINT proposal_sending_deliveries_pkey PRIMARY KEY (id);


--
-- Name: public_email_challenges public_email_challenges_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.public_email_challenges
    ADD CONSTRAINT public_email_challenges_pkey PRIMARY KEY (id);


--
-- Name: quote_artifacts quote_artifacts_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_artifacts
    ADD CONSTRAINT quote_artifacts_pkey PRIMARY KEY (id);


--
-- Name: quote_artifacts quote_artifacts_revision_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_artifacts
    ADD CONSTRAINT quote_artifacts_revision_id_key UNIQUE (revision_id);


--
-- Name: quote_lines quote_lines_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_lines
    ADD CONSTRAINT quote_lines_pkey PRIMARY KEY (id);


--
-- Name: quote_lines quote_lines_revision_id_position_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_lines
    ADD CONSTRAINT quote_lines_revision_id_position_key UNIQUE (revision_id, "position");


--
-- Name: quote_revisions quote_revisions_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_revisions
    ADD CONSTRAINT quote_revisions_pkey PRIMARY KEY (id);


--
-- Name: quote_revisions quote_revisions_quote_id_number_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_revisions
    ADD CONSTRAINT quote_revisions_quote_id_number_key UNIQUE (quote_id, number);


--
-- Name: quotes quotes_number_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quotes
    ADD CONSTRAINT quotes_number_key UNIQUE (number);


--
-- Name: quotes quotes_owner_id_operation_key_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quotes
    ADD CONSTRAINT quotes_owner_id_operation_key_key UNIQUE (owner_id, operation_key);


--
-- Name: quotes quotes_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quotes
    ADD CONSTRAINT quotes_pkey PRIMARY KEY (id);


--
-- Name: sending_attempts sending_attempts_delivery_id_number_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_attempts
    ADD CONSTRAINT sending_attempts_delivery_id_number_key UNIQUE (delivery_id, number);


--
-- Name: sending_attempts sending_attempts_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_attempts
    ADD CONSTRAINT sending_attempts_pkey PRIMARY KEY (id);


--
-- Name: sending_deliveries sending_deliveries_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_deliveries
    ADD CONSTRAINT sending_deliveries_pkey PRIMARY KEY (id);


--
-- Name: sending_deliveries sending_deliveries_plan_id_sequence_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_deliveries
    ADD CONSTRAINT sending_deliveries_plan_id_sequence_key UNIQUE (plan_id, sequence);


--
-- Name: sending_plans sending_plans_invoice_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_plans
    ADD CONSTRAINT sending_plans_invoice_id_key UNIQUE (invoice_id);


--
-- Name: sending_plans sending_plans_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_plans
    ADD CONSTRAINT sending_plans_pkey PRIMARY KEY (id);


--
-- Name: sending_preferences sending_preferences_owner_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_preferences
    ADD CONSTRAINT sending_preferences_owner_id_key UNIQUE (owner_id);


--
-- Name: sending_preferences sending_preferences_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_preferences
    ADD CONSTRAINT sending_preferences_pkey PRIMARY KEY (id);


--
-- Name: subscription_billing_accounts subscription_billing_accounts_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_accounts
    ADD CONSTRAINT subscription_billing_accounts_pkey PRIMARY KEY (id);


--
-- Name: subscription_billing_accounts subscription_billing_accounts_subscription_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_accounts
    ADD CONSTRAINT subscription_billing_accounts_subscription_id_key UNIQUE (subscription_id);


--
-- Name: subscription_billing_events subscription_billing_events_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_events
    ADD CONSTRAINT subscription_billing_events_pkey PRIMARY KEY (id);


--
-- Name: subscription_billing_events subscription_billing_events_provider_event_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_events
    ADD CONSTRAINT subscription_billing_events_provider_event_id_key UNIQUE (provider_event_id);


--
-- Name: subscription_billing_operations subscription_billing_operations_owner_id_key_digest_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_operations
    ADD CONSTRAINT subscription_billing_operations_owner_id_key_digest_key UNIQUE (owner_id, key_digest);


--
-- Name: subscription_billing_operations subscription_billing_operations_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_operations
    ADD CONSTRAINT subscription_billing_operations_pkey PRIMARY KEY (id);


--
-- Name: subscription_billing_operations subscription_billing_operations_transaction_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_operations
    ADD CONSTRAINT subscription_billing_operations_transaction_id_key UNIQUE (transaction_id);


--
-- Name: subscription_operations subscription_operations_owner_id_key_digest_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_operations
    ADD CONSTRAINT subscription_operations_owner_id_key_digest_key UNIQUE (owner_id, key_digest);


--
-- Name: subscription_operations subscription_operations_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_operations
    ADD CONSTRAINT subscription_operations_pkey PRIMARY KEY (id);


--
-- Name: time_contributions time_contributions_actor_id_source_source_item_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_contributions
    ADD CONSTRAINT time_contributions_actor_id_source_source_item_id_key UNIQUE (actor_id, source, source_item_id);


--
-- Name: time_contributions time_contributions_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_contributions
    ADD CONSTRAINT time_contributions_pkey PRIMARY KEY (id);


--
-- Name: time_entries time_entries_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_entries
    ADD CONSTRAINT time_entries_pkey PRIMARY KEY (id);


--
-- Name: time_entries time_entries_timecard_id_project_id_work_date_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_entries
    ADD CONSTRAINT time_entries_timecard_id_project_id_work_date_key UNIQUE (timecard_id, project_id, work_date);


--
-- Name: time_import_records time_import_records_actor_id_source_source_record_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_import_records
    ADD CONSTRAINT time_import_records_actor_id_source_source_record_id_key UNIQUE (actor_id, source, source_record_id);


--
-- Name: time_import_records time_import_records_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_import_records
    ADD CONSTRAINT time_import_records_pkey PRIMARY KEY (id);


--
-- Name: time_operations time_operations_actor_id_source_idempotency_key_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_operations
    ADD CONSTRAINT time_operations_actor_id_source_idempotency_key_key UNIQUE (actor_id, source, idempotency_key);


--
-- Name: time_operations time_operations_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_operations
    ADD CONSTRAINT time_operations_pkey PRIMARY KEY (id);


--
-- Name: timecards timecard_owner_client_week_kind; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.timecards
    ADD CONSTRAINT timecard_owner_client_week_kind UNIQUE (owner_id, client_id, week_start, is_internal);


--
-- Name: timecards timecards_object_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.timecards
    ADD CONSTRAINT timecards_object_id_key UNIQUE (object_id);


--
-- Name: timecards timecards_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.timecards
    ADD CONSTRAINT timecards_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: workspace_admissions workspace_admissions_email_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.workspace_admissions
    ADD CONSTRAINT workspace_admissions_email_key UNIQUE (email);


--
-- Name: workspace_admissions workspace_admissions_issuer_subject_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.workspace_admissions
    ADD CONSTRAINT workspace_admissions_issuer_subject_key UNIQUE (issuer, subject);


--
-- Name: workspace_admissions workspace_admissions_owner_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.workspace_admissions
    ADD CONSTRAINT workspace_admissions_owner_id_key UNIQUE (owner_id);


--
-- Name: workspace_admissions workspace_admissions_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.workspace_admissions
    ADD CONSTRAINT workspace_admissions_pkey PRIMARY KEY (id);


--
-- Name: workspace_admissions workspace_admissions_slot_id_key; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.workspace_admissions
    ADD CONSTRAINT workspace_admissions_slot_id_key UNIQUE (slot_id);


--
-- Name: workspace_subscriptions workspace_subscriptions_pkey; Type: CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.workspace_subscriptions
    ADD CONSTRAINT workspace_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: ix_audit_events_created_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_audit_events_created_id ON timeker_reference.audit_events USING btree (created_at DESC, id);


--
-- Name: ix_audit_events_entity_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_audit_events_entity_id ON timeker_reference.audit_events USING btree (entity_id);


--
-- Name: ix_case_time_allocations_case_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_case_time_allocations_case_id ON timeker_reference.case_time_allocations USING btree (case_id);


--
-- Name: ix_case_time_allocations_entry_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_case_time_allocations_entry_id ON timeker_reference.case_time_allocations USING btree (entry_id);


--
-- Name: ix_cases_archived_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_cases_archived_at ON timeker_reference.cases USING btree (archived_at);


--
-- Name: ix_cases_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_cases_client_id ON timeker_reference.cases USING btree (client_id);


--
-- Name: ix_cases_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_cases_owner_id ON timeker_reference.cases USING btree (owner_id);


--
-- Name: ix_cases_project_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_cases_project_id ON timeker_reference.cases USING btree (project_id);


--
-- Name: ix_cases_status; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_cases_status ON timeker_reference.cases USING btree (status);


--
-- Name: ix_client_drafts_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_client_drafts_owner_id ON timeker_reference.client_drafts USING btree (owner_id);


--
-- Name: ix_clients_display_name; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_clients_display_name ON timeker_reference.clients USING btree (display_name);


--
-- Name: ix_clients_status; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_clients_status ON timeker_reference.clients USING btree (status);


--
-- Name: ix_contact_attempts_created_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_contact_attempts_created_at ON timeker_reference.contact_attempts USING btree (created_at);


--
-- Name: ix_contacts_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_contacts_client_id ON timeker_reference.contacts USING btree (client_id);


--
-- Name: ix_integration_codes_grant_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_integration_codes_grant_id ON timeker_reference.integration_codes USING btree (grant_id);


--
-- Name: ix_integration_grants_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_integration_grants_owner_id ON timeker_reference.integration_grants USING btree (owner_id);


--
-- Name: ix_integration_operations_grant_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_integration_operations_grant_id ON timeker_reference.integration_operations USING btree (grant_id);


--
-- Name: ix_integration_tokens_expires_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_integration_tokens_expires_at ON timeker_reference.integration_tokens USING btree (expires_at);


--
-- Name: ix_integration_tokens_grant_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_integration_tokens_grant_id ON timeker_reference.integration_tokens USING btree (grant_id);


--
-- Name: ix_invoice_lines_invoice_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_invoice_lines_invoice_id ON timeker_reference.invoice_lines USING btree (invoice_id);


--
-- Name: ix_invoice_time_entries_invoice_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_invoice_time_entries_invoice_id ON timeker_reference.invoice_time_entries USING btree (invoice_id);


--
-- Name: ix_invoices_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_invoices_client_id ON timeker_reference.invoices USING btree (client_id);


--
-- Name: ix_invoices_created_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_invoices_created_id ON timeker_reference.invoices USING btree (created_at DESC, id);


--
-- Name: ix_invoices_due_date; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_invoices_due_date ON timeker_reference.invoices USING btree (due_date);


--
-- Name: ix_invoices_status; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_invoices_status ON timeker_reference.invoices USING btree (status);


--
-- Name: ix_library_document_versions_document_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_library_document_versions_document_id ON timeker_reference.library_document_versions USING btree (document_id);


--
-- Name: ix_library_document_versions_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_library_document_versions_owner_id ON timeker_reference.library_document_versions USING btree (owner_id);


--
-- Name: ix_library_documents_case_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_library_documents_case_id ON timeker_reference.library_documents USING btree (case_id);


--
-- Name: ix_library_documents_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_library_documents_client_id ON timeker_reference.library_documents USING btree (client_id);


--
-- Name: ix_library_documents_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_library_documents_owner_id ON timeker_reference.library_documents USING btree (owner_id);


--
-- Name: ix_library_documents_project_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_library_documents_project_id ON timeker_reference.library_documents USING btree (project_id);


--
-- Name: ix_library_uploads_document_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_library_uploads_document_id ON timeker_reference.library_uploads USING btree (document_id);


--
-- Name: ix_mail_addresses_case_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_addresses_case_id ON timeker_reference.mail_addresses USING btree (case_id);


--
-- Name: ix_mail_addresses_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_addresses_client_id ON timeker_reference.mail_addresses USING btree (client_id);


--
-- Name: ix_mail_addresses_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_addresses_owner_id ON timeker_reference.mail_addresses USING btree (owner_id);


--
-- Name: ix_mail_addresses_project_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_addresses_project_id ON timeker_reference.mail_addresses USING btree (project_id);


--
-- Name: ix_mail_attachments_message_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_attachments_message_id ON timeker_reference.mail_attachments USING btree (message_id);


--
-- Name: ix_mail_messages_archived_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_messages_archived_at ON timeker_reference.mail_messages USING btree (archived_at);


--
-- Name: ix_mail_messages_archived_basis_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_messages_archived_basis_at ON timeker_reference.mail_messages USING btree (archived_basis_at);


--
-- Name: ix_mail_messages_case_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_messages_case_id ON timeker_reference.mail_messages USING btree (case_id);


--
-- Name: ix_mail_messages_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_messages_client_id ON timeker_reference.mail_messages USING btree (client_id);


--
-- Name: ix_mail_messages_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_messages_owner_id ON timeker_reference.mail_messages USING btree (owner_id);


--
-- Name: ix_mail_messages_owner_received_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_messages_owner_received_id ON timeker_reference.mail_messages USING btree (owner_id, received_at DESC, id) WHERE (archived_at IS NULL);


--
-- Name: ix_mail_messages_project_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_mail_messages_project_id ON timeker_reference.mail_messages USING btree (project_id);


--
-- Name: ix_payments_invoice_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_payments_invoice_id ON timeker_reference.payments USING btree (invoice_id);


--
-- Name: ix_projects_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_projects_client_id ON timeker_reference.projects USING btree (client_id);


--
-- Name: ix_proposal_sending_attempts_delivery_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_proposal_sending_attempts_delivery_id ON timeker_reference.proposal_sending_attempts USING btree (delivery_id);


--
-- Name: ix_proposal_sending_deliveries_case_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_proposal_sending_deliveries_case_id ON timeker_reference.proposal_sending_deliveries USING btree (case_id);


--
-- Name: ix_proposal_sending_deliveries_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_proposal_sending_deliveries_owner_id ON timeker_reference.proposal_sending_deliveries USING btree (owner_id);


--
-- Name: ix_proposal_sending_deliveries_state; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_proposal_sending_deliveries_state ON timeker_reference.proposal_sending_deliveries USING btree (state);


--
-- Name: ix_public_email_challenges_address_digest; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_public_email_challenges_address_digest ON timeker_reference.public_email_challenges USING btree (address_digest);


--
-- Name: ix_public_email_challenges_expires_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_public_email_challenges_expires_at ON timeker_reference.public_email_challenges USING btree (expires_at);


--
-- Name: ix_public_email_challenges_network_digest; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_public_email_challenges_network_digest ON timeker_reference.public_email_challenges USING btree (network_digest);


--
-- Name: ix_public_email_challenges_session_digest; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_public_email_challenges_session_digest ON timeker_reference.public_email_challenges USING btree (session_digest);


--
-- Name: ix_quote_artifacts_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_quote_artifacts_owner_id ON timeker_reference.quote_artifacts USING btree (owner_id);


--
-- Name: ix_quote_lines_revision_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_quote_lines_revision_id ON timeker_reference.quote_lines USING btree (revision_id);


--
-- Name: ix_quote_revisions_case_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_quote_revisions_case_id ON timeker_reference.quote_revisions USING btree (case_id);


--
-- Name: ix_quote_revisions_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_quote_revisions_client_id ON timeker_reference.quote_revisions USING btree (client_id);


--
-- Name: ix_quote_revisions_project_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_quote_revisions_project_id ON timeker_reference.quote_revisions USING btree (project_id);


--
-- Name: ix_quote_revisions_quote_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_quote_revisions_quote_id ON timeker_reference.quote_revisions USING btree (quote_id);


--
-- Name: ix_quotes_archived_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_quotes_archived_at ON timeker_reference.quotes USING btree (archived_at);


--
-- Name: ix_quotes_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_quotes_owner_id ON timeker_reference.quotes USING btree (owner_id);


--
-- Name: ix_sending_attempts_delivery_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_sending_attempts_delivery_id ON timeker_reference.sending_attempts USING btree (delivery_id);


--
-- Name: ix_sending_deliveries_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_sending_deliveries_owner_id ON timeker_reference.sending_deliveries USING btree (owner_id);


--
-- Name: ix_sending_deliveries_plan_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_sending_deliveries_plan_id ON timeker_reference.sending_deliveries USING btree (plan_id);


--
-- Name: ix_sending_deliveries_scheduled_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_sending_deliveries_scheduled_at ON timeker_reference.sending_deliveries USING btree (scheduled_at);


--
-- Name: ix_sending_deliveries_state; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_sending_deliveries_state ON timeker_reference.sending_deliveries USING btree (state);


--
-- Name: ix_sending_plans_owner_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_sending_plans_owner_id ON timeker_reference.sending_plans USING btree (owner_id);


--
-- Name: ix_time_contributions_entry_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_time_contributions_entry_id ON timeker_reference.time_contributions USING btree (entry_id);


--
-- Name: ix_time_contributions_timecard_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_time_contributions_timecard_id ON timeker_reference.time_contributions USING btree (timecard_id);


--
-- Name: ix_time_entries_timecard_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_time_entries_timecard_id ON timeker_reference.time_entries USING btree (timecard_id);


--
-- Name: ix_time_entries_work_date; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_time_entries_work_date ON timeker_reference.time_entries USING btree (work_date);


--
-- Name: ix_timecards_archived_at; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_timecards_archived_at ON timeker_reference.timecards USING btree (archived_at);


--
-- Name: ix_timecards_client_id; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_timecards_client_id ON timeker_reference.timecards USING btree (client_id);


--
-- Name: ix_timecards_status; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_timecards_status ON timeker_reference.timecards USING btree (status);


--
-- Name: ix_timecards_week_start; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE INDEX ix_timecards_week_start ON timeker_reference.timecards USING btree (week_start);


--
-- Name: quote_one_draft; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE UNIQUE INDEX quote_one_draft ON timeker_reference.quote_revisions USING btree (quote_id) WHERE ((status)::text = 'draft'::text);


--
-- Name: subscription_billing_current_owner; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE UNIQUE INDEX subscription_billing_current_owner ON timeker_reference.subscription_billing_accounts USING btree (owner_id) WHERE current;


--
-- Name: time_entry_internal_day; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE UNIQUE INDEX time_entry_internal_day ON timeker_reference.time_entries USING btree (timecard_id, work_date) WHERE (project_id IS NULL);


--
-- Name: timecard_internal_personal_week; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE UNIQUE INDEX timecard_internal_personal_week ON timeker_reference.timecards USING btree (owner_id, week_start) WHERE (is_internal AND (client_id IS NULL));


--
-- Name: uq_active_fixed_fee_project; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE UNIQUE INDEX uq_active_fixed_fee_project ON timeker_reference.invoices USING btree (fixed_fee_project_id) WHERE ((fixed_fee_project_id IS NOT NULL) AND ((status)::text <> 'Void'::text));


--
-- Name: uq_active_manual_extra_reference; Type: INDEX; Schema: timeker_reference; Owner: -
--

CREATE UNIQUE INDEX uq_active_manual_extra_reference ON timeker_reference.invoices USING btree (manual_extra_project_id, manual_extra_reference) WHERE ((manual_extra_project_id IS NOT NULL) AND ((status)::text <> 'Void'::text));


--
-- Name: workspace_admissions admission_allocation_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER admission_allocation_history BEFORE DELETE OR UPDATE ON timeker_reference.workspace_admissions FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_admission_history_guard();


--
-- Name: admission_identities admission_identity_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER admission_identity_history BEFORE DELETE OR UPDATE ON timeker_reference.admission_identities FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_admission_history_guard();


--
-- Name: timecards allocated_card_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER allocated_card_guard BEFORE UPDATE ON timeker_reference.timecards FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_allocated_parent_guard();


--
-- Name: projects allocated_project_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER allocated_project_guard BEFORE UPDATE ON timeker_reference.projects FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_allocated_parent_guard();


--
-- Name: case_time_allocations allocation_contribution_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER allocation_contribution_guard BEFORE DELETE OR UPDATE ON timeker_reference.case_time_allocations FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_allocation_contribution_guard();


--
-- Name: case_time_allocations allocation_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER allocation_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.case_time_allocations FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_allocation_guard();


--
-- Name: timecards archive_card_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER archive_card_guard BEFORE DELETE OR UPDATE ON timeker_reference.timecards FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_archive_guard();


--
-- Name: mail_messages archive_mail_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER archive_mail_guard BEFORE DELETE OR UPDATE ON timeker_reference.mail_messages FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_archive_guard();


--
-- Name: invoice_artifacts artifact_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER artifact_guard BEFORE DELETE OR UPDATE ON timeker_reference.invoice_artifacts FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_artifact_guard();


--
-- Name: audit_events audit_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER audit_guard BEFORE DELETE OR UPDATE ON timeker_reference.audit_events FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_artifact_guard();


--
-- Name: cases case_archive_status_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER case_archive_status_guard BEFORE INSERT OR UPDATE ON timeker_reference.cases FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_case_archive_status_guard();


--
-- Name: cases case_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER case_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.cases FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_case_guard();


--
-- Name: cases commercial_case_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER commercial_case_guard BEFORE UPDATE ON timeker_reference.cases FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_commercial_case_guard();


--
-- Name: time_contributions contribution_allocation_check; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE CONSTRAINT TRIGGER contribution_allocation_check AFTER INSERT OR UPDATE ON timeker_reference.time_contributions DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_contribution_allocation_check();


--
-- Name: time_contributions contribution_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER contribution_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.time_contributions FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_contribution_guard();


--
-- Name: credit_memos credit_memo_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER credit_memo_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.credit_memos FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_credit_memo_guard();


--
-- Name: credit_memos credit_memo_invoice_check; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE CONSTRAINT TRIGGER credit_memo_invoice_check AFTER INSERT ON timeker_reference.credit_memos DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_credit_memo_final_guard();


--
-- Name: email_auth_challenges email_challenge_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER email_challenge_history BEFORE DELETE OR UPDATE ON timeker_reference.email_auth_challenges FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_registration_history_guard();


--
-- Name: time_entries entry_allocation_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER entry_allocation_guard BEFORE DELETE OR UPDATE ON timeker_reference.time_entries FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_allocated_entry_guard();


--
-- Name: time_entries entry_contribution_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER entry_contribution_guard BEFORE DELETE OR UPDATE ON timeker_reference.time_entries FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_entry_contribution_guard();


--
-- Name: time_entries entry_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER entry_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.time_entries FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_entry_guard();


--
-- Name: owner_identities identity_binding_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER identity_binding_history BEFORE DELETE OR UPDATE ON timeker_reference.owner_identities FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_registration_history_guard();


--
-- Name: invoice_time_entries internal_billing_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER internal_billing_guard BEFORE INSERT OR UPDATE ON timeker_reference.invoice_time_entries FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_internal_billing_guard();


--
-- Name: timecards internal_card_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER internal_card_guard BEFORE INSERT OR UPDATE ON timeker_reference.timecards FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_internal_card_guard();


--
-- Name: invoices invoice_credit_memo_check; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE CONSTRAINT TRIGGER invoice_credit_memo_check AFTER INSERT OR UPDATE ON timeker_reference.invoices DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_credit_memo_final_guard();


--
-- Name: invoices invoice_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER invoice_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.invoices FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_invoice_guard();


--
-- Name: invoices issued_artifact_check; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE CONSTRAINT TRIGGER issued_artifact_check AFTER INSERT OR UPDATE ON timeker_reference.invoices DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_issued_artifact_check();


--
-- Name: library_documents library_document_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER library_document_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.library_documents FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_library_guard();


--
-- Name: library_uploads library_upload_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER library_upload_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.library_uploads FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_library_guard();


--
-- Name: library_document_versions library_version_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER library_version_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.library_document_versions FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_library_guard();


--
-- Name: invoice_lines line_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER line_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.invoice_lines FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_line_guard();


--
-- Name: mail_addresses mail_address_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER mail_address_guard BEFORE INSERT OR UPDATE ON timeker_reference.mail_addresses FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_mail_guard();


--
-- Name: mail_attachments mail_attachment_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER mail_attachment_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.mail_attachments FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_mail_attachment_guard();


--
-- Name: mail_messages mail_message_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER mail_message_guard BEFORE INSERT OR UPDATE ON timeker_reference.mail_messages FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_mail_guard();


--
-- Name: clients object_id_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER object_id_guard BEFORE UPDATE ON timeker_reference.clients FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_object_id_guard();


--
-- Name: invoices object_id_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER object_id_guard BEFORE UPDATE ON timeker_reference.invoices FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_object_id_guard();


--
-- Name: library_documents object_id_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER object_id_guard BEFORE UPDATE ON timeker_reference.library_documents FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_object_id_guard();


--
-- Name: projects object_id_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER object_id_guard BEFORE UPDATE ON timeker_reference.projects FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_object_id_guard();


--
-- Name: timecards object_id_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER object_id_guard BEFORE UPDATE ON timeker_reference.timecards FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_object_id_guard();


--
-- Name: payments payment_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER payment_guard BEFORE DELETE OR UPDATE ON timeker_reference.payments FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_payment_guard();


--
-- Name: project_agreements project_agreement_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER project_agreement_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.project_agreements FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_project_agreement_guard();


--
-- Name: projects project_billing_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER project_billing_guard BEFORE UPDATE ON timeker_reference.projects FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_project_billing_guard();


--
-- Name: proposal_sending_attempts proposal_attempt_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER proposal_attempt_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.proposal_sending_attempts FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_proposal_sending_guard();


--
-- Name: proposal_sending_deliveries proposal_delivery_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER proposal_delivery_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.proposal_sending_deliveries FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_proposal_sending_guard();


--
-- Name: public_email_challenges public_email_challenge_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER public_email_challenge_history BEFORE DELETE OR UPDATE ON timeker_reference.public_email_challenges FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_admission_history_guard();


--
-- Name: quote_artifacts quote_artifact_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER quote_artifact_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.quote_artifacts FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_quote_guard();


--
-- Name: quote_lines quote_line_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER quote_line_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.quote_lines FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_quote_guard();


--
-- Name: quote_revisions quote_revision_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER quote_revision_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.quote_revisions FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_quote_guard();


--
-- Name: quotes quote_root_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER quote_root_guard BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.quotes FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_quote_guard();


--
-- Name: owner_registrations registration_acceptance_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER registration_acceptance_history BEFORE DELETE OR UPDATE ON timeker_reference.owner_registrations FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_registration_history_guard();


--
-- Name: sending_attempts sending_attempt_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER sending_attempt_history BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.sending_attempts FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_sending_guard();


--
-- Name: sending_deliveries sending_delivery_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER sending_delivery_history BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.sending_deliveries FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_sending_guard();


--
-- Name: sending_plans sending_plan_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER sending_plan_history BEFORE INSERT OR DELETE OR UPDATE ON timeker_reference.sending_plans FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_sending_guard();


--
-- Name: workspace_subscriptions subscription_assignment_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER subscription_assignment_history BEFORE DELETE OR UPDATE ON timeker_reference.workspace_subscriptions FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_subscription_history_guard();


--
-- Name: subscription_billing_accounts subscription_billing_account_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER subscription_billing_account_history BEFORE DELETE OR UPDATE ON timeker_reference.subscription_billing_accounts FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_subscription_billing_guard();


--
-- Name: subscription_billing_events subscription_billing_event_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER subscription_billing_event_history BEFORE DELETE OR UPDATE ON timeker_reference.subscription_billing_events FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_subscription_billing_guard();


--
-- Name: subscription_billing_operations subscription_billing_operation_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER subscription_billing_operation_history BEFORE DELETE OR UPDATE ON timeker_reference.subscription_billing_operations FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_subscription_billing_guard();


--
-- Name: subscription_operations subscription_operation_history; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER subscription_operation_history BEFORE DELETE OR UPDATE ON timeker_reference.subscription_operations FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_subscription_history_guard();


--
-- Name: time_import_records time_import_record_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER time_import_record_guard BEFORE DELETE OR UPDATE ON timeker_reference.time_import_records FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_time_operation_guard();


--
-- Name: time_operations time_operation_guard; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER time_operation_guard BEFORE DELETE OR UPDATE ON timeker_reference.time_operations FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_time_operation_guard();


--
-- Name: timecards timecard_void_restriction; Type: TRIGGER; Schema: timeker_reference; Owner: -
--

CREATE TRIGGER timecard_void_restriction BEFORE INSERT OR UPDATE ON timeker_reference.timecards FOR EACH ROW EXECUTE FUNCTION timeker_reference.timeker_timecard_void_restriction();


--
-- Name: audit_events audit_events_actor_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.audit_events
    ADD CONSTRAINT audit_events_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES timeker_reference.users(id);


--
-- Name: case_time_allocations case_time_allocations_actor_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.case_time_allocations
    ADD CONSTRAINT case_time_allocations_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES timeker_reference.users(id);


--
-- Name: case_time_allocations case_time_allocations_case_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.case_time_allocations
    ADD CONSTRAINT case_time_allocations_case_id_fkey FOREIGN KEY (case_id) REFERENCES timeker_reference.cases(id);


--
-- Name: case_time_allocations case_time_allocations_entry_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.case_time_allocations
    ADD CONSTRAINT case_time_allocations_entry_id_fkey FOREIGN KEY (entry_id) REFERENCES timeker_reference.time_entries(id);


--
-- Name: cases cases_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.cases
    ADD CONSTRAINT cases_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: cases cases_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.cases
    ADD CONSTRAINT cases_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: cases cases_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.cases
    ADD CONSTRAINT cases_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: client_drafts client_drafts_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.client_drafts
    ADD CONSTRAINT client_drafts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: client_source_references client_source_references_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.client_source_references
    ADD CONSTRAINT client_source_references_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: client_source_references client_source_references_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.client_source_references
    ADD CONSTRAINT client_source_references_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES timeker_reference.users(id);


--
-- Name: contacts contacts_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.contacts
    ADD CONSTRAINT contacts_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: credit_memos credit_memos_actor_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.credit_memos
    ADD CONSTRAINT credit_memos_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES timeker_reference.users(id);


--
-- Name: credit_memos credit_memos_invoice_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.credit_memos
    ADD CONSTRAINT credit_memos_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES timeker_reference.invoices(id);


--
-- Name: email_auth_challenges email_auth_challenges_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.email_auth_challenges
    ADD CONSTRAINT email_auth_challenges_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: invoices fk_invoices_fixed_fee_project_id; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoices
    ADD CONSTRAINT fk_invoices_fixed_fee_project_id FOREIGN KEY (fixed_fee_project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: invoices fk_invoices_manual_extra_project_id; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoices
    ADD CONSTRAINT fk_invoices_manual_extra_project_id FOREIGN KEY (manual_extra_project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: integration_codes integration_codes_grant_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_codes
    ADD CONSTRAINT integration_codes_grant_id_fkey FOREIGN KEY (grant_id) REFERENCES timeker_reference.integration_grants(id);


--
-- Name: integration_grants integration_grants_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_grants
    ADD CONSTRAINT integration_grants_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: integration_operations integration_operations_grant_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_operations
    ADD CONSTRAINT integration_operations_grant_id_fkey FOREIGN KEY (grant_id) REFERENCES timeker_reference.integration_grants(id);


--
-- Name: integration_tokens integration_tokens_grant_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.integration_tokens
    ADD CONSTRAINT integration_tokens_grant_id_fkey FOREIGN KEY (grant_id) REFERENCES timeker_reference.integration_grants(id);


--
-- Name: invoice_artifacts invoice_artifacts_invoice_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_artifacts
    ADD CONSTRAINT invoice_artifacts_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES timeker_reference.invoices(id);


--
-- Name: invoice_lines invoice_lines_invoice_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_lines
    ADD CONSTRAINT invoice_lines_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES timeker_reference.invoices(id);


--
-- Name: invoice_lines invoice_lines_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_lines
    ADD CONSTRAINT invoice_lines_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: invoice_time_entries invoice_time_entries_entry_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_time_entries
    ADD CONSTRAINT invoice_time_entries_entry_id_fkey FOREIGN KEY (entry_id) REFERENCES timeker_reference.time_entries(id);


--
-- Name: invoice_time_entries invoice_time_entries_invoice_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoice_time_entries
    ADD CONSTRAINT invoice_time_entries_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES timeker_reference.invoices(id);


--
-- Name: invoices invoices_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.invoices
    ADD CONSTRAINT invoices_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: library_document_versions library_document_versions_document_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_document_versions
    ADD CONSTRAINT library_document_versions_document_id_fkey FOREIGN KEY (document_id) REFERENCES timeker_reference.library_documents(id);


--
-- Name: library_document_versions library_document_versions_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_document_versions
    ADD CONSTRAINT library_document_versions_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: library_document_versions library_document_versions_source_upload_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_document_versions
    ADD CONSTRAINT library_document_versions_source_upload_id_fkey FOREIGN KEY (source_upload_id) REFERENCES timeker_reference.library_uploads(id);


--
-- Name: library_documents library_documents_case_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_documents
    ADD CONSTRAINT library_documents_case_id_fkey FOREIGN KEY (case_id) REFERENCES timeker_reference.cases(id);


--
-- Name: library_documents library_documents_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_documents
    ADD CONSTRAINT library_documents_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: library_documents library_documents_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_documents
    ADD CONSTRAINT library_documents_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: library_documents library_documents_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_documents
    ADD CONSTRAINT library_documents_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: library_uploads library_uploads_document_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_uploads
    ADD CONSTRAINT library_uploads_document_id_fkey FOREIGN KEY (document_id) REFERENCES timeker_reference.library_documents(id);


--
-- Name: library_uploads library_uploads_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.library_uploads
    ADD CONSTRAINT library_uploads_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES timeker_reference.users(id);


--
-- Name: mail_addresses mail_addresses_case_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_addresses
    ADD CONSTRAINT mail_addresses_case_id_fkey FOREIGN KEY (case_id) REFERENCES timeker_reference.cases(id);


--
-- Name: mail_addresses mail_addresses_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_addresses
    ADD CONSTRAINT mail_addresses_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: mail_addresses mail_addresses_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_addresses
    ADD CONSTRAINT mail_addresses_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: mail_addresses mail_addresses_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_addresses
    ADD CONSTRAINT mail_addresses_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: mail_attachments mail_attachments_message_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_attachments
    ADD CONSTRAINT mail_attachments_message_id_fkey FOREIGN KEY (message_id) REFERENCES timeker_reference.mail_messages(id);


--
-- Name: mail_messages mail_messages_case_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_messages
    ADD CONSTRAINT mail_messages_case_id_fkey FOREIGN KEY (case_id) REFERENCES timeker_reference.cases(id);


--
-- Name: mail_messages mail_messages_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_messages
    ADD CONSTRAINT mail_messages_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: mail_messages mail_messages_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_messages
    ADD CONSTRAINT mail_messages_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: mail_messages mail_messages_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.mail_messages
    ADD CONSTRAINT mail_messages_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: owner_identities owner_identities_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.owner_identities
    ADD CONSTRAINT owner_identities_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: owner_registrations owner_registrations_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.owner_registrations
    ADD CONSTRAINT owner_registrations_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: payments payments_created_by_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.payments
    ADD CONSTRAINT payments_created_by_fkey FOREIGN KEY (created_by) REFERENCES timeker_reference.users(id);


--
-- Name: payments payments_invoice_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.payments
    ADD CONSTRAINT payments_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES timeker_reference.invoices(id);


--
-- Name: project_agreements project_agreements_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.project_agreements
    ADD CONSTRAINT project_agreements_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: project_agreements project_agreements_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.project_agreements
    ADD CONSTRAINT project_agreements_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES timeker_reference.users(id);


--
-- Name: projects projects_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.projects
    ADD CONSTRAINT projects_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: proposal_sending_attempts proposal_sending_attempts_delivery_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_attempts
    ADD CONSTRAINT proposal_sending_attempts_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES timeker_reference.proposal_sending_deliveries(id);


--
-- Name: proposal_sending_deliveries proposal_sending_deliveries_case_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_deliveries
    ADD CONSTRAINT proposal_sending_deliveries_case_id_fkey FOREIGN KEY (case_id) REFERENCES timeker_reference.cases(id);


--
-- Name: proposal_sending_deliveries proposal_sending_deliveries_library_version_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_deliveries
    ADD CONSTRAINT proposal_sending_deliveries_library_version_id_fkey FOREIGN KEY (library_version_id) REFERENCES timeker_reference.library_document_versions(id);


--
-- Name: proposal_sending_deliveries proposal_sending_deliveries_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_deliveries
    ADD CONSTRAINT proposal_sending_deliveries_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: proposal_sending_deliveries proposal_sending_deliveries_quote_artifact_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.proposal_sending_deliveries
    ADD CONSTRAINT proposal_sending_deliveries_quote_artifact_id_fkey FOREIGN KEY (quote_artifact_id) REFERENCES timeker_reference.quote_artifacts(id);


--
-- Name: quote_artifacts quote_artifacts_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_artifacts
    ADD CONSTRAINT quote_artifacts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: quote_artifacts quote_artifacts_revision_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_artifacts
    ADD CONSTRAINT quote_artifacts_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES timeker_reference.quote_revisions(id);


--
-- Name: quote_lines quote_lines_revision_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_lines
    ADD CONSTRAINT quote_lines_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES timeker_reference.quote_revisions(id);


--
-- Name: quote_revisions quote_revisions_case_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_revisions
    ADD CONSTRAINT quote_revisions_case_id_fkey FOREIGN KEY (case_id) REFERENCES timeker_reference.cases(id);


--
-- Name: quote_revisions quote_revisions_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_revisions
    ADD CONSTRAINT quote_revisions_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: quote_revisions quote_revisions_parent_revision_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_revisions
    ADD CONSTRAINT quote_revisions_parent_revision_id_fkey FOREIGN KEY (parent_revision_id) REFERENCES timeker_reference.quote_revisions(id);


--
-- Name: quote_revisions quote_revisions_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_revisions
    ADD CONSTRAINT quote_revisions_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: quote_revisions quote_revisions_quote_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quote_revisions
    ADD CONSTRAINT quote_revisions_quote_id_fkey FOREIGN KEY (quote_id) REFERENCES timeker_reference.quotes(id);


--
-- Name: quotes quotes_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.quotes
    ADD CONSTRAINT quotes_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: sending_attempts sending_attempts_delivery_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_attempts
    ADD CONSTRAINT sending_attempts_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES timeker_reference.sending_deliveries(id);


--
-- Name: sending_deliveries sending_deliveries_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_deliveries
    ADD CONSTRAINT sending_deliveries_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: sending_deliveries sending_deliveries_plan_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_deliveries
    ADD CONSTRAINT sending_deliveries_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES timeker_reference.sending_plans(id);


--
-- Name: sending_plans sending_plans_artifact_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_plans
    ADD CONSTRAINT sending_plans_artifact_id_fkey FOREIGN KEY (artifact_id) REFERENCES timeker_reference.invoice_artifacts(id);


--
-- Name: sending_plans sending_plans_invoice_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_plans
    ADD CONSTRAINT sending_plans_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES timeker_reference.invoices(id);


--
-- Name: sending_plans sending_plans_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_plans
    ADD CONSTRAINT sending_plans_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: sending_preferences sending_preferences_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.sending_preferences
    ADD CONSTRAINT sending_preferences_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: subscription_billing_accounts subscription_billing_accounts_checkout_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_accounts
    ADD CONSTRAINT subscription_billing_accounts_checkout_id_fkey FOREIGN KEY (checkout_id) REFERENCES timeker_reference.subscription_billing_operations(id);


--
-- Name: subscription_billing_accounts subscription_billing_accounts_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_accounts
    ADD CONSTRAINT subscription_billing_accounts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: subscription_billing_operations subscription_billing_operations_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_billing_operations
    ADD CONSTRAINT subscription_billing_operations_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: subscription_operations subscription_operations_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.subscription_operations
    ADD CONSTRAINT subscription_operations_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: time_contributions time_contributions_actor_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_contributions
    ADD CONSTRAINT time_contributions_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES timeker_reference.users(id);


--
-- Name: time_contributions time_contributions_case_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_contributions
    ADD CONSTRAINT time_contributions_case_id_fkey FOREIGN KEY (case_id) REFERENCES timeker_reference.cases(id);


--
-- Name: time_contributions time_contributions_entry_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_contributions
    ADD CONSTRAINT time_contributions_entry_id_fkey FOREIGN KEY (entry_id) REFERENCES timeker_reference.time_entries(id);


--
-- Name: time_contributions time_contributions_import_record_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_contributions
    ADD CONSTRAINT time_contributions_import_record_id_fkey FOREIGN KEY (import_record_id) REFERENCES timeker_reference.time_import_records(id);


--
-- Name: time_contributions time_contributions_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_contributions
    ADD CONSTRAINT time_contributions_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: time_contributions time_contributions_timecard_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_contributions
    ADD CONSTRAINT time_contributions_timecard_id_fkey FOREIGN KEY (timecard_id) REFERENCES timeker_reference.timecards(id);


--
-- Name: time_entries time_entries_project_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_entries
    ADD CONSTRAINT time_entries_project_id_fkey FOREIGN KEY (project_id) REFERENCES timeker_reference.projects(id);


--
-- Name: time_entries time_entries_timecard_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_entries
    ADD CONSTRAINT time_entries_timecard_id_fkey FOREIGN KEY (timecard_id) REFERENCES timeker_reference.timecards(id);


--
-- Name: time_import_records time_import_records_actor_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_import_records
    ADD CONSTRAINT time_import_records_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES timeker_reference.users(id);


--
-- Name: time_operations time_operations_actor_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.time_operations
    ADD CONSTRAINT time_operations_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES timeker_reference.users(id);


--
-- Name: timecards timecards_client_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.timecards
    ADD CONSTRAINT timecards_client_id_fkey FOREIGN KEY (client_id) REFERENCES timeker_reference.clients(id);


--
-- Name: timecards timecards_internal_case_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.timecards
    ADD CONSTRAINT timecards_internal_case_id_fkey FOREIGN KEY (internal_case_id) REFERENCES timeker_reference.cases(id);


--
-- Name: timecards timecards_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.timecards
    ADD CONSTRAINT timecards_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- Name: workspace_subscriptions workspace_subscriptions_owner_id_fkey; Type: FK CONSTRAINT; Schema: timeker_reference; Owner: -
--

ALTER TABLE ONLY timeker_reference.workspace_subscriptions
    ADD CONSTRAINT workspace_subscriptions_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES timeker_reference.users(id);


--
-- PostgreSQL database dump complete
--
