# R in VSCode

2024-08-29

***

## 简介

R 是为统计和可视化设计的动态语言，常用于统计分析、科学计算、机器学习和数据可视化。

vscode 的 [R 插件](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r) 支持语法高亮、代码完成、linting、格式化、与 R 终端交互、查看数据、plots、查看工作空间变量、help 页面、管理 packages 以及 R Markdown。

## 入门

### 安装

1. [安装 R](https://cloud.r-project.org/) (>= 3.4.0)。对 Windows，安装 R 时建议勾选 "Save version number in registry"，便于 vscode R 插件自动查找 R。
2. 在 R 中安装 `languageserver`。

```r
install.packages("languageserver")
```

3. 在 vscode 安装 R 插件。
4. 创建 R 文件，开始写代码。

为了增强在 vscode 使用 R 的体验，建议安装：

- [radian](https://github.com/randy3k/radian): 一个现代 R console，在官方 R console 的基础上提供了许多额外功能，如语法高亮、自动完成等。
- [httpgd](https://github.com/nx10/httpgd): 一个 R 包，通过 HTPP 和 Websockets 异步提供 SVG 图形。vscode 的 R 插件通过该包提供图形的交互查看功能。

### 运行 R code

运行 R 代码就是将代码发送到 R 终端。在运行 R 代码前，可以使用命令 `R: Create R terminal` 创建一个 R 终端。

准备好 R 终端，可以选择代码，或者将光标放在要运行代码的开头或结尾，按 `Ctrl+Enter`，代码就发送到 R 终端。

如果想运行整个 R 文件，先在编辑器中打开该文件，并按 `Ctrl+Shift+S`，文件将发送到终端运行。

### 代码补全（IntelliSense）

R 插件支持代码补全和许多其它代码编辑功能。补全功能显示当前 scope 可用的函数和变量，以及包的文档：

![](./images/completion.gif)

### Linting

Linting 是检查代码是否有警告和潜在错误的功能。R 代码 linting 功能由 lintr 包提供。通过配置文件可以选择其他 linter。



## R 终端

### 创建 R 终端

在 vscode 窗口，按 F1 或 `Ctrl+Shift+P`，选择 `R: Create R terminal` 命令，启动 R 终端。

默认为官方 R 终端。但 vscode 团队更推荐 radian 终端。





## 参考

- https://code.visualstudio.com/docs/languages/r