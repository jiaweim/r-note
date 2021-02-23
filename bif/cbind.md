# 合并行或列

- [合并行或列](#合并行或列)
  - [简介](#简介)
  - [cbind 实例](#cbind-实例)

2021-02-23, 14:57
***

## 简介

向量、矩阵或数据框按行或列进行合并，`cbind` 和 `rbind` 是带有其他 R 类方法的泛型函数。

```r
cbind(…, deparse.level = 1)
rbind(…, deparse.level = 1)
# S3 method for data.frame
rbind(…, deparse.level = 1, make.row.names = TRUE,
      stringsAsFactors = default.stringsAsFactors(), factor.exclude = NA)
```

`cbind` 和 `rbind` 是 S3 泛型函数，包含数据框的方法。如果合并的数据有一个是数据框，其它的是向量或矩阵，则使用数据框的方法。

参数说明：

- `...` 为向量或矩阵。

## cbind 实例

如果数据不足，自动重复补齐：

```r
> m <- cbind(1, 1:7)
> m
     [,1] [,2]
[1,]    1    1
[2,]    1    2
[3,]    1    3
[4,]    1    4
[5,]    1    5
[6,]    1    6
[7,]    1    7
```