# Dict-ja

## AWS

### Amazon API Gateway

どのような規模のシステムであっても、開発者が簡単に API の作成、配布、保守、監視、保護を行えるフルマネージドサービス。(e.g: API Gateway + Lambda)

### Amazon Athena

標準 SQL を使用し Amazon S3 のデータ分析を簡易化するインタラクティブなクエリサービス。サーバレスであり、自動的にスケーリングする。数秒以内にデータセットの分析を開始可能。

### Amazon Aurora

オープンソースデータベースのシンプルさとコスト効率性を持つとともに、商用データベースのパフォーマンスと可用性を持つ DB 。フルマネージド型 MySQL および PostgreSQL と互換性のある RDB エンジン。

### Amazon CloudFront

低レイテンシーの高速転送によって、世界中のユーザに安全にコンテンツ配信できる高速のコンテンツ配信ネットワーク(CDN)サービス。Web サイトやアプリのパフォーマス、信頼性、可用性を向上。

### Amazon CloudSearch

website またはアプリ向けの検索容易かつコスト効率よく設定できるフルマネージドサービス。

### Amazon CloudWatch

アプリを監視し、システムの使用率の最適化を図る統合的なリソース管理サービス。メトリクスに基づいてアラームのアクションを設定可能。

### Amazon CloudWatchEvents

AWS リソースでの変更を示すシステムイベントをほぼリアルタイムで AWS Lambda 関数、Amazon Kinesis Data Streams に提供できるストリーム、Amazon Simple Notification Service トピック、またはその他ターゲットに振り分けることができる Web サービス。

### Amazon CloudWatch Logs

運用上の問題をトラブルシューティング可能にするサービス。既存のシステム、アプリおよびカスタムログファイルから、システムとアプリをモニタリングし、とラブルシューティング可能なサービス。既存のログファイルを CloudWatch Logs に送信し、送信したログをほぼリアルタイムにモニタリング可。

### Amazon Cognito

モバイルアプリやウェブアプリにユーザのサインアップやアクセス認証機能を簡単に追加できるサービス。バックエンドコードの記述やインフラの管理は必要ない。モバイルアイデンティティ管理や複数のデバイス間の同期が可能。

### Amazon DocumentDB

高速でスケーラブルかつ高可用性のフルマネージド型のドキュメントベースサービス。MongoDB のワークロードをサポート。

### Amazon DynamoDB

フルマネージドの NoSQL データベースサービスで数ミリ秒のレイテンシーを実現できるパフォーマンスとどんな規模にも対応可能な拡張性を持つDB。

### Amazon DynamoDB Streams

DynamoDB テーブル内の項目に加えられた変更に関する順序つけられた情報。テーブルでストリームを有効にすると、データの変更情報をキャプチャーし、この情報を最大24時間ログに保存するAWSサービス。アプリは、このログにアクセスすることでデータをほぼリアルタイム参照可。

### Amazon Elastic Block Dtore (Amazon EBS)

EC2インスタンスのクラスターにあるDockerコンテナを簡単に実行、停止、管理できるようにする、拡張性が高く、高速なコンテナ管理サービス。

### [Amazon Elastic Container Service (Amazon ECS)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)

Linux/UNIX および Windows サーバのインスタンスを起動して管理できるサービス。

### Amazon Elastic Compute Cloud (Amazon EC2)

ユーザ定義のポリシー、シケジュールおよびヘルスチェックに基づいてインスタンスを自動的に起動または終了するように設計された Web サービス。

### Amazon Elastic File System

AWSでのネットワークファイルシステム(NFS)。ファイルシステムを作成し、設定する簡単なインターフェースを提供。ストレージ容量はファイルの追加や削除に伴い、大会伸縮自在性がある。

### Amazon EMR

大量のデータを効率的かつ簡単に処理するためのデータ分析に適したサービス。Hadoop 処理とさまざまなサービスを組み合わせることによって、ウェブインデックス作成、データマイニング、ログファイル分析、機械学習、価格シミュレーション、DWH といった分析タスクを実施可。

### [Amazon ElasticCache](https://docs.aws.amazon.com/elasticache/index.html)

クラウドのメモリ内キャッシュのデプロイ、運用、スケーリングを単純化する Web サービス。

### Amazon Elasticsearch Service (Amazon ES)

フルマネージドでスケーラブルな Elasticsearch サービス。

### Amazon GuardDuty

未然にセキュリティの脅威を検出し、継続的にモニタリングするセキュリティサービス。

### [Amazon Inspector](https://docs.aws.amazon.com/inspector/latest/userguide/inspector_introduction.html)

アプリのセキュリティとコンプライアンスを向上させるための自動化されたセキュリティ評価サービス。自動的にアプリを評価し、脆弱性やベストプラクティスからの逸脱を判定。評価の実行後には、修復に必要なステップを優先順位に従ってリスト化したものを含む詳細なレポートを作成。

### [Amazon Kinesis](https://docs.aws.amazon.com/kinesis/index.html)

動画やログデータなどのストリーミングデータを収集、処理、分析するためのプラットフォーム。ストリーミングのデータの読み込みと分析を簡略化できる。

### [Amazon Kinesis Data Firehose](https://docs.aws.amazon.com/firehose/latest/dev/what-is-this-service.html)

ストリーミングデータの読み込み用のフルマネージドサービス。Amazon S3 および Amazon Redshift にストリーミングデータをキャプチャし、自動的に収集する ETL サービスのようなもの。また既存のビジネスインテリジェンスツールとダッシュボードでぼほリアルタイムに分析。データのスループットに合わせ自動的にスケールし、継続的な管理作業は不要。

### AMI

Amazon Elastic Block Store (Amazon EBS)または Amazon Simple Storage Service に格納される暗号化されたマシンイメージ。

### Amazon ML

データのパターンを検出して機械学習モデルを作成し、そのモデルを使用して新規データを処理し、予測を生成するクラウドベースのサービス。ML サービスとして、 [SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/whatis.html) がある。

### [Amazon Macie](https://docs.aws.amazon.com/macie/?id=docs_gateway)

機械学習によって AWS 内の機密データを自動的に検出、分類、保護するセキュリティサービス。

### Amzon Managed Blockchain

Hyperledger や Etherium といった一般的なオープンソースのフレームワークを使用して、スケーラブルなブロックチェーンネットワークを作成および管理するためのフルマネージドサービス。

### Amazon MQ

AWS 上でメッセージブローカーを容易に設定および運用できる Apache ActiveMQ 向けのマネージド型メッセージブローカーサービス。

### Amazon Neptune

マネージド型のグラフデータベースサービス。人気の高いグラフクエリ言語 Apache TinkerPop Gremlin と W3C の SPARQL をサポートしているため、高度に接続されたデータセットを効率的にナビゲートできるクエリが作成可能。

### Amazon QuickSight

クラウド型の高速な BI サービス。データの視覚化と分析を容易に行うダッシュボードが構築でき、ビジネス上の洞察を素早く得ることが可能。

### Amazon Redshift

クラウド内でのフルマネージド型でペタバイト規模 DWH サービス。既存の BI ツールを使用してデータを分析可能。

### Amazon Relational Database Service (Amazon RDS)

クラウドでリレーショナルデータベースを簡単に設定、運用および拡張することができるサービス。業界標準のリレーショナルデータベース向けに、費用対効果に優れた拡張機能を備え、データベースワークロードを管理。

### Amazon Route53

新しい DNS サービスを作成し、クラウドに既存の DNS サービスを移行するために使用するウェブサービス。

### Amazon S3 Glacier

データのアーカイブおよび長期バックアップを行うための安全性と耐久性に優れた低コストのストレージサービス。アクセス頻度が低く、数時間内の取り出し回数が適切なデータに最適化。迅速取り出しオプションを利用すると、数分での取り出しも可能。

### Amazon SageMaker

機械学習のワークフロー全体をカバーするフルマネージドサービス。機械学習モデルの構築、トレーニング、デプロイ手段を提供。データをラベル付けして準備し、アルゴリズムを選択肢て、モデルのトレーニングを行い、デプロイのための調整と最適化を実施。機械学習モデルをより少ない労力と費用で、本番稼働させることが可能。

### Amazon Simple Email Service (Amazon SES)

簡単に利用でき、費用対効果の高いＥメールソリューション。

### [Amazon Simple Notification Service (Amazon SNS)](https://docs.aws.amazon.com/sns/latest/dg/welcome.html)

アプリ、ユーザ、およびデバイスでクラウドからすぐに通知を送受信できるようにする pub/sub 型の古まーじどのメッセージングサービス。

### Amazon Simple Queue Service (Amazon SQS)

コンピュータ館で送受信されるメッセージを格納するための、信頼性の高いスケーラブルメッセージングサービス。

### Amazon Simple Storage Service (Amazon S3)

インターネット用のストレージ。

### Amazon Simple Workflow Service (Amazon SWF)

並行したステップや連続したステップのあるバッククラウドジョブを構築、実行、拡張するのを支援するフルマネージドサービス。クラウド内で、ステータストラッカーや、タスクコーディネーターのような役割を実施。

### Amazon Virtual Private Cloud (Amazon VPC)

AWS クラウドの論理的に隔離された仮想ネットワークを構築するサービス。独自のＩＰアドレス範囲の選択、サブネットの作成、ルートテーブル、ネットワークゲートウェイの設定など、仮想ネットワーク環境をコントロール可能。

### Application Auto Scaling

Amazon ECS サービス、Amazon EMR クラスター、DynamoDBテーブルなど、EC2の枠を超えた AWS リソースの自動スケーリングを設定する。

### AWS Auto Scaling

複数の AWS リソースを簡単かつ安全にスケーリングするサービス。インフラのコスト削減とアプリのパフォーマンスを最適化可能。複数のサービスにまたがる複数のリソースのスケーリングの場合、個別のスケーリングではなく、AWS Auto Scaling が良い。

### AWS Backup

マネージド型のバックアップサービス。クラウド内およびオンプレミスの AWS のサービス間でデータのバックアップを簡単に一元化及び自動化可能。

### AWS Batch

フルマネージドのバッチ処理サービス。数十万件のバッチ処理が可能で分析系ワークロードの用途に強い。

### AWS Certificate Manager (ACM)

Secure Sockets Layer/Transport Layer Security(SSL/TLS)証明書を AWS で使用するためのサービスで、プロビジョニング、デプロイ、管理を実施する。

### AWD Cloud9

コードの記述、実行、デバッグに使用する AWS 上の統合開発環境(IDE)。

### AWS CloudFormation

インフラを記述してプロビジョニングするためのテンプレートサービス。追加料金なしで利用可能。

### AWS CloudHSM

専用ハードウェアセキュリティモジュール(HSM) アプライアンスを AWS クラウド内で使用できるサービス。データセキュリティに対する社会、契約上、または法令で定められた要件の遵守を支援する。

### AWS Cloud Trail

お客様のアカウントの AWS API コールを記録し、ログファイルをお客様に送信するユーザアクティビティと API 使用状況を追跡するサービス。記録される情報には、 API 呼び出し元の ID、API 呼び出しの時刻、API 呼び出し元のソース IP アドレス、リクエストパラメータおよび AWS サービスから返された応答の情報がある。

### AWS CodeBuild

フルマネージド型の継続的インテグレーションサービスであり、ソースコードをコンパイルし、テストを実行し、デプロイ可能なソフトウェアパッケージを作成可。

### AWS CodeCommit

プライベート Git リポジトリとして、フルマネージドのソースコントロールを行うサービス。安全で極めて拡張性の高いプライベート Git リポジトリを簡単にホスティング可。

### AWS CodeDeploy

オンプレミスで実行中の EC2 インスタンスなど、インスタンスへのコードのデプロイを自動化することでデプロイにおけるダウンタイムを最小化するサービス。

### AWS CodePipeline

アプリの更新をスピードと信頼性を維持する継続的デリバリーサービス。

### AWS Command Line Interface (AWS CLI)

AWS サービスを管理するための、ダウンロードおよび設定が可能な統合ツール。複数の AWS サービスをコマンドラインから制御、スクリプトで自動化。

### AWS Config

AWS リソースの設定を記録し、評価することができるサービス。セキュリティや管理面を向上するため、AWS リソース在庫、設定履歴、設定変更の通知を提供する完全マネージド型サービス。

### AWS Data Pipeline

AWS の異なるサービス間や、オンプレミスのデータソース間でデータの移動を信頼性高く実行できるサービス。

### AWS Direct Connect

オンプレミスから AWS への専用ネットワーク接続を確立する。AWS と顧客のデータセンター、オフィス、またはコロケーション環境との間にプライベート接続を確立可能。

### AWS Directory Service

AWS でのマネージド型の Microsoft Active Directory。AWS リソースを既存のオンプレミス Microsoft Active Directory に接続するか、AWS クラウドに新規のスタンドアロンディレクトリを設定して運用する AWS でのマネージド型の Microsoft Active Directory。

### AWS Elastic Beanstalk

Java、.NET、PHP、Node.js、Python、Ruby、Go および Docker を使用して開発された web アプリを Apache、Nginx、Passenger、IIS など使い慣れたサーバでデプロイおよびスケーリングするサービス。

### AWS Glue

完全マネージド型の抽出、変換、ロード(ETL)サービス。データを検出し、ソースをターゲットに変換するためのスクリプトを開発して、サーバレス環境で ETL ジョブをスケジュールして実行可。

### AWS Idenetity and Access Management (IAM)

利用者が、AWS 内でユーザとユーザアクセス許可を管理できる認証と認可を管理するサービス。

### AWS Key Management Service (AWS KMS)

データの暗号化に使用される暗号化キーの作成と管理を容易にするとともに、証跡を残して可視化するマネージド型サービス。

### AWS Lambda

サーバの管理なしにコードを実行できるコンピューティングサービス。実質どのようなタイプのアプリやバックエンドサービスでも、管理なしでコードを実行可。コードは AWS の他のサービスから自動的にトリガするか、ウェブやモバイルアプリから直接呼び出すように設定可能。

### AWS マネジメントコンソール

コンピューティング、ストレージ、およびその他の AWS のリソースを1つのウェブのインターフェイスから管理できるグラフィカルな画面インターフェイス。

### AWS OpsWorks

Chef や Puppet を使って運用を自動化する構成管理サービス。インスタンスおよびアプリのグループを構成。パッケージのインストール、ソフトウェア設定およびストレージなどのリソースを含む、各コンポーネントのアプリのアーキテクチャおよび使用を定義可。

### AWS Organizations

アカウント全体を一元管理するサービス。作成して一元管理する組織に、複数の AWS アカウントを統合するためのアカウント管理サービス。

### AWS Security Token Service (AWS STS)

一時的なリクエスト、AWS Identity adn Access Management(IAM) ユーザまたは認証するユーザの権限制限の認証情報(フェデレーションユーザ)のためのサービス。

### AWS Shield

マネージド型の分散サービス妨害(DDos)攻撃に対する保護サービス。Amazon EC2 インスタンス、Elastic Load Balancing ロードバランサー、Amazon CloudFront ディストリビューション、Route53 ホストゾーンなどのリソースを DDos 攻撃から保護するのに役立つサービス。追加料金なしで自動的に含まれる。AWS WAF と他の AWS のサービスに対して支払い済みの金額を超えて支払い不要。

### AWS シングルサインオン (SSO)

複数の AWS アカウントおよびビジネスアプリへの SSO アクセスの管理を簡単にするクラウドベースのサービス。AWS Organizations では、全ての AWS アカウントの SSO アクセスとユーザアクセス許可を管理可能。

### AWS Step Functions

分散アプリのコンポーネントを視覚的なワークフローを一連のステップとして管理するワークフロー実行サービス。

### AWS Snowball

AWS クラウドとの大容量データ転送を安全に行うように設計されたトランクのような物理的なデバイスを使用したペタバイト規模のデータ転送ソリューション。

### AWS Storage Gateway

オンプレミスのソフトアプライアンスとクラウドベースのストレージとを接続するストレージサービス。オンプレミス IT 環境と AWS のストレージインフラとを、シームレスに、セキュリティを維持しながら統合。

### AWS Trusted Advisor

AWS 環境を調査し、コストの削減、システムの可用性とパフォーマンスの向上に関するガイダンスを作成。セキュリティのギャップを埋める支援を行うサービス。

### AWS WAF

AWS によるウェブアプリケーションファイアウォールサービス。例えば、リクエストの送信元のヘッダー値または IP アドレスに基づいて、アクセスをフィルター可能。アプリの可用性低下、セキュリティの侵害、リソースの過剰消費に影響を与える一般的なウェブエクスプロイトからウェブアプリケーションを保護。ユーザ指定の基準をもとに、ウェブコンテンツへのアクセスをコントロールする。

## その他

### TL;DR (TLDR)

TL;DRもしくはTLDRとは、「Too Long, Didn’t Read」の略で、「文章が長すぎて、読んでいません」という意味の英語の略語、インターネットスラングのこと。文章が長くて文句を言ったり「長文ウザい」と小馬鹿にしたりといった、ネガティブで非難するニュアンスを含むケースが多い。自らの冗長な文章への自虐的な弁明の場合もある。

エンジニア界隈では、そこから転じて「（長すぎて読めない人のための）要約」の意味でも用いられる。

「;（セミコロン）」は接続詞省略で、「だから」の意味を表す。「tl;dr」など小文字表記も見られる。

*出典: [シマウマ用語集](https://makitani.net/shimauma/tldr)

### フェデレーション（英：federation）

一度認証を通れば、その認証情報を使って、許可されているすべてのサービスを使えるようにする仕組み。
