# R Packages

## 简介

本文介绍如何创建 R 包。

在 R 语言中，包（package）是可共享代码的基本单元。一个包将代码、数据、文档和测试捆绑在一起，方便与他人贡献。截止 2026年2月13号，CRAN（Comprehensive R Archive Network）上已有 23174 个包。庞大的包资源库是 R 语言成功的语言之一：你需要解决的问题前人已经搞定了，你只需要下载他们的包，直接使用即可。

package 常用操作：

- `install.packages("x")` - 从 CRAN 安装 package
- `library("x")` 或 `library(x)` - 在 R 中加载并使用 package
- `package?x` 和 `help(package = "x")` 查看 package 的文档

文本的目的是介绍如何开发软件包，让你不仅能使用别人的包，还能写出属于自己的包。

## 1. 完整流程

下面完整走一遍开发一个小型工具包的流程，并建议一套可行的工作流。

### 1.1 加载 devtools 和其它工具

首先加载 `devtools`，`devtools` 是一套支持开发工具的接口。在加载 `devtools`，会同时加载 `usethis`。

```R
> library(devtools)
载入需要的程序包：usethis
```

查看 devtools 版本：

```R
> packageVersion("devtools")
[1] ‘2.4.6’
```

### 1.2 示例包：regexcite

下面从零开始构建一个小型包，涵盖包中常见功能：

- 函数：本例中是用于辅助正则表达式工作的函数
- 版本控制
- 成熟的工作流：安装、获取帮助以及质量检查
- 函数文档：通过 `roxygen2` 生成
- 单元测试：使用 `testthat` 进行
- 整体包文档：通过可执行的 `README.Rmd` 文件呈现

将这个包命名为 regexcite，它包含几个简单函数，用于简化正则表达式的常见操作。

> [!NOTE]
>
> regexcite 非常简单，不是很有用，仅用于展示。已有许多正则表达式的实用工具，如 `stringr`, `stringi`, `rex`, `rematch2` 等。

### 1.3 成品预览

`regexcite` 开发过程使用 Git 版本控制系统，GitHub 上有一个成品：https://github.com/jennybc/regexcite

### 1.4 create_package()

调用 `create_package()` 即可在指定目录初始化一个新 package。如果该目录不存在，`create_package()` 会自动创建。

目录的选择：

- 不应该嵌套在另一个 RStudio 项目中，另一个 R 包中或 Git 仓库内部
- 不应放在 package-library 中，因为那里是用来存放已构建并安装好的 package

选好位置后，只需将下面的路径替换为你自己的路径即可：

```R
create_package("~/path/to/regexcite")
```

示例：

```R
> create_package("D:/repo/regexcite")
✔ Setting active project to "D:/repo/regexcite".
✔ Creating R/.
✔ Writing DESCRIPTION.
Package: regexcite
Title: What the Package Does (One Line, Title Case)
Version: 0.0.0.9000
Authors@R (parsed):
    * First Last <first.last@example.com> [aut, cre]
Description: What the package does (one paragraph).
License: `use_mit_license()`, `use_gpl3_license()` or friends to
    pick a license
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.3.3
✔ Writing NAMESPACE.
✔ Writing regexcite.Rproj.
✔ Adding "^regexcite\\.Rproj$" to .Rbuildignore.
✔ Adding ".Rproj.user" to .gitignore.
✔ Adding "^\\.Rproj\\.user$" to .Rbuildignore.
✔ Opening D:/repo/regexcite/ in a new session.
✔ Setting active project to "<no active project>".
```

如果使用的是 RStudio，你会发现会自动打开一个新的 RStudio 窗口，包含刚刚创建的 `regexcite` 项目。另外，也可以到目录中点击 `regexcite.Rproj` 文件打开项目。

加载 `devtools`：

```R
library(devtools)
```

下面介绍一下 `regexcite` 目录的文件：

- `.Rbuildignore` - 文件，列出那些包含在项目中，但从源码构建 R 包时应跳过的文件。简而言之，就是一个黑名单，列出那些在打包时要忽略的文件。一般使用 RStudio 才有。
- `.gitignore` - 文件，
- `DESCRIPTION` - 文件
- `NAMESPACE` - 文件
- `R` - 目录
- `regexcite.Rproj` - 文件
- `.Rproj.user` - RStudio 内部使用的目录

## 参考

- https://r-pkgs.org/
- https://cran.r-project.org/doc/manuals/R-exts.html#Creating-R-packages

