# Windows Install Scope Separation

Windows exposed an installer scope bug: a command meant to install global AI Dev OS files also created project `.ai-dev` files in the source repo. That dirtied the repo and mixed three different places that must stay separate.

## Three Places

- Source repo: the AI Dev OS code and templates under development.
- Global install folder: `$HOME\.ai-dev-os`, where the CLI, checkers, version, and manifest live.
- Target project: the product repo that receives `.ai-dev` memory, proof, and run-card files.

Global install prepares the tool. Project init changes a project. Those are different operations and must require different commands.

## Correct Boundary

- Windows global install: `.\install.ps1 -InstallCodexHome`
- Windows project init: `.\install.ps1 -Project -TargetDir C:\path\to\project`
- Windows CLI init: `cd C:\path\to\project`, then `ai-dev-os.ps1 init -Profile serious -Detect`
- Bash global install: `./install.sh --install-codex-home`
- Bash project init: `./install.sh --project /path/to/project`
- Bash CLI init: `ai-dev-os init --profile serious --detect /path/to/project`

## Why Side Effects Are Dangerous

Installer side effects make proof ambiguous. If a global install silently writes `.ai-dev` files into the current directory, a clean source repo becomes dirty, future checks may read accidental project memory, and a user can confuse tool installation with onboarding a client repo.

Windows made the problem easy to see because the global install was run directly from the source checkout with `.\install.ps1 -InstallCodexHome`. The command succeeded, but the current working directory also received `.ai-dev` files.

## Client Offer Angle

Clear scope separation makes the future offer easier to trust. The client can see that the tool install is reversible and global, while project init is explicit, auditable, and pointed at the intended repo. That supports a safer onboarding story: install the control layer first, then initialise one target project with proof.
