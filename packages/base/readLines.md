# base::readLines

@since 2026-10-16⭐
@author Jiawei Mao
***
从 `connection` 中读取文本行，支持读取部分或全部内容。

```r
readLines(con = stdin(), n = -1L, ok = TRUE, warn = TRUE,
          encoding = "unknown", skipNul = FALSE)
```

## 参数

### con

`connection` 对象或字符串。

### n

整数，读取的最大行数；负值表示读取至末尾。

### ok

逻辑值，是否允许 `n>0` 时读取内容不足 `n` 就到末尾；不允许就报错。

### warn

逻辑值，如果文件末尾缺少换行符，或文件中包含 NUL 字符，是否发出警告？

### encoding

输入文本编码。用于将字符串标记为已知的 Latin-1、UTF-8 或字节流，不执行转码；若需转码，请在连接 `con` 或  `options(encoding=)` 中设置，参见示例和详细说明。

### skipNul

逻辑值，是否跳过 NUL 字符。

## 详细说明

如果 `con` 为字符串，该函数会调用 `file` 创建文件连接，该连接在本次调用期间保持打开；支持压缩文件。文件路径的波浪号展开由 `file` 完成：

- 如果连接已打开，则从当前位置开始读取。
- 如果未打开，则以 `"rt"`（只读文本）模式打开，读取完毕后关闭（连接对象不会被销毁，必须手动调用 `close`）。

如果文件最后一行缺少换行符（EOL），其行为由连接的阻塞属性决定：

- 非阻塞文本模式连接，不完整行会被静默推回（舍弃）
- 其他连接读取该行并发出警告

无论连接以何种模式打开，LF、CRLF、CR 均可作为 EOL 标记。

输入流中嵌入的 NUL 字符会终止正在读取的行，并给出警告（除非 `skipNul = TRUE` 或 `warn = FALSE`）。

如果 `con` 未打开且设置了非默认的 `encoding`，文本将被转换为 UTF-8 并如此声明（此时 `readLines` 的 `encoding` 参数被忽略），参见示例。

## 返回值

字符串向量，长度等于读取的行数；如果 `encoding` 为 `"latin1"` 或 `"UTF-8"`，结果的元素会带有声明的编码。

## 注意

默认连接 `stdin` 可能与 `con = "stdin"` 不同：参见 `file`。

## 另见

`connections`（连接）, `writeLines`（写入文本行）, `readBin`（读取二进制文件）, `scan`（扫描读取）。

## 示例

```r
# 运行示例

fil <- tempfile(fileext = ".data")
cat("TITLE extra line", "2 3 5 7", "", "11 13 17", file = fil,
    sep = "\n")
readLines(fil, n = -1)
unlink(fil) # 清理临时文件

## 阻塞模式与非阻塞模式的差异
fil <- tempfile("test")
cat("123\nabc", file = fil)
readLines(fil) # 会给出警告的行

con <- file(fil, "r", blocking = FALSE)
readLines(con) # 仅返回 "123"
cat(" def\n", file = fil, append = TRUE)
readLines(con) # 获取到剩余的两部分
close(con)

unlink(fil) # 清理临时文件

## Not run: 
# 读取一个 'Windows Unicode' 文件
A <- readLines(con <- file("Unicode.txt", encoding = "UCS-2LE"))
close(con)
unique(Encoding(A)) # 极有可能为 UTF-8

## End(Not run)
```