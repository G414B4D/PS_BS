# Check Registry
Write-Host "Checking Registry..."
$foundInRegistry = $false
$registryPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
)
foreach ($path in $registryPaths) {
    Write-Host "`nChecking path: $path"
    if (Test-Path $path) {
        $registryItems = Get-ItemProperty -Path $path |
                         Where-Object { $_.Value -like "*.ps1" }
        if ($registryItems) {
            $registryItems | ForEach-Object { Write-Host "Found in Registry: $_" }
            $foundInRegistry = $true
        } else {
            Write-Host "No PowerShell scripts found in registry path: $path"
        }
    } else {
        Write-Host "Registry path not found: $path"
    }
}

# Check Scheduled Tasks
Write-Host "`nChecking Scheduled Tasks..."
$foundInScheduledTasks = $false
$scheduledTasks = Get-ScheduledTask |
                  Where-Object { $_.Actions.Execute -like "*powershell*" -and $_.Actions.Arguments -like "*.ps1" }
if ($scheduledTasks) {
    $scheduledTasks | ForEach-Object { Write-Host "Found in Scheduled Tasks: $($_.TaskName)" }
    $foundInScheduledTasks = $true
} else {
    Write-Host "No PowerShell scripts found in Scheduled Tasks."
}

# Check Startup Folder
Write-Host "`nChecking Startup Folder..."
$foundInStartupFolder = $false
$startupFolder = [Environment]::GetFolderPath("Startup")
Write-Host "Checking in: $startupFolder"
$startupScripts = Get-ChildItem -Path $startupFolder -Filter "*.ps1" -Recurse
if ($startupScripts) {
    $startupScripts | ForEach-Object { Write-Host "Found in Startup Folder: $($_.FullName)" }
    $foundInStartupFolder = $true
} else {
    Write-Host "No PowerShell scripts found in Startup Folder."
}

# Summary of findings
Write-Host "`n"
if (-not $foundInRegistry -and -not $foundInScheduledTasks -and -not $foundInStartupFolder) {
    Write-Host "No PowerShell scripts found that persist through a system reboot."
} else {
    Write-Host "Finished checking for persistent PowerShell scripts."
}
