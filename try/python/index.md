---
x: date
title: Try `date` in Y minutes
image: /try/cover.png
lastmod: 2024-02-16
license: CC BY-SA 4.0
contributors:
    - ["molekh-xyz", "http://github.com/molekh-xyz"]
    - ["Louie Dinh", "http://pythonpracticeprojects.com"]
    - ["Zachary Ferguson", "http://github.com/zfergus2"]
    - ["evuez", "http://github.com/evuez"]
    - ["Rommel Martinez", "https://ebzzry.io"]
    - ["Roberto Fernandez Diaz", "https://github.com/robertofd1995"]
    - ["caminsha", "https://github.com/caminsha"]
    - ["Stanislav Modrak", "https://stanislav.gq"]
    - ["John Paul Wohlscheid", "https://gitpi.us"]
---
---
name: Python
adapted from the version on [[learnxinyminutes]] by:
- ["Louie Dinh", "http://pythonpracticeprojects.com"]
- ["Steven Basart", "http://github.com/xksteven"]
- ["Andre Polykanine", "https://github.com/Oire"]
- ["Zachary Ferguson", "http://github.com/zfergus2"]
- ["evuez", "http://github.com/evuez"]
- ["Rommel Martinez", "https://ebzzry.io"]
- ["Roberto Fernandez Diaz", "https://github.com/robertofd1995"]
- ["caminsha", "https://github.com/caminsha"]
- ["Stanislav Modrak", "https://stanislav.gq"]
- ["John Paul Wohlscheid", "https://gitpi.us"]
edited and made interactive by [molekh-xyz](https://molekh.xyz)

---
Python was created by Guido van Rossum in the early 90s. It is now one of the
most popular languages in existence. I fell in love with Python for its
syntactic clarity. It's basically executable pseudocode.

### There are two ways to make comments
<pre><code>
# Single line comments start with a number symbol.

""" 
Multiline strings can be written
using three "s, and are often used
as documentation.
"""
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

# 1. Primitive Datatypes and Operators

### You have numbers
<pre><code>
print(3)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Math operates as you'd expect
<pre><code>
a = 1 + 1
b = 2 - 1
c = 4 / 2
d = 3 * 2
print(a, b, c, d)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Floor division rounds towards negative infinity
<pre><code>
a = 5 // 3     
b = -5 // 3    
c = 5.0 // 3.0
d = -5.0 // 3.0 
print(a, b, c, d)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### The result of division is always a float
<pre><code>
x = 10.0 / 3 
print(x)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Modulo operation
<pre><code>
x = 7 % 3 
print(x)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Exponentiation (x**y, x to the yth power)
<pre><code>
x = 2**3
print(x)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Enforce precedence with parentheses
<pre><code>
x = 1 + 3 * 2 
y = (1 + 3) * 2
print(x, y)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Boolean values are primitives (Note: the capitalization)
<pre><code>
x = True
y = False
print(x, y)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Negate with not
<pre><code>
x = not True
y = not False
print(x, y)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Note "and" and "or" are case-sensitive
<pre><code>
x = True and False
y = False or True 
print(x, y)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### True and False are actually 1 and 0 but with different keywords
<pre><code>
x = True + True
y = True * 8   
z = False - 5  
print(x, y, z)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Comparison operators look at the numerical value of True and False
<pre><code>
x = 0 == False
y = 2 > False  
z = 2 == 2
print(x, y, z)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

None, 0, and empty strings/lists/dicts/tuples/sets all evaluate to False.

### All other values are True
<pre><code>
print(bool(0))
print(bool(""))
print(bool([]))
print(bool({}))
print(bool(()))
print(bool(set()))
print(bool(4))
print(bool(-6))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Using boolean logical operators on ints casts them to booleans for evaluation, but their non-cast value is returned
<pre><code>
print(bool(0))
print(bool(2))
print(0 and 2)
print(bool(-5))
print(bool(2))
print(-5 or 0)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Equality is ==
<pre><code>
print(1 == 1)
print(2 == 1)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Inequality is !=
<pre><code>
print(1 != 1)
print(2 != 1)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### More comparisons
<pre><code>
print(1 < 10)
print(1 > 10)
print(2 <= 2)
print(2 >= 2)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Seeing whether a value is in a range
<pre><code>
print(1 < 2 and 2 < 3)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Chaining makes this look nicer
<pre><code>
print(1 < 2 < 3)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### (is vs. ==) is checks if two variables refer to the same object, but == checks if the objects pointed to have the same values
<pre><code>
a = [1, 2, 3, 4]
b = a
print(b is a)
print(b == a)
b = [1, 2, 3, 4]
print(b is a)
print(b == a)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Strings are created with " or '
<pre><code>
print("This is a string.")
print('This is also a string.')
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Strings can be added too
<pre><code>
print("Hello " + "world!")
print("Hello " "world!")
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### A string can be treated like a list of characters
<pre><code>
print("Hello world!"[0])
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can find the length of a string
<pre><code>
print(len("This is a string"))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Since Python 3.6, you can use f-strings or formatted string literals
<pre><code>
name = "Reiko"
print(f"She said her name is {name}.")
print(f"{name} is {len(name)} characters long.")
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### None is an object
<pre><code>
print(None)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Don't use the equality "==" symbol to compare objects to None
<pre><code>
print("etc" is None)
print(None is None)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

# 2. Variables and Collections

### As you've seen from the last section, Python has a print function
<pre><code>
print("I'm Python. Nice to meet you!")
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### By default the print function also prints out a newline at the end
<pre><code>
print("Hello, World", end="!")
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Simple way to get input data from console
<pre><code>
# input_string_var = input("Enter some data: ")
# print(input_string_var)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### There are no declarations, only assignments
<pre><code>
some_var = 5
print(some_var)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Accessing a previously unassigned variable is an exception
<pre><code>
# Uncommenting the next line will raise a NameError
# print(some_unknown_var)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### if can be used as an expression
<pre><code>
print("yay!" if 0 > 1 else "nay!")
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Lists store sequences
<pre><code>
li = []
other_li = [4, 5, 6]
print(li)
print(other_li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Add stuff to the end of a list with append
<pre><code>
li = []
li.append(1)
li.append(2)
li.append(4)
li.append(3)
print(li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Remove from the end with pop
<pre><code>
li = [4, 7, 32]
print(li.pop())
print(li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Access a list like you would any array
<pre><code>
li = [4, 7, 32]
print(li[0])
print(li[-1]) # [-1] will give you the last value in a list
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Looking out of bounds is an IndexError
<pre><code>
li = [4, 7, 32, 8]
# Uncommenting the next line will raise an IndexError
# print(li[4])
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can look at ranges with slice syntax
<pre><code>
li = [100, 200, 300, 400]
print(li[1:3])
print(li[2:])
print(li[:3])
print(li[::2]) # Return list selecting elements with a step size of 2
print(li[::-1]) # Return list in reverse order
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Make a one layer deep copy using slices
<pre><code>
li = [4, 7, 32, 8]
li2 = li[:]
print(li2)
print(li2 is li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Remove arbitrary elements from a list with "del"
<pre><code>
li = [4, 7, 32, 8]
del li[2]
print(li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Remove first occurrence of a value
<pre><code>
li = [4, 7, 32, 8]
li.remove(2)
print(li)
# Uncommenting the next line will raise a ValueError
# li.remove(2)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Insert an element at a specific index
<pre><code>
li = [4, 7, 32, 8]
li.insert(1, 2)
print(li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Get the index of the first item found matching the argument
<pre><code>
li = [4, 7, 32, 8]
print(li.index(7))
# Uncommenting the next line will raise a ValueError
# print(li.index(36))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can add lists
<pre><code>
li = [4, 7, 32, 8]
other_li = [1, 2, 3, 4]
print(li + other_li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Concatenate lists with "extend()"
<pre><code>
li = [4, 7, 32, 8]
other_li = [1, 2, 3, 4]
li.extend(other_li)
print(li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Check for existence in a list with "in"
<pre><code>
li = [4, 7, 32, 8]
print(1 in li)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Examine the length with "len()"
<pre><code>
li = [4, 7, 32, 8]
print(len(li))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Tuples are like lists but are immutable
<pre><code>
tup = (1, 2, 3)
print(tup[0])
# Uncommenting the next line will raise a TypeError
# tup[0] = 3
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Note that a tuple of length one has to have a comma after the last element
<pre><code>
print(type((1)))
print(type((1,)))
print(type(()))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can do most of the list operations on tuples too
<pre><code>
tup = (1, 2, 3)
print(len(tup))
print(tup + (4, 5, 6))
print(tup[:2])
print(2 in tup)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can unpack tuples (or lists) into variables
<pre><code>
a, b, c = (1, 2, 3)
print(a, b, c)
a, *b, c = (1, 2, 3, 4)
print(a, b, c)
d, e, f = 4, 5, 6
print(d, e, f)
e, d = d, e
print(d, e)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Dictionaries store mappings from keys to values
<pre><code>
empty_dict = {}
filled_dict = {"one": 1, "two": 2, "three": 3}
print(empty_dict)
print(filled_dict)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Note keys for dictionaries have to be immutable types
<pre><code>
# Uncommenting the next line will raise a TypeError
# invalid_dict = {[1,2,3]: "123"}
valid_dict = {(1,2,3):[1,2,3]}
print(valid_dict)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Look up values with []
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
print(filled_dict["one"])
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Get all keys as an iterable with "keys()"
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
print(list(filled_dict.keys()))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Get all values as an iterable with "values()"
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
print(list(filled_dict.values()))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Check for existence of keys in a dictionary with "in"
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
print("one" in filled_dict)
print(1 in filled_dict)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Looking up a non-existing key is a KeyError
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
# Uncommenting the next line will raise a KeyError
# print(filled_dict["four"])
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Use "get()" method to avoid the KeyError
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
print(filled_dict.get("one"))
print(filled_dict.get("four"))
print(filled_dict.get("one", 4))
print(filled_dict.get("four", 4))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### "setdefault()" inserts into a dictionary only if the given key isn't present
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
print(filled_dict.setdefault("five", 5))
print(filled_dict.setdefault("five", 6))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Adding to a dictionary
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
filled_dict.update({"four":4})
print(filled_dict)
filled_dict["four"] = 4
print(filled_dict)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Remove keys from a dictionary with del
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
del filled_dict["one"]
print(filled_dict)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### From Python 3.5 you can also use the additional unpacking options
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
print({"a": 1, **{"b": 2}})
print({"a": 1, **{"a": 2}})
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Sets store ... well sets
<pre><code>
empty_set = set()
some_set = {1, 1, 2, 2, 3, 4}
print(empty_set)
print(some_set)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Similar to keys of a dictionary, elements of a set have to be immutable
<pre><code>
# Uncommenting the next line will raise a TypeError
# invalid_set = {[1], 1}
valid_set = {(1,), 1}
print(valid_set)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Add one more item to the set
<pre><code>
filled_set = {1, 1, 2, 2, 3, 4}
filled_set.add(5)
print(filled_set)
filled_set.add(5)
print(filled_set)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Do set intersection with &
<pre><code>
filled_set = {1, 1, 2, 2, 3, 4}
other_set = {3, 4, 5, 6}
print(filled_set & other_set)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Do set union with |
<pre><code>
filled_set = {1, 1, 2, 2, 3, 4}
other_set = {3, 4, 5, 6}
print(filled_set | other_set)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Do set difference with -
<pre><code>
print({1, 2, 3, 4} - {2, 3, 5})
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Do set symmetric difference with ^
<pre><code>
print({1, 2, 3, 4} ^ {2, 3, 5})
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Check if set on the left is a superset of set on the right
<pre><code>
print({1, 2} >= {1, 2, 3})
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Check if set on the left is a subset of set on the right
<pre><code>
print({1, 2} <= {1, 2, 3})
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Check for existence in a set with in
<pre><code>
filled_set = {1, 1, 2, 2, 3, 4}
print(2 in filled_set)
print(10 in filled_set)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Make a one layer deep copy
<pre><code>
some_set = {1, 1, 2, 2, 3, 4}
filled_set = some_set.copy()
print(filled_set)
print(filled_set is some_set)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

# 3. Control Flow and Iterables

### Let's just make a variable
<pre><code>
some_var = 5
print(some_var)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Here is an if statement. Indentation is significant in Python!
<pre><code>
some_var = 5
if some_var > 10:
    print("some_var is totally bigger than 10.")
elif some_var < 10:
    print("some_var is smaller than 10.")
else:
    print("some_var is indeed 10.")
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### For loops iterate over lists
<pre><code>
for animal in ["dog", "cat", "mouse"]:
    print(f"{animal} is a mammal")
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### "range(number)" returns an iterable of numbers
<pre><code>
for i in range(4):
    print(i)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### "range(lower, upper)" returns an iterable of numbers
<pre><code>
for i in range(4, 8):
    print(i)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### "range(lower, upper, step)" returns an iterable of numbers
<pre><code>
for i in range(4, 8, 2):
    print(i)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Loop over a list to retrieve both the index and the value of each list item
<pre><code>
animals = ["dog", "cat", "mouse"]
for i, value in enumerate(animals):
    print(i, value)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### While loops go until a condition is no longer met
<pre><code>
x = 0
while x < 4:
    print(x)
    x += 1
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Handle exceptions with a try/except block
<pre><code>
try:
    raise IndexError("This is an index error")
except IndexError as e:
    pass
except (TypeError, NameError):
    pass
else:
    print("All good!")
finally:
    print("We can clean up resources here")
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Instead of try/finally to cleanup resources you can use a with statement
<pre><code>
# with open("myfile.txt") as f:
#    for line in f:
#        print(line)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Writing to a file
<pre><code>
# contents = {"aa": 12, "bb": 21}
# with open("myfile1.txt", "w") as file:
#     file.write(str(contents))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Reading from a file
<pre><code>
# with open("myfile1.txt") as file:
#     contents = file.read()
# print(contents)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Python offers a fundamental abstraction called the Iterable
<pre><code>
filled_dict = {"one": 1, "two": 2, "three": 3}
our_iterable = filled_dict.keys()
print(our_iterable)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### We can loop over it
<pre><code>
for i in our_iterable:
    print(i)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### An iterable is an object that knows how to create an iterator
<pre><code>
our_iterator = iter(our_iterable)
print(next(our_iterator))
print(next(our_iterator))
print(next(our_iterator))
# Uncommenting the next line will raise StopIteration
# print(next(our_iterator))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can grab all the elements of an iterable or iterator by call of list()
<pre><code>
print(list(our_iterable))
print(list(our_iterator))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

# 4. Functions

### Use "def" to create new functions
<pre><code>
def add(x, y):
    print(f"x is {x} and y is {y}")
    return x + y
print(add(5, 6))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Another way to call functions is with keyword arguments
<pre><code>
def add(x, y):
    return x + y
print(add(y=6, x=5))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can define functions that take a variable number of positional arguments
<pre><code>
def varargs(*args):
    return args
print(varargs(1, 2, 3))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can define functions that take a variable number of keyword arguments
<pre><code>
def keyword_args(**kwargs):
    return kwargs
print(keyword_args(big="foot", loch="ness"))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can do both at once, if you like
<pre><code>
def all_the_args(*args, **kwargs):
    print(args)
    print(kwargs)
all_the_args(1, 2, a=3, b=4)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### When calling functions, you can do the opposite of args/kwargs!
<pre><code>
def all_the_args(*args, **kwargs):
    print(args)
    print(kwargs)
args = (1, 2, 3, 4)
kwargs = {"a": 3, "b": 4}
all_the_args(*args)
all_the_args(**kwargs)
all_the_args(*args, **kwargs)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Returning multiple values (with tuple assignments)
<pre><code>
def swap(x, y):
    return y, x
x = 1
y = 2
x, y = swap(x, y)
print(x, y)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### global scope
<pre><code>
x = 5
def set_x(num):
    x = num
    print(x)
def set_global_x(num):
    global x
    print(x)
    x = num
    print(x)
set_x(43)
set_global_x(6)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Python has first class functions
<pre><code>
def create_adder(x):
    def adder(y):
        return x + y
    return adder
add_10 = create_adder(10)
print(add_10(3))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Closures in nested functions:
<pre><code>
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
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### There are also anonymous functions
<pre><code>
print((lambda x: x > 2)(3))
print((lambda x, y: x ** 2 + y ** 2)(2, 1))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### There are built-in higher order functions
<pre><code>
def add_10(x):
    return x + 10
print(list(map(add_10, [1, 2, 3])))
print(list(map(max, [1, 2, 3], [4, 2, 1])))
print(list(filter(lambda x: x > 5, [3, 4, 5, 6, 7])))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### We can use list comprehensions for nice maps and filters
<pre><code>
def add_10(x):
    return x + 10
print([add_10(i) for i in [1, 2, 3]])
print([x for x in [3, 4, 5, 6, 7] if x > 5])
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can construct set and dict comprehensions as well
<pre><code>
print({x for x in "abcddeef" if x not in "abc"})
print({x: x**2 for x in range(5)})
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

# 5. Modules

### You can import modules
<pre><code>
import math
print(math.sqrt(16))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can get specific functions from a module
<pre><code>
from math import ceil, floor
print(ceil(3.7))
print(floor(3.7))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can import all functions from a module
<pre><code>
from math import *
print(sqrt(16))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can shorten module names
<pre><code>
import math as m
print(m.sqrt(16))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Python modules are just ordinary Python files
<pre><code>
import math
print(dir(math))
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

# 6. Classes

### We use the "class" statement to create a class
<pre><code>
class Human:
    species = "H. sapiens"
    def __init__(self, name):
        self.name = name
        self._age = 0
    def say(self, msg):
        print(f"{self.name}: {msg}")
    def sing(self):
        return "yo... yo... microphone check... one two... one two..."
    @classmethod
    def get_species(cls):
        return cls.species
    @staticmethod
    def grunt():
        return "*grunt*"
    @property
    def age(self):
        return self._age
    @age.setter
    def age(self, age):
        self._age = age
    @age.deleter
    def age(self):
        del self._age
if __name__ == "__main__":
    i = Human(name="Ian")
    i.say("hi")
    j = Human("Joel")
    j.say("hello")
    i.say(i.get_species())
    Human.species = "H. neanderthalensis"
    i.say(i.get_species())
    j.say(j.get_species())
    print(Human.grunt())
    print(i.grunt())
    i.age = 42
    i.say(i.age)
    j.say(j.age)
    del i.age
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>


## Inheritance

### Inheritance allows new child classes to be defined that inherit methods and variables from their parent class
<pre><code>
class Animal:
    def __init__(self, name):
        self.name = name
    def speak(self):
        return f"{self.name} makes a sound."

class Dog(Animal):
    def speak(self):
        return f"{self.name} barks!"

if __name__ == "__main__":
    dog = Dog("Buddy")
    print(dog.speak())  # Output: Buddy barks!
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

## Multiple Inheritance
### Another class definition that inherits from Superhero and Bat
<pre><code>
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

class Bat:
    species = "Baty"
    def __init__(self, can_fly=True):
        self.fly = can_fly
    def sonar(self):
        return "))) ... ((("

class Batman(Superhero, Bat):
    def __init__(self, *args, **kwargs):
        Superhero.__init__(self, "anonymous", movie=True, superpowers=["Wealthy"], *args, **kwargs)
        Bat.__init__(self, *args, can_fly=False, **kwargs)
        self.name = "Sad Affleck"
    def sing(self):
        return "nan nan nan nan nan batman!"

if __name__ == "__main__":
    sup = Batman()
    print(Batman.__mro__)  # Method Resolution Order
    print(sup.get_species())  # Inherited from Superhero
    print(sup.sing())  # Overridden in Batman
    sup.say("I agree")  # Inherited from Superhero
    print(sup.sonar())  # Inherited from Bat
    sup.age = 100  # Dynamic attribute assignment
    print(sup.age)  # Output: 100
    print(f"Can I fly? {sup.fly}")  # Inherited from Bat
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>


# 7. Advanced

## Generators
A **generator** in Python is a special type of iterator that allows you to iterate over a sequence of values without storing the entire sequence in memory. Generators are created using functions and the `yield` keyword.

### Generators help you make lazy code
<pre><code>
def double_numbers(iterable):
    for i in iterable:
        yield i + i
for i in double_numbers(range(1, 900000000)):
    print(i)
    if i >= 30:
        break
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Just as you can create a list comprehension, you can create generator comprehensions as well
<pre><code>
values = (-x for x in [1,2,3,4,5])
for x in values:
    print(x)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### You can also cast a generator comprehension directly to a list
<pre><code>
values = (-x for x in [1,2,3,4,5])
gen_to_list = list(values)
print(gen_to_list)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>


## Decorators
A **decorator** in Python is a design pattern that allows you to modify or extend the behavior of a function or method without changing its actual code.

### Decorators are a form of syntactic sugar
<pre><code>
def log_function(func):
    def wrapper(*args, **kwargs):
        print(f"Entering function {func.__name__}")
        result = func(*args, **kwargs)
        print(f"Exiting function {func.__name__}")
        return result
    return wrapper
@log_function
def my_function(x,y):
    return x+y
my_function(1,2)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### But there's a problem
<pre><code>
def log_function(func):
    def wrapper(*args, **kwargs):
        print(f"Entering function {func.__name__}")
        result = func(*args, **kwargs)
        print(f"Exiting function {func.__name__}")
        return result
    return wrapper
@log_function
def my_function(x,y):
    return x+y

print(my_function.__name__)
print(my_function.__code__.co_argcount)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

### Fix this using functools
<pre><code>
from functools import wraps
def log_function(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print(f"Entering function {func.__name__}")
        result = func(*args, **kwargs)
        print(f"Exiting function {func.__name__}")
        return result
    return wrapper
@log_function
def my_function(x,y):
    return x+y

print(my_function.__name__)
print(my_function.__code__.co_argcount)
</code></pre>
<codapi-snippet sandbox="python" editor="basic"></codapi-snippet>

# Free Online Resources

* [Automate the Boring Stuff with Python](https://automatetheboringstuff.com)
* [The Official Docs](https://docs.python.org/3/)
* [Hitchhiker's Guide to Python](https://docs.python-guide.org/)
* [Python Course](https://www.python-course.eu)
* [First Steps With Python](https://realpython.com/learn/python-first-steps/)
* [A curated list of awesome Python frameworks, libraries and software](https://github.com/vinta/awesome-python)
* [Official Style Guide for Python](https://peps.python.org/pep-0008/)
* [Python 3 Computer Science Circles](https://cscircles.cemc.uwaterloo.ca/)
* [Dive Into Python 3](https://www.diveintopython3.net/)
* [Python Tutorial for Intermediates](https://pythonbasics.org/)
* [Build a Desktop App with Python](https://pythonpyqt.com/)