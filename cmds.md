# 常用命令

## 通用

- 查看工作目录

```R
getwd()
```

- 修改工作目录

Session > Set Working Directory > Choose Directory



## 库和包

- 查看当前库所在位置

```r
.libPaths()
```

- 查看当前库和库中所含包

```R
lapply(.libPaths(), list.files)
```

- 查看所用 repository

```R
getOption("repos")
```

## renv

- 初始化项目库

```R
renv::init()
```

- 初始化空的项目库

```R
renv::init(bare=TRUE)
```

- 更新 lockfile

```R
renv::snapshot()
```

- 安装 lockfile 中所有 packages（恢复项目库）

```r
renv::restore()
```

- 安装 package

```R
renv::install()
```

- 更新 package

```R
renv::update()
```

