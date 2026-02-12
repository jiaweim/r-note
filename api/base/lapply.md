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

## replicate

`replicate` 用于重复执行表达式。

```R
replicate(n, expr, simplify = "array")
```

- n

重复次数

- expr

执行的表达式。

**例1**：把 `1+1` 执行 3 次

```R
> replicate(3, 1+1)
[1] 2 2 2
```




## 参考

- https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lapply