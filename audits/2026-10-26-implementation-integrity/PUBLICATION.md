# Public package custody

This package is a derived, text-only publication. Raw logs, exact local argv paths, rendered synthetic PDFs/PNGs, databases, temporary TLS keys and installed dependencies remain outside this repository. No private application source is copied.

Machine paths are aliased as <AUDIT_ROOT>, <SOURCE_ROOT>, <DOCUMENTATION_ROOT>, <WORKSPACE_ROOT>, <USER_HOME>, <POSTGRES_BIN>, <NODE_BIN> and <BROWSER_EXECUTABLE>. Published receipts preserve command structure, times, status and numerical outcomes; they are not byte-identical to raw receipts after deidentification. Source-file snapshot hashes remain hashes of the evaluated bytes.

Before running machine-bound reproduction templates, substitute aliases in a separate working copy with your explicit disposable locations. The evaluator and financial logic remain unchanged. calculate_score.py is directly portable and checks the published matrix against its frozen contract. Synthetic test configuration constants in repro code are test inputs, not hosted credentials.

No PDF/PNG was published. Extracted synthetic totals, hashes and the recorded visual-inspection result provide the public evidence; originals remain in local audit custody. Scripts referring to those raw outputs explain how to regenerate them in an isolated environment.

Public text uses canonical LF and removes trailing transport whitespace. Raw evidence retains its original whitespace outside the public repository. This representation change does not change measured outcomes; the publication manifest seals the actual Git blob bytes.

## XML publication correction — 2026-10-26

PUB-01 repairs only the serialization of the two invalid derived JUnit documents.
The actual publisher now parses original XML, sanitizes text/tail/attribute values,
serializes, and reparses before writing. Literal path aliases remain escaped text.
The portable helper and its five regressions are under repro/. All nine derived
XML files parse; testcase identity, status, structure and recorded counts match
their valid originals. The 2 AUDIT_ROOT and 65 USER_HOME aliases are escaped.
The two repaired XML files are an exception to the historical trailing-whitespace
normalization above: they preserve all sanitized original decoded text, tail and
attribute values, including log whitespace. The other seven XML files retain
their historical published bytes.
Original evidence, historical failures, scores and product source are unchanged.
See PUB01-REPAIR.json for exact original/derived hashes and the publisher change.
