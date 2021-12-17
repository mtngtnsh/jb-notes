# jb-notes

## Introduction

Learning Jupyter, and note it by Jupyter Book Community.

## Deployment

All you need to do is:

```
$ jb build --all jb-notes
$ cd jb-notes
$ git checkout main
$ git add .
$ git commit -m "{messages}"
$ git push
$ ghp-import -n -p -f _build/html
```
