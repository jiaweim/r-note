# 分组操作


***
## 简介

数据分析中，常需要对数据的不同部分进行重复操作，就是 Hadley Wickham 所说的 "split-apply-combine"。及根据特定条件将数据分成不同部分，对每个部分应用某种转换，然后将所有部分合并在一起。这有点像 Hadoop 的 Map Reduce 范式。R 提供了多种迭代数据的方式，下面介绍一些常用的。另外，下面介绍的许多功能一直在改进，由更高效的工具进行替代。

## Apply 系列

R 内置的 `apply` 函数，以及它的相关函数，如 `tapply`, `lapply`, `mapply` 等，应对不同情况。

### apply

`apply` 应用限制最多。它只能用于 `matrix`，即所有元素类型必须相同，如 `character`, `numeric` 或 `logical`。如果应用于其它对象，如 `data.frame`，则首先将其转换为 `matrix`。

```r
apply(X, MARGIN, FUN, …)
```

`apply` 由三个必须参数：

- `X` 是要处理的对象
- `MARGIN` 是应用函数的方式：`1` 表示按行应用函数，`2` 表示按列应用函数
- `FUN` 是要应用的函数

余下的参数传递给 `FUN`。

`apply` 迭代 matrix 的行或列，将它们视为指定函数 `FUN` 的第一个参数。例如：

```r
> theMatrix <- matrix(1:9, nrow = 3)
> theMatrix
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9
> apply(theMatrix, 1, sum) # 每一行相加
[1] 12 15 18
> apply(theMatrix, 2, sum) # 每一列相加
[1]  6 15 24
```

当然，这个简单功能用内置的 `rowSums` 和 colSums 函数也能实现：

```r
> rowSums(theMatrix)
[1] 12 15 18
> colSums(theMatrix)
[1]  6 15 24
```

现在将 `theMatrix` 的一个元素设置为 `NA`，看看如何使用 `na.rm` 参数处理缺失数据。如果 `vector` 某一个元素为 NA，那么 `sum` 为 `NA`。设置 `na.rm=TRUE` 表示移除 `NA` 值，对余下元素进行操作。

在 apply 中使用 sum 或其它函数，额外的参数（如 na.rm ）为 FUN 的参数。

```r
> theMatrix[2,1] <- NA
> apply(theMatrix, 1, sum)
[1] 12 NA 18
> apply(theMatrix, 1, sum, na.rm = TRUE)
[1] 12 13 18
> rowSums(theMatrix)
[1] 12 NA 18
> rowSums(theMatrix, na.rm = TRUE)
[1] 12 13 18
```

### lapply 和 sapply

`lapply` 对 list 的每个元素应用函数，返回一个 list。

```r
> theList <- list(A = matrix(1:9, 3), B = 1:5, C = matrix(1:4, 2), D = 2)
> theList
$A
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9

$B
[1] 1 2 3 4 5

$C
     [,1] [,2]
[1,]    1    3
[2,]    2    4

$D
[1] 2

> lapply(theList, sum)
$A
[1] 45

$B
[1] 15

$C
[1] 10

$D
[1] 2
```

处理 lists 可能很麻烦，所以将 `lapply` 的结果转换为 `vector` 更好。`sapply` 与 `lapply` 除了返回 `vector`，其它完全一样：

```r
> sapply(theList, sum)
 A  B  C  D 
45 15 10  2 
```

因为 `vector` 从技术上讲就是一种 list，所以 `lapply` 和 `sapply` 也支持 vector 输入：

```r
> theNames <- c("Jared", "Deb", "Paul")
> lapply(theNames, nchar)
[[1]]
[1] 5

[[2]]
[1] 3

[[3]]
[1] 4
```

