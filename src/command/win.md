# Windows

## 1. chcp

### 現在の文字コードを確認する

```
> chcp
```

| Identifier | .NET Name | Additional information                  |
| :---------- | :--------- | :--------------------------------------- |
| 932        | shift_jis | ANSI/OEM Japanese; Japanese (Shift-JIS) |
| 20127      | us-ascii  | US-ASCII (7-bit)                        |
| 51932      | euc-jp    | EUC Japanese                            |
| 65001      | utf-8     | Unicode (UTF-8)                         |

出典: [Code Page Identifiers](https://docs.microsoft.com/en-us/windows/win32/intl/code-page-identifiers)

### 文字コードを変更する

```
> chcp {identifier_code}
```

## 2. netsh

### 接続していたWiFi一覧を調べる

```
> netsh wlan show profiles
```

### PW を調べる

```
> netsh wlan show profiles name={SSID} key=clear
```
