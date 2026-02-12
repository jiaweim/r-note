# renv

## 简介

`renv` 是一个类似 conda 的 R 包管理工具。

### 安装

从 CRAN 安装最新版的 renv：

```R
install.packages("renv")
```

或者从 r-universe 安装开发版本：

```R
install.packages("renv", repos = "https://rstudio.r-universe.dev")
```

### Workflow

<img src="./images/renv.png" alt="A diagram showing the most important verbs and nouns of renv. Projects start with init(), which creates a project library using packages from the system library. snapshot() updates the lockfile using the packages installed in the project library, where restore() installs packages into the project library using the metadata from the lockfile, and status() compares the lockfile to the project library. You install and update packages from CRAN and GitHub using install() and update(), but because you'll need to do this for multiple projects, renv uses cache to make this fast." width="500" />

`renv::init()` 为新项目或现有项目初始化 renv。该操作会创建一个项目专属的函数库，包含当前使用的所有包。这些包（以及重新安装它们所需的 metadata）记录到一个名为 `renv.lock` 的文件；同时，项目根目录下的 `.Rprofile` 文件会确保每次打开该项目都自动使用这个专属库。

在后续开发过程中，你可能会继续安装或升级包，无论通过 `install.packages`, `update.packages()`，还是通过 `renv::install()` 和 `renv::update()`。当你确认代码按预期正常运行，就可以调用 `renv::snapshot()` 将当前使用的包及其来源信息保存到 `renv.lock` 锁文件中。

以后，若需要与他人共享代码，或将项目迁移到新机器上，只需调用 `renv::restore()`，即可根据锁文件中记录的包版本信息重新安装依赖项，从而复现一致的运行环境。

## Library 和 Repository

**库**（library）是一个包含安装包的目录。这个术语容易引起混淆，因为 `library(dplyr)` 会让人以为记载 `dplyr` library，而实际上加载的是 dplyr package。不过通常情况下，我们无需考虑库的概念，所有包默认被安装到一个**系统库**（system library），所有项目共享该库。

使用 renv 后情况就不痛了：我们开始使用**项目库**（project library），即为每个项目分配单独的 package 集合，从而实现各项目之间依赖隔离。

- `.libPaths()` 查看当前 library 路径
- `lapply(.libPaths(), list.files)` 查看 library 中安装的 packages



## 参考

- https://rstudio.github.io/renv/index.html