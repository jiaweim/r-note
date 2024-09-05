# 修改值

2024-09-05 ⭐
@author Jiawei Mao

***
## 原地修改

直接使用赋值操作符 `<-` 修改值。

适用于 vector, matrix, array, list, data.frame。

### 修改一个值

```R
> vec <- c(0,0,0,0,0,0)
> vec
[1] 0 0 0 0 0 0
```

选择 `vec` 的第一个值：

```R
> vec[1]
[1] 0
```

修改 `vec` 的第一个值：

```R
> vec[1] <- 1000
> vec
[1] 1000    0    0    0    0    0
```

### 修改多个值

可以一次修改多个值，要求选择的元素和设置的元素个数相等

```R
> vec[c(1,3,5)] <- c(1,1,1)
> vec
[1] 1 0 1 0 1 0

> vec[4:6] <- vec[4:6]+1
> vec
[1] 1 0 1 1 2 1
```

### 扩展向量

为没有元素的地方赋值，R 会扩展向量

```R
> vec[7] <- 0
> vec
[1] 1 0 1 1 2 1 0

> vec[10] <- 3
> vec
 [1]  1  0  1  1  2  1  0 NA NA  3
```

### 添加新变量

为 data.frame 不存在的 column 赋值，等价于添加新变量：

```R
> deck2$new <- 1:52
> head(deck2)
   face   suit value new
1  king spades    13   1
2 queen spades    12   2
3  jack spades    11   3
4   ten spades    10   4
5  nine spades     9   5
6 eight spades     8   6
```

将 column 赋值为 `NULL`，等价于删除 column：

```R
> deck2$new <- NULL
> head(deck2)
   face   suit value
1  king spades    13
2 queen spades    12
3  jack spades    11
4   ten spades    10
5  nine spades     9
6 eight spades     8
```

## 逻辑运算

逻辑操作：

| 操作符 | 语法              | 说明                  |
| ------ | ----------------- | --------------------- |
| >      | a > b             | a 是否大于 b          |
| >=     | a >= b            | a 是否大于等于 b      |
| <      | a < b             | a 是否小于 b          |
| <=     | a <= b            | a 是否小于等于 b      |
| ==     | a == b            | a 是否等于 b          |
| !=     | a != b            | a 是否不等于 b        |
| %in%   | a %in% c(a, b, c) | c(a, b, c) 是否包含 a |

使用逻辑运算符比较向量，R 会逐元素比较，返回 boolean 向量：

```R
> 1 > 2
[1] FALSE
> 1 > c(0, 1, 2)
[1]  TRUE FALSE FALSE
> c(1, 2, 3) == c(3, 2, 1)
[1] FALSE  TRUE FALSE
```

`%in%` 是唯一非逐元素操作符，检查左边的值是否在右边的向量中。

如果 `%in%` 左侧是一个向量，则逐个检查向量中的每个元素是否包含在右侧向量中：

```R
> 1 %in% c(3, 4, 5)
[1] FALSE
> c(1, 2) %in% c(3, 4, 5)
[1] FALSE FALSE
> c(1, 2, 3) %in% c(3, 4, 5)
[1] FALSE FALSE  TRUE
> c(1, 2, 3, 4) %in% c(3, 4, 5)
[1] FALSE FALSE  TRUE  TRUE
```

> [!NOTE]
>
> 使用两个等号 `==` 检查两个值是否相等。
>
> 一个等号 `=` 是赋值操作符，与 `<-` 效果一样。

可以用逻辑运算符对比任意两个 R 对象，不过一般只有对比相同数据类型的对象才有意义，否则 R 会强制转换类型。

示例：查找 `deck2` 中 face 等于 "ace" 的值，并计数：

```R
> sum(deck2$face == "ace")
[1] 4
```

> [!NOTE]
>
> 对 boolean 向量进行数学运算，会自动类型升档。

### 布尔选择

用逻辑运算得到布尔向量，然后用布尔向量选择满足条件的数据。

例如：

```R
> deck3$value[deck3$face == "ace"]
[1] 1 1 1 1
```

选择之后，就可以对这些值进行操作。比如，重新赋值：

```R
> deck3$value[deck3$face == "ace"] <- 14
> deck3$value[deck3$face == "ace"]
[1] 14 14 14 14
```

### 布尔运算

R 有 6 种布尔运算符：

| 运算符 | 语法                           | 说明                                   |
| ------ | ------------------------------ | -------------------------------------- |
| &      | cond1 & cond2                  | 与：是否 `cond1` 和 `cond2` 同为 true  |
| `|`    | `cond1 pipe cond2`             | 或：`cond1` 和 `cond2` 至少一个为 true |
| xor    | `xor(cond1, cond2)`            | 异或：`cond1` 和 `cond2` 一个为 true   |
| !      | `!cond1`                       | 否：`cond1` 是否为 false               |
| any    | `any(cond1, cond2, cond3,...)` | 任意条件为 true                        |
| all    | `all(cond1, cond2, cond3,...)` | 所有条件为 true                        |

对向量，布尔运算也是逐元素对比。例如：

```R
> a <- c(1, 2, 3)
> b <- c(1, 2, 3)
> c <- c(1, 2, 4)

> a == b
[1] TRUE TRUE TRUE
> b == c
[1]  TRUE  TRUE FALSE
> a == b & b == c
[1]  TRUE  TRUE FALSE
```

## 缺失值

R 用 `NA` (not available) 表示缺失值。

和 `NA` 运算得到 `NA`：

```R
> 1 + NA
[1] NA
> 1 == NA
[1] NA
```

### na.rm

`NA` 会导致对数据集的任何计算结果都是 `NA`。例如：

```R
> c(NA, 1:50)
 [1] NA  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
[25] 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
[49] 48 49 50
> mean(c(NA, 1:50))
[1] NA
```

不过，大多数 R 函数都有一个可选的 `na.rm` 参数，表示移除 `NA` 值。添加 `na.rm = TRUE` 后，R 函数计算时忽略 `NA` 值：

```R
> mean(c(NA, 1:3), na.rm = TRUE)
[1] 2
```

### is.na

如何查找数据集里的缺失值？

任何与 `NA` 的运算都返回 `NA`，例如：

```R
> NA == NA
[1] NA
> c(1, 2, 3, NA) == NA
[1] NA NA NA NA
```

因此无法帮助查找缺失值。

为了，R 专门提供了一个函数 `is.na()` 用于判断一个值是否为 `NA`

```R
> is.na(NA)
[1] TRUE
> vec <- c(1, 2, 3, NA)
> is.na(vec)
[1] FALSE FALSE FALSE  TRUE
```

