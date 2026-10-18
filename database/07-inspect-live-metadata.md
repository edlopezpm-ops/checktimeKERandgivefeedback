# Inspect live metadata without changing the application

This is a procedure for a future explicitly authorized metadata inspection.
Preparing it did not connect to Stage/production, read credentials or verify a
live schema inventory. The SQL collector was validated only on the empty local
reference database. The known/unknown boundary is recorded
in [schemas and tenancy](01-schemas-and-tenancy.md).

Use the reviewed [inventory-live.sql](inventory-live.sql). It is an inspection
artifact, separate from the package's empty reference-schema DDL. Never run the
reference build, migrations, seed commands, grant scripts or a restore against a
live connection merely to inspect metadata.

## Identify the intended target

Before opening a connection, record the selected environment, database, role and
purpose through existing approved custody. Obtain only the access needed for
catalog inspection; do not extract or copy app/provider credentials. Connection
details and passwords do not belong in this public repository, a chat message,
screenshots, command history or exported SQL.

Use an already authorized read-only PostgreSQL connection with required TLS
verification. Do not change role attributes, grants, ownership, search paths or
production settings to obtain broader visibility. Confirm the actual connected
database and role before running the rest of the script; confusing Stage,
production and the local reference invalidates the result.

The application itself checks connection role/schema identity in
[app/db.py:19](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/db.py#L19).
Its environment/tenant validation is defined in
[app/tenancy.py:148](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/tenancy.py#L148).
These are source controls, not evidence that this procedure has connected.

## PostgreSQL command-line client

1. Select an existing approved connection profile or protected credential
   mechanism for the intended database. Do not paste a password-bearing URL into
   a shell command or this document.
2. Open `psql` with that profile. Check its displayed connection information and
   the script's target/role identity results. Stop if the target is unexpected.
3. Enable stop-on-error for the session, then execute the reviewed script from
   its local location. The relative example assumes `psql` was started from this
   dossier's root:

   ```text
   \set ON_ERROR_STOP on
   \i database/inventory-live.sql
   ```

4. Preserve the result and any permission errors in approved private evidence
   custody. Close the session after the read-only transaction ends. If execution
   stopped early inside a transaction, issue `ROLLBACK` before disconnecting.

No connection string or credential is supplied by this example. Starting `psql`
alone does not make its connection read-only; retain the script's read-only
transaction boundary and the selected role restrictions.

## pgAdmin

1. Select the already approved server and intended database. Check the actual
   database/role; a similarly named saved connection is not enough.
2. Open Query Tool for that database and load `inventory-live.sql` as text.
   Review the complete script and selected connection before execution.
3. Execute the reviewed inspection script. Preserve its read-only transaction
   controls; do not run a table-edit grid, restore dialog, schema designer or
   generated DDL as part of inspection.
4. Inspect every result set and reported error. A hidden object or denied catalog
   definition is a visibility limitation, not evidence that the object does not
   exist. Export only the needed metadata into approved private custody.
5. End any unfinished transaction with `ROLLBACK`, then close the query session.

Client/object-browser caches can be stale. Catalog results tied to the actual
connection/date/role are the evidence; refreshing a tree is not a replacement.

## VS Code

Use an existing authorized PostgreSQL-capable connection extension, or the
integrated terminal with the `psql` procedure above. This dossier does not require
installing or granting a new extension access to production credentials.

1. Open `database/inventory-live.sql` and explicitly select the intended saved
   database connection. Verify database, role and environment in the client's
   connection/status display and identity result.
2. Execute the complete reviewed read-only inspection script. If the extension
   sends selections separately, preserve transaction boundaries and statement
   order; do not accidentally run unrelated editor content.
3. Keep connection secrets and results out of workspace settings, synchronized
   profiles, source control and public output. Close the connection after use.

An editor's “read-only” result grid is not a server permission boundary. Use the
restricted role and SQL read-only transaction; never rely on the appearance of
the UI to prevent a write.

## Interpret and retain the result

Catalog metadata can identify schemas, owners, relations, columns, constraints,
indexes, functions, triggers and privileges visible to the selected role. It
must not read business rows, invoke application functions, infer identities from
email, execute provider calls or trigger repairs. If a definition is unavailable,
record UNKNOWN or permission-limited rather than granting extra authority.

Record environment/date, actual connected role/database, query/script version,
all result sets, errors and visibility limits. Avoid publishing unreviewed live
owners, connection endpoints, role memberships or function text: operational
metadata may itself require private custody. Supply a sanitized inventory or
reviewed public subset when updating this dossier.

Compare against the empty PostgreSQL 18.4 reference schema `timeker_reference`:
55 tables (54 mapped application tables plus Alembic), 634 columns, 36 functions,
61 application triggers, 360 internal triggers, 90 foreign keys and head 009.
Those reference-build counts are not assertions about all live provider schemas,
every tenant's current head or either hosted server's version.

The latest retained Stage maintenance proof covers nine schemas at
`ph3_009_read_indexes` and five excluded quarantines. Full exact live names and
provider/platform inventories remain unknown until this separate inspection is
authorized, executed and reviewed.
[Retained maintenance evidence](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/HOSTING.md#L197).

A catalog match establishes structural correspondence within the observed scope.
It does not prove application correctness, human UAT, tenant recovery, current
business totals, provider interoperability, a backup/restore, or production
release readiness. Any discrepancy leads to a separately scoped decision; this
procedure authorizes no repair, migration, grant, deletion or deployment.
