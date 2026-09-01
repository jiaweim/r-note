# 处理数据对象的常用函数

| 函数                         | 用途                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| `length(object)`             | 显示对象中元素/成分的数量                                    |
| `dim(object)`                | 显示某个对象的维度                                           |
| `str(object)`                | 显示某个对象的结构                                           |
| `class(object)`              | 显示某个对象的类或类型                                       |
| `mode(object)`               | 显示某个对象的模式                                           |
| `names(object)`              | 显示某对象中各成分的名称                                     |
| `c(object, object, ...)`     | 将对象合并入一个向量                                         |
| `cbind(object, object, ...)` | 按列合并对象                                                 |
| `rbind(object, object, ...)` | 按行合并对象                                                 |
| `object`                     | 输出某个对象                                                 |
| `head(object)`               | 列出某个对象的开始部分                                       |
| `tail(object)`               | 列出某个对象的最后部分                                       |
| `ls()`                       | 显示当前的对象列表                                           |
| `rm(object, object, ...)`    | 删除一个或更多个对象。语句 `rm(list = ls())` 将删除当前工作环境中的几乎所有对象 |
| `newobject <- edit(object)`  | 编辑对象并另存为 newobject                                   |
| `fix(object)`                | 直接编辑对象                                                 |