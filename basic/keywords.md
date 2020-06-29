# R Keywords

## library & require

`require` 在函数内使用，如果没有发现对应包，输出警告信息，程序继续运行。

`require` 返回一个 boolean 值，如果载入包成功，返回 TRUE。如果不需要使用其返回值，应当尽量避免使用 `require`。

`library` 如果没有发现对应包，抛出错误。
