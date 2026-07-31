param(
    [Parameter(Position = 0)]
    [string]$Command = "help",
    [Parameter(Position = 1)]
    [string]$TargetArg = "",
    [string]$Profile = "",
    [switch]$Detect,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$AiDevOsHome = Split-Path -Parent $ScriptDir

function Find-SourceDir {
    $localInstall = Join-Path $AiDevOsHome "install.ps1"
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
    Write-Host "                   Options: -Profile <name>, -Detect"
    Write-Host "                   Also accepts: --profile <name>, --detect"
    Write-Host "  attach [options] [path]"
    Write-Host "                   Alias for init"
    Write-Host "  check [path]     Check required .ai-dev files, default ."
    Write-Host "  doctor [path]    Check global install and project health, default ."
    Write-Host "  version          Print installed version"
    Write-Host "  help             Show this help"
}

function Get-CommandArgs {
    $items = @()
    if ($TargetArg) {
        $items += $TargetArg
    }
    if ($RemainingArgs) {
        $items += $RemainingArgs
    }
    return @($items)
}

function Get-TargetArg {
    $commandArgs = @(Get-CommandArgs)
    if ($commandArgs.Count -gt 0) {
        return [string]$commandArgs[0]
    }
    return "."
}

function Parse-InitArgs {
    param([string[]]$InputArgs)

    $result = @{
        Target = "."
        Profile = ""
        Detect = $false
    }

    $i = 0
    while ($i -lt $InputArgs.Count) {
        $arg = $InputArgs[$i]
        if ($arg -in @("--profile", "-Profile")) {
            $i++
            if ($i -ge $InputArgs.Count -or -not $InputArgs[$i]) {
                Write-Host "STOP -Profile requires a value"
                exit 1
            }
            $result.Profile = $InputArgs[$i]
        } elseif ($arg -in @("--detect", "-Detect")) {
            $result.Detect = $true
        } elseif ($arg -in @("-h", "--help", "-Help")) {
            Show-Help
            exit 0
        } elseif ($arg.StartsWith("-")) {
            Write-Host "STOP unknown init option: $arg"
            exit 1
        } else {
            $result.Target = $arg
        }
        $i++
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

    $branch = try {
        $value = & git -C $Target branch --show-current 2>$null
        if ($LASTEXITCODE -eq 0) { $value } else { "" }
    } catch {
        ""
    }
    $remote = try {
        $value = & git -C $Target remote get-url origin 2>$null
        if ($LASTEXITCODE -eq 0) { $value } else { "" }
    } catch {
        ""
    }
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
        exit 0
    }
    { $_ -in @("version", "--version") } {
        $version = Join-Path $AiDevOsHome "VERSION"
        if (Test-Path -LiteralPath $version) {
            Get-Content -LiteralPath $version
        } else {
            $sourceDir = Find-SourceDir
            $gitVersion = try {
                $value = & git -C $sourceDir rev-parse --short HEAD 2>$null
                if ($LASTEXITCODE -eq 0) { $value } else { "unknown" }
            } catch {
                "unknown"
            }
            Write-Host $gitVersion
        }
        exit 0
    }
    { $_ -in @("init", "attach") } {
        $commandArgs = @(Get-CommandArgs)
        $parsed = Parse-InitArgs -InputArgs $commandArgs
        if ($Profile) {
            $parsed.Profile = $Profile
        }
        if ($Detect) {
            $parsed.Detect = $true
        }
        $sourceDir = Find-SourceDir
        & (Join-Path $sourceDir "install.ps1") -Project -TargetDir $parsed.Target
        Write-CliProfile -Target $parsed.Target -Profile $parsed.Profile -Detect $parsed.Detect
        exit 0
    }
    "check" {
        $TargetDir = Get-TargetArg
        $installedCheck = Join-Path $AiDevOsHome "bin/ai-dev-os-check.ps1"
        if (Test-Path -LiteralPath $installedCheck) {
            & $installedCheck -TargetDir $TargetDir
            exit $LASTEXITCODE
        } else {
            $sourceDir = Find-SourceDir
            & (Join-Path $sourceDir "scripts/ai-dev-os-check.ps1") -TargetDir $TargetDir
            exit $LASTEXITCODE
        }
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

        if (-not (Test-Path -LiteralPath (Join-Path $TargetDir ".ai-dev"))) {
            Write-Host "WARN project check skipped: target has no .ai-dev; run init explicitly when this is a project"
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
