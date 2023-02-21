# $profilePath contains URL to profile.ps1 
$profilePath = 'https://raw.githubusercontent.com/mjisaak/azure/master/profile.ps1'
# New random GUID to prevent web client from caching file 
$downloadString = '{0}?{1}' -f $profilePath, (New-Guid)
# Download profile.ps1 as string and execute to load into runspace
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($profilePath))