# tips

## How to create this note?

1. Rent a VPS and setup your VPS with
    - Linux(Ubuntu or others)
    - Nginx
    - Docker
2. Buy a Domain.
3. Write articles by markdown.
4. Go to [github](https://github.com/mtngtnsh/self-notes) repository to read the README please.

### TL;DR(ja)

以下のステップで実現できる。

- VPSを購入して構築する([DigitalOcean](https://www.digitalocean.com/))
- ドメインを購入してSSL証明書を取得する
- ノートや記事を用意する(Markdownで書く)
- Webサーバに配置する

#### (1) VPSを購入して構築する

DigitalOceanというシンプルで安いクラウドを選択。  
VPS構成(DigitalOceanの世界でいうと、VPSはDroplets):  
***DigitalOceanでのDroplets作成方法を省略。**

- Nginx(Ubuntu:20.04)  --->>>  [How To Install Nginx on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04)
- Git
- Docker  --->>>  [How To Install and Use Docker on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)

#### (2)ドメインを購入してSSL証明書を取得する

- ドメインを購入する  --->>>  [namecheap](https://www.namecheap.com/)

- SSL証明書を取得する  --->>>  [How To Secure Nginx with Let's Encrypt on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04)

#### (3)ノートや記事を用意する(VuePress)

- VuePressを導入(ローカル端末)
  ```
  ├─ docs
  │  ├─ .vuepress
  │  │  └─ config.js
  │  └─ README.md
  ├─ .gitignore
  └─ package.json
  ```

- 依存をインスール(yarnの例)

  ```
  yarn
  ```

  *依存ファイル`yarn.lock`が生成される。

- 開発環境で確認

  ```
  yarn dev
  ```

#### (4) Webサーバに配置する

個人用GitHubの[README.md](https://github.com/mtngtnsh/self-notes#readme)に記載している。
