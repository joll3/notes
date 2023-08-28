# Handcrafted guides for doing cloudstuff

## Windows Terminal

- `|clip` #copy output `from` Windows Terminal `to` clipboard
- [installing chocolatey](https://chocolatey.org/install#individual) #!done
    Run `Get-ExecutionPolicy`,
    If it returns Restricted, then run,
    `Set-ExecutionPolicy AllSigned` OR
    `Set-ExecutionPolicy Bypass -Scope Process`

## wsl

- `wsl --shutdown` - shuts down wsl instances if vmmem process consumes too much resources
- `wsreset.exe` - resets windows store (might help for "PUR Authentication failure" in MS Store)

## Cloudshell setup

- recommended: Windows terminal, with Powershell cloudshell

### Goal

```PS
PS /home/contoso> Connect-AzureAD
PS /home/contoso> Get-AzureADUser -ObjectId 'first.last@domain.com'
```

### [Cloudshell profile](https://about-azure.com/configure-azure-cloud-shell-to-use-a-profile-hosted-on-github/)

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
$profilePath = 'https://raw.githubusercontent.com/joll3/azure/master/profile.ps1'
# New random GUID to prevent web client from caching file 
$downloadString = '{0}?{1}' -f $profilePath, (New-Guid)
# Download profile.ps1 as string and execute to load into runspace
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($profilePath))
```

Download `Set-Profile.ps1` and pipe to `Set-Content` cmdlet to override profile

```PS
(New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/joll3/azure/Set-Profile.ps1') | Set-Content $profile -Force
```

```PS
. $profile
```

[1]: https://github.com/mjisaak "mjisaak"

## [DuckDuckGo email protection](https://bitwarden.com/help/generator/#username-types)

- **Generate Private Duck Address** > browser dev tools *Network* > authorization: Bearer {API token value}
- <https://www.icloud.com/shortcuts/febbc87b90a24921a2399764fcafae46>

## [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) - #Github secrets leak

1. copy/download bfg-x.yy.z.jar to working directory

2. Create `passwd.txt` which lists sensitive strings

3. ```bash
    java -jar ./bfg-1.14.0.jar --replace-text passwd.txt
    ```

## SVG Scalable Vector Graphics

- <https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute>

### [Raivo](https://github.com/raivo-otp/issuer-icons) icons SVG

- use online tool Convertio to [convert image file (.png .jpg etc.) to .svg](https://convertio.co/png-svg/)
- <https://developers.convertio.co/cli/> - cli version looks really good also
- <https://jsfiddle.net/u9x423ph/2/> - javascript sandbox - the best one I have ever used < 2023-05-11

to see and edit .svg XML source in browser `view-source:file:///{path}sf_mark_primary.svg`

- [scalefusion-branding-guidelines.pdf](https://scalefusion.com/mediakit/scalefusion-branding-guidelines.pdf)

### [favicon](https://en.wikipedia.org/wiki/Favicon)

## [AdoptOpenJDK](https://adoptopenjdk.net/releases.html) - opensource JDK

## Link collection

- <https://testconnectivity.microsoft.com/tests/EwsTask/input> - Microsoft Remote Connectivity Analyzer

- <https://github.com/MISP/MISP-Taxii-Server>

## Pandoc markdown > pdf

```bash
pandoc Työnantajan_todistus.md -o tyonantajantodistus.pdf
```

## WSL Ubuntu Docker

```bash
sudo dockerd # start docker daemon with sudo priviledges
```

## certificates

```openssl x509 -in /path/to/certificate.crt -text -noout``` - check certificate details

### certificates for ZScaler

- <https://github.com/microsoft/WSL/issues/5134#issuecomment-1043406222>

### mkcert - locally trusted developer certificates

- <https://github.com/FiloSottile/mkcert> - have not tried this yet

## regex

- [regex101.com](www.regex101.com)  
- `^\W*LOG\s(\d*)-(\d*)-(\d*)` >replace> `LOG $3-$2-$1`
  - <https://regex101.com/r/Mm2ctB/1>
