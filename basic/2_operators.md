# 运算符

- [运算符](#运算符)
  - [数序运算符](#数序运算符)
  - [逻辑运算符](#逻辑运算符)
  - [数据类型](#数据类型)
  - [赋值和下划线](#赋值和下划线)

2020-05-12, 20:16
***

## 数序运算符

| Operator | Description    |
| -------- | -------------- |
| +        | addition       |
| -        | subtraction    |
| *        | multiplication |
| /        | division       |
| ^ or **  | exponentiation |
| %/%      | 整除           |
| %%       | 余数           |

## 逻辑运算符

| Operator  | Description              |
| --------- | ------------------------ |
| <         | 小于                     |
| <=        | 小于等于                 |
| >         | greater than             |
| >=        | greater than or equal to |
| ==        | exactly equal to         |
| !=        | not equal to             |
| %in%      | 属于                     |
| xor(x, y) | x 与 y 的异或运算        |
|&&|短路与|
|`||`|短路或|

`%in%` 是比较特殊的比较， `x %in% y` 将 y 看作集合，判断 x 中的元素是否在 y 中。例如：

```r
> c(1, 3) %in% c(2, 3, 4)
[1] FALSE  TRUE
> c(NA, 3) %in% c(2, 3, 4)
[1] FALSE  TRUE
> c(1, 3) %in% c(NA, 3, 4)
[1] FALSE  TRUE
> c(NA, 3) %in% c(NA, 3, 4)
[1] TRUE TRUE
```

`match(x, y)` 功能和 `x %in% y` 类似，不过不是判断是否在，而是找到 `x` 的元素在 `y` 中**首次**出现的位置。例如：

```r
> match(c(1, 3), c(2, 3, 4, 3))
[1] NA  2
```

## 数据类型

R 支持多种数据类型，包括标量、向量（数值、字符、逻辑）、矩阵、数据框以及列表等。

## 赋值和下划线

R 的赋值运算符为 `<-`。例如：

```r
e <- m*c^2
```

也可以反过来：
