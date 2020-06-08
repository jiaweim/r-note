# 简介

- [简介](#简介)
  - [辅助软件](#辅助软件)
  - [Workspace](#workspace)
  - [图形用户界面](#图形用户界面)

2020-05-31, 09:59
***

## 辅助软件

R 可以看作 Rick Becker, John Chambers和 Allan Wilks 在贝尔实验室开发的 S 语言实现，它也是 S-PLUS的基础。

R 可以把一段程序卸载以 `.r` 或 `.R` 文本文件中，如 `date.r`，称为源码文件。在 R 命令行使用

```r
source("date.r")
```

运行源程序。

## Workspace

Workspace 是当前 R 的工作环境，包含用户自定义的对象，如向量、数据库、函数等。在一个 R 会话结束时，用户可以保存当前的用户空间镜像，下次启动 R 时自动加载镜像。

## 图形用户界面

除了内置的 R console，RStudio 是使用最广泛的 R 代码编辑器，推荐是还有。
