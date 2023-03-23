# merge

## 简介

```r
merge(x, y, …)
# S3 method for default
merge(x, y, …)

# S3 method for data.frame
merge(x, y, by = intersect(names(x), names(y)),
      by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all,
      sort = TRUE, suffixes = c(".x",".y"), no.dups = TRUE,
      incomparables = NULL, …)
```

按 common column names 或 row names 合并两个数据框。

**参数：**

- `x`, `y`

需要合并的两个数据集。

- `by`, `by.x`, `by.y`

合并数据集使用的变量。

- `all`：logical

默认 `FALSE`，表示输出结果只包含 x,y 数据集共有行，TRUE 表示输出 x,y 数据集的并集。

`all=TRUE` 等价于 `all.x=TRUE` 和 `all.y=TRUE`。

- `all.x`：logical

`TRUE` 表示输出 `y` 中没有匹配到的 `x` 行，此时对应 `y` 的数据为 `NA`。
默认 `FALSE`，即只输出交集。

- `all.y`：logical

类似 `all.x`。

- `sort`：logical

结果是否按 column 排序。

- `suffixes`

长度为 2 的字符向量，
a character vector of length 2 specifying the suffixes to be used for making unique the names of columns in the result which are not used for merging (appearing in by etc).

no.dups
logical indicating that suffixes are appended in more cases to avoid duplicated column names in the result. This was implicitly false before R version 3.5.0.

incomparables
values which cannot be matched. See match. This is intended to be used for merging on one column, so these are incomparable values of that column.

…
arguments to be passed to or from methods.

## 参考

- https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/merge
