# Browser Proof Prompt

Prove the requested browser-facing behaviour.

Required proof chain:

1. Confirm target URL, runtime, route, branch/source identity, and browser profile.
2. Confirm expected user/session identity before writes.
3. Perform the user action in the browser.
4. Check the relevant API/network boundary where possible.
5. Confirm persisted state.
6. Reload or revisit and read back the user-visible state.

Stop if the browser profile, runtime, route, or identity is wrong.
