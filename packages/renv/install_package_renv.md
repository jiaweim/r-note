# 使用 renv 安装 package

```R
install(
  packages = NULL,
  ...,
  exclude = NULL,
  library = NULL,
  type = NULL,
  rebuild = FALSE,
  repos = NULL,
  prompt = interactive(),
  dependencies = NULL,
  verbose = NULL,
  lock = FALSE,
  project = NULL
)
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