---
x: Expr
title: Try Expr in Y minutes
image: /try/cover.png
lastmod: 2023-12-27
license: MIT
contributors:
    - ["Anton Medvedev", "https://medv.io"]
---

[Expr](https://expr-lang.org/) is a simple, fast and extensible expression language for Go. It is
designed to be easy to use and integrate into your Go application. Let's delve
deeper into its core features:

-   **Memory safe** - Designed to prevent vulnerabilities like buffer overflows and memory leaks.
-   **Type safe** - Enforces strict type rules, aligning with Go's type system.
-   **Terminating** - Ensures every expression evaluation cannot loop indefinitely.
-   **Side effects free** - Evaluations won't modify global states or variables.

Let's start with a simple example:

<script id="main.tpl" type="text/plain">
package main

import (
    "fmt"
    "time"

    "github.com/expr-lang/expr"
)

var _ = fmt.Print
var _ = time.Now

func main() {
    ##CODE##
}
</script>

<script id="imports.tpl" type="text/plain">
package main

import (
    "fmt"
    "time"

    "github.com/expr-lang/expr"
)

var _ = fmt.Print
var _ = time.Now

##CODE##
</script>

```go
program, err := expr.Compile(`2 + 2`)
if err != nil {
    panic(err)
}

output, err := expr.Run(program, nil)
if err != nil {
    panic(err)
}

fmt.Print(output) // 4
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#main.tpl">
</codapi-snippet>

Expr compiles the expression `2 + 2` into a bytecode program. Then we run
the program and get the output. The output is `4` as expected.

The `expr.Compile` function returns a `*vm.Program` and an error. The program
can be reused between runs. The `expr.Run` function takes a program and an
environment. The environment is a map of variables that can be used in the
expression. In this example, we use `nil` as an environment because we don't
need any variables.

Now let's pass some variables to the expression:

```go
env := map[string]any{
    "foo": 100,
    "bar": 200,
}

program, err := expr.Compile(`foo + bar`, expr.Env(env))
if err != nil {
    panic(err)
}

output, err := expr.Run(program, env)
if err != nil {
    panic(err)
}

fmt.Print(output) // 300
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#main.tpl">
</codapi-snippet>

Why do we need to pass the environment to the `expr.Compile` function? Expr can be used as a type-safe language.
Expr can infer the type of the expression and check it against the environment. Here is an example:

```go
env := map[string]any{
    "name": "Anton",
    "age": 35,
}

_, err := expr.Compile(`name + age`, expr.Env(env))
if err != nil {
    panic(err) // Will panic with "invalid operation: string + int"
}
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#main.tpl">
</codapi-snippet>

Expr can work with any Go types. Here is an example:

```go
env := map[string]any{
    "greet":   "Hello, %v!",
    "names":   []string{"world", "you"},
    "sprintf": fmt.Sprintf,
}

code := `sprintf(greet, names[0])`

program, err := expr.Compile(code, expr.Env(env))
if err != nil {
    panic(err)
}

output, err := expr.Run(program, env)
if err != nil {
    panic(err)
}

fmt.Print(output) // Hello, world!
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#main.tpl">
</codapi-snippet>

Also, Expr can use a struct as an environment. Methods defined on the struct become functions.
The struct fields can be renamed with the `expr` tag. Here is an example:

```go
type Env struct {
    Posts []Post `expr:"posts"`
}

func (Env) Format(t time.Time) string {
    return t.Format(time.RFC822)
}

type Post struct {
    Body string
    Date time.Time
}

func main() {
    code := `map(posts, Format(.Date) + ": " + .Body)`

    program, err := expr.Compile(code, expr.Env(Env{}))
    if err != nil {
        panic(err)
    }

    env := Env{
        Posts: []Post{
            {"Oh My God!", time.Now()},
            {"How you doin?", time.Now()},
            {"Could I be wearing any more clothes?", time.Now()},
        },
    }

    output, err := expr.Run(program, env)
    if err != nil {
        panic(err)
    }

    fmt.Print(output)
}
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#imports.tpl">
</codapi-snippet>

The compiled program can be reused between runs. Here is an example:

```go
type Env struct {
    X int
    Y int
}

program, err := expr.Compile(`X + Y`, expr.Env(Env{}))
if err != nil {
    panic(err)
}

output, err := expr.Run(program, Env{1, 2})
if err != nil {
    panic(err)
}

fmt.Print(output) // 3

output, err = expr.Run(program, Env{3, 4})
if err != nil {
    panic(err)
}

fmt.Print(output) // 7
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#main.tpl">
</codapi-snippet>

**Tip**. For one-off expressions, you can use the `expr.Eval` function. It compiles and runs the expression in one step.

```go
output, err := expr.Eval(`2 + 2`, nil)

if err != nil {
    panic(err)
}
fmt.Print(output)
```

<codapi-snippet sandbox="expr-lang" editor="basic" template="#main.tpl">
</codapi-snippet>
