# base::connections

创建、打开和关闭连接的函数，即广义文件，支持压缩文件、URL、管道等。

```R
file(description = "", open = "", blocking = TRUE,
     encoding = getOption("encoding"), raw = FALSE,
     method = getOption("url.method", "default"))

url(description, open = "", blocking = TRUE,
    encoding = getOption("encoding"),
    method = getOption("url.method", "default"),
    headers = NULL)

gzfile(description, open = "", encoding = getOption("encoding"),
       compression = 6)

bzfile(description, open = "", encoding = getOption("encoding"),
       compression = 9)

xzfile(description, open = "", encoding = getOption("encoding"),
       compression = 6)

zstdfile(description, open = "", encoding = getOption("encoding"),
       compression = 9)

unz(description, filename, open = "", encoding = getOption("encoding"))

pipe(description, open = "", encoding = getOption("encoding"))

fifo(description, open = "", blocking = FALSE,
     encoding = getOption("encoding"))

socketConnection(host = "localhost", port, server = FALSE,
                 blocking = FALSE, open = "a+",
                 encoding = getOption("encoding"),
                 timeout = getOption("timeout"),
                 options = getOption("socketOptions"))

serverSocket(port)

socketAccept(socket, blocking = FALSE, open = "a+",
             encoding = getOption("encoding"),
             timeout = getOption("timeout"),
             options = getOption("socketOptions"))

open(con, ...)
## S3 method for class 'connection'
open(con, open = "r", blocking = TRUE, ...)

close(con, ...)
## S3 method for class 'connection'
close(con, type = "rw", ...)

flush(con)

isOpen(con, rw = "")
isIncomplete(con)

socketTimeout(socket, timeout = -1)
```

## 参数

### description

字符串，连接描述信息，详见详细说明。

### open

字符串，打开模式；请见模式部分。

### blocking

逻辑值，参见阻塞部分。

### encoding

字符串，指定编码名称。请参见编码部分。

### raw

逻辑值：`TRUE` 表示使用原始接口，适合处理非常规文件（如字符设备）；以 text-mode 读取模式打开时，该选项会调过对压缩文件的检查，并断言该文件不支持随机访问。

### method

字符串，与 `c("default", "internal", "wininet", "libcurl")` 部分匹配：详见详细说明部分。

### headers

带名称的字符串向量，为 HTTP 请求中的 HTTP 请求头；对非 HTTP 的 URL 忽略此参数。系统会自动将来自 `HTTPUserAgent` 选项（见 `options`）的 `User-Agent` 请求头作为第一个请求头使用。

- **compression**（压缩级别）：0–9 之间的整数（对于 `zstdfile` 为 1–19）。写入时应用的压缩程度，从最小到最大可用级别。对于 `xzfile` 和 `zstdfile`，该值也可以是负数：详见“压缩（Compression）”部分。
- **timeout**（超时时间）：数值型。此连接使用的超时时间（以秒为单位）。请注意，某些操作系统可能会将非常大的值视为零：但 POSIX 标准要求支持高达 31 天的值。
- **options**（选项）：可选的字符串向量，包含特定选项。目前 TCP 套接字仅支持 `"no-delay"`（无延迟）选项。
- **filename**（文件名）：ZIP 压缩包内的文件名。
- **host**（主机）：字符串。端口对应的主机名。
- **port**（端口）：整数。TCP 端口号。
- **server**（服务器模式）：逻辑值。该套接字应作为客户端还是服务器？
- **socket**（套接字）：一个正在监听连接的服务器套接字。
- **con**（连接）：一个连接对象。
- **type**（类型）：字符串。目前被忽略。
- **rw**（读写权限）：字符串。空字符串、`"read"`（读）或 `"write"`（写），允许部分匹配。
- **...**（其他参数）：传递给其他方法或从其他方法接收的参数。




