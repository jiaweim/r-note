# Text

@since 2026-09-21
@author Jiawei Mao
***

文本类几何图层（Text geoms）用于图表标注。它们既可以单独用来制作散点图，也能与其他图层结合使用，比如给数据点加标签，或在柱状图上方标注柱高。

- `geom_text()` 只添加纯文本；
- `geom_label()` 会在文本下绘制矩形背景框，让文字更清晰易读。

```R
geom_label(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "nudge",
  ...,
  parse = FALSE,
  label.padding = unit(0.25, "lines"),
  label.r = unit(0.15, "lines"),
  label.size = deprecated(),
  border.colour = NULL,
  border.color = NULL,
  text.colour = NULL,
  text.color = NULL,
  size.unit = "mm",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
```

```R
geom_text(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "nudge",
  ...,
  parse = FALSE,
  check_overlap = FALSE,
  size.unit = "mm",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
```

## 参数

**mapping**

由 `aes()` 创建的美学映射。若指定该参数且 `inherit.aes = TRUE`（默认值），它会与图表顶层的默认映射合并；若图表没有设置默认映射，则必须提供 `mapping`。

**data**

当前图层的数据。有三种执行方式：

- `NULL`（默认）：继承 `ggplot()` 中指定的图表数据。
- `data.frame`  或其他对象：覆盖原有图表数据，并转换为数据框（参见 [fortify()](https://ggplot2.tidyverse.org/reference/fortify.html)）。
- `function`：该函数会被调用，传入图表数据，返回值数据框用作图层数据，可用公式，如如 `~ head(.x, 10)`。

**stat**

统计变换。当使用 `geom_*()` 构建图层时，可通过 `stat` 参数覆盖 geoms 与 stat 之间的默认绑定。该参数接受以下类型：

- `Stat` 的 ggproto 子类，例如 `StatCount`。
- 命名 stat 的字符串形式，需去掉 `stat_` 前缀。如 `"count"` 对应 `stat_count()`。


更多信息请参阅 [layer_stat](https://ggplot2.tidyverse.org/reference/layer_stats.html) 文档。

**position**

用于调整该图层数据的位置，用于避免数据点重叠、改善显示效果。支持参数类型：

- 位置函数调用，如 `position_jitter()`。这种方法可以传递额外参数。
- 命名位置调整的字符串。以字符串形式提供时，需去掉 `position_` 前缀。例如，要使用 `position_jitter()`，请将 `position` 设为 `"jitter"`。 有关更多信息及其他指定方式，请参阅图层 position 文档。

- **...** 传递给 `layer()` 的 `params` 参数的其他参数。这些参数大致分为以下 4 类。需要注意的是，`position` 参数的额外参数或必需的美学映射不能通过 `...` 传递。不属于以下 4 类的未知参数将被忽略：
  1. **静态美学映射**：未映射到比例尺，而是固定值并应用于整个图层。例如 `colour = "red"` 或 `linewidth = 3`。几何图层的文档中有“美学 (Aesthetics)”一节列出了可用选项。“必需”的美学映射不能传递给 `params`。请注意，虽然技术上可以将未映射的美学映射作为向量传递，但其顺序和所需长度不保证与输入数据并行。
  2. **传递给 geom 的参数**：当使用 `stat_*()` 函数构建图层时，`...` 可用于向图层的 geom 部分传递参数。例如：`stat_density(geom = "area", outline.type = "both")`。geom 的文档列出了它可以接受的参数。
  3. **传递给 stat 的参数**：相反，当使用 `geom_*()` 函数构建图层时，`...` 可用于向图层的 stat 部分传递参数。例如：`geom_area(stat = "density", adjust = 0.5)`。stat 的文档列出了它可以接受的参数。
  4. **图例符号 (key_glyph)**：`layer()` 的 `key_glyph` 参数也可以通过 `...` 传递。这可以是文档中描述的 key glyphs 函数之一，用于更改图层在图例中的显示方式。
- **parse** 如果为 `TRUE`，标签将被解析为表达式，并按照 `?plotmath` 中的描述进行显示。
- **label.padding** 标签周围的填充量。默认值为 0.25 行高。
- **label.r** 圆角的半径。默认值为 0.15 行高。
- **label.size** [已弃用] 已被 `linewidth` 美学映射取代。标签边框的大小，单位为毫米 (mm)。
- **border.colour / border.color** 标签边框的颜色。当为 `NULL`（默认）时，`colour` 美学映射决定标签边框的颜色。`border.color` 是 `border.colour` 的别名。
- **text.colour / text.color** 文本的颜色。当为 `NULL`（默认）时，`colour` 美学映射决定文本的颜色。`text.color` 是 `text.colour` 的别名。
- **size.unit** `size` 美学映射的解释方式：毫米 (`"mm"`，默认)、磅 (`"pt"`)、厘米 (`"cm"`)、英寸 (`"in"`) 或 派卡 (`"pc"`)。
- **na.rm** 如果为 `FALSE`（默认），缺失值将被移除并给出警告。如果为 `TRUE`，缺失值将被静默移除。
- **show.legend** 逻辑值。该图层是否应包含在图例中？
  - `NA`（默认）：如果有任何美学映射，则包含。
  - `FALSE`：永远不包含。
  - `TRUE`：始终包含。 它也可以是一个命名逻辑向量，以精细选择要显示的美学映射。若要包含所有层级的图例键（即使没有数据），请使用 `TRUE`。如果为 `NA`，则所有层级都会显示在图例中，但会省略未观察到的层级。
- **inherit.aes** 如果为 `FALSE`，将覆盖默认的美学映射，而不是与它们合并。这对于同时定义数据和美学映射的辅助函数最有用，这些函数不应继承默认图表规范的行为，例如 `annotation_borders()`。
- **check_overlap** 如果为 `TRUE`，与同一图层中先前文本重叠的文本将不会被绘制。`check_overlap` 在绘制时发生，且按数据的顺序进行。因此，在调用 `geom_text()` 之前，数据应按标签列进行排序。请注意，`geom_label()` 不支持此参数。

## 参考

- https://ggplot2.tidyverse.org/reference/geom_text.html