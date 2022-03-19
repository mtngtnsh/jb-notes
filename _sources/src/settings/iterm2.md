# iTerm2

## zsh-syntax-highlighting

1.Simply clone this repository and source the script

```sh
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
$ echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
```

2.Enable syntax highlighting in the current interactive shell

```sh
$ source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

## Preferences

```json
{
  "Custom Directory" : "No",
  "Working Directory" : "\/Users\/mtngtnsh",
  "Prompt Before Closing 2" : false,
  "Selected Text Color" : {
    "Red Component" : 0.8780597448348999,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.87804841995239258,
    "Alpha Component" : 1,
    "Green Component" : 0.87803351879119873
  },
  "Rows" : 50,
  "Ansi 11 Color" : {
    "Red Component" : 0.99454373121261597,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.49358806014060974,
    "Alpha Component" : 1,
    "Green Component" : 0.74323266744613647
  },
  "Use Italic Font" : true,
  "Foreground Color" : {
    "Red Component" : 0.83137254901960789,
    "Color Space" : "sRGB",
    "Blue Component" : 0.039215686274509803,
    "Alpha Component" : 1,
    "Green Component" : 0.5725490196078431
  },
  "Right Option Key Sends" : 0,
  "Character Encoding" : 4,
  "Selection Color" : {
    "Red Component" : 0.7321934700012207,
    "Color Space" : "sRGB",
    "Blue Component" : 0.0093701402415717894,
    "Alpha Component" : 1,
    "Green Component" : 0.52810217487674638
  },
  "Mouse Reporting" : true,
  "Ansi 4 Color" : {
    "Red Component" : 0.35994330048561096,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.99871313571929932,
    "Alpha Component" : 1,
    "Green Component" : 0.62262850999832153
  },
  "Non-ASCII Anti Aliased" : true,
  "Sync Title" : false,
  "Disable Window Resizing" : true,
  "Description" : "Default",
  "Close Sessions On End" : true,
  "Jobs to Ignore" : [
    "rlogin",
    "ssh",
    "slogin",
    "telnet"
  ],
  "Scrollback Lines" : 1000,
  "Brighten Bold Text" : true,
  "Flashing Bell" : false,
  "Cursor Guide Color" : {
    "Red Component" : 0.14865921437740326,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.82989299297332764,
    "Alpha Component" : 0.25,
    "Green Component" : 1
  },
  "BM Growl" : true,
  "AWDS Window Directory" : "",
  "Ansi 3 Color" : {
    "Red Component" : 0.99310135841369629,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.35100504755973816,
    "Alpha Component" : 1,
    "Green Component" : 0.66525256633758545
  },
  "Use Non-ASCII Font" : false,
  "Link Color" : {
    "Red Component" : 0.055476372221164638,
    "Color Space" : "sRGB",
    "Blue Component" : 0.81575512414217621,
    "Alpha Component" : 1,
    "Green Component" : 0.93679451942443848
  },
  "Shortcut" : "",
  "Background Image Location" : "",
  "Bold Color" : {
    "Red Component" : 0.019607843137254902,
    "Color Space" : "sRGB",
    "Blue Component" : 0.51372549019607838,
    "Alpha Component" : 1,
    "Green Component" : 0.43137254901960786
  },
  "Use Cursor Guide" : false,
  "Unlimited Scrollback" : false,
  "Custom Command" : "No",
  "AWDS Tab Option" : "No",
  "Keyboard Map" : {
    "0xf700-0x260000" : {
      "Text" : "[1;6A",
      "Action" : 10
    },
    "0x37-0x40000" : {
      "Text" : "0x1f",
      "Action" : 11
    },
    "0x32-0x40000" : {
      "Text" : "0x00",
      "Action" : 11
    },
    "0xf709-0x20000" : {
      "Text" : "[17;2~",
      "Action" : 10
    },
    "0xf70c-0x20000" : {
      "Text" : "[20;2~",
      "Action" : 10
    },
    "0xf729-0x20000" : {
      "Text" : "[1;2H",
      "Action" : 10
    },
    "0xf72b-0x40000" : {
      "Text" : "[1;5F",
      "Action" : 10
    },
    "0xf705-0x20000" : {
      "Text" : "[1;2Q",
      "Action" : 10
    },
    "0xf703-0x260000" : {
      "Text" : "[1;6C",
      "Action" : 10
    },
    "0xf700-0x220000" : {
      "Text" : "[1;2A",
      "Action" : 10
    },
    "0xf701-0x280000" : {
      "Text" : "0x1b 0x1b 0x5b 0x42",
      "Action" : 11
    },
    "0x38-0x40000" : {
      "Text" : "0x7f",
      "Action" : 11
    },
    "0x33-0x40000" : {
      "Text" : "0x1b",
      "Action" : 11
    },
    "0xf703-0x220000" : {
      "Text" : "[1;2C",
      "Action" : 10
    },
    "0xf701-0x240000" : {
      "Text" : "[1;5B",
      "Action" : 10
    },
    "0xf70d-0x20000" : {
      "Text" : "[21;2~",
      "Action" : 10
    },
    "0xf702-0x260000" : {
      "Text" : "[1;6D",
      "Action" : 10
    },
    "0xf729-0x40000" : {
      "Text" : "[1;5H",
      "Action" : 10
    },
    "0xf706-0x20000" : {
      "Text" : "[1;2R",
      "Action" : 10
    },
    "0x34-0x40000" : {
      "Text" : "0x1c",
      "Action" : 11
    },
    "0xf700-0x280000" : {
      "Text" : "0x1b 0x1b 0x5b 0x41",
      "Action" : 11
    },
    "0x2d-0x40000" : {
      "Text" : "0x1f",
      "Action" : 11
    },
    "0xf70e-0x20000" : {
      "Text" : "[23;2~",
      "Action" : 10
    },
    "0xf702-0x220000" : {
      "Text" : "[1;2D",
      "Action" : 10
    },
    "0xf703-0x280000" : {
      "Text" : "0x1b 0x1b 0x5b 0x43",
      "Action" : 11
    },
    "0xf700-0x240000" : {
      "Text" : "[1;5A",
      "Action" : 10
    },
    "0xf707-0x20000" : {
      "Text" : "[1;2S",
      "Action" : 10
    },
    "0xf70a-0x20000" : {
      "Text" : "[18;2~",
      "Action" : 10
    },
    "0x35-0x40000" : {
      "Text" : "0x1d",
      "Action" : 11
    },
    "0xf70f-0x20000" : {
      "Text" : "[24;2~",
      "Action" : 10
    },
    "0xf703-0x240000" : {
      "Text" : "[1;5C",
      "Action" : 10
    },
    "0xf701-0x260000" : {
      "Text" : "[1;6B",
      "Action" : 10
    },
    "0xf702-0x280000" : {
      "Text" : "0x1b 0x1b 0x5b 0x44",
      "Action" : 11
    },
    "0xf72b-0x20000" : {
      "Text" : "[1;2F",
      "Action" : 10
    },
    "0x36-0x40000" : {
      "Text" : "0x1e",
      "Action" : 11
    },
    "0xf708-0x20000" : {
      "Text" : "[15;2~",
      "Action" : 10
    },
    "0xf701-0x220000" : {
      "Text" : "[1;2B",
      "Action" : 10
    },
    "0xf70b-0x20000" : {
      "Text" : "[19;2~",
      "Action" : 10
    },
    "0xf702-0x240000" : {
      "Text" : "[1;5D",
      "Action" : 10
    },
    "0xf704-0x20000" : {
      "Text" : "[1;2P",
      "Action" : 10
    }
  },
  "Ansi 14 Color" : {
    "Red Component" : 0.14865921437740326,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.82989299297332764,
    "Alpha Component" : 1,
    "Green Component" : 1
  },
  "Ansi 2 Color" : {
    "Red Component" : 0.14805346727371216,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.82991856336593628,
    "Alpha Component" : 1,
    "Green Component" : 1
  },
  "Send Code When Idle" : false,
  "ASCII Anti Aliased" : true,
  "Tags" : [

  ],
  "Ansi 9 Color" : {
    "Red Component" : 0.98614990711212158,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.35388326644897461,
    "Alpha Component" : 1,
    "Green Component" : 0.020856760442256927
  },
  "Use Bold Font" : true,
  "Silence Bell" : false,
  "Ansi 12 Color" : {
    "Red Component" : 0.33359432220458984,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.99875175952911377,
    "Alpha Component" : 1,
    "Green Component" : 0.68011558055877686
  },
  "Window Type" : 0,
  "Use Bright Bold" : true,
  "Cursor Text Color" : {
    "Red Component" : 0.97647058823529409,
    "Color Space" : "sRGB",
    "Blue Component" : 0.23921568627450981,
    "Alpha Component" : 1,
    "Green Component" : 0.75294117647058822
  },
  "Default Bookmark" : "No",
  "Cursor Color" : {
    "Red Component" : 0.94117647058823528,
    "Color Space" : "sRGB",
    "Blue Component" : 0.27450980392156865,
    "Alpha Component" : 1,
    "Green Component" : 0.75294117647058822
  },
  "Ansi 1 Color" : {
    "Red Component" : 0.98614990711212158,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.35388326644897461,
    "Alpha Component" : 1,
    "Green Component" : 0.020856760442256927
  },
  "Name" : "panda",
  "Blinking Cursor" : true,
  "Guid" : "8301F835-B001-4AAF-93A0-1D7A83CFA4CF",
  "Idle Code" : 0,
  "Ansi 10 Color" : {
    "Red Component" : 0.14805346727371216,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.82991856336593628,
    "Alpha Component" : 1,
    "Green Component" : 1
  },
  "Ansi 8 Color" : {
    "Red Component" : 0.36078432202339172,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.43921568989753723,
    "Alpha Component" : 1,
    "Green Component" : 0.38823530077934265
  },
  "Badge Color" : {
    "Red Component" : 0.98614990711212158,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.35388326644897461,
    "Alpha Component" : 0.5,
    "Green Component" : 0.020856760442256927
  },
  "Smart Cursor Color" : false,
  "Ambiguous Double Width" : false,
  "Blur Radius" : 3.4913134860009261,
  "Cursor Type" : 2,
  "Ansi 0 Color" : {
    "Red Component" : 0.12057839334011078,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.12636999785900116,
    "Alpha Component" : 1,
    "Green Component" : 0.12339203059673309
  },
  "AWDS Pane Directory" : "",
  "Blur" : false,
  "Vertical Spacing" : 1,
  "Normal Font" : "JetBrainsMonoNerdFontCompleteM-Regular 14",
  "Ansi 7 Color" : {
    "Red Component" : 0.94097667932510376,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.9409644603729248,
    "Alpha Component" : 1,
    "Green Component" : 0.940948486328125
  },
  "AWDS Tab Directory" : "",
  "AWDS Pane Option" : "Yes",
  "Command" : "",
  "Terminal Type" : "xterm-256color",
  "Horizontal Spacing" : 1,
  "Tab Color" : {
    "Red Component" : 0.68458080291748047,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.062073707580566406,
    "Alpha Component" : 1,
    "Green Component" : 0
  },
  "Option Key Sends" : 0,
  "Minimum Contrast" : 0,
  "Ansi 15 Color" : {
    "Red Component" : 0.94097667932510376,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.9409644603729248,
    "Alpha Component" : 1,
    "Green Component" : 0.940948486328125
  },
  "Ansi 6 Color" : {
    "Red Component" : 0.14865921437740326,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.82989299297332764,
    "Alpha Component" : 1,
    "Green Component" : 1
  },
  "Transparency" : 0.029999999999999999,
  "Background Color" : {
    "Red Component" : 0.058823529411764705,
    "Color Space" : "sRGB",
    "Blue Component" : 0.35294117647058826,
    "Alpha Component" : 1,
    "Green Component" : 0.21568627450980393
  },
  "Screen" : -1,
  "AWDS Window Option" : "Yes",
  "Bound Hosts" : [

  ],
  "Non Ascii Font" : "Monaco 12",
  "Ansi 13 Color" : {
    "Red Component" : 0.99126648902893066,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.81628024578094482,
    "Alpha Component" : 1,
    "Green Component" : 0.58417999744415283
  },
  "Columns" : 160,
  "Use Tab Color" : false,
  "Visual Bell" : true,
  "ASCII Ligatures" : false,
  "Thin Strokes" : 4,
  "Ansi 5 Color" : {
    "Red Component" : 0.98811757564544678,
    "Color Space" : "Calibrated",
    "Blue Component" : 0.65158092975616455,
    "Alpha Component" : 1,
    "Green Component" : 0.35074537992477417
  }
}
```
