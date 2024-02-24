---
x: Bash
title: Try Bash in Y minutes
image: /try/cover.png
lastmod: 2024-02-12
original: https://learnxinyminutes.com/docs/bash/
license: CC-BY-SA-4.0
contributors:
    - ["Max Yankov", "https://github.com/golergka"]
    - ["Darren Lin", "https://github.com/CogBear"]
    - ["Alexandre Medeiros", "http://alemedeiros.sdf.org"]
    - ["Denis Arh", "https://github.com/darh"]
    - ["akirahirose", "https://twitter.com/akirahirose"]
    - ["Anton Strömkvist", "http://lutic.org/"]
    - ["Rahil Momin", "https://github.com/iamrahil"]
    - ["Gregrory Kielian", "https://github.com/gskielian"]
    - ["Etan Reisner", "https://github.com/deryni"]
    - ["Jonathan Wang", "https://github.com/Jonathansw"]
    - ["Leo Rudberg", "https://github.com/LOZORD"]
    - ["Betsy Lorton", "https://github.com/schbetsy"]
    - ["John Detter", "https://github.com/jdetter"]
    - ["Harry Mumford-Turner", "https://github.com/harrymt"]
    - ["Martin Nicholson", "https://github.com/mn113"]
    - ["Mark Grimwood", "https://github.com/MarkGrimwood"]
    - ["Emily Grace Seville", "https://github.com/EmilySeville7cfg"]
---

[Bash](https://www.gnu.org/software/bash/manual/bashref.html) is a name of the unix shell, which was also distributed as the shell
for the GNU operating system and as the default shell on most Linux distros.
Nearly all examples below can be a part of a shell script
or executed directly in the shell.

[Introduction](#introduction) ·
[Variables](#variables) ·
[Control flow](#control-flow) ·
[Files and directories](#files-and-directories) ·
[Running processes](#running-processes) ·
[Useful commands](#useful-commands)

<div class="tryx__panel">
<p>✨ This is an open source guide. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/bash/index.md">improve it</a>!</p>
</div>

## Introduction

First line of the script is the [shebang](<https://en.wikipedia.org/wiki/Shebang_(Unix)>) which tells the system how to execute the script:

```bash
#!/usr/bin/env bash
# As you already figured, comments start with #.
# Shebang is also a comment.
```

Simple hello world example:

```bash
#!/usr/bin/env bash
echo "Hello world!"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
Hello world!
```

Each command starts on a new line, or after a semicolon:

```bash
#!/usr/bin/env bash
echo "This is the first command"; echo "This is the second command"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
This is the first command
This is the second command
```

## Variables

Declaring a variable looks like this (I'll skip the shebang from now on):

```bash
variable="Some string"
```

<codapi-snippet id="s-variable" sandbox="bash" editor="basic" output-mode="hidden">
</codapi-snippet>

But not like this:

```bash
variable = "Some string"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
variable: command not found
```

Bash will decide that `variable` is a command it must execute and give an error
because it can't be found.

Nor like this:

```bash
variable= "Some string"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
Some string: command not found
```

Bash will decide that `Some string` is a command it must execute and give an
error because it can't be found. In this case the `variable=` part is seen
as a variable assignment valid only for the scope of the `Some string`
command.

Using the variable:

```bash
echo "$variable"
echo '$variable'
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-variable" output>
</codapi-snippet>

```
Some string
$variable
```

When you use a variable itself — assign it, export it, or else — you write
its name without `$`. If you want to use the variable's value, you should use `$`.
Note that `'` (single quote) won't expand the variables!
You can write variable without surrounding quotes but it's not recommended.

Parameter expansion `${...}`:

```bash
echo "${variable}"
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-variable" output>
</codapi-snippet>

```
Some string
```

This is a simple usage of parameter expansion such as two examples above.
Parameter expansion gets a value from a variable.
It "expands" or prints the value.
During the expansion time the value or parameter can be modified.
Below are other modifications that add onto this expansion.

String substitution in variables:

```bash
echo "${variable/Some/A}"
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-variable" output>
</codapi-snippet>

```
A string
```

This will substitute the first occurrence of `Some` with `A`.

Substring from a variable:

```bash
length=7

# This will return only the first 7 characters of the value
echo "${variable:0:length}"

# This will return the last 5 characters (note the space before -5).
# The space before minus is mandatory here.
echo "${variable: -5}"
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-variable" output>
</codapi-snippet>

```
Some st
tring
```

String length:

```bash
echo "${#variable}"
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-variable" output>
</codapi-snippet>

```
11
```

Indirect expansion:

```bash
other_variable="variable"
echo ${!other_variable}
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-variable" output>
</codapi-snippet>

```
Some string
```

This will expand the value of `other_variable`.

The default value for variable:

```bash
echo "${foo:-"DefaultValueIfFooIsMissingOrEmpty"}"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
DefaultValueIfFooIsMissingOrEmpty
```

This works for null (`foo=`) and empty string (`foo=""`); zero (`foo=0`) returns `0`.
Note that it only returns default value and doesn't change variable value.

Arrays:

```bash
# Declare an array with 6 elements:
array=(one two three four five six)

echo "First element:"
echo "${array[0]}"
echo ""
echo "All elements:"
echo "${array[@]}"
echo ""
echo "Number of elements:"
echo "${#array[@]}"
echo ""
echo "Number of chars in 3rd element:"
echo "${#array[2]}"
echo ""
echo "Two elements starting from 4th:"
echo "${array[@]:3:2}"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
First element:
one

All elements:
one two three four five six

Number of elements:
6

Number of chars in 3rd element:
5

Two elements starting from 4th:
four five
```

Print all elements each of them on new line:

```bash
array=(one two three four five six)
for item in "${array[@]}"; do
    echo "$item"
done
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
one
two
three
four
five
six
```

Built-in variables:

```bash
echo "Last program's return value: $?"
echo "Script's PID: $$"
echo "Number of arguments passed to script: $#"
echo "All arguments passed to script: $@"
echo "Script's arguments separated into different variables: $1 $2..."
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
Last program's return value: 0
Script's PID: 1
Number of arguments passed to script: 0
All arguments passed to script:
Script's arguments separated into different variables:  ...
```

Brace expansion `{...}` is used to generate arbitrary strings:

```bash
echo {1..10}
echo {a..z}
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
1 2 3 4 5 6 7 8 9 10
a b c d e f g h i j k l m n o p q r s t u v w x y z
```

This will output the range from the start value to the end value.

Note that you can't use variables here:

```bash
from=1
to=10
echo {$from..$to}
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
{1..10}
```

Expressions are denoted with the following format:

```bash
echo $(( 10 + 5 ))
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
15
```

## Control flow

We have the usual `if` structure.
Condition is true if the value of `$name` is not equal to the current user's login username:

```bash
name="Alice"
if [[ "$name" != "$USER" ]]; then
    echo "Your name isn't your username"
else
    echo "Your name is your username"
fi
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
Your name isn't your username
```

To use `&&` and `||` with `if` statements, you need multiple pairs of square brackets:

```bash
name="Daniya"
age=15

if [[ "$name" == "Steve" ]] && [[ "$age" -eq 15 ]]; then
    echo "This will run if $name is Steve AND $age is 15."
fi

if [[ "$name" == "Daniya" ]] || [[ "$name" == "Zach" ]]; then
    echo "This will run if $name is Daniya OR Zach."
fi
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
This will run if Daniya is Daniya OR Zach.
```

There are other comparison operators for numbers listed below:

-   `-ne` - not equal
-   `-lt` - less than
-   `-gt` - greater than
-   `-le` - less than or equal to
-   `-ge` - greater than or equal to

There is also the `=~` operator, which tests a string against the Regex pattern:

```bash
email=me@example.com
if [[ "$email" =~ [a-z]+@[a-z]{2,}\.(com|net|org) ]]
then
    echo "Valid email!"
fi
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
Valid email!
```

There is also conditional execution:

```bash
echo "Always executed" || echo "Only executed if first command fails"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
Always executed
```

```bash
echo "Always executed" && echo "Only executed if first command does NOT fail"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
Always executed
Only executed if first command does NOT fail
```

Bash uses a `case` statement that works similarly to switch in Java and C++:

```bash
variable=1

case "$variable" in
    # List patterns for the conditions you want to meet
    0) echo "There is a zero.";;
    1) echo "There is a one.";;
    *) echo "It is not null.";;  # match everything
esac
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
There is a one.
```

`for` loops iterate for as many arguments given.
The contents of `$variable` is printed three times:

```bash
for variable in {1..3}
do
    echo "$variable"
done
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
1
2
3
```

Or write it the "traditional for loop" way:

```bash
for ((a=1; a <= 3; a++))
do
    echo $a
done
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
1
2
3
```

They can also be used to act on files.
This will run the command `cat` (prints file contents) on `file1` and `file2`:

```bash
for variable in file1.txt file2.txt
do
    cat "$variable"
done
```

<codapi-snippet sandbox="bash" editor="basic" files="file1.txt file2.txt" output>
</codapi-snippet>

```
hello from file1
hello from file2
```

...or the output from a command.
This will `cat` the output from `ls` (lists files that match the pattern).

```bash
for output in $(ls *.txt)
do
    cat "$output"
done
```

<codapi-snippet sandbox="bash" editor="basic" files="file1.txt file2.txt" output>
</codapi-snippet>

```
hello from file1
hello from file2
```

Bash can also accept patterns, like this to `cat`
all the text files in current directory:

```bash
for output in ./*.txt
do
    cat "$output"
done
```

<codapi-snippet sandbox="bash" editor="basic" files="file1.txt file2.txt" output>
</codapi-snippet>

```
hello from file1
hello from file2
```

While loop:

```bash
while [ true ]
do
    echo "loop body here..."
    break
done
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
loop body here...
```

You can also define functions:

```bash
function foo ()
{
    echo "All arguments passed to function: $@"
    echo "Arguments separated into different variables: $1 $2..."
    echo "This is a function"
    returnValue=0    # Variable values can be returned
    return $returnValue
}
```

<codapi-snippet id="s-function" sandbox="bash" editor="basic" output-mode="hidden">
</codapi-snippet>

Call the function `foo` with two arguments, `arg1` and `arg2`:

```bash
foo arg1 arg2
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-function" output>
</codapi-snippet>

```
All arguments passed to function: arg1 arg2
Arguments separated into different variables: arg1 arg2...
This is a function
```

Return values can be obtained with `$?`:

```bash
foo > /dev/null  # hide the output

resultValue=$?
echo "result = $resultValue"
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-function" output>
</codapi-snippet>

```
result = 0
```

More than 9 arguments are also possible by using braces, e.g. `${10}`, `${11}`, etc.

You can also define functions like this:

```bash
bar ()
{
    echo "Another way to declare functions!"
    return 0
}

# call the function `bar` with no arguments:
bar
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
Another way to declare functions!
```

## Files and directories

Our current directory is available through the command `pwd`.
`pwd` stands for "print working directory".
We can also use the built-in variable `$PWD`.
Observe that the following are equivalent:

```bash
# execs `pwd` and interpolates output
echo "I'm in $(pwd)"

# interpolates the variable
echo "I'm in $PWD"
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
I'm in /sandbox
I'm in /sandbox
```

If you get too much output in your terminal, or from a script, the command
`clear` clears your screen:

```
clear
```

`Ctrl-L` also works for clearing output.

Reading a value from input:

```bash
echo "What's your name?"
read name
# Note that we didn't need to declare a new variable.
echo "Hello, $name!"
```

Unlike other programming languages, bash is a shell so it works in the context
of a current directory. You can list files and directories in the current
directory with the `ls` command:

```bash
ls
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
main.sh
```

This command has options that control its execution:

```bash
# Lists every file and directory on a separate line
ls -l
echo ""

# Sorts the directory contents by last-modified date (descending)
ls -t
echo ""

# Recursively `ls` this directory and all of its subdirectories
ls -R
```

<codapi-snippet sandbox="bash" editor="basic" files="file.txt" output>
</codapi-snippet>

```
total 8
-r--r--r-- 1 sandbox sandbox  40 Feb 12 00:54 file.txt
-r--r--r-- 1 sandbox sandbox 226 Feb 12 00:54 main.sh

file.txt
main.sh

.:
file.txt
main.sh
```

Results (stdout) of the previous command can be passed as input (stdin) to the next command
using a pipe `|`. Commands chained in this way are called a "pipeline", and are run concurrently.
The `grep` command filters the input with provided patterns.
That's how we can list `.txt` files in the current directory:

```bash
ls -l | grep "\.txt"
```

<codapi-snippet sandbox="bash" editor="basic" files="file.txt" output>
</codapi-snippet>

```
-r--r--r-- 1 sandbox sandbox 40 Feb 12 00:53 file.txt
```

Use `cat` to print files to stdout:

```bash
cat file.txt
```

<codapi-snippet sandbox="bash" editor="basic" files="file.txt" output>
</codapi-snippet>

```
Hello, World!
Today is a beautiful day.
```

We can also read the file using `cat`:

```bash
Contents=$(cat file.txt)

# "\n" prints a new line character
# "-e" to interpret the newline escape characters as escape characters
echo -e "START OF FILE\n$Contents\nEND OF FILE"
```

<codapi-snippet sandbox="bash" editor="basic" files="file.txt" output>
</codapi-snippet>

```
START OF FILE
Hello, World!
Today is a beautiful day.
END OF FILE
```

Use `cp` to copy files or directories from one place to another.
`cp` creates NEW versions of the sources,
so editing the copy won't affect the original (and vice versa).
Note that it will overwrite the destination if it already exists.

```bash
cp file.txt /tmp/clone.txt
cp -r /sandbox/ /tmp # recursively copy
ls -lR /tmp
```

<codapi-snippet sandbox="bash" editor="basic" files="file.txt" output>
</codapi-snippet>

```
/tmp:
total 4
-r--r--r-- 1 sandbox sandbox 40 Feb 12 01:00 clone.txt
drwxr-xr-x 2 sandbox sandbox 80 Feb 12 01:00 sandbox

/tmp/sandbox:
total 8
-r--r--r-- 1 sandbox sandbox 40 Feb 12 01:00 file.txt
-r--r--r-- 1 sandbox sandbox 80 Feb 12 01:00 main.sh
```

Look into `scp` or `sftp` if you plan on exchanging files between computers.
`scp` behaves very similarly to `cp`.
`sftp` is more interactive.

Use `mv` to move files or directories from one place to another.
`mv` is similar to `cp`, but it deletes the source.
`mv` is also useful for renaming files!

```bash
touch /tmp/src.txt
mv /tmp/src.txt /tmp/dst.txt
ls /tmp
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
dst.txt
```

Since bash works in the context of a current directory, you might want to
run your command in some other directory. We have cd for changing location:

```bash
cd ~    # change to home directory
cd      # also goes to home directory
cd ..   # go up one directory
        # (^^say, from /home/username/Downloads to /home/username)
```

```bash
# change to specified directory
cd /sandbox

# change to another directory
cd /var/log/..

# change to last directory
cd -
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
/sandbox
```

Use subshells to work across directories:

```bash
(echo "First, I'm here: $PWD") && (cd /tmp; echo "Then, I'm here: $PWD")
pwd # still in first directory
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
First, I'm here: /sandbox
Then, I'm here: /tmp
/sandbox
```

Use `mkdir` to create new directories:

```bash
mkdir /tmp/one

# the `-p` flag causes new intermediate directories to be created as necessary.
mkdir -p /tmp/two/three/four

# show directory tree
tree /tmp
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
/tmp
├── one
└── two
    └── three
        └── four

4 directories, 0 files
```

If the intermediate directories didn't already exist, running the above
command without the `-p` flag would return an error.

You can redirect command input and output (stdin, stdout, and stderr)
using "redirection operators". Unlike a pipe, which passes output to a command,
a redirection operator has a command's input come from a file or stream, or
sends its output to a file or stream.

Read from stdin until `^EOF$` and overwrite `hello.sh` with the lines
between "EOF" (which are called a "here document"):

```bash
cat > /tmp/hello.sh << EOF
#!/usr/bin/env bash
# read stdin and print it to stdout
stdin=$(cat)
if [[ "$stdin" == "" ]]; then
    echo "stdin is empty"
else
    echo "stdin: $stdin"
fi
EOF
```

<codapi-snippet sandbox="bash" editor="basic" output-mode="hidden">
</codapi-snippet>

Variables will be expanded if the first "EOF" is not quoted.

Run the `hello.sh` Bash script with various stdin, stdout, and
stderr redirections:

```bash
# pass input.in as input to the script
bash hello.sh < "input.in"

# redirect output from the script to output.out
bash hello.sh > "/tmp/output.out"

# redirect error output to error.err
bash hello.sh 2> "/tmp/error.err"
```

<codapi-snippet sandbox="bash" editor="basic" files="hello.sh input.in" output>
</codapi-snippet>

```
stdin: I appreciate your input.
stdin is empty
```

Redirect both output and errors to `output-and-error.log`
`&1` means file descriptor 1 (stdout), so `2>&1` redirects stderr (2) to the current
destination of stdout (1), which has been redirected to `output-and-error.log`:

```bash
bash hello.sh > "/tmp/output-and-error.log" 2>&1
cat /tmp/output-and-error.log
```

<codapi-snippet sandbox="bash" editor="basic" files="hello.sh" output>
</codapi-snippet>

```
stdin is empty
```

Redirect all output and errors to the black hole, `/dev/null`, i.e., no output:

```bash
bash hello.sh > /dev/null 2>&1
```

<codapi-snippet sandbox="bash" editor="basic" files="hello.sh" output>
</codapi-snippet>

```

```

`>` will overwrite the file if it exists. If you want to append instead, use `>>`:

```bash
bash hello.sh >> "/tmp/output.out" 2>> "/tmp/error.err"
bash hello.sh >> "/tmp/output.out" 2>> "/tmp/error.err"

echo "output.out:"
cat /tmp/output.out

echo "error.err:"
cat /tmp/error.err
```

<codapi-snippet sandbox="bash" editor="basic" files="hello.sh" output>
</codapi-snippet>

```
output.out:
stdin is empty
stdin is empty
error.err:
```

Overwrite `output.out`, append to `error.err`, and count lines:

```bash
help for > /tmp/output.out 2>> /tmp/error.err
wc -l /tmp/output.out /tmp/error.err
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
10 /tmp/output.out
  0 /tmp/error.err
 10 total
```

Run a command and print its file descriptor (e.g. `/dev/fd/123`)
see: `man fd`

```bash
echo <(echo "#helloworld")
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
/dev/fd/63
```

Overwrite `output.out` with `#helloworld`:

```bash
cat > /tmp/output.out <(echo "#helloworld")
echo "#helloworld" > /tmp/output.out
echo "#helloworld" | cat > /tmp/output.out
echo "#helloworld" | tee /tmp/output.out >/dev/null
cat /tmp/output.out
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
#helloworld
```

Cleanup temporary files verbosely (add `-i` for interactive).
WARNING: `rm` commands cannot be undone:

```bash
touch /tmp/one.txt /tmp/two.txt
mkdir /tmp/subdir
touch /tmp/subdir/three.txt

rm -v /tmp/one.txt /tmp/two.txt
rm -r /tmp/subdir/ # recursively delete
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
removed '/tmp/one.txt'
removed '/tmp/two.txt'
```

You can install the [`trash-cli`](https://pypi.org/project/trash-cli/) Python package to have `trash`
which puts files in the system trash and doesn't delete them directly.

Commands can be substituted within other commands using `$( )`.
The following command displays the number of files and directories in the
current directory:

```bash
echo "There are $(ls | wc -l) items here."
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
There are 1 items here.
```

The same can be done using backticks ``but they can't be nested -
the preferred way is to use`$( )`.

```bash
echo "There are `ls | wc -l` items here."
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
There are 1 items here.
```

## Running processes

A single ampersand `&` after a command runs it in the background. A background command's
output is printed to the terminal, but it cannot read from the input.

```bash
sleep 30 &

# List background jobs
jobs # => [1]+  Running                 sleep 30 &

# Bring the background job to the foreground
fg

# Ctrl-C to kill the process, or Ctrl-Z to pause it
# Resume a background process after it has been paused with Ctrl-Z
bg

# Kill job number 2
kill %2
# %1, %2, etc. can be used for fg and bg as well
```

Redefine command `ping` as alias to send only 5 packets:

```bash
alias ping='ping -c 5'
```

<codapi-snippet id="s-alias" sandbox="bash" editor="basic" output-mode="hidden">
</codapi-snippet>

Escape the alias and use command with this name instead:

```bash
\ping -c 1 127.0.0.1
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: seq=0 ttl=42 time=0.114 ms

--- 127.0.0.1 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 0.114/0.114/0.114 ms
```

Print all aliases:

```bash
alias -p
```

<codapi-snippet sandbox="bash" editor="basic" depends-on="s-alias" output>
</codapi-snippet>

```
alias ping='ping -c 5'
```

## Useful commands

There are a lot of useful commands you should learn.

Prints last 5 lines of `data.txt`:

```bash
tail -n 5 data.txt
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
three
four,five
foo
foo bar
foo baz bar
```

Prints first 5 lines of `data.txt`:

```bash
head -n 5 data.txt
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
one
two
two
three
three
```

Print `data.txt`'s lines in sorted order:

```bash
sort data.txt
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
foo
foo bar
foo baz bar
four,five
one
three
three
three
two
two
```

Report or omit repeated lines, with `-d` it reports them:

```bash
uniq -d data.txt
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
two
three
```

Prints only the first column before the `,` character:

```bash
cut -d ',' -f 1 data.txt | grep four
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
four
```

Replaces every occurrence of `three` with `ten` in `data.txt` (regex compatible):

```bash
cp data.txt /tmp
sed -i 's/three/ten/g' /tmp/data.txt
grep "three" /tmp/data.txt | wc -l
grep "ten" /tmp/data.txt | wc -l
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
0
3
```

Be aware that this `-i` flag means that `data.txt` will be changed.
`-i` or `--in-place` erase the input file (use `--in-place=.backup` to keep a back-up).

Print to stdout all lines of `data.txt` which match some regex.
The example prints lines which begin with `foo` and end in `bar`:

```bash
grep "^foo.*bar$" data.txt
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
foo bar
foo baz bar
```

Pass the option `-c` to instead print the number of lines matching the regex:

```bash
grep -c "^foo.*bar$" data.txt
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
2
```

Other useful options are:

```bash
# recursively `grep`
grep -r "^foo.*bar$" somedir/

# give line numbers
grep -n "^foo.*bar$" data.txt

# recursively `grep`, but ignore binary files
grep -rI "^foo.*bar$" somedir/
```

Perform the same initial search, but filter out the lines containing "baz"

```bash
grep "^foo.*bar$" data.txt | grep -v "baz"
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
foo bar
```

If you literally want to search for the string,
and not the regex, use `fgrep` (or `grep -F`):

```
fgrep "baz" data.txt
```

<codapi-snippet sandbox="bash" editor="basic" files="data.txt" output>
</codapi-snippet>

```
foo baz bar
```

The `trap` command allows you to execute a command whenever your script
receives a signal. Here, `trap` will execute `rm` if it receives any of the
three listed signals.

```bash
trap "rm $TEMP_FILE; exit" SIGHUP SIGINT SIGTERM
```

`sudo` is used to perform commands as the superuser.
Usually it will ask interactively the password of superuser:

```bash
NAME1=$(whoami)
NAME2=$(sudo whoami)
echo "Was $NAME1, then became more powerful $NAME2"
```

Read Bash shell built-ins documentation with the bash `help` built-in:

```bash
help
help <command>
```

Help for the `return` command:

```bash
help return
```

<codapi-snippet sandbox="bash" editor="basic" output>
</codapi-snippet>

```
return: return [n]
    Return from a shell function.

    Causes a function or sourced script to exit with the return value
    specified by N.  If N is omitted, the return status is that of the
    last command executed within the function or script.

    Exit Status:
    Returns N, or failure if the shell is not executing a function or script.
```

Read Bash manpage documentation with `man`:

```bash
apropos bash
man 1 bash
man bash
```

Read info documentation with `info` (`?` for help):

```bash
apropos info | grep '^info.*('
man info
info info
info 5 info
```

Read bash info documentation:

```bash
info bash
info bash 'Bash Features'
info bash 6
info --apropos bash
```
