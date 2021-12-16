# Python

## logging 実装例

```python
from logging import Logger, getLogger, basicConfig, DEBUG

log_fmt = '%(asctime)s %(levelname)s %(message)s'
basicConfig(format=log_fmt, level=DEBUG)
# ログファイルを出力する場合
# basicConfig(filename='result.txt',format=log_fmt,level=DEBUG)
logger = getLogger(__name__)
```

## 時間フォーマット変換例

### 1. format the datetime, and convert utc to jst

```python
def _format_datetime(lt):
    """format the datetime, and convert utc to jst
    """
    return datetime.datetime(
        int(lt[0]),
        int(lt[1]),
        int(lt[2]),
        int(lt[3]),
        int(lt[4]),
        int(lt[5]),
        int(lt[6]),
        tzinfo=datetime.timezone.utc
    ).astimezone(datetime.timezone(datetime.timedelta(hours=9))).strftime('%Y%m%d%H%M%S')
```

### 2. format the str to jst datetime

```python
def _format_strtime(st):
    """format the str to jst datetime
    """
    return datetime.datetime.strptime(st, '%Y-%m-%d %H:%M:%S') + datetime.timedelta(hours=9)
```
