---
x: Just
title: Try Just in Y minutes
image: /try/cover.png
lastmod: 2024-02-10
original: https://just.systems/man/en/chapter_20.html
license: CC0-1.0
contributors:
    - ["Casey Rodarmor", "https://rodarmor.com"]
---

[`just`](https://just.systems/) is a handy way to save and run project-specific commands. Commands, called recipes, are stored in a file called `justfile` with syntax inspired by `make`.

Try running `just --version` to make sure that it's installed correctly:

```
just --version
```

<codapi-snippet sandbox="just" editor="basic">
</codapi-snippet>

Once `just` is installed and working, create a file named `justfile` in the root of your project with the following contents:

```
recipe-name:
  echo 'This is a recipe!'

# this is a comment
another-recipe:
  @echo 'This is another recipe.'
```

<script id="justfile" type="text/plain">
recipe-name:
  echo 'This is a recipe!'

# this is a comment
another-recipe:
  @echo 'This is another recipe.'
</script>

When you invoke `just` it looks for file `justfile` in the current directory and upwards, so you can invoke it from any subdirectory of your project.

The search for a `justfile` is case insensitive, so any case, like `Justfile`, `JUSTFILE`, or `JuStFiLe`, will work. `just` will also look for files with the name `.justfile`, in case you’d like to hide a `justfile`.

Running `just` with no arguments runs the first recipe in the `justfile`:

```
just
```

<codapi-snippet sandbox="just" editor="basic" files="#justfile">
</codapi-snippet>

One or more arguments specify the recipe(s) to run:

```
just another-recipe
```

<codapi-snippet sandbox="just" editor="basic" files="#justfile">
</codapi-snippet>

`just` prints each command to standard error before running it, which is why `echo 'This is a recipe!'` was printed. This is suppressed for lines starting with `@`, which is why echo `'This is another recipe.'` was not printed.

To be continued...
