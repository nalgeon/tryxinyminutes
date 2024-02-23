---
x: C
title: Try C in Y minutes
image: /try/cover.png
lastmod: 2024-02-12
original: https://learnxinyminutes.com/docs/c/
license: CC-BY-SA-3.0
contributors:
    - ["Adam Bard", "http://adambard.com/"]
    - ["Árpád Goretity", "http://twitter.com/H2CO3_iOS"]
    - ["Jakub Trzebiatowski", "http://cbs.stgn.pl"]
    - ["Marco Scannadinari", "https://marcoms.github.io"]
    - ["Zachary Ferguson", "https://github.io/zfergus2"]
    - ["himanshu", "https://github.com/himanshu81494"]
    - ["Joshua Li", "https://github.com/JoshuaRLi"]
    - ["Dragos B. Chirila", "https://github.com/dchirila"]
    - ["Heitor P. de Bittencourt", "https://github.com/heitorPB/"]
    - ["Anton Zhiyanov", "https://antonz.org/"]
---

Ah, C. Still **the** language of modern high-performance computing.

C is the lowest-level language most programmers will ever use, but
it more than makes up for it with raw speed. Just be aware of its manual
memory management and C will take you as far as you need to go.

[Introduction](#introduction) ·
[Types](#types) ·
[Operators](#operators) ·
[Control Structures](#control-structures) ·
[Typecasting](#typecasting) ·
[Pointers](#pointers) ·
[Functions](#functions) ·
[User-defined types and structs](#user-defined-types-and-structs) ·
[Function pointers](#function-pointers) ·
[Printing characters with printf()](#printing-characters-with-printf) ·
[Order of Evaluation](#order-of-evaluation) ·
[Header files](#header-files) ·
[Further Reading](#further-reading)

> **About compiler flags**
>
> By default, `gcc` and `clang` are pretty quiet about compilation warnings and
> errors, which can be very useful information. Explicitly using stricter
> compiler flags is recommended. Here are some recommended defaults:
>
> `-Wall -Wextra -Werror -O2 -std=c99 -pedantic`
>
> For information on what these flags do as well as other flags, consult the man page for your C compiler (e.g. `man 1 gcc`) or just search online.

## Introduction

Single-line and multi-line comments:

```c
// Single-line comments start with // - only available in C99 and later.

/*
Multi-line comments look like this. They work in C89 as well.
*/
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

Multi-line comments don't nest:

```c
/*
Multi-line comments don't nest /* Be careful */  // comment ends on this line...
*/ // ...not this one!
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

Constants are defined using `#define`. They are written in all-caps as a convention,
not a requirement:

```c
#define DAYS_IN_YEAR 365
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

Enumeration constants are another way to declare constants:

```c
enum days {SUN, MON, TUE, WED, THU, FRI, SAT};
// SUN gets 0, MON gets 1, TUE gets 2, etc.
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

All statements must end with a semicolon.

Enumeration values can also be specified:

```c
enum days {SUN = 1, MON, TUE, WED = 99, THU, FRI, SAT};
// MON gets 2 automatically, TUE gets 3, etc.
// WED get 99, THU gets 100, FRI gets 101, etc.
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

Import headers with `#include`:

```c
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

File names between `<angle brackets>` tell the compiler to look in your system
libraries for the headers.
For your own headers, use double quotes instead of angle brackets, and
provide the path:

```c
#include "my_header.h" // local file
#include "../my_lib/my_lib_header.h" // relative path
```

Declare function signatures in advance in a `.h` file, or at the top of
your `.c` file.

```c
void function_1();
int function_2(void);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

At a minimum, you must declare a 'function prototype' before its use in any function.
Normally, prototypes are placed at the top of a file before any function definition.

```c
// function prototype
int add_two_ints(int x1, int x2);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

Although `int add_two_ints(int, int);` is also valid (no need to name the args),
it is recommended to name arguments in the prototype as well for easier inspection.

Function prototypes are not necessary if the function definition comes before
any other function that calls that function. However, it's standard practice to
always add the function prototype to a header file (`*.h`) and then `#include` that
file at the top. This prevents any issues where a function might be called
before the compiler knows of its existence, while also giving the developer a
clean header file to share with the rest of the project.

Your program's entry point is a function called `main`. The return type can
be anything, however most operating systems expect a return type of `int` for
error code processing.

```c
int main(void) {
  // your program
}
```

<codapi-snippet sandbox="gcc" editor="basic">
</codapi-snippet>

The command line arguments used to run your program are also passed to main:

-   `argc` being the number of arguments - your program's name counts as 1.
-   `argv` is an array of character arrays - containing the arguments themselves.
    `argv[0]` = name of your program, `argv[1]` = first argument, etc.

```c
int main (int argc, char** argv) {
  // print output using printf, for "print formatted"
  // %d is an integer, \n is a newline
  printf("%d\n", 42);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" output>
</codapi-snippet>

```
42
```

Take input using `scanf`:

```c
// '&' is used to define the location
// where we want to store the input value
int input;
scanf("%d", &input);
```

## Types

Compilers that are not C99-compliant require that variables _must_ be
declared at the top of the current block scope.
Compilers that _are_ C99-compliant allow declarations near the point where
the value is used.
For the sake of the tutorial, variables are declared dynamically under
C99-compliant standards.

```c
// ints are usually 4 bytes (use the `sizeof` operator to check)
// `%zu` stands for `size_t` type, which is returned by `sizeof`
int x_int = 1024;
printf("x_int = %d, size = %zu bytes\n", x_int, sizeof(x_int));

// shorts are usually 2 bytes
// `%hi` stands for short integers
short x_short = 42;
printf("x_short = %hi, size = %zu bytes\n", x_short, sizeof(x_short));
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
x_int = 1024, size = 4 bytes
x_short = 42, size = 2 bytes
```

Chars are defined as the smallest addressable unit for a processor.
This is usually 1 byte, but for some systems it can be more (ex. for TMS320 from TI it's 2 bytes).

```c
char x_char = 120;
// `%c` stands for characters
printf(
  "x_char = %c, code = %d, size = %zu bytes\n",
  x_char, x_char, sizeof(x_char)
);

char y_char = 'y'; // Char literals are quoted with ''
printf(
  "y_char = %c, code = %d, size = %zu bytes\n",
  y_char, y_char, sizeof(y_char)
);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
x_char = x, code = 120, size = 1 bytes
y_char = y, code = 121, size = 1 bytes
```

Longs are often 4 to 8 bytes; long longs are guaranteed to be at least
8 bytes.

```c
// `%li` stands for long integers
long x_long = 0;
printf(
  "x_long = %li, size = %zu bytes\n",
  x_long, sizeof(x_long)
);

// `%lli` stands for long long integers
long long x_long_long = 0;
printf(
  "x_long_long = %lli, size = %zu bytes\n",
  x_long_long, sizeof(x_long_long)
);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
x_long = 0, size = 8 bytes
x_long_long = 0, size = 8 bytes
```

Floats are usually 32-bit floating point numbers.
Doubles are usually 64-bit floating-point numbers.

```c
// 'f' suffix here denotes floating point literal
float x_float = 0.0f;
// `%f` stands for floating point numbers
printf("x_float = %f, size = %zu bytes\n", x_float, sizeof(x_float));

// real numbers without any suffix are doubles
double x_double = 0.0;
printf("x_double = %f, size = %zu bytes\n", x_double, sizeof(x_double));
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
x_float = 0.000000, size = 4 bytes
x_double = 0.000000, size = 8 bytes
```

Integer types may be unsigned (greater than or equal to zero).

```c
unsigned short ux_short;
unsigned int ux_int;
unsigned long long ux_long_long;
```

Chars inside single quotes are integers in machine's character set.

```c
// 48 in the ASCII character set.
printf("'0' = %d\n", '0');

// 65 in the ASCII character set.
printf("'A' = %d\n", 'A');
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
'0' = 48
'A' = 65
```

`sizeof(T)` gives you the size of a variable with type `T` in bytes.
`sizeof(obj)` yields the size of the expression (variable, literal, etc.).

```c
// = 4 on most machines with 4-byte words
printf("%zu\n", sizeof(int));
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
4
```

If the argument of the `sizeof` operator is an expression, then its argument
is not evaluated (except VLAs (see below)).
The value it yields in this case is a compile-time constant.

```c
int a = 1;
// size_t is an unsigned integer type of at least 2 bytes
// used to represent the size of an object.
size_t size = sizeof(a++); // a++ is not evaluated
printf("sizeof(a++) = %zu where a = %d\n", size, a);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
sizeof(a++) = 4 where a = 1
```

Arrays must be initialized with a concrete size:

```c
// This array occupies 1 * 20 = 20 bytes
char my_char_array[20];

// This array occupies 4 * 20 = 80 bytes
int my_int_array[20];

// (assuming 4-byte words)
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

You can initialize an array of twenty ints that all equal 0 thusly:

```c
int my_array[20] = {0};
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

...where the `{0}` part is called an "array initializer".

All elements (if any) past the ones in the initializer are initialized to 0:

```c
int my_array[5] = {1, 2};

// for loop is used to iterate over array,
// described in more detail later
for (int i = 0; i < 5; i++) {
  printf("%d ", my_array[i]);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
1 2 0 0 0
```

So `my_array` now has five elements, all but the first two of which are 0.

You get away without explicitly declaring the size
of the array IF you initialize the array on the same line:

```c
int my_array[] = {11, 12, 13};

for (int i = 0; i < 3; i++) {
  printf("%d ", my_array[i]);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
11 12 13
```

When not declaring the size, the size of the array is the number
of elements in the initializer. With `{11, 12, 13}`, `my_array` is now of size 3.
To evaluate the size of the array at run-time, divide its byte size by the
byte size of its element type:

```c
int my_array[] = {11, 12, 13};
size_t my_array_size = sizeof(my_array) / sizeof(my_array[0]);
printf("my_array size = %zu\n", my_array_size);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
3
```

**Warning**. You should evaluate the size _before_ you begin passing the array
to functions (see later discussion) because arrays get "downgraded" to
raw pointers when they are passed to functions (so the statement above
will produce the wrong result inside the function).

Indexing an array is like other languages - or,
rather, other languages are like C:

```c
int my_array[] = {11, 12, 13};
printf("my_array[0] = %d\n", my_array[0]);

// Arrays are mutable; it's just memory!
my_array[1] = 2;
printf("my_array[1] = %d\n", my_array[1]);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
my_array[0] = 11
my_array[1] = 2
```

In C99 (and as an optional feature in C11), variable-length arrays (VLAs)
can be declared as well. The size of such an array need not be a compile
time constant:

```c
printf("Enter the array size: "); // ask the user for an array size
int array_size;
fscanf(stdin, "%d", &array_size);

int var_length_array[array_size]; // declare the VLA
printf("sizeof array = %zu\n", sizeof var_length_array);
```

Example:

```c
// suppose this is coming from the user
int array_size = 10;

int var_length_array[array_size]; // declare the VLA
printf("sizeof array = %zu\n", sizeof var_length_array);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
sizeof array = 40
```

Strings are just arrays of chars terminated by a `NULL` (`0x00`) byte,
represented in strings as the special character `\0`.
(We don't have to include the `NULL` byte in string literals; the compiler
inserts it at the end of the array for us.)

```c
char a_string[20] = "This is a string";
printf("%s\n", a_string); // %s formats a string

// byte #17 is 0 (as are 18, 19, and 20)
printf("a_string[16] = %d\n", a_string[16]);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
This is a string
a_string[16] = 0
```

If we have characters between single quotes, that's a character literal.
It's of type `int`, and _not_ `char` (for historical reasons).

```c
int cha = 'a'; // fine
char chb = 'a'; // fine too (implicit conversion from int to char)
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

Multi-dimensional arrays:

```c
int multi_array[2][5] = {
  {1, 2, 3, 4, 5},
  {6, 7, 8, 9, 0}
};

// access elements:
int array_int = multi_array[0][2];
printf("multi_array[0][2] = %d\n", array_int);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
multi_array[0][2] = 3
```

## Operators

Shorthands for multiple declarations:

```c
int i1 = 1, i2 = 2;
float f1 = 1.0, f2 = 2.0;

int b, c;
b = c = 0;
```

<codapi-snippet id="c-ints" sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

Arithmetic is straightforward:

```c
printf("i1 + i2 = %d\n", i1 + i2);
printf("i2 - i1 = %d\n", i2 - i1);
printf("i2 * i1 = %d\n", i2 * i1);
printf("i1 / i2 = %d\n", i1 / i2); // (0.5, but truncated towards 0)
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="c-ints" output>
</codapi-snippet>

```
i1 + i2 = 3
i2 - i1 = 1
i2 * i1 = 2
i1 / i2 = 0
```

You need to cast at least one integer to float to get a floating-point result:

```c
printf("i1 / i2 (f) = %f\n", (float)i1 / i2);
printf("i1 / i2 (d) = %f\n", i1 / (double)i2);
printf("f1 / f2     = %f\n", f1 / f2); // 0.5, plus or minus epsilon
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="c-ints" output>
</codapi-snippet>

```
i1 / i2 (f) = 0.500000
i1 / i2 (d) = 0.500000
f1 / f2     = 0.500000
```

Floating-point numbers are defined by IEEE 754, thus cannot store perfectly
exact values. For instance, the following does not produce expected results
because 0.1 might actually be 0.099999999999 inside the computer, and 0.3
might be stored as 0.300000000001:

```c
(0.1 + 0.1 + 0.1) != 0.3; // => 1 (true)
// and it is NOT associative due to reasons mentioned above.
1 + (1e123 - 1e123) != (1 + 1e123) - 1e123; // => 1 (true)
// this notation is scientific notations for numbers: 1e123 = 1*10^123
```

It is important to note that most all systems have used IEEE 754 to
represent floating points. Even Python, used for scientific computing,
eventually calls C which uses IEEE 754. It is mentioned this way not to
indicate that this is a poor implementation, but instead as a warning
that when doing floating point comparisons, a little bit of error (epsilon)
needs to be considered.

Modulo is there as well, but be careful if arguments are negative:

```c
printf("%d\n", 11 % 3); // 2 as 11 = 2 + 3*x (x=3)
printf("%d\n", (-11) % 3); // -2, as one would expect
printf("%d\n", 11 % (-3)); // 2 and not -2, and it's quite counter intuitive
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
2
-2
2
```

Comparison operators are probably familiar, but
there is no Boolean type in C. We use ints instead.
0 is false, anything else is true. (The comparison
operators always yield 0 or 1.)

```c
printf("3 == 2 -> %d\n", 3 == 2);
printf("3 != 2 -> %d\n", 3 != 2);
printf("3 > 2  -> %d\n", 3 > 2);
printf("3 < 2  -> %d\n", 3 < 2);
printf("2 <= 2 -> %d\n", 2 <= 2);
printf("2 >= 2 -> %d\n", 2 >= 2);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
3 == 2 -> 0
3 != 2 -> 1
3 > 2  -> 1
3 < 2  -> 0
2 <= 2 -> 1
2 >= 2 -> 1
```

C99 introduced the `_Bool` type in `stdbool.h`, but its `true` and `false`
values are just aliases for 1 and 0:

```c
#include <stdbool.h>

int main() {
  bool is_true = 1;
  bool is_false = 0;
}
```

<codapi-snippet sandbox="gcc" editor="basic" output-mode="hidden">
</codapi-snippet>

C is not Python - comparisons do NOT chain.
Warning: The line below will compile, but it means `(0 < a) < 2`.
This expression is always true, because (0 < a) could be either 1 or 0,
and 2 is greater than 1 or 0.

```c
int a = 42;
printf("0 < 42 < 2: %d\n", 0 < a < 2);
// instead use:
printf("0 < 42 && 42 < 2: %d\n", 0 < a && a < 2);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
...
```

Logic works on ints:

```c
printf("!3 -> %d\n", !3); // (Logical not)
printf("!0 -> %d\n", !0);
printf("1 && 1 -> %d\n", 1 && 1); // (Logical and)
printf("0 && 1 -> %d\n", 0 && 1);
printf("0 || 1 -> %d\n", 0 || 1); // (Logical or)
printf("0 || 0 -> %d\n", 0 || 0);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
!3 -> 0
!0 -> 1
1 && 1 -> 1
0 && 1 -> 0
0 || 1 -> 1
0 || 0 -> 0
```

Conditional ternary expression `? :`:

```c
int e = 5;
int f = 10;
int z;
z = (e > f) ? e : f; // "if e > f return e, else return f."
printf("%d\n", z);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
10
```

Increment and decrement operators:

```c
int j = 0;

int pos = j++; // return j THEN increase j
printf("%d\n", pos);

int pre = ++j; // increase j THEN return j
printf("%d\n", pre);

// same with j-- and --j
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
0
2
```

Bitwise operators:

```c
// bitwise negation, "1's complement", example result for 32-bit int
printf("~0x0F       -> 0x%02X\n", ~0x0F);       // bitwise NOT
printf("0x0F & 0xF0 -> 0x%02X\n", 0x0F & 0xF0); // bitwise AND
printf("0x0F | 0xF0 -> 0x%02X\n", 0x0F | 0xF0); // bitwise OR
printf("0x04 ^ 0x0F -> 0x%02X\n", 0x04 ^ 0x0F); // bitwise XOR
printf("0x01 << 1   -> 0x%02X\n", 0x01 << 1);   // bitwise left shift (by 1)
printf("0x02 >> 1   -> 0x%02X\n", 0x02 >> 1);   // bitwise right shift (by 1)
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
~0x0F       -> FFFFFFF0
0x0F & 0xF0 -> 0
0x0F | 0xF0 -> FF
0x04 ^ 0x0F -> B
0x01 << 1   -> 2
0x02 >> 1   -> 1
```

Be careful when shifting signed integers - the following are undefined:

-   shifting into the sign bit of a signed integer (`int a = 1 << 31`)
-   left-shifting a negative number (`int a = -1 << 2`)
-   shifting by an offset which is >= the width of the type of the LHS:<br>
    `int a = 1 << 32` (UB if int is 32 bits wide)

## Control Structures

If-then-else:

```c
if (0) {
  printf("I am never run\n");
} else if (0) {
  printf("I am also never run\n");
} else {
  printf("I print\n");
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
I print
```

While loops with pre-conditions:

```c
int ii = 0;
while (ii < 10) { // ANY value less than ten is true.
  printf("%d, ", ii++); // ii++ increments ii AFTER using its current value.
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
```

And post-conditions:

```c
int kk = 0;
do {
  printf("%d, ", kk);
} while (++kk < 10); // ++kk increments kk BEFORE using its current value.
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
```

For loops too:

```c
int jj;
for (jj = 0; jj < 10; jj++) {
  printf("%d, ", jj);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
```

In C99 and newer versions, you can directly declare loop control variables
in the loop's parentheses:

```c
for (int i = 0; i < 10; i++) {
  printf("%d, ", i);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
```

Loops and Functions MUST have a body:

```c
int i;
for (i = 0; i <= 5; i++) {
  ; // If no body is needed, use semicolon
    // to act as the body (null statement)
}

// Or
for (i = 0; i <= 5; i++);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```

```

Branching with multiple choices:

```c
int a = 1;
switch (a) {
case 0: // labels need to be integral *constant* expressions (such as enums)
  printf("Hey, 'a' equals 0!\n");
  break; // if you don't break, control flow falls over labels

case 1:
  printf("Huh, 'a' equals 1!\n");
  break;
  // Be careful - without a "break", execution continues until the
  // next "break" is reached.

case 3:
case 4:
  printf("Look at that.. 'a' is either 3, or 4\n");
  break;

default:
  // if `some_integral_expression` didn't match any of the labels
  fputs("Error!\n", stderr);
  exit(-1);
  break;
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
Huh, 'a' equals 1!
```

Using `goto`:

```c
typedef enum { false, true } bool;
bool disaster = false;
int i, j;

for (i = 0; i < 100; ++i) {
  for (j = 0; j < 100; ++j) {
    if ((i + j) >= 150) {
      disaster = true;
    }
    if (disaster) {
        goto error;  // exit both for loops
    }
  }
}

error: // this is a label that you can "jump" to with "goto error;"
printf("Error occurred at i = %d & j = %d.\n", i, j);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
Error occurred at i = 51 & j = 99.
```

It is generally considered bad practice to do so, except if
you really know what you are doing. See [Spaghetti code](https://en.wikipedia.org/wiki/Spaghetti_code#Meaning).

## Typecasting

Every value in C has a type, but you can cast one value into another type
if you want (with some constraints).

```c
// You can assign vars with hex literals
// binary is not in the standard, but allowed by some
// compilers (x_bin = 0b0010010110)
int x_hex = 0x01;
```

<codapi-snippet id="s-hex" sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

Casting between types will attempt to preserve their numeric values:

```c
printf("%d\n", x_hex);
printf("%d\n", (short) x_hex);
printf("%d\n", (char) x_hex);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="s-hex" output>
</codapi-snippet>

```
1
1
1
```

If you assign a value greater than a types max val, it will rollover
without warning:

```c
// Max char = 255 if char is 8 bits long
printf("%d\n", (unsigned char) 257);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
1
```

For determining the max value of a `char`, a `signed char` and an `unsigned char`,
respectively, use the `CHAR_MAX`, `SCHAR_MAX` and `UCHAR_MAX` macros from `<limits.h>`.

Integral types can be cast to floating-point types, and vice-versa:

```c
printf("%f\n", (double) 100); // %f always formats a double...
printf("%f\n", (float)  100); // ...even with a float.
printf("%d\n", (char)100.0);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
100.000000
100.000000
100
```

## Pointers

A pointer is a variable declared to store a memory address. Its declaration will
also tell you the type of data it points to. You can retrieve the memory address
of your variables, then mess with them.

```c
int x = 0;
printf("%p\n", (void *)&x); // Use & to retrieve the address of a variable
// (%p formats an object pointer of type void *)
// prints some address in memory
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
0x7ffdb92d98d4
```

Pointers start with `*` in their declaration:

```c
int x = 0;
int *px, not_a_pointer; // px is a pointer to an int
px = &x; // Stores the address of x in px
```

<codapi-snippet id="s-xpx" sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

```c
// Prints some address in memory
printf("%p\n", (void *)px);
// Prints "8, 4" on a typical 64-bit system
printf("%zu, %zu\n", sizeof(px), sizeof(not_a_pointer));
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="s-xpx" output>
</codapi-snippet>

```
0x7fff4c25c0bc
8, 4
```

To retrieve the value at the address a pointer is pointing to,
put `*` in front to dereference it.
Note: yes, it may be confusing that `*` is used for _both_ declaring a
pointer and dereferencing it.

```c
x = 42;
printf("%d\n", *px); // prints the value of x
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="s-xpx" output>
</codapi-snippet>

```
42
```

You can also change the value the pointer is pointing to.
We'll have to wrap the dereference in parenthesis because
`++` has a higher precedence than `*`:

```c
(*px)++; // Increment the value px is pointing to by 1
printf("%d\n", *px);
printf("%d\n", x);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="s-xpx" output>
</codapi-snippet>

```
1
1
```

Arrays are a good way to allocate a contiguous block of memory:

```c
int x_array[20]; //declares array of size 20 (cannot change size)
for (int xx = 0; xx < 20; xx++) {
  x_array[xx] = 20 - xx;
} // Initialize x_array to 20, 19, 18,... 2, 1

// Declare a pointer of type int and initialize it to point to x_array
int* x_ptr = x_array;
```

<codapi-snippet id="s-xarray" sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

`x_ptr` now points to the first element in the array (the integer 20).
This works because arrays often decay into pointers to their first element.
For example, when an array is passed to a function or is assigned to a pointer,
it decays into (implicitly converted to) a pointer.

Exceptions:

```c
// when the array is the argument of the `&` (address-of) operator:
int arr[10];
int (*ptr_to_arr)[10] = &arr; // &arr is NOT of type `int *`!
// It's of type "pointer to array" (of ten `int`s).

// or when the array is a string literal used for initializing a char array:
char otherarr[] = "foobarbazquirk";

// or when it's the argument of the `sizeof` or `alignof` operator:
int arraythethird[10];
int *ptr = arraythethird; // equivalent with int *ptr = &arr[0];
printf("%zu, %zu\n", sizeof(arraythethird), sizeof(ptr));
// probably prints "40, 4" or "40, 8"
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
40, 8
```

Pointers are incremented and decremented based on their type
(this is called pointer arithmetic):

```c
printf("%d\n", *(x_ptr + 1));
printf("%d\n", x_array[1]);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="s-xarray" output>
</codapi-snippet>

```
19
19
```

You can also dynamically allocate contiguous blocks of memory with the
standard library function `malloc`, which takes one argument of type `size_t`
representing the number of bytes to allocate (usually from the heap, although this
may not be true on e.g. embedded systems - the C standard says nothing about it):

```c
int *my_ptr = malloc(sizeof(*my_ptr) * 20);
for (int xx = 0; xx < 20; xx++) {
  *(my_ptr + xx) = 20 - xx; // my_ptr[xx] = 20-xx
} // Initialize memory to 20, 19, 18, 17... 2, 1 (as ints)
```

<codapi-snippet id="s-myptr" sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

Be careful passing user-provided values to malloc! If you want
to be safe, you can use `calloc` instead (which, unlike `malloc`, also zeros out the memory):

```c
int *my_other_ptr = calloc(20, sizeof(int));
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

Note that there is no standard way to get the length of a
dynamically allocated array in C. Because of this, if your arrays are
going to be passed around your program a lot, you need another variable
to keep track of the number of elements (size) of an array. See the
functions section for more info.

```c
size_t size = 10;
int *my_arr = calloc(size, sizeof(int));

// Add an element to the array
size++;
my_arr = realloc(my_arr, sizeof(int) * size);

if (my_arr == NULL) {
  // Remember to check for realloc failure!
  printf("realloc failed!\n");
  return 0;
}

printf("successful realloc\n");
my_arr[10] = 5;
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
successful realloc
```

Dereferencing memory that you haven't allocated gives
"unpredictable results" - the program is said to invoke "undefined behavior":

```c
printf("%d\n", *(my_ptr + 21));
// Prints who-knows-what? It may even crash.
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="s-myptr" output>
</codapi-snippet>

```
0
```

When you're done with a malloc'd block of memory, you need to free it,
or else no one else can use it until your program terminates
(this is called a "memory leak"):

```c
free(my_ptr);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" depends-on="s-myptr" output-mode="hidden">
</codapi-snippet>

Strings are arrays of char, but they are usually represented as a
pointer-to-char (which is a pointer to the first element of the array).
It's good practice to use `const char *` when referring to a string literal,
since string literals shall not be modified (i.e. `foo[0]` = 'a' is ILLEGAL.)

```c
const char *my_str = "This is my very own string literal";
printf("%c\n", *my_str); // first character
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
T
```

This is not the case if the string is an array
(potentially initialized with a string literal)
that resides in writable memory, as in:

```c
char foo[] = "foo";
foo[0] = 'a'; // this is legal
printf("%s\n", foo);
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output>
</codapi-snippet>

```
aoo
```

## Functions

Function declaration syntax:

```c
// <return type> <function name>(<args>)
int add_two_ints(int x1, int x2) {
  return x1 + x2; // Use return to return a value
}

int main() {
  int sum = add_two_ints(40, 2);
  printf("%d\n", sum);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" output>
</codapi-snippet>

```
42
```

Functions are call by value. When a function is called, the arguments passed to
the function are copies of the original arguments (except arrays). Anything you
do to the arguments in the function do not change the value of the original
argument where the function was called.

Use pointers if you need to edit the original argument values (arrays are always
passed in as pointers).

Example: in-place string reversal:

```c
// A void function returns no value
void str_reverse(char *str_in) {
  char tmp;
  size_t len = strlen(str_in); // `strlen()` is part of the c standard library
  // NOTE: string.h header file needs to be included to use strlen()
  // NOTE: length returned by `strlen` DOESN'T
  // include the terminating NULL byte ('\0')

  for (int ii = 0; ii < len / 2; ii++) {
    tmp = str_in[ii];
    str_in[ii] = str_in[len - ii - 1]; // ii-th char from end
    str_in[len - ii - 1] = tmp;
  }
}
```

<codapi-snippet id="s-reverse" sandbox="gcc" editor="basic" template="tpl-func.c" output-mode="hidden">
</codapi-snippet>

```c
int main() {
  char c[] = "This is a test.";
  str_reverse(c);
  printf("%s\n", c);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" depends-on="s-reverse" output>
</codapi-snippet>

```
.tset a si sihT
```

C does not allow for returning multiple values with the return statement. If
you would like to return multiple values, then the caller must pass in the
variables where they would like the returned values to go. These variables must
be passed in as pointers such that the function can modify them.

```c
int return_multiple(int *array_of_3, int *ret1, int *ret2, int *ret3) {
  if (array_of_3 == NULL) {
    return 0; // return status (false)
  }

  // de-reference the pointer so we modify its value
  *ret1 = array_of_3[0];
  *ret2 = array_of_3[1];
  *ret3 = array_of_3[2];

  return 1; // return status (true)
}

int main() {
  int arr[] = {11, 22, 33};
  int a = 0;
  int b = 0;
  int c = 0;
  int ok = return_multiple(arr, &a, &b, &c);
  printf("ok=%d a=%d b=%d c=%d\n", ok, a, b, c);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" output>
</codapi-snippet>

```
ok=1 a=11 b=22 c=33
```

Another example:

```c
void swap_numbers(int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp;
}

int main() {
  int first = 10;
  int second = 20;
  printf("first: %d\nsecond: %d\n", first, second);
  swap_numbers(&first, &second);
  printf("first: %d\nsecond: %d\n", first, second);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" output>
</codapi-snippet>

```
first: 10
second: 20
first: 20
second: 10
```

With regards to arrays, they will always be passed to functions
as pointers. Even if you statically allocate an array like `arr[10]`,
it still gets passed as a pointer to the first element in any function calls.
Again, there is no standard way to get the size of a dynamically allocated
array in C.

```c
// Size must be passed!
// Otherwise, this function has no way of knowing how big the array is.
void print_int_array(int *arr, size_t size) {
  for (int i = 0; i < size; i++) {
    printf("arr[%d] is: %d\n", i, arr[i]);
  }
}

int main() {
  int my_arr[] = { 1, 2, 3, 4, 5 };
  int size = 5;
  print_int_array(my_arr, size);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" output>
</codapi-snippet>

```
arr[0] is: 1
arr[1] is: 2
arr[2] is: 3
arr[3] is: 4
arr[4] is: 5
```

If referring to external variables outside function, you should use the `extern` keyword:

```c
int i = 0;

void extern_1() {
  extern int i; // i here is now using external variable i
  i = 42;
}

int main() {
  printf("i = %d\n", i);
  extern_1();
  printf("i = %d\n", i);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" output>
</codapi-snippet>

```
i = 0
i = 42
```

Make external variables private to source file with `static`:

```c
static int j = 0; // other files using extern_2() cannot access variable j

void extern_2() {
  extern int j;
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

The `static` keyword makes a variable inaccessible to code outside the
compilation unit. (On almost all systems, a "compilation unit" is a `.c`
file.) `static` can apply both to global (to the compilation unit) variables,
functions, and function-local variables. When using `static` with
function-local variables, the variable is effectively global and retains its
value across function calls, but is only accessible within the function it
is declared in. Additionally, static variables are initialized to 0 if not
declared with some other starting value.

You can also declare functions as static to make them private. Suppose you have
two functions in `mylib.c`:

```c
#include <stdio.h>

// is accessible from other .c files
void public_hello() {
  printf("hello in public");
}

// is NOT accessible from other .c files
static void private_hello() {
  printf("hello in private");
}
```

You can call the first function from `main.c`:

```c
void public_hello();

int main() {
  public_hello();
}
```

<codapi-snippet sandbox="gcc" editor="basic" files="mylib.c" output>
</codapi-snippet>

```
hello in public
```

But not the second one, declared as `static`:

```c
void private_hello();

int main() {
  private_hello();
}
```

<codapi-snippet sandbox="gcc" editor="basic" files="mylib.c" output>
</codapi-snippet>

```
main.c:(.text+0xa): undefined reference to `private_hello'
collect2: error: ld returned 1 exit status
 (exit status 1)
```

## User-defined types and structs

Typedefs can be used to create type aliases:

```c
typedef int my_type;
my_type my_type_var = 0;
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

Structs are just collections of data, the members are allocated sequentially,
in the order they are written:

```c
struct rectangle {
  int width;
  int height;
};
```

<codapi-snippet id="s-rectangle" sandbox="gcc" editor="basic" template="tpl-head.c" output-mode="hidden">
</codapi-snippet>

It's NOT generally true that

```c
sizeof(struct rectangle) == sizeof(int) + sizeof(int)
```

due to potential padding between the structure members (this is for [alignment
reasons](https://stackoverflow.com/questions/119123/why-isnt-sizeof-for-a-struct-equal-to-the-sum-of-sizeof-of-each-member)).

Using structs:

```c
int main() {
  // Fields can be initialized immediately
  struct rectangle my_rec = { 1, 2 };

  // Access struct members with .
  my_rec.width = 10;
  my_rec.height = 20;

  printf("{%d %d}\n", my_rec.width, my_rec.height);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" depends-on="s-rectangle" output>
</codapi-snippet>

```
{10 20}
```

Using pointers to structs:

```c
int main() {
  struct rectangle my_rec = { 1, 2 };
  // You can declare pointers to structs
  struct rectangle *my_rec_ptr = &my_rec;

  // Use dereferencing to set struct pointer members...
  (*my_rec_ptr).width = 30;

  // ... or even better: prefer the -> shorthand for the sake of readability
  my_rec_ptr->height = 10; // Same as (*my_rec_ptr).height = 10;

  printf("{%d %d}\n", my_rec_ptr->width, my_rec_ptr->height);
  printf("{%d %d}\n", my_rec.width, my_rec.height);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" depends-on="s-rectangle" output>
</codapi-snippet>

```
{30 10}
{30 10}
```

You can apply a typedef to a struct for convenience:

```c
typedef struct rectangle rect;

int area(rect r) {
  return r.width * r.height;
}

int main() {
  rect r = { 2, 4 };
  printf("area = %d\n", area(r));
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" depends-on="s-rectangle" output>
</codapi-snippet>

```
area = 8
```

Typedefs can also be defined right during struct definition:

```c
typedef struct {
  int width;
  int height;
} rect;

int main() {
  // Like before, doing this means one can type
  rect r1;

  // instead of having to type
  struct rectangle r2;
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" depends-on="s-rectangle" output-mode="hidden">
</codapi-snippet>

If you have large structs, you can pass them "by pointer" to avoid copying
the whole struct:

```c
typedef struct {
  int width;
  int height;
} rect;

int areaptr(const rect *r) {
  return r->width * r->height;
}

int main() {
  rect r = { 2, 4 };
  printf("area = %d\n", areaptr(&r));
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" output>
</codapi-snippet>

```
area = 8
```

## Function pointers

At run time, functions are located at known memory addresses. Function pointers are
much like any other pointer (they just store a memory address), but can be used
to invoke functions directly, and to pass handlers (or callback functions) around.
However, definition syntax may be initially confusing.

```c
int main() {
  char str_in[] = "Hello, World!";

  // Use str_reverse from a pointer.
  // Define a function pointer variable, named f.
  void (*f)(char *); // Signature should exactly match the target function.

  f = &str_reverse; // Assign the address for the actual function (determined at run time)
  // f = str_reverse; would work as well - functions decay into pointers, similar to arrays

  (*f)(str_in); // Just calling the function through the pointer
  // f(str_in); // That's an alternative but equally valid syntax for calling it.

  printf("%s\n", str_in);
}
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-body.c" depends-on="s-reverse" output>
</codapi-snippet>

```
!dlroW ,olleH
```

As long as function signatures match, you can assign any function to the same pointer.
Function pointers are usually typedef'd for simplicity and readability, as follows:

```c
typedef void (*my_fnp_type)(char *);

// Then used when declaring the actual pointer variable:
// ...
// my_fnp_type f;
```

<codapi-snippet sandbox="gcc" editor="basic" template="tpl-main.c" output-mode="hidden">
</codapi-snippet>

## Printing characters with printf()

Special characters:

```c
'\a'; // alert (bell) character
'\n'; // newline character
'\t'; // tab character (left justifies text)
'\v'; // vertical tab
'\f'; // new page (form feed)
'\r'; // carriage return
'\b'; // backspace character
'\0'; // NULL character. Usually put at end of strings in C.
//   hello\n\0. \0 used by convention to mark end of string.
'\\'; // backslash
'\?'; // question mark
'\''; // single quote
'\"'; // double quote
'\xhh'; // hexadecimal number. Example: '\xb' = vertical tab character
'\0oo'; // octal number. Example: '\013' = vertical tab character
```

Print formatting:

```c
"%d";    // integer
"%3d";   // integer with minimum of length 3 digits (right justifies text)
"%s";    // string
"%f";    // float
"%ld";   // long
"%3.2f"; // minimum 3 digits left and 2 digits right decimal float
"%7.4s"; // (can do with strings too)
"%c";    // char
"%p";    // pointer. NOTE: need to (void *)-cast the pointer, before passing
         //                it as an argument to `printf`.
"%x";    // hexadecimal
"%o";    // octal
"%%";    // prints %
```

## Order of Evaluation

From top to bottom, top has higher precedence:

```
┌───────────────────────────────────┬───────────────┐
│        Operators                  │ Associativity │
├───────────────────────────────────┼───────────────┤
│ () [] -> .                        │ left to right │
│ ! ~ ++ -- + = *(type) sizeof      │ right to left │
│ * / %                             │ left to right │
│ + -                               │ left to right │
│ << >>                             │ left to right │
│ < <= > >=                         │ left to right │
│ == !=                             │ left to right │
│ &                                 │ left to right │
│ ^                                 │ left to right │
│ |                                 │ left to right │
│ &&                                │ left to right │
│ ||                                │ left to right │
│ ?:                                │ right to left │
│ = += -= *= /= %= &= ^= |= <<= >>= │ right to left │
│ ,                                 │ left to right │
└───────────────────────────────────┴───────────────┘
```

## Header files

Header files are an important part of C as they allow for the connection of C
source files and can simplify code and definitions by separating them into
separate files.

Header files are syntactically similar to C source files but reside in `.h`
files. They can be included in your C source file by using the precompiler
command `#include "example.h"`, given that `example.h` exists in the same directory
as the C file.

Here is a sample `example.h`:

```c
// A safe guard to prevent the header from being defined too many times. This
// happens in the case of circle dependency, the contents of the header is
// already defined.
#ifndef EXAMPLE_H // if EXAMPLE_H is not yet defined.
#define EXAMPLE_H // Define the macro EXAMPLE_H.

// Other headers can be included in headers and therefore transitively
// included into files that include this header.
#include <string.h>

// Like for c source files, macros can be defined in headers
// and used in files that include this header file.
#define EXAMPLE_NAME "Dennis Ritchie"

// Function macros can also be defined.
#define ADD(a, b) ((a) + (b))

// Notice the parenthesis surrounding the arguments -- this is important to
// ensure that a and b don't get expanded in an unexpected way (e.g. consider
// MUL(x, y) (x * y); MUL(1 + 2, 3) would expand to (1 + 2 * 3), yielding an
// incorrect result)

// Structs and typedefs can be used for consistency between files.
typedef struct Node {
  int val;
  struct Node *next;
} Node;

// So can enumerations.
enum traffic_light_state {GREEN, YELLOW, RED};

// Function prototypes can also be defined here for use in multiple files,
// but it is bad practice to define the function in the header. Definitions
// should instead be put in a C file.
Node create_linked_list(int *vals, int len);

// Beyond the above elements, other definitions should be left to a C source
// file. Excessive includes or definitions should also not be contained in
// a header file but instead put into separate headers or a C file.

#endif // End of the if precompiler directive.
```

And here is how to use it in `main.c`:

```c
#include <stdio.h>
#include "example.h"

// function definition
Node create_linked_list(int *vals, int len) {
    // implementation skipped for brevity
    Node n = {42, NULL};
    return n;
}

int main() {
  printf("EXAMPLE_NAME = %s\n", EXAMPLE_NAME);
  printf("3 + 2 = %d\n", ADD(3,2));
  printf("Lights: %d -> %d -> %d\n", GREEN, YELLOW, RED);

  int vals[] = {42};
  Node list = create_linked_list(vals, 1);
  printf("{ %d }\n", list.val);
}
```

<codapi-snippet sandbox="gcc" editor="basic" files="example.h" output>
</codapi-snippet>

```
EXAMPLE_NAME = Dennis Ritchie
3 + 2 = 5
Lights: 0 -> 1 -> 2
{ 42 }
```

## Further Reading

Books:

-   [K&R, aka "The C Programming Language"](https://en.wikipedia.org/wiki/The_C_Programming_Language)
    is _the_ book about C, written by Dennis Ritchie, the creator of C, and Brian Kernighan.
    Be careful, though - it's ancient and contains some inaccuracies (well, ideas that are not
    considered good anymore) or now-changed practices.
-   [Beej's Guide to C Programming](https://beej.us/guide/bgc/)
    is probably the best introduction to _modern_ C.
-   [Learn C The Hard Way](https://learncodethehardway.org/c/) (not free) is another good resource.

If you have a question, read the [compl.lang.c FAQ](https://c-faq.com).

It's very important to use proper spacing, indentation and to be consistent with
your coding style in general. Readable code is better than clever code and fast code.
There are a few good coding styles available on the Internet to follow, these are:

-   [Linux kernel coding style](https://www.kernel.org/doc/Documentation/process/coding-style.rst)
	is mainly used in the Linux kernel.
-   [Kernel Normal Form](https://man.openbsd.org/style.9) is used in the BSD systems. Based on the
	original KNF concept from CSRG.
-   [Coding Standards for SunOS](https://www.cis.upenn.edu/~lee/06cse480/data/cstyle.ms.pdf)
	is used in the SunOS and OpenZFS.
