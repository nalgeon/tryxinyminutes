---
x: ripgrep
title: Try ripgrep in Y minutes
image: /try/ripgrep/cover.png
lastmod: 2024-03-19
original: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
license: CC-BY-SA-4.0
contributors:
    - ["Andrew Gallant", "https://blog.burntsushi.net"]
    - ["Anton Zhiyanov", "https://antonz.org"]
---

[ripgrep](https://github.com/BurntSushi/ripgrep) is a command line tool that searches your files for patterns that you give it. It's similar to grep, but provides a better user experience and is (generally) faster.

[Basics](#basics) ·
[Recursive search](#recursive-search) ·
[Useful options](#useful-options) ·
[Replacements](#replacements) ·
[Configuration](#configuration) ·
[Further reading](#further-reading)

<div class="tryx__panel">
<p>✨ This is an open source guide. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/ripgrep/index.md">improve it</a>!</p>
</div>

## Basics

ripgrep behaves as if it were reading each file line by line:

-   If a line matches the pattern given to ripgrep, that line is printed.
-   If a line does not match the pattern, the line is not printed.

The best way to see how this works is with an example.

We'll try searching [httpurr](https://github.com/rednafi/httpurr) source code, which I have already downloaded to the `/opt/httpurr` directory like this:

```shell
cd /opt
curl -OL https://github.com/rednafi/httpurr/archive/refs/tags/v0.1.2.tar.gz
tar xvzf v0.1.2.tar.gz
mv httpurr-0.1.2 httpurr
cd httpurr
```

[Search in file](#search-in-file) ·
[Partial matches](#partial-matches) ·
[Regular expressions](#regular-expressions) ·
[Fixed strings](#fixed-strings) ·
[Multiple patterns](#multiple-patterns)

### Search in file

Let's find all occurrences of the word `codes` in `README.md`:

```shell
rg codes README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status codes on speed dial << </i></strong>
30:* List the HTTP status codes:
54:* Filter the status codes by categories:
124:		  Print HTTP status codes by category with --list;
131:		  Print HTTP status codes
```

So what happened here? ripgrep read the contents of `README.md`, and for each line that contained `codes`, ripgrep printed it to the terminal.

ripgrep includes the line number for each line by default (use `-n`/`--line-number` to force this) and highlights the matches (use `--color=always` to force this).

### Partial matches

ripgrep supports partial matches by default:

```shell
rg descr README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
81:* Display the description of a status code:
127:		  Print the description of an HTTP status code
```

The word `description` matches the `descr` search pattern.

To search for whole words instead, use the `-w` (`--word-regexp`) option:

```shell
rg --word-regexp code README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
81:* Display the description of a status code:
84:	httpurr --code 410
94:	The HyperText Transfer Protocol (HTTP) 410 Gone client error response code
99:	code should be used instead.
126:	  -c, --code [status code]
127:		  Print the description of an HTTP status code
```

ripgrep found strings containing the word `code`, but not `codes`. Try removing `--word-regexp` and see how the results change.

### Regular expressions

By default, ripgrep treats the search pattern as a _regular expression_. Let's find all lines with a word that contains `res` followed by other letters:

```shell
rg 'res\w+' README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
94:	The HyperText Transfer Protocol (HTTP) 410 Gone client error response code
95:	indicates that access to the target resource is no longer available at the
152:of the rest.
```

`\w+` means "one or more word-like characters" (e.g. letters like `p` or `o`, but not punctuation like `.` or `!`), so `response`, `resource`, and `rest` all match.

Suppose we are only interested in 4 letter words starting with `res`:

```shell
rg 'res\w\b' README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
152:of the rest.
```

`\b` means "word boundary" (e.g. a space, a punctuation character, or the end of a line), so `rest` matches, but `response` and `resource` don't.

Finally, let's search for 3-digit numbers (showing first 10 matches with `head`):

```shell
rg '\d\d\d' README.md | head
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
45:	100    Continue
46:	101    Switching Protocols
47:	102    Processing
48:	103    Early Hints
69:	200    OK
70:	201    Created
71:	202    Accepted
72:	203    Non-Authoritative Information
73:	204    No Content
74:	205    Reset Content
```

A full tutorial on regular expressions is beyond the scope of this guide, but ripgrep's specific syntax is documented in the [regex](https://docs.rs/regex/*/regex/#syntax) package.

### Fixed strings

What if we want to search for a _literal_ string instead of a regular expression? Suppose we are interested in a word `code` followed by a dot:

```shell
rg 'code.' src/data.go | head
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
8:The HTTP 100 Continue informational status response code indicates that
14:status code in response before sending the body.
31:The HTTP 101 Switching Protocols response code indicates a protocol to which the
53:Deprecated: This status code is deprecated. When used, clients may still accept
56:The HTTP 102 Processing informational status response code indicates to client
59:This status code is only sent if the server expects the request to take
112:The HTTP 200 OK success status response code indicates that the request has
141:The HTTP 201 Created success status response code indicates that the request has
149:The common use case of this status code is as the result of a POST request.
165:The HTTP 202 Accepted response status code indicates that the request has been
```

Since `.` means "any character" in regular expressions, our pattern also matches `code `, `codes` and other cases we are not interested in.

To treat the pattern as a literal string, use the `-F` (`--fixed-strings`) option:

```shell
rg --fixed-strings 'code.' src/data.go
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
197:to responses with any status code.
283:Browsers accessing web pages will never encounter this status code.
695:to an error code.
1027:erroneous cases it happens, they will handle it as a generic 400 status code.
1051:Regular web servers will normally not return this status code. But some other
1418:then the server responds with the 510 status code.
```

Much better!

### Multiple patterns

To search for multiple patterns, list them with the `-e` (`--regexp`) option. ripgrep will output-mode="html" output lines matching at least one of the specified patterns.

For example, search for `make` or `run`:

```shell
rg -e 'make' -e 'run' README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
139:* Go to the root directory and run:
141:	make init
145:	make lint
149:	make test
```

If you have many patterns, it may be easier to put them in a file and point ripgrep to it with `-f` (`--file`):

```shell
echo 'install' > /tmp/patterns.txt
echo 'make' >> /tmp/patterns.txt
echo 'run' >> /tmp/patterns.txt

rg --file=/tmp/patterns.txt README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
* On MacOS, brew install:
	    && brew install httpurr
* Or elsewhere, go install:
	go install github.com/rednafi/httpurr/cmd/httpurr
* Go to the root directory and run:
	make init
	make lint
	make test
```

## Recursive search

Previously, we used ripgrep to search a single file, but ripgrep is perfectly capable of recursively searching in directories.

[Search in directory](#search-in-directory) ·
[Automatic filtering](#automatic-filtering) ·
[File globs](#file-globs) ·
[File types](#file-types)

### Search in directory

Let's find all unexported functions (they start with a lowercase letter):

```shell
rg 'func [a-z]\w+' .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:12:func main() {
./src/cli.go:16:func formatStatusText(text string) string {
./src/cli.go:21:func printHeader(w *tabwriter.Writer) {
./src/cli.go:35:func printStatusCodes(w *tabwriter.Writer, category string) error {
./src/cli.go:105:func printStatusText(w *tabwriter.Writer, code string) error {
```

This search returned matches from both the `cmd` and `src` directories. If you are only interested in `cmd`, specify it instead of `.`:

```shell
rg 'func [a-z]\w+' cmd
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
cmd/httpurr/main.go:12:func main() {
```

To search multiple directories, list them all like this:

```shell
rg 'func [a-z]\w+' cmd src
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
cmd/httpurr/main.go:12:func main() {
src/cli.go:16:func formatStatusText(text string) string {
src/cli.go:21:func printHeader(w *tabwriter.Writer) {
src/cli.go:35:func printStatusCodes(w *tabwriter.Writer, category string) error {
src/cli.go:105:func printStatusText(w *tabwriter.Writer, code string) error {
```

### Automatic filtering

ripgrep is smart enough to ignore some paths when searching:

-   patterns from `.gitignore`,
-   hidden files and directories,
-   binary files,
-   symlinks.

For example, let's search for GitHub action jobs:

```shell
rg 'jobs:' .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
exit status 1
```

Since the GitHub stuff is in a hidden `.github` directory, ripgrep won't find it. But it will with the `-.` (`--hidden`) option:

```shell
rg --hidden 'jobs:' .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./.github/workflows/automerge.yml:8:jobs:
./.github/workflows/lint.yml:11:jobs:
./.github/workflows/release.yml:10:jobs:
./.github/workflows/test.yml:11:jobs:
```

Similarly, there are options to enable other paths:

-   `--no-ignore` to search patterns from `.gitignore`;
-   `-a` (`--text`) to search binary files;
-   `-L` (`--follow`) to follow symlinks.

ripgrep allows you to override the ignored paths from `.gitignore` with `.ignore` files. See the [official guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#automatic-filtering) for details.

### File globs

Let's search for `httpurr`:

```shell
rg --max-count=5 httpurr .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./README.md:2:    <h1>ᗢ httpurr</h1>
./README.md:16:	brew tap rednafi/httpurr https://github.com/rednafi/httpurr \
./README.md:17:	    && brew install httpurr
./README.md:23:	go install github.com/rednafi/httpurr/cmd/httpurr
./README.md:33:	httpurr --list
./cmd/httpurr/main.go:4:	"github.com/rednafi/httpurr/src"
./go.mod:1:module github.com/rednafi/httpurr
./httpurr.rb:7:  homepage "https://github.com/rednafi/httpurr"
./httpurr.rb:12:      url "https://github.com/rednafi/httpurr/releases/download/v0.1.1/httpurr_Darwin_x86_64.tar.gz"
./httpurr.rb:16:        bin.install "httpurr"
./httpurr.rb:20:      url "https://github.com/rednafi/httpurr/releases/download/v0.1.1/httpurr_Darwin_arm64.tar.gz"
./httpurr.rb:24:        bin.install "httpurr"
./src/cli.go:24:	fmt.Fprintf(w, "\nᗢ httpurr\n")
./src/cli_test.go:64:	want := "\nᗢ httpurr\n==========\n\n"
```

Note that I have limited the number of results per file to 5 with the `-m` (`--max-count`) option to keep the results readable in case there are many matches.

Quite a lot of results. Let's narrow it down by searching only in `.go` files:

```shell
rg -g '*.go' httpurr .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:4:	"github.com/rednafi/httpurr/src"
./src/cli.go:24:	fmt.Fprintf(w, "\nᗢ httpurr\n")
./src/cli_test.go:64:	want := "\nᗢ httpurr\n==========\n\n"
```

The `-g` (`--glob`) option takes a _glob_ (filename pattern), typically containing a fixed part (`.go` in our example) and a wildcard `*` ("anything but the path separator").

Another example — search in files named `http`-something:

```shell
rg -g 'http*' httpurr .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./httpurr.rb:7:  homepage "https://github.com/rednafi/httpurr"
./httpurr.rb:12:      url "https://github.com/rednafi/httpurr/releases/download/v0.1.1/httpurr_Darwin_x86_64.tar.gz"
./httpurr.rb:16:        bin.install "httpurr"
./httpurr.rb:20:      url "https://github.com/rednafi/httpurr/releases/download/v0.1.1/httpurr_Darwin_arm64.tar.gz"
./httpurr.rb:24:        bin.install "httpurr"
./httpurr.rb:31:      url "https://github.com/rednafi/httpurr/releases/download/v0.1.1/httpurr_Linux_arm64.tar.gz"
./httpurr.rb:35:        bin.install "httpurr"
./httpurr.rb:39:      url "https://github.com/rednafi/httpurr/releases/download/v0.1.1/httpurr_Linux_x86_64.tar.gz"
./httpurr.rb:43:        bin.install "httpurr"
```

To _negate_ the glob, prefix it with `!`. For example, search everywhere except the `.go`, `.md`, and `.rb` files:

```shell
rg -g '!*.{go,md,rb}' httpurr .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./go.mod:1:module github.com/rednafi/httpurr
```

All that is left is `go.mod`.

To apply multiple filters, specify multiple glob options. For example, find all functions except those in test files:

```shell
rg -g '*.go' -g '!*_test.go' 'func ' .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:12:func main() {
./src/cli.go:16:func formatStatusText(text string) string {
./src/cli.go:21:func printHeader(w *tabwriter.Writer) {
./src/cli.go:35:func printStatusCodes(w *tabwriter.Writer, category string) error {
./src/cli.go:105:func printStatusText(w *tabwriter.Writer, code string) error {
./src/cli.go:123:func Cli(w *tabwriter.Writer, version string, exitFunc func(int)) {
```

### File types

Instead of using a glob to filter by extension, you can use ripgrep's support for file types. Let's search for `httpurr` in `.go` files:

```shell
rg -t go httpurr .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:4:	"github.com/rednafi/httpurr/src"
./src/cli.go:24:	fmt.Fprintf(w, "\nᗢ httpurr\n")
./src/cli_test.go:64:	want := "\nᗢ httpurr\n==========\n\n"
```

The `-t` (`--type`) option restricts the search results to files of a certain type (Go source files in our example).

To exclude files of a certain type, use `-T` (`--not-type`):

```shell
rg -T go -T md -T ruby httpurr .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./go.mod:1:module github.com/rednafi/httpurr
```

We've excluded Go, Markdown and Ruby files, so all that's left is `go.mod` (personally, I'd consider it a Go file as well, but ripgrep disagrees).

## Useful options

ripgrep supports a number of additional search and output-mode="html" output options you may find handy.

[Ignore case](#ignore-case) ·
[Inverse matching](#inverse-matching) ·
[Count matches](#count-matches) ·
[Show matches only](#show-matches-only) ·
[Show files only](#show-files-only) ·
[Show context](#show-context) ·
[Multiline search](#multiline-search)

### Ignore case

Remember our search for `codes` in the README?

```shell
rg codes README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status codes on speed dial << </i></strong>
30:* List the HTTP status codes:
54:* Filter the status codes by categories:
124:		  Print HTTP status codes by category with --list;
131:		  Print HTTP status codes
```

It returns `codes` matches, but not `Codes` because ripgrep is case-sensitive by default. To change this, use `-i` (`--ignore-case`):

```shell
rg --ignore-case codes README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status codes on speed dial << </i></strong>
30:* List the HTTP status codes:
40:	Status Codes
54:* Filter the status codes by categories:
64:	Status Codes
124:		  Print HTTP status codes by category with --list;
131:		  Print HTTP status codes
```

There is also `-S` (`--smart-case`), which behaves like `--ignore-case` unless the search pattern is all caps:

```shell
rg --smart-case HTTP README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status codes on speed dial << </i></strong>
30:* List the HTTP status codes:
94:	The HyperText Transfer Protocol (HTTP) 410 Gone client error response code
109:	https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/410
124:		  Print HTTP status codes by category with --list;
127:		  Print the description of an HTTP status code
131:		  Print HTTP status codes
```

Searching for `HTTP` matches `HTTP`, but not `https` or `httpurr`.

### Inverse matching

To find lines that _do not_ contain the pattern, use `-v` (`--invert-match`). For example, find the non-empty lines without the `@` symbol:

```shell
rg --invert-match -e '@' -e '^$' Makefile
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
1:.PHONY: lint
2:lint:
8:.PHONY: lint-check
9:lint-check:
14:.PHONY: test
15:test:
20:.PHONY: clean
21:clean:
27:.PHONY: init
28:init:
```

### Count matches

To count the number of matched lines (per file), use `-c` (`--count`). For example, count the number of functions in each `.go` file:

```shell
rg --count -t go 'func ' .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:1
./src/cli.go:5
./src/cli_test.go:10
./src/data_test.go:2
```

Note that `--count` counts the number of _lines_, not the number of matches. For example, there are 6 words `string` in `src/cli.go`, but two of them are on the same line, so `--count` reports 5:

```shell
rg -w --count -t go 'string' src/cli.go
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
5
```

To count the number of _matches_ instead, use `--count-matches`:

```shell
rg -w --count-matches -t go 'string' src/cli.go
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
6
```

### Show matches only

By default, ripgrep prints the entire line containing the match. To show only the matching part, use `-o` (`--only-matching`).

Suppose we want to find functions named `print`-something:

```shell
rg --only-matching -t go 'func print\w+' .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./src/cli.go:21:func printHeader
./src/cli.go:35:func printStatusCodes
./src/cli.go:105:func printStatusText
```

The results are much cleaner than without `--only-matching` (try removing the option in the above command and see for yourself).

### Show files only

If there are too many matches, you may prefer to show only the files where the matches occurred. Use `-l` (`--files-with-matches`) to do this:

```shell
rg --files-with-matches 'httpurr' .
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
./README.md
./cmd/httpurr/main.go
./go.mod
./httpurr.rb
./src/cli.go
./src/cli_test.go
```

### Show context

Remember when we searched for GitHub jobs?

```shell
rg 'jobs:' .github/workflows
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
.github/workflows/automerge.yml:8:jobs:
.github/workflows/lint.yml:11:jobs:
.github/workflows/release.yml:10:jobs:
.github/workflows/test.yml:11:jobs:
```

These results are kind of useless, because they don't return the actual job name (which is on the next line after `jobs`). To fix this, let's use `-C` (`--context`), which shows `N` lines around each match:

```shell
rg --context=1 'jobs:' .github/workflows
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
.github/workflows/automerge.yml-7-
.github/workflows/automerge.yml:8:jobs:
.github/workflows/automerge.yml-9-  dependabot:
--
.github/workflows/lint.yml-10-
.github/workflows/lint.yml:11:jobs:
.github/workflows/lint.yml-12-  golangci:
--
.github/workflows/release.yml-9-
.github/workflows/release.yml:10:jobs:
.github/workflows/release.yml-11-  goreleaser:
--
.github/workflows/test.yml-10-
.github/workflows/test.yml:11:jobs:
.github/workflows/test.yml-12-  test:
```

It might be even better to show only the _next_ line after the match, since we are not interested in the previous one. Use `-A` (`--after-context`) for this:

```shell
rg --after-context=1 'jobs:' .github/workflows
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
.github/workflows/automerge.yml:8:jobs:
.github/workflows/automerge.yml-9-  dependabot:
--
.github/workflows/lint.yml:11:jobs:
.github/workflows/lint.yml-12-  golangci:
--
.github/workflows/release.yml:10:jobs:
.github/workflows/release.yml-11-  goreleaser:
--
.github/workflows/test.yml:11:jobs:
.github/workflows/test.yml-12-  test:
```

Nice!

### Multiline search

I have another idea for searching GitHub jobs. Since the job name is always on the next line after the literal `jobs:`, let's enable multiline searching with `-U` (`--multiline`):

```shell
rg --multiline 'jobs:\n\s+\w+' .github/workflows
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
.github/workflows/automerge.yml:8:jobs:
.github/workflows/automerge.yml:9:  dependabot:
.github/workflows/lint.yml:11:jobs:
.github/workflows/lint.yml:12:  golangci:
.github/workflows/release.yml:10:jobs:
.github/workflows/release.yml:11:  goreleaser:
.github/workflows/test.yml:11:jobs:
.github/workflows/test.yml:12:  test:
```

Now we can see the job names even without using `--context`.

## Replacements

ripgrep provides a limited ability to replace matched text with some other text.

[Replace matches](#replace-matches) ·
[Replace entire line](#replace-entire-line) ·
[Replace groups](#replace-groups)

### Replace matches

Remember our search for `codes` in the README?

```shell
rg codes README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status codes on speed dial << </i></strong>
30:* List the HTTP status codes:
54:* Filter the status codes by categories:
124:		  Print HTTP status codes by category with --list;
131:		  Print HTTP status codes
```

Now let's replace all `codes` with `ids` using the `-r` (`--replace`) option:

```shell
rg codes -r ids README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status ids on speed dial << </i></strong>
30:* List the HTTP status ids:
54:* Filter the status ids by categories:
124:		  Print HTTP status ids by category with --list;
131:		  Print HTTP status ids
```

### Replace entire line

Replace applies only to the matching portion of text. To replace an entire line of text, include the entire line in the match like this:

```shell
rg '^.*codes.*$' -r 'REDACTED' README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:REDACTED
30:REDACTED
54:REDACTED
124:REDACTED
131:REDACTED
```

Alternatively, you can combine the `-o` (`--only-matching`) option with `--replace` to achieve the same result:

```shell
rg codes -or 'REDACTED' README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:REDACTED
30:REDACTED
54:REDACTED
124:REDACTED
131:REDACTED
```

### Replace groups

Replacements can include capturing groups. Let's say we want to find all occurrences of `status` followed by another word and join them together with a dash. The pattern we might use is `status\s+(\w+)`:

-   literal string `status`,
-   followed by any number of whitespace characters,
-   followed by any number of "word" characters (e.g. letters).

We put the `\w+` in a "capturing group" (indicated by parentheses) so that we can reference it later in our replacement string. For example:

```shell
rg 'status\s+(\w+)' -r 'status-$1' README.md
```

<codapi-snippet sandbox="shell" command="aha" editor="basic" template="httpurr.sh" output-mode="html" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status-codes on speed dial << </i></strong>
30:* List the HTTP status-codes:
54:* Filter the status-codes by categories:
81:* Display the description of a status-code:
124:		  Print HTTP status-codes by category with --list;
126:	  -c, --code [status-code]
127:		  Print the description of an HTTP status-code
131:		  Print HTTP status-codes
```

Our replacement string (`status-$1`) consists of the literal `status-` followed by the contents of the capturing group at index `1`.

> Capturing groups actually start at index `0`, but the 0th capturing group always corresponds to the entire match. The capturing group at index `1` always corresponds to the first explicit capturing group found in the regex pattern.

ripgrep **will never modify your files**. The `--replace` flag only controls ripgrep's output-mode="html" output. (And there is no flag to let you do a replacement in a file.)

## Configuration

ripgrep's has reasonable defaults, but you can change them with configuration files.

ripgrep does not automatically look for a config file in a predefined directory. To use a config file, set the `RIPGREP_CONFIG_PATH` environment variable to its path.

Here's an example of a configuration file:

```shell
cat /tmp/.ripgreprc
```

<codapi-snippet sandbox="shell" editor="basic" template="config.sh" output>
</codapi-snippet>

```
# Trim really long lines and show a preview
--max-columns=40
--max-columns-preview

# Search hidden files / directories (e.g. dotfiles)
--hidden

# Do not search git files
--glob
!.git/*

# Ignore case unless all caps
--smart-case
```

When specifying a flag that has a value, either put the flag and the value on the same line with a `=` sign (e.g. `--max-columns=40`), or put the flag and the value on two different lines (e.g., `--glob`). Do not put them on the same line without an equal sign (e.g. not `--max-columns 40`).

Let's search using this config:

```shell
export RIPGREP_CONFIG_PATH=/tmp/.ripgreprc
rg httpurr . | head
```

<codapi-snippet sandbox="shell" editor="basic" template="config.sh" output>
</codapi-snippet>

```
./.goreleaser.yml:14:    main: ./cmd/httpurr
./.goreleaser.yml:45:  - name: httpurr
./.goreleaser.yml:46:    homepage: "https://github.com/rednaf [... omitted end of long line]
./.goreleaser.yml:50:      name: httpurr
./README.md:2:    <h1>ᗢ httpurr</h1>
./README.md:16:	brew tap rednafi/httpurr https://github [... omitted end of long line]
./README.md:17:	    && brew install httpurr
./README.md:23:	go install github.com/rednafi/httpurr/c [... omitted end of long line]
./README.md:33:	httpurr --list
./README.md:37:	ᗢ httpurr
```

## Further reading

ripgrep supports more features, such as explicit handling of encodings or searching binary data. See the [official guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md) for details.

Use `rg --help` to see all supported options (we have covered less than half of them in this guide).
