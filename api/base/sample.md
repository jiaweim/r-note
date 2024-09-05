# sample

## 简介

`sample` 使用放回或不放回抽样从 `x` 获得指定大小的样本。

```R
sample(x, size, replace = FALSE, prob = NULL)
sample.int(n, size = n, replace = FALSE, prob = NULL,
           useHash = (!replace && is.null(prob) && size <= 2="" n="" &&=""> 1e7))
```

## 参数

- `x`

包含多个元素的向量，或一个正整数。

- `n`

正整数，可供选择的元素数量。

- `size`

非负整数，抽样数。

- `replace`

是否放回抽样，默认否。

- `prob`

概率权重向量，即对向量的各个元素设置不同的采样概率。`prob` 向量与 `x` 中的元素一一对应。

## 详情

如果 `x` 长度为 1，为数字类型 (`is.numeric`) 并且 `x >= 1`，则 `sample` 在 `1:x` 之间抽样。

> [!NOTE]
>
> 当 `x` 的长度不固定，该特性可能会导致不期望的行为。

参数 `prob` (可选) 用于设置待采样向量各个元素的概率权重。它们加和不需要为 1，但必须为非负数，不能全部为 0。如果 `replace` 为 TRUE，且可能值超过 200 个，就采用 Walker's alias 方法（Ripley, 1987），给出结果与 R<2.2.0 不兼容。

## 示例

- 模拟洗牌

生成 1:52 的随机数，不放回抽样 52 次：

```R
> random <- sample(1:52, size = 52)
> random
 [1] 34 24 13 27 29 33 42 20 43 30  1 12 41 50 26 25 18  8 40 17  3 51 16 37
[25]  2 23  4  6  9 45 48  7 32 36 44 11 19 35 28 52  5 38 10 49 22 31 39 47
[49] 15 21 14 46
```



## 参考

- https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/sample