param(
    [string]$TargetDir = "."
)

$ErrorActionPreference = "Stop"
$aiDevDir = Join-Path $TargetDir ".ai-dev"
$stop = $false
$warn = $false

function Check-File {
    param([string]$Name)
    $path = Join-Path $aiDevDir $Name
    if (Test-Path -LiteralPath $path) {
        Write-Host "PASS .ai-dev/$Name"
    } else {
        Write-Host "STOP missing .ai-dev/$Name"
        $script:stop = $true
    }
}

if (-not (Test-Path -LiteralPath (Join-Path $TargetDir ".git"))) {
    Write-Host "STOP git repo not found at $TargetDir"
    $stop = $true
} else {
    Write-Host "PASS git repo found"
    Write-Host "INFO remote=$(git -C $TargetDir remote get-url origin 2>$null)"
    Write-Host "INFO branch=$(git -C $TargetDir branch --show-current 2>$null)"
    $dirty = git -C $TargetDir status --short 2>$null
    if ($dirty) {
        Write-Host "WARN dirty tree"
        $dirty
        $warn = $true
    } else {
        Write-Host "PASS clean tracked tree"
    }
}

Check-File "AI_MEMORY_INDEX.md"
Check-File "PROJECT_CONTEXT.md"
Check-File "ACTIVE_STATE.md"
Check-File "PROOF_REQUIREMENTS.md"
Check-File "RELEASE_LEDGER.jsonl"

if (Test-Path -LiteralPath (Join-Path $aiDevDir "PROOF_MATRIX.md")) {
    Write-Host "PASS .ai-dev/PROOF_MATRIX.md"
} else {
    Write-Host "WARN proof matrix missing"
    $warn = $true
}

if ($stop) {
    Write-Host "SUMMARY STOP"
    exit 1
}

if ($warn) {
    Write-Host "SUMMARY WARN"
} else {
    Write-Host "SUMMARY PASS"
}
