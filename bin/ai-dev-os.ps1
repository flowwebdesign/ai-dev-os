param(
    [string]$Command = "help",
    [string]$TargetDir = "."
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$AiDevOsHome = Split-Path -Parent $ScriptDir

function Find-SourceDir {
    $localInstall = Join-Path $AiDevOsHome "install.sh"
    if (Test-Path -LiteralPath $localInstall) {
        return $AiDevOsHome
    }

    $manifest = Join-Path $AiDevOsHome "manifest.json"
    if (Test-Path -LiteralPath $manifest) {
        $json = Get-Content -LiteralPath $manifest -Raw | ConvertFrom-Json
        if ($json.installed_from -and (Test-Path -LiteralPath (Join-Path $json.installed_from "install.ps1"))) {
            return $json.installed_from
        }
    }

    Write-Error "STOP cannot locate AI Dev OS source install.ps1"
}

function Show-Help {
    Write-Host "Usage: ai-dev-os.ps1 <command> [path]"
    Write-Host ""
    Write-Host "Commands:"
    Write-Host "  init [path]      Install .ai-dev project files into path, default ."
    Write-Host "  attach [path]    Alias for init"
    Write-Host "  check [path]     Check required .ai-dev files, default ."
    Write-Host "  doctor [path]    Check global install and project health, default ."
    Write-Host "  version          Print installed version"
    Write-Host "  help             Show this help"
}

switch ($Command) {
    { $_ -in @("help", "-h", "--help") } {
        Show-Help
        break
    }
    { $_ -in @("version", "--version") } {
        $version = Join-Path $AiDevOsHome "VERSION"
        if (Test-Path -LiteralPath $version) {
            Get-Content -LiteralPath $version
        } else {
            Write-Host "unknown"
        }
        break
    }
    { $_ -in @("init", "attach") } {
        $sourceDir = Find-SourceDir
        & (Join-Path $sourceDir "install.ps1") -TargetDir $TargetDir
        break
    }
    "check" {
        $installedCheck = Join-Path $AiDevOsHome "bin/ai-dev-os-check.ps1"
        if (Test-Path -LiteralPath $installedCheck) {
            & $installedCheck -TargetDir $TargetDir
        } else {
            $sourceDir = Find-SourceDir
            & (Join-Path $sourceDir "scripts/ai-dev-os-check.ps1") -TargetDir $TargetDir
        }
        break
    }
    "doctor" {
        $warn = $false
        if (Test-Path -LiteralPath $AiDevOsHome) {
            Write-Host "PASS ai-dev-os home=$AiDevOsHome"
        } else {
            Write-Host "WARN ai-dev-os home not found: $AiDevOsHome"
            $warn = $true
        }

        if (Test-Path -LiteralPath (Join-Path $AiDevOsHome "manifest.json")) {
            Write-Host "PASS manifest=$(Join-Path $AiDevOsHome "manifest.json")"
        } else {
            Write-Host "WARN manifest missing"
            $warn = $true
        }

        if (Test-Path -LiteralPath (Join-Path $HOME ".codex/AGENTS.md")) {
            Write-Host "PASS codex agents=$(Join-Path $HOME ".codex/AGENTS.md")"
        } else {
            Write-Host "WARN codex agents missing"
            $warn = $true
        }

        if (-not (Test-Path -LiteralPath $TargetDir)) {
            Write-Host "STOP target not found: $TargetDir"
            exit 1
        }
        Write-Host "PASS target=$TargetDir"

        $checkOutput = & $MyInvocation.MyCommand.Path check $TargetDir 2>&1
        $checkExit = $LASTEXITCODE
        $checkOutput
        if ($checkExit -ne 0) {
            Write-Host "SUMMARY STOP"
            exit 1
        }
        if ($checkOutput -match "SUMMARY WARN") {
            $warn = $true
        }

        if ($warn) {
            Write-Host "SUMMARY WARN"
        } else {
            Write-Host "SUMMARY PASS"
        }
        exit 0
    }
    default {
        Write-Host "STOP unknown command: $Command"
        Show-Help
        exit 1
    }
}
