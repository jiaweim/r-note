# Help

2024-09-04 ⭐
@author Jiawei Mao

***

## 帮助函数列表

| 函数                              | 说明                                                         |
| --------------------------------- | ------------------------------------------------------------ |
| `help.start()`                    | 打开帮助文档首页（浏览器窗口），可查阅入门手册、FAQ 及参考材料 |
| `help("foo")` 或 `?foo`           | 查看函数 `foo` 的帮助文档（引号可省略）                      |
| `help(package="foo")`             | 输出 `foo` 包的帮助信息                                      |
| `help.search("foo")` 或 `??foo`   | 以 `foo` 为关键词搜索本地帮助文档                            |
| `example("foo")`                  | 运行函数 `foo` 的使用示例（引号可省略）                      |
| `RSiteSearch("foo")`              | 以 `foo` 为关键词搜索在线帮助文档和邮件列表存档              |
| `apropos("foo", mode="function")` | 列出名称中含有 `foo` 的所有可用函数                          |
| `data()`                          | 列出当前已加载包中所有可用的示例数据集                       |
| `vignette()`                      | 列出当前已安装包中所有可用的简介文档                         |
| `vignette("foo")`                 | 显示主题 `foo` 的简介信息                                    |

## 简介

获取函数帮助信息：

- `help(lm)` 会显示关于函数 `lm()`（线性模型）的帮助页面。
- `?lm` 同上
- `help("lm")` 同上

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

`help()` 函数默认只在**被载入内存**的包中搜索。将选项 `try.all.package` 设置为 `TRUE`，可以在所有包中搜索：

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

在RStudio中有一个单独的 Help 面板， 如果需要，可以用菜单“View–Panes–Zoom help”将其放大到占据整个窗口空间。 但是，这一功能目前不支持放大显示字体的功能， 不如在浏览器中方便。

RStudio的帮助窗格中包含R软件的官方文档，以及RStudio软件的的文档。 “Search engine and keywords”项下面有分类的帮助。有软件包列表。

在基本R软件而不是RStudio的命令行中运行命令 `help.start()` 或者用 RGUI 的帮助菜单中“html帮助”可以打开系统默认的互联网浏览器， 在其中查看帮助文档。

用 `example(函数名)` 的格式可以运行此函数的样例，如:

```r
> example(mean)

mean> x <- c(0:10, 50)

mean> xm <- mean(x)

mean> c(xm, mean(x, trim = 0.10))
[1] 8.75 5.50
```

## 关键字检索

用两个问号 `??` 可以检索关键字：

```R
??log
```

用于不记得函数名称的情况。

R 会拉出与关键字相关的帮助页面列表。

## Help 页面内容

| 内容        | 说明               |
| ----------- | ------------------ |
| Description | 函数功能的简短描述 |
| Usage       | 函数签名           |
| Arguments   | 参数的详细描述     |
| Details     | 对函数的深入描述   |
| Value       | 函数的返回值       |
| See Also    | 相关 R 函数的列表  |
| Examples    | 函数使用示例       |

