# with

@since 2026-09-10⭐
@author Jiawei Mao
***
## 描述

**在数据环境中计算表达式**
在由数据构建的环境中计算 R 表达式，可能会修改（原始数据的副本）。

```R
with(data, expr, ...)
within(data, expr, ...)
## S3 method for class 'list'
within(data, expr, keepAttrs = TRUE, ...)
```

## 参数

- **data**：用于构建环境的数据。对于默认的 `with` 方法，它可以是环境、列表、数据框，或者是 `sys.call` 中的整数。对于 `within`，它可以是列表或数据框。

- **expr**：待计算的表达式；特别是对于 `within()`，通常是一个“复合”表达式，即如下形式：

  ```r
  {
    a <- somefun()
    b <- otherfun()
    .....
    rm(unused1, temp)
  }
  ```

- **keepAttrs**：针对 `within()` 的列表方法，是一个逻辑值，用于指定结果列表是否应保留来自 `data` 的属性，并保持名称顺序相同。通常这并非必要，因为结果本身就是一个命名列表，此时设置 `keepAttrs = FALSE` 效率更高。

- **...**：传递给（未来的）方法的参数。

## 详细信息

`with` 是一个泛型函数，它在由 `data` 构建的**局部环境**中计算 `expr`。该环境以调用者的环境作为其父环境。这对于简化模型函数的调用非常有用。（注意：如果 `data` 已经是一个环境，则直接使用该环境及其现有的父环境。）

请注意，`expr` 内部的赋值操作发生在构建的局部环境中，而不是用户的整体工作区中。

`within` 的功能与之类似，不同之处在于它会在 `expr` 计算完成后检查该环境，并对 `data` 的副本进行相应的修改（在数据框的情况下，如果创建的对象无法存储在数据框中，这可能会失败），然后返回该副本。`within` 可以作为 `transform` 函数的替代方案。

## 返回值

对于 `with`，返回的是计算后的 `expr` 的值。对于 `within`，返回的是被修改后的对象。

## 注意事项

在交互式使用时，这非常有效且代码可读性高。但在编程时（例如在你自己的函数中），需要更加谨慎，通常应避免使用 `with()`，因为 `data` 中的变量可能会意外地覆盖局部变量，具体请参阅相关参考资料。

此外，当使用带有显式 `data` 参数的建模或图形函数（通常使用公式）时，通常优先使用该函数自带的 `data` 参数，而不是使用 `with(data, ...)`。

## 示例

- `with` 在 `mtcars` 局部环境中计算表达式，不需要前缀引用

```R
with(mtcars, mpg[cyl == 8  &  disp > 350])
    # is the same as, but nicer than
mtcars$mpg[mtcars$cyl == 8  &  mtcars$disp > 350]
```



```R


require(stats); require(graphics)

# examples from glm:
with(data.frame(u = c(5,10,15,20,30,40,60,80,100),
                lot1 = c(118,58,42,35,27,25,21,19,18),
                lot2 = c(69,35,26,21,18,16,13,12,12)),
    list(summary(glm(lot1 ~ log(u), family = Gamma)),
         summary(glm(lot2 ~ log(u), family = Gamma))))

aq <- within(airquality, {     # Notice that multiple vars can be changed
    lOzone <- log(Ozone)
    Month <- factor(month.abb[Month])
    cTemp <- round((Temp - 32) * 5/9, 1) # From Fahrenheit to Celsius
    S.cT <- Solar.R / cTemp  # using the newly created variable
    rm(Day, Temp)
})
head(aq)




# example from boxplot:
with(ToothGrowth, {
    boxplot(len ~ dose, boxwex = 0.25, at = 1:3 - 0.2,
            subset = (supp == "VC"), col = "yellow",
            main = "Guinea Pigs' Tooth Growth",
            xlab = "Vitamin C dose mg",
            ylab = "tooth length", ylim = c(0, 35))
    boxplot(len ~ dose, add = TRUE, boxwex = 0.25, at = 1:3 + 0.2,
            subset = supp == "OJ", col = "orange")
    legend(2, 9, c("Ascorbic acid", "Orange juice"),
           fill = c("yellow", "orange"))
})

# alternate form that avoids subset argument:
with(subset(ToothGrowth, supp == "VC"),
     boxplot(len ~ dose, boxwex = 0.25, at = 1:3 - 0.2,
             col = "yellow", main = "Guinea Pigs' Tooth Growth",
             xlab = "Vitamin C dose mg",
             ylab = "tooth length", ylim = c(0, 35)))
with(subset(ToothGrowth,  supp == "OJ"),
     boxplot(len ~ dose, add = TRUE, boxwex = 0.25, at = 1:3 + 0.2,
             col = "orange"))
legend(2, 9, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))

```



## 参考

- https://rdrr.io/r/base/with.html