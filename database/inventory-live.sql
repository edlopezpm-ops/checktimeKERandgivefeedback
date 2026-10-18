-- READ-ONLY metadata collection. Not run against Stage/PROD by this dossier task.
-- Run in the intended database with an operator-approved metadata/reader role.
-- All schema names are listed; object details exclude pg_* and information_schema.
-- No business rows, passwords, tokens, sequence current values or credential stores.
-- Keep output private until reviewed: custom definitions/defaults can contain literals.
BEGIN READ ONLY;
SET LOCAL statement_timeout = '30s';
SET LOCAL search_path = pg_catalog;

WITH user_schemas AS (
  SELECT oid, nspname FROM pg_namespace
  WHERE nspname !~ '^pg_' AND nspname <> 'information_schema'
), relations AS (
  SELECT c.*, n.nspname FROM pg_class c
  JOIN user_schemas n ON n.oid=c.relnamespace
), routine_objects AS (
  SELECT p.*, n.nspname, l.lanname FROM pg_proc p
  JOIN user_schemas n ON n.oid=p.pronamespace
  JOIN pg_language l ON l.oid=p.prolang
)
SELECT jsonb_build_object(
  'scope', 'metadata-only; object definitions for non-system schemas; no row data',
  'collected_at_utc', to_char(clock_timestamp() AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.US"Z"'),
  'server_version', current_setting('server_version'),
  'connected_database', current_database(),
  'connected_role', current_user,
  'transaction_read_only', current_setting('transaction_read_only'),
  'schemas', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'name',nspname,'owner',pg_get_userbyid(nspowner),'acl',nspacl::text,
      'usage_for_current_role',has_schema_privilege(oid,'USAGE'),
      'create_for_current_role',has_schema_privilege(oid,'CREATE')) ORDER BY nspname)
    FROM pg_namespace), '[]'::jsonb),
  'relations', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',nspname,'name',relname,'kind',relkind,
      'owner',pg_get_userbyid(relowner),'persistence',relpersistence,
      'rls_enabled',relrowsecurity,'force_rls',relforcerowsecurity,
      'acl',relacl::text,'partition_key',pg_get_partkeydef(oid)) ORDER BY nspname,relname)
    FROM relations WHERE relkind IN ('r','p','v','m','f')), '[]'::jsonb),
  'columns', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',c.nspname,'table',c.relname,'position',a.attnum,'name',a.attname,
      'type',format_type(a.atttypid,a.atttypmod),'nullable',NOT a.attnotnull,
      'default',pg_get_expr(d.adbin,d.adrelid),'identity',a.attidentity,
      'generated',a.attgenerated,'collation',co.collname)
      ORDER BY c.nspname,c.relname,a.attnum)
    FROM relations c JOIN pg_attribute a ON a.attrelid=c.oid
    LEFT JOIN pg_attrdef d ON d.adrelid=c.oid AND d.adnum=a.attnum
    LEFT JOIN pg_collation co ON co.oid=a.attcollation
    WHERE c.relkind IN ('r','p','v','m','f') AND a.attnum>0 AND NOT a.attisdropped), '[]'::jsonb),
  'constraints', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',c.nspname,'table',c.relname,'name',x.conname,'kind',x.contype,
      'definition',pg_get_constraintdef(x.oid,true),'validated',x.convalidated,
      'deferrable',x.condeferrable,'initially_deferred',x.condeferred)
      ORDER BY c.nspname,c.relname,x.conname)
    FROM relations c JOIN pg_constraint x ON x.conrelid=c.oid), '[]'::jsonb),
  'indexes', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',c.nspname,'table',c.relname,'name',i.relname,
      'primary_key',x.indisprimary,'unique',x.indisunique,'valid',x.indisvalid,
      'definition',pg_get_indexdef(x.indexrelid),'predicate',pg_get_expr(x.indpred,x.indrelid))
      ORDER BY c.nspname,c.relname,i.relname)
    FROM relations c JOIN pg_index x ON x.indrelid=c.oid JOIN pg_class i ON i.oid=x.indexrelid), '[]'::jsonb),
  'routines', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',p.nspname,'name',p.proname,'kind',p.prokind,
      'identity_arguments',pg_get_function_identity_arguments(p.oid),
      'arguments',pg_get_function_arguments(p.oid),'result',pg_get_function_result(p.oid),
      'language',p.lanname,'owner',pg_get_userbyid(p.proowner),
      'security_definer',p.prosecdef,'volatility',p.provolatile,
      'strict',p.proisstrict,'parallel',p.proparallel,'configuration',p.proconfig,
      'acl',p.proacl::text,
      'definition',CASE WHEN p.prokind='a' THEN NULL ELSE pg_get_functiondef(p.oid) END)
      ORDER BY p.nspname,p.proname,pg_get_function_identity_arguments(p.oid))
    FROM routine_objects p), '[]'::jsonb),
  'triggers', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',c.nspname,'table',c.relname,'name',t.tgname,'internal',t.tgisinternal,
      'enabled',t.tgenabled,'definition',pg_get_triggerdef(t.oid,true),
      'function_schema',n.nspname,'function_name',p.proname,
      'constraint_name',x.conname,'deferrable',t.tgdeferrable,
      'initially_deferred',t.tginitdeferred)
      ORDER BY c.nspname,c.relname,t.tgname)
    FROM relations c JOIN pg_trigger t ON t.tgrelid=c.oid
    JOIN pg_proc p ON p.oid=t.tgfoid JOIN pg_namespace n ON n.oid=p.pronamespace
    LEFT JOIN pg_constraint x ON x.oid=t.tgconstraint), '[]'::jsonb),
  'sequences', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',s.schemaname,'name',s.sequencename,'type',s.data_type,
      'start',s.start_value,'min',s.min_value,'max',s.max_value,
      'increment',s.increment_by,'cycle',s.cycle,'cache',s.cache_size)
      ORDER BY s.schemaname,s.sequencename)
    FROM pg_sequences s JOIN user_schemas n ON n.nspname=s.schemaname), '[]'::jsonb),
  'views', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',c.nspname,'name',c.relname,'materialized',c.relkind='m',
      'definition',pg_get_viewdef(c.oid,true)) ORDER BY c.nspname,c.relname)
    FROM relations c WHERE c.relkind IN ('v','m')), '[]'::jsonb),
  'types', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'schema',n.nspname,'name',t.typname,'kind',t.typtype,
      'base_type',CASE WHEN t.typtype='d' THEN format_type(t.typbasetype,t.typtypmod) ELSE NULL END,
      'enum_labels',(SELECT jsonb_agg(e.enumlabel ORDER BY e.enumsortorder) FROM pg_enum e WHERE e.enumtypid=t.oid),
      'domain_constraints',(SELECT jsonb_agg(pg_get_constraintdef(x.oid,true) ORDER BY x.conname)
                            FROM pg_constraint x WHERE x.contypid=t.oid))
      ORDER BY n.nspname,t.typname)
    FROM pg_type t JOIN user_schemas n ON n.oid=t.typnamespace
    WHERE t.typtype IN ('d','e','r','m')), '[]'::jsonb),
  'policies', COALESCE((SELECT jsonb_agg(to_jsonb(p) ORDER BY p.schemaname,p.tablename,p.policyname)
    FROM pg_policies p JOIN user_schemas n ON n.nspname=p.schemaname), '[]'::jsonb),
  'extensions', COALESCE((SELECT jsonb_agg(jsonb_build_object(
      'name',e.extname,'schema',n.nspname,'version',e.extversion)
      ORDER BY e.extname) FROM pg_extension e JOIN pg_namespace n ON n.oid=e.extnamespace), '[]'::jsonb)
) AS database_metadata;

ROLLBACK;
