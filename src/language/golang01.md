# Golang

## 1. Golang(Go)とは?

これらの記事がある。  

- [Go言語(golang)とは？人気が高まっている理由を言語の特徴を踏まえて解説！](https://udemy.benesse.co.jp/development/system/golang.html)
- [go言語（golang）の特徴って？メリットとデメリットをまとめてみた](https://itpropartners.com/blog/10984/)  

まとめると、

- シンプルなスクリプト言語
- 曖昧な記述はできない
- 機能を増やすことで言語を拡張していくことはない
- 並行プログラミング: 関数fを別のゴールーチンで呼び出すと、goキーワードを付けて`go f()`でいける
- 豊富な標準ライブラリ群
- ...(省略)...

## 2.公式ドキュメントを読んで学ぶ

- [言語仕様](https://golang.org/ref/spec)  
   コンパクトな言語仕様なので簡単に読める
- [CodeReviewComments](https://github.com/golang/go/wiki/CodeReviewComments)  
   Goらしい書き方が学べる
- [パッケージドキュメント](https://golang.org/pkg/)  
   ドキュメントをしっかり読む
- [公式ブログ](https://blog.golang.org/)  
     最新の情報が記載される  

   ※公式入門教材は[A Tour of Go](https://go-tour-jp.appspot.com/welcome/1)

## 3. [Go](https://golang.org/)をダウンロード

   ※ Go1の間は言語の後方互換が保たれる。言い換えると、Go1.0で書いたコードはGo1.13でもビルドできる。

## 4. Go環境を構築

- インストールしてからバージョン確認してみる。  
`$ go version`

## 5. ソースコードファイルの構成

```go
   package main
   
   func main() {
      // 行コメント
      println("Hello, world.")
      /*
      ブロックコメント
      */
   }
```

## 6. プログラムの構成要素

- パッケージ
- 型
- 関数
- 変数
- 定数

## 7. パッケージの使い方

   ```go
   package main
   
   import "fmt" // fmtパッケージのインポート
   
   func main() {
      fmt.Println("hello, world.") // fmtパッケージのPrintln関数を呼び出す
   }
   ```

## 8. コマンドラインからGoを実行

- プログラムが実行されるまでの流れは下記のようなイメージ
     **Goのコード**(コーディング)
     ↓
     **コンパイル可能なファイルを生成**(go build)
     ↓
     **コンパイルおよび実行**(go run)

- コンパイルと実行のイメージ
  - go build コマンド  
     コンパイルして実行可能なファイル(バイナリ)を生成  
`$ go build main.go`  
`$ go build .`  
`$ go build pkgname`  
  - go run コマンド
       コンパイルから実行まで行う  
`$ go run main.go`  
`$ go run .`  
`$ go run pkgname`

## 9. 開発ツール: コードの書式を揃える

- gofmt
  - 標準のフォーマッタ
  - 絶対に使う
  - -s オプションで冗長な書き方をシンプルにできる

- goimports
  - import文を追加/削除してくれる
  - 未使用パッケージのimportはエラーなので必須
  - フォーマットもかける

## 10. 開発ツール: コードの品質を保つ

- 静的解析ツール
  - golint: Goらしくないコードを検出
  - go test: コンパイラでは発見できないバグを検出(Go1.10以降)

## 11. バージョン管理ツール[goenv(Git)](https://github.com/syndbg/goenv)を導入

　※必須ではないからスキップしてよい
>Homebrewでもインストールが可能ですが、brewの場合はバージョンが少し古いです（2020/5/4時点で1.23）。
>最新バージョンのGoを使いたい場合は下記コマンドで最新のgoenvを指定する必要があります。  
>$ brew install --HEAD goenv  

　引用: [Goのバージョン管理ツールに関する調査](https://hodalog.com/research-a-version-manager-of-go/)

<!--仕事しながら勉強もできる観点では、goenvを使うとより便利だと思われる。-->

## 12. [Go Playground](https://play.golang.org/)

Go環境を構築せず、Go Playgroudを活かして自分で作成した簡単なコードを実行するのもあり

## 13. その他

- Javaで開発した経験がある方には、こちらの記事「[JavaプログラマーのためのGo言語入門](https://future-architect.github.io/articles/20200311/)」をおすすめ。
