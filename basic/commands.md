# R Commands

- [R Commands](#r-commands)
  - [help](#help)

## help

启动帮助。例如 `help(lm)` 会显示关于函数 `lm()`（线性模型）的帮助页面。

`?lm` 和 `help("lm")` 具有相同的效果。

查询特殊语法意义字符时必须使用 `help` 函数，用 `?` 出错。

例如：

```r
> ?*
Error: unexpected '*' in "?*"
> help("*")
Arithmetic {base} R Documentation
Arithmetic Operators
...
```

`help()` 函数默认只在被载入内存中的包总搜索。将选项 `try.all.package` 设置为 `TRUE`，可以在所有包中搜索：

```r
> help("bs")
No documentation for 'bs' in specified packages and libraries:
you could try 'help.search("bs")'
> help("bs", try.all.packages = TRUE)
Help for topic 'bs' is not in any loaded package
but can be found in the following packages:

Package Library
splines /usr/lib/R/library
```

此时不会显示函数 `bs` 的帮助页面，如果要显示其帮助信息，可以使用 `package` 选项：

```r
> help("bs", package = "splines")
bs package:splines R Documentation

B-Spline Basis for Polynomial Splines
Description:
Generate the B-spline basis matrix for a polynomial spline.
...
```

使用 `help.start()` 可以启动 HTML 格式的帮助页面。