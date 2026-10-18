# 16 — Code flow and maintenance keystone

The [code-flow reference](code-flow/README.md) traces the pinned PH3 source
`9fc9eebdaf9f52170530c8a28d34f6c8cd612c64` through real functions, branches,
transactions, persistence guards, external effects and error outcomes.

Read the [single code-flow Markdown](code-flow/timeKER-CODE-FLOW-FULL.md), or the
eight module chapters in that folder. GitHub renders their Mermaid diagrams
directly. The modules cover runtime/requests, identity/admission, work/billing,
documents/Mail/Sending, integrations/subscriptions, operations/troubleshooting,
browser/UI and the complete Python symbol index.

The deterministic AST index covers 118 production/support Python modules,
103 classes, 945 functions/async declarations, 13,140 syntactic call sites and
438 internal declared-import edges; it includes 180 app literal route decorators.
It provides source locations rather than claiming runtime call resolution,
execution order, coverage or reachability. All browser scripts and Worker entry
boundaries are described separately in the relevant flow chapters.

Each narrative diagram explains its actual decision points, transaction owner,
durable state, failure/retry boundaries and existing test/source pointers. A
symptom map and incident evidence template support future troubleshooting. The
folder connects to the [full database reference](database/README.md), existing
route/test catalogs and current scope/authority boundaries.

This is a maintenance and future whitepaper/SDK foundation. No SDK, public API
compatibility guarantee, new feature, hosted validation or production authority
is created by the diagrams. Product/runtime tests were not rerun for this
source-only documentation extension.
