# rep

## 简介

`rep` 用来生成重复数值。语法：

```r
rep(x, …)
rep.int(x, times)

rep_len(x, length.out)
```

`rep` 重复 `x` 中的值。

`rep.int` 和 `rep_len` 是对两种常见情况的优化版本。

rep 表示 repeat，将 a 重复 b次，获得一个向量。参数说明：

- `length.out` 输出向量的期望长度。
- `each` 表示分别重复每个元素，如 `each=2` 表示把第1个元素重复2次，再把第二个元素重复2次，以此类推。

例如：

- `rep(0, n)`, 初始值为 0 长度为 n 的向量
- `rep(c(1, 3), 2)`，把第一个向量重复3次，得到 c(1, 3, 1, 3)
- `rep(c(1,3), c(2, 4))`，按照一一对应原则重复

```r
> rep(c(1, 3), c(2, 4))
[1] 1 1 3 3 3 3
```

如果希望重复完一个元素之后，再重复另一个元素，可以用 `each=` 选项。例如：

```r
> rep(c(1, 3), each=2)
[1] 1 1 3 3
```

```r
rep.int(x, times)

rep_len(x, length.out)
```
