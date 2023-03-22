# BiocManager

## 简介

BiocManager 用于安装和管理 Bioconductor 项目的软件包。Bioconductor 致力于高通量基因组数据的统计分析。

## install

```r
install(
  pkgs = character(),
  ...,
  site_repository = character(),
  update = TRUE,
  ask = TRUE,
  checkBuilt = FALSE,
  force = FALSE,
  version = BiocManager::version()
)
```

