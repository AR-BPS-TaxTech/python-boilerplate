# PowerShell equivalent of pre-requirements.sh

function Test-UvInstalled {
    try {
        $null = Get-Command uv -ErrorAction Stop
        return $true
    }
    catch {
        Write-Error "uv is not installed. Please go to https://docs.astral.sh/uv/getting-started/installation/."
        return $false
    }
}

if (-not (Test-UvInstalled)) {
    exit 1
}
