# HOC repair and hosted delivery — 26–27 October 2026

The reviewed repairs are published in the separate Stage and PROD main histories and deployed to their intended runtimes. Stage is Container version **53**; PROD is version **22**. Exact image, readiness, static assets and restricted-role observations passed in both environments. This is a bounded technical delivery under `HOC-2026-10-26-TIMEKER-REPAIR-STAGE-PROD`; it is not full PH3 product acceptance or wholesale promotion of PH3 into PROD.

The frozen 30-capability assessment is **INCONCLUSIVE**: **24 PASS, 0 FAIL, 6 UNKNOWN**. Weights remain **W=126, P=100, F=0, U=26**. Demonstrated evidence is **79.37%**; decided evidence is **79.37%**; pending evidence is **20.63%**. These are evidence-policy ratios, not branch coverage, a probability of correctness or an estimate of every possible defect. [Matrix](MATRIX.json), [scorecard](SCORECARD.json), [unchanged calculator](repro/calculate_score.py).

The historical audit remains intact with W=126, P=63, F=42 and U=21. This separate candidate packet uses the same contract and calculator, independently re-evaluates each leaf, and does not inherit historical PASS labels. Its inventory closure applies to the bounded repair and current evidence; it does not claim a new semantic reading of the whole historical repository. [Frozen contract](reviews/contract.json), [coverage](COVERAGE.json), [historical audit](../2026-10-26-implementation-integrity/REPORT.md).

## Sources and deployed results

| Surface | Tested repair source | Final documentation checkpoint or runtime |
|---|---|---|
| Stage main | `42910224ccff417b1bbc38c1772de240487f1125` | `bdd03c7dcf16629126fe795ce8ffa59cabcf40ce` |
| PROD main | `42482d0ddcda8b56acf305eba465700965c34582` | `7fd285d538f38a17f4dd884bd4484f28fb1ffdaa` |
| PH3 complete backend/browser | `a6979425af4d8327ae52d93adb3aa56575438c04` | Documentation descendant `f90af25475a6fa0d955c63c3ef5354a72b356e67` |
| PROD runtime complete browser | `a4d916e770558165492d325292814dc4f1be9397` | Documentation descendant `20d37fa1d2d3133eb70eee1170ca99c9e6b42810` |
| [Stage](https://stage-timeker.aekr.io) image | `ac46c5184b60950b6631e31661edfd3885df92aa` | Version 53; image `sha256:f21568164c63f382fa23940d0f65a4b1361652bd0c910429316b5b87a9fd6400` |
| [PROD](https://timeker.aekr.io) image | `0e4d4e95c9552710518c838f02e31717934b4e15` | Version 22; image `sha256:1225b22f42756403fc634173e18cff434c7ca3de405994a7ceeb45ead602a637` |

The test descendants differ from image sources only in the recorded E2E harness files; application, backend tests, locks, migrations, grants and build inputs are identical. Each final documentation commit adds five documentation files/updates without deleting historical lines. No code test is claimed as rerun merely because documentation changed. PROD main retains pre-existing undeployed Collect work; the selected PROD image preserves the separate approved runtime boundary. Stage remains schema 017 and PROD schema 009. [Exact promotion and source mapping](PROMOTION.json), [source equivalence and test evidence](TEST-RESULTS.json).

Both images were built from scratch, checked as nonroot with a read-only filesystem, and started against actual disposable PostgreSQL containers with migrations from empty and canonical nonowner grants. Hosted delivery then verified the exact image and running version, readiness, public pages and matching static assets. Postdeployment read-only role checks covered eight Stage and two PROD credential scopes. Operator connections used verify-full TLS; unreadable encrypted provider secret values were not asserted to match local custody. Registry upload failures remain retained; the reviewed continuation reused the same image and verified remote blobs/manifests before deployment, without changing product source or activations. Configuration and binding preservation are recorded separately from image delivery.

## Repair findings

| Finding | Final bounded result |
|---|---|
| FIN-01 | Integer minutes now produce exact rational cents and one grouped half-up rounding. An independent oracle and SQL/PDF/CSV checks cover half-cent cases. Issued amounts and immutable artifacts are retained; stale drafts require explicit recalculation/review. |
| Native Billing lookup | Search and pagination retain client/date/context and remain on Billing. Only explicit work selection enters the PH3 work flow; PH2 retains its own creation contract. |
| B01 | Own-role checks reject replication, elevation, ownership, CREATE and unsafe memberships even for a singleton workspace; reciprocal isolation remains separate. Hosted restricted-role observations passed. |
| B02 | An explicit owned-client join precedes active-card filters and limit. Local OAuth/token/tools-call and independent SQL prove cardinality, identities, minutes and truncation; real assistant-host interoperability remains unknown. |
| B04 | UTC normalization precedes the seven-day elapsed duration. DST, replay, paid-period binding and stale-event tests pass. Read-only current impact inventory found no retained grace anchors/receipts requiring reconciliation; no entitlements were rewritten. |
| B03 | The selected baseline already exposed the collector route. Full-application middleware tests prove positive effects and negative no-effects under current consent/purpose controls. No new optional purpose was activated. |
| EVAL-01 | Tests exercise actual Stage/PROD exports and forwarding boundaries. Constant-success and other negative controls were detected; restored source equivalence is recorded without relabeling retained mutations as fresh runs. |
| EVAL-02 | Canonical documentation separates historical PH2 evidence, current PH3 authority, source/image identities and observed scheduling. An actual Stage scheduled event is now recorded; PROD invocation and unobserved business effects remain separate. |
| Harness and complete suites | Disposable nonowner databases, explicit operator checks, current legal/UI fixtures and strict external redirect interception replaced obsolete assumptions without weakening business assertions. All earlier failures and interruptions remain retained. |
| Mobile accessibility | Narrow-screen control spacing removes the 320px search/language overlap. Complete browser tests and hosted mobile inspection pass within the inspected scope; no blanket WCAG certification is claimed. |
| PUB-01 | XML is sanitized through parsed text, tails and attributes, serialized and reparsed. Historical test identities/counts are preserved. The separate dossier repair remains published at `5fa0b23868d47c5fc407b5286b6691e230e9d232`. |

Each finding has root cause, changed paths, retained reproduction/verification hashes and remaining limits in [REPAIR-PROOF.json](REPAIR-PROOF.json). Earlier nonzero focused runs remain nonzero; later complete success is a separate invocation.

## Verification and actual hosted journeys

| Invocation | Result |
|---|---|
| PH3 complete backend | 2,509 PASS; zero failures, errors or skips |
| PH3 complete browser | 352 PASS; zero failures, errors or skips |
| Stage-main complete backend | 2,267 PASS; backend/build inputs identical to the later E2E-only source |
| Stage-main complete browser | 316 PASS; zero failures, errors or skips |
| PROD-runtime complete backend | 2,253 PASS; zero failures, errors or skips |
| PROD-runtime complete browser | 322 PASS; zero failures, errors or skips |
| PROD-main full attempt | 2,280 PASS and **3 setup errors**; exit 1 remains retained |
| PROD-main exact capacity focus | 3 PASS in a separate unchanged-source invocation |

The three PROD-main errors came from one shared capacity fixture connection before application assertions. No definitive connection-failure cause was established. Independent review accepted the directive's C3 common-coverage reuse: the exact capacity tests and 25 dependency paths are identical to complete passing Stage/runtime suites, all 53 changed main-specific backend cases passed, and the exact three-node main focus passed without a source/configuration repair. **This is not a recombined full-green main run.** Prior interrupted processes receive no PASS credit. Current Ruff and mypy gates passed, as did adapter tests with 65/60/62/60 cases and typechecks across the four carriers. Test commands, exact sources, counts and original receipt/XML/log hashes are in [TEST-RESULTS.json](TEST-RESULTS.json). Missing or skipped remote CI checks are not CI success.

On repaired Stage 53, a new explicitly fictional two-minute draft at USD 15.15/hour displayed **USD 0.51** after reload. A fresh restricted read-only SQL connection verified the line, subtotal and total. The authenticated downloaded two-page Draft PDF showed the same values and was visually inspected. Native no-JavaScript Choose work/back preserved client/dates; the 320-CSS-pixel view had no horizontal overflow. The draft was not issued: blank commercial-source validation remained effective and no source was invented. This downloaded Draft checksum is not represented as a retained issued-artifact checksum.

Two separately reviewed controlled emails were then sent through the native Stage UI: one existing fictional issued statement and one published fictional HLE revision through its separate outbox. Each new durable record has exactly one `provider_queued` attempt; fresh SQL preserved finance and exact frozen hashes. Both unique messages were observed in the controlled owner inbox with SPF/DKIM/DMARC passes. Original downloaded attachment bytes matched the 12,873-byte statement and 13,121-byte HLE hashes. Both new records were stopped for future attempts; follow-ups and scheduled Sending remained off. Historical consumed/simulated records were not replayed. This proves these two deliveries, not human reading, client receipt, legal acceptance or payment.

Actual existing-owner Google proof and explicitly approved versioned legal acknowledgments reached protected Dashboards in both environments before image promotion. After PROD 22 converged, authenticated Dashboard, Billing and Clients rendered without business writes. These observations do not replace the remaining provider/session lifecycle tests or constitute human product acceptance. An existing Sandbox account's fresh status read preserved its access and prior cancellation setting; it did not create a checkout, charge, cancellation or renewal event.

One real Stage 53 scheduled Worker invocation was observed at **2026-10-27 02:17:27.037 UTC**, with exact Worker-version match and outcome `ok`. The bounded observer ended normally. This is invocation evidence, not evidence of durable business effects or Sending dispatch. The earlier PROD observation remained inconclusive and is not interpreted as nonexecution.

## Remaining capability evidence

The remaining UNKNOWN leaves are C02, C20, C22, C23, C28 and C29:

- **C02:** Remaining actual GitHub/managed-email proof and selected registered-session lifecycle. Existing-owner Google proof and explicit acknowledgment are already observed.
- **C20:** Actual inbound provider capture, trusted routing and exact attachment/tenant receipt.
- **C22:** A real supported assistant-host lifecycle with controlled owners, scopes, refresh/revoke, cross-owner denial and selected financial confirmation.
- **C23:** Actual Sandbox checkout, selected 3DS, renewal/failure/grace and reconciliation/effective cancellation transitions. Catalog, status and current impact reads are partial evidence.
- **C28:** Adopted recovery objectives/custody, off-host or new-device/provider-loss recovery, matched-host sustained capacity, remaining PROD scheduled invocation and selected business effects.
- **C29:** Actual contact CAPTCHA/provider/inbox delivery. The form was inspected but not submitted; independent live metadata confirms contact delivery is disabled with no email binding. That effective mode was preserved, and no user approval is pending.

[EXTERNAL-PENDING.json](EXTERNAL-PENDING.json) records each observed portion and the precise missing prerequisite. No production activation, live payment, invented external proof, unsolicited client send, historical financial rewrite or full PH3 acceptance is implied.

This packet contains only bounded derived evidence. Product source, private documents, recipient identities, business UUIDs, screenshots, credentials and original operational receipts remain outside it. `MANIFEST.sha256` binds the exact published files. Reproduce the evidence-policy calculation with `python repro/calculate_score.py --check` from this folder; the historical contract and calculator are byte-identical.
