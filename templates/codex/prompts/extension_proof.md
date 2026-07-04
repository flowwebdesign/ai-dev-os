# Extension Proof Prompt

Prove the requested browser extension behaviour.

Required proof chain:

1. Confirm extension folder, manifest, build/source identity, and active browser profile.
2. Confirm the page URL and app bridge target.
3. Confirm session identity if the extension writes or reads private data.
4. Trigger the extension action.
5. Check content script, background/service worker, bridge/API, persisted state, and visible page effect as relevant.
6. Reload and read back the result.

Stop if the active extension folder or browser profile cannot be proven.
