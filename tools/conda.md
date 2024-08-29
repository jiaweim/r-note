# R in Anaconda

## 创建 R 环境

语法：

```sh
conda create -n <ENV_NAME> r-base r-essentials
conda activate <ENV_NAME>
```

这里关键是要包含 `r-base` 包。

1. 下载并安装 Anaconda
2. 创建一个新的 conda 环境，包括所有 `r-essentials` conda 包

```sh
conda create -n r_env r-essentials r-base
```

3. 激活环境

```sh
conda activate r_env
```

4. 查看该环境中的 packages

```sh
conda list
```

## 下载 R Essentials

```sh
conda activate <ENV_NAME>
conda remove r-essentials
```

> [!NOTE]
>
> 这里只是删除 R essentials 并禁用 R 语言，不会删除其它 R 包。

## 使用 R 环境

在 vscode 中使用 R 环境，修改 `Rterm: Windows` 为 R.exe 或 radian.exe 的路径。

