# Future Project State Server

## Purpose

Expose `.ai-dev/` project state through MCP so agents can fetch current context without broad file scans.

## Candidate Resources

- `project://context`
- `project://rules`
- `project://active-state`
- `project://proof-requirements`
- `project://branch-registry`
- `project://deploy-source-map`
- `project://release-ledger/latest`

## Candidate Tools

- `classify_task`
- `check_truth_gate`
- `map_claim_to_proof`
- `append_release_ledger`
- `create_run_card`

## Guardrails

- Read-only by default.
- Append-only ledger writes.
- No secret exposure.
- No deployment or destructive mutation.
- Every response includes freshness metadata.
