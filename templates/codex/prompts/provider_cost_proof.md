# Provider Cost Proof Prompt

Use this when AI, search, TTS, embeddings, scraping, or another paid provider may be called.

Before calling:

- name provider
- name mock or real mode
- confirm budget
- confirm ledger location
- confirm target runtime
- confirm whether cached output is allowed

After calling:

- record call evidence without exposing secrets
- record cost or usage if available
- verify persisted output
- perform quality/readback proof
- report any partial or not-run checks

Stop if budget, provider mode, or ledger is missing.
