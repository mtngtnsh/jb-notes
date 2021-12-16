# MacOS

## xcode系

```output
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```

対応法

```sh
xcode-select --install
```
