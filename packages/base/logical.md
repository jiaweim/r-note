# logical

2026-09-04⭐
@author Jiawei Mao
***
## 描述

用于创建或测试类型为 `"logical"` 的对象，以及基本的逻辑常量。

```r
TRUE
FALSE
T; F

logical(length = 0)
as.logical(x, ...)
is.logical(x)
```

## 参数

- **length**：一个非负整数，指定所需的向量长度。双精度值将被强制转换为整数：如果提供的长度参数不是单一值（长度不为 1），则会报错。
- **x**：需要被强制转换或测试的对象。
- **...**：传递给其他方法或从其他方法接收的额外参数。

## 详细说明

`TRUE` 和 `FALSE` 是 R 语言中表示逻辑常量的保留字，而 `T` 和 `F` 则是全局变量，它们的初始值被设置为对应的逻辑常量。这四个都是长度为 1 的逻辑型向量（`logical(1)`）。

在需要数值型值的上下文中，逻辑型向量会被强制转换为整型向量，其中 `TRUE` 映射为 `1L`，`FALSE` 映射为 `0L`，而 `NA` 映射为 `NA_integer_`。

## 返回值

`logical` 会创建一个指定长度的逻辑型向量。该向量中的每个元素都等于 `FALSE`。

`as.logical` 会尝试将其参数强制转换为逻辑型。在数值型和复数型向量中，零值被视为 `FALSE`，非零值被视为 `TRUE`。对于因子（factors），该函数会基于其水平（levels，即标签）进行转换。与 `as.vector` 类似，它会剥离包括 `names` 在内的所有属性。

对于字符型字符串，`c("T", "TRUE", "True", "true")` 会被识别为真（`TRUE`），`c("F", "FALSE", "False", "false")` 会被识别为假（`FALSE`），而所有其他字符串都会被转换为 `NA`。

`is.logical` 会根据其参数是否为逻辑型，返回 `TRUE` 或 `FALSE`。

## 示例

```r
## 非零值会被转换为 TRUE
as.logical(c(pi, 0))
if (length(letters)) cat("26 is TRUE\n")

## 特定字符串的逻辑转换解释
charvec <- c("FALSE", "F", "False", "false",    "fAlse", "0",
             "TRUE",  "T", "True",  "true",     "tRue",  "1")
as.logical(charvec)

## 因子会通过其水平（levels）进行转换，因此这里使用的是字符串转换规则
as.logical(factor(charvec))
as.logical(factor(c(0,1)))  # 字符 "0" 和 "1" 会被转换为 NA
```
