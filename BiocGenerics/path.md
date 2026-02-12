# path

2024-06-06
@author Jiawei Mao
***

path 用于访问对象路径。

```R
path(object, ...)
path(object, ...) <- value

basename(path, ...)
basename(path, ...) <- value

dirname(path, ...)
dirname(path, ...) <- value

## The purpose of the following methods is to make the basename() and
## dirname() getters work out-of-the-box on any object for which the
## path() getter works.

## S4 method for signature 'ANY'
basename(path, ...)

## S4 method for signature 'ANY'
dirname(path, ...)

## The purpose of the following replacement methods is to make the
## basename() and dirname() setters work out-of-the-box on any object
## for which the path() getter and setter work.

## S4 replacement method for signature 'character'
basename(path, ...) <- value

## S4 replacement method for signature 'ANY'
basename(path, ...) <- value

## S4 replacement method for signature 'character'
dirname(path, ...) <- value

## S4 replacement method for signature 'ANY'
dirname(path, ...) <- value
```

`object` ：包含路径的对象，虽然它通常只包含一条路径，但实际上可以包含任何数量的路径。

`...`：其它参数，特定方法中使用。

`value`：

- 对 `path`，为 `object` 设置的路径
- 对 `basename` 或 `dirname`，返回路径的 basenames 或 dirnames

`path`：包含路径的字符向量或对象。

