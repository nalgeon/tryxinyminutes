---
title: "Expr: Language Definition"
image: /try/cover.png
lastmod: 2023-12-27
license: MIT
contributors:
    - ["Anton Medvedev", "https://medv.io"]
---

[Expr](https://expr-lang.org/) is a simple expression language that can be used to evaluate expressions.

## Literals

<table>
    <tr>
        <td><strong>Comment</strong></td>
        <td>
             <code>/* */</code> or <code>//</code>
        </td>
    </tr>
    <tr>
        <td><strong>Boolean</strong></td>
        <td>
            <code>true</code>, <code>false</code>
        </td>
    </tr>
    <tr>
        <td><strong>Integer</strong></td>
        <td>
            <code>42</code>, <code>0x2A</code>, <code>0o52</code>, <code>0b101010</code>
        </td>
    </tr>
    <tr>
        <td><strong>Float</strong></td>
        <td>
            <code>0.5</code>, <code>.5</code>
        </td>
    </tr>
    <tr>
        <td><strong>String</strong></td>
        <td>
            <code>"foo"</code>, <code>'bar'</code>
        </td>
    </tr>
    <tr>
        <td><strong>Array</strong></td>
        <td>
            <code>[1, 2, 3]</code>
        </td>
    </tr>
    <tr>
        <td><strong>Map</strong></td>
        <td>
            <code>&#123;a: 1, b: 2, c: 3&#125;</code>
        </td>
    </tr>
    <tr>
        <td><strong>Nil</strong></td>
        <td>
            <code>nil</code>
        </td>
    </tr>
</table>

<script id="eval.tpl" type="text/plain">
package main

import (
	"fmt"
    "time"

	"github.com/expr-lang/expr"
)

var _ = fmt.Print
var _ = time.Now

type User struct {
    Id int
    Name string
    Group string
}

func main() {
	env := map[string]any{
        "user": User{11, "Alice", "admin"},
        "array": []string{"one", "two", "three"},
    }

	code := `##CODE##`

	program, err := expr.Compile(code, expr.Env(env))
	if err != nil {
		panic(err)
	}

	output, err := expr.Run(program, env)
	if err != nil {
		panic(err)
	}

	fmt.Println(output)
}
</script>

### Strings

Strings can be enclosed in single quotes or double quotes. Strings can contain escape sequences, like `\n` for newline,
`\t` for tab, `\uXXXX` for Unicode code points.

```expr
"Hello\nWorld"
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#eval.tpl">
</codapi-snippet>

For multiline strings, use backticks:

```expr
`Hello
World`
```

Backticks strings are raw strings, they do not support escape sequences.

## Operators

<table>
    <tr>
        <td><strong>Arithmetic</strong></td>
        <td>
            <code>+</code>, <code>-</code>, <code>*</code>, <code>/</code>, <code>%</code> (modulus), <code>^</code> or <code>**</code> (exponent)
        </td>
    </tr>
    <tr>
        <td><strong>Comparison</strong></td>
        <td>
            <code>==</code>, <code>!=</code>, <code>&lt;</code>, <code>&gt;</code>, <code>&lt;=</code>, <code>&gt;=</code>
        </td>
    </tr>
    <tr>
        <td><strong>Logical</strong></td>
        <td>
            <code>not</code> or <code>!</code>, <code>and</code> or <code>&amp;&amp;</code>, <code>or</code> or <code>||</code>
        </td>
    </tr>
    <tr>
        <td><strong>Conditional</strong></td>
        <td>
            <code>?:</code> (ternary), <code>??</code> (nil coalescing)
        </td>
    </tr>
    <tr>
        <td><strong>Membership</strong></td>
        <td>
            <code>[]</code>, <code>.</code>, <code>?.</code>, <code>in</code>
        </td>
    </tr>
    <tr>
        <td><strong>String</strong></td>
        <td>
            <code>+</code> (concatenation), <code>contains</code>, <code>startsWith</code>, <code>endsWith</code>
        </td>
    </tr>
    <tr>
        <td><strong>Regex</strong></td>
        <td>
            <code>matches</code>
        </td>
    </tr>
    <tr>
        <td><strong>Range</strong></td>
        <td>
            <code>..</code>
        </td>
    </tr>
    <tr>
        <td><strong>Slice</strong></td>
        <td>
            <code>[:]</code>
        </td>
    </tr>
    <tr>
        <td><strong>Pipe</strong></td>
        <td>
            <code>|</code>
        </td>
    </tr>
</table>

### Membership Operator

Fields of structs and items of maps can be accessed with `.` operator
or `[]` operator. Next two expressions are equivalent:

```expr
user.Name
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#eval.tpl">
</codapi-snippet>

```
user["Name"]
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#eval.tpl">
</codapi-snippet>

Elements of arrays and slices can be accessed with
`[]` operator. Negative indices are supported with `-1` being
the last element.

```expr
array[0] // first element
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#eval.tpl">
</codapi-snippet>

```expr
array[-1] // last element
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#eval.tpl">
</codapi-snippet>

The `in` operator can be used to check if an item is in an array or a map.

```expr
"John" in ["John", "Jane"]
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#eval.tpl">
</codapi-snippet>

```expr
"name" in {"name": "John", "age": 30}
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#eval.tpl">
</codapi-snippet>

And so on...

_Expr is copyrighted by [Anton Medvedev](https://medv.io/) and licensed under the MIT License._
