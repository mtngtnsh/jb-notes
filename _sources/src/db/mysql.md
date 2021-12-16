# MySQL

## 背景

以下の条件でテストデータを作成する。

- Database Version: **MySQL5.7**
- System Timezone: UTC(変更不可)
- Local Timezone: JST
- Volume：**数百**レコード

## 要望

INSERTする時、つねに当日(JST)、または当日から数日、数ヶ月前の指定時刻(`yyyy-MM-dd 00:00:00`)の`TIMESTAMP`型の日付でカラム(UTC)を更新する。つまり、

1. (UTC)実行時の当日日付(e.g.`yyyy-MM-02 12:59:59 UTC`)をDBから取得して、
2. (JST)指定時刻の当日日付`yyyy-MM-02 00:00:00 JST`へ変換し、
3. (UTC)日付を変換して`yyyy-MM-01 15:00:00 UTC`でDBにINSERTする

こと。

## 方法

### No.1 JSTはUTCより**9時間**進んでいることはさきに知っておけば、この方法が分かりやすくなると思われる

**当日**  

```
INSERT INTO `table_name` (colume_name) \
VALUES (TIMESTAMPADD(HOUR,-9,CONCAT(DATE(TIMESTAMPADD(HOUR,9,NOW())),' 00:00:00')));
```

**数日前、数か月前**  
開始日付から減算される間隔値を指定する式は、`DAY`や`MONTH`などを使用する。1日前を例として挙げる。下の方法も同様。

```
INSERT INTO `table_name` (colume_name) \
VALUES (TIMESTAMPADD(HOUR,-9,CONCAT(DATE(DATE_SUB(TIMESTAMPADD(HOUR,9,NOW()),INTERVAL 1 DAY)),' 00:00:00')));
```

### No.2 時差は調べたくない場合は、`'+00:00'`を`'UTC'`に、`'+09:00'`を`'Asia/Tokyo'`に書き換えられる。ただし、[適切に設定する](https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html)必要がある

**当日**  

```
INSERT INTO `table_name` (colume_name) \
VALUES (CONVERT_TZ(CONCAT(DATE(CONVERT_TZ(NOW(),'+00:00','+09:00')),' 00:00:00'),'+09:00','+00:00'));
```

**数日前、数か月前**  

```
INSERT INTO `table_name` (colume_name) \
VALUES (CONVERT_TZ(CONCAT(DATE(DATE_SUB(CONVERT_TZ(NOW(),'+00:00','+09:00'),INTERVAL 1 DAY)),' 00:00:00'),'+09:00','+00:00'));
```

### No.3 指定時刻は`00:00:00`であり、`CURRENT_DATE()`と`NOW()`をさらに詳しく理解されている場合、No.1をこのような形に変更できる

**当日**  

```
INSERT INTO `table_name` (colume_name) \
VALUES (TIMESTAMPADD(HOUR,-9,DATE(TIMESTAMPADD(HOUR,9,CURRENT_DATE()))));
```

**数日前、数か月前**  

```
INSERT INTO `table_name` (colume_name) \
VALUES (TIMESTAMPADD(HOUR,-9,DATE(DATE_SUB(TIMESTAMPADD(HOUR,9,CURRENT_DATE()),INTERVAL 1 DAY))));
```

## 終わりに

ある案件の要望だが、上記いずれの方法でテストデータを作成すると、いつになっても、データを一々直さなく、指定した日付のものをINSERTできると考えられた。

## 参考記事

1. [MySQL5.7 Reference Manual / Functions and Operators / Date and Time Functions](https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html)
2. [世界のタイムゾーンと主要都市の時差を計算](https://www.jisakeisan.com)
