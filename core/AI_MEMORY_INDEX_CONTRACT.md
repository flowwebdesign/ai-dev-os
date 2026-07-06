# AI Memory Index Contract

The AI memory index is the first project file agents read when it exists.

Its job is to route work, not to replace proof. Keep it short enough to load on every lane, and use it to point agents to deeper files only when the current task needs them.

Required rule:

“Load the index first. Load deeper files only when the task classifier, proof requirement, or active risk points to them.”

## Required Sections

- Read Order
- Project Identity
- Ownership Map
- Runtime Map
- Current Active State
- Proof Boundaries
- Fast Stop Conditions
- Deeper Files To Load By Task
- Last Updated

## Maintenance

Update the index when project identity, runtime targets, ownership, active lanes, proof boundaries, or stop conditions change.

Do not place secrets in the index. Do not treat old index content as proof when Git, runtime, API, database, or browser evidence disagrees.
