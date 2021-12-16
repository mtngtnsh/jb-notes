# midPoint + Keycloack + GitLab

## 1. About keycloak settings

### 1) Starting Keycloak with docker

```docker
docker run -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin quay.io/keycloak/keycloak:16.1.0
```

### 2) Note the RS256 certification of master realm

```text
-----BEGIN CERTIFICATE-----
MIICmzCCAYMCBgF94oc1+TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMjIyMTQyMjMxWhcNMzExMjIyMTQyNDExWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCfhUTZIhyOTtDkc5qWuJArk103NniXbPs21BdA+1Bs0/RqgbaKASt9CP7MigS/yvx4CuM5AoWM813Kd6IUP18aCJ55u28NUI6G7DfU42SV7qqp5yvn+Wf24Kjvd5pJz6079wI/3Eqd/yUnXPv43BBfb9CvJKSLWds51YKaGwT1FbYZYtb0D1NZg5a24YAFfG7RVl1SAZW6eimXPLgUiUMHOJlVgUPw+PFklEVbVTJMI8Iiy9EzDG6kenn3LZ9mndxtSY4cBMzrf0fKX/FUdEdoicnD2Fb3TQL9BL4McvUMdg60DVRL5106tkvQajCoQFAxfIlQO/DhpGXvSZ7+2IMlAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAISGthr3+kCe++JA1PVqhYkpNhF+EQflTe9iOq/EBJNtAZOV5FsIUx7BEOPKqeZwSseEgUsR/b33Ks7+TIeBC1nnHgvVr7wSBqRr/tN7EXXrWLPWtQOshizSezj2bJASEHOkMRl31WnHFhnN49eknxYH5PCLrYdeOxG4ICbd35EgZHMtaeIDB2NCYZvZAHq9m6mtqpI8e8AC+OtDHAupQZ33I8k/aegB1Z0NG+W6t3t1e7ywsuRN+ujQqMFMDRkgdGS/L2gZI/UmiP/biWGcpvK5qora+We/fkTbKYET8LZogjnYNgMkcTMVO2wODDXZviFjPTJp331pd7iMFtllQKs=
-----END CERTIFICATE-----
```

### 3) Create GitLab client and modify settings

```text
Client ID: localhost:8929
Name: gitlab
Enabled: ON
Client Protocol: saml
Include AuthStatement: ON
Sign Documents: ON
Signature Algorithm: RSA_SHA256
SAML Signature Key Name: KEY_ID
Canonicalization Method: EXCLUSIVE
Force POST Binding: ON
Front Channel Logout: ON
Name ID Format: persistent
Root URL: http://localhost:8929
Valid Redirect URL: http://localhost:8929/*
Base URL: /
Master SAML Processing URL: http://localhost:8929/users/auth/saml/callback
IDP Initiated SSO URL Name: http://localhost:8929
Assertion Consumer Service POST Binding URL: http://localhost:8929/users/auth/saml/callback
```

![key_settings_1](../img/key_settings_1.png)

![key_settings_2](../img/key_settings_2.png)

### 4) Modify mappers

```text
    Email
        Name：email
        Mapper Property：User Property
        Property：Email
        Friendly Name：Email
        SAML Attribute Name：email
        SAML Attribute NameFormat：Basic
    First_Name
        Name：first_name
        Mapper Property：User Property
        Property：FirstName
        Friendly Name：First Name
        SAML Attribute Name：first_name
        SAML Attribute NameFormat：Basic
    Last_Name
        Name：last_name
        Mapper Property：User Property
        Property：LastName
        Friendly Name：Last Name
        SAML Attribute Name：name
        SAML Attribute NameFormat：Basic
    Username
        Name：username
        Mapper Property：User Property
        Property：UserName
        Friendly Name：User Name
        SAML Attribute Name：name
        SAML Attribute NameFormat：Basic
    Roles
        Name：roles
        Mapper Property：Role List
        Role attribute name：roles
        Friendly Name：Roles
        SAML Attribute NameFormat：Basic
        Single Role Attribute：ON

```

![key_settings_3](../img/key_settings_3.png)

## 2. About GitLab settings

Ref:

- [gitlab-ce Dockerhub tags](https://hub.docker.com/r/gitlab/gitlab-ce/tags)
- [GitLab Mattermost でダブルSSOしてみた](https://qiita.com/ymasaoka/items/482a92cb7898c1b53e7c)
- [シングルサインオンサービスKeycloakとGitLabを連携する](https://qiita.com/myoshimi/items/37c90c2a63dca295edb4)

**TODO**:gitlabのログインアカウントPWをymlでセットするように

```sh
# openssl x509 -sha1 -fingerprint -noout -in gitlab-sso.pem
```

### 1) GitLab config yaml

```yaml
version: '3.8'

services:
  web:
    image: 'gitlab/gitlab-ce:14.5.2-ce.0'
    restart: always
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://localhost:8929'
        gitlab_rails['gitlab_shell_ssh_port'] = 2224
        mattermost_external_url 'http://localhost:8001'
        gitlab_rails['omniauth_enabled'] = true
        gitlab_rails['omniauth_allow_single_sign_on'] = ['saml']
        gitlab_rails['omniauth_block_auto_created_users'] = false
        gitlab_rails['omniauth_auto_link_saml_user'] = true
        gitlab_rails['omniauth_providers'] = [
          {
            name: 'saml',
            label: 'Keycloak Login',
            groups_attribute: 'roles',
            args: {
              assertion_consumer_service_url: 'http://localhost:8929/users/auth/saml/callback',
              idp_sso_target_url: 'http://localhost:8080/auth/realms/master/protocol/saml',
              issuer: 'localhost:8929',
              idp_cert: '-----BEGIN CERTIFICATE-----
                MIICmzCCAYMCBgF94oc1+TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjExMjIyMTQyMjMxWhcNMzExMjIyMTQyNDExWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCfhUTZIhyOTtDkc5qWuJArk103NniXbPs21BdA+1Bs0/RqgbaKASt9CP7MigS/yvx4CuM5AoWM813Kd6IUP18aCJ55u28NUI6G7DfU42SV7qqp5yvn+Wf24Kjvd5pJz6079wI/3Eqd/yUnXPv43BBfb9CvJKSLWds51YKaGwT1FbYZYtb0D1NZg5a24YAFfG7RVl1SAZW6eimXPLgUiUMHOJlVgUPw+PFklEVbVTJMI8Iiy9EzDG6kenn3LZ9mndxtSY4cBMzrf0fKX/FUdEdoicnD2Fb3TQL9BL4McvUMdg60DVRL5106tkvQajCoQFAxfIlQO/DhpGXvSZ7+2IMlAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAISGthr3+kCe++JA1PVqhYkpNhF+EQflTe9iOq/EBJNtAZOV5FsIUx7BEOPKqeZwSseEgUsR/b33Ks7+TIeBC1nnHgvVr7wSBqRr/tN7EXXrWLPWtQOshizSezj2bJASEHOkMRl31WnHFhnN49eknxYH5PCLrYdeOxG4ICbd35EgZHMtaeIDB2NCYZvZAHq9m6mtqpI8e8AC+OtDHAupQZ33I8k/aegB1Z0NG+W6t3t1e7ywsuRN+ujQqMFMDRkgdGS/L2gZI/UmiP/biWGcpvK5qora+We/fkTbKYET8LZogjnYNgMkcTMVO2wODDXZviFjPTJp331pd7iMFtllQKs= 
                -----END CERTIFICATE-----',
              name_identifier_format: 'urn:oasis:names:tc:SAML:2.0:nameid-format:persistent',
              attribute_statements: {
                first_name: ['first_name'],
                last_name: ['last_name'],
                username: ['name'],
                email: ['email']
              }
            }
          }
        ]
    ports:
      - '8001:8001'
      - '2224:22'
      - '8929:8929'
      - '10080:80'
      - '10443:443'
    volumes:
      - gitlab_config:/etc/gitlab
      - gitlab_logs:/var/log/gitlab
      - gitlab_data:/var/opt/gitlab

volumes:
  gitlab_config:
  gitlab_logs:
  gitlab_data:
```

### 2) docker-compose -f xxx.yml up -d

## 3. About midPoint settings

### 1) midPoint  config yaml

```yaml
version: "3.8"

services:
  midpoint:
    image: evolveum/midpoint:${MP_VERSION:-4.4}-alpine
    restart: always 
    container_name: midpoint-4.4
    ports:
      - "7001:8080"
    volumes:
      - midpoint_home:/opt/midpoint/var

volumes:
  midpoint_home:
    name: midpoint-4.4
```

### 2) Download Keycloak connector and place to midPoint home directory

[keycloak connector Github release](https://github.com/openstandia/connector-keycloak/releases)

```sh
curl -LO "https://search.maven.org/remotecontent?filepath=jp/openstandia/connector/connector-keycloak/1.1.2/connector-keycloak-1.1.2.jar"
```

```sh
docker cp connector-keycloak-1.1.2.jar midpoint-4.4:/opt/midpoint/var/icf-connectors
```

### 3) midpoint + keycloak

- [KeycloakとmidPointを連携させてみよう(connector-keycloak編)](https://qiita.com/wadahiro/items/ec4ccf18d6fa14e215c4)

```xml
<resource xmlns="http://midpoint.evolveum.com/xml/ns/public/common/common-3" xmlns:c="http://midpoint.evolveum.com/xml/ns/public/common/common-3" xmlns:icfs="http://midpoint.evolveum.com/xml/ns/public/connector/icf-1/resource-schema-3" xmlns:org="http://midpoint.evolveum.com/xml/ns/public/common/org-3" xmlns:q="http://prism.evolveum.com/xml/ns/public/query-3" xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3" xmlns:t="http://prism.evolveum.com/xml/ns/public/types-3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" oid="d8fca210-c37c-4080-b497-8d19ec09f83e" version="20">
    <name>keycloak</name>
    <metadata>
        <modifyTimestamp>2021-12-23T02:12:54.417Z</modifyTimestamp>
        <modifierRef oid="00000000-0000-0000-0000-000000000002" relation="org:default" type="c:UserType">
            <!-- administrator -->
        </modifierRef>
        <modifyChannel>http://midpoint.evolveum.com/xml/ns/public/common/channels-3#user</modifyChannel>
    </metadata>
    <iteration>0</iteration>
    <connectorRef oid="b1764267-a0d3-473e-ab05-f0950817d157" relation="org:default" type="c:ConnectorType">
        <!-- ConnId jp.openstandia.connector.keycloak.KeycloakConnector v1.1.2 -->
    </connectorRef>
    <connectorConfiguration xmlns:icfc="http://midpoint.evolveum.com/xml/ns/public/connector/icf-1/connector-schema-3">
        <icfc:configurationProperties xmlns:gen364="http://midpoint.evolveum.com/xml/ns/public/connector/icf-1/bundle/jp.openstandia.connector.connector-keycloak/jp.openstandia.connector.keycloak.KeycloakConnector">
            <gen364:serverUrl>http://192.168.3.24:8080/auth</gen364:serverUrl>
            <gen364:username>admin</gen364:username>
            <gen364:password>
                <t:encryptedData>
                    <t:encryptionMethod>
                        <t:algorithm>http://www.w3.org/2001/04/xmlenc#aes256-cbc</t:algorithm>
                    </t:encryptionMethod>
                    <t:keyInfo>
                        <t:keyName>rp167H4HSYaULZBMtyjWcrHNioM=</t:keyName>
                    </t:keyInfo>
                    <t:cipherData>
                        <t:cipherValue>zB/9nKzuL86t8GKCizb8mdcXX4mDDWWBj/MYveTU5hs=</t:cipherValue>
                    </t:cipherData>
                </t:encryptedData>
            </gen364:password>
            <gen364:clientId>admin-cli</gen364:clientId>
            <gen364:realmName>master</gen364:realmName>
            <gen364:targetRealmName>master</gen364:targetRealmName>
        </icfc:configurationProperties>
    </connectorConfiguration>
    <schema>
        <cachingMetadata>
            <retrievalTimestamp>2021-12-23T01:48:28.044Z</retrievalTimestamp>
            <serialNumber>581360d3ad0f8e1-1d73b96a7401f895</serialNumber>
        </cachingMetadata>
        <definition>
            <xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:a="http://prism.evolveum.com/xml/ns/public/annotation-3" xmlns:ra="http://midpoint.evolveum.com/xml/ns/public/resource/annotation-3" xmlns:tns="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3" elementFormDefault="qualified" targetNamespace="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3" xmlns:t="http://prism.evolveum.com/xml/ns/public/types-3">
                <xsd:import namespace="http://prism.evolveum.com/xml/ns/public/types-3"/>
                <xsd:import namespace="http://prism.evolveum.com/xml/ns/public/annotation-3"/>
                <xsd:import namespace="http://midpoint.evolveum.com/xml/ns/public/resource/annotation-3"/>
                <xsd:complexType name="group">
                    <xsd:annotation>
                        <xsd:appinfo>
                            <ra:resourceObject/>
                            <ra:identifier xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:groupId</ra:identifier>
                            <ra:secondaryIdentifier xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:name</ra:secondaryIdentifier>
                            <ra:displayNameAttribute xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:name</ra:displayNameAttribute>
                            <ra:namingAttribute xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:name</ra:namingAttribute>
                            <ra:nativeObjectClass>group</ra:nativeObjectClass>
                        </xsd:appinfo>
                    </xsd:annotation>
                    <xsd:sequence>
                        <xsd:element minOccurs="0" name="path" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>120</a:displayOrder>
                                    <a:access>read</a:access>
                                    <a:matchingRule xmlns:qn24="http://prism.evolveum.com/xml/ns/public/matching-rule-3">qn24:stringIgnoreCase</a:matchingRule>
                                    <ra:frameworkAttributeName>path</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="parentGroup" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>130</a:displayOrder>
                                    <ra:frameworkAttributeName>parentGroup</ra:frameworkAttributeName>
                                    <ra:returnedByDefault>false</ra:returnedByDefault>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element name="name" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>110</a:displayOrder>
                                    <a:matchingRule xmlns:qn955="http://prism.evolveum.com/xml/ns/public/matching-rule-3">qn955:stringIgnoreCase</a:matchingRule>
                                    <ra:nativeAttributeName>name</ra:nativeAttributeName>
                                    <ra:frameworkAttributeName>__NAME__</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="groupId" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>100</a:displayOrder>
                                    <a:access>read</a:access>
                                    <ra:nativeAttributeName>groupId</ra:nativeAttributeName>
                                    <ra:frameworkAttributeName>__UID__</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                    </xsd:sequence>
                </xsd:complexType>
                <xsd:complexType name="user">
                    <xsd:annotation>
                        <xsd:appinfo>
                            <ra:resourceObject/>
                            <ra:identifier xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:userId</ra:identifier>
                            <ra:secondaryIdentifier xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:username</ra:secondaryIdentifier>
                            <ra:displayNameAttribute xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:username</ra:displayNameAttribute>
                            <ra:namingAttribute xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:username</ra:namingAttribute>
                            <ra:nativeObjectClass>user</ra:nativeObjectClass>
                        </xsd:appinfo>
                    </xsd:annotation>
                    <xsd:sequence>
                        <xsd:element maxOccurs="unbounded" minOccurs="0" name="groups" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>120</a:displayOrder>
                                    <ra:frameworkAttributeName>groups</ra:frameworkAttributeName>
                                    <ra:returnedByDefault>false</ra:returnedByDefault>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="lastName" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>130</a:displayOrder>
                                    <ra:frameworkAttributeName>lastName</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="firstName" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>140</a:displayOrder>
                                    <ra:frameworkAttributeName>firstName</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element name="username" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>110</a:displayOrder>
                                    <a:matchingRule xmlns:qn285="http://prism.evolveum.com/xml/ns/public/matching-rule-3">qn285:stringIgnoreCase</a:matchingRule>
                                    <ra:nativeAttributeName>username</ra:nativeAttributeName>
                                    <ra:frameworkAttributeName>__NAME__</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="createdTimestamp" type="xsd:dateTime">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>150</a:displayOrder>
                                    <a:access>read</a:access>
                                    <ra:frameworkAttributeName>createdTimestamp</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="email" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>160</a:displayOrder>
                                    <a:matchingRule xmlns:qn371="http://prism.evolveum.com/xml/ns/public/matching-rule-3">qn371:stringIgnoreCase</a:matchingRule>
                                    <ra:frameworkAttributeName>email</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="emailVerified" type="xsd:boolean">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>170</a:displayOrder>
                                    <ra:frameworkAttributeName>emailVerified</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="userId" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>100</a:displayOrder>
                                    <a:access>read</a:access>
                                    <ra:nativeAttributeName>userId</ra:nativeAttributeName>
                                    <ra:frameworkAttributeName>__UID__</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                    </xsd:sequence>
                </xsd:complexType>
                <xsd:complexType name="clientRole">
                    <xsd:annotation>
                        <xsd:appinfo>
                            <ra:resourceObject/>
                            <ra:identifier xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:clientRoleId</ra:identifier>
                            <ra:secondaryIdentifier xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:name</ra:secondaryIdentifier>
                            <ra:displayNameAttribute xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:name</ra:displayNameAttribute>
                            <ra:namingAttribute xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:name</ra:namingAttribute>
                            <ra:nativeObjectClass>clientRole</ra:nativeObjectClass>
                        </xsd:appinfo>
                    </xsd:annotation>
                    <xsd:sequence>
                        <xsd:element maxOccurs="unbounded" minOccurs="0" name="attributes" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>120</a:displayOrder>
                                    <ra:frameworkAttributeName>attributes</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="description" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>130</a:displayOrder>
                                    <ra:frameworkAttributeName>description</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element name="name" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>110</a:displayOrder>
                                    <a:matchingRule xmlns:qn16="http://prism.evolveum.com/xml/ns/public/matching-rule-3">qn16:stringIgnoreCase</a:matchingRule>
                                    <ra:nativeAttributeName>name</ra:nativeAttributeName>
                                    <ra:frameworkAttributeName>__NAME__</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="clientRoleId" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>100</a:displayOrder>
                                    <a:access>read</a:access>
                                    <ra:nativeAttributeName>clientRoleId</ra:nativeAttributeName>
                                    <ra:frameworkAttributeName>__UID__</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                    </xsd:sequence>
                </xsd:complexType>
                <xsd:complexType name="client">
                    <xsd:annotation>
                        <xsd:appinfo>
                            <ra:resourceObject/>
                            <ra:identifier xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:clientUUID</ra:identifier>
                            <ra:secondaryIdentifier xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:clientId</ra:secondaryIdentifier>
                            <ra:displayNameAttribute xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:clientId</ra:displayNameAttribute>
                            <ra:namingAttribute xmlns:ri="http://midpoint.evolveum.com/xml/ns/public/resource/instance-3">ri:clientId</ra:namingAttribute>
                            <ra:nativeObjectClass>client</ra:nativeObjectClass>
                        </xsd:appinfo>
                    </xsd:annotation>
                    <xsd:sequence>
                        <xsd:element maxOccurs="unbounded" minOccurs="0" name="attributes" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>120</a:displayOrder>
                                    <ra:frameworkAttributeName>attributes</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="serviceAccountsEnabled" type="xsd:boolean">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>130</a:displayOrder>
                                    <ra:frameworkAttributeName>serviceAccountsEnabled</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="adminUrl" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>140</a:displayOrder>
                                    <ra:frameworkAttributeName>adminUrl</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="rootUrl" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>150</a:displayOrder>
                                    <ra:frameworkAttributeName>rootUrl</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="publicClient" type="xsd:boolean">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>160</a:displayOrder>
                                    <ra:frameworkAttributeName>publicClient</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="baseUrl" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>170</a:displayOrder>
                                    <ra:frameworkAttributeName>baseUrl</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="authorizationServicesEnabled" type="xsd:boolean">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>180</a:displayOrder>
                                    <ra:frameworkAttributeName>authorizationServicesEnabled</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="directAccessGrantsEnabled" type="xsd:boolean">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>190</a:displayOrder>
                                    <ra:frameworkAttributeName>directAccessGrantsEnabled</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element name="protocol" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>200</a:displayOrder>
                                    <a:access>create</a:access>
                                    <a:access>read</a:access>
                                    <ra:frameworkAttributeName>protocol</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element maxOccurs="unbounded" minOccurs="0" name="webOrigins" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>210</a:displayOrder>
                                    <ra:frameworkAttributeName>webOrigins</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="name" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>220</a:displayOrder>
                                    <ra:frameworkAttributeName>name</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="origin" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>230</a:displayOrder>
                                    <ra:frameworkAttributeName>origin</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="standardFlowEnabled" type="xsd:boolean">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>240</a:displayOrder>
                                    <ra:frameworkAttributeName>standardFlowEnabled</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="description" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>250</a:displayOrder>
                                    <ra:frameworkAttributeName>description</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element maxOccurs="unbounded" minOccurs="0" name="redirectUris" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>260</a:displayOrder>
                                    <ra:frameworkAttributeName>redirectUris</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="implicitFlowEnabled" type="xsd:boolean">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>270</a:displayOrder>
                                    <ra:frameworkAttributeName>implicitFlowEnabled</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element name="clientId" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>110</a:displayOrder>
                                    <a:matchingRule xmlns:qn495="http://prism.evolveum.com/xml/ns/public/matching-rule-3">qn495:stringIgnoreCase</a:matchingRule>
                                    <ra:nativeAttributeName>clientId</ra:nativeAttributeName>
                                    <ra:frameworkAttributeName>__NAME__</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="secret" type="t:ProtectedStringType">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>280</a:displayOrder>
                                    <ra:frameworkAttributeName>secret</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="bearerOnly" type="xsd:boolean">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>290</a:displayOrder>
                                    <ra:frameworkAttributeName>bearerOnly</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                        <xsd:element minOccurs="0" name="clientUUID" type="xsd:string">
                            <xsd:annotation>
                                <xsd:appinfo>
                                    <a:displayOrder>100</a:displayOrder>
                                    <a:access>read</a:access>
                                    <ra:nativeAttributeName>clientUUID</ra:nativeAttributeName>
                                    <ra:frameworkAttributeName>__UID__</ra:frameworkAttributeName>
                                </xsd:appinfo>
                            </xsd:annotation>
                        </xsd:element>
                    </xsd:sequence>
                </xsd:complexType>
            </xsd:schema>
        </definition>
    </schema>
    <schemaHandling>
        <objectType id="11">
            <kind>account</kind>
            <intent>default</intent>
            <displayName>user</displayName>
            <default>true</default>
            <objectClass>ri:user</objectClass>
            <attribute id="12">
                <ref>ri:email</ref>
                <tolerant>true</tolerant>
                <exclusiveStrong>false</exclusiveStrong>
                <outbound>
                    <authoritative>true</authoritative>
                    <exclusive>false</exclusive>
                    <strength>strong</strength>
                    <source>
                        <path>$focus/emailAddress</path>
                    </source>
                </outbound>
            </attribute>
            <attribute id="13">
                <ref>ri:firstName</ref>
                <tolerant>true</tolerant>
                <exclusiveStrong>false</exclusiveStrong>
                <outbound>
                    <authoritative>true</authoritative>
                    <exclusive>false</exclusive>
                    <strength>strong</strength>
                    <source>
                        <path>$focus/givenName</path>
                    </source>
                </outbound>
            </attribute>
            <attribute id="14">
                <ref>ri:lastName</ref>
                <tolerant>true</tolerant>
                <exclusiveStrong>false</exclusiveStrong>
                <outbound>
                    <authoritative>true</authoritative>
                    <exclusive>false</exclusive>
                    <strength>strong</strength>
                    <source>
                        <path>$focus/familyName</path>
                    </source>
                </outbound>
            </attribute>
            <attribute id="15">
                <ref>ri:username</ref>
                <tolerant>true</tolerant>
                <exclusiveStrong>false</exclusiveStrong>
                <outbound>
                    <authoritative>true</authoritative>
                    <exclusive>false</exclusive>
                    <strength>strong</strength>
                    <source>
                        <path>$focus/name</path>
                    </source>
                </outbound>
            </attribute>
        </objectType>
    </schemaHandling>
    <capabilities>
        <cachingMetadata>
            <retrievalTimestamp>2021-12-23T01:48:28.022Z</retrievalTimestamp>
            <serialNumber>a929fe097692697d-7870fdab770dde0</serialNumber>
        </cachingMetadata>
        <native xmlns:cap="http://midpoint.evolveum.com/xml/ns/public/resource/capabilities-3">
            <cap:schema/>
            <cap:testConnection/>
            <cap:create/>
            <cap:update>
                <cap:delta>true</cap:delta>
                <cap:addRemoveAttributeValues>true</cap:addRemoveAttributeValues>
            </cap:update>
            <cap:delete/>
            <cap:script>
                <cap:host>
                    <cap:type>connector</cap:type>
                </cap:host>
            </cap:script>
            <cap:activation>
                <cap:status/>
            </cap:activation>
            <cap:credentials>
                <cap:password>
                    <cap:returnedByDefault>false</cap:returnedByDefault>
                </cap:password>
            </cap:credentials>
            <cap:read>
                <cap:returnDefaultAttributesOption>true</cap:returnDefaultAttributesOption>
            </cap:read>
        </native>
    </capabilities>
</resource>
```

## 4. Appendix

Change the "User Enabled" >>> ON, while user which created by midPoint, couldn't login GitLab.

![key_settings_4](../img/key_settings_4.png)
