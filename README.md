# 用 Jison 實作一個四則計算語言

主要是學習用 Jison 這個工具來實作一個四則計算語言。

## 規則

1. 僅能對正整數做四則運算
2. 可以用小括號
3. 空白、換行會被忽略

## EBNF 形式

```ebnf
E ::= T (('+' | '-') T)*
T ::= F (('*' | '/') F)*
F ::= NUMBER | '(' E ')'
```

* `E` 為 expression ，加減運算；
* `T` 為 term ，乘除運算；
* `F` 為 factor ，可以是數字，也可以是用小括號包起來的 expression 。

註：可以在 [Railroad Diagram Generator](https://bottlecaps.de/rr/ui) 把上面的 EBNF 貼上去查看語法圖。

## 測試

```bash
$ jison calc.jison
$ node example.js
```

## 參考

* [Jison - Documentation](http://zaa.ch/jison/docs/)
* [工程中的編譯原理 -- Jison入門篇](http://icodeit.org/2015/09/write-a-parser/)
