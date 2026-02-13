# Rtools

2026-02-13⭐
@author Jiawei Mao
***
## 简介

Rtools 是工具链，用于从源代码构建 R 软件包，同时也用于构建 R 语言本身。

Rtools 包含：

- Msys2 build tools
- GCC 12/MinGW-w64 编译工具链
- 使用该工具链构建的库文件
- QPDF

## 安装

只有以下两种情况需要 Rtools：

1. 从 源代码构建 R 包（特别是需要编译 C/C++ 或 Fortran 代码的包）
2. 从源代码构建 R 语言本身

通常直使用安装包来安装 R，R 默认也会安装 CRAN 上的一些二进制软件，这些操作不需要 Rtools。

此外，目前也有一些在线构建服务可以用来为 Windows 检车和构建 R package，此时同时不需要安装 Rtools。例如，[Winbuilder](https://win-builder.r-project.org/) 检查服务使用的配置与 CRAN 官方检查输入 packages 的相同，而且它已经预装了所有 CRAN 和 Bioconductor 包。

下载完 Rtools 后，建议使用默认设置，包括默认的安装路径 `C:\rtools45`。

如果是使用 installer 安装的 R，那么安装好 Rtools45 后通常不需要进行额外配置，就可以开始从源代码构建 R 包。如果使用默认安装路径，R 和 Rtools45 的安装顺序没有强制要求，甚至可以在 R 正在运行的时候安装 Rtools45.

> [!NOTE]
>
> 目前 CRAN 没有为 ARM 架构提供 package 的二进制版本，因此如果需要安装任何需要编译的 package，都需要安装 Rtools。

安装好 Rtools 后，需要将包含 Rtools 可执行程序的目录添加到 `PATH`。

如 `C:\rtools40\usr\bin`。

添加好 PATH，重启 R。

使用 Rtools 构建 package 和 R：https://cran.r-project.org/bin/windows/base/howto-R-4.5.html

## 参考

- https://cran.r-project.org/bin/windows/Rtools/rtools45/rtools.html
