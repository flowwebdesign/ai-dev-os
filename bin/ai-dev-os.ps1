param(
    [string]$Command = "help",
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
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
    Write-Host "  init [options] [path]"
    Write-Host "                   Install .ai-dev project files into path, default ."
    Write-Host "                   Options: --profile <name>, --detect"
    Write-Host "  attach [options] [path]"
    Write-Host "                   Alias for init"
    Write-Host "  check [path]     Check required .ai-dev files, default ."
    Write-Host "  doctor [path]    Check global install and project health, default ."
    Write-Host "  version          Print installed version"
    Write-Host "  help             Show this help"
}

function Get-TargetArg {
    if ($RemainingArgs -and $RemainingArgs.Count -gt 0) {
        return $RemainingArgs[0]
    }
    return "."
}

function Parse-InitArgs {
    param([string[]]$Args)

    $result = @{
        Target = "."
        Profile = ""
        Detect = $false
    }

    for ($i = 0; $i -lt $Args.Count; $i++) {
        switch ($Args[$i]) {
            "--profile" {
                $i++
                if ($i -ge $Args.Count -or -not $Args[$i]) {
                    Write-Host "STOP --profile requires a value"
                    exit 1
                }
                $result.Profile = $Args[$i]
            }
            "--detect" {
                $result.Detect = $true
            }
            { $_ -in @("-h", "--help") } {
                Show-Help
                exit 0
            }
            { $_.StartsWith("-") } {
                Write-Host "STOP unknown init option: $_"
                exit 1
            }
            default {
                $result.Target = $Args[$i]
            }
        }
    }

    return $result
}

function Write-CliProfile {
    param(
        [string]$Target,
        [string]$Profile,
        [bool]$Detect
    )

    if (-not $Profile -and -not $Detect) {
        return
    }

    $aiDevDir = Join-Path $Target ".ai-dev"
    if (-not (Test-Path -LiteralPath $aiDevDir)) {
        Write-Host "STOP missing $aiDevDir after init"
        exit 1
    }

    $branch = git -C $Target branch --show-current 2>$null
    $remote = git -C $Target remote get-url origin 2>$null
    if (-not $branch) { $branch = "unknown" }
    if (-not $remote) { $remote = "none" }
    if (-not $Profile) { $Profile = "default" }

    $targetFile = Join-Path $aiDevDir "CLI_PROFILE.md"
    @(
        "# AI Dev OS CLI Profile",
        "",
        "- Profile: $Profile",
        "- Detect requested: $Detect",
        "- Git branch: $branch",
        "- Git remote: $remote"
    ) | Set-Content -LiteralPath $targetFile
    Write-Host "create $targetFile"
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
        $parsed = Parse-InitArgs -Args $RemainingArgs
        $sourceDir = Find-SourceDir
        & (Join-Path $sourceDir "install.ps1") -TargetDir $parsed.Target
        Write-CliProfile -Target $parsed.Target -Profile $parsed.Profile -Detect $parsed.Detect
        break
    }
    "check" {
        $TargetDir = Get-TargetArg
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
        $TargetDir = Get-TargetArg
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

        if (-not (Test-Path -LiteralPath (Join-Path $TargetDir ".git")) -and -not (Test-Path -LiteralPath (Join-Path $TargetDir ".ai-dev"))) {
            Write-Host "WARN project check skipped: target is not a git repo and has no .ai-dev"
            Write-Host "SUMMARY WARN"
            exit 0
        }

        $checkOutput = & $MyInvocation.MyCommand.Path check $TargetDir 2>&1
        $checkExit = $LASTEXITCODE
        $checkOutput | Where-Object { $_ -notmatch "^SUMMARY " }
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
