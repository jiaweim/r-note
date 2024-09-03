# renv 快速入门

2024-09-03 ⭐
@author Jiawei Mao

***

## 概述

<img src="./images/renv.png" style="zoom:67%;" />

## Libraries 和 repositories

**库（library）**: 包含安装的 packages 的目录。

这个术语的概念容易混淆，例如 `library(dplyr)` 加载的时 dplyr 包，而是库。不过没关系，我们基本上不需要考虑库的问题，直接将所有 package 安装到所有项目共享的系统库。使用 renv，则将开始使用项目库（project library），即为每个项目单独维护 packages。

- 使用 `.libPaths()` 查看当前库
- 使用 `lapply(.libPaths(), list.files)` 查看每个库中可用的包

**存储库（repository）**: 是 packages 的来源。

`install.packages()` 从 repository（通常是网络上的某个地方）获取 package，将其放入 library（计算机上的一个目录）。CRAN 是最重要的 repository，其它免费的 repository 还有 [Bioconductor](https://bioconductor.org/), [Posit Public Package Manager](https://packagemanager.posit.co/) 和 [R Universe](https://r-universe.dev/search)，R universe 将 GitHub 转变成 repository。

- 使用 `getOption("repos")` 查看当前使用的 repository
- 调用 `install.packages("{pkgname}")`，R 会依次在每个 repository 查找 `pkgname`

## 使用 renv

使用 `renv::init()` 将项目转换为 renv 管理。它会在项目中添加三个文件和目录：

- 项目库 `renv/library`，包含项目使用的所有包的库。调用 `renv::init(bare=TRUE)` 表示跳过依赖发现，初始化一个空的项目库。项目库是 renv 的核心。
- lockfile `renv.lock`，记录项目使用的所有 packages 的信息。在使用 `renv::snapshot()` 和 `renv::restore()` 或涉及 lockfile。
- 项目 R profile 文件 `.Rprofile`。在项目里启动 R 每次都会运行该文件，renv 使用该文件配置 R 会话，以使用项目库。这确保为项目启用 renv 后，它一直处于运行状态。

`renv::snapshot()` 和 `renv::restore()` 是下一对重要工具。

- `snapshot()` 使用项目库中当前使用的包的元数据更新 lockfile。
- `restore()` 使用 lockfile 的信息安装每个 package 的对应版本。

因此，通过共享 lockfile，其他人就可以通过 `restore()` 轻松重现环境。

到这里已经对 renv 的核心概念有了理解，下面展示几个特定的 workflow。

### 共享

使用 renv 的一个重要原因是使得代码共享更容易，使得别人能获得与你完全相同版本的包。流程：

1. `renv::init()` 初始化
2. 将 `renv.lock`, `.Rprofile`, `renv/settings.json` 和 `renv/activate.R` 提交到版本控制系统，如果使用 git 会相对简单，renv 会创建 `.gitignore` 文件

现在，当你的合作者打开这个项目，renv 会自我引导，下载和安装对应版本的 renv。它会主动循环用户是否希望通过 `renv::restore()` 下载并安装所需的所有软件包。

### 安装 package

renv 支持继续使用原来的工具安装包：

```R
install.packages()
```

也可以使用 renv 工具：

```R
renv::install()
```

`renv::install()` 的优点是：输入更少，而且可以安装来自 GitHub、Bioconductor 等的包，不限于 CRAN。

> [!NOTE]
>
> 如果在多个项目中使用 renv，就有多个项目库，意味着需要在多个位置安装相同的包。如果需要反复下载、甚至编译相同的包，就会很烦，因此 renv 包含 package 缓冲功能。只需要下载并安装一次，后续的每次安装，renv 只是在项目库中添加一个到缓存的链接。

安装包后，确定代码工作正常，就可以调用 `renv::snapshot()` 以在 lockfile 中记录包的最新版本。

如果正在与他人写作，还需要将 lockfile 的更改提交到 git，当他们下次处理项目时应该调用 `renv::restore()`。

### 更新 package

使用 `renv::update()` 获取所有依赖性的最新版本，也可以使用 `update.packages()`，不过和安装工具一样，`renv::update()` 支持更多 repository。

调用 `renv::update()` 后，最好运行项目代码，检查是否依然能正确工作。然后调用 `renv::snapshot()` 更新 lockfile。

- 如果使用新版的 packages 项目无法正确工作，可以调用 `renv::restore()` 回滚到之前的状态。
- 如果要回滚到更早的版本，可以参考 `renv::history()` 和 `renv::revert()`。

`renv::update()` 会同时更新 renv 本身。如果只想更新 renv，可以使用 `renv::upgrade()`。

## lockfile

下面介绍 lockfile 文件的格式。

lockfile 文件名总是 `renv.lock`，这是一个 json 文件，记录重新安装 package 所需的所有信息。下面是一个 lockfile 示例，其中 markdown package 是从 CRAN 安装，mime package 从 GitHub 安装：

```json
{
  "R": {
    "Version": "4.3.3",
    "Repositories": [
      {
        "Name": "CRAN",
        "URL": "https://cloud.r-project.org"
      }
    ]
  },
  "Packages": {
    "markdown": {
      "Package": "markdown",
      "Version": "1.0",
      "Source": "Repository",
      "Repository": "CRAN",
      "Hash": "4584a57f565dd7987d59dda3a02cfb41"
    },
    "mime": {
      "Package": "mime",
      "Version": "0.12.1",
      "Source": "GitHub",
      "RemoteType": "github",
      "RemoteHost": "api.github.com",
      "RemoteUsername": "yihui",
      "RemoteRepo": "mime",
      "RemoteRef": "main",
      "RemoteSha": "1763e0dcb72fb58d97bab97bb834fc71f1e012bc",
      "Requirements": [
        "tools"
      ],
      "Hash": "c2772b6269924dad6784aaa1d99dbb86"
    }
  }
}
```

可以看到，该文件重要包含两部分：R 和 Packages。

- `R` 包含使用的 R 版本，以及 repository 列表
- `Packages`，包含项目所使用的 package，每个 package 的字段来自 package 的 DESCRIPTION 文件

## 警告

需要强调的是，renv 不是可重复性的万能解决方案。它只是解决整个问题中的一个：R 包。目前还有很多其它地方 renv 无法解决的问题：

- R 版本：renv 仅记录软件包使用的 R 版本。renv 本身在 R 中运行，无法提供 R 版本管理功能。[rig ](https://github.com/r-lib/rig) 提供 R 版本管理功能。
- pandoc: rmarkdown 依赖于 pandoc，但 pandoc 没有与 rmarkdown 包捆绑在有一起。因此，单纯从 lockfile 恢复 rmarkdown 不足以保证完整相同的 rmarkdown 文档渲染。使用 [pandoc package](https://cderv.github.io/pandoc/) 可解决该问题。
- 操作系统、系统库版本、编译版本：维护一个稳定的镜像是一个单独的挑战，Docker 是一个流行的解决方案。参考 [vignette("docker", package = "renv")](https://rstudio.github.io/renv/articles/docker.html) 如何结合 renv 和 Docker。

另外还需要注意，如果最初包是通过二进制文件安装的，但是二进制文件现在没了，安装包就会失败。renv 会尝试通过源码安装，但可能因为缺少系统依赖项而失败。

## 卸载 renv

停用并卸载 renv:

- 使用 `renv::deactivate()` 停用 renv。该操作会从项目的 `.Rprofile`移除 renv，但不会删除项目中其它 renv 文件。如果想重新激活 renv，使用 `renv::activate()`。
- 调用 `renv::deactivate(clean=TRUE)` 从项目完全删除 renv。如果以后想再次使用 renv，需要从 `renv::init()` 从头开始。

如果想在所有项目都停止使用 renv，则还需要用以下 R 代码删除 renv 的全局结构：

```R
root <- renv::paths$root()
unlink(root, recursive = TRUE)
```

然后使用 `utils::remove::packages("renv")` 卸载 renv。