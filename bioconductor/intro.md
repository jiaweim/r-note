# Bioconductor

## 简介

Bioconductor 是用于生物信息数据的注释、处理、分析及可视化工具包的总集，由一系列 R 扩展包组成。

Bioconductor 每年更新两次，目前（Bioc 3.17）包含：

- 2183 个软件包
- 910 个注释包
- 416 个实验数据包
- 28 个工作流

常用包：

- Biostrings, 序列处理包
- 

## 镜像设置

Bioconductor 镜像源配置文件之一是 `.Rprofile` 文件。

该文件在 Linux 位于 `~/.Rprofilee`，在Windows 位于 `~\library\base\R\Rprofile`。

在该文件末尾或在 R Conole 键入如下内容：

```r
options(BioC_mirror="https://mirrors.tuna.tsinghua.edu.cn/bioconductor")
```

即可使用 Bioconductor 镜像源安装 Bioconductor。命令：

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("$package_name")
```

## 参考

- https://www.bioconductor.org/