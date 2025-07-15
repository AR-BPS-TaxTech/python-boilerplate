# PowerShell equivalent of local-setup.sh

function Install-GitHooks {
    Write-Host "Installing git hooks..."
    git config core.hooksPath scripts/hooks
}

function Main {
    Install-GitHooks
}

Main
