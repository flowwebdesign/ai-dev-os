# Extension Truth Fragment

Extension proof requires a full chain, not just visible UI.

Required behavior:

- Prove extension folder and manifest/source identity.
- Prove active browser profile.
- Prove configured `appUrl`.
- Prove bootstrap/session state where relevant.
- Prove payload route through extension action, bridge/API, app/backend effect, persistence/readback, and visible result as applicable.
- List any missing link in `Not Proven`.

Stop if the active extension folder or browser profile cannot be proven.

