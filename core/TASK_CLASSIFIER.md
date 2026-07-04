# Task Classifier

Classify the lane before doing work. Use the class to choose proof depth and stop conditions.

## Classes

| Class | Description | Default Proof |
| --- | --- | --- |
| `docs_only` | Markdown, comments, prompts, templates, or copy that does not change runtime behaviour. | Link/readback changed files and run lightweight lint if available. |
| `source_fix` | Code change inside an existing behaviour boundary. | Focused test, typecheck, build, or runtime smoke tied to the changed area. |
| `browser_proof` | UI behaviour, routes, forms, extension surfaces, or visual state. | Browser action plus network/persistence/reload/readback as needed. |
| `provider_cost` | AI/search/TTS/embeddings/scraping/paid service calls. | Mode, budget, ledger, call evidence, persisted output, quality/readback. |
| `release` | RC, deploy, publish, migration, or production-impacting work. | Release ledger, source map, required checks, rollback or blocker statement. |
| `forensic` | Repeated failures, frustration, unclear truth, or conflicting evidence. | Current-state inventory before more edits. |

## Decision Questions

1. What exact claim will be true when this lane is done?
2. Which repo, branch, runtime, identity, and provider mode does the claim depend on?
3. What is the smallest action that can prove or falsify it?
4. What must not be touched?
5. What is the first stop condition?

If the answer is unclear, do a read-only inventory before implementing.
