# tibble::as_tibble



**将列表、矩阵等对象强制转换为数据框**

- `as_tibble()` 将现有对象（如数据框或矩阵）转换为 `tibble`（`tbl_df` 类数据框）；
- `tibble()` 从单独的列构建 `tibble`

`as_tibble()` 之于 `tibble()`，类似 `base::as.data.frame()` 之于 `base::data.frame()`。

`as_tibble()` 是 S3 泛型函数，支持：

- `data.frame`：对 list 方法的轻量封装，并实现 `tibble` 对行名（`rownames`）的处理。
- `matrix`, `poly`, `ts`, `table`
- **默认方法**：其他输入先通过 `base::as.data.frame()` 强制转换。

`as_tibble_row()` 将向量转为单行 `tibble`；如果输入为列表，则所有元素长度必须为 1；`as_tibble_col()` 将向量转换为单列 `tibble`。

## 用法

```R
as_tibble(
  x,
  ...,
  .rows = NULL,
  .name_repair = c("check_unique", "unique", "universal", "minimal", "unique_quiet",
    "universal_quiet"),
  rownames = pkgconfig::get_config("tibble::rownames", NULL)
)
```

```R
## S3 method for class 'data.frame'
as_tibble(
  x,
  validate = NULL,
  ...,
  .rows = NULL,
  .name_repair = c("check_unique", "unique", "universal", "minimal", "unique_quiet",
    "universal_quiet"),
  rownames = pkgconfig::get_config("tibble::rownames", NULL)
)
```

```R
## S3 method for class 'list'
as_tibble(
  x,
  validate = NULL,
  ...,
  .rows = NULL,
  .name_repair = c("check_unique", "unique", "universal", "minimal", "unique_quiet",
    "universal_quiet")
)
```

```R
## S3 method for class 'matrix'
as_tibble(x, ..., validate = NULL, .name_repair = NULL)
```

```R
## S3 method for class 'table'
as_tibble(x, `_n` = "n", ..., n = `_n`, .name_repair = "check_unique")
```

```R
## S3 method for class ''NULL''
as_tibble(x, ...)
```

```r
## Default S3 method:
as_tibble(x, ...)
```

```R
as_tibble_row(
  x,
  .name_repair = c("check_unique", "unique", "universal", "minimal", "unique_quiet",
    "universal_quiet")
)

as_tibble_col(x, column_name = "value")
```

#### 参数

- **x**：数据框、列表、矩阵或其他可合理强制转换为 tibble 的对象。
- **...**：未使用，仅用于扩展性。
- **.rows**：行数，用于创建 0 列的 tibble，或作为额外的检查。
- **.name_repair**：对问题列名的处理方式：
  - `"minimal"`：除了基本存在性检查外，不进行名称修复或检查。
  - `"unique"`：确保名称唯一且不为空。
  - `"check_unique"`：（默认值）不进行名称修复，但检查其是否唯一。
  - `"universal"`：使名称唯一且符合语法规范。
  - `"unique_quiet"`：与 `"unique"` 相同，但不输出提示信息。
  - `"universal_quiet"`：与 `"universal"` 相同，但不输出提示信息。
  - **函数**：应用自定义名称修复（例如 `.name_repair = make.names` 以使用基础 R 风格的名称）。
  - **purrr 风格的匿名函数**：参见 `rlang::as_function()`。 此参数作为 `repair` 传递给 `vctrs::vec_as_names()`。有关这些术语及强制执行策略的更多详细信息，请参阅该函数文档。
- **rownames**：如何处理数据框或矩阵现有的行名：
  - `NULL`：删除行名。这是默认设置。
  - `NA`：保留行名。
  - **字符串**：新列的名称。现有的行名将被转移到该列中，并且 `row.names` 属性将被删除。即使 `x` 已包含同名列，也不会对新列名应用名称修复。请使用 `as_tibble(rownames_to_column(...))` 来防止发生这种情况。 更多信息请参见“Row names（行名）”章节。
- **_n, validate**：[已软弃用] 仅为兼容性保留，请勿在新代码中使用。
- **n**：计数列的名称，默认为 `"n"`。
- **column_name**：列的名称。

#### 行名 (Row names)

默认行为是静默删除行名。 新代码应使用 `rownames` 参数显式将行名转换为新列。 对于依赖保留行名的现有代码，请在脚本或包的 `.onLoad()` 函数中调用 `pkgconfig::set_config("tibble::rownames" = NA)`。

#### 生命周期

从 3.0.0 版本开始，对向量使用 `as_tibble()` 已被取代，新代码更推荐使用表达力更强的 `as_tibble_row()` 和 `as_tibble_col()` 变体。

#### 参见

`tibble()` 从单独的列构建 tibble。`enframe()` 将命名向量转换为包含名称列和值列的 tibble。名称修复使用 `vctrs::vec_as_names()` 实现。

#### 示例

*(运行示例)*

```r
m <- matrix(rnorm(50), ncol = 5)
colnames(m) <- c("a", "b", "c", "d", "e")
df <- as_tibble(m)

as_tibble_row(c(a = 1, b = 2))
as_tibble_row(list(c = "three", d = list(4:5)))
as_tibble_row(1:3, .name_repair = "unique")

as_tibble_col(1:3)
as_tibble_col(
  list(c = "three", d = list(4:5)),
  column_name = "data"
)
```

[Package tibble version 3.3.1 Index]