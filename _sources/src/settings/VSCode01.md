# VSCode

## 1. Font

### before download

[font overview website](https://www.programmingfonts.org/)

### install font

```
$ brew tap homebrew/cask-fonts &&
brew install --cask font-<Font-Name>-nerd-font
```

[*github url](https://github.com/ryanoasis/nerd-fonts)

### settings.json

::: {note}
:class: dropdown
```
{
    ...
    "editor.fontFamily": "JetBrains Mono",
    "editor.fontSize": 14,
    "terminal.integrated.fontSize": 14,
    ...
}
```

## 2. Extensions(recommanded)

- Markdown Preview Enhanced
- markdownlint
- Docker
- Git History
- CodeSnap

## 3. Terminal Color

[Base16 Terminal Colors for Visual Studio Code](https://glitchbone.github.io/vscode-base16-term/#/)

### settings.json

```
{
    ...
    "workbench.colorCustomizations": {
        "terminal.foreground":"#E6E1DC",
        "terminalCursor.background":"#E6E1DC",
        "terminalCursor.foreground":"#E6E1DC",
        "terminal.ansiBlack":"#2B2B2B",
        "terminal.ansiBlue":"#6D9CBE",
        "terminal.ansiBrightBlack":"#5A647E",
        "terminal.ansiBrightBlue":"#6D9CBE",
        "terminal.ansiBrightCyan":"#519F50",
        "terminal.ansiBrightGreen":"#A5C261",
        "terminal.ansiBrightMagenta":"#B6B3EB",
        "terminal.ansiBrightRed":"#DA4939",
        "terminal.ansiBrightWhite":"#F9F7F3",
        "terminal.ansiBrightYellow":"#FFC66D",
        "terminal.ansiCyan":"#519F50",
        "terminal.ansiGreen":"#A5C261",
        "terminal.ansiMagenta":"#B6B3EB",
        "terminal.ansiRed":"#DA4939",
        "terminal.ansiWhite":"#E6E1DC",
        "terminal.ansiYellow":"#FFC66D"
    ...
}
```

:::
