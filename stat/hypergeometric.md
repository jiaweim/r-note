# 超几何分布

## 简介

超几何分布用于不放回抽样。假设盒子里有 `m` 个白球，`n` 个黑球，从中抽出 `k` 个球，则抽出的 `k` 中有 `x` 个白球的概率为：

$$p(x)=\frac{\binom{m}{x}\binom{n}{k-x}}{\binom{m+n}{k}}$$

其中 $x=0,...,k$。

超几何分布的密度、分布函数、分位数函数以及随机数生成。

```r
dhyper(x, m, n, k, log = FALSE)
phyper(q, m, n, k, lower.tail = TRUE, log.p = FALSE)
qhyper(p, m, n, k, lower.tail = TRUE, log.p = FALSE)
rhyper(nn, m, n, k)
```

## 参数

- **x, q**

向量，表示从装有黑球和白球的盒子里抽出的白球数。

- **m**

盒子中白球总数。

- **n**

盒子中黑球总数。

- **k**

从盒子中抽出的球数。

- **p**

概率，0 到 1 之间。

- **nn**



## 参考

- https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/Hypergeometric
