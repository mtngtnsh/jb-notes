# tips

## How to create this note?

1. Write articles by markdown.
2. Publish your book online.

### TL;DR(ja)

以下のステップで実現できる。

- ノートや記事を用意する(Markdownで書く)
- ghp-import で release する

#### (1)ノートや記事を用意する

- ディレクトリ構成
  ```
  ├─ src
  │  ├─ index.md
  │  └─ ..
  ├─ _config.yml
  └─ _toc.yml
  ```

#### (2) ghp-import で release する

*if home directory was jb-notes*

```
$ cd ../
$ jb build --all jb-notes            # _build will be generated
$ cd jb-notes
$ ghp-import -n -p -f _build/html
```

[Reference](https://jupyterbook.org/start/publish.html#publish-your-book-online)
