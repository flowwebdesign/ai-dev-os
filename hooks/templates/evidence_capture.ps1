param(
    [Parameter(Mandatory = $true)]
    [string]$RunDir,
    [Parameter(Mandatory = $true)]
    [string]$Message
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $RunDir)) {
    New-Item -ItemType Directory -Path $RunDir | Out-Null
}

$log = Join-Path $RunDir "EVIDENCE.log"
$stamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
Add-Content -LiteralPath $log -Value "$stamp $Message"
Write-Host "PASS appended $log"
