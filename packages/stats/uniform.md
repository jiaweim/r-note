# 均匀分布（Uniform Distribution）

## 描述

在区间 `[min, max]` 上的均匀分布，提供概率密度函数、累积分布函数、分位数函数以及随机数生成功能。

```R
dunif(x, min = 0, max = 1, log = FALSE)
punif(q, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE)
qunif(p, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE)
runif(n, min = 0, max = 1)
```

