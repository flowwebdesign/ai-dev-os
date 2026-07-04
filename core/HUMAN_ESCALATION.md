# Human Escalation

Stop and ask for human direction when continuing would risk data, money, access, user trust, or unrelated work.

## Escalate Immediately

- requested target repo or branch cannot be proven
- dirty user work blocks the lane
- production mutation is possible and approval is missing
- logged-in identity does not match the requested user or role
- provider call may incur cost and budget/mode is not explicit
- destructive command is needed
- deployment source identity cannot be proven
- secret, credential, or private data access is needed beyond scope
- tests require credentials or accounts the agent does not have

## Report Format

```text
Blocked at:
Why it matters:
Evidence:
Safest next choice:
```

Do not compensate for a failed boundary with guesses or adjacent fixes.
