# Code Fix Prompt

Fix the requested issue with one-change-one-proof.

Rules:

- Prove repo, branch, dirty tree, runtime target, and scope first.
- Inspect only the smallest relevant files.
- Preserve user work and existing patterns.
- Make the narrowest safe change.
- Run the smallest relevant test, typecheck, build, or smoke check.
- Do not include adjacent fixes unless required to unblock this claim.

Report:

- changed files
- check command and result
- verified claim
- not-run checks
- residual risk
- next smallest lane
