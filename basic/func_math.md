# Math Functions

- [Math Functions](#math-functions)
  - [函数列表](#函数列表)
  - [三角函数](#三角函数)
  - [分布函数](#分布函数)
    - [Normal Distribution](#normal-distribution)
  - [统计函数](#统计函数)
  - [函数详细说明](#函数详细说明)
    - [round](#round)
    - [sqrt](#sqrt)
    - [sd](#sd)

2020-08-12, 10:01
***

## 函数列表

| 函数    | 功能               |
| ------- | ------------------ |
| sqrt()  | 平方根             |
| exp()   | 指数               |
| log10() | 对数               |
| sin()   | 正弦               |
| cos()   | 余弦               |
| tan()   | 正切               |
| asin()  | 反正切             |
| acos()  | 反余弦             |
| atan    | 反正切             |
| dnorm() | 标准正态分布密度   |
| pnorm() | 标准正态分布函数   |
| qnorm   | 标准正态分布分位数 |
| sign()  | 返回数值的符号     |

`sign()` 对正数返回 1，负数 -1，0 返回 0，不可用于复数。

```r
sign(pi)    # == 1
sign(-2:3)  # -1 -1 0 1 1 1
```

## 三角函数

```r
> pi
[1] 3.141593
> sin(pi/6)
[1] 0.5
> cos(pi/6)
[1] 0.8660254
> sqrt(3)/2
[1] 0.8660254
> tan(pi/6)
[1] 0.5773503
```

反三角函数，结果为弧度值：

```r
> asin(0.5) # 反正弦
[1] 0.5235988
> acos(sqrt(3)/2) # 反余弦
[1] 0.5235988
> atan(sqrt(3)/3) # 反正切
[1] 0.5235988
```

## 分布函数

### Normal Distribution

正态分布的密度函数、分布函数、分位数函数以及随机数生成器。

```r
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)
```

`dnorm(x)` 表示标准正态分布密度函数 $\varPhi(x)=\frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}x^2}$。

`pnorm(x)` 表示标准正态分布函数 $\Phi(x)=\int_{-\infin}^x\varPhi(t)dt$.

`qnorm(y)` 表示标准正态分布分位函数 $\Phi^{-1}(x)$

`rnorm` 计算随机数。

## 统计函数

| 函数    | 功能           |
| ------- | -------------- |
| sum     | 求和           |
| mean    | 均值           |
| var     | 方差           |
| sd      | 标准差         |
| min     | 最小值         |
| max     | 最大值         |
| range   | 最小值和最大值 |
| prod    | 所有元素乘积   |
| cumsum  | 累积加和       |
| cumprod | 累积乘积       |

```r
> cumsum(1:5)
[1]  1  3  6 10 15
> cumprod(1:5)
[1]   1   2   6  24 120
> prod(1:5)
[1] 120
```

## 函数详细说明

### round

| 函数       | 功能                     |
| ---------- | ------------------------ |
| round()    | 取整                     |
| floor()    | 向下取整                 |
| ceiling()  | 向上取整                 |
| trunc()    | 向 0 的方向截断取整      |
| signif()   | 四舍五入到指定的有效数字 |
| zapsmall() | 从指定位数开始舍入       |

`round()` 用于舍入：

```r
> round(1.1234, 2)
[1] 1.12
> round(-1.98765, 2)
[1] -1.99
```

`floor` 和 `ceiling` 用于取整：

```r
> floor(1.1234)
[1] 1
> floor(-1.12)
[1] -2
> ceiling(1.123)
[1] 2
> ceiling(-1.234)
[1] -1
```

### sqrt

sqrt(x) 计算 x 的平方根。

`x^2` 则计算 x 的二次方。

对向量和矩阵， 则对各个元素依次计算：

```r
> x=matrix(c(1, 2, 3, 4),2,2)
> sqrt(x)
         [,1]     [,2]
[1,] 1.000000 1.732051
[2,] 1.414214 2.000000
> x^2
     [,1] [,2]
[1,]    1    9
[2,]    4   16
```

### sd

计算标准差。

```r
> set.seed(3)
> y=rnorm(100)
> mean(y)
[1] 0.01103557
> var(y)
[1] 0.7328675
> sqrt(var(y))
[1] 0.8560768
> sd(y)
[1] 0.8560768
```
