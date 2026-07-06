# Profile Matrix Proof

Profiles turn one generic install into a project-specific starting mode.

The current profile layer records the requested profile in `.ai-dev/CLI_PROFILE.md`. It does not pretend to change behavior that has not been implemented yet.

Profile proof means checking the full matrix:

- minimal
- standard
- serious
- serious with detect

For each profile, prove:

- `ai-dev-os init` exits successfully
- `.ai-dev/AI_MEMORY_INDEX.md` exists
- `.ai-dev/PROOF_MATRIX.md` exists
- `.ai-dev/CLI_PROFILE.md` records the expected profile
- `ai-dev-os check` exits successfully, even if it reports warnings
- `ai-dev-os doctor` reports global and project health

Mistakes prevented:

- assuming one successful profile proves every profile
- treating a parsed option as real behavior without readback
- hiding warnings behind a broad success claim

Exercise: create four temporary repos and run the profile matrix. Write which warnings are expected and which would be blockers. A fresh serious-profile project should include `.ai-dev/PROOF_MATRIX.md`; missing it is a template or update mismatch.

Client offer angle: use profile matrices to sell a controlled AI onboarding path: light controls for small prototypes, stronger controls for client or release work, and detect mode for project discovery.
