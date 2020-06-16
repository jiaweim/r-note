# 程序控制结构

- [程序控制结构](#程序控制结构)
  - [表达式](#表达式)
  - [分支结构](#分支结构)
    - [用逻辑下标代替分支结构](#用逻辑下标代替分支结构)
    - [ifelse](#ifelse)
    - [switch](#switch)
  - [循环结构](#循环结构)
    - [计数循环](#计数循环)
    - [while 循环和 repeat 循环](#while-循环和-repeat-循环)

2020-06-15, 15:39
***

## 表达式

R是一个表达式语言, 任何语句都可以看作表达式：

- 表达式之间以分号分隔或换行分隔。
- 表达式可以续行, 只要前一行不是完整表达式(比如末尾是加减乘除等运算符, 或有未配对的括号)则下一行为上一行的继续。
- 若干个表达式可以放在一起组成一个复合表达式, 作为一个表达式使用，复合表达式的值为最后一个表达式的值， 组合用大括号表示, 如：

```r
{
  x <- 15
  x
}
```

## 分支结构

`if` 语句：

```r
if (contidition) exp1
```

或者:

```r
if(condition1) exp1 else exp2
```

条件语句返回 BOOLEAN 值，不允许缺失。

> 和 java 结构一致

### 用逻辑下标代替分支结构

R 是向量化语言，所以应尽可能少用标量运算。比如，x 是一个向量，要定义 y 域 x 等长，且 y 的每一个 元素当前仅当 x 对应元素为整数时等于 1，否则为 0.

正确做法：

```r
y <- numeric(length(x))
y[x>0] <- 1
y
```

### ifelse

函数 `ifelse()` 可以根据逻辑向量中的多个条件，分别选择不同结果。例如：

```r
> x <- c(-2, 0, 1)
> y <- ifelse(x >= 0, 1, 0)
> y
[1] 0 1 1
```

函数 `ifelse(test,  yes, no)` 中的 `test` 是逻辑向量，yes 和 no 是一般向量。如果 `yes` 或 `no` 长度不够，会自动循环使用。例如：

```r
> ifelse((1:6) >= 3, 1:2, c(-1. -2))
[1] -3 -3  1  2  1  2
```

不过最常见还是 `yes`, `no` 为标量的情况。

另外，`ifelse` 允许缺失值，如果 `test` 中有缺失值，对应结果也是缺失值。

`dplyr` 包的 `case_when` 函数可以看成是 `ifelse` 的多分支推广， 或看成`if-else if-else语句的向量化。 可以设定多个向量化的分支， 每个分支有对应的输出值。

### switch

`switch()` 函数可以建立多分支结构。

## 循环结构

### 计数循环

for 循环语法：

```r
for (循环变量 in 序列) 语句
```

例如：

```r
set.seed(101)
x <- rnorm(5)
y <- numeric(length(x))
for (i in 1:5) {
  if (x[i] >= 0) {
    y[i] <- 1
  } else {
    y[i] <- 0
  }
}
print(y)
# [1] 0 1 0 1 1
```

其中：

- `rnorm(5)` 生成 5 个标准正态分布随机数
- `numeric(n)` 生成包含 n 个 0 的数值向量（基础类型 double）

使用 `seq_along(x)` 生成向量 `x` 的所有下标序列，不要用 `1:n`，因为 n 可能为0，从而导致错误下标，而 `seq_long(x)` 在 `x` 长度为 0 时返回长度为 0 的下标。

例如，设序列 $x_n$ 满足 $x_0=0$，$x_n=2x_{n-1}+1$，求 $S_n=\sum_{i=1}^nx_n$

```r
x <- 0.0; s <- 0; n <- 5
for(i in 1:n){
  x <- 2*x + 1
  s <- s + x
}
print(s)
# [1] 57
```

在 R 中应尽量避免 for 循环，其速度比向量化版本慢一个数量级以上，而且不够简洁。例如，前面的 for 循环向量化版本：

```r
> set.seed(101); x <- rnorm(5)
> y <- ifelse(x >= 0, 1, 0)
> print(y)
[1] 0 1 0 1 1
```

许多计数循环都可以用 `lapply`, `vapply`, `sapply`, `apply`, `map`, `Map` 等函数替代。

- 用 `break` 退出循环
- 用 `next` 进行下一轮循环
- 如果对向量每个元素遍历并保存结果，应在循环前声明等长的常量存储结果。
  - 用 `numeric(n)` 生成长度为 n 的数值型向量
  - 用 `vector("list", n)` 生成长度为 n 的列表
- 对向量使用下标遍历时，采用 `seq_along(x)` 而不是 `1:length(x)`
- 如果直接对向量遍历，可能会丢失向量属性，而用下标访问则不存在该问题

```r
> x <- as.POSIXct(c("1988-12-13", "1989-01-19"))
> for(xi in x)
+     print(xi)
[1] 597945600
[1] 601142400
> for(i in seq_along(x))
+     print(x[i])
[1] "1988-12-13 +08"
[1] "1989-01-19 +08"
```

### while 循环和 repeat 循环