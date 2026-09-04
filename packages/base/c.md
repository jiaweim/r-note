# c

2026-09-04⭐
@author Jiawei Mao
***
## 描述

这是一个用于组合其参数的泛型函数。

默认将传入的参数组合成一个向量。所有参数被强制转换为一种公共类型，该类型即为最终返回值的类型，并且除了 `names`（名称）属性外，其余所有属性都被移除。

```R
## S3 Generic function
c(...)

## Default S3 method:
c(..., recursive = FALSE, use.names = TRUE)
```

## 参数

- **...**：需要拼接的对象。除非位于参数列表的最前面，否则所有为 `NULL` 的条目在方法分派（method dispatch）之前都会被丢弃。
- **recursive**：逻辑值（logical）。如果 `recursive = TRUE`，该函数会递归地深入列表（list）和配对列表（pairlist）中，将其所有元素组合成一个向量。
- **use.names**：逻辑值，用于指示是否保留元素的名称（names）。

## 详细说明

输出的数据类型由参与组合的组件中“最高”的类型决定，其类型层级关系为：`NULL < raw < logical < integer < double < complex < character < list < expression`。

配对列表（pairlists）会被视为列表（lists）处理；而非向量组件（如名称/符号（names/symbols）和调用（calls））会被视为单元素列表，即使设置了 `recursive = TRUE`，也无法被展平（unlisted）。

请注意，在 R 4.1.0 之前的版本中，因子（factors）仅通过其内部的整数代码进行处理：而现在有了 `c.factor` 方法，可以将多个因子组合成一个新的因子。

`c` 有时会被专门用来产生移除属性（除 `names` 外）的副作用，例如将数组（array）转换为向量。使用 `as.vector` 是实现这一目的更直观的方式，但它同样会移除 `names` 属性。需要注意的是，除了默认方法外，其他方法并不强制要求执行此操作（并且它们几乎肯定会保留 `class` 属性）。

这是一个底层原生函数（primitive function）。

## 返回值

返回 `NULL`、表达式（expression）或具有适当模式（mode）的向量。（如果不提供任何参数，则返回 `NULL`。）

## S4 方法

该函数是 S4 泛型函数，但其参数列表定义为 `(x, ...)`。

## 示例

```R
c(1,7:9)
c(1:5, 10.5, "next")

## uses with a single argument to drop attributes
x <- 1:4
names(x) <- letters[1:4]
x
c(x)          # has names
as.vector(x)  # no names
dim(x) <- c(2,2)
x
c(x)
as.vector(x)

## append to a list:
ll <- list(A = 1, c = "C")
## do *not* use
c(ll, d = 1:3) # which is == c(ll, as.list(c(d = 1:3)))
## but rather
c(ll, d = list(1:3))  # c() combining two lists

c(list(A = c(B = 1)), recursive = TRUE)

c(options(), recursive = TRUE)
c(list(A = c(B = 1, C = 2), B = c(E = 7)), recursive = TRUE)
```

- 相同类型向量自动展平

```r
> c(c(1, 2), c(3, 4))
[1] 1 2 3 4
```

## 参考

- https://rdrr.io/r/base/c.html