---
x: C3
title: Try C3 in Y minutes
image: /try/cover.png
lastmod: 2025-12-27
original: https://learn-c3.org
license: MIT
contributors:
    - ["Book-reader", "https://github.com/Book-reader"]
    - ["Anton Zhiyanov", "https://antonz.org"]
---

[C3](https://odin-lang.org/) is a systems programming language that aims to be an evolution of C; enabling the same paradigms and syntax where possible, while adding more modern quality of life features.

```c3
import std::io;

fn void main()
{
	io::printfn("Hello, World!");
}
```

<codapi-snippet sandbox="c3" editor="basic" output>
</codapi-snippet>

```text
Hello, World!
```

The purpose of this tutorial is to get you started programming in C3 as soon as possible. Some familiarity with the C language is recommended, but general programming concepts will still be covered.

<div class="tryx__panel">
<p>✨ This is an open source guide adapted from the <a href="https://learn-c3.org">C3 Tutorial</a>. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/c3/index.md">improve it</a>!</p>
</div>

## Modules and imports

C3 groups functions, types, variables and macros into namespaces called modules.

When doing builds, any C3 file must start with the `module` keyword, specifying the module.

When compiling single files, the module is not needed and the module name is assumed to be the file name, converted to lower case, with any invalid characters replaced by underscore (`_`).

```c3
module example;

import std::io;
import libc;

fn void main()
{
	io::printfn("Our server's password: %d", libc::rand());
}
```

<codapi-snippet sandbox="c3" editor="basic" output>
</codapi-snippet>

```text
Our server's password: 1804289383
```

Modules are imported using the `import` statement. Imports always recursively import sub-modules.

## Constants

In C3, a constant is a compile-time value declared with the `const` keyword. The name of a constant can only contain uppercase letters, numbers, and underscores. Constants can be both explicitly typed and untyped when the type can be inferred.

```c3
import std::io;
import std::math;

const TWO = 2; // Untyped
const double HALF = 0.5; // Typed

fn void main()
{
	io::printfn("2*PI = %f", math::PI * TWO);
	io::printfn("PI/2 = %f", math::PI * HALF);
}
```

<codapi-snippet sandbox="c3" editor="basic" output>
</codapi-snippet>

```text
2*PI = 6.283185
PI/2 = 1.570796
```

Unlike in C, there is no way to create a runtime value that cannot be modified.

## Functions

Functions in C3 are declared the same way as in C with the addition of the `fn` keyword.

```c3
fn void test(int x)
{
	io::printfn("%d", x);
}

fn void main()
{
	test(100);
}
```

<codapi-snippet sandbox="c3" editor="basic" template="header.c3" output>
</codapi-snippet>

```text
100
```

## For loops

C3 `for` loops are the same as in C. A `for` loop is made of 3 sections that are enclosed in parentheses and separated by semicolons:

-   the init section, which is is run once when the loop is first started and usually used to declare the counter (eg `usz i = 0`).
-   the condition section, which is checked before the code in the loop body is executed each iteration of the loop. The loop will continue running until the condition is no longer true.
-   the next section, which is run each iteration after the code in the loop body runs, and is usually used to add to the counter.

Any of these sections can be empty, but the semicolons must always be included. If the condition is empty it will loop forever.

After the closing parenthesis there can either be a block or single line of code as the body. If a body is not needed a semicolon can be used instead.

```c3
const TIMES = 5;
for (usz i = 0; i < TIMES; i = i + 1)
{
    io::printfn("Iteration %s", i);
}
```

<codapi-snippet sandbox="c3" editor="basic" template="main.c3" output>
</codapi-snippet>

```text
Iteration 0
Iteration 1
Iteration 2
Iteration 3
Iteration 4
```

The `break` keyword can be used to exit out of a loop early, and the `continue` keyword will skip the rest of the code in the body and continue at the next iteration of the loop.

```c3
const TIMES = 10;
for (usz i = 0; i < TIMES; i++)
{
    if (i == 3)
    {
        io::printn("Continuing at 3");
        continue;
    }
    else if (i == 8)
    {
        io::printn("Breaking at 8");
        break;
    }
    io::printfn("Iteration %s", i);
}
```

<codapi-snippet sandbox="c3" editor="basic" template="main.c3" output>
</codapi-snippet>

```text
Iteration 0
Iteration 1
Iteration 2
Continuing at 3
Iteration 4
Iteration 5
Iteration 6
Iteration 7
Breaking at 8
```

Repeatedly doing `collection[index]` when iterating over a collection such as an array or hashmap with a `for` loop can become a bit cumbersome, this is where [`foreach`](#foreach) comes in.

## Foreach

Use `foreach` to iterate over any collection (array, subarray, vector or any customized type implementing the indexing operators).

```c3
// without foreach
int[3] items = {123, 456, 789};
for (usz i = 0; i < items.len; i++)
{
    items[i] += items[i];
}

// with foreach
foreach (&item : items)
{
    *item += *item;
}
```

<codapi-snippet sandbox="c3" editor="basic" template="main.c3" output>
</codapi-snippet>

```text
ok
```

Either iterate over the value: `foreach (v : values)` or over index + value: `foreach (index, v : values)`.

Values can also be retrieved by reference by using `&` in front of the variable name: `foreach (&v : values)`, this allows mutation of the element directly.

`foreach_r` conversely allows iteration from back and forward.

...to be continued

## Further reading

See the C3 [documentation](https://c3-lang.org/getting-started/) to learn more about the language.
