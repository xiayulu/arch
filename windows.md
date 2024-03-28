# Windows

## Tools For Programmer

### Git

- Download Installer For Windows: https://git-scm.com/download

- Run Installer
- Config

```bash
# check version
git --version

# commit info
git config --global user.email "myemail@example.com"
git config --global user.name "My Name"
```

**Github CLI**

- Download Installer: https://cli.github.com/

- Login

```bash
gh auth login
```

- Generate token at: https://github.com/settings/tokens

### Markdown

**Typora**

- Download: https://typora.io/ (\$14.99 ￥89)
- Settings
- Theme

**Mark Text**

- https://github.com/marktext/marktext
- Open Source And Free

### Oh My Posh

Site: https://ohmyposh.dev/

**Install**

```bash
# may not work
winget install JanDeDobbeleer.OhMyPosh -s winget
# quickly
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
```

**Config**: https://ohmyposh.dev/docs/installation/prompt

```bash
# create $PROFILE file
New-Item -Path $PROFILE -Type File -Force

# Solve PowerShell blocks running local scripts
# 
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

# edit $PROFILE
notepad $PROFILE
```

add config by using  the [ys](https://ohmyposh.dev/docs/themes#ys) theme

```bash
# in $PROFILE
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/ys.omp.json" | Invoke-Expression
```

Install Nerd Fonts (Support icons for some themes). Download fonts at: https://www.nerdfonts.com/font-downloads, For Example I download `JetBrainsMono Nerd Font`

**Config terminal font**. This can be easily done by modifying the Windows Terminal settings (default shortcut: `CTRL + SHIFT + ,`). In your `settings.json` file, add the `font.face` attribute under the `defaults` attribute in `profiles`:

```json
{
    "profiles": {
        "defaults": {
            "font": {
                "face": "JetBrainsMono Nerd Font"
            }
        }
    }
}
```

✨ **PSReadLine**: [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions) alternative for powershell

> Github: https://github.com/PowerShell/PSReadLine

Install from PowerShellGallery

```bash
# get posh version
Get-Host

# install the latest PowerShellGet
Install-Module -Name PowerShellGet -Force

# After installing PowerShellGet, you can get the latest prerelease version of PSReadLine by running
Install-Module PSReadLine -AllowPrerelease -Force
```
Add Config: `notepad $PROFILE`

```shell
# PSReadLine
Import-Module PSReadLine
# Enable Prediction History
Set-PSReadLineOption -PredictionSource History
# Advanced Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
```

✨ **zoxide**: zoxide is a **smarter cd command**, inspired by `z` and `autojump`.

>  Github: https://github.com/ajeetdsouza/zoxide

Install:

```bash
# not work for me
winget install ajeetdsouza.zoxide

# I use choco
choco install zoxide
```

Add Config: `notepad $PROFILE`

```bash
# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })
```

### Chocolatey

The Package Manager for Windows

> Site: https://chocolatey.org/install

```bash
# Administrator Powershell Run
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# check install
choco
```

