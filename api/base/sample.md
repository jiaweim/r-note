# sample

## 简介

`sample` 使用放回或不放回抽样从 `x` 获得指定大小的样本。

```R
sample(x, size, replace = FALSE, prob = NULL)
sample.int(n, size = n, replace = FALSE, prob = NULL,
           useHash = (!replace && is.null(prob) && size <= 2="" n="" &&=""> 1e7))
```

- `x`

包含多个元素的向量，或一个正整数。

- `n`

正整数，可供选择的元素数量。

- `size`

非负整数，抽样数。

- `replace`

是否放回抽样，默认否。

## 详情

如果 `x` 长度为 1，为数字类型 (`is.numeric`) 并且 `x >= 1`，则 `sample` 在 `1:x` 之间抽样。

> [!NOTE]
>
> 当 `x` 的长度不固定，该特性可能会导致不期望的行为。



## 示例



## 参考

- https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/sample