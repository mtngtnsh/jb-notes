# MacOS

## xcode系

```output
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```

対応法

```sh
xcode-select --install
```

## docker desktop インストールせず、docker を起動する方法

### colima インストール前

::: {tip}
:class: dropdown
```
$ docker version
Client:
 Version:           20.10.9
 API version:       1.41
 Go version:        go1.16.8
 Git commit:        c2ea9bc
 Built:             Thu Nov 18 21:15:43 2021
 OS/Arch:           darwin/amd64
 Context:           default
 Experimental:      true
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

:::

### colima インストールして、起動する

```sh
brew install colima
colima start
```

::: {tip}
:class: dropdown
```

$ brew install colima
==> Downloading https://ghcr.io/v2/homebrew/core/lima/manifests/0.11.0
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/lima/blobs/sha256:55fc8683194596963af16021c1063e8b79fd5f215505ce69100ebcab1c
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:55fc8683194596963af16021c1063e8b79fd5f21
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/colima/manifests/0.4.2
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/colima/blobs/sha256:eb0f075e0a2a10d623f616a1dda562b3f9fdbbeddada7440bc0fbdbd
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:eb0f075e0a2a10d623f616a1dda562b3f9fdbbed
######################################################################## 100.0%
==> Installing dependencies for colima: lima
==> Installing colima dependency: lima
==> Pouring lima--0.11.0.monterey.bottle.tar.gz
🍺  /usr/local/Cellar/lima/0.11.0: 52 files, 32.7MB
==> Installing colima
==> Pouring colima--0.4.2.monterey.bottle.tar.gz
==> Caveats
zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/colima/0.4.2: 8 files, 16.9MB
==> Running `brew cleanup colima`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> Caveats
==> colima
zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
INFO[0000] starting colima
INFO[0000] runtime: docker
INFO[0000] preparing network ...                         context=vm
INFO[0000] creating and starting ...                     context=vm
INFO[0176] provisioning ...                              context=docker
INFO[0176] starting ...                                  context=docker
INFO[0181] done
```

:::

### colima インストール後

::: {tip}
:class: dropdown
```
$ docker version
Client:
 Version:           20.10.9
 API version:       1.41
 Go version:        go1.16.8
 Git commit:        c2ea9bc
 Built:             Thu Nov 18 21:15:43 2021
 OS/Arch:           darwin/amd64
 Context:           colima
 Experimental:      true

Server:
 Engine:
  Version:          20.10.11
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.15
  Git commit:       847da184ad5048b27f5bdf9d53d070f731b43180
  Built:            Wed Apr 13 23:41:08 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v1.5.8
  GitCommit:        1e5ef943eb76627a6d3b6de8cd1ef6537f393a71
 runc:
  Version:          1.0.0-rc95
  GitCommit:        b9ee9c6314599f1b4a7f497e1f1f856fe433d3b7
 docker-init:
  Version:          0.19.0
  GitCommit:
```

:::

## uninstall local java env

### 1. find out version of java

- use this command

```
/usr/libexec/java_home -V
```

::: {tip}

```
~ /usr/libexec/java_home -V
Matching Java Virtual Machines (1):
    17.0.1 (x86_64) "Oracle Corporation" - "OpenJDK 17.0.1" /Users/{user_name}/Library/Java/JavaVirtualMachines/openjdk-17.0.1/Contents/Home
/Users/{user_name}/Library/Java/JavaVirtualMachines/openjdk-17.0.1/Contents/Home
```

:::

- copy the path of java_home

```
/Users/{user_name}/Library/Java/JavaVirtualMachines/openjdk-17.0.1/
```

### 2. uninstall it

- remove it

```
sudo rm -rf /Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk
```

- confirm result

::: {tip}

```
~ java -version
The operation couldn’t be completed. Unable to locate a Java Runtime.
Please visit http://www.java.com for information on installing Java.
```

:::
