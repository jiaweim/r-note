# var.test

F 检验，比较两个来自正态总体的样本的方差。

```R
var.test(x, …)
# S3 method for default
var.test(x, y, ratio = 1,
         alternative = c("two.sided", "less", "greater"),
         conf.level = 0.95, …)

# S3 method for formula
var.test(formula, data, subset, na.action, …)
```

**ratio**: `x` 和 `y` 总体方差的假设比例。

**alternative**：指定假设类型，包括 `"two.sided"` (default), `"greater"` 或 `"less"`. 