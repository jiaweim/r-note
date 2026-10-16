# base::tempfile

@since 2026-10-16⭐
@author Jiawei Mao
***
`tempfile` 返回一个字符串向量，可作为临时文件名。

```r
tempfile(pattern = "file", tmpdir = tempdir(), fileext = "")
tempdir(check = FALSE)
```

## 参数

### pattern

非空字符串向量，设置文件名前缀。

多个前缀表示创建多个文件名。

### tmpdir

非空字符向量，设置存放目录。

### fileext

非空字符串向量，设置文件后缀。

### check

逻辑值（TRUE/FALSE），是否检查 `tempdir()` 返回的目录；目录失效时自动重建。

## 详细说明

返回向量的长度等于 `pattern`, `tmpdir`, `fileext` 三者中最长参数的长度；较短参数的值循环复用。

生成的文件名在同一 R 会话或多个并行 R 会话中基本唯一（除非手动指定 `tmpdir`），且保证生成时文件不存在（避免覆盖已有文件）。

**文件名拼接规则**：`tmpdir` 路径+`pattern` 前缀+随机十六进制字符串+`fileext` 后缀。

`tmpdir` 默认为是 `tempdir()` 返回的目录，即 R 会话启动时创建的会话临时目录的子目录：

- 系统按顺序读取环境变量 `TMPDIR`、`TMP` 和 `TEMP`，选用第一个可写入目录；
- 全部失败则使用 `R_USER`（参见 Rconsole）；
- 如果目录路径包含空格，返回的路径将使用短名称版本（如果该版本不包含空格的话）。

> [!NOTE]
>
> R 会话启动后修改上述环境变量，不影响 `tempdir()`，因为会话临时目录在 R 启动时就已确定。

## 返回值

- `tempfile`：返回字符串向量，内容为候选临时文件名。**注意：`tempfile` 不会创建实体文件。**
- `tempdir`：返回当前 R 会话临时目录的路径。

Windows 下两者的路径分隔符为反斜杠（`\`）。 

类 Unix 系统默认返回绝对路径（`tmpdir` 被设为相对路径时除外），但不一定是规范路径（参见 `normalizePath`），在 macOS 上通常不是规范路径。

## 并行使用注意事项

`parallel` 包的 `mclapply` 和 `makeForkCluster` 等函数创建的派生 R 进程，共享当前会话临时目录。此外，文件名当前未被占用仅在请求时生效，多个子进程并发调用可能冲突。可让不同子进程使用不同前缀调用 `tempfile` 来避免该问题。

## 来源

`tempdir()` 的最终目录由 POSIX 系统调用 `mkdtemp` 创建；Windows 等不支持该调用的平台，则使用基于 GNU glibc 的实现。

目录命名格式为 `RtmpXXXXXX`，最后 6 个字符以平台特定的方式填充：

- POSIX 仅要求填充字符为 ASCII，包括 `.`（看起来像带有文件扩展名）以及正则表达式元字符（如 `+`）。
- 多数平台使用 `[A-Za-z0-9]`，也可能出现 `.`。

## 另见

[unlink](./unlink.md) 用于删除文件。

## 示例

- 多个前缀。注意：生成的文件名中有空格

```R
> tempfile(c("ab", "a b c"))
[1] "C:\\Users\\jiawe\\AppData\\Local\\Temp\\RtmpI7J020\\abbaf836353fb"   
[2] "C:\\Users\\jiawe\\AppData\\Local\\Temp\\RtmpI7J020\\a b cbaf86da4597"
```

- 多个扩展名

```R
> tempfile("plot", fileext = c(".ps", ".pdf"))
[1] "C:\\Users\\jiawe\\AppData\\Local\\Temp\\RtmpI7J020\\plotbaf84f834ac5.ps"
[2] "C:\\Users\\jiawe\\AppData\\Local\\Temp\\RtmpI7J020\\plotbaf8ba47808.pdf"
```

- 临时目录

在所有平台适用，结果取决于具体的平台

```R
> tempdir()
[1] "C:\\Users\\jiawe\\AppData\\Local\\Temp\\RtmpI7J020"
```

- `check` 参数：展示 'check' 参数在某些平台上的工作原理

```R
if (exists("I'm brave") && `I'm brave` &&
  identical(.Platform$OS.type, "unix") && grepl("^/tmp/", tempdir())) {
  cat("Current tempdir(): ", tempdir(), "\n")
  cat(
    "Removing it :", file.remove(tempdir()),
    "; dir.exists(tempdir()):", dir.exists(tempdir()), "\n"
  )
  cat("and now  tempdir(check = TRUE) :", tempdir(check = TRUE), "\n")
}
```

