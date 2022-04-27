# midPoint

> MidPoint is an identity management and governance platform. It is a comprehensive, feature-rich system, developed and maintained by a professional team of full-time engineers. MidPoint is open source software, available under the terms of Apache License and European Union Public License.

## GitHub

- [Evolveum/midpoint](https://github.com/Evolveum/midpoint)
- [Evolveum/midpoint-docker](https://github.com/Evolveum/midpoint-docker)
- [Evolveum/midpoint-samples](https://github.com/Evolveum/midpoint-samples)

## Docs

- [Evolveum Docs](https://docs.evolveum.com/midpoint/)
- [Practical Identity Management With MidPoint](https://docs.evolveum.com/book/practical-identity-management-with-midpoint.html)

## Tips

### How to extend your schema? (どうやってスキーマを定義するの？)

#### 1. create XSD file to add your attributes. (XSD ファイルでスキーマ属性を定義する)

- たとえば、gitlab と連携する際、sshKeys という属性を追加しようとすると、以下のように定義ファイルを作成する。

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>

<xsd:schema elementFormDefault="qualified"
            targetNamespace="http://midpoint.evolveum.com/xml/ns/story/orgsync/ext"
            xmlns:c="http://midpoint.evolveum.com/xml/ns/public/common/common-3"
            xmlns:a="http://prism.evolveum.com/xml/ns/public/annotation-3"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">

    <!-- user extension -->
    <xsd:complexType name="UserTypeExtensionType">
        <xsd:annotation>
            <xsd:appinfo>
                <a:extension ref="c:UserType"/>
            </xsd:appinfo>
        </xsd:annotation>
        <xsd:sequence>
            <xsd:element name="sshKeys" type="xsd:string" minOccurs="0" maxOccurs="unbounded">
                <xsd:annotation>
                        <xsd:appinfo>
                            <a:indexed>false</a:indexed>
                        </xsd:appinfo>
                </xsd:annotation>
            </xsd:element>
        </xsd:sequence>
    </xsd:complexType>
</xsd:schema>
```

#### 2. copy the file to midpoint directory. (そのファイルをmidpointディレクトリにコピーする)

- ファイルを /opt/midpoint/var/schema にコピーする。

#### 3. restart midpoint server. (midpointサーバを再起動する)

- 再起動できたら、正しく追加された属性が確認できると思われます。

Ref: [MidPoint Tutorial, Chapter VI: Schema](https://www.youtube.com/watch?v=9ipACsFmmyc)
