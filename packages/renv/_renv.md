# renv

2024-09-02 ⭐
@author Jiawei Mao

***

renv，用于 R 项目的环境管理：

- Isolated: 为一个项目安装新的 package 或更新 package，而不影响其它项目，反之亦然。因为 renv 为每个项目提供私有库。
- Portable: 将项目从一台计算机转移到另一台计算机很容易，甚至跨平台。用 renv 安装项目所依赖的包很容易。
- Reproducible: renv 会记录项目所依赖包的具体版本。

## 安装

安装最新版的 renv：

```r
install.packages("renv")
```

或者从 r-universe 安装开发版本：

```R
install.packages("renv", repos = "https://rstudio.r-universe.dev")
```

## 使用

- [renv 快速入门](./renv_intro.md)
- [安装 package](./install_package_renv.md)

## Workflow

<img src="./images/renv.png" width="500" />

- 使用 `renv::init()` 在新项目或现有项目中初始化 renv

该操作会创建一个项目库（project library），包含当前使用的所有 packages。packages 相关信息都记录在一个名为 lockfile 中，即 `renv.lock` 文件，以及一个 `.Rprofile` 文件以确保每次打开该项目都使用该库。

- 更新

当继续开发项目，使用 `install.packages()` 和 `update.packages()` 安装或升级包，或使用 `renv::install()` 和 `renv::update()`。在确认代码工作正确后，使用 `renv::snapshot()` 在 lockfile 中记录包的信息。

- 共享

当需要与其他共享代码，或在新的机器上运行代码，调用 `renv::restore()` 重新安装 lockfile 中记录的包。

## 参考

- https://github.com/rstudio/renv

