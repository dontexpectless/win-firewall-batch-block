# Add Firewall new rule to block outbound for all exe files in folder (recursively) #

# v3 - Ask for rule name prefix (default are Folder Name)
# v2 - Ask for path to block all .exe files recursively (meaning subfolders too)
# v1 - Add all files in list as Block Outbund in Windows Firewall 
#       -- Need manual code edit for file list path
# ------------------------------------------------------------------------------------


# Prompt user for folder path
$FolderPath = Read-Host "Full path to the folder"

# Check if the folder exists
if (Test-Path $FolderPath) {
    
    # Prompt user for rule name prefix (optional)
    $RulePrefix = Read-Host "Rule name prefix (wil- use folder name if no input):"
    
    # If no prefix is provided, use folder name as the prefix
    if ([string]::IsNullOrEmpty($RulePrefix)) {
        $RulePrefix = [System.IO.Path]::GetFileName($FolderPath.TrimEnd('\'))
    }

    # Find all .exe files in the folder and its subfolders
    $Executables = Get-ChildItem -Path $FolderPath -Recurse -Filter "*.exe" | Select-Object -ExpandProperty FullName
    
    if ($Executables.Count -eq 0) {
        Write-Host "No .exe files found in the specified path."
    } else {
        # Loop through each .exe and create a firewall rule to block it
        foreach ($Exe in $Executables) {
            # Get the file name without the path
            $FileName = [System.IO.Path]::GetFileName($Exe)
            
            # Create the firewall rule with the specified prefix and file name
            New-NetFirewallRule -DisplayName "$RulePrefix - $FileName" `
                                -Direction Outbound `
                                -Program $Exe `
                                -Action Block `
                                -Profile Any
        }

        Write-Host "Firewall rules have been created to block outbound traffic for all executables in $FolderPath."
    }
} else {
    Write-Host "The specified folder does not exist. Please check the path and try again."
}
