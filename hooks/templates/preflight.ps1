param(
    [string]$ExpectedRemote = ""
)

$ErrorActionPreference = "Stop"

try {
    $root = git rev-parse --show-toplevel
} catch {
    Write-Host "STOP no git repo"
    exit 1
}

$branch = git branch --show-current
$remote = git remote get-url origin 2>$null
$dirty = git status --short

if ($ExpectedRemote -and $remote -ne $ExpectedRemote) {
    Write-Host "STOP wrong remote: $remote"
    exit 1
}

if (-not $branch) {
    Write-Host "STOP unknown branch"
    exit 1
}

if ($dirty) {
    Write-Host "WARN dirty tree"
    $dirty
} else {
    Write-Host "PASS clean tracked tree"
}

Write-Host "PASS repo=$root"
Write-Host "PASS branch=$branch"
Write-Host "PASS remote=$remote"
