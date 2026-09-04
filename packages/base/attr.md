# attr

2026-09-04⭐
@author Jiawei Mao
***
## 描述

获取或设置对象的特定属性。

```R
attr(x, which, exact = FALSE)
attr(x, which) <- value
```

## 参数

- **x**：待访问属性的对象。
- **which**：一个非空字符串，用于指定要访问的**属性名称**。
- **exact**：逻辑值（logical）：是否需要对 `which` 进行精确匹配？
- **value**：一个对象，表示该属性的新值；如果传入 `NULL`，则表示移除该属性。

## 详细说明

- `attr(x, which, exact = FALSE)` 用于访问对象的单个属性（提取形式）
- `attr(x, which) <- value` 替换形式（即赋值形式）会使指定的属性被赋予设定的值（或者以给定的值创建一个新属性）。

提取函数首先在 `x` 的属性中查找与 `which` 完全匹配的名称，然后（除非 `exact = TRUE`）再尝试进行部分匹配。（如果设置 `options(warnPartialMatchAttr = TRUE)`，则在部分匹配时会触发警告。）

赋值形式仅使用完全匹配。

> [!NOTE]
>
> 某些属性（即 `class`、`comment`、`dim`、`dimnames`、`names`、`row.names` 和 `tsp`）会被特殊处理，并且对其可设置的值存在限制。（注意：`levels` 属性不在此列，因子的 `levels` 应通过 `levels` 替换函数来进行设置。）

提取函数允许 `which` 为空值或缺失值（此时不进行匹配）；而赋值函数则不允许。

`NULL` 对象不能具有属性，如果尝试通过 `attr` 为其赋值，将会引发错误。

这两个函数都是底层原生函数（primitive functions）。

## 返回值（Value）

对提取函数，返回的是匹配到的属性值；如果没有找到完全匹配项，或者没有找到/找到了多个部分匹配项，则返回 `NULL`。

## 示例

```R
# create a 2 by 5 matrix
x <- 1:10
attr(x,"dim") <- c(2, 5)
```

## 参考

- https://rdrr.io/r/base/attr.html