# Lists the Chrome extensions installed in the Steam client's browser profile.
# Read-only: it never changes anything.

$profileDir = Join-Path $env:LOCALAPPDATA 'Steam\htmlcache\Default'
$extDir = Join-Path $profileDir 'Extensions'

if (-not (Test-Path $extDir)) {
    Write-Host "No extensions found. Expected folder: $extDir"
    exit 1
}

# Chromium keeps the current version in the highest-numbered folder.
$rows = foreach ($ext in Get-ChildItem $extDir -Directory | Where-Object Name -match '^[a-p]{32}$') {
    $versionDir = Get-ChildItem $ext.FullName -Directory |
        Sort-Object { [version]($_.Name -replace '_\d+$', '') } -Descending -ErrorAction SilentlyContinue |
        Select-Object -First 1
    $manifestPath = Join-Path $versionDir.FullName 'manifest.json'
    if (-not (Test-Path $manifestPath)) { continue }

    $manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
    $name = $manifest.name

    # Localized names look like __MSG_appName__ and live in _locales.
    if ($name -match '^__MSG_(.+)__$') {
        $key = $Matches[1]
        $locale = if ($manifest.default_locale) { $manifest.default_locale } else { 'en' }
        $messagesPath = Join-Path $versionDir.FullName "_locales\$locale\messages.json"
        if (Test-Path $messagesPath) {
            $messages = Get-Content $messagesPath -Raw | ConvertFrom-Json
            $entry = $messages.PSObject.Properties | Where-Object { $_.Name -ieq $key } | Select-Object -First 1
            if ($entry) { $name = $entry.Value.message }
        }
    }

    [pscustomobject]@{
        Name    = $name
        Version = $manifest.version
        Id      = $ext.Name
    }
}

if (-not $rows) {
    Write-Host 'Steam browser profile exists, but no extensions are installed.'
    exit 1
}

$rows | Sort-Object Name | Format-Table -AutoSize
