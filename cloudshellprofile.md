# Handcrafted guides for doing cloudstuff

## Cloudshell setup

- recommended: Windows terminal, with Powershell cloudshell

```PS
PS /home/contoso> Connect-AzureAD
PS /home/contoso> Get-AzureADUser -ObjectId 'first.last@domain.com'
```

## [Cloudshell profile](https://about-azure.com/configure-azure-cloud-shell-to-use-a-profile-hosted-on-github/)

- [followed a reputable guide from][1]

```PS
#returns False because no profile exists
$profile
Test-Path $profile
```

Create `profile.ps1` to GitHub repo

```PS
function Show-HelloWorld {
    Write-Host "hello, world!"
}
```

Loading the profile with `Set-Profile.ps1`

```PS
# $profilePath contains URL to profile.ps1 
$profilePath = 'https://raw.githubusercontent.com/mjisaak/azure/master/profile.ps1'
# New random GUID to prevent web client from caching file 
$downloadString = '{0}?{1}' -f $profilePath, (New-Guid)
# Download profile.ps1 as string and execute to load into runspace
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($profilePath))
```

Download `Set-Profile.ps1` and pipe to `Set-Content` cmdlet to override profile

```PS
(New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mjisaak/azure/master/Set-Profile.ps1') | Set-Content $profile -Force
```

```PS
. $profile
```

[1]: https://github.com/mjisaak "mjisaak"
