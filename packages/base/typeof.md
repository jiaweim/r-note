# typeof

2026-09-04⭐
@author Jiawei Mao
***
## 描述

`typeof` 函数用于确定任何对象的（R 内部）类型或存储模式。

```r
typeof(x)
```

## 参数

- **x**：任何 R 对象。

## 返回值

返回一个字符型字符串。可能的取值列在 `src/main/util.c` 源码中的 `TypeTable` 结构体中。当前的取值包括：

- **向量类型**：`"logical"`（逻辑型）、`"integer"`（整型）、`"double"`（双精度型）、`"complex"`（复数型）、`"character"`（字符型）、`"raw"`（原生型）和 `"list"`（列表）。
- **其他常见类型**：`"NULL"`、`"closure"`（闭包/函数）、`"special"` 和 `"builtin"`（基础函数和运算符）、`"environment"`（环境）、`"S4"`（部分 S4 对象）。
- **底层/罕见类型**：在用户层面极少见到的类型，包括 `"symbol"`（符号）、`"pairlist"`（配对列表）、`"promise"`（延迟求值对象）、`"language"`（语言对象）、`"char"`、`"..."`、`"any"`、`"expression"`（表达式）、`"externalptr"`（外部指针）、`"bytecode"`（字节码）和 `"weakref"`（弱引用）。

## 示例

```r
typeof(2)
mode(2)
## 如需查看完整的示例表格，请参阅 ?mode 或 examples(mode)
```

```r
> typeof(c(TRUE, FALSE))
[1] "logical"
> typeof(c(1L, 6L, 10L))
[1] "integer"
> typeof(c(1, 2.5, 4.5))
[1] "double"
> typeof(c("Hello"))
[1] "character"
```

## 参考

- https://rdrr.io/r/base/typeof.html