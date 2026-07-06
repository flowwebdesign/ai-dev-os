param(
    [string]$TargetDir = "."
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$resolvedTarget = Resolve-Path -LiteralPath $TargetDir
$dest = Join-Path $resolvedTarget ".ai-dev/hooks"

if (-not (Test-Path -LiteralPath $dest)) {
    New-Item -ItemType Directory -Path $dest | Out-Null
}

Copy-Item -LiteralPath (Join-Path $ScriptDir "templates/preflight.ps1") -Destination (Join-Path $dest "preflight.ps1")
Copy-Item -LiteralPath (Join-Path $ScriptDir "templates/stop_check.ps1") -Destination (Join-Path $dest "stop_check.ps1")
Copy-Item -LiteralPath (Join-Path $ScriptDir "templates/evidence_capture.ps1") -Destination (Join-Path $dest "evidence_capture.ps1")
Write-Host "PASS installed hook templates in $dest"
