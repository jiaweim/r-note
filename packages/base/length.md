# length

2026-09-04⭐
@author Jiawei Mao
***
## 描述

获取或设置向量（包括列表）和因子的长度，以及任何已为其定义了方法的 R 对象的长度。

```r
length(x)
length(x) <- value
```

## 参数

- **x**：一个 R 对象。对于赋值替换形式，需为向量或因子。
- **value**：一个非负整数或双精度数（若是双精度数，将被向下取整）。

## 详细说明

这两个函数都是泛型函数：你可以编写方法来处理特定类的对象，详见 `InternalMethods`。`length<-` 拥有一个针对 `"factor"`（因子）的方法。

赋值替换形式可用于重置向量的长度。如果向量被缩短，多余的值将被丢弃；如果向量被拉长，其新长度将使用 `NA` 进行填充（对于原生型 `raw` 向量，则使用 `nul` 填充）。

这两个都是底层原生函数（primitive functions）。

## 返回值

`length` 的默认方法目前返回一个长度为 1 的非负整数；但当向量元素超过 $2^{31} - 1$ 个时，将返回双精度数（double）。

- 对于向量（包括列表）和因子，长度即为其包含的元素数量。
- 对于环境（environment），长度为该环境中对象的数量，而 `NULL` 的长度为 0。
- 对于表达式（expressions）和配对列表（pairlists，包括语言对象和 `...` 列表），长度为配对列表链的长度。
- 所有其他对象（包括函数）的长度均为 1：请注意，对于函数的这一规定与 S 语言不同。

赋值替换形式会移除 `x` 的所有属性，仅保留 `names`（名称）属性，且 `names` 会被相应调整（必要时使用 `""` 进行扩展）。

## 警告

部分包作者编写的方法可能会返回长度不为 1 的结果（例如 `Formula`），或者返回双精度型向量（例如 `Matrix`），甚至在早期版本的 `sets` 中会返回非整数值。当返回的单个双精度值可以表示为整数时，它将被转换为长度为 1 的整数向量返回。

## 另请参阅

- `nchar`：用于计算字符向量中的字符数量。
- `lengths`：用于获取列表中每个元素的长度。

## 示例

```r
length(diag(4))  # = 16 (4 x 4 的矩阵)
length(options())  # 12 或更多
length(y ~ x1 + x2 + x3)  # 3
length(expression(x, {y <- x^2; y+2}, x^y))  # 3

## 来自 example(warpbreaks) 的示例
require(stats)

fm1 <- lm(breaks ~ wool * tension, data = warpbreaks)
length(fm1$call)      # 3，即 lm() 及其两个参数
length(formula(fm1))  # 3，即 ~ lhs rhs
```

## 参考

- https://rdrr.io/r/base/length.html