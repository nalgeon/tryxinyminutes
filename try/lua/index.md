---
x: Lua
title: Try Lua in Y minutes
image: /try/cover.png
lastmod: 2024-03-08
license: CC BY-SA 4.0
contributors:
    - ["Sameer Srivastava", "https://github.com/s-m33r"]
---

# Introduction

Lua is designed to be a lightweight embeddable scripting language that is easy to learn and use and to embed into your application.

Lua has no notion of a "main" program: it works embedded in a host client, called the embedding program or simply the host. (Frequently, this host is the stand-alone lua program.) The host program can invoke functions to execute a piece of Lua code, can write and read Lua variables, and can register C functions to be called by Lua code. Through the use of C functions, Lua can be augmented to cope with a wide range of different domains, thus creating customized programming languages sharing a syntactical framework.

This guide has been adapted from the [learnxinyminutes page on Lua](https://learnxinyminutes.com/docs/lua/) and [the Lua reference manual](https://lua.org/manual/5.4/).

Let's begin:

Two dashes start a one-line comment.

```lua
-- Two dashes start a one-line comment.
```
<codapi-snippet sandbox="lua" editor="basic">
</codapi-snippet>

Multi-line comments.

```lua
--[[
     Adding two ['s and ]'s makes it a
     multi-line comment.
--]]
```
<codapi-snippet sandbox="lua" editor="basic">
</codapi-snippet>

# Variables and flow control

Lua is dynamically typed, with **global variables by default**.

There are eight basic types in Lua: nil, boolean, number, string, function, userdata, thread, and table. 

```lua
num = 42  -- Numbers can be integer or floating point.
someFloat = 1.23

bool = false

s = 'walternate'  -- Immutable strings like Python.
t = "double-quotes are also fine"
u = [[ Double brackets
       start and end
       multi-line strings.]]
       
t = nil  -- Undefines t; Lua has garbage collection.

-- Undefined variables return nil.
-- This is not an error:
foo = anUnknownVariable  -- Now foo = nil.
```
<codapi-snippet id="vars" sandbox="lua" editor="basic">
</codapi-snippet>

Blocks are denoted with keywords like do/end. All whitespace is ignored.

Looping constructs:

```lua
while num < 50 do
  num = num + 1  -- No ++ or += type operators.
  print(num)
end

karlSum = 0
for i = 1, 100 do  -- The range includes both ends.
  karlSum = karlSum + i
end

repeat
  num = num - 1
until num > 10 
```
<codapi-snippet sandbox="lua" depends-on="vars" editor="basic">
</codapi-snippet>

If/Else clauses:

```lua
if num > 40 then
  print('over 40')
  
elseif s ~= 'walternate' then  -- ~= is not equals.
  -- Equality check is == like Python; ok for strs.
  io.write('not over 40\n')  -- Defaults to stdout.
  
else
  -- Variables are global by default.
  thisIsGlobal = 5  -- Camel case is common.

  -- How to make a variable local:
  local line = io.read()  -- Reads next stdin line.

  -- String concatenation uses the .. operator:
  print('Winter is coming, ' .. line)
  
end
```
<codapi-snippet sandbox="lua" depends-on="vars" editor="basic">
</codapi-snippet>

Only nil and false are falsy; 0 and '' are true!

```lua
if not nonexistentVariable then print('it was false') end

-- 'or' and 'and' are short-circuited.
-- This is similar to the a?b:c operator in C/js:
ans = aBoolValue and 'yes' or 'no'  --> 'no'
```
<codapi-snippet sandbox="lua" editor="basic">
</codapi-snippet>

More on ranges:

```lua
-- Use "100, 1, -1" as the range to count down:
fredSum = 0
for j = 100, 1, -1 do
  fredSum = fredSum + j; if j % 2 == 0 then print(j) end -- use ; to put multiple statements in one line
end

-- In general, the range is begin, end[, step].
```
<codapi-snippet sandbox="lua" depends-on="vars" editor="basic">
</codapi-snippet>

# Functions

Functions are defined using the keyword 'function' and follow the format `function name(argslist) [block] end`. No `do` required.

```lua
function fib(n)
  if n < 2 then return 1 end
  return fib(n - 2) + fib(n - 1)
end

print(fib(5))
```
<codapi-snippet sandbox="lua" editor="basic">
</codapi-snippet>

Closures and anonymous functions are ok:

```lua
function adder(x)
  -- The returned function is created when adder is
  -- called, and remembers the value of x:
  return function (y) return x + y end
end
a1 = adder(9)
a2 = adder(36)
print(a1(16))  --> 25
print(a2(64))  --> 100
```
<codapi-snippet sandbox="lua" editor="basic">
</codapi-snippet>

Lua supports multiple single-line assignments and returns.

```lua
-- Returns, func calls, and assignments all work
-- with lists that may be mismatched in length.
-- Unmatched receivers are nil;
-- unmatched senders are discarded.

x, y, z = 1, 2, 3, 4
-- Now x = 1, y = 2, z = 3, and 4 is thrown away.

function bar(a, b, c)
  print(a, b, c)
  return 4, 8, 15, 16, 23, 42
end

x, y = bar('zaphod')  --> prints "zaphod  nil nil"
-- Now x = 4, y = 8, values 15...42 are discarded.
```
<codapi-snippet sandbox="lua" editor="basic">
</codapi-snippet>

Functions are first-class, global by default like variables.

```lua
-- Functions are first-class, may be local/global.
-- These are the same:
function f(x) return x * x end
f = function (x) return x * x end
print(f(11))

-- And so are these:
local function g(x) return math.sin(x) end
local g; g  = function (x) return math.sin(x) end
-- the 'local g' decl makes g-self-references ok.

-- Trig funcs work in radians, by the way.
print(g(math.pi/2))
```
<codapi-snippet sandbox="lua" editor="basic">
</codapi-snippet>

Calls with one string param don't need parens.

```lua
print 'hello'  -- Works fine.
```
<codapi-snippet sandbox="lua" editor="basic">
</codapi-snippet>

