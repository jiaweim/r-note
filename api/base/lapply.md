# lapply

对 List 或 Vector 应用函数。

```r
lapply(X, FUN, …)

sapply(X, FUN, …, simplify = TRUE, USE.NAMES = TRUE)

vapply(X, FUN, FUN.VALUE, …, USE.NAMES = TRUE)

replicate(n, expr, simplify = "array")

simplify2array(x, higher = TRUE)
```

- `lapply` 返回一个与 `X` 长度相同的 list。


## 参考

- https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lapply