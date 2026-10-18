# 15 — Complete application database reference

The [database folder](database/README.md) contains the complete physical database
reference produced by the pinned PH3 source `9fc9eebdaf9f52170530c8a28d34f6c8cd612c64`
at migration head `ph3_009_read_indexes`.

This extension applied all 26 migrations to a new, empty, loopback-only
PostgreSQL 18.4 database, inspected native catalogs and ran Alembic metadata
comparison successfully. It imported models and executed local migrations only;
it did not start the application, seed/read business records, connect to a hosted
database or run product tests. The owned local server was stopped afterward.

| Reference object | Count |
| --- | --- |
| Application tables | 54 |
| Tables including `alembic_version` | 55 |
| Columns | 634 |
| Foreign keys | 90 |
| Indexes, including PK/unique backing indexes | 192 |
| Sequences | 8 |
| Final application PL/pgSQL functions | 36 |
| Application stored procedures | 0 |
| Application triggers | 61: 57 ordinary,4 deferred constraint triggers |
| PostgreSQL-generated FK triggers in this build | 360 |

Read the [schema inventory](database/01-schemas-and-tenancy.md),
[all table layouts](database/02-tables-and-layouts.md),
[full relationship map](database/03-relationships-and-map.md),
[all final function bodies](database/04-functions-and-procedures.md),
[every application trigger](database/05-application-triggers.md) and
[internal objects](database/06-internal-triggers-and-other-objects.md).
The [catalog JSON](database/catalog.json),
[schema-only SQL](database/reference-schema.sql) and
[provenance](database/PROVENANCE.json) supply machine-readable structure.

`timeker_reference` is a synthetic local name. The last retained Stage evidence
counts9 maintained schemas and 5 quarantines, but the complete exact live schema
names and provider/system inventory are unavailable in the permitted source.
Those unknowns are explicit; no live parity claim follows from reconstruction.
[Read-only inventory instructions](database/07-inspect-live-metadata.md) and
[SQL](database/inventory-live.sql) support collecting that metadata separately.

The migration-only reference retains default PUBLIC EXECUTE on6 older functions;
30 revoke it during migrations. The separate source runtime-grants policy revokes
all application-function PUBLIC access. Hosted role/grant installation was not
performed or freshly verified here; the schema-only export omits privileges.
SQLAlchemy client defaults and Python domain behavior remain separate from
PostgreSQL defaults, trigger guards and stored procedures.
