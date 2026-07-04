# Release Ledger Fragment

Before release, deploy, handoff, or multi-lane claims, reconcile current truth.

Required behavior:

- Read existing ledger, manifest, branch registry, source map, and run-card templates when present.
- Treat pasted summaries as last-known context only.
- Reconcile summaries with Git, runtime, and evidence.
- Produce a run card and final report for release or handoff lanes.
- Include not proven, blockers, risks, checks run, and next smallest lane.

Never call a release candidate ready without traceable source, runtime, proof, and gap records.

