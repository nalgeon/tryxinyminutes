---
x: Odin
title: Try Odin in Y minutes
image: /try/cover.png
lastmod: 2023-07-31
canonical: https://antonz.org/trying-odin/
original: https://antonz.org/trying-odin/
license: CC-BY-SA-4.0
contributors:
    - ["Anton Zhiyanov", "https://antonz.org"]
---

[Odin](https://odin-lang.org/) is a general-purpose programming language with distinct typing, designed for high performance, modern systems, and data-oriented programming. Some people refer to Odin as "better C".

Odin has a unique set of characteristics:

-   Simple language design without bells and whistles.
-   Manual memory management with custom allocators.
-   Well-thought standard library.
-   Concise and calm syntax.

## Some examples

A classic "hello world":

```odin
package main

import "core:fmt"

main :: proc() {
    fmt.println("Hellope!")
    // Hellope!
}
```

<codapi-snippet sandbox="odin" editor="basic">
</codapi-snippet>

**Dynamic arrays** and sorting:

```
package main

import "core:fmt"
import "core:slice"

main :: proc() {
    list := [dynamic]int{11, 7, 42}
    defer delete(list)

    append(&list, 2, 54)
    slice.sort(list[:])

    fmt.println(list)
    // [2, 7, 11, 42, 54]
}
```

<codapi-snippet sandbox="odin" editor="basic">
</codapi-snippet>

**Memory management** in Odin is manual, so allocated memory must be explicitly freed. There are two built-in allocators (a heap allocator and a growing arena based allocator), but the language supports custom allocators:

```odin
// tracking allocator for debugging
track: mem.Tracking_Allocator
mem.tracking_allocator_init(&track, context.allocator)

// context is an implicit variable
// available in every scope
context.allocator = mem.tracking_allocator(&track)

// we can use a custom allocator at any level,
// even at individual statements
list := make([]int, 6, context.allocator)
```

**Structs**, procedures and iteration (I'll skip the "package" stuff from now on):

```
Person :: struct {
    name: string,
    age: int,
}

person_to_str :: proc(p: Person) -> string {
    return fmt.tprintf("%v - %v", p.name, p.age)
}

people := []Person{
    Person{"Alice", 25},
    Person{"Bob", 24},
    Person{"Cindy", 26},
}

for p, idx in people {
    fmt.println(idx, person_to_str(p))
}
// 0 Alice - 25
// 1 Bob - 24
// 2 Cindy - 26
```

<codapi-snippet sandbox="odin" editor="basic" template="main.odin">
</codapi-snippet>

There are no functions or struct methods, only procedures.

**Pointers** are declared with a leading caret, and dereferenced with a trailing caret:

```odin
val := "Hellope!"

ptr: ^string
ptr = &val

fmt.println(ptr^)
// Hellope!
```

<codapi-snippet sandbox="odin" editor="basic" template="main.odin">
</codapi-snippet>

A bit unusual, but logical.

**Errors** are just values:

```odin
Error :: enum {
    None,
    Insufficient_Funds,
}

withdraw :: proc(balance, amount: int) -> (int, Error) {
    if amount > balance {
        return balance, .Insufficient_Funds
    }
    return balance - amount, .None
}

balance, err := withdraw(42, 1000)
if err != nil {
    fmt.println(err)
}
// Insufficient_Funds
```

<codapi-snippet sandbox="odin" editor="basic" template="main.odin">
</codapi-snippet>

There is also a shortcut for the dreaded `if err != nil return`:

```odin
balance := withdraw(42, 1000) or_return
```

**Generics** (aka parametric polymorphism):

```odin
Pair :: struct($T: typeid) {
    first: T,
    second: T
}

pair_to_str :: proc(p: $T/Pair) -> string {
    return fmt.tprintf("%v-%v", p.first, p.second)
}

p1 := Pair(int){1, 2}
p2 := Pair(string){"one", "two"}

fmt.println(pair_to_str(p1))
// 1-2

fmt.println(pair_to_str(p2))
// one-two
```

<codapi-snippet sandbox="odin" editor="basic" template="main.odin">
</codapi-snippet>

Here `pair_to_str` only allows types that are specializations of the `Pair` type.

[Language overview](https://odin-lang.org/docs/overview/)

## Specialization

Although Odin is a general-purpose language, it leans slightly towards game and visual effects programming. This is probably due to the fact that the language creator ([Ginger Bill](https://www.gingerbill.org/)) is a physicist working in a visual effects company.

Odin supports a native `matrix` type and matrix operations, and has various SIMD/SIMT-related programming features (of which I don't know anything about, so better consult the doc for those).

As far as I can tell, a significant number of programmers using Odin are game developers.

## Current status

Odin is pre-1.0 and it does not have a 1.0 roadmap. However, Odin is actively used in production by the company it's creator works for.
