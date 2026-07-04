param(
    [string]$TargetDir = "."
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

Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/PROJECT_CONTEXT.md") (Join-Path $aiDevDir "PROJECT_CONTEXT.md")
Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/PROJECT_RULES.md") (Join-Path $aiDevDir "PROJECT_RULES.md")
Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/ACTIVE_STATE.md") (Join-Path $aiDevDir "ACTIVE_STATE.md")
Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/PROOF_REQUIREMENTS.md") (Join-Path $aiDevDir "PROOF_REQUIREMENTS.md")
Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/RELEASE_LEDGER.jsonl") (Join-Path $aiDevDir "RELEASE_LEDGER.jsonl")
Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/RUN_CARD.template.json") (Join-Path $aiDevDir "RUN_CARD.template.json")
Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/BRANCH_REGISTRY.json") (Join-Path $aiDevDir "BRANCH_REGISTRY.json")
Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/DEPLOY_SOURCE_MAP.md") (Join-Path $aiDevDir "DEPLOY_SOURCE_MAP.md")
Copy-IfMissing (Join-Path $ScriptDir "templates/project/.ai-dev/REQUIRED_FOR_RC.md") (Join-Path $aiDevDir "REQUIRED_FOR_RC.md")

Write-Host "AI Dev OS project files installed in $aiDevDir"
