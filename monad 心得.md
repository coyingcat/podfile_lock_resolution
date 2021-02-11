m a,

即 Monadic a



<hr>


初始化函数：

```
func or(_ other: Parser<Result>) -> Parser<Result> {
    
    return Parser(parseX: {
        input in
        return self.parseX(input) ?? other.parseX(input)
    })
}

```


等价于


```


func or(_ other: Parser<Result>) -> Parser<Result> {
    
    return Parser {
        input in
        return self.parseX(input) ?? other.parseX(input)
    }
}

```
