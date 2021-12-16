# PowerShell

## Install a custom prompt engine([Oh My Posh](https://ohmyposh.dev/docs/pwsh)) for PowerShell7

### Preview the themes(require a Nerd Font)

```
Get-PoshThemes
```

### Settings

```
notepad $PROFILE
```

paradox がお気に入り
![tools-paradox](../img/tools-paradox.png)

- config file path: `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`  

```
# 文字化けを解決する
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")
[System.Console]::InputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")
$env:LESSCHARSET = "utf-8"

# Emacs base
Set-PSReadLineOption -EditMode Emacs

Import-Module posh-git
Import-Module oh-my-posh
# Paradox という Theme をセットアップする
Set-PoshPrompt Paradox

# git flow
function gf()  { git fetch --all }
function gd()  { git diff $args }
function ga()  { git add $args }
function gaa() { git add --all }
function gco() { git commit -m $args[0] }

# git switch
function gb()  { git branch -l | rg -v '^\* ' | % { $_ -replace " ", "" } | fzf | % { git switch $_ } }
function gbr() { git branch -rl | rg -v "HEAD|master" | % { $_ -replace "  origin/", "" } | fzf | % { git switch $_ } }
function gbc() { git switch -c $args[0] }
function gbm()  { git branch -l | rg -v '^\* ' | % { $_ -replace " ", "" } | fzf | % { git merge --no-ff $_ } }

# git log
function gls()   { git log -3}
function gll()   { git log -10 --oneline --all --graph --decorate }
function glll()  { git log --graph --all --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(auto)%d%Creset\ %C(yellow)%h%Creset %C(magenta)%ae%Creset %C(cyan)%ad%Creset%n%C(white bold)%w(80)%s%Creset%n%b' }
function glls()  { git log --graph --all --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(auto)%d%Creset\ %C(yellow)%h%Creset %C(magenta)%ae%Creset %C(cyan)%ad%Creset%n%C(white bold)%w(80)%s%Creset%n%b' -10}

# git status
function gs()  { git status --short }
function gss() { git status -v }
```

- [Windows TerminalとPowerShellでクールなターミナル環境をつくってみた](https://blog.mamansoft.net/2020/05/31/windows-terminal-and-power-shell-makes-beautiful/)
