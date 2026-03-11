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







