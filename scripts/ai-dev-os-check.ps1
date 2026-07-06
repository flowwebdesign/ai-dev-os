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

function Get-GitLines {
    param([string[]]$GitArgs)

    try {
        $output = & git -C $TargetDir @GitArgs 2>$null
        if ($LASTEXITCODE -ne 0 -or -not $output) {
            return @()
        }
        return @($output)
    } catch {
        return @()
    }
}

if (-not (Test-Path -LiteralPath (Join-Path $TargetDir ".git"))) {
    Write-Host "STOP git repo not found at $TargetDir"
    $stop = $true
} else {
    Write-Host "PASS git repo found"
    $remote = Get-GitLines @("remote", "get-url", "origin")
    $branch = Get-GitLines @("branch", "--show-current")
    if (-not $remote) { $remote = @("none") }
    if (-not $branch) { $branch = @("unknown") }
    Write-Host "INFO remote=$($remote -join ' ')"
    Write-Host "INFO branch=$($branch -join ' ')"
    $dirty = Get-GitLines @("status", "--short")
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

$proofMatrixPath = Join-Path $aiDevDir "PROOF_MATRIX.md"
if ((Test-Path -LiteralPath $proofMatrixPath) -and ((Get-Item -LiteralPath $proofMatrixPath).Length -gt 0)) {
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
