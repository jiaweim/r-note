# renv 常见问题解答

## 为什么我的包没有被快照到锁文件中？

要让一个包被记录到锁文件中，它必须同时满足以下两个条件：

1. 已安装在你的项目库（project library）中，并且
2. 被项目实际使用（由 `renv::dependencies()` 判定）

这一机制确保了只有你的项目真正需要的包才会进入锁文件；而开发依赖项（例如 `devtools`）通常不应该被包含在内的。

因此，如果你发现某个包没有进入锁文件，请检查 `renv::dependencies()` 的输出结果。如果某个你期望的包没有被列出来，这很可能是因为 `dependencies()` 采用的是静态分析（static analysis），它无法理解一个包在项目中所有可能的使用方式。

## 捕获所有依赖项

如果你更倾向于将安装到项目库中的所有包都捕获下来（并且完全跳过依赖项发现机制），可以通过以下代码来实现：

```R
renv::settings$snapshot.type("all")
```

此外，你也可以通过项目设置来显式忽略某些包，例如：

```R
renv::settings$ignored.packages("<package>")
```

你可能还需要仔细检查一下被忽略的包列表（`renv::settings$ignored.packages()`），确认自己没有不小心把项目实际需要的包给忽略掉了。

## 捕获显式依赖项

如果你想明确声明你的项目依赖于哪些包，可以通过让 renv 生成“显式（explicit）”快照来实现：

```R
renv::settings$snapshot.type("explicit")
```

在这种模式下，renv 只会包含那些在项目的 `DESCRIPTION` 文件中被明确列为依赖项的包。

## 如何更新锁文件

最重要的一点是：`renv::snapshot()` 捕获的是你调用该函数那一刻的项目状态。从这个意义上说，更新锁文件的“正确”步骤应该是：

1. 加载 renv 项目；
2. 进行你想要的更改（例如：安装包、调用 `options(repos = <...>)` 修改仓库源等）；
3. 调用 `renv::snapshot()` 来更新锁文件。

话虽如此，如果有必要，你也可以直接手动修改 `renv.lock` 锁文件；例如，当你想手动添加或更改仓库源、更改所使用的包版本等。`renv.lock` 本质上是一个 JSON 文件，在 renv 的官方代码仓库中提供了相应的 JSON 模式（schema）供参考。

直接在锁文件中编辑包记录的主要缺点是：你将无法为该包提供哈希值（Hash），因此 renv 在安装该包时，将无法利用其全局包缓存。

如果你手动编辑了锁文件，可以使用 `renv::lockfile_validate()` 函数，根据 renv 的 JSON 模式来验证文件格式是否正确：

```R
renv::lockfile_validate()
```

## 如何处理开发依赖项

这与前面的问题有关：按照设计，`renv.lock` 通常只捕获构建时或部署时所需的依赖项；它可能不会捕获你在迭代开发工作流中使用的包（例如 `devtools`）。然而，你可能希望在恢复项目库时，仍然有办法确保这些开发依赖项被正确安装。

针对这种情况，我们建议将这类包记录在项目的 `DESCRIPTION` 文件中；通常写在 `Suggests:` 字段下。然后，你可以执行：

```
renv::install()
```

来请求 renv 按照 `DESCRIPTION` 文件中的描述安装包。此外，`Remotes:` 字段也会被解析和使用，以确保包能够从声明的远程源（如 GitHub 等）正确安装。

如果你希望开发依赖项默认也被包含在锁文件中，可以设置：

```
renv::settings$snapshot.dev(TRUE)
```

开启此选项后，`renv::snapshot()` 和 `renv::status()` 将会自动包含开发依赖项。”