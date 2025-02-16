# zstd-cj

仓颉的 ZSTD 绑定

## 重新生成绑定

```bash
cjbind --make-func-wrapper --auto-cstring --no-enum-prefix -p zstd -o src/zstd.cj libs/zstd/lib/zdict.h libs/zstd/lib/zstd.h libs/zstd/lib/zstd_errors.h
```