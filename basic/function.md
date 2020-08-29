# 函数式编程

- [函数式编程](#函数式编程)
  - [函数定义](#函数定义)
    - [无参函数](#无参函数)
    - [一元函数](#一元函数)

2020-08-29, 20:45
@jiawei
***

## 函数定义

使用 `function` 关键字定义函数，一般格式为：

```r
函数名 <- function(形参列表) 函数体
```

使用 `return(x)` 返回 x 值，要返回多个值，可以打包在 list 中。

### 无参函数

例如，定义一个无参的绘图函数：

```r
f <- function() {
  x <- seq(0, 2 * pi, length = 50)
  y1 <- sin(x)
  y2 <- cos(x)
  plot(x, y1, type = 'l', lwd = 2, col = 'red',
       xlab = 'x', ylab = "")
  lines(x, y2, lwd = 2, col = 'blue')
  abline(h = 0, col = 'gray')
}
f()
```

![line](images/2020-08-29-20-44-25.png)

### 一元函数

一元函数，即包含一个参数的函数。其定义十分简单：

```r
f <- function(x) 1 / sqrt(1 + x^2)
```

该函数和数学函数 $f(x)=1/\sqrt{1+x^2}$ 对应。

函数定义中的自变量 `x` 称为形参（formal argument）。函数调用时，为形参提供的参数值称为实参（actual argument）。

R 函数

