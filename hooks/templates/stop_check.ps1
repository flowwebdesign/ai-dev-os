param(
    [Parameter(Mandatory = $true)]
    [string]$RunDir
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $RunDir -PathType Container)) {
    Write-Host "STOP run folder not found: $RunDir"
    exit 1
}

foreach ($file in @("FINAL_REPORT.md", "RUN_CARD.json", "VERIFICATION.txt")) {
    $path = Join-Path $RunDir $file
    if (-not (Test-Path -LiteralPath $path) -or (Get-Item -LiteralPath $path).Length -eq 0) {
        Write-Host "STOP missing or empty $path"
        exit 1
    }
}

Write-Host "PASS final report, run card, and verification file exist"
