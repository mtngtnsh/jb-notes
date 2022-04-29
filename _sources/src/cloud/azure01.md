# Azure

## デモ1(Python): Azure Batch サービスクライアントを作成する

環境:

- Python 3.8.x 以降

::: {note}
:class: dropdown
```
import adal
import cryptography.x509
import cryptography.hazmat.primitives
import binascii

import msrestazure.azure_active_directory
import azure.batch
import azure.identity
import azure.mgmt.batch


def create_batch_service(tenant_id, client_id, cert_path, batch_url, proxies=None):
    '''azure.batch.BatchServiceClientを作成する

    Parameters
    ----------
    tenant_id: str
        テナントID
    client_id: str
        サービスプリンシパルのクライアントID
    cert_path: str
        証明書ファイルのパス
    batch_url: str
        Azure BatchのエンドポイントURL
    proxies: str
        プロキシサーバのURL
    
    Ruturns
    ----------
    BatchServiceClient
        Azure Batch サービスアクセス用クライアント
    '''
    # AzureActiveDirectoryの認証コンテキスト取得
    context = adal.AuthenticationContext('https://login.microsoftonline.com/' + tenant_id, proxies=proxies)

    # 秘密鍵と証明書が格納されたファイルを読み込み
    with open(cert_path) as f:
        key_cert = f.read()
    
    # 証明書からSHA1フィンガープリントを16進文字列で取得
    certificate = cryptography.x509.load_pem_x509_certificate(key_cert.encode())
    finger_print = certificate.fingerprint(cryptography.hazmat.primitives.hashes.SHA1())
    finger_print_hex = str(binascii.hexlify(finger_print), 'utf-8')

    # 秘密鍵とフィンガプリントでAzureActiveDirectoryから認証トークンを取得
    token = context.acquire_token_with_client_certificate(
        resource='https://batch.core.windows.net/',
        client_id=client_id,
        certificate=key_cert,
        thumbprint=finger_print_hex
    )

    # 認証トークンをベースにクレデンシャルを作成
    credential =  msrestazure.azure_active_directory.AADTokenCredentials(
        token=token,
        client_id=client_id
    )

    # BatchServiceClient作成
    return azure.batch.BatchServiceClient(credential, batch_url)
```

:::

## デモ2(Python): プールを再作成する(定期的に実行可)

前提としては、再作成プールの定義ファイルは別途で用意すること。*.jsonや *.j2でも可。
本でもの場合、.jsonを使用。

**<<フロー>>**  

1. オートスケールで設定しているプールに対して、オートスケールを無効にする
2. 稼働しているプールをリサイズする(プール数を0に指定してリサイズ)
3. 割り当て状態が steady になるまで待つ
4. プールを削除する
5. プールを作成する

### 1. オートスケールで設定しているプールに対して、オートスケールを無効にする

::: {note}
:class: dropdown
```
# 複数プールの場合に適応(proc_codeはプールの処理状態を表す値にセットする、本デモはその部分を省略する)
target_pool_dict = {"p_id1": proc_code0, "p_id2": proc_code0}

def _disable_auto_scale(batch_service, target_pool_dict):
    '''オートスケールを無効にする

    '''
    for p_id in target_pool_dict.keys():
        # 現在のオートスケールフラグを確認
        auto_scale_flag = batch_service.pool.get(p_id).enable_auto_scale

        # オートスケールが無効化されている場合は処理しない
        if not auto_scale_flag:
            continue

        # オートスケールを無効化
        batch_service.pool.disable_auto_scale(p_id)
 
        # 再度オートスケールフラグを確認
        auto_scale_flag = batch_service.pool.get(p_id).enable_auto_scale
```

:::

### 2. 稼働しているプールをリサイズする(プール数を0に指定してリサイズ)

::: {note}
:class: dropdown
```
# 複数プールの場合に適応(proc_codeはプールの処理状態を表す値にセットする、本デモはその部分を省略する)
target_pool_dict = {"p_id1": proc_code0, "p_id2": proc_code0}
RESIZE_NODE_NUM = 0
RESIZE_TIMEOUT = 30

def _resize_pools(batch_service, target_pool_dict):
    '''プールをリサイズする

    '''
    for p_id in target_pool_dict.keys():
        p_allocation_state = batch_service.pool.get(p_id).allocation_state

        # リサイズする前、resizing である場合、resizing を停止する
        if p_allocation_state == 'resizing':
            ...
            ...

        resize_option = azure.batch.models.PoolResizeParameter(
            target_dedicated_nodes=RESIZE_NODE_NUM,
            node_deallocation_option='taskCompletion',
            resize_timeout=timedelta(minutes=RESIZE_TIMEOUT)
        )
        batch_service.pool.resize(p_id, resize_option)
```

:::

### 3. 割り当て状態が steady になるまで待つ

::: {note}
:class: dropdown
```
# 複数プールの場合に適応(proc_codeはプールの処理状態を表す値にセットする、本デモはその部分を省略する)
target_pool_dict = {"p_id1": proc_code0, "p_id2": proc_code0}
POLLING_COUNT = 5
WAITING_TIME = 5

def _resize_until_steady(batch_service, target_pool_dict):
    '''プールごとに割り当て状態が steady になるまでまつ

    '''
    for p_id in target_pool_dict.keys():
        for i in range(1, POLLING_COUNT + 1, 1):
            p_allocation_state = batch_service.pool.get(p_id).allocation_state
            
            if p_allocation_state == 'steady':
                break

            sleep(WAITING_TIME)
        else:
            ...
```

:::

### 4. プールを削除する

::: {note}
:class: dropdown
```
# 複数プールの場合に適応(proc_codeはプールの処理状態を表す値にセットする、本デモはその部分を省略する)
target_pool_dict = {"p_id1": proc_code0, "p_id2": proc_code0}

def _delete_pools(batch_service, target_pool_dict):
    '''プールを削除する

    '''
    for p_id, p_error in target_pool_dict.keys():
        # プール削除処理
        batch_service.pool.delete(p_id)

```

:::

### 5-1. プールの作成: プール定義ファイルの値を取得して整形する

::: {note}
:class: dropdown
```
# 複数プールの場合に適応(proc_codeはプールの処理状態を表す値にセットする、本デモはその部分を省略する)
# 共通の定義を'common-config'に定義、異なる部分は、プール名で分けて定義する
target_pool_dict = {"p_id1": proc_code0, "p_id2": proc_code0}

def _format_pools_config(target_pool_dict, pool_config):
    '''プール設定JSONファイルから値を取得して整形する

    '''
    target_pool_config = {}

    for p_id in target_pool_dict.keys():
        # 対象プールの設定情報を取得する
        p_config = pool_config[p_id]

        # environment settings を整形する
        environment_settings = []
        for i in range(len(pool_config['common-config']['startTask']['environmentSettings'])):
            environment_settings.append(
                {
                    'name':pool_config['common-config']['startTask']['environmentSettings'][i]['name'],
                    'value':pool_config['common-config']['startTask']['environmentSettings'][i]['value'],
                }
            )

        # オートスケール対象のプールかどうかに応じてターゲットノード数を設定する
        if p_config.get('enableAutoScale'):
            target_dedicated_nodes = None
            enable_auto_scale = p_config['enableAutoScale']
            auto_scale_formula = p_config['autoScaleFormula']
            auto_scale_evaluation_interval = p_config['autoScaleEvaluationInterval']
        else:
            target_dedicated_nodes = p_config['targetDedicatedNodes']
            enable_auto_scale = pool_config['common-config']['enableAutoScale']
            auto_scale_formula = None
            auto_scale_evaluation_interval = None
        
        # プール情報を取得する
        new_pool = azure.batch.models.PoolAddParameter(
            id = p_id,
            display_name = p_id,
            virtual_machine_configuration = azure.batch.models.VirtualMachineConfiguration(
                image_reference = azure.batch.models.ImageReference(
                    publisher = p_config['virtualMachineConfiguration']['imageReference']['publisher'],
                    offer = p_config['virtualMachineConfiguration']['imageReference']['offer'],
                    sku = p_config['virtualMachineConfiguration']['imageReference']['sku'],
                    version = p_config['virtualMachineConfiguration']['imageReference']['version']
                ),
                node_agent_sku_id = p_config['virtualMachineConfiguration']['nodeAgentSKUId'],
                container_configuration = azure.batch.models.ContainerConfiguration(
                    type = p_config['virtualMachineConfiguration']['containerConfiguration']['type'],
                    container_registries = [
                        azure.batch.models.ContainerRegistry(
                            registry_server = p_config['virtualMachineConfiguration']['containerConfiguration']['containerRegistries'][0]['registryServer'],
                            user_name = p_config['virtualMachineConfiguration']['containerConfiguration']['containerRegistries'][0]['username'],
                            password = p_config['virtualMachineConfiguration']['containerConfiguration']['containerRegistries'][0]['password']
                        )
                    ]
                ),
                disk_encryption_configuration = azure.batch.models.DiskEncryptionConfiguration(
                    target = [
                        p_config['virtualMachineConfiguration']['diskEncryptionConfiguration']['targets'][0],
                        p_config['virtualMachineConfiguration']['diskEncryptionConfiguration']['targets'][1]
                    ]
                )                
            ),
            vm_size = p_config['vmSize'],
            # オートスケーリングの設定が異なる
            target_dedicated_nodes = target_dedicated_nodes,
            # 隔離 vnet 外に作成されないため追加する
            network_configuration = azure.batch.models.NetworkConfiguration(
                subnet_id = pool_config['common-config']['networkConfiguration']['subnetId'],
                dynamic_vnet_assignment_scope = azure.batch.models.DynamicVNetAssignmentScope(
                    pool_config['common-config']['networkConfiguration']['dynamicCNetAssignmentScope']
                ),
                public_ip_address_configuration = azure.batch.models.PublicIPAddressConfiguration(
                    provision = pool_config['common-config']['networkConfiguration']['publicIPAddressConfiguration']['provision']
                )
            ),
            # 開始タスクを設定
            start_task = azure.batch.models.StartTask(
                command_line = pool_config['common-config']['startTask']['commandLine'],
                environment_settings = environment_settings,
                user_identity = azure.batch.models.UserIdentity(
                    auto_user = azure.batch.models.AutoUserSpecification(
                        scope = pool_config['common-config']['startTask']['userIdentity']['autoUser']['scope'],
                        elevation_level = pool_config['common-config']['startTask']['userIdentity']['autoUser']['elevationLevel']
                    )
                ),
                max_task_retry_count = pool_config['common-config']['startTask']['maxTaskRetryCount'],
                wait_for_success = pool_config['common-config']['startTask']['waitForSuccess']
            ),
            task_slots_per_node = pool_config['common-config']['taskSlotsPerNode'],
            task_scheduling_policy = azure.batch.models.TaskSchedulingPolicy(
                node_fill_type = pool_config['common-config']['taskSchedulingPolicy']['nodeFillType']
            ),
            # オートスケール評価即時開始の対応
            enable_auto_scale = enable_auto_scale,
            auto_scale_formula = auto_scale_formula,
            auto_scale_evaluation_interval = auto_scale_evaluation_interval
        )
        target_pool_config[p_id] = new_pool
    return target_pool_config

```

:::

### 5-2. プールの作成: 複数プールをまとめて作成する

::: {note}
:class: dropdown
```
# 複数プールの場合に適応(proc_codeはプールの処理状態を表す値にセットする、本デモはその部分を省略する)
target_pool_dict = {"p_id1": proc_code0, "p_id2": proc_code0}

def _create_pools(batch_service, target_pool_dict, target_pool_config, pool_config):
    '''プールを作成する

    '''
    for p_id in target_pool_dict.keys():
        # 対象プールのせってい情報を取得
        p_config = pool_config[p_id]

        # プールを作成
        batch_service.pool.id.add(target_pool_config[p_id])
```

:::
