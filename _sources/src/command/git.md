# Git

## Tag

### 1. create & push tag to remote branch

```
$ git tag {tag_name}
$ git push origin {tag_name}
```

### 2. delete local & remote tag

```
$ git tag -d {tag_name}
$ git push origin --delete {tag_name}
```

*引用: [第18話 便利なgit tagの使い方！コミットにタグをつけて管理しやすくしよう【連載】マンガでわかるGit ～コマンド編～](https://www.r-staffing.co.jp/engineer/entry/20201120_1)*

## Branch

### 1. change local branch name

```
$ git branch -m {old_branch_name} {new_branch_name}
// change current branch name
$ git branch -m {new_branch_name}
```

### 2. change remote branch name

In fact, there is no change regarding the remote branch name.  
It's just to create a new branch with the same "git log", and then delete old remote branch.  

```
$ git branch -m {old_branch_name} {new_branch_name}
$ git push -u origin {current_branch_name}
$ git push origin :{old_branch_name}
```

**Example**  
input-1:
```
❯ git branch -m feature-tree master
❯ git push -u origin master
```

output-1:
```
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
remote: 
remote: Create a pull request for 'master' on GitHub by visiting:
remote:      https://github.com/mtngtnsh/self-notes/pull/new/master
remote: 
To github.com:mtngtnsh/self-notes.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```

input-2:
```
❯ git push origin :feature-tree 
```

output-2:
```
To github.com:mtngtnsh/self-notes.git
 - [deleted]         feature-tree
```

### 3. pull remote branch

```
$ git branch -a
$ git checkout {the_same_branchName_with_origin}
```

::: {tip} Example
```
❯ git branch
* main
❯ git branch -a
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/feb
  remotes/origin/main
  remotes/origin/master
❯ git checkout feb
Switched to a new branch 'feb'
Branch 'feb' set up to track remote branch 'feb' from 'origin'.
❯ git branch
* feb
  main
```
:::

## Clone

### 1. clone from specific branch

```
$ git clone -b {branch_name} https://...{repository_address}...
```

## Rebase

### 1. rebase commits(squash) or change commit message(reword)

```
$ git rebase -i HEAD~{n}
< edit commits to drop, squash, fixup.. >
< edit commit messages >
$ git push origin {branch} -f
```

## Fetch

### 1. Update local branch forcefully

```
$ git fetch origin master
$ git reset --hard origin/master
```
