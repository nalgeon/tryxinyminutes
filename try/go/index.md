---
name: Go
category: language
language: Go
filename: learngo.go
canonical: https://learnxinyminutes.com/docs/go/
original: https://github.com/adambard/learnxinyminutes-docs/blob/master/go.html.markdown
contributors:
    -  ["Christoph Berger", "https://github.com/christophberger"]
license: CC-BY-SA 3.0
---
<!-- codapi-settings url="http://localhost:1313/v1">
</codapi-settings -->

> This text and code is based on [Learn X in Y Minutes Where X = Go](https://learnxinyminutes.com/docs/go/), with only a few changes required by the separation of the code into snippets that can execute independently. Big shoutout to the authors!

Go was created out of the need to get work done. It's not the latest trend
in programming language theory, but it is a way to solve real-world
problems.

Go draws concepts from imperative languages with static typing.
It's fast to compile and fast to execute, it adds easy-to-understand
concurrency because multicore CPUs are now common, and it's used successfully
in large codebases (~100 million lines of code at Google, Inc.).

Go comes with a rich standard library and a large, thriving community.

## Comments

Go has single- and multiline comments. Multiline comments cannot be nested.
```go
// Single line comment
/* Multi-
 line comment */
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_plain_main.go"></codapi-snippet>


## Build tags

```go
 /* A build tag is a line comment starting with // +build
  and can be executed by go build -tags="foo bar" command.
  Build tags are placed before the package clause near or at the top of the file
  followed by a blank line or other line comments. */
// +build prod, dev, test
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_plain_main.go"></codapi-snippet>


## Packages and imports

A package clause starts every source file.
`main` is a special name declaring an executable rather than a library.

Import declaration declares library packages referenced in this file.

Imported packages must be used. (The Go Language Server `gopls` can take care of removing unused imports automatically.)

```go
package main

import (
	"fmt"       // A package in the Go standard library.
	"io/ioutil" // Implements some I/O utility functions.
	m "math"    // Math library with local alias m.
	"net/http"  // Yes, a web server!
	"os"        // OS functions like working with the file system
	"strconv"   // String conversions.
)

// Running this code snippet is expected to fail.
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_noop_main_for_package_decl.go"></codapi-snippet>

 
## Functions

A function definition. 

The name `main` is special. It is the entry point for the
executable program. 

Go uses curly braces for defining scopes like a function body.

The opening brace of a function **must** appear on the same line as the function signature.

Go does **not** require semicolons to end a statement.

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

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go"></codapi-snippet>

> **NOTE:** For brevity, most of the following code snippets hide the package declaration, imports, and the `main()` function.
>
> If a code snippet contains only statements, assume they exist in a context similar to this:
> 
>     package main
> 
>     import (
>         // used packages imported here
>     )
>    
>     func main() {
>	     // statements visible in a code snippet typically live here
>     }

Functions have parameters in parentheses.
If there are no parameters, empty parentheses are still required.

```go
func noparams() {
	fmt.Println("Look ma! No parameters!")
}
```
<codapi-snippet sandbox="go" editor="basic" template="tpl_func_noparams.go"></codapi-snippet>

## Variables

Variables must be declared before use. The type name *precedes* the variable name; this is quite the opposite of what C does. See [here](https://appliedgo.com/blog/go-declaration-syntax) for an explanation.

A variable assignment uses a single equal sign (`=`). 

Use a "short declaration" to declare and assign in one statement. Go infers the type from the value assigned.

```go
var x int // Variable declaration. 
x = 3     // Variable assignment.
y := 4    // "Short" declaration
fmt.Println("x:", x, ", y:", y) 
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

Functions can have parameters and (multiple!) return values.

Here `x`, `y` are the arguments and `sum`, `prod` is the signature (what's returned). You could write `func learnMultiple(x, y int) (int, int)` as well, but named return parameters make the function signature clearer.

Note that `x` and `sum` receive the type `int`.

```go
func learnMultiple(x, y int) (sum, prod int) {
	return x + y, x * y // Return two values.
}

func main() {
	a, b := learnMultiple(3,4)
	fmt.Println(a, b)
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go"></codapi-snippet>

## Built-in types and literals

### Simple types

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

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

### Pointers

A pointer represents the address of a variable in memory.

Pointers are bound to their base type. For example, a pointer to an integer variable cannot be changed to point to a boolean variable.

Pointers are created by taking the address of a variable (`&a`) or by the `new()` function (discussed later).

```go
a, b := 1024, 2048
p, q := &a, &b // Declares p, q to be type pointer to int.
fmt.Println(p, q)   // This prints the addresses of p and q.
fmt.Println(*p, *q)   // * follows a pointer. This prints two ints.
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

### Arrays

Arrays are static; that is, they have a fixed size at compile time. 

```go
var a4 [4]int           // An array of 4 ints, initialized to all 0.
a5 := [...]int{3, 1, 5, 10, 100} // An array initialized with a fixed size of five
fmt.Printf("a4: %v\na5: %v\n", a4, a5)
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

Arrays have value semantics.

```go
var a4 [4]int           // An array of 4 ints, initialized to all 0.
a4_cpy := a4            // a4_cpy is a copy of a4, two separate instances.
a4_cpy[0] = 25          // Only a4_cpy is changed, a4 stays the same.
fmt.Println(a4_cpy[0] == a4[0]) // false
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>


### Slices

Slices have dynamic size. Arrays and slices each have advantages, 
but use cases for slices are much more common.

```go
s3 := []int{4, 5, 9}    // Compare to a5. No ellipsis used here.
s4 := make([]int, 4)    // Allocates slice of 4 ints, initialized to all 0.
var d2 [][]float64      // Declaration only, nothing allocated here.
bs := []byte("a slice") // Type conversion syntax.
fmt.Printf("s3: %v\ns4: %v\nd2: %v\nbs: %v\n", s3, s4, d2, bs)
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

Slices (as well as maps and channels) have reference semantics.

```go
s3 := []int{4, 5, 9}
s3_cpy := s3            // Both variables point to the same instance.
s3_cpy[0] = 0           // Which means both are updated.
fmt.Println(s3_cpy[0] == s3[0]) // true	
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

Because they are dynamic, slices can be appended to on-demand.

To append elements to a slice, the built-in `append()` function is used.

`append()` takes a variable number of arguments.

The first argument is a slice, to which `append()` adds the subsequent arguments and returns the updated slice.

```go
s := []int{1, 2, 3}		// Result is a slice of length 3.
fmt.Println(s)
s = append(s, 4, 5, 6)	// Added 3 elements. Slice now has length of 6.
fmt.Println(s) // Updated slice is now [1 2 3 4 5 6]
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

`append` only adds atomic elements to a slice. To append another slice, 
pass a slice and add a trailing ellipsis. The ellipsis tells the compiler 
to unpack the slice into individual elements, making them consumable for `append`. (This is called "paremeter expansion".)


```go
s := []int{1, 2, 3, 4, 5, 6}
s = append(s, []int{7, 8, 9}...) // The ellipsis unpacks the slice 
fmt.Println(s)	// Updated slice is now [1 2 3 4 5 6 7 8 9]
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

## Maps

Maps are a dynamically growable associative array type, like the
hash or dictionary types of some other languages.

```go
m := map[string]int{"three": 3, "four": 4}
m["one"] = 1
fmt.Printf("m: %v\nm[\"one\"]: %d", m, m["one"])
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

## Unused variables

Unused variables are an error in Go.

The blank identifier lets you "use" a variable but discard its value. 
Technically, the blank identifier is an underscore. 

(Try replacing the blank identifier "_" with a variable name.)

```go
var _ = "This variable is not used"
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_plain_main.go"></codapi-snippet>

Usually you use it to ignore one of the return values of a function.
For example, in a **quick and dirty** (!) script you might ignore the
error value returned from `os.Create` and expect that the file
will always be created.


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

<codapi-snippet sandbox="go" editor="basic"></codapi-snippet>

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

You do not need to list named return values in the return statement. 
However, be aware that "naked" return statements are bad practice. They make the code
less readable and prone to errors. 

```go
func namedReturn() (a, b int) {
	a = 1 // note the simple assignment; no short declaration := required
	// b is initialized with the zero value, 0 in this case.
	return      // bad practice; don't do this.
}

func main() {
	fmt.Println(namedReturn())
}
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go"></codapi-snippet>


## Memory management

Go is fully garbage collected. Variables do not need to be manually allocated, and allocated memory does not need to be manually freed. Automatic memory management is one of the biggest factors in accelerating code creation.

Go has pointers but no pointer arithmetic.
You can make a mistake with a `nil` pointer, but not by incrementing a pointer.

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

<codapi-snippet sandbox="go" editor="basic" template="tpl_pkg_main_with_fmt.go"></codapi-snippet>

## Flow control

### if 

The condition of an `if` statement does not require parentheses.

The body of an `if` statement *does* require curly braces, even for "one-line" `if` bodies. 

The `else` statement must follow on the same line as the closing curly brace of the `then` block. 

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
```

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

### switch

If you find yourself writing changed `if` statements, switch to `switch` (pun intended). 

A switch statement consists of an expression and a block with `case`s. A `case` block is executed if the `case` expression matches the result of the `switch` expression.

Unlike in other languages, you do not need to call `break` at the end of a case. Cases don't "fall through".

If you intentionally want to "fall through" subsequent cases, add the keyword `fallthrough` to the end of a `case` block.

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

<codapi-snippet sandbox="go" editor="basic" template="tpl_main_with_fmt.go"></codapi-snippet>

<div id="high-water mark" style="text-align:center; font-size:4em">🌊🌊🌊</div>

```go
	// Type switch allows switching on the type of something instead of value
	var data interface{}
	data = ""
	switch c := data.(type) {
	case string:
		fmt.Println(c, "is a string")
	case int64:
		fmt.Printf("%d is an int64\n", c)
	default:
		// all other cases
	}

	// Like if, for doesn't use parens either.
	// Variables declared in for and if are local to their scope.
	for x := 0; x < 3; x++ { // ++ is a statement.
		fmt.Println("iteration", x)
	}
	// x == 42 here.

	// For is the only loop statement in Go, but it has alternate forms.
	for { // Infinite loop.
		break    // Just kidding.
		continue // Unreached.
	}

	// You can use range to iterate over an array, a slice, a string, a map, or a channel.
	// range returns one (channel) or two values (array, slice, string and map).
	for key, value := range map[string]int{"one": 1, "two": 2, "three": 3} {
		// for each pair in the map, print key and value
		fmt.Printf("key=%s, value=%d\n", key, value)
	}
	// If you only need the value, use the underscore as the key
	for _, name := range []string{"Bob", "Bill", "Joe"} {
		fmt.Printf("Hello, %s\n", name)
	}

	// As with for, := in an if statement means to declare and assign
	// y first, then test y > x.
	if y := expensiveComputation(); y > x {
		x = y
	}
	// Function literals are closures.
	xBig := func() bool {
		return x > 10000 // References x declared above switch statement.
	}
	x = 99999
	fmt.Println("xBig:", xBig()) // true
	x = 1.3e3                    // This makes x == 1300
	fmt.Println("xBig:", xBig()) // false now.

	// What's more is function literals may be defined and called inline,
	// acting as an argument to function, as long as:
	// a) function literal is called immediately (),
	// b) result type matches expected type of argument.
	fmt.Println("Add + double two numbers: ",
		func(a, b int) int {
			return (a + b) * 2
		}(10, 2)) // Called with args 10 and 2
	// => Add + double two numbers: 24

	// When you need it, you'll love it.
	goto love
love:

	learnFunctionFactory() // func returning func is fun(3)(3)
	learnDefer()      // A quick detour to an important keyword.
	learnInterfaces() // Good stuff coming up!
}

func learnFunctionFactory() {
	// Next two are equivalent, with second being more practical
	fmt.Println(sentenceFactory("summer")("A beautiful", "day!"))

	d := sentenceFactory("summer")
	fmt.Println(d("A beautiful", "day!"))
	fmt.Println(d("A lazy", "afternoon!"))
}

// Decorators are common in other languages. Same can be done in Go
// with function literals that accept arguments.
func sentenceFactory(mystring string) func(before, after string) string {
	return func(before, after string) string {
		return fmt.Sprintf("%s %s %s", before, mystring, after) // new string
	}
}

func learnDefer() (ok bool) {
	// A defer statement pushes a function call onto a list. The list of saved
	// calls is executed AFTER the surrounding function returns.
	defer fmt.Println("deferred statements execute in reverse (LIFO) order.")
	defer fmt.Println("\nThis line is being printed first because")
	// Defer is commonly used to close a file, so the function closing the
	// file stays close to the function opening the file.
	return true
}

// Define Stringer as an interface type with one method, String.
type Stringer interface {
	String() string
}

// Define pair as a struct with two fields, ints named x and y.
type pair struct {
	x, y int
}

// Define a method on type pair. Pair now implements Stringer because Pair has defined all the methods in the interface.
func (p pair) String() string { // p is called the "receiver"
	// Sprintf is another public function in package fmt.
	// Dot syntax references fields of p.
	return fmt.Sprintf("(%d, %d)", p.x, p.y)
}

func learnInterfaces() {
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

	learnVariadicParams("great", "learning", "here!")
}

// Functions can have variadic parameters.
func learnVariadicParams(myStrings ...interface{}) {
	// Iterate each value of the variadic.
	// The underscore here is ignoring the index argument of the array.
	for _, param := range myStrings {
		fmt.Println("param:", param)
	}

	// Pass variadic value as a variadic parameter.
	fmt.Println("params:", fmt.Sprintln(myStrings...))

	learnErrorHandling()
}

func learnErrorHandling() {
	// ", ok" idiom used to tell if something worked or not.
	m := map[int]string{3: "three", 4: "four"}
	if x, ok := m[1]; !ok { // ok will be false because 1 is not in the map.
		fmt.Println("no one there")
	} else {
		fmt.Print(x) // x would be the value, if it were in the map.
	}
	// An error value communicates not just "ok" but more about the problem.
	if _, err := strconv.Atoi("non-int"); err != nil { // _ discards value
		// prints 'strconv.ParseInt: parsing "non-int": invalid syntax'
		fmt.Println(err)
	}
	// We'll revisit interfaces a little later. Meanwhile,
	learnConcurrency()
}

// c is a channel, a concurrency-safe communication object.
func inc(i int, c chan int) {
	c <- i + 1 // <- is the "send" operator when a channel appears on the left.
}

// We'll use inc to increment some numbers concurrently.
func learnConcurrency() {
	// Same make function used earlier to make a slice. Make allocates and
	// initializes slices, maps, and channels.
	c := make(chan int)
	// Start three concurrent goroutines. Numbers will be incremented
	// concurrently, perhaps in parallel if the machine is capable and
	// properly configured. All three send to the same channel.
	go inc(0, c) // go is a statement that starts a new goroutine.
	go inc(10, c)
	go inc(-805, c)
	// Read three results from the channel and print them out.
	// There is no telling in what order the results will arrive!
	fmt.Println(<-c, <-c, <-c) // channel on right, <- is "receive" operator.

	cs := make(chan string)       // Another channel, this one handles strings.
	ccs := make(chan chan string) // A channel of string channels.
	go func() { c <- 84 }()       // Start a new goroutine just to send a value.
	go func() { cs <- "wordy" }() // Again, for cs this time.
	// Select has syntax like a switch statement but each case involves
	// a channel operation. It selects a case at random out of the cases
	// that are ready to communicate.
	select {
	case i := <-c: // The value received can be assigned to a variable,
		fmt.Printf("it's a %T", i)
	case <-cs: // or the value received can be discarded.
		fmt.Println("it's a string")
	case <-ccs: // Empty channel, not ready for communication.
		fmt.Println("didn't happen.")
	}
	// At this point a value was taken from either c or cs. One of the two
	// goroutines started above has completed, the other will remain blocked.

	learnWebProgramming() // Go does it. You want to do it too.
}

// A single function from package http starts a web server.
func learnWebProgramming() {

	// First parameter of ListenAndServe is TCP address to listen to.
	// Second parameter is an interface, specifically http.Handler.
	go func() {
		err := http.ListenAndServe(":8080", pair{})
		fmt.Println(err) // don't ignore errors
	}()

	requestServer()
}

// Make pair an http.Handler by implementing its only method, ServeHTTP.
func (p pair) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	// Serve data with a method of http.ResponseWriter.
	w.Write([]byte("You learned Go in Y minutes!"))
}

func requestServer() {
	resp, err := http.Get("http://localhost:8080")
	fmt.Println(err)
	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	fmt.Printf("\nWebserver said: `%s`", string(body))
}
```

## Further Reading

The root of all things Go is the [official Go web site](http://golang.org/).
There you can follow the tutorial, play interactively, and read lots.
Aside from a tour, [the docs](https://golang.org/doc/) contain information on
how to write clean and effective Go code, package and command docs, and release history.

The [Go language specification](https://golang.org/ref/spec) itself is highly recommended. It's easy to read
and amazingly short (as language definitions go these days.)

You can play around with the code on [Go playground](https://play.golang.org/p/tnWMjr16Mm). Try to change it and run it from your browser! Note that you can use [https://play.golang.org](https://play.golang.org) as a [REPL](https://en.wikipedia.org/wiki/Read-eval-print_loop) to test things and code in your browser, without even installing Go.

On the reading list for students of Go is the [source code to the standard
library](http://golang.org/src/pkg/). Comprehensively documented, it
demonstrates the best of readable and understandable Go, Go style, and Go
idioms. Or you can click on a function name in [the
documentation](http://golang.org/pkg/) and the source code comes up!

Another great resource to learn Go is [Go by example](https://gobyexample.com/).

There are many excellent conference talks and video tutorials on Go available on YouTube, and here are three playlists of the very best, tailored for beginners, intermediate, and advanced Gophers respectively:

- [Golang University 101](https://www.youtube.com/playlist?list=PLEcwzBXTPUE9V1o8mZdC9tNnRZaTgI-1P) introduces fundamental Go concepts and shows you how to use the Go tools to create and manage Go code
- [Golang University 201](https://www.youtube.com/playlist?list=PLEcwzBXTPUE_5m_JaMXmGEFgduH8EsuTs) steps it up a notch, explaining important techniques like testing, web services, and APIs
- [Golang University 301](https://www.youtube.com/playlist?list=PLEcwzBXTPUE8KvXRFmmfPEUmKoy9LfmAf) dives into more advanced topics like the Go scheduler, implementation of maps and channels, and optimisation techniques

Go Mobile adds support for mobile platforms (Android and iOS). You can write all-Go native mobile apps or write a library that contains bindings from a Go package, which can be invoked via Java (Android) and Objective-C (iOS). Check out the [Go Mobile page](https://github.com/golang/go/wiki/Mobile) for more information.