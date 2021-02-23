# 行和列

## 简介

`nrow` 和 `ncol` 分别返回 `x` 中的行数和列数。

`NCOL` 和 `NROW` 功能同上，但是对向量和只有一列的矩阵也能执行，对长度为 0 的向量也可以，且与 `as.matrix()` 或 `cbind()` 兼容。

## 使用方法

```r
nrow(x)
ncol(x)

NCOL(x)
NROW(x)
```

`x` 为向量、数组、数据框或 NULL。

返回长度，`ncol` 和 `nrow` 还可能返回 `NULL`。