param(
    [string]$TargetDir = ".",
    [Alias("Global")]
    [switch]$InstallGlobal,
    [switch]$InstallCodexHome,
    [switch]$Project,
    [switch]$Force,
    [switch]$Help
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Show-Help {
    Write-Host "Usage: .\install.ps1 [-InstallCodexHome|-Global] [-Project] [-TargetDir <path>] [-Force]"
    Write-Host ""
    Write-Host "Default: install global CLI and Codex home bootstrap only."
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -InstallCodexHome  Install `$HOME\.ai-dev-os and install or preserve `$HOME\.codex\AGENTS.md."
    Write-Host "  -Global            Alias for global install and Codex home bootstrap."
    Write-Host "  -Project           Install .ai-dev project files into -TargetDir."
    Write-Host "  -TargetDir <path>  Project target used only with -Project. Default ."
    Write-Host "  -Force             Backup and replace existing Codex AGENTS.md."
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\install.ps1 -InstallCodexHome"
    Write-Host "  .\install.ps1 -InstallCodexHome -Force"
    Write-Host "  .\install.ps1 -Project -TargetDir C:\path\to\project"
    Write-Host "  cd C:\path\to\project"
    Write-Host "  ai-dev-os.ps1 init -Profile serious -Detect"
}

function Copy-IfMissing {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (Test-Path -LiteralPath $Destination) {
        Write-Host "skip existing $Destination"
        return
    }

    Copy-Item -LiteralPath $Source -Destination $Destination
    Write-Host "create $Destination"
}

function Copy-WithOptionalForce {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (Test-Path -LiteralPath $Destination) {
        if (-not $Force) {
            Write-Host "skip existing $Destination"
            return
        }

        $stamp = Get-Date -Format "yyyyMMddHHmmss"
        $backup = "$Destination.backup.$stamp"
        Copy-Item -LiteralPath $Destination -Destination $backup
        Write-Host "backup $backup"
    }

    Copy-Item -LiteralPath $Source -Destination $Destination
    Write-Host "create $Destination"
}

if ($Help) {
    Show-Help
    exit 0
}

$doGlobalInstall = $InstallGlobal -or $InstallCodexHome -or (-not $Project)
$doCodexHomeInstall = $InstallGlobal -or $InstallCodexHome -or (-not $Project)

if ($doGlobalInstall) {
    Write-Host "GLOBAL INSTALL"
    $aiDevOsHome = if ($env:AI_DEV_OS_HOME) { $env:AI_DEV_OS_HOME } else { Join-Path $HOME ".ai-dev-os" }
    $aiDevOsBin = Join-Path $aiDevOsHome "bin"
    if (-not (Test-Path -LiteralPath $aiDevOsBin)) {
        New-Item -ItemType Directory -Path $aiDevOsBin | Out-Null
    }

    Copy-Item -LiteralPath (Join-Path $ScriptDir "bin/ai-dev-os") -Destination (Join-Path $aiDevOsBin "ai-dev-os")
    Copy-Item -LiteralPath (Join-Path $ScriptDir "bin/ai-dev-os.ps1") -Destination (Join-Path $aiDevOsBin "ai-dev-os.ps1")
    Copy-Item -LiteralPath (Join-Path $ScriptDir "scripts/ai-dev-os-check.sh") -Destination (Join-Path $aiDevOsBin "ai-dev-os-check.sh")
    Copy-Item -LiteralPath (Join-Path $ScriptDir "scripts/ai-dev-os-check.ps1") -Destination (Join-Path $aiDevOsBin "ai-dev-os-check.ps1")

    $version = try { git -C $ScriptDir rev-parse --short HEAD 2>$null } catch { "unknown" }
    if (-not $version) { $version = "unknown" }
    Set-Content -LiteralPath (Join-Path $aiDevOsHome "VERSION") -Value $version
    @{
        name = "ai-dev-os"
        version = $version
        installed_from = $ScriptDir
    } | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $aiDevOsHome "manifest.json")

    Write-Host "AI Dev OS global files installed in $aiDevOsHome"
}

if ($doCodexHomeInstall) {
    Write-Host "CODEX HOME INSTALL"
    $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
    if (-not (Test-Path -LiteralPath $codexHome)) {
        New-Item -ItemType Directory -Path $codexHome | Out-Null
    }

    Copy-WithOptionalForce (Join-Path $ScriptDir "templates/codex-home/AGENTS.md") (Join-Path $codexHome "AGENTS.md")
    Write-Host "Codex Home Bootstrap installed in $codexHome"
}

if ($Project) {
    Write-Host "PROJECT INIT"
    $resolvedTarget = Resolve-Path -LiteralPath $TargetDir
    $aiDevDir = Join-Path $resolvedTarget ".ai-dev"

    if (-not (Test-Path -LiteralPath $aiDevDir)) {
        New-Item -ItemType Directory -Path $aiDevDir | Out-Null
    }

    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/AI_MEMORY_INDEX.md") (Join-Path $aiDevDir "AI_MEMORY_INDEX.md")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/PROJECT_CONTEXT.md") (Join-Path $aiDevDir "PROJECT_CONTEXT.md")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/PROJECT_RULES.md") (Join-Path $aiDevDir "PROJECT_RULES.md")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/ACTIVE_STATE.md") (Join-Path $aiDevDir "ACTIVE_STATE.md")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/PROOF_REQUIREMENTS.md") (Join-Path $aiDevDir "PROOF_REQUIREMENTS.md")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/RELEASE_LEDGER.jsonl") (Join-Path $aiDevDir "RELEASE_LEDGER.jsonl")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/RUN_CARD.template.json") (Join-Path $aiDevDir "RUN_CARD.template.json")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/BRANCH_REGISTRY.json") (Join-Path $aiDevDir "BRANCH_REGISTRY.json")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/DEPLOY_SOURCE_MAP.md") (Join-Path $aiDevDir "DEPLOY_SOURCE_MAP.md")
    Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/REQUIRED_FOR_RC.md") (Join-Path $aiDevDir "REQUIRED_FOR_RC.md")
    Copy-IfMissing (Join-Path $ScriptDir "project-management/templates/NEXT_ACTIONS.md") (Join-Path $aiDevDir "NEXT_ACTIONS.md")
    Copy-IfMissing (Join-Path $ScriptDir "project-management/templates/DECISIONS.md") (Join-Path $aiDevDir "DECISIONS.md")
    Copy-IfMissing (Join-Path $ScriptDir "project-management/templates/RISKS.md") (Join-Path $aiDevDir "RISKS.md")
    Copy-IfMissing (Join-Path $ScriptDir "project-management/templates/PROGRESS_LOG.md") (Join-Path $aiDevDir "PROGRESS_LOG.md")
    Copy-IfMissing (Join-Path $ScriptDir "project-management/templates/WEEKLY_REVIEW.md") (Join-Path $aiDevDir "WEEKLY_REVIEW.md")
    Copy-IfMissing (Join-Path $ScriptDir "project-management/templates/RUN_CARD.schema.json") (Join-Path $aiDevDir "RUN_CARD.schema.json")

    Write-Host "AI Dev OS project files installed in $aiDevDir"
    Write-Host "Run scripts/ai-dev-os-check.ps1 -TargetDir $TargetDir to verify required project files."
} else {
    Write-Host "PROJECT INIT skipped. Pass -Project to create .ai-dev files."
}

Write-Host "Next steps:"
Write-Host '$env:Path = "$HOME\.ai-dev-os\bin;$env:Path"'
Write-Host '& "$HOME\.ai-dev-os\bin\ai-dev-os.ps1" doctor'
Write-Host 'cd C:\Users\floww\Documents\Scripts\Study_master'
Write-Host '& "$HOME\.ai-dev-os\bin\ai-dev-os.ps1" check .'
Write-Host '& "$HOME\.ai-dev-os\bin\ai-dev-os.ps1" init -Profile serious -Detect'
