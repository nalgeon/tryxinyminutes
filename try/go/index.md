---
x: Go
title: Try Go in Y minutes
image: /try/go/cover.png
lastmod: 2024-08-16
original: https://learnxinyminutes.com/docs/go/
license: CC-BY-SA 3.0
contributors:
    - ["Sonia Keys", "https://github.com/soniakeys"]
    - ["Christopher Bess", "https://github.com/cbess"]
    - ["Jesse Johnson", "https://github.com/holocronweaver"]
    - ["Quint Guvernator", "https://github.com/qguv"]
    - ["Jose Donizetti", "https://github.com/josedonizetti"]
    - ["Alexej Friesen", "https://github.com/heyalexej"]
    - ["Clayton Walker", "https://github.com/cwalk"]
    - ["Leonid Shevtsov", "https://github.com/leonid-shevtsov"]
    - ["Michael Graf", "https://github.com/maerf0x0"]
    - ["John Arundel", "https://github.com/bitfield"]
    - ["Christoph Berger", "https://github.com/christophberger"]
---

Go was created out of the need to get work done. It's not the latest trend in programming language theory, but it is a way to solve real-world problems.

Go draws concepts from imperative languages with static typing. It's fast to compile and fast to execute, it adds easy-to-understand concurrency because multicore CPUs are now common, and it's used successfully in large codebases.

Go comes with a rich standard library and a large, thriving community.

<div class="tryx__panel">
<p>✨ This is an open source guide. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/go/index.md">improve it</a>!</p>
<p>The guide is based on <a href="https://learnxinyminutes.com/docs/go/">Learn Go in Y Minutes</a>, with only a few changes required by the separation of the code into snippets that can execute independently. Big shoutout to the authors!</p>
</div>

[Comments](#comments-and-build-tags) ·
[Packages and imports](#packages-and-imports) ·
[Functions](#functions) ·
[Variables](#variables) ·
[Types and literals](#built-in-types-and-literals) ·
[Maps](#maps) ·
[Unused variables](#unused-variables) ·
[Named return values](#named-return-values) ·
[Memory management](#memory-management) ·
[Flow control](#flow-control) ·
[Function literals](#function-literals) ·
[Defer](#defer) ·
[Basic Interfaces](#basic-interfaces) ·
[Type parameters](#type-parameters) ·
[Variadic parameters](#variadic-parameters) ·
[Error handling](#error-handling) ·
[Comma,ok idiom](#commaok-idiom) ·
[Concurrency](#concurrency) ·
[Web programming](#web-programming) ·
[Further Reading](#further-reading)

## Comments and build tags

Go has single- and multiline comments. Multiline comments cannot be nested.

```go
// Single line comment
/* Multi-
 line comment */
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_plain_main.go">
</codapi-snippet>

A build tag is a line comment starting with `//go:build` and can be executed by `go build -tags="foo bar"` command. Build tags are placed before the package clause near or at the top of the file followed by a blank line or other line comments.

```go
//go:build prod || dev || test
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_build_tag.go">
</codapi-snippet>

## Packages and imports

A `package` clause starts every source file. `main` is a special name declaring an executable rather than a library.

`import` declaration declares library packages referenced in this file. Imported packages must be used. (The Go Language Server `gopls` can take care of removing unused imports automatically.)

```go
package main

import (
	"fmt"              // A package in the Go standard library.
	"io"               // Implements some I/O utility functions.
	m "math"           // Math library with local alias m.
	"net/http"         // Yes, a web server!
	_ "net/http/pprof" // Profiling library imported only for side effects
	"os"               // OS functions like working with the file system
	"strconv"          // String conversions.
)

// Running this code snippet is expected to fail,
// because the imported packages are not used.
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_noop_main_for_package_decl.go">
</codapi-snippet>

## Functions

Functions are defined using the `func` keyword. Go uses curly braces for defining scopes like a function body. The opening brace of a function must appear on the same line as the function signature. Go does not require semicolons to end a statement.

The name `main` is special. It is the entry point for the executable program.

```go
func main() {
	// Println outputs a line to stdout.
	// It comes from the package fmt.
	fmt.Println("Hello world!")

	// Call another function within package main.
	beyondHello()
}

func beyondHello() {
	fmt.Println("Hello main!")
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

> **NOTE:** For brevity, many of the following code snippets hide the package declaration, imports, and the `main()` function.
>
> If a code snippet contains only statements and no function definitions, assume these statements exist in a context similar to this:
>
>     package main
>
>     import (
>         // used packages imported here
>     )
>
>     func main() {
>          // statements visible in a code snippet typically live here
>     }

Functions have parameters in parentheses. If there are no parameters, empty parentheses are still required.

```go
func noparams() {
	fmt.Println("Look ma! No parameters!")
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_func_noparams.go">
</codapi-snippet>

## Variables

Variables must be declared before use. The variable name _precedes_ the type name; this is quite the opposite of what C does. See [here](https://appliedgo.com/blog/go-declaration-syntax) for an explanation.

A variable assignment uses a single equal sign (`=`).

Use a "short declaration" to declare and assign in one statement. Go infers the type from the value assigned.

```go
var x int    // Variable declaration.
x = 3        // Variable assignment.
y := 4+3i    // "Short" declaration
fmt.Println("x:", x, ", y:", y)
fmt.Printf("Type of y: %T\n", y)
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

Functions can have parameters and (multiple!) return values.

```go
func learnMultiple(x, y int) (sum, prod int) {
	return x + y, x * y // Return two values.
}

func main() {
	a, b := learnMultiple(3,4)
	fmt.Println(a, b)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

Here `x`, `y` are the arguments and `sum`, `prod` are the return values. You could write `func learnMultiple(x, y int) (int, int)` as well, but named return parameters make the function signature clearer.

Variables `a` and `b` receive the type `int` through type inference.

## Built-in types and literals

### Simple types

Go supports strings, signed and unsigned integers of various sizes, floating point numbers, bytes, booleans, and more.

```go
str := "Learn Go!" // string type.

s2 := `A "raw" string literal
can include line breaks.` // Same string type.

// Non-ASCII literal. Go source is UTF-8.
g := 'Σ' // rune type, an alias for int32, holds a unicode code point.

f := 3.14159 // float64, an IEEE-754 64-bit floating point number.
c := 3 + 4i  // complex128, represented internally with two float64's.

// var syntax with initializers.
var u uint = 7 // Unsigned, but implementation dependent size as with int.
var pi float32 = 22. / 7

// Conversion syntax with a short declaration.
n := byte('\n') // byte is an alias for uint8.

fmt.Printf("str: %s\ns2: %s\ng: %s\nf: %f\nc: %f\nu: %d\npi: %f\nn: %v\n",
	str, s2, g, f, c, u, pi, n)
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

### Pointers

A pointer represents the address of a variable in memory.

Pointers are bound to their base type. For example, a pointer to an integer variable cannot be changed to point to a boolean variable.

Pointers are created by taking the address of a variable (`&a`) or by the `new()` function (discussed later).

```go
a, b := 1024, 2048
p, q := &a, &b      // Declares p, q to be type pointer to int.
fmt.Println(p, q)   // This prints the addresses of p and q.
fmt.Println(*p, *q) // * follows (or dereferences) a pointer.
                    // This prints two ints.
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

### Arrays

Arrays are static; that is, they have a fixed size at compile time.

```go
var a4 [4]int // An array of 4 ints, initialized to all 0.
a5 := [...]int{3, 1, 5, 10, 100} // An array initialized from an array literal.
// The ellipsis says that the size is determined from the literal.
fmt.Printf("a4: %v\na5: %v\n", a4, a5)
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

Arrays have value semantics.

```go
var a4 [4]int   // An array of 4 ints, initialized to all 0.
a4_cpy := a4    // a4_cpy is a copy of a4, two separate instances.
a4_cpy[0] = 25  // Only a4_cpy is changed, a4 stays the same.
fmt.Println(a4_cpy[0] == a4[0]) // false
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

### Slices

Slices have dynamic size. Arrays and slices each have advantages, but use cases for slices are much more common.

```go
s3 := []int{4, 5, 9}    // Compare to a5. No ellipsis used here.
s4 := make([]int, 4)    // Allocates slice of 4 ints, initialized to all 0.
var d2 [][]float64      // Declaration only, nothing allocated here.
bs := []byte("a slice") // Type conversion syntax.
fmt.Printf("s3: %v\ns4: %v\nd2: %v\nbs: %v\n", s3, s4, d2, bs)
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

Slices (as well as maps and channels) have reference semantics.

```go
s3 := []int{4, 5, 9}
s3_cpy := s3    // Both variables point to the same instance.
s3_cpy[0] = 0   // Which means both are updated.
fmt.Println(s3_cpy[0] == s3[0]) // true
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

Because slices are dynamic, you can append more elements to them. To append elements to a slice, the built-in `append()` function is used. `append()` takes a variable number of arguments. The first argument is a slice, to which `append()` adds the subsequent arguments and returns the updated slice.

```go
s := []int{1, 2, 3}		// Result is a slice of length 3.
fmt.Println(s)
s = append(s, 4, 5, 6)	// Added 3 elements. Slice now has length of 6.
fmt.Println(s)          // Updated slice is now [1 2 3 4 5 6]
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

`append` only adds atomic elements to a slice. To append another slice, pass a slice and add a trailing ellipsis. The ellipsis tells the compiler to unpack the slice into individual elements, making them consumable for `append`. (This is called "parameter expansion".)

```go
s := []int{1, 2, 3, 4, 5, 6}
s = append(s, []int{7, 8, 9}...) // The ellipsis unpacks the slice
fmt.Println(s) // Updated slice is now [1 2 3 4 5 6 7 8 9]
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

## Maps

Maps are a dynamically growable associative array type, like the hash or dictionary types of some other languages.

Keys in a map have no particular order. The key type does not even have to be orderable, it only must be comparable.

```go
m := map[string]int{"three": 3, "four": 4}
m["one"] = 1
fmt.Printf("m: %v\nm[\"one\"]: %d", m, m["one"])
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

## Unused variables

Unused variables are an error in Go.

The blank identifier lets you "use" a variable but discard its value. Technically, the blank identifier is an underscore.

```go
// Try replacing the blank identifier _ with a variable name.
var _ = "This variable is not used"
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_plain_main.go">
</codapi-snippet>

Usually you use it to ignore one of the return values of a function. For example, in a quick and dirty (!) script you might ignore the error value returned from `os.Create` and expect that the file will always be created.

```go
package main

import (
	"os"
	"fmt"
)

func main() {
	file, _ := os.Create("output.txt")
	fmt.Fprint(file, "This is how you write to a file, by the way")
	file.Close()
}
```

<codapi-snippet sandbox="go" editor="basic">
</codapi-snippet>

## Named return values

Functions in Go can have named return values. The main benefit is better self-documentation.

Compare

```go
func query(filter string) (string, string, string) { ... }
```

with

```go
func query(filter string) (first, last, email string) { ... }
```

The latter variant leaves no question about what each returned string represents.

Named return values are automatically declared in the function body.

You do not need to list named return values in the return statement. However, be aware that "naked" return statements are bad practice. They make the code less readable and prone to errors.

```go
func namedReturn() (a, b int) {
	a = 1   // note the simple assignment; no short declaration := required
	        // b is initialized with the zero value, 0 in this case.
	return  // bad practice; don't do this.
}

func main() {
	fmt.Println(namedReturn())
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

## Memory management

Go is fully garbage collected. Variables do not need to be manually allocated, and allocated memory does not need to be manually freed. Automatic memory management is one of the biggest factors in accelerating code creation.

Go has pointers but no pointer arithmetic. You can make a mistake with a `nil` pointer, but not by incrementing a pointer.

Unlike in C or C++, taking and returning an address of a local variable is also safe.

```go
func memoryAllocations() (p, q *int) {
	// Named return values p and q have type pointer to int.
	p = new(int) // Built-in function new allocates memory.

    // The allocated int slice is initialized to 0, p is no longer nil.
	s := make([]int, 20) // Allocate 20 ints as a single block of memory.
	s[3] = 7             // Assign one of them.
	r := -2              // Declare another local variable.
	return &s[3], &r     // & takes the address of an object.
}

func main() {
	a, b := memoryAllocations()
	fmt.Printf("*a: %d, *b: %d\n", *a, *b)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

## Flow control

### if

The condition of an `if` statement does not require parentheses. The body of an `if` statement _does_ require curly braces, even for "one-line" `if` bodies. The `else` statement must follow on the same line as the closing curly brace of the `then` block.

<script id="expensive.go" type="text/plain">
package main

func expensiveComputation() int {
	return 1
}
</script>

```go
if true {
	fmt.Println("told ya")
}

a := 1
if a > 0 {
	fmt.Println("yep")
} else {
	fmt.Println("nope")
}

// You can put an assignment statement before the condition.
// In this case, the variable lives ONLY within the scope of the `if``
// statement.

if y := expensiveComputation(); y > 0 {
	fmt.Println("positive!")
}
// y is not defined outside the if block.
// fmt.Println(y) // Uncomment this line to see the error
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go" files="#expensive.go">
</codapi-snippet>

### switch

If you find yourself writing changed `if` statements, switch to `switch` (pun intended).

A switch statement consists of an expression and a block with `case`s. A `case` block is executed if the `case` expression matches the result of the `switch` expression.

Unlike in other languages, you do not need to call `break` at the end of a case. Cases don't "fall through". If you intentionally want to "fall through" subsequent cases, add the keyword `fallthrough` to the end of a `case` block.

A `default` block can be added at the end. It is invoked if, and only if, none of the `case`s match.

```go
x := 42.0
switch x {
case 0:
	fmt.Println("not 42")
case 1, 2: // Can have multiple matches on one case
	fmt.Println("still not 42")
case 42:
	fmt.Println("Yay! 42!")
	// no fallthrough to subsequent case blocks.
case 43:
	fmt.Println("This case is never reached.")
default:
	fmt.Println("The default case is optional.")
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

#### Type switch

A type switch allows switching on the type of a variable instead of its value.

`any` is the name of the empty interface. Interfaces are discussed later. For this example, you only need to know that a variable of type `any` can be instantiated with data of any type.

Assign different values to data, like `10`, `false`, or `int64(42)`.

```go
var data any    // data is an empty interface
data = "data"   // now data holds a string
switch c := data.(type) { // c
case string:
	fmt.Printf("%s is a string", c)
case int64:
	fmt.Printf("%d is an int64\n", c)
default:
	fmt.Printf("data's type is %T, its value is %v", c, c)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

### Loops

Go has one loop keyword, `for`, to create for, while, and until loops, as well as loops over data ranges.

Like `if`, `for` conditions don't need parentheses.

Variables declared in `for` and `if` are local to their scope.

```go
x := 42
for x := 0; x < 3; x++ { // ++ is the increment operator
	fmt.Println("iteration", x)
}
fmt.Println("Not the loop's x: ", x)
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

Loop options and variants:

```go
// infinite loops and the break statement
x := 0
for { // an unrestricted loop
	fmt.Print(x, ",")
	if x >= 3 {
		break  // exit the loop
	}
	x++
}

fmt.Println()

x = 0
for x <= 5 { // a while loop
	x++
	if x % 2 == 0 { // modulo operator
		continue // skip the rest of this iteration
	}
	fmt.Print(x, ",")
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

### Range loops

You can use `range` to iterate over an array, a slice, a string, a map, or a channel.

`range` yields two values on every iteration:

-   For strings, slices, and arrays, the index and the value of the current element.
-   For maps, the key and the value of the current element.

For channels, `range` returns only one value, the element read from the channel.

```go
for index, value := range "Hello" {
	fmt.Printf("index=%d, value=%c\n", index, value)
}
fmt.Println()

for key, value := range map[string]int{"one": 1, "two": 2, "three": 3} {
	// for each pair in the map, print key and value
	fmt.Printf("key=%s, value=%d\n", key, value)
}
fmt.Println()

// If you only need the value, assign the key to the blank identifier
for _, name := range []string{"Bob", "Bill", "Joe"} {
	fmt.Printf("Hello, %s\n", name)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

### Goto (OMG!)

Use `goto` with great caution. But when you need it, [you'll love it](https://ammar.io/blog/go-goto-retry).

Example: Cleanup without deferred functions, often used in low-level pacakges like `syscall` or `runtime` (courtesy of the aforementioned article).

```go
func cleanupWithoutDefer() (err error) { // err is declared here
	var a, b string
	_, err = fmt.Sscan("one", &a, &b) // too many arguments for the input
    if err != nil {
        goto fail
    }
    // more error-producing code
    if err != nil {
        goto fail
    }
    // ...
    return nil

    fail:
        fmt.Printf("Got %s, cleaning up\n", err)
		// clean up
        return err
}

func main() {
	fmt.Println(cleanupWithoutDefer())
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

A `goto` directive cannot skip variable declarations.

```go
	goto printx // ERROR: goto jumps over declaration
	x := "I am skipped"
printx:
	fmt.Println(x)
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

## Function literals

Function literals are closures. A closure can see variables defined in the parent function's scope.

```go
x := 99999
xBig := func() bool {  // xBig is a variable of type func() bool
    return x > 10000   // References x declared outside the closure
}
fmt.Println("xBig:", xBig()) // true
x = 1.3e3                    // This makes x == 1300
fmt.Println("xBig:", xBig()) // false now.
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

Function literals may be used as an argument to a function, as long as:

1. the function literal is called immediately `()`, and
2. the result type matches the expected type of the argument.

```go
fmt.Printf("Add and double two numbers: %d", // %d expects an integer
    func(a, b int) int {
        return (a + b) * 2
    }(10, 2)) // Called with args 10 and 2
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

If you ever miss decorators in Go, try function literals:

```go
func main() {
	// Next two are equivalent, with second being more practical
	fmt.Println(sentenceFactory("summer")("It's", "time!"))

	d := sentenceFactory("summer")
	fmt.Println(d("A beautiful", "day!"))
	fmt.Println(d("A lazy", "afternoon!"))
}

func sentenceFactory(mystring string) func(before, after string) string {
	return func(before, after string) string {
		return fmt.Sprintf("%s %s %s", before, mystring, after) // new string
	}
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

## Defer

A `defer` statement pushes a function call onto a list. The list of saved calls is executed when the surrounding function returns.

Deferred functions are useful if a function has resources to clean up and if it has multiple exit points.

A deferred function takes no arguments and returns nothing. It is a closure, hence it can access its parent func's variables.

```go
func learnDefer() (err error) {
	defer func() {
		fmt.Println("deferred statements execute in reverse (LIFO) order.")
	}()  // Note the parens! The deferred func must be called here.
	defer fmt.Println("\nThis line is being printed first because")
	fmt.Println("This is normal code.")
	return nil
}

func main() {
	_ = learnDefer()  // always make ignoring an error an explicit operation
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

Note that the `defer` statement takes a function _call_, rather than a function _definition_.

## Basic Interfaces

A basic interface defines behavior by listing zero or more methods.

A type _implements_ an interface if it implements all methods that the interface declares.

```go
// Define Stringer as an interface type with one method, String.
type Stringer interface {
	String() string
}

// Define pair as a struct with two fields, ints named x and y.
type pair struct {
	x, y int
}

// Define a method on type pair. Pair now implements Stringer
// because Pair has defined all the methods in the interface.
func (p pair) String() string { // p is called the "receiver"
	// Sprintf is another public function in package fmt.
	// Dot syntax references fields of p.
	return fmt.Sprintf("(%d, %d)", p.x, p.y)
}
```

<codapi-snippet id="s-interfaces" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

```go
func main() {
	// Brace syntax is a "struct literal". It evaluates to an initialized
	// struct. The := syntax declares and initializes p to this struct.
	p := pair{3, 4}
	fmt.Println(p.String()) // Call String method of p, of type pair.
	var i Stringer          // Declare i of interface type Stringer.
	i = p                   // Valid because pair implements Stringer
	// Call String method of i, of type Stringer. Output same as above.
	fmt.Println(i.String())

	// Functions in the fmt package call the String method to ask an object
	// for a printable representation of itself.
	fmt.Println(p) // Output same as above. Println calls String method.
	fmt.Println(i) // Output same as above.

}
```

<codapi-snippet sandbox="go" editor="basic" depends-on="s-interfaces" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

## Type parameters

Type parameters, a.k.a. generics, can be used to define generic functions that work with a range of parameter types, rather than just one specific. They are also useful for creating generic containers that can hold elements of different types (think "tree of ints" or "tree of strings").

A type parameter for a function is specified within brackets, between the function name and the parameter list. `T` is the name of the parameter, and `comparable` is a type constraint.

```go
func CountOccurrences[T comparable](slice []T, element T) int {
    count := 0
    for _, value := range slice {
        if value == element {
            count++
        }
    }
    return count
}

func main() {
	numbers := []int{1, 2, 3, 2, 4, 2, 5}
	count := CountOccurrences(numbers, 2)  //
	fmt.Printf("Found %d occurrences of 2 in %v\n", count, numbers)

	words := []string{"go", "is", "awesome!", "go", "go!"}
	count = CountOccurrences(words, "go")
	fmt.Printf("Found %d occurrences of 'go' in %v\n", count, words)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

In this example, `T` can only be instantiated by a type that is comparable (through the `==` and `!=` operators). `comparable` is a pre-declared constraint. You can use a list of allowed types as well.

Edit the code and change

```go
[T comparable]
```

to

```go
[T int|string]
```

Now only `int`s or `string`s can be used for `T`. The code still works because `int` and `string` are both comparable types.

## Variadic parameters

Functions can have a dynamic number of parameters.

Prepend an ellipsis to a parameter type to make it variadic. Only the last parameter in a parameter list can be variadic.

Inside the function, the variadic parameter is an array of the given type.

```go
func learnVariadicParams(myStrings ...string) {
	// Iterate each value of the variadic.
	for i, param := range myStrings {
		fmt.Printf("(%d) %s ", i, param)
	}
	fmt.Println()
}

func main() {
	learnVariadicParams("great", "learning", "here!")

	// Expand a slice into a list of parameters by appending an ellipsis
	s := []string{"codapi", "is", "awesome!"}
	learnVariadicParams(s...)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go">
</codapi-snippet>

## Error handling

Go handles errors explicitly. It has no exceptions.

Please do not try to emulate exceptions because you are used to them. In Go, errors are values, and handling errors when they occur is idiomatic Go.

Also, don't ignore errors returned by a function. Handling errors is part of your program's logic. People often say that Go's explicit error handling only adds noise to the code, but consider this:

> "If 80% of your Go code consists of error handling, it is because 80% of your code might fail at any time."
>
> _– [Preslav Rachev](https://preslav.me/2023/04/14/golang-error-handling-is-a-form-of-storytelling/)_

```go
func divideBy(a, b int) (int, error) {  // always put an error last
	// Create a new error
	if b == 0 {
		// errors is a package from the standard library
		return 0, errors.New("divideBy: division by zero is undefined")
	}
	return a/b, nil // nil means no error
}

func calculate() (int, error) {
	// If you cannot handle an error, pass it on with annotations
	res, err := divideBy(10, 0)
	if err != nil {
		// The fmt package has an Errorf function for creating error messages
        // %w is a special verb for wrapping errors
		return 0, fmt.Errorf("calculate: %w", err)
	}
	return res, nil
}

func main() {
	fmt.Println(calculate())
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt_errors.go">
</codapi-snippet>

## Comma,ok idiom

Trying to fetch a non-existing element from a map or read from a closed channel is not an error. Therfore, such an operation returns a boolean instead of an error.

The "comma,ok" idiom is used to examine the result of that operation.

```go
m := map[int]string{3: "three", 4: "four"}

if x, ok := m[1]; ok { // key 1 is not in the map.
	fmt.Println("1:", x)
}

if x, ok := m[3]; ok { // key 3 is in the map
	fmt.Println("3:", x)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

## Concurrency

Go has three concurrency primitives built into the language: goroutines, channels and select.

### Goroutines

Goroutines are lightweight threads. They are supposed to be short-lived. Hence, they have no "control API". The runtime scheduler maps goroutines onto system threads as needed.

A goroutine cannot have a return value. The caller doesn't wait for the goroutine, so there is nothing to return a value to.

```go
// A function with an endless loop.
func surfing() {
	for {
		fmt.Print(".")
	}
}

// Start any function as a goroutine by prepending "go".
func main() {
	go surfing()
	time.Sleep(time.Millisecond)
}

// A process does not wait for running goroutines
// to finish. When main() exits, all goroutines are stopped
// immediately.
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt_time.go">
</codapi-snippet>

### Channels

Channels are used for sending data from one goroutine to another.

A channel can have a size of zero. In this case, the sender blocks until the receiver reads the sent value. This is effectively a synchronization mechanism.

The `<-` operator reads from or writes to a channel.

```go
// Create a channel with integer elements.
ch := make(chan int) // this channel has zero size.

// The syntax "chan<-" tells the func that this channel
// is for sending only.
go func(send chan<- int) {
	for i := 0; i < 10; i++ {
		send <- i
		fmt.Println("sent", i)
	}
	// by closing the channel, we tell the receiver
	// that there is nothing left to wait for
	close(send)
}(ch) // don't forget to call the goroutine here

// Now that the sender runs concurrently, we can start
// receiving values from the channel.
// The range loop exits when the channel is closed.
for n := range ch {
	fmt.Println("received", n)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go">
</codapi-snippet>

You might have noticed that some "received" messages may appear before the corresponding "sent" message. This is because of the asynchronous nature of this code. The receiver may be faster to print out the result than the sender.

You may also have noticed that the send and receive messages come in a quite ordered manner. That's because the sender has to wait for the receiver to read a value from the channel before it can send a new one.

Give the channel a non-zero size and see what happens. Edit the above code and change the line

```go
ch := make(chan int)
```

to

```
ch := make(chan int, 7)
```

Now, the sender can write 7 elements to the channel before it is blocked. After the receiver reads some values, the sender is able to continue sending.

### Select statement

A `select` statement is similar to a `switch` statement. But instead of matching a condition, the `case` blocks listen on channels to read from or wait for channels to become available for sending.

```go
c1 := make(chan string)
c2 := make(chan string)

// send some values to c1 with a delay
go func() {
	for i := 0; i < 3; i++ {
		c1 <- fmt.Sprintf("one %d", i)
		time.Sleep(10 * time.Millisecond)
	}
	close(c1)
}()

// send some values to c2 with a delay
go func() {
	for i := 0; i < 2; i++ {
		c2 <- fmt.Sprintf("two %d", i)
		time.Sleep(15 * time.Millisecond)
	}
	close(c2)
}()

for {
	// select takes no expressions. The cases block
    // until one of the channels becomes available.
	select {
	// The comma,ok idiom allows checking if a channel
	// is open or closed.
	case msg1, ok := <-c1:
		if !ok {
			c1 = nil
		} else {
			fmt.Println("Received from c1:", msg1)
		}
	case msg2, ok := <-c2:
		if !ok {
			c2 = nil
		} else {
			fmt.Println("Received from c2:", msg2)
		}
	default:
		if c1 == nil && c2 == nil {
			return
		}
	}
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt_time.go">
</codapi-snippet>

## Web programming

A single function from package `net/http` is sufficient to run a web server.

The following code starts a web server in a separate goroutine, then makes a request to it and prints the response:

```go
// A handler function responds to an HTTP request.
func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "You tried Go in Y minutes!")
}

func main() {
	// Wire the base path to the handler func
	http.HandleFunc("/", handler)

	// Start a web server
	go func() {
		err := http.ListenAndServe(":8181", nil)
		if err != nil {
			fmt.Println("ListenAndServe: ", err)
		}
	}()

	// send a request
	resp, err := http.Get("http://localhost:8181/")
	if err != nil {
		log.Fatal("Error sending request: ", err)
	}
	// The response body is an `io.Reader` stream that must be
	// closed after reading.
	defer resp.Body.Close()

	// Read and print the response.
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatal("Error reading response body: ", err)
	}

	// `body` is a byte slice. string() turns it into a string.
	fmt.Println("The web server says:", string(body))
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt_http_log_io.go">
</codapi-snippet>

## Further Reading

The root of all things Go is the [official Go web site](http://go.dev/). There you can follow the tutorial, play interactively, and read lots.

Aside from a tour, [the docs](https://go.dev/doc/) contain information on how to write clean and effective Go code, package and command docs, and release history.

The [Go language specification](https://go.dev/ref/spec) itself is highly recommended. It's easy to read and amazingly short (as language definitions go these days.)

You can try out or share Go code on the [Go playground](https://go.dev/play/p/njnvlXVIrRd).

On the reading list for students of Go is the [source code to the standard library](https://pkg.go.dev/std). Comprehensively documented, it demonstrates the best of readable and understandable Go, Go style, and Go idioms. If you click on a function name in a package documentation, you can drill down into the source code!

Another great resource to learn Go is [Go by example](https://gobyexample.com/) by Mark McGranaghan and Eli Bendersky.

If you want to stay up to date on Go, read the [Applied Go Weekly Newsletter](https://newsletter.appliedgo.net) by Christoph Berger.
