# DataFrame

## 简介

数据框是矩形结构，包含行和列。

数据框实际上是一个列表，列表中的元素是向量，这些向量构成数据框的列，每一列必须具有相同的长度，而且列必须命令。

可以将数据框看作包含多种类型数据的矩阵。和 Excel 的二维表格数据类似。其特征有：

- column 名不能为空
- row names 必须唯一
- 可存储 numeric, factor 和 character 数据类型
- 每一列的数据类型必须相同

数据框 `data.frame` 具有 List 和 Matrix 的属性，因此：

- 可以和 List 一样，根据位置选择列，如 `df[1:2]` 选择前两列
  - `df["x"]` 选择 `x` 列，返回新的矩阵
  - `df[["x"]]` 选择 `x` 列，返回向量
  - `df$x` 等价于 `df[["x"]]`
- 像矩阵一样，使用行和列选择，如 `df[1:3, ]` 选择前三行的所有列

## 创建数据框

用 `data.frame` 函数，例如：

```r
> df <- data.frame(x=1:4,
+                  y=4:1,
+                  z=c("a", "b", "c", "d"))
> df
  x y z
1 1 4 a
2 2 3 b
3 3 2 c
4 4 1 d
> # like list
> df[c("x", "z")] # 选择 x 和 z 这两列
  x z
1 1 a
2 2 b
3 3 c
4 4 d

> # like matrix
> df[, c("x", "z")] # 所有行，x 和 z 这两列
  x z
1 1 a
2 2 b
3 3 c
4 4 d
> df[1:2] # 选择 1 到 2 列，所有行
  x y
1 1 4
2 2 3
3 3 2
4 4 1
> df[1:3, ] # 选择 1-3 行，所有列
  x y z
1 1 4 a
2 2 3 b
3 3 2 c
```

和矩阵一样，当数据只剩下单行或单列，数据会降维：

```r
> df[, "x"]
[1] 1 2 3 4
```

如果不想降维，可以设置 `drop`:

```r
> df[, "x", drop=FALSE]
  x
1 1
2 2
3 3
4 4
```

`colnames(df)` 查看数据库列的名称。


## 增强型数据框 tibble

`tibble` 是增强型的 `data.frame`，选取 `tibble` 的行或列，即使遇到当行或单列，数据也不会降维，总是返回 `tibble`。例如：

```r
> tb <- tibble::tibble(
+     x=1:4,
+     y=4:1,
+     z=c("a", "b", "c", "d")
+ )
> tb
# A tibble: 4 x 3
      x     y z
  <int> <int> <chr>
1     1     4 a
2     2     3 b
3     3     2 c
4     4     1 d
> tb["x"]
# A tibble: 4 x 1
      x
  <int>
1     1
2     2
3     3
4     4
> tb[, "x"]
# A tibble: 4 x 1
      x
  <int>
1     1
2     2
3     3
4     4
```
