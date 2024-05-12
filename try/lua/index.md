---
x: Lua
title: Try Lua in Y minutes
image: /try/cover.png
lastmod: 2024-03-08
original: https://learnxinyminutes.com/docs/lua/
license: CC-BY-SA-3.0
contributors:
    - ["Tyler Neylon", "http://tylerneylon.com/"]
    - ["Sameer Srivastava", "https://github.com/s-m33r"]
---

# Introduction

[Lua](https://www.lua.org/) is designed to be a lightweight embeddable scripting language that is easy to learn and use and to embed into your application.

Lua has no notion of a "main" program: it works embedded in a host client, called the embedding program or simply the host. (Frequently, this host is the stand-alone lua program.) The host program can invoke functions to execute a piece of Lua code, can write and read Lua variables, and can register C functions to be called by Lua code. Through the use of C functions, Lua can be augmented to cope with a wide range of different domains, thus creating customized programming languages sharing a syntactical framework.

This guide has been adapted from the [learnxinyminutes page on Lua](https://learnxinyminutes.com/docs/lua/) and [the Lua reference manual](https://lua.org/manual/5.4/).

<div class="tryx__panel">
<p>🚧 This guide is a work in progress.</p>
</div>

Let's begin:

Two dashes start a one-line comment.

```lua
-- Two dashes start a one-line comment.
```

<codapi-snippet sandbox="lua" editor="basic" output-mode="hidden">
</codapi-snippet>

Multi-line comments.

```lua
--[[
     Adding two ['s and ]'s makes it a
     multi-line comment.
--]]
```

<codapi-snippet sandbox="lua" editor="basic" output-mode="hidden">
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

<codapi-snippet id="vars" sandbox="lua" editor="basic" output-mode="hidden">
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

# Tables

Tables are Lua's only compound data structure. Under the hood, they are associative arrays. Similar to JS objects, they are hash-lookup dicts that can also be used as lists.

Using tables as dictionaries/maps:

```lua
t = {key1 = 'value1', key2 = false}
u = {['@!#'] = 'qbert', [{}] = 1729, [6.28] = 'tau'}
```

<codapi-snippet id="tabledecl" sandbox="lua" output-mode="hidden" editor="basic">
</codapi-snippet>

```lua
-- string keys can use JS-like dot notation
print(t.key1)

t.newKey = {}  -- Adds a new key/value pair.
t.key2 = nil   -- Removes key2 from the table.

-- Literal notation for any (non-nil) value as key:

print(u[6.28])  -- prints "tau"
```

<codapi-snippet sandbox="lua" depends-on="tabledecl" editor="basic">
</codapi-snippet>

Key matching is basically by value for numbers and strings, but by identity for tables.

```lua
a = u['@!#']  -- Now a = 'qbert'.
b = u[{}]     -- We might expect 1729, but it's nil:
-- b = nil since the lookup fails. It fails
-- because the key we used is not the same object
-- as the one used to store the original value. So
-- strings & numbers are more portable keys.

print(a)
```

<codapi-snippet sandbox="lua" depends-on="tabledecl" editor="basic" >
</codapi-snippet>

Similar to strings, a one-table function call needs no parens:

```lua
function h(x) print(x.key) end

h{key = 'Sonmi~451'}  -- Prints 'Sonmi~451'.
```

<codapi-snippet sandbox="lua" editor="basic" >
</codapi-snippet>

Tables can be iterated over:

```lua
for key, val in pairs(u) do  -- Table iteration.
  print(key, val)
end

-- Notice that printing out the `table` key's value prints the memory address for that table.
```

<codapi-snippet sandbox="lua" depends-on="tabledecl" editor="basic" >
</codapi-snippet>

`_G` is a special table of all globals.

```lua
print(_G['_G'] == _G) -- true
```

<codapi-snippet sandbox="lua" editor="basic" >
</codapi-snippet>

Using tables as lists / arrays. **Indices start at 1**.

```lua
-- List literals implicitly set up int keys:
v = {'value1', 'value2', 1.21, 'gigawatts'}

for i = 1, #v do  -- #v is the size of v for lists.
  print(v[i])  -- Indices start at 1 !! SO CRAZY!
end

-- A 'list' is not a real type. v is just a table
-- with consecutive integer keys, treated as a list.
```

<codapi-snippet sandbox="lua" editor="basic" >
</codapi-snippet>

# Metatables and metamethods

A table can have a metatable that gives the table operator-overloadish behavior. Later we'll see how metatables support js-prototype behavior.

```lua
f1 = {a = 1, b = 2}  -- Represents the fraction a/b.
f2 = {a = 2, b = 3}

-- This would fail:
-- s = f1 + f2
```

<codapi-snippet id="metatable1" sandbox="lua" editor="basic" >
</codapi-snippet>

```lua
metafraction = {}
function metafraction.__add(f1, f2)
  sum = {}
  sum.b = f1.b * f2.b
  sum.a = f1.a * f2.b + f2.a * f1.b
  return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2  -- call __add(f1, f2) on f1's metatable

print(s.a, s.b)

-- This would fail since s has no metatable:
-- z = s + s
```

<codapi-snippet sandbox="lua" editor="basic" depends-on="metatable1" >
</codapi-snippet>

f1, f2 have no key for their metatable, unlike prototypes in js, so you must retrieve it as in `getmetatable(f1)`.
The metatable is a normal table with keys that Lua knows about, like `__add`.

An `__index` on a metatable overloads dot lookups.

From the Lua reference manual:
> The indexing access operation table[key]. This event happens when table is not a table or when key is not present in table. The metavalue is looked up in the metatable of table.

```lua
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.animal  -- works! thanks, metatable

print(eatenBy)
```

<codapi-snippet sandbox="lua" editor="basic" >
</codapi-snippet>

Direct table lookups that fail will retry using
the metatable's `__index` value, and this recurses.

An `__index` value can also be a function(tbl, key)
for more customized lookups.

Values of index, add, .. are called metamethods.
Here is a list: (not runnable)

```lua
-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)  <fn or a table>  for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)
```

# Class-like tables and inheritance

Classes aren't built in; there are different ways to make them using tables and metatables.

Explanation below:

```lua
Dog = {}                                   -- 1.

function Dog:new()                         -- 2.
  newObj = {sound = 'woof'}                -- 3.
  self.__index = self                      -- 4.
  return setmetatable(newObj, self)        -- 5.
end

function Dog:makeSound()                   -- 6.
  print('I say ' .. self.sound)
end

mrDog = Dog:new()                          -- 7.
```

<codapi-snippet id="Dog" sandbox="lua" editor="basic" >
</codapi-snippet>

```lua
mrDog:makeSound()  -- 'I say woof'         -- 8.
```

<codapi-snippet id="Dog-makeSound" sandbox="lua" depends-on="Dog" editor="basic" >
</codapi-snippet>

1. Dog acts like a class; it's really a table.
2. function tablename:fn(...) is the same as
   function tablename.fn(self, ...)
   The : just adds a first arg called self.
   Read 7 & 8 below for how self gets its value.
3. newObj will be an instance of class Dog.
4. self = the class being instantiated. Often
   self = Dog, but inheritance can change it.
   newObj gets self's functions when we set both
   newObj's metatable and self's __index to self.
5. Reminder: setmetatable returns its first arg.
6. The : works as in 2, but this time we expect
   self to be an instance instead of a class.
7. Same as Dog.new(Dog), so self = Dog in new().
8. Same as mrDog.makeSound(mrDog); self = mrDog.

**Inheritance Example:**

```lua
LoudDog = Dog:new()                           -- 1.

function LoudDog:makeSound()
  s = self.sound .. ' '                       -- 2.
  print(s .. s .. s)
end

seymour = LoudDog:new()                       -- 3.
```

<codapi-snippet sandbox="lua" id="LoudDog" depends-on="Dog" editor="basic" >
</codapi-snippet>

```lua
seymour:makeSound()  -- 'woof woof woof'      -- 4.
```

<codapi-snippet sandbox="lua" id="LoudDog-makeSound" depends-on="LoudDog" editor="basic" >
</codapi-snippet>

1. LoudDog gets Dog's methods and variables.
2. self has a 'sound' key from new(), see 3.
3. Same as LoudDog.new(LoudDog), and converted to
   Dog.new(LoudDog) as LoudDog has no 'new' key,
   but does have __index = Dog on its metatable.
   Result: seymour's metatable is LoudDog, and
   LoudDog.__index = LoudDog. So seymour.key will
   = seymour.key, LoudDog.key, Dog.key, whichever
   table is the first with the given key.
4. The 'makeSound' key is found in LoudDog; this
   is the same as LoudDog.makeSound(seymour).

```lua
-- If needed, a subclass's new() is like the base's:
function LoudDog:new()
  newObj = {}
  -- set up newObj
  self.__index = self
  return setmetatable(newObj, self)
end
```

<codapi-snippet sandbox="lua" depends-on="LoudDog" editor="basic" >
</codapi-snippet>

# Modules

Suppose the file mod.lua looks like this:

```lua
-- mod.lua

local M = {}

local function sayMyName()
  print('Hrunkner')
end

function M.sayHello()
  print('Why hello there')
  sayMyName()
end

return M
```

Another file can use mod.lua's functionality:

```lua
local mod = require('mod')  -- Run the file mod.lua.

-- This works because mod here = M in mod.lua:
mod.sayHello() -- Prints: Why hello there Hrunkner
```

<codapi-snippet id="mod" sandbox="lua" files="mod.lua" editor="basic" >
</codapi-snippet>

```lua
-- This is wrong; sayMyName only exists in mod.lua:
mod.sayMyName()  -- error
```

<codapi-snippet sandbox="lua" depends-on="mod" files="mod.lua" editor="basic" >
</codapi-snippet>

`require`'s return values are cached so a file is run at most once, even when require'd many times.

Example:

```lua
-- mod2.lua

print('Hi')
```

```lua
local a = require('mod2')  -- Prints Hi!
local b = require('mod2')  -- Doesn't print; a=b.
```

<codapi-snippet sandbox="lua" files="mod2.lua" editor="basic" >
</codapi-snippet>

`dofile` is like require without caching:

```lua
dofile('mod2.lua')  --> Hi!
dofile('mod2.lua')  --> Hi! (runs it again)
```

<codapi-snippet sandbox="lua" files="mod2.lua" editor="basic" >
</codapi-snippet>

```lua
-- loadfile loads a lua file but doesn't run it yet.
f = loadfile('mod2.lua')  -- Call f() to run it.

-- load is loadfile for strings.
-- (loadstring is deprecated, use load instead)
g = load('print(343)')  -- Returns a function.
g()  -- Prints out 343; nothing printed before now.
```

<codapi-snippet sandbox="lua" files="mod2.lua" editor="basic" >
</codapi-snippet>

# Further Reading

- The official [Programming in Lua](https://www.lua.org/pil/contents.html) book
- [BlackBulletIV’s Lua for programmers](https://ebens.me/posts/lua-for-programmers-part-1/)
- [Lua Short Reference](http://lua-users.org/wiki/LuaShortReference)

- [Love2D](https://love2d.org/) is a very popular Lua game engine
- Fantasy consoles like [TIC-80](https://tic80.com/) use Lua as the main programming language for games

- The main topics not covered are standard libraries:
    - [string library](http://lua-users.org/wiki/StringLibraryTutorial)
    - [table library](http://lua-users.org/wiki/TableLibraryTutorial)
    - [math library](http://lua-users.org/wiki/MathLibraryTutorial)
    - [io library](http://lua-users.org/wiki/IoLibraryTutorial)
    - [os library](http://lua-users.org/wiki/OsLibraryTutorial)

Have fun with Lua!
