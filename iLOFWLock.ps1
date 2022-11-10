##############
# iLOFWLock v1.0 by Gary Howard
# Prereq: PWSH 5.x or later, HPEilocmdlets module, ilo.csv file
# Purpose: To change all the iLO firmware downgrade policy to disable downgrading
# Updates: none 
##############

#Greet user and Ask ilo Creds
Write-Host "iLOFWLock v1.0 by Gary Howard"
Write-Host "Please Provide iLO Credentials that will be used to access all iLOs"
$Creds = Get-Credential -Message "Enter iLO Username and Password"

#Ask user for CSV file and stores it in an Array
$filepath = Read-Host "Please provide the full path of the CSV file ex C:\Users"
$Hostname=@()
Import-Csv $filepath | ForEach-Object{
    $Hostname += $_.hostname
}

#Connect to ilO and changes downgrade policy 
$connection = Connect-HPEilo -ip $Hostname -Credential $Creds
$connection | Set-HPEiloFirmwarePolicy -DowngradePolicy NoDowngrade

Write-Host "Script Completed" -ForegroundColor Green
