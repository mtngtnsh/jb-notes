# + CheatSheet - AWS Developer

## 1. Deploy Service

- デプロイパターン

  | デプロイパターン | 特徴                                                         |
  | :----------------- | :----------------------------------------------------------- |
  | In-Place         | 稼働中の環境を新しいアプリで更新する                         |
  | Linear(線形)     | 毎分10%づつ新環境の割合をふやすなど、時系列グラフとした場合、直線的に推移する |
  | Canary           | 最初は10%のみで、数分後に全てなど、割合によって段階的にリリース |
  | Blue/Green       | 現バージョン環境とは別に新バージョン環境を構築し、リクエスト送信先を切り替える |
  | Rolling          | サーバをいくつかのグループに分けて、グループごとにIn-Place更新をする |
  | Immutable        | 現バージョンサーバとは別に新バージョンサーバを構築する       |
  | All at once      | 全てのサーバで同時にIn-Place更新をする                       |

- AWS Code サービス (English)
  - [AWS CodeCommit](https://docs.aws.amazon.com/en_us/codecommit/latest/userguide/welcome.html): プライベートなGitリポジトリサービス
  - [AWS CodeBuild](https://docs.aws.amazon.com/en_us/codebuild/latest/userguide/welcome.html): コンパイル、テスト、パッケージングなどのビルドプロセスを提供
  - [AWS CodeDeploy](https://docs.aws.amazon.com/en_us/codedeploy/latest/userguide/welcome.html): デプロイの自動化
  - [AWS CodePipeline](https://docs.aws.amazon.com/en_us/codepipeline/latest/userguide/welcome.html): CI/CDパイプラインを構築
    - 迅速かつ信頼性の高いアプリ更新を実現する。
    - リリース結果を可視化して確認できる。
  - [AWS CodeStar](https://docs.aws.amazon.com/codestar/latest/userguide/welcome.html): ウィザード形式でCI/CDパイプラインを構築
  - [AWS CodeArtifact](https://docs.aws.amazon.com/codeartifact/latest/ug/welcome.html): プライベートソフトウェア配信リポジトリサービス
  - [AWS CodeGuru](https://docs.aws.amazon.com/codeguru/latest/reviewer-ug/welcome.html): 自動コードレビュー

## 2. Security Service

- ネットワークのセキュリティ
  - [Azmazon VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
    - VPC エンドポイント
      - **ゲートウェイエンドポイント**を使用するサービス(2つ)
        - Amazon S3
        - Amazon DynamoDB
      - **インターフェースエンドポイント**を使用するサービス(一部)
        - Amazon API GateWay
        - Amazon CloudWatch
        - AWS CodeBuild
        - AWS Elastic Beanstalk
        - Amazon Elastic Container Registry
        - AWS KMS
        - Amazon Kinesis Data Steams
        - AWS Lambda
        - AWS Secrets Manager
        - AWS Systems Manager
        - Amazon SNS
        - Amazon SQS

- 認証と認可
  - [AWS Identity & Access Management (IAM)](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
    - IAMポリシーは、最小権限の原則を守って設定することがベストプラクティス。

      ```json
      {
          "Version": "2012-10-17",
          "Statement": [
              {
                  "Effect": "Allow",
                  "Action": "*",
                  "Resource": "*"
              }
          ]
      }
      ```

  - [Amazon Cognito](https://docs.aws.amazon.com/cognito/latest/developerguide/what-is-amazon-cognito.html)
    - User Group
      - ユーザグループでできることは主に以下の通り。
        - サインアップ、サインインを簡単にアプリに実装
        - カスタム可能な組み込みサインインUI
        - ユーザプロファイルの管理
        - MFA、本人確認などユーザ認証の一般的な機能
        - Lambdaトリガー
        - Web ID フェデレーション(Google, Apple, Amazon)
  - [AWS Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html)
  - [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)

- 暗号化
  - [AWS Key Management Service (KMS)](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html): 暗号化するためのキーを作成、管理するサービス。
  - [AWS Certificate Manager](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html): 独自ドメインのアプリでの証明書の管理、設定の機能を提供。
  - [Amazon CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)
  - [Amazon Simple Stroage Service (S3)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
  - [Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
  - [Amazon Simple Queue Service (SQS)](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html)

## 3. Development

### 開発環境

- 署名バージョン4を使用してリクエストに署名する手順
  1. 正規リクエストを作成する。
  2. 正規リクエストと追加のメタデータを使用して、署名の文字列を作成する。
  3. AWSシークレットアクセスキーから署名キーを取得する。次に署名キーと手順で準備した文字列を使用して署名を作成する。
  4. 作成した署名をヘッダーのHTTPリクエストに追加するか、クエリ文字列パラメータとして追加する。

- 認証情報の優先順位
  1. コードのオプションやパラメータで指定されたアクセスキー情報
  2. 環境変数(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KERY)
  3. .aws/credentials ファイル
  4. EC2 の IAM ロール(インスタンスプロファイル)

- AWS Cloud9
  - すぐに開発を始めることができる
  - 複数ユーザでリアルタイム共有できる
  - サーバレスのデプロイが簡単

### ストレージ

- S3 主な特徴
  - オブジェクトストレージ
  - インターネット対応
  - 無制限にデータを保存
  - 柔軟なセキュリティ設定

- S3 主なユースケース
  - データレイク: あらゆる場所から、あらゆる形式のデータをそのままの形で保存して、集計や機械学習などのさまざまな分析用途で使用するための保管場所のこと。
  - バックアップ
  - 配信
  - コンテンツストレージ

### データベース

- RDB系
  - Amazon RDB
  - Amazon Aurora
- NoSQL系
  - Amazon DynamoDB

### コンピューティング・API

- AWS Lambda
  - ベストプラクティス
    - 環境変数を使用する
    - 共通のモジュール、ライブラリーをレイヤーで共有する
    - 再帰的なコードを使用しない

- API Gateway で REST API を作成する最短手順
  - API Gateway で REST API を作成
  - リソースの作成
  - メソッドの作成
  - テスト
  - デプロイ

## 4. Monitoring

- Amazon ClouWatch のメトリクス
  - EC2
    - CPUUtilization: EC2 で使用されている CPU の比率。
    - NetworkIn: インスタンスが受信したバイト数。
    - NetworkOut: インスタンスから送信したバイト数。
    - StatusCheckFailed: インスタンスのステータスチェックとシステムステータスチェックのいずれかに失敗した場合は1、それ以外は0。
  - EBS
    - VolumeReadOps: ディスク読み取り回数。
    - VolumeWriteOps: ディスク書き込み回数。
  - RDS
    - DatabaseConnections: データベース接続数。
    - ReadIOPS: ディスク読み取り回数。
    - WriteIOPS: ディスク書き込み回数。
    - FreeableMemory: 使用可能なメモリ容量。
  - DynamoDB
    - ProvisionedWriteCapacityUnits: 設定している、またはオートスケーリングによって設定された書き込みキャパシティユニット数。
    - ProvisionedReadCapacityUnits: 設定している、またはオートスケーリングによって設定された読み込みキャパシティユニット数。
    - ConsumedWriteCapacityUnits: 消費された書き込みキャパシティユニット数。
    - ConsumedReadCapacityUnits: 消費された読み込みキャパシティユニット数。
    - TrottledRequests: キャパシティユニットによって設定されたスループットの上限を超えて発生したリクエスト数。
    - ReadThrottleEvents: スロットルのうちの読み込みリクエスト。
    - WriteThrottleEvents: スロットルのうちの書き込みリクエスト。
  - S3
    - BucketSizeBytes: 保存されているオブジェクトデータの量。
    - NumberOfObjects: オブジェクトの合計数。
  - Lambda
    - Invocations: 呼び出し実行数(請求対象リクエスト数)
    - ConcurrentExecutions: 実行された関数インスタンスの数。
    - Errors: タイムアウトなどのランタイムエラー、コードによって例外処理したエラーの総数。
    - Throttles: ConcurrentExecutions が同時実行数に達した場合、リクエストが実行されずにスロットリングされる。スロットリングされた数が記録される。
    - Duration: 関数が実行された時間。
  - API Gateway
    - Count: API リクエスト数。
    - 4XXError: クライアント側のエラー数。
    - 5XXError: サーバ側のエラー数。
    - IntegrationLatency: API Gateway がバックエンドにリクエストを送信してからレスポンスを受け取るまでの時間。
    - Latency: API Gateway がクライアントからリクエストを受け取ってからクライアントにレスポンスを返すまでの時間。
  - SQS
    - SentMessageSize: キューに送信されたメッセージのサイズ。
    - NumberOfMessagesSent: キューに送信されたメッセージの数。
    - NumberOfMessagesReceived: キューへの ReceiveMessage API アクションによって返されたメッセージの数。
    - NumberOfMessagesDeleted: キューから削除されたメッセージの数。
    - NumberOfEmptyReceives: メッセージを返さなかったキューへの ReceiveMessage API アクションの数。この数が多くて減らしたい場合は、ロングポーリングを検討する。
    - ApproximateNumberOfMessagesVisible: 取得可能なメッセージの数。Visible とあるように可視性タイムアウトになっていないメッセージ。
    - ApproximateNumberOfMessagesNotVisible: 処理中のメッセージの数。Not Visible なので可視性タイムアウトによって見えなくなっているメッセージ。
  - SNS
    - NumberOfMessagesPublished: トピックにパブリッシュされたメッセージ数。
    - NumberOfNotificationsDeliverd: サブスクライブに正常配信されたメッセージ数。
    - NumberOfNotificationsFailed: サブスクライブへの配信に失敗したメッセージ数。
    - PublishSize: トピックにパブリッシュされたメッセージサイズ。
  - Step Functions
    - ExecutionTime: 開始から終了までの時間。
    - EcecutionThrottled: 制限に達した実行回数。この問題を解消するためには、クォータ引上げのリクエストをしてください。
    - ExecutionsFailed: 失敗した実行数。
    - ExecutionsStarted: 開始された実行数。
    - ExecutionsSucceeded: 正常完了した実行数。
    - ExecutionsTimedOut: タイムアウトした実行数。

## point

- **データベース認証情報を格納**および**自動ローテート**するための**セキュアな方法**

    AWS Secrets Manager

- サインアップ機能、サインイン機能をロギングする

    Amazon Congnito + AWS Lambda

*出典: [「ポケットスタディ AWS認定 デベロッパーアソシエイト (アソシエイト試験ポケットスタディ)」](https://www.amazon.co.jp/%E3%83%9D%E3%82%B1%E3%83%83%E3%83%88%E3%82%B9%E3%82%BF%E3%83%87%E3%82%A3-AWS%E8%AA%8D%E5%AE%9A-%E3%83%87%E3%83%99%E3%83%AD%E3%83%83%E3%83%91%E3%83%BC%E3%82%A2%E3%82%BD%E3%82%B7%E3%82%A8%E3%82%A4%E3%83%88-%E3%82%A2%E3%82%BD%E3%82%B7%E3%82%A8%E3%82%A4%E3%83%88%E8%A9%A6%E9%A8%93%E3%83%9D%E3%82%B1%E3%83%83%E3%83%88%E3%82%B9%E3%82%BF%E3%83%87%E3%82%A3-%E5%B1%B1%E4%B8%8B%E5%85%89%E6%B4%8B/dp/4798063401/ref=sr_1_1?dchild=1&keywords=aws+%E3%83%87%E3%83%99%E3%83%AD%E3%83%83%E3%83%91%E3%83%BC+%E3%82%A2%E3%82%BD%E3%82%B7%E3%82%A8%E3%82%A4%E3%83%88&qid=1634528270&sr=8-1)*

## documment

### **Be Lazy**

>**Lazy caching**, also called **lazy population** or **cache-aside**, is the most prevalent form of caching. Laziness should serve as the foundation of any good caching strategy. The basic idea is to populate the cache only when an object is actually requested by the application.

### products and features can be deployed by Elastic Beanstalk

- Auto Scaling groups
- Elastic Load Balancers
- RDS Instances

### ProvisionedThroughputExceededException

>Your request rate is too high. The AWS SDKs for DynamoDB automatically retry requests that receive this exception. Your request is eventually successful, unless your retry queue is too large to finish. Reduce the frequency of requests **using Error Retries** and **Exponential Backoff**.

### web fonts are being blocked by the browser

>Suppose that you want to host a web font from your S3 bucket. Again, browsers require a CORS check (also called a preflight check) for loading web fonts. You would configure the bucket that is hosting the web font to allow any origin to make these requests.

出典: [Using cross-origin resource sharing (CORS)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/cors.html)

### It is able to access an EC2 instance in subnet A, but is unable to access an EC2 instance in subnet B in the same VPC. Which logs can be used to verify whether the traffic is reaching subnet B?

>VPC Flow Logs
