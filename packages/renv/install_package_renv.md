# 使用 renv 安装 package

## 概览

`install()` 使用了与 `restore()` 相同的底层机制（即它会尽可能利用已缓存的包），但它**不会**遵循锁文件（lockfile）的限制，而是直接安装 CRAN 上可用的最新版本。

```R
install(
  packages = NULL,
  ...,
  include = NULL,
  exclude = NULL,
  library = NULL,
  type = NULL,
  rebuild = FALSE,
  repos = NULL,
  prompt = interactive(),
  dependencies = NULL,
  verbose = NULL,
  transactional = NULL,
  lock = FALSE,
  project = NULL
)
```

### packages

可以是 `NULL`（默认值），表示安装项目所需的所有包；也可以是一个字符向量，指定要安装的包。`renv` 支持 `remotes` 包安装语法的一个子集，例如：

- `pkg`: 从 CRAN 安装 `pkg` 的最新版本。
- `pkg@version`: 从 CRAN 安装 `pkg` 的指定版本。
- `username/repo`: 从 GitHub 安装包。
- `username/repo@ref`: 从指定的 Git 引用（分支、标签或 SHA）安装。
- `username/repo:subdir`: 从 GitHub 仓库的子目录安装。
- `bioc::pkg`: 从 Bioconductor 安装 `pkg`。

更多详细信息，请参阅 https://remotes.r-lib.org/articles/dependencies.html 以及下方的示例。

请注意，`renv` 在一个重要的地方与 `remotes` 的规范有所不同：子目录与仓库地址之间使用 `:` 而不是 `/` 分隔。例如，要从 GitHub 包 `username/repo` 的 `subdir` 子目录安装，你应该使用：

```
renv::install("username/repo:subdir")
```



## 示例

- 安装最新版的 digest

```R
renv::install("digest")
```

- 安装特定版本的 digest

```R
renv::install("digest@0.6.18")
```

- 从 GitHub 安装最新版的 digest

```R
renv::install("eddelbuettel/digest")
```

- 从 GitHub 安装特定 commit 的 digest

```R
renv::install("eddelbuettel/digest@df55b00bff33e945246eff2586717452e635032f")
```

- 从 Bioconductor 安装 package

```R
renv::install("bioc::Biobase")
```

> 需要安装 BiocManager 

- 从指定路径安装 package

```R
renv::install("~/path/to/package")
```

- 根据 DESCRIPTION 文件安装 packages

```R
renv::install()
```

## 参考

- https://rstudio.github.io/renv/reference/install.html