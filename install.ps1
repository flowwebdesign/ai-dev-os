param(
    [string]$TargetDir = ".",
    [switch]$InstallCodexHome,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$resolvedTarget = Resolve-Path -LiteralPath $TargetDir
$aiDevDir = Join-Path $resolvedTarget ".ai-dev"

if (-not (Test-Path -LiteralPath $aiDevDir)) {
    New-Item -ItemType Directory -Path $aiDevDir | Out-Null
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

if ($InstallCodexHome) {
    $codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
    if (-not (Test-Path -LiteralPath $codexHome)) {
        New-Item -ItemType Directory -Path $codexHome | Out-Null
    }

    Copy-WithOptionalForce (Join-Path $ScriptDir "templates/codex-home/AGENTS.md") (Join-Path $codexHome "AGENTS.md")
    Write-Host "Codex Home Bootstrap installed in $codexHome"
}

Write-Host "AI Dev OS project files installed in $aiDevDir"
Write-Host "Run scripts/ai-dev-os-check.ps1 -TargetDir $TargetDir to verify required project files."
