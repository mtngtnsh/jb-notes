# DigitalOcean

## nginxサーバ構築からSSL証明書を取得するまでのリンク

- [How To Install Nginx on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04)

- [How To Secure Nginx with Let's Encrypt on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04)

  - http → https へリダイレクトする時、下記のようにセットアップする。
  
    ```
    # ここに追記(元の設定の上) 
    server {
        listen 80;
        listen [::]:80;

        server_name hangyuz.com;
        return 301 https://$server_name;
    }
    # 以下は元の設定
    server {
        listen 80;
        ...
    }
    ```

    ::: {warning}
    元の設定の下に追記してみたが、なぜかリダイレクトできなかった。

    ```
    # 以下は元の設定
    server {
        listen 80;
        ...
    }
    server {
        listen 80;
        listen [::]:80;

        server_name hangyuz.com;
        return 301 https://$server_name;
    }
    ```

    :::

  - reload nginx

    ```sh
    $ sudo systemctl reload nginx
    ```

- [How To Install and Use Docker on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)  
**ドメイン名取得を省略*
