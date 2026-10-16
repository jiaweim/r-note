# base::unlink

@since 2026-10-16⭐
@author Jiawei Mao
***

`unlink` 删除参数 `x` 指定的文件或目录。

```r
unlink(x, recursive = FALSE, force = FALSE, expand = TRUE)
```

## 参数

### x

字符串向量，包含待删除的文件或目录路径（支持多个）。

### recursive

逻辑值，是否递归删除目录？

### force

逻辑值，是否尝试修改权限以执行删除。

### expand

逻辑值，是否展开通配符和波浪号（参见 `path.expand`）。

## 详细说明

`recursive = FALSE` 时不删除目录，即使是空目录也不删除。

通配符（ `*` 和 `?`）由 `Sys.glob` 解析。通配符不匹配以 `.` 开头的文件； `.`、`..` 和 `~` 文件永远不会被删除。

## 返回值

不可见地（invisibly）返回 `0` 表示成功，返回 `1` 表示失败。

未删除不存在的文件不算失败；`recursive = FALSE` 未删除目录也不算失败；但是，如果参数 `x` 中包含缺失值，会判定为失败。

## 另见

`file.remove`。