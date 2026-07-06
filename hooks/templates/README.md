# Hook Templates

Run from a project root unless a script says otherwise.

Examples:

```sh
hooks/templates/preflight.sh https://github.com/flowwebdesign/ai-dev-os
hooks/templates/evidence_capture.sh _agent_runs/run-001 "build passed"
hooks/templates/stop_check.sh _agent_runs/run-001
```

PowerShell:

```powershell
.\hooks\templates\preflight.ps1 -ExpectedRemote https://github.com/flowwebdesign/ai-dev-os
.\hooks\templates\evidence_capture.ps1 -RunDir _agent_runs\run-001 -Message "build passed"
.\hooks\templates\stop_check.ps1 -RunDir _agent_runs\run-001
```
