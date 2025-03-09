---
x: Python
title: Try Python in Y minutes
image: /try/cover.png
lastmod: 2025-03-08
original: https://learnxinyminutes.com/docs/python/
license: CC-BY-SA 3.0
contributors:
    - ["efemeral-net", "http://github.com/efemeral-net"]
    - ["Louie Dinh", "http://pythonpracticeprojects.com"]
    - ["Zachary Ferguson", "http://github.com/zfergus2"]
    - ["evuez", "http://github.com/evuez"]
    - ["Rommel Martinez", "https://ebzzry.io"]
    - ["Roberto Fernandez Diaz", "https://github.com/robertofd1995"]
    - ["caminsha", "https://github.com/caminsha"]
    - ["Stanislav Modrak", "https://stanislav.gq"]
    - ["John Paul Wohlscheid", "https://gitpi.us"]
---

Python was created by Guido van Rossum in the early 90s. It is now one of the
most popular languages in existence. I fell in love with Python for its
syntactic clarity. It's basically executable pseudocode.

<div class="tryx__panel">
<p>✨ This is an open source guide. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/python/index.md">improve it</a>!</p>
</div>

[Datatypes and Operators](#1-datatypes-and-operators) ·
[Variables and Collections](#2-variables-and-collections) ·
[Control Flow and Iterables](#3-control-flow-and-iterables) ·
[Functions](#4-functions) ·
[Modules](#5-modules) ·
[Classes](#6-classes) ·
[Generators and Decorators](#7-generators-and-decorators) ·
[Further Reading](#further-reading)

## 1. Datatypes and Operators

There are two ways to make comments:

```python
# Single line comments start with a number symbol.

"""
Multiline strings can be written
using three "s, and are often used
as documentation.
"""
```

You have numbers:

```python
print(3)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
3
```

Math operates as you'd expect:

```python
a = 1 + 1
b = 2 - 1
c = 4 / 2
d = 3 * 2
print(a, b, c, d)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
2 1 2.0 6
```

Floor division rounds towards negative infinity:

```python
a = 5 // 3
b = -5 // 3
c = 5.0 // 3.0
d = -5.0 // 3.0
print(a, b, c, d)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
1 -2 1.0 -2.0
```

The result of division is always a float:

```python
x = 10 / 3
print(x)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
3.3333333333333335
```

Unless you use an integer division:

```python
x = 10 // 3
print(x)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
3
```

Modulo operation:

```python
x = 7 % 3
print(x)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
1
```

Exponentiation (x\*\*y, x to the yth power):

```python
x = 2**3
print(x)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
8
```

Enforce precedence with parentheses:

```python
x = 1 + 3 * 2
y = (1 + 3) * 2
print(x, y)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
7 8
```

Boolean values are primitives (Note: the capitalization):

```python
x = True
y = False
print(x, y)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True False
```

Negate with not:

```python
x = not True
y = not False
print(x, y)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
False True
```

Note "and" and "or" are case-sensitive:

```python
x = True and False
y = False or True
print(x, y)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
False True
```

True and False are actually 1 and 0 but with different keywords:

```python
x = True + True
y = True * 8
z = False - 5
print(x, y, z)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
2 8 -5
```

Comparison operators look at the numerical value of True and False:

```python
x = 0 == False
y = 2 > False
z = 2 == 2
print(x, y, z)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True True True
```

None, 0, and empty strings/lists/dicts/tuples/sets all evaluate to False. All other values are True:

```python
print(bool(0))
print(bool(""))
print(bool([]))
print(bool({}))
print(bool(()))
print(bool(set()))
print(bool(4))
print(bool(-6))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
False
False
False
False
False
False
True
True
```

Using boolean logical operators on ints casts them to booleans for evaluation,
but their non-cast value is returned. Don't mix up with bool(ints) and bitwise
and/or (&,|):

```python
print(bool(0))
print(bool(2))
print(0 and 2)
print(bool(-5))
print(bool(2))
print(-5 or 0)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
False
True
0
True
True
-5
```

Equality is ==:

```python
print(1 == 1)
print(2 == 1)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
print(1 == 1)
print(2 == 1)
```

Inequality is !=:

```python
print(1 != 1)
print(2 != 1)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
False
True
```

More comparisons:

```python
print(1 < 10)
print(1 > 10)
print(2 <= 2)
print(2 >= 2)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True
False
True
True
```

Seeing whether a value is in a range:

```python
print(1 < 2 and 2 < 3)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True
```

Chaining makes this look nicer:

```python
print(1 < 2 < 3)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True
```

(is vs. ==) is checks if two variables refer to the same object, but == checks if the objects pointed to have the same values:

```python
a = [1, 2, 3, 4]  # Point a at a new list, [1, 2, 3, 4]
b = a             # Point b at what a is pointing to
print(b is a)     # => True, a and b refer to the same object
print(b == a)     # => True, a's and b's objects are equal
b = [1, 2, 3, 4]  # Point b at a new list, [1, 2, 3, 4]
print(b is a)     # => False, a and b do not refer to the same object
print(b == a)     # => True, a's and b's objects are equal
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True
True
False
True
```

Strings are created with " or ':

```python
print("This is a string.")
print('This is also a string.')
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
This is a string.
This is also a string.
```

Strings can be added too:

```python
print("Hello " + "world!")
# String literals (but not variables)
# can be concatenated without using '+'.
print("Hello " "world!")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
Hello world!
Hello world!
```

A string can be treated like a list of characters:

```python
print("Hello world!"[0])
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
H
```

You can find the length of a string:

```python
print(len("This is a string"))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
16
```

You can use f-strings or formatted string literals:

```python
name = "Reiko"
print(f"She said her name is {name}.")
# Any valid Python expression inside
# these braces is returned to the string.
print(f"{name} is {len(name)} characters long.")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
She said her name is Reiko.
Reiko is 5 characters long.
```

None is an object:

```python
print(None, type(None))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
None <class 'NoneType'>
```

Don't use the equality "==" symbol to compare objects to None. Use "is" instead. This checks for equality of object identity:

```python
print("etc" is None)
print(None is None)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
False
True
```

## 2. Variables and Collections

As you've seen from the last section, Python has a print function:

```python
print("I'm Python. Nice to meet you!")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
I'm Python. Nice to meet you!
```

By default the print function also prints out a newline at the end.
Use the optional argument end to change the end string:

```python
print("Hello, World", end="!")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
Hello, World!
```

Simple way to get input data from console:

```python
input_string_var = input("Enter some data: ")
print(input_string_var)
```

There are no declarations, only assignments.
Convention in naming variables is snake_case style:

```python
some_var = 5
print(some_var)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
5
```

Accessing a previously unassigned variable is an exception:

```python
print(some_unknown_var)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
Traceback (most recent call last):
  File "/sandbox/main.py", line 1, in <module>
    print(some_unknown_var)
          ^^^^^^^^^^^^^^^^
NameError: name 'some_unknown_var' is not defined (exit status 1)
```

See [Control Flow](#3-control-flow-and-iterables) to learn more about exception handling.

if can be used as an expression, equivalent of C's '?:' ternary operator:

```python
print("yay!" if 0 > 1 else "nay!")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
nay!
```

Lists store sequences. You can start with a prefilled list:

```python
li = []
other_li = [4, 5, 6]
print(li)
print(other_li)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[]
[4, 5, 6]
```

Add stuff to the end of a list with append:

```python
li = []
li.append(1)
li.append(2)
li.append(4)
li.append(3)
print(li)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[1, 2, 4, 3]
```

Remove from the end with pop:

```python
li = [4, 7, 32]
print(li.pop())
print(li)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
32
[4, 7]
```

Access a list like you would any array:

```python
li = [4, 7, 32]
print(li[0])
print(li[-1]) # [-1] gives the last element
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
4
32
```

Looking out of bounds is an IndexError:

```python
li = [4, 7, 32, 8]
print(li[4])
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
Traceback (most recent call last):
  File "/sandbox/main.py", line 2, in <module>
    print(li[4])
          ~~^^^
IndexError: list index out of range (exit status 1)
```

You can look at ranges with slice syntax.
The start index is included, the end index is not
(It's a closed/open range for you mathy types):

```python
li = [100, 200, 300, 400]
print(li[1:3])   # list from index 1 to 3 => [2, 4]
print(li[2:])    # list starting from index 2 => [4, 3]
print(li[:3])    # list from beginning until index 3  => [1, 2, 4]
print(li[::2])   # list selecting elements with a step size of 2 => [1, 4]
print(li[::-1])  # list in reverse order => [3, 4, 2, 1]
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[200, 300]
[300, 400]
[100, 200, 300]
[100, 300]
[400, 300, 200, 100]
```

Make a one layer deep copy using slices:

```python
li = [4, 7, 32, 8]
li2 = li[:]
print(li2)
print(li2 is li)  # False
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[4, 7, 32, 8]
False
```

Remove arbitrary elements from a list with "del":

```python
li = [4, 7, 32, 8]
del li[2]
print(li)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[4, 7, 8]
```

Remove first occurrence of a value:

```python
li = [4, 7, 32, 8]
li.remove(32)
print(li)
# Uncommenting the next line will raise a ValueError
# li.remove(2)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[4, 7, 8]
```

Insert an element at a specific index:

```python
li = [4, 7, 32, 8]
li.insert(1, 2)
print(li)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[4, 2, 7, 32, 8]
```

Get the index of the first item found matching the argument:

```python
li = [4, 7, 32, 8]
print(li.index(7))
# Uncommenting the next line will raise a ValueError
# print(li.index(36))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
1
```

You can add lists (Note: values for li and for other_li are not modified):

```python
li = [4, 7, 32, 8]
other_li = [1, 2, 3, 4]
print(li + other_li)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[4, 7, 32, 8, 1, 2, 3, 4]
```

Concatenate lists with "extend()":

```python
li = [4, 7, 32, 8]
other_li = [1, 2, 3, 4]
li.extend(other_li)
print(li)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[4, 7, 32, 8, 1, 2, 3, 4]
```

Check for existence in a list with "in":

```python
li = [4, 7, 32, 8]
print(1 in li)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
False
```

Examine the length with "len()":

```python
li = [4, 7, 32, 8]
print(len(li))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
4
```

Tuples are like lists but are immutable:

```python
tup = (1, 2, 3)
print(tup[1])
# Uncommenting the next line will raise a TypeError
# tup[1] = 7
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
2
```

Note that a tuple of length one has to have a comma after the last element but
tuples of other lengths, even zero, do not:

```python
print(type((1)))
print(type((1,)))
print(type(()))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
<class 'int'>
<class 'tuple'>
<class 'tuple'>
```

You can do most of the list operations on tuples too:

```python
tup = (1, 2, 3)
print(len(tup))
print(tup + (4, 5, 6))
print(tup[:2])
print(2 in tup)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
3
(1, 2, 3, 4, 5, 6)
(1, 2)
True
```

You can unpack tuples (or lists) into variables:

```python
a, b, c = (1, 2, 3)
print(a, b, c)

# Extended unpacking.
a, *b, c = (1, 2, 3, 4)
print(a, b, c)

# Tuples are created by default if you leave out the parentheses.
d, e, f = 4, 5, 6
print(d, e, f)

# Tuple 4, 5, 6 is unpacked into variables d, e and f
# respectively such that d = 4, e = 5 and f = 6
# Now look how easy it is to swap two values:
e, d = d, e
print(d, e)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
1 2 3
1 [2, 3] 4
4 5 6
5 4
```

Dictionaries store mappings from keys to values:

```python
empty_dict = {}
filled_dict = {"one": 1, "two": 2, "three": 3}
print(empty_dict)
print(filled_dict)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{}
{'one': 1, 'two': 2, 'three': 3}
```

Note keys for dictionaries have to be immutable types. This is to ensure that
the key can be converted to a constant hash value for quick look-ups.
Immutable types include ints, floats, strings, tuples:

```python
valid_dict = {(1, 2, 3): "123"}
print(valid_dict)
# Uncommenting the next line will raise a TypeError
# invalid_dict = {[1, 2, 3]: "123"}
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{(1, 2, 3): "123"}
```

Look up values with []:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
print(filled_dict["one"])
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
1
```

Get all keys as an iterable with "keys()". We need to wrap the call in list()
to turn it into a list. Dictionary items maintain the order at which they are
inserted into the dictionary:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
print(list(filled_dict.keys()))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
['one', 'two', 'three']
```

Get all values as an iterable with "values()". Once again we need to wrap it
in list() to get it out of the iterable:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
print(list(filled_dict.values()))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[1, 2, 3]
```

Check for existence of keys in a dictionary with "in":

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
print("one" in filled_dict)
print(1 in filled_dict)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True
False
```

Looking up a non-existing key is a KeyError:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
print(filled_dict["four"])
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
Traceback (most recent call last):
  File "/sandbox/main.py", line 2, in <module>
    print(filled_dict["four"])
          ~~~~~~~~~~~^^^^^^^^
KeyError: 'four' (exit status 1)
```

Use "get()" method to avoid the KeyError:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
print(filled_dict.get("one"))
print(filled_dict.get("four"))
print(filled_dict.get("one", 4))
print(filled_dict.get("four", 4))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
1
None
1
4
```

"setdefault()" inserts into a dictionary only if the given key isn't present:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
print(filled_dict.setdefault("five", 5))
print(filled_dict.setdefault("five", 6))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
5
5
```

Adding to a dictionary:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
filled_dict.update({"four":4})
print(filled_dict)
filled_dict["four"] = 4
print(filled_dict)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{'one': 1, 'two': 2, 'three': 3, 'four': 4}
{'one': 1, 'two': 2, 'three': 3, 'four': 4}
```

Remove keys from a dictionary with del:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
del filled_dict["one"]
print(filled_dict)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{'two': 2, 'three': 3}
```

You can also use the additional unpacking options:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
print({"a": 1, **{"b": 2}})
print({"a": 1, **{"a": 2}})
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{'a': 1, 'b': 2}
{'a': 2}
```

Sets store ... well sets (collections of unique elements):

```python
empty_set = set()
some_set = {1, 1, 2, 2, 3, 4}
print(empty_set)
print(some_set)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
set()
{1, 2, 3, 4}
```

Similar to keys of a dictionary, elements of a set have to be immutable:

```python
valid_set = {(1,), 1}
print(valid_set)
# Uncommenting the next line will raise a TypeError
# invalid_set = {[1], 1}
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{(1,), 1}
```

Add one more item to the set:

```python
filled_set = {1, 1, 2, 2, 3, 4}
filled_set.add(5)
print(filled_set)
filled_set.add(5)
print(filled_set)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{1, 2, 3, 4, 5}
{1, 2, 3, 4, 5}
```

Do set intersection with &:

```python
filled_set = {1, 1, 2, 2, 3, 4}
other_set = {3, 4, 5, 6}
print(filled_set & other_set)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{3, 4}
```

Do set union with |:

```python
filled_set = {1, 1, 2, 2, 3, 4}
other_set = {3, 4, 5, 6}
print(filled_set | other_set)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{1, 2, 3, 4, 5, 6}
```

Do set difference with -:

```python
print({1, 2, 3, 4} - {2, 3, 5})
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{1, 4}
```

Do set symmetric difference with ^:

```python
print({1, 2, 3, 4} ^ {2, 3, 5})
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{1, 4, 5}
```

Check if set on the left is a superset of set on the right:

```python
print({1, 2} >= {1, 2, 3})
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
False
```

Check if set on the left is a subset of set on the right:

```python
print({1, 2} <= {1, 2, 3})
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True
```

Check for existence in a set with in:

```python
filled_set = {1, 1, 2, 2, 3, 4}
print(2 in filled_set)
print(10 in filled_set)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True
False
```

Make a one layer deep copy:

```python
some_set = {1, 1, 2, 2, 3, 4}
filled_set = some_set.copy()
print(filled_set)
print(filled_set is some_set)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{1, 2, 3, 4}
False
```

## 3. Control Flow and Iterables

Here is an if statement. Indentation is significant in Python!
Convention is to use four spaces, not tabs.
This prints "some_var is smaller than 10":

```python
some_var = 5
if some_var > 10:
    print("some_var is totally bigger than 10")
elif some_var < 10:
    print("some_var is smaller than 10")
else:
    print("some_var is indeed 10")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
some_var is smaller than 10
```

For loops iterate over lists:

```python
for animal in ["dog", "cat", "mouse"]:
    print(f"{animal} is a mammal")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
dog is a mammal
cat is a mammal
mouse is a mammal
```

"range(number)" returns an iterable of numbers
from zero up to (but excluding) the given number:

```python
for i in range(4):
    print(i)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
0
1
2
3
```

"range(lower, upper)" returns an iterable of numbers
from the lower number to the upper number:

```python
for i in range(4, 8):
    print(i)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
4
5
6
7
```

"range(lower, upper, step)" returns an iterable of numbers
from the lower number to the upper number, while incrementing
by step. If step is not indicated, the default value is 1:

```python
for i in range(4, 8, 2):
    print(i)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
4
6
```

Loop over a list to retrieve both the index and the value of each list item:

```python
animals = ["dog", "cat", "mouse"]
for i, value in enumerate(animals):
    print(i, value)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
0 dog
1 cat
2 mouse
```

While loops go until a condition is no longer met:

```python
x = 0
while x < 4:
    print(x)
    x += 1
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
0
1
2
3
```

Handle exceptions with a try/except block:

```python
try:
    # Use "raise" to raise an error
    raise IndexError("This is an index error")
except IndexError as e:
    # Refrain from this, provide a recovery (next example).
    pass
except (TypeError, NameError):
    # Multiple exceptions can be processed jointly.
    pass
else:
    # Optional clause to the try/except block.
    # Must follow all except blocks.
    # Runs only if the code in try raises no exceptions.
    print("All good!")
finally:
    # Execute under all circumstances.
    print("We can clean up resources here")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
We can clean up resources here
```

Instead of try/finally to cleanup resources you can use a with statement:

```python
with open("/etc/hosts") as f:
    for line in f:
        print(line, end="")
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
```

Writing to a file:

```python
contents = {"aa": 12, "bb": 21}
with open("/tmp/myfile1.txt", "w") as file:
    # Writes a string to a file.
    file.write(str(contents))

import json
with open("/tmp/myfile2.txt", "w") as file:
    # Writes an object to a file.
    file.write(json.dumps(contents))
```

<codapi-snippet id="s3-write-file" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

Reading from a file:

```python
with open("/tmp/myfile1.txt") as file:
    # Reads a string from a file.
    contents = file.read()
print(contents)

import json
with open("/tmp/myfile2.txt", "r") as file:
    # Reads a json object from a file.
    contents = json.load(file)
print(contents)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s3-write-file" output>
</codapi-snippet>

```text
{'aa': 12, 'bb': 21}
{'aa': 12, 'bb': 21}
```

Python offers a fundamental abstraction called the Iterable.
An iterable is an object that can be treated as a sequence:

```python
filled_dict = {"one": 1, "two": 2, "three": 3}
our_iterable = filled_dict.keys()
```

<codapi-snippet id="s3-iterable" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

The object returned by the range function, is an iterable.

We can loop over it:

```python
for i in our_iterable:
    print(i)

# However we cannot address elements by index.
# our_iterable[1]  # Raises a TypeError
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s3-iterable" output>
</codapi-snippet>

```text
one
two
three
```

An iterable is an object that knows how to create an iterator:

```python
our_iterator = iter(our_iterable)

# Our iterator is an object that can remember the state
# as we traverse through it. We get the next object with "next()".
print(next(our_iterator))

# It maintains state as we iterate.
print(next(our_iterator))
print(next(our_iterator))

# After the iterator has returned all of its data,
# it raises a StopIteration exception.
# print(next(our_iterator))
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s3-iterable" output>
</codapi-snippet>

```text
one
two
three
```

We can also loop over an iterator. In fact, "for" does this implicitly:

```python
our_iterator = iter(our_iterable)
for i in our_iterator:
    print(i)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s3-iterable" output>
</codapi-snippet>

```text
one
two
three
```

You can grab all the elements of an iterable or iterator by call of list():

```python
print(list(our_iterable))
our_iterator = iter(our_iterable)
print(list(our_iterator))
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s3-iterable" output>
</codapi-snippet>

```text
['one', 'two', 'three']
['one', 'two', 'three']
```

## 4. Functions

Use "def" to create new functions:

```python
def add(x, y):
    print(f"x is {x} and y is {y}")
    return x + y
```

<codapi-snippet id="s4-add" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

Calling functions with parameters:

```python
add(5, 6)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s4-add" output>
</codapi-snippet>

```text
x is 5 and y is 6
```

Another way to call functions is with keyword arguments. They can arrive in any order:

```python
add(y=6, x=5)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s4-add" output>
</codapi-snippet>

```text
x is 5 and y is 6
```

You can define functions that take a variable number of positional arguments:

```python
def varargs(*args):
    return args

print(varargs(1, 2, 3))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
(1, 2, 3)
```

You can define functions that take a variable number of keyword arguments:

```python
def keyword_args(**kwargs):
    return kwargs

print(keyword_args(big="foot", loch="ness"))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{'big': 'foot', 'loch': 'ness'}
```

You can do both at once, if you like:

```python
def all_the_args(*args, **kwargs):
    print(args)
    print(kwargs)

all_the_args(1, 2, a=3, b=4)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
(1, 2)
{'a': 3, 'b': 4}
```

When calling functions, you can do the opposite of args/kwargs.
Use \* to expand args (tuples) and use \*\* to expand kwargs (dictionaries):

```python
def all_the_args(*args, **kwargs):
    print(args)
    print(kwargs)

args = (1, 2, 3, 4)
kwargs = {"a": 3, "b": 4}
all_the_args(*args)            # same as all_the_args(1, 2, 3, 4)
all_the_args(**kwargs)         # same as all_the_args(a=3, b=4)
all_the_args(*args, **kwargs)  # same as all_the_args(1, 2, 3, 4, a=3, b=4)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
(1, 2, 3, 4)
{}
()
{'a': 3, 'b': 4}
(1, 2, 3, 4)
{'a': 3, 'b': 4}
```

Returning multiple values (with tuple assignments):

```python
def swap(x, y):
    return y, x

x = 1
y = 2
x, y = swap(x, y)  # same as (x, y) = swap(x,y)
print(x, y)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
2 1
```

Global scope:

```python
x = 5

def set_x(num):
    # local scope begins here
    # local var x not the same as global var x
    x = num
    print(x)

def set_global_x(num):
    # global indicates that particular var lives in the global scope
    global x
    print(x)
    x = num  # global var x is now set to 6
    print(x)

set_x(43)
set_global_x(6)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
43
5
6
```

Python has first class functions:

```python
def create_adder(x):
    def adder(y):
        return x + y
    return adder

add_10 = create_adder(10)
print(add_10(3))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
13
```

Closures in nested functions.
We can use the nonlocal keyword to work with variables in nested scope
which shouldn't be declared in the inner functions:

```python
def create_avg():
    total = 0
    count = 0
    def avg(n):
        nonlocal total, count
        total += n
        count += 1
        return total/count
    return avg

avg = create_avg()
print(avg(3))
print(avg(5))
print(avg(7))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
3.0
4.0
5.0
```

There are also anonymous functions:

```python
print((lambda x: x > 2)(3))
print((lambda x, y: x ** 2 + y ** 2)(2, 1))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
True
5
```

There are built-in higher order functions "map" and "filter":

```python
def add_10(x):
    return x + 10

print(list(map(add_10, [1, 2, 3])))
print(list(map(max, [1, 2, 3], [4, 2, 1])))
print(list(filter(lambda x: x > 5, [3, 4, 5, 6, 7])))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[11, 12, 13]
[4, 2, 3]
[6, 7]
```

We can use list comprehensions for nice maps and filters.
List comprehension stores the output as a list (which itself may be nested):

```python
def add_10(x):
    return x + 10

print([add_10(i) for i in [1, 2, 3]])
print([x for x in [3, 4, 5, 6, 7] if x > 5])
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[11, 12, 13]
[6, 7]
```

You can construct set and dict comprehensions as well:

```python
print({x for x in "abcddeef" if x not in "abc"})
print({x: x**2 for x in range(5)})
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
{'d', 'f', 'e'}
{0: 0, 1: 1, 2: 4, 3: 9, 4: 16}
```

## 5. Modules

You can import modules:

```python
import math
print(math.sqrt(16))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
4.0
```

You can get specific functions from a module:

```python
from math import ceil, floor
print(ceil(3.7))
print(floor(3.7))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
4
3
```

You can import all functions from a module (not recommended):

```python
from math import *
print(sqrt(16))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
4.0
```

You can shorten module names:

```python
import math as m
print(m.sqrt(16))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
4.0
```

Python modules are just ordinary Python files. You
can write your own, and import them. The name of the
module is the same as the name of the file.

You can find out which functions and attributes
are defined in a module:

```python
import math
print(dir(math))
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
['__doc__', '__file__', '__loader__', '__name__', '__package__', '__spec__', 'acos', 'acosh', 'asin', 'asinh', 'atan', 'atan2', 'atanh', 'cbrt', 'ceil', 'comb', 'copysign', 'cos', 'cosh', 'degrees', 'dist', 'e', 'erf', 'erfc', 'exp', 'exp2', 'expm1', 'fabs', 'factorial', 'floor', 'fmod', 'frexp', 'fsum', 'gamma', 'gcd', 'hypot', 'inf', 'isclose', 'isfinite', 'isinf', 'isnan', 'isqrt', 'lcm', 'ldexp', 'lgamma', 'log', 'log10', 'log1p', 'log2', 'modf', 'nan', 'nextafter', 'perm', 'pi', 'pow', 'prod', 'radians', 'remainder', 'sin', 'sinh', 'sqrt', 'sumprod', 'tan', 'tanh', 'tau', 'trunc', 'ulp']
```

If you have a Python script named math.py in the same
folder as your current script, the file math.py will
be loaded instead of the built-in Python module.
This happens because the local folder has priority
over Python's built-in libraries.

## 6. Classes

We use the "class" statement to create a class:

```python
class Human:

    # A class attribute. It is shared by all instances of this class
    species = "H. sapiens"

    # Basic initializer, this is called when this class is instantiated.
    # Methods with double underscores (__init__, __str__, __repr__ etc.)
    # are called special methods (or sometimes called dunder
    # methods). You should not invent such names on your own.
    def __init__(self, name):
        # Assign the argument to the instance's name attribute
        self.name = name

        # Initialize property
        self._age = 0
        # The leading underscore indicates the "age" property is private.
        # Do not rely on this to be enforced: it's a hint to other devs.

    # An instance method. All methods take "self" as the first argument
    def say(self, msg):
        print("{name}: {message}".format(name=self.name, message=msg))

    # Another instance method
    def sing(self):
        return "yo... yo... microphone check... one two... one two..."

    # A class method is shared among all instances
    # They are called with the calling class as the first argument
    @classmethod
    def get_species(cls):
        return cls.species

    # A static method is called without a class or instance reference
    @staticmethod
    def grunt():
        return "*grunt*"

    # A property is just like a getter.
    # It turns the method age() into a read-only attribute of the same name.
    # There's no need to write trivial getters and setters in Python, though.
    @property
    def age(self):
        return self._age

    # This allows the property to be set
    @age.setter
    def age(self, age):
        self._age = age

    # This allows the property to be deleted
    @age.deleter
    def age(self):
        del self._age
```

<codapi-snippet id="s6-class" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

When a Python interpreter reads a source file it executes all its code.
This \_\_name\_\_ check makes sure this code block is only executed when this
module is the main program:

```python
if __name__ == "__main__":
    # Instantiate a class
    inga = Human(name="Inga")
    inga.say("hi")
    joel = Human("Joel")
    joel.say("hello")
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-class" output>
</codapi-snippet>

```text
Inga: hi
Joel: hello
```

```python
# inga and joel are instances of type Human;
# i.e., they are Human objects.
inga = Human(name="Inga")
joel = Human("Joel")
```

<codapi-snippet id="s6-objects" sandbox="python" editor="basic" depends-on="s6-class" output>
</codapi-snippet>

```text
ok
```

Call our class method:

```python
inga.say(inga.get_species())
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-objects" output>
</codapi-snippet>

```text
Inga: H. sapiens
```

Change the shared attribute:

```python
Human.species = "H. neanderthalensis"
inga.say(inga.get_species())
joel.say(joel.get_species())
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-objects" output>
</codapi-snippet>

```text
Inga: H. neanderthalensis
Joel: H. neanderthalensis
```

Call the static method:

```python
print(Human.grunt())
# Static methods can be called by instances too.
print(inga.grunt())
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-objects" output>
</codapi-snippet>

```text
*grunt*
*grunt*
```

Work with properties:

```python
# Update the property for this instance.
inga.age = 42

# Get the property
inga.say(inga.age)
joel.say(joel.age)

# Delete the property
del inga.age
# inga.age    # this would raise an AttributeError
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-objects" output>
</codapi-snippet>

```text
Inga: 42
Joel: 0
```

### 6.1 Inheritance

Inheritance allows new child classes to be defined that inherit methods and
variables from their parent class.

Using the Animal class as the base or parent class, we can
define a child class, Dog, which inherits variables like "name",
as well as methods like "speak" from the Animal class,
but can also have its own unique properties.

```python
class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        return f"{self.name} makes a sound."

class Dog(Animal):
    # Children automatically inherit their parent class's
    # constructor, but can also define their own.
    # This constructor adds the "barks" argument:
    def __init__(self, name, barks=True):
        self.barks = barks
        # Use "super" to access the parent class's methods.
        super().__init__(name)

    def speak(self):
        if self.barks:
            return f"{self.name} barks!"
        return super().speak()
```

<codapi-snippet id="s6-animal" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

```python
dog = Dog("Buddy")
print(dog.speak())

dog = Dog("Weirdo", barks=False)
print(dog.speak())
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-animal" output>
</codapi-snippet>

```text
Buddy barks!
Weirdo makes a sound.
```

### 6.2 Multiple Inheritance

You can inherit from multiple classes. For example, use Superhero and Bat as bases for Batman:

```python
class Superhero:
    species = "Superhuman"

    def __init__(self, name, movie=False, superpowers=None):
        self.name = name
        self.movie = movie
        self.superpowers = superpowers or ["super strength", "bulletproofing"]

    def say(self, msg):
        print(f"{self.name}: {msg}")

    def get_species(self):
        return self.species

    def sing(self):
        return "Dun, dun, DUN!"
```

<codapi-snippet id="s6-superhuman" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

```python
class Bat:
    species = "Baty"

    def __init__(self, can_fly=True):
        self.fly = can_fly

    # Bat also has a say method
    def say(self, msg):
        msg = "... ... ..."
        return msg

    # And its own method as well
    def sonar(self):
        return "))) ... ((("
```

<codapi-snippet id="s6-bat" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

Define Batman as a child that inherits from both Superhero and Bat:

```python
class Batman(Superhero, Bat):
    species = "Human"

    def __init__(self, *args, **kwargs):
        # Typically to inherit attributes you have to call super:
        # super(Batman, self).__init__(*args, **kwargs).

        # However we are dealing with multiple inheritance here, and super()
        # only works with the next base class in the MRO list.

        # So instead we explicitly call __init__ for all ancestors.
        # The use of *args and **kwargs allows for a clean way to pass
        # arguments, with each parent "peeling a layer of the onion".
        Superhero.__init__(self, "anonymous", movie=True,
                           superpowers=["Wealthy"], *args, **kwargs)
        Bat.__init__(self, *args, can_fly=False, **kwargs)

        # override the value for the name attribute
        self.name = "Sad Affleck"

    def sing(self):
        return "nan nan nan nan nan batman!"
```

<codapi-snippet id="s6-batman" sandbox="python" editor="basic" depends-on="s6-superhuman s6-bat" output>
</codapi-snippet>

```text
ok
```

The Method Resolution Order:

```python
sup = Batman()
print(Batman.__mro__)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-batman" output>
</codapi-snippet>

```text
(<class '__main__.Batman'>, <class '__main__.Superhero'>, <class '__main__.Bat'>, <class 'object'>)
```

Calls parent method (get_species) but uses its own class attribute (species):

```python
sup = Batman()
print(sup.get_species())
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-batman" output>
</codapi-snippet>

```text
Human
```

Calls overridden method:

```python
sup = Batman()
print(sup.sing())
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-batman" output>
</codapi-snippet>

```text
nan nan nan nan nan batman!
```

Calls method from the 1st ancestor (Human), because inheritance order matters:

```python
sup = Batman()
sup.say("I agree")
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-batman" output>
</codapi-snippet>

```text
Sad Affleck: I agree
```

Call method that exists only in 2nd ancestor (Bat):

```python
sup = Batman()
print(sup.sonar())
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-batman" output>
</codapi-snippet>

```text
))) ... (((
```

Inherited class attribute:

```python
sup = Batman()
sup.age = 100
print(sup.age)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-batman" output>
</codapi-snippet>

```text
100
```

Inherited attribute from 2nd ancestor (Bat) whose default value was overridden:

```python
sup = Batman()
print(f"Can I fly? {sup.fly}")
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s6-batman" output>
</codapi-snippet>

```text
Can I fly? False
```

## 7. Generators and Decorators

A **generator** in Python is a special type of iterator that allows you to iterate over a sequence of values without storing the entire sequence in memory. Generators are created using functions and the "yield" keyword.

Generators help you make lazy code:

```python
def double_numbers(iterable):
    for i in iterable:
        yield i + i
```

<codapi-snippet id="s7-generator" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

Generators are memory-efficient because they only load the data needed to
process the next value in the iterable. This allows them to perform
operations on otherwise prohibitively large value ranges:

```python
for i in double_numbers(range(1, 900000000)):
    print(i)
    if i >= 10:
        break
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s7-generator" output>
</codapi-snippet>

```text
2
4
6
8
10
```

Just as you can create a list comprehension, you can create generator comprehensions as well:

```python
values = (-x for x in [1, 2, 3, 4, 5])
for x in values:
    print(x)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
-1
-2
-3
-4
-5
```

You can also cast a generator comprehension directly to a list:

```python
values = (-x for x in [1, 2, 3, 4, 5])
gen_to_list = list(values)
print(gen_to_list)
```

<codapi-snippet sandbox="python" editor="basic" output>
</codapi-snippet>

```text
[-1, -2, -3, -4, -5]
```

A **decorator** in Python is a design pattern that allows you to modify or extend the behavior of a function or method without changing its actual code.

Decorators are a form of syntactic sugar:

```python
def log_function(func):
    def wrapper(*args, **kwargs):
        print(f"Entering function {func.__name__}")
        result = func(*args, **kwargs)
        print(f"Exiting function {func.__name__}")
        return result
    return wrapper

@log_function
def my_function(x, y):
    """Sums two arguments and returns the result."""
    return x+y
```

<codapi-snippet id="s7-decorator-1" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

The decorator @log_function tells us as we begin reading the function definition
for my_function that this function will be wrapped with log_function
(similar to my_function = log_function(my_function)).

Calling my_function now calls the wrapped function:

```python
my_function(1, 2)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s7-decorator-1" output>
</codapi-snippet>

```text
Entering function my_function
Exiting function my_function
```

But there's a problem. What happens if we try to get some information about my_function?

```python
print(my_function.__name__)
print(my_function.__doc__)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s7-decorator-1" output>
</codapi-snippet>

```text
wrapper
None
```

We've replaced information about my_function with information from wrapper. The name and the docstring are lost.

Fix this using functools:

```python
from functools import wraps

def log_function(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print("Entering function", func.__name__)
        result = func(*args, **kwargs)
        print("Exiting function", func.__name__)
        return result
    return wrapper

@log_function
def my_function(x, y):
    """Sums two arguments and returns the result."""
    return x+y
```

<codapi-snippet id="s7-decorator-2" sandbox="python" editor="basic" output>
</codapi-snippet>

```text
ok
```

The @wraps decorator ensures that docstring, function name and some other attributes are copied
to the wrapped function - instead of being replaced with wrapper's info:

```python
print(my_function.__name__)
print(my_function.__doc__)
```

<codapi-snippet sandbox="python" editor="basic" depends-on="s7-decorator-2" output>
</codapi-snippet>

```text
my_function
Sums two arguments and returns the result.
```

## Further Reading

-   [Official Docs](https://docs.python.org/3/)
-   [Official Style Guide for Python](https://peps.python.org/pep-0008/)
-   [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/#toc)
-   [Hitchhiker's Guide to Python](https://docs.python-guide.org/)
-   [Python Course](https://www.python-course.eu)
-   [First Steps With Python](https://realpython.com/learn/python-first-steps/)
-   [Python Exercises](https://cscircles.cemc.uwaterloo.ca/)
-   [Build a Desktop App with Python](https://pythonpyqt.com/)
-   [Curated list of Python stuff](https://github.com/vinta/awesome-python)
