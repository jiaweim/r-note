# Rserve

## 简介

Rserve 是一款基于 TCP/IP 协议的服务器，它允许其他程序通过多种编程语言调用 R 语言的功能，而无需初始化 R 环境或链接 R 库。每个连接都拥有独立的工作空间与工作目录。目前已为多种常用语言提供客户端实现，包括 C/C++、PHP、JavaScript 以及 Java。Rserve 支持远程连接、身份验证与文件传输功能。其典型应用场景是在其他应用程序中集成 R 作为后端，用于统计模型计算、绘图等任务。

以下 Java 代码演示集成 Rserve 的简易性：

```java
RConnection c = new RConnection();
double d[] = c.eval("rnorm(10)").asDoubles();
```

如果本地主机上运行着 Rserve，那么变量 `d` 中将包含 10 个服从标准正态分布 $N(0,1)$ 的随机样本。对于后续执行的命令，无需重复创建 `RConnection`连接（不过，除非进行显式同步处理，否则每个线程必须拥有独立的连接对象）。

顺便提一下 —— 如果只是想在单个应用程序中实现 Java 调用 R，而不需要使用客户端 / 服务器架构，那么可以了解一下**JRI**。它通过 **JNI（Java 本地接口）** 将 R 直接嵌入 Java 中运行。

原始的 Rserve 论文发表于 [DSC-2003 会议论文集](http://www.ci.tuwien.ac.at/Conferences/DSC-2003/Proceedings/Urbanek.pdf)中。使用 Rserve 时请引用该篇论文。

**注意**：Rserve 非常适合作为网络服务的后端，并且也常被用于该场景。另可参见 FastRWeb。

### Rserve 特点

- **快速高效**—— 无需初始化 R 环境。
- **二进制传输**—— 传输协议以二进制数据形式发送 R 对象，而非仅发送 R 文本输出。
- **自动类型转换**—— 大多数 R 数据类型会转换为本机数据类型，例如 `rnorm(10)` 的结果在 C/Java 中会是 `double[10]` 类型。Java 客户端还为 R 新增类型提供了对应类，如 `RBool`、`RList` 等。
- **持久性**—— 每个连接拥有独立的命名空间和工作目录。创建的所有对象都会持久保留，直至连接关闭。客户端无需获取或存储中间结果。
- **客户端独立性**—— 由于客户端不与 R 链接，因此不会出现类似 rJava 等工具中的线程问题。
- **安全性**——Rserve 通过服务端质询机制支持加密的用户名 / 密码认证，提供基础安全保障。也可配置为仅接受本地连接。此外，Rserve 支持 OCAP（对象能力）模式，可禁止任意代码执行，仅允许应用暴露指定函数。最后，Rserve 还支持加密连接（TLS/SSL）。
- **文件传输**——Rserve 协议支持在客户端与服务器之间传输文件。因此即使是生成绘图图片等任务，也可将 Rserve 作为远程服务器使用。
- **可配置性**—— 通过单个配置文件管控各项设置，启用或禁用认证、远程访问、文件传输等功能。
- **内置网页服务**——Rserve 可作为网页服务器，提供静态内容和 R 脚本服务；同时支持 WebSocket，实现浏览器与 R 的直接通信，支持高效的交互式绘图。

### 客户端

Rserve 自带 Java 客户端以及一个极为精简的 C++ 客户端，但由于它采用开放协议，其他开发者也热心构建了面向 Rserve 的开源客户端。

- 与 Rserve 捆绑的 REngine（Java 客户端）
- rserve-js（JavaScript 客户端），被 RCloud 采用
- RSclient（R 语言客户端），由本人维护
- rserve-php（PHP 客户端）
- RClientCxx（C++ 客户端）
- RserveCLI2（C# 客户端）
- pyRserve（Python 客户端）
- Rserve-Ruby-client（Ruby 客户端）

### Rserve 不具备的功能

- Rserve **不提供回调功能**。你的应用程序可以通过 TCP/IP 以及 R 套接字自行实现回调，但这不属于 Rserve 自带功能。（注：目前在 OCAP 模式下可通过 OOB 命令支持回调）
- Rserve **不是 R 的 telnet 前端**。控制台打印输出不会被传输（除非使用 `capture.output` 捕获）。Rserve 采用二进制协议传输对象以获得更高性能。（注：在 OCAP 模式下现已支持控制台输入输出）
- Rserve 在**不同连接之间是线程安全的**，但在**同一个连接内部，eval 方法并非线程安全**。这意味着多个线程不应共用同一个连接，除非能确保不会并行执行 eval 调用。

## 参考

- https://www.rforge.net/Rserve/index.html