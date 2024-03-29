# Windows Manual For Programmers



## Proxy

- clash
- ji chang(May Not Free)

## Git

> Download Link : https://git-scm.com/download

### Install

Run Installer.

### Config

```bash
# check version
git --version

# commit info
git config --global user.email "myemail@example.com"
git config --global user.name "My Name"

# custom git log info
# https://www.liaoxuefeng.com/wiki/896043488029600/898732837407424
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

### Usage

> Git command list (Chinese): https://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html

```bash
# repo
git init
git clone <remote link>

# show info
git status
git log

##### commit #####
git add .
git add *
git commit -am "commit message"
git pull
git push

##### branch #####
# list all local and remote branchs
git branch -a
# list remote branch links
git remote -v
# switch to <brach-name>
git checkout <brach-name>
# create and switch to <branch-name>
git checkout -b <branch-name>
# delete <branch-name>
git branch -d <branch-name>
# delete remote <branch-name>
git push origin --delete <branch-name>

##### tag #####
# list tags
git tag
# add <tag-name> for current commit
git tag <tag-name>
# push <tag> to <remote>
git push <remote> <tag>
# push all tags
git push <remote> --tags
```

### Github CLI

- Download Installer: https://cli.github.com/

- Login

```bash
gh auth login
```

- Generate token at: https://github.com/settings/tokens

## Markdown

### Typora

> Download: https://typora.io/ 

- Purchase: \$14.99 ￥89
- Settings
- Add Theme

### Mark Text

> Github:https://github.com/marktext/marktext

- Open Source And Free

## Oh My Posh

> Official Site: https://ohmyposh.dev/

### Install

```bash
# may not work
winget install JanDeDobbeleer.OhMyPosh -s winget
# quickly
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
```

### Config

> Document: https://ohmyposh.dev/docs/installation/prompt

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

### Font

**Install Nerd Fonts** (Support icons for some themes). Download fonts at: https://www.nerdfonts.com/font-downloads, For Example I download `JetBrainsMono Nerd Font`

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

### Useful tools

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

## Chocolatey

The Package Manager for Windows

> Official Site: https://chocolatey.org/install

```bash
# Administrator Powershell Run
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# check install
choco
```

## VSCode

> Official Site: https://code.visualstudio.com/

VSCodium is a community-driven, freely-licensed binary distribution of Microsoft’s editor VS Code.

Microsoft’s `vscode` source code is open source (MIT-licensed), but the product available for download (Visual Studio Code) is licensed under [this not-FLOSS license](https://code.visualstudio.com/license) and contains telemetry/tracking. According to [this comment](https://github.com/Microsoft/vscode/issues/60#issuecomment-161792005) from a Visual Studio Code maintainer.

> VSCodium Site: https://vscodium.com/

> **Warning**: VSCodium can not use `code` command.

### Install

- Option1: Download Installer from official site.
- Option2: Install with Chocolatey

```bash
# vscode
choco install vscode
# vscodium
choco install vscodium
```

### Preferences

- Theme: One Dark Pro
- Icons: Material icon theme
- Font: JetBrainsMono Nerd Font
- Auto Save
- Change Hotkey: Format Document: `Shift+Alt+F ---> Alt+F`

### Codeium

✨ **Codeium**: A free AI powered toolkit for developers

> Official Site: https://codeium.com/

- Register an account
- Download extension
- Login

## Python

> Python Official Site: https://www.python.org/downloads/

### Install

- Option1: Download from official site and run installer.
- Option2: Install with Chocolatey

```bash
choco install python
```

### Config

[PyPI tuna mirror](https://mirrors.tuna.tsinghua.edu.cn/help/pypi/):

```bash
# once
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package

# set as default
python -m pip install --upgrade pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

### VSCode Extension

- Python
- Black formatter

### conda

👉 **conda (miniconda)**

> Official Site: https://docs.anaconda.com/free/miniconda/miniconda-install/
>
> tuna: https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/

👉 **Config**

> tuna: https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/

edit or create `.condarc` 。Windows can run `conda config --set show_channel_urls yes` to generate `.condarc` then change it:

```bash
channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch-lts: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  deepmodeling: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/
```

👉 **Usage**:

```bash
# create a environment with specified python version and packages
conda create -n myenv python=3.9 numpy=1.23.5 astropy
# activate the environment:
conda activate myenv

# list envs
conda env list

# export all packages in myenv environment
conda activate myenv
conda env export > myenv.yml

# create a new environment from a myenv.yml
conda env create -f myenv.yml
```
