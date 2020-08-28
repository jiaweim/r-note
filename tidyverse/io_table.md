# Table 数据读写

- [Table 数据读写](#table-数据读写)
  - [简介](#简介)
  - [语法格式](#语法格式)

2020-08-28, 09:28
@jiaweiM
***

## 简介

`read_table()` 和 `read_table2()` 用于读写文本类型的表格数据，不同列由空格分隔。

`read_table2()` 和 `read.table()` 的功能类似，允许两列之间包含任意数量的空格，并且行的长度可以不一样。

`read_table()` 则更为严格，要求每行的长度相同，并且每个字段在每行处于相同的位置。它首先查找空 columns，然后以固定宽度解析文件。

## 语法格式

```r
read_table(file, col_names = TRUE, col_types = NULL,
  locale = default_locale(), na = "NA", skip = 0, n_max = Inf,
  guess_max = min(n_max, 1000), progress = show_progress(),
  comment = "", skip_empty_rows = TRUE)

read_table2(file, col_names = TRUE, col_types = NULL,
  locale = default_locale(), na = "NA", skip = 0, n_max = Inf,
  guess_max = min(n_max, 1000), progress = show_progress(),
  comment = "", skip_empty_rows = TRUE)
```

1. file

文件路径，connection，或字面量（如单个字符串）。

对以 .gz, .bz2, .xz 和 .zip 结尾的文件会自动解压。

对以 http://, https://, ftp:// 或 ftps:// 开头的文件会自动下载。远程的 gz 文件会被自动下载并解压。

字面量数据很适合于测试。字面量要求至少两行，从而不会被识别为路径，或者长度大于 1 的向量。

使用 `clipboard()` 则自动从系统剪切板读取数据。

2. col_names

TRUE, FALSE 或包含列名称的向量。

- `TRUE`，表示第一行为标题。
- `FALSE`，第一行不是标题，自动生成格式为 `X1`, `X2`, `X3` 这样的标题。
- 字符向量，则将该向量的值作为标题。

column 名称缺失会产生警告信息，并会填充自动生成的标题。重复的 column 名称也会有警告信息，并自动添加数字前缀以示区分。

3. col_types

NULL，`cols()` 或字符串。

- NULL，根据前 1000 行自动推断类型。该功能边界且快速，但是不稳定。如果推断失败，则需要自己手动指定类型。
- `cols()`，指定每列的类型。如果只需要读取部分列，可以用 `cols_only()`。
- 也可以用紧凑的字符串指定每列类型，每个类型对应一个字符
  
|字符|类型|
|---|---|
|c|character|
|i|integer|
|n|number|
|d|double|
|l|logical|
|f|factor|
|D|date|
|T|date time|
|t|time|
|?|guess|
|`_/-`|skip column|

4. locale

locale 的默认值因位置而异。可以使用 `locale()` 自定义时区、encoding, decimal mark, big mark 以及 day/month names。

5. na

解析为缺失值的字符串向量。将其指定为 `character()` 表示没有缺失值。

6. skip

读取前跳过的行数。

7. n_max

读取的最大记录数

8. guess_max

推测 column 类型使用的最大行数。

9. progress

是否显示进度条。默认只在交互模式中显示。其进度显示每 50,000 个值更新一次，并且只在估计读取时间大于 5 秒才显示。

设置 `readr.show_progress=FALSE` 可以禁用进度条。

10. comment

用于标识注释的字符串。注释字符串后面的内容在解析时忽略。

11. skip_empty_rows

是否忽略空白行。如果设置为 `TRUE`，则不显示空白行；如果为 `FALSE`，则以 NA 表示空白内容。

