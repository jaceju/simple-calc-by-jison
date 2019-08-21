// 從 `%lex` 開始宣告每個 token 如何組成
// `%%` 是用來分段的， jison
/* lexical grammar */
%lex
%%

\s+         // 不 return 的話就是略過，這邊就是略過空白字元 (空格、換行等)
[0-9]+      return 'NUMBER' // 這裡 return 的 token 名稱就會被用在下面語法的表示上
"+"         return '+' // 這裡如果回傳符號，在底下的語法部份就要用字串形式
"-"         return '-'
"*"         return '*'
"/"         return '/'
"("         return '('
")"         return ')'
<<EOF>>     return 'EOF' // 檔案的結尾
.           return 'INVALID' // 其它符號都視為不合法

/lex // 表示結束 token 的定義

// `%start` 表示語法的起始
%start S
// 一個正確的語法從 S (statement) 開始， S 只是一個名稱，可以隨意命名，不要有跟 token 名稱衝突即可

%% /* language grammar */

/*
// 這邊是四則運算的公式 EBNF 形式

E ::= T (('+' | '-') T)*
T ::= F (('*' | '/') F)*
F ::= NUMBER | '(' E ')'

// E 為 expression ，加減運算；
// T 為 term ，乘除運算；
// F 為 factor ，可以是數字，也可以是用小括號包起來的 expression 。
*/

S: // 一個 S 是
    E EOF // 以 E (expression) 和 EOF 組成
    // `{ ... }` 裡面是符合這個組成時要執行的目標碼
    // $1 是第一個符合的 token ，以此類推
    // 這裡的 `return` 會把最終結果回傳給呼叫的程式
    {
        // console.log($1); // 這行用來做 debug
        return $1;
    }
    ; // 一組定義要用分號結尾

E: // 一個 E 可以是
    T '+' T // term 加 term
    {
        $$ = $1 + $3;
    }
    // $$ 就是指向 E ，會把目標碼的執行結果存起來
    // 注意這裡的 `$$ =` 不能寫成 `return`
    |
    // 這裡的 | 就是「或」的意思
    T '-' T // term 減 term
    {
        $$ = $1 - $3;
    }
    |
    T // 只有 term
    {
        $$ = $1;
    }
    ;
// E:
//     T (('+' | '-') T)* { console.log($1, $2, $3); };

T:
    F '*' F { $$ = $1 * $3; } // 可以寫在一行
    |
    F '/' F { $$ = $1 / $3; }
    |
    F { $$ = $1; }
    ;
// T:
//     F (('*' | '/') F)* { console.log($1, $2, $3); };

F:
    NUMBER { $$ = Number(yytext) } // 由於這裡只有一個 match 的值，所以 `$1` 可以用  `yytext` 取代
    |
    '(' E ')' { $$ = $2; }
    ;
    // NUMBER { $$ = Number($1) } | '(' S ')' { $$ = $2 }; // 也可以這樣寫，但不好讀
