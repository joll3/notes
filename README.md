# Handcrafted guides for doing infosec and things

## zsh < command line interpreter CLI

- zsh = default **Z Shell** for Unix-like operating systems (e.g. macOS)

  - extended Bourne shell with features **(scripting, customization, compatibility)** from bash, ksh, tcsh
  - installs via package manager, if not pre-installed like on macOS
  - `chsh -s /bin/zsh` can be used to change shell

- `alias` > commands initialized into current shell session from shell configuration file

- `alias dusage='du -sh * | sort -hr'` > create temporary (this shell session only) alias for given command

- `source ~/.zshrc` > sources/updates shell "run commands **rc**" into current session from script `.zshrc` text file (script executed by shell interpreter when starting new shell session)

### Environment variables in Unix-like shell

Environment is any given [shell] and variable name eg. ´PATH´

```shell
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/system/Library/
```

- `export` sets and makes environment variables available in child processes
- colon-separated list of directories where [shell] looks for executable commands in order
- `export PATH=$PATH:/some/other/directory` appends $PATH

```shell
echo $PATH
/Users/username/.nvm/versions/node/v16.13.2/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/TeX/texbin:/Applications/Wireshark.app/Contents/MacOS:/Applications/Little Snitch.app/Contents/Components
```

- only **trusted directories** should be in $PATH

## Windows Terminal

```terminal
|clip #copy to clipboard
```

## wsl2

- `wsl --shutdown` - shuts down wsl instances if vmmem process consumes too much resources
- `wsreset.exe` - resets windows store (might help for "PUR Authentication failure" in MS Store)

## Azure Cloudshell setup

- recommended: Windows terminal, with Powershell cloudshell

### Goal

```PS
PS /home/contoso> Connect-AzureAD
PS /home/contoso> Get-AzureADUser -ObjectId 'first.last@domain.com'
```

### [Cloudshell profile](https://about-azure.com/configure-azure-cloud-shell-to-use-a-profile-hosted-on-github/)

- [followed a reputable guide][1]

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

## markdown formatting

- [reference-style-links](https://www.markdownguide.org/basic-syntax#reference-style-links) to make text more readable like this: first part is easy to read [inline][1] and second part can be anywhere, i.e. at the end of document

- the difference between i.e. "**id est** (latin)" == "that is" and eg. "**exempli gratia** (latin)" == "for example" is clear and both are **usually** followed by a comma.

  - [Merriam Webster][2]

## Git(hub)

Tldr. _Gitlab_ and _Github_ are competitors, with open source code manager **Git** as part of their offering.

### Github guides

- [Git Magic Guide](http://www-cs-students.stanford.edu/%7Eblynn/gitmagic/pr01.html) - recommended reading to learn git
- <https://stackoverflow.com/questions/448919/how-can-i-remove-a-commit-on-github>
  `git reset --hard <hashofcommit>`
  `git push --force`

### macOS Git setup

`git --version`

> `git version 2.39.3 (Apple Git-145)`

`which git`

> `/usr/bin/git` < executable run from this location

- macOS built-in git version > lets not use that, install via brew

`brew install git` and update symlinks/files with `brew link --overwrite git`

`which git`

> `/opt/homebrew/bin/git`

[Adding global .gitignore](https://stackoverflow.com/questions/7335420/global-git-ignore) file with `git config --global core.excludesFile '~/.gitignore'` > create file and append `.DS_Store` as new line. This changes settings in user specific `~/.gitconfig` file.

### [Github guide for SSH authentication](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

1. generate keypair
2. `ssh-add` add keys to ssh-agent and passphrase to keychain
3. verify connection

Check for existing SSH keys `ls -al ~/.ssh` if none are usable generate new SSH key pair `ssh-keygen -t ed25519 -C "your_email@example.com"`, add public key to target service (github.com).

Starting SSH agent in shell session with `eval "$(ssh-agent -s)"` prints out PID of SSH agent. SSH agent is background process that manages and provides SSH keys to SSH client programs. This helps avoid having to enter SSH passphrase repeatedly.

Adding SSH private key to ssh-agent and store passphrase in keychain `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`

and then appending `~/.ssh/config` with settings for each host.

```bash
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

Changing passphrase for existing private key `ssh-keygen -p -f ~/.ssh/id_ed25519` requires current passphrase.

New cryptographically secure passphrase generation straight to clipboard `env LC_CTYPE=C tr -dc "a-zA-Z0-9-_\$\?" < /dev/urandom | head -c 22 | pbcopy` for easy entry.

- Adding command to `~/.zshrc` file may be required

Verify connection with `ssh -T git@github.com`

#### **Github CLI** not useful or installed

```shell
gh --version`  - outputs executable for `GitHub CLI`
> `zsh: command not found: gh
```

### [Git Credential Manager](https://github.com/git-ecosystem/git-credential-manager)

Provides consistent and secure authentication experience, including multi-factor auth, to every source control hosting service. Not required, not used. Storing SSH keys locally for persistent connection.

> Secure Git credential helper built on .NET that runs on Windows, macOS, and Linux. It aims to provide a consistent and secure authentication experience, including multi-factor auth, to every major source control hosting service and platform.

### [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) - #Github secrets leak

1. copy/download bfg-x.yy.z.jar to working directory

2. Create `strings.txt` which lists sensitive strings

3. ```bash
   java -jar ./bfg-1.14.0.jar --replace-text strings.txt
   ```

### Background

[Git](https://git-scm.com) free open source **distributed** version control, with a branching model. Other alternative source code manager (SCM) tools (version control systems (VCS)) exist but are not relevant. Git is inherently local and can be hosted by anyone, since its open source.

[Github](https://github.com) is a company [bought by Microsoft](https://news.microsoft.com/2018/06/04/microsoft-to-acquire-github-for-7-5-billion/) for **$7.5 billion** worth of Microsoft stock in 2018.

[GitLab](https://en.wikipedia.org/wiki/GitLab) is a 1600 person software company, first partly Ukrainian unicorn. Featured in the Gartner® "DevOps Platforms report".

## [DuckDuckGo email protection](https://bitwarden.com/help/generator/#username-types)

- **Generate Private Duck Address** > browser > dev tools _Network_ > authorization: Bearer {API token value}
- <https://www.icloud.com/shortcuts/febbc87b90a24921a2399764fcafae46>

## SVG Scalable Vector Graphics

- <https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute>

## [Raivo](https://github.com/raivo-otp/issuer-icons) icons SVG

- use online tool Convertio to [convert image file (.png .jpg etc.) to .svg](https://convertio.co/png-svg/)
- <https://developers.convertio.co/cli/> - cli version looks really good also
- <https://jsfiddle.net/u9x423ph/2/> - javascript sandbox - the best one I have ever used < 2023-05-11

to see and edit .svg XML source in browser `view-source:file:///{path}sf_mark_primary.svg`

- [scalefusion-branding-guidelines.pdf](https://scalefusion.com/mediakit/scalefusion-branding-guidelines.pdf)

### [favicon](https://en.wikipedia.org/wiki/Favicon)

## [AdoptOpenJDK](https://adoptopenjdk.net/releases.html) - opensource JDK

## Microsoft / Azure administrator

- <https://testconnectivity.microsoft.com/tests/EwsTask/input> - Microsoft Remote Connectivity Analyzer

## SIEM homelab

- <https://github.com/MISP/MISP-Taxii-Server>

## Pandoc markdown > pdf

```bash
pandoc file1.md -o fil1.pdf
```

## WSL Ubuntu Docker

```bash
sudo dockerd #start docker daemon with sudo priviledges
```

## [QUIC](https://datatracker.ietf.org/doc/rfc9000/)

Created by Google in 2012. QUIC is a transport layer protocol, using HTTP/3 multiplexed connections over UDP. In contrast HTTP/2 is based on stateful TCP connections. Supports encrypted HTTP traffic in a similar role to TCP, with reduced latency and more efficient loss recovery.

Blocking Google QUIC traffic with firewall e.g. Little Snitch is almost impossible. Created `blocklist.txt` which had no effect on QUIC connections to `youtube.com`.

- <https://www.reddit.com/r/networking/comments/148qz1f/why_is_there_a_general_hostility_to_quic_by/>
- [Cloudflare QUIC](https://cloudflare-quic.com)

## certificates

`openssl x509 -in /path/to/certificate.crt -text -noout` - check certificate details

### certificates for ZScaler

- <https://github.com/microsoft/WSL/issues/5134#issuecomment-1043406222>
- <https://github.com/microsoft/WSL/issues/3161#issuecomment-898007915>

## regex

- [regex101.com](www.regex101.com)
- `^\W*LOG\s(\d*)-(\d*)-(\d*)` >replace> `LOG $3-$2-$1`
  - <https://regex101.com/r/Mm2ctB/1>

[1]: https://www.markdownguide.org/basic-syntax#reference-style-links "a title in double quotation marks"
[2]: https://www.merriam-webster.com/grammar/ie-vs-eg-abbreviation-meaning-usage-difference
