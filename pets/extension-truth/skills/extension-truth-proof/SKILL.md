# Extension Truth Proof Skill

Use this skill for extension, content-script, service-worker, app-bridge, or extension `appUrl` claims.

## Goal

Prove that the active extension is the intended source and that its payload reaches the intended app/runtime boundary.

## Steps

1. Record extension folder and manifest/source identity.
2. Record active browser profile.
3. Record configured `appUrl`.
4. Record target page URL and route.
5. Confirm bootstrap/session state if private reads or writes are involved.
6. Trigger the extension action.
7. Check bridge/API/payload boundary.
8. Check app/backend effect and persistence where relevant.
9. Reload/read back and record visible result where relevant.
10. List missing proof links.

## Output

```text
Extension folder:
Manifest/source identity:
Browser profile:
appUrl:
Target route:
Bootstrap/session:
Action:
Payload/API boundary:
Persistence/readback:
Visible result:
Not proven:
Proof label:
```

