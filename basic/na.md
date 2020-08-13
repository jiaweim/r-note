# NA 值

## 简介

下面介绍处理缺失值（NA）的各种函数。

- `na.fail`，如果对象不包含缺失值，返回该对象，否则返回错误。
- `na.omit`，去除包含缺失值的数据，返回包含余下实例的对象。
- `na.pass`，不作修改原样返回数据。

```r
na.fail(object, ...)
na.omit(object, ...)
na.exclude(object, ...)
na.pass(object, ...)
```

