# Proof Matrix

This file defines generic proof levels. Use `PROOF_REQUIREMENTS.md` for project-specific requirements, overrides, and release gates.

| Proof Level | What It Proves | What It Does Not Prove | When Required |
| --- | --- | --- | --- |
| Static inspection | Relevant files, configuration, and code paths exist and match the stated claim. | Runtime behavior, integration behavior, persisted state, or user-visible behavior. | Before any edit, before broad testing, and when classifying scope or risk. |
| Unit test | A small function, module, or isolated rule behaves as expected under test inputs. | Wiring through APIs, browsers, databases, provider calls, or deployment. | For logic changes, validators, parsers, calculations, and regressions that can be isolated. |
| Integration/API test | A service boundary or API route works with its expected dependencies or test doubles. | Full browser behavior, extension behavior, hosted infrastructure, or real provider quality. | For backend routes, persistence flows, cross-module contracts, and service integration claims. |
| Component/jsdom test | UI component logic, rendering branches, and event handling work in a simulated DOM. | Real browser layout, network behavior, extension APIs, downloads, or accessibility across actual engines. | For frontend component changes where browser proof is not yet required. |
| Real browser route proof | A real browser can load the route and show the expected user-visible state after the relevant action. | Hosted parity, extension APIs, persisted backend state unless separately read back, or provider quality. | For learner-facing UI, dashboard flows, screenshots, layout claims, and route-level release checks. |
| Extension proof | The unpacked or packaged extension runs in the intended browser profile with the expected manifest, permissions, storage, and target URLs. | Hosted backend readiness, store approval, or product source correctness outside the extension boundary. | For browser extension flows, Chrome store package checks, content scripts, panel behavior, and app-bridge identity. |
| Hosted proof | The deployed hosted target serves the expected route/API behavior and is not accidentally calling localhost or stale infrastructure. | Local-only behavior, future deploys, account safety beyond the checked identity, or real paid-provider quality. | For staging, beta, production, release-control, and customer-facing deployment claims. |
| Real provider paid proof | A real paid provider call completed under an explicit budget and ledger boundary, with output quality and readback checked. | General product readiness, hosted readiness, or future cost behavior outside the tested request. | For AI, search, TTS, embeddings, scraping, or any paid service claim. |
| Release candidate proof | The release candidate has source, build, runtime, identity, persistence, hosted, provider, rollback, and user-visible evidence required by the project. | Approval to release, unless the release owner explicitly accepts the remaining risks. | Before recommending a release, client handoff, store submission, or production promotion. |

## Labels

- `verified` - the required boundaries for the claim were checked.
- `partial` - meaningful evidence exists, but at least one required boundary is missing.
- `smoke` - quick signal only.
- `not_run` - no current check.
- `blocked` - stopped at a named failing boundary.

## Boundary Rule

Do not claim a result as verified from one signal alone. Map each claim to the relevant action, API or network boundary, persisted state, reload or readback, and user-visible state.
