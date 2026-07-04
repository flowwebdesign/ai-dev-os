# Fixture vs Live Proof Skill

Use this skill before claims involving fixtures, live providers, mocks, external APIs, or paid services.

## Goal

Prove whether the lane uses fixture, live, auto, mock provider, or real provider mode before reporting results.

## Steps

1. Record target runtime.
2. Record configured mode.
3. If mode is `auto`, resolve and record the actual mode.
4. Record provider identity.
5. Record cost flags, budget, and cache policy.
6. Record ledger or run-card path.
7. If a call is made, record non-secret call evidence.
8. Verify persisted output and readback where relevant.
9. Label fixture/live gaps.

## Output

```text
Runtime:
Mode:
Resolved mode:
Provider:
Cost flags:
Budget:
Cache policy:
Ledger/run card:
Call evidence:
Readback:
Not proven:
Proof label:
```

