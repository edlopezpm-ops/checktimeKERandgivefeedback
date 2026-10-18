# Schemas, tenancy and known inventory

This database reference follows application source
`9fc9eebdaf9f52170530c8a28d34f6c8cd612c64`, prepared on 2026-10-18 after PH2
administrative closure. It describes source-defined structure, retained dated
Stage evidence and a separately built empty reference database. No live
Stage/production catalog or business table was queried to prepare this chapter.

A complete source-derived reference and a complete live database inventory are
different deliverables. The former is supplied here. Exact live schema names,
owners, provider-managed schemas and current deployment drift remain unknown
where the available evidence does not enumerate them.

## Three populations with different evidence

| Population | Known structure/count | Evidence boundary |
| --- | --- | --- |
| Empty local reference | PostgreSQL 18.4; schema `timeker_reference`; 55 tables, 634 columns, 36 functions, 61 application triggers, 360 internal triggers and 90 foreign keys; migration head `ph3_009_read_indexes` | Reference-build catalog counts. Contains no live owners, clients, financial records, credentials or provider data. |
| Maintained Stage targets | Nine schemas last verified at head 009; 495 snapshot tables and 486 retained application-table images | Dated backup/migration/readback evidence; does not enumerate every live schema name or imply nine active owners/free slots. |
| Excluded Stage quarantines | Five retained quarantined schemas, separate from the nine maintained targets | Retained exclusion evidence. Exact names and fresh live catalog state are not available in this source snapshot. |

The source pins the maintained head in [app/db.py:6](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/db.py#L6).
The dated nine-schema preservation result is in
[HOSTING.md:26](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L26),
with current inventory limits at
[HOSTING.md:38](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/HOSTING.md#L38).

The reference catalog is an empty structural specimen, not a Stage backup,
production restore, provider-schema dump or migration applied to an existing
service. Its PostgreSQL 18.4 version describes the reference build only. It does
not establish either hosted environment's current server version or capacity.

## Exact names that the available sources actually identify

| Name or family | What is established | What is not established |
| --- | --- | --- |
| `timeker_reference` | This package's empty reference schema | It is not a live workspace or a schema to deploy by renaming. |
| `timeker` | Default hosted application schema, paired with runtime role `timeker_app` | This source-defined/default mapping is not a fresh catalog observation of all live tenants. |
| `timeker_eve` | Named retained/inactive schema in the historical Stage database runbook; explicitly excluded by the Stage transport policy | Current live presence, ownership and row inventory have not been queried here; it is not an admitted Stage login target. |
| `timeker_stage_*` | Required naming family for additional configured Stage targets, with corresponding `*_app` roles | A naming rule does not enumerate actual schema names or prove allocation. |
| `timeker_stage_signup_*` | Five prepared schemas are described using this family in the operations record | Exact suffixes, current allocation and owner identities are not published in the source inventory. |
| `public` | Non-hosted fallback when no explicit schema is selected | It is not proof that hosted business tables use `public`, or a complete account of provider-managed schemas. |

Sources: [default schema selection](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/tenancy.py#L105),
[Stage schema/role policy](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/cloudflare/README.md#L26),
[historical inactive schema](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/postgres/README.md#L9),
[prepared-family and quarantine boundary](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/OPERATIONS.md#L93).

**UNKNOWN:** the complete nine-name maintained Stage list; the complete five-name
quarantine list; each target's current owner/runtime role, allocation and grants;
the complete live production schema inventory; and all installed Supabase/platform
schema names, objects and counts. These unknowns must remain visible until an
authorized metadata-only inventory supplies them. Synthetic test names, numeric
suffix guesses and assumed Supabase defaults cannot fill the gaps.

The nine maintained targets plus five exclusions describe fourteen targets in
the retained maintenance account. They are not a verified total for every schema
in either hosted PostgreSQL database. In particular, do not infer installed
`auth`, `storage`, `realtime` or other provider schemas from product conventions
or authentication API URLs.

## Count denominators

The application has 54 mapped application tables. Alembic adds its version table,
giving 55 tables in the reference schema. At the recorded nine-schema maintenance
boundary, 9 × 55 explains the 495-table snapshot and 9 × 54 explains the 486
application-table preservation images. The latter includes application management
tables and directory shadows; it is not a count of 486 distinct entity types.

The five quarantines were excluded from that nine-schema backup/migration
population. Older evidence describes them as empty, NOLOGIN and retained at
head 005. “Empty” must not be translated into zero physical tables: retained
migration markers and structure are different from an absence of business rows.
Their exact physical table inventory remains unknown here.
[Dated owner/quarantine record](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/OPERATIONS.md#L144).

The reference's 36 functions and 61 application triggers are structure counts.
The additional 360 internal triggers are PostgreSQL-maintained catalog objects,
not 360 more application features. The 90 foreign keys are constraint counts.
None of these counts measures active owners, business rows, API endpoints, passed
tests, hosted service health or human acceptance.

## Workspace routing and isolation

One owner/user belongs to one private workspace. Clients, Projects and Cases are
business records inside it. The server resolves a fixed descriptor containing
schema, runtime role and connection factory from verified identity or a scoped
integration credential. Browser/model-supplied names and UUIDs cannot select an
arbitrary schema. There is no default-owner fallback or runtime DDL.

The registry requires unique identifiers, schemas, roles and encryption keys;
additional descriptors and prepared slots must remain on the selected database
boundary. Each connection checks its actual `current_user` and `current_schema()`
against the expected descriptor. A connection string alone is not isolation proof.
[Registry validation](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/tenancy.py#L148),
[prepared slots](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/tenancy.py#L251),
[connection identity check](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/db.py#L19).

New-owner admission reserves an exact operator-prepared slot, initializes and
reads back its immutable owner identity, then activates the retained mapping.
Reservations survive partial failure; they are not casually reassigned. A
prepared schema is not necessarily an active owner workspace or currently free.
[Reserve/initialize/activate](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission.py#L142).

## Runtime roles and schema owners

| Role boundary | Source or retained evidence |
| --- | --- |
| Default runtime role | `timeker_app`; schema USAGE and explicit table/sequence privileges, without schema creation or object ownership. |
| Additional Stage runtime roles | Corresponding `<schema>_app` naming rule. Exact complete live role-name list is unknown. |
| Migration owner | Historical `timeker_migrator` is explicitly named for the default schema. Do not treat it as the owner of every workspace. |
| Retained owner split | The dated nine-target record describes four named migrators and five administrator-owned prepared schemas; exact complete owner-name inventory is unavailable. |
| Quarantine roles | Retained NOLOGIN exclusion; not proof of usable runtime admission or authorization to enable them. |
| Provider/platform roles | `anon`, `authenticated` and `service_role` occur as revoked principals in grant policy; this does not inventory every installed role or provider schema. |

[Runtime grants](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/scripts/postgres-runtime-grants.sql#L3),
[historical default owner/runtime provisioning](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/deploy/postgres/README.md#L57),
[four/five owner split](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/docs/OPERATIONS.md#L144).

Readiness checks reject runtime object ownership, schema CREATE, role membership,
foreign-schema USAGE and elevated role capabilities. Operator/migrator authority
must not enter the serving container or be substituted for the runtime role to
make an isolation check pass.
[Runtime privilege verification](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/tenancy.py#L405).

## Central directory and noncentral shadows

`workspace_admissions`, `admission_identities` and `public_email_challenges` are
the three central admission tables. They are part of the replicated application
structure, but only the fixed default directory role receives their central
SELECT/INSERT/UPDATE authorization. Noncentral runtime roles lose access to
their shadow copies. Physical presence therefore does not imply the same
operational purpose or permission in every workspace schema.
[Directory table list](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission_operations.py#L12),
[directory grant boundary](https://github.com/edlopezpm-ops/timeker-PH2/blob/9fc9eebdaf9f52170530c8a28d34f6c8cd612c64/app/admission_operations.py#L79).

## How to close the live inventory gap

Use the separately reviewed [metadata inspection procedure](07-inspect-live-metadata.md)
and [inventory-live.sql](inventory-live.sql) only on a specifically authorized
connection. Retain target/date/role, exact schema names and visibility limits;
compare maintained, prepared, allocated, inactive, quarantine and platform
populations explicitly. A role-limited view can be complete for that role without
being a complete server inventory. No schema creation, grants, migration, data
query or recovery action follows from this documentation.
