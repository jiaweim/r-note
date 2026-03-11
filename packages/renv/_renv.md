# renv

2026-03-11 添加命令总结
2024-09-02 ⭐
@author Jiawei Mao

***

## 简介

renv，用于 R 项目的环境管理：

- **隔离性**（Isolated）：为一个项目安装或更新 package，不影响其它项目，反之亦然。因为 renv 为每个项目创建专属的私有库。
- **可移植性**（Portable）：可以轻松地将项目从一台计算机迁移到另一台计算机，甚至跨平台。用 renv 可以很容易地安装项目所依赖的包。
- **可复现性**（Reproducible）: renv 会记录项目所依赖包的具体版本，确保不管在何处部署，安装的都是完全一致的版本。

## 安装 renv

- 从 CRAN 安装最新版的 renv

```r
install.packages("renv")
```

- 或者从 r-universe 安装开发版本

```R
install.packages("renv", repos = "https://rstudio.r-universe.dev")
```

## 使用

- [renv 快速入门](./renv_intro.md)
- [安装 package](./install_package_renv.md)

命令总结：

```R
# 初始化项目
renv::init() 
renv::init(bare=TRUE) # 初始化空的项目库

# 更新或安装包
renv::install()
renv::update()

# 记录包版本，更新 lockfile
renv::snapshot()

# 安装 lockfile 中记录的包: 恢复项目库
renv::restore()
```

## Workflow

<img src="./images/renv.png" width="400" />

- 使用 `renv::init()` 在新项目或现有项目中**初始化 renv 环境**

该操作会创建一个**项目库**（project library），包含当前正在使用的所有 packages。这些 packages 的信息都记录在一个名为 `renv.lock` 的 lockfile 文件；同时生成的 `.Rprofile` 文件可以确保每次打开该项目都使用这个项目库。

- **更新**

当继续开发项目，可以使用 `install.packages()` 和 `update.packages()` 安装或升级包，也可以使用 `renv::install()` 和 `renv::update()`。在确认代码工作正确后，使用 `renv::snapshot()` 在 lockfile 中记录包的信息。

- **共享**

当需要与他人共享代码，或在新的机器上运行代码，可调用 `renv::restore()` 重新安装 lockfile 中记录的包。

## 参考

- https://github.com/rstudio/renv

