---
x: grep
title: Try grep in Y minutes
image: /try/cover.png
lastmod: 2024-03-29
canonical: https://antonz.org/grep-by-example/
original: https://antonz.org/grep-by-example/
license: CC-BY-NC-ND-4.0
contributors:
    - ["Anton Zhiyanov", "https://antonz.org/"]
---

[grep](https://www.gnu.org/software/grep/manual/grep.html) is the ultimate text search tool available on virtually all Linux machines. While there are now better alternatives (such as [ripgrep](/try/ripgrep/)), you will still often find yourself on a server where grep is the only search tool available. So it's nice to have a working knowledge of it.

[Basics](#basics) ·
[Recursive search](#recursive-search) ·
[Search options](#search-options) ·
[Output options](#output-options) ·
[Final thoughts](#final-thoughts)

<div class="tryx__panel">
<p>✨ This is an open source guide. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/grep/index.md">improve it</a>!</p>
</div>

## Basics

Basically, grep works like this:

-   You give it a search pattern and a file.
-   grep reads the file line by line, printing the lines that match the pattern and ignoring others.

Let's look at an example. We'll search the [httpurr](https://github.com/rednafi/httpurr) source code, which I've already downloaded to the `/opt/httpurr` directory like this:

```shell
cd /opt
curl -OL https://github.com/rednafi/httpurr/archive/refs/tags/v0.1.2.tar.gz
tar xvzf v0.1.2.tar.gz
mv httpurr-0.1.2 httpurr
cd httpurr
```

[Search in file](#search-in-file) ·
[Matches](#matches) ·
[Regular expressions](#regular-expressions) ·
[Fixed strings](#fixed-strings) ·
[Multiple patterns](#multiple-patterns)

### Search in file

Let's find all occurrences of the word `codes` in `README.md`:

```shell
grep -n codes README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status codes on speed dial << </i></strong>
30:* List the HTTP status codes:
54:* Filter the status codes by categories:
124:		  Print HTTP status codes by category with --list;
131:		  Print HTTP status codes
```

grep read the contents of `README.md`, and for each line that contained `codes`, grep printed it to the terminal.

grep also included the line number for each line, thanks to the `-n` (`--line-number`) option.

> Not all grep versions support the long option syntax (e.g. `--line-number`). If you get an error using the long version, try the short one (e.g. `-n`) — it may work fine.

### Matches

grep uses _partial matches_ by default:

```shell
grep -n descr README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
81:* Display the description of a status code:
127:		  Print the description of an HTTP status code
```

The word `description` matches the `descr` search pattern.

To search for _whole words_ instead, use the `-w` (`--word-regexp`) option:

```shell
grep -n --word-regexp code README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
81:* Display the description of a status code:
84:	httpurr --code 410
94:	The HyperText Transfer Protocol (HTTP) 410 Gone client error response code
99:	code should be used instead.
126:	  -c, --code [status code]
127:		  Print the description of an HTTP status code
```

grep found strings containing the word `code`, but not `codes`. Try removing `--word-regexp` and see how the results change.

> When using multiple short options, you can combine them like this: `grep -nw code README.md`. This gives exactly the same result as using the separate options (`-n -w`).

To search for _whole lines_ instead of partial matches of whole words, use the `-x` (`--line-regexp`) option:

```shell
grep -n --line-regexp end httpurr.rb
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
47:end
```

Try removing `--line-regexp` and see how the results change.

### Regular expressions

To make grep use regular expressions (_Perl-compatible regular expressions_ in grep terminology), use the `-P` (`--perl-regexp`) option.

Let's find all lines with a word that contains `res` followed by other letters:

```shell
grep -Pn 'res\w+' README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
94:	The HyperText Transfer Protocol (HTTP) 410 Gone client error response code
95:	indicates that access to the target resource is no longer available at the
152:of the rest.
```

`\w+` means "one or more word-like characters" (e.g. letters like `p` or `o`, but not punctuation like `.` or `!`), so `response`, `resource`, and `rest` all match.

<div class="boxed">
<h3>Regular expression dialects in grep</h3>
<p>Without <code>--perl-regexp</code>, grep treats the search pattern as something called a <em>basic regular expression</em>. While regular expressions are quite common in the software world, the <em>basic</em> dialect is really weird, so it's better not to use it at all.</p>
<p>Another dialect supported by grep is <a href="https://www.gnu.org/software/grep/manual/grep.html#Regular-Expressions">extended</a> regular expressions. You can use the <code>-E</code> (<code>--extended-regexp</code>) option to enable them. Extended regular expressions are <em>almost</em> like normal regular expressions, but not quite. So I wouldn't use them either.</p>
<p>Some grep versions do not support <code>--perl-regexp</code>. For those, <code>--extended-regexp</code> is the best you can get.</p>
</div>

Suppose we are only interested in 4 letter words starting with `res`:

```shell
grep -Pn 'res\w\b' README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
152:of the rest.
```

`\b` means "word boundary" (e.g. a space, a punctuation character, or the end of a line), so `rest` matches, but `response` and `resource` don't.

Finally, let's search for 3-digit numbers (showing first 10 matches with `head`):

```shell
grep -Pn '\d\d\d' README.md | head
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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

A full tutorial on regular expressions is beyond the scope of this guide, but grep's "Perl-compatible" syntax is documented in the [PCRE2 manual](https://www.pcre.org/current/doc/html/pcre2syntax.html).

### Fixed strings

What if we want to search for a _literal_ string instead of a regular expression? Suppose we are interested in a word `code` followed by a dot:

```shell
grep -Pn 'code.' src/data.go | head
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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

Since `.` means "any character" in regular expressions, our pattern also matches `code `, `codes` and other cases we are not interested in.

To treat the pattern as a literal string, use the `-F` (`--fixed-strings`) option:

```shell
grep -Fn 'code.' src/data.go
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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

To search for multiple patterns, list them with the `-e` (`--regexp`) option. grep will output lines matching at least one of the specified patterns.

For example, search for `make` or `run`:

```shell
grep -En -e make -e run README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
139:* Go to the root directory and run:
141:	make init
145:	make lint
149:	make test
```

> Unfortunately, grep can't use Perl-compatible regular expressions (`-P`) with multiple patterns. So we are stuck with the extended (`-E`) dialect.

If you have many patterns, it may be easier to put them in a file and point grep to it with `-f` (`--file`):

```shell
echo 'install' > /tmp/patterns.txt
echo 'make' >> /tmp/patterns.txt
echo 'run' >> /tmp/patterns.txt

grep -En --file=/tmp/patterns.txt README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
13:* On MacOS, brew install:
17:	    && brew install httpurr
20:* Or elsewhere, go install:
23:	go install github.com/rednafi/httpurr/cmd/httpurr
139:* Go to the root directory and run:
141:	make init
145:	make lint
149:	make test
```

## Recursive search

grep searches directories recursively when called with the `-r` (`--recursive`) option.

[Search in directory](#search-in-directory) ·
[File globs](#file-globs) ·
[Binary files](#binary-files)

### Search in directory

Let's find all unexported functions (they start with a lowercase letter):

```shell
grep -Pnr 'func [a-z]\w+' .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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
grep -Pnr 'func [a-z]\w+' cmd
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
cmd/httpurr/main.go:12:func main() {
```

To search multiple directories, list them all like this:

```shell
grep -Pnr 'func [a-z]\w+' cmd src
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
cmd/httpurr/main.go:12:func main() {
src/cli.go:16:func formatStatusText(text string) string {
src/cli.go:21:func printHeader(w *tabwriter.Writer) {
src/cli.go:35:func printStatusCodes(w *tabwriter.Writer, category string) error {
src/cli.go:105:func printStatusText(w *tabwriter.Writer, code string) error {
```

### File globs

Let's search for `httpurr`:

```shell
grep -Pnr --max-count=5 httpurr .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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
grep -Pnr --include='*.go' httpurr .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:4:	"github.com/rednafi/httpurr/src"
./src/cli.go:24:	fmt.Fprintf(w, "\nᗢ httpurr\n")
./src/cli_test.go:64:	want := "\nᗢ httpurr\n==========\n\n"
```

The `--include` option (there is no short version) takes a _glob_ (filename pattern), typically containing a fixed part (`.go` in our example) and a wildcard `*` ("anything but the path separator").

Another example — search in files named `http`-something:

```shell
grep -Pnr --include='http*' httpurr .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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

To _negate_ the glob, use the `--exclude` option. For example, search everywhere except the `.go` files:

```shell
grep -Pnr --exclude '*.go' def .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
./.goreleaser.yml:1:# This is an example .goreleaser.yml file with some sensible defaults.
./httpurr.rb:15:      def install
./httpurr.rb:21:      sha256 "82acefd1222f6228636f2cda6518e0316f46624398adc722defb55c68ac3bb30"
./httpurr.rb:23:      def install
./httpurr.rb:34:      def install
./httpurr.rb:42:      def install
```

To apply multiple filters, specify multiple glob options. For example, find all functions except those in test files:

```shell
grep -Pnr --include '*.go' --exclude '*_test.go' 'func ' .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:12:func main() {
./src/cli.go:16:func formatStatusText(text string) string {
./src/cli.go:21:func printHeader(w *tabwriter.Writer) {
./src/cli.go:35:func printStatusCodes(w *tabwriter.Writer, category string) error {
./src/cli.go:105:func printStatusText(w *tabwriter.Writer, code string) error {
./src/cli.go:123:func Cli(w *tabwriter.Writer, version string, exitFunc func(int)) {
```

### Binary files

By default, grep does not ignore binary files:

```shell
grep -Pnr aha .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="binary.sh" output>
</codapi-snippet>

```
grep: ./data.bin: binary file matches
```

Most of the time, this is probably not what you want. If you're searching in a directory that might contain binary files, it's better to ignore them altogether with the `-I` (`--binary-files=without-match`) option:

```shell
grep -Pnr --binary-files=without-match aha .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="binary.sh" output>
</codapi-snippet>

```
(not found)
```

If for some reason you want grep to search binary files and print the actual matches (as it does with text files), use the `-a` (`--text`) option.

## Search options

grep supports a couple of additional search options you may find handy.

[Ignore case](#ignore-case) ·
[Inverse matching](#inverse-matching)

### Ignore case

Let's find all occurrences of the word `codes` in `README.md`:

```shell
grep -Pnr codes README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
3:    <strong><i> >> HTTP status codes on speed dial << </i></strong>
30:* List the HTTP status codes:
54:* Filter the status codes by categories:
124:		  Print HTTP status codes by category with --list;
131:		  Print HTTP status codes
```

It returns `codes` matches, but not `Codes` because grep is case-sensitive by default. To change this, use `-i` (`--ignore-case`):

```shell
grep -Pnr --ignore-case codes README.md
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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

### Inverse matching

To find lines that _do not_ contain the pattern, use `-v` (`--invert-match`). For example, find the non-empty lines without the `@` symbol:

```shell
grep -Enr --invert-match -e '@' -e '^$' Makefile
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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

## Output options

grep supports a number of additional output options you may find handy.

[Count matches](#count-matches) ·
[Limit matches](#limit-matches) ·
[Show matches only](#show-matches-only) ·
[Show files only](#show-files-only) ·
[Show context](#show-context) ·
[Silent mode](#silent-mode) ·
[Colors](#colors)

### Count matches

To count the number of matched lines (per file), use `-c` (`--count`). For example, count the number of functions in each `.go` file:

```shell
grep -Pnr --count --include '*.go' 'func ' .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:1
./src/cli.go:5
./src/cli_test.go:10
./src/data_test.go:2
```

Note that `--count` counts the number of _lines_, not the number of matches. For example, there are 6 words `string` in `src/cli.go`, but two of them are on the same line, so `--count` reports 5:

```shell
grep -nrw --count string src/cli.go
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
5
```

### Limit matches

To limit the number of matching lines per file, use the `-m` (`--max-count`) option:

```shell
grep -Pnrw --max-count=5 func .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
./cmd/httpurr/main.go:12:func main() {
./src/cli.go:16:func formatStatusText(text string) string {
./src/cli.go:21:func printHeader(w *tabwriter.Writer) {
./src/cli.go:35:func printStatusCodes(w *tabwriter.Writer, category string) error {
./src/cli.go:105:func printStatusText(w *tabwriter.Writer, code string) error {
./src/cli.go:123:func Cli(w *tabwriter.Writer, version string, exitFunc func(int)) {
./src/cli_test.go:15:func TestFormatStatusText(t *testing.T) {
./src/cli_test.go:54:func TestPrintHeader(t *testing.T) {
./src/cli_test.go:71:func TestPrintStatusCodes(t *testing.T) {
./src/cli_test.go:159:		t.Run(want, func(t *testing.T) {
./src/cli_test.go:168:func TestPrintStatusText(t *testing.T) {
./src/data_test.go:9:func TestStatusCodes(t *testing.T) {
./src/data_test.go:99:func TestStatusCodeMap(t *testing.T) {
```

With `--max-count=N`, grep stops searching the file after finding the first N matching lines (or non-matching lines if used with `--invert-match`).

### Show matches only

By default, grep prints the entire line containing the match. To show only the matching part, use `-o` (`--only-matching`).

Suppose we want to find functions named `print`-something:

```shell
grep -Pnr --only-matching --include '*.go' 'func print\w+' .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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
grep -Pnr --files-with-matches 'httpurr' .
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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

Let's search for GitHub action jobs:

```shell
grep -Pnr 'jobs:' .github/workflows
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
.github/workflows/automerge.yml:8:jobs:
.github/workflows/lint.yml:11:jobs:
.github/workflows/release.yml:10:jobs:
.github/workflows/test.yml:11:jobs:
```

These results are kind of useless, because they don't return the actual job name (which is on the next line after `jobs`). To fix this, let's use `-C` (`--context`), which shows `N` lines around each match:

```shell
grep -Pnr --context=1 'jobs:' .github/workflows
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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
grep -Pnr --after-context=1 'jobs:' .github/workflows
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
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

> There is also `-B` (`--before-context`) for showing N lines _before_ the match.

Nice!

### Silent mode

Sometimes you just want to know if a file contains a certain string; you don't care about the number or positions of the matches.

To make grep quit immediately after the first match and not print anything, use the `-q` (`--quiet` or `--silent`) option. Use the return code (`$?`) to see if grep found anything (0 — found, 1 — not found):

```shell
grep -Pnrw --quiet main cmd/httpurr/main.go
if [ $? = "0" ]; then echo "found!"; else echo "not found"; fi
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
found!
```

Try changing the search pattern from `main` to `Main` and see how the results change.

When searching in multiple files with `--quiet`, grep stops after the first match in any file and does not check other files:

```shell
grep -Pnrw --quiet main .
if [ $? = "0" ]; then echo "found!"; else echo "not found"; fi
```

<codapi-snippet sandbox="shell" command="run" editor="basic" template="httpurr.sh" output>
</codapi-snippet>

```
found!
```

### Colors

To highlight matches and line numbers, use the `--color=always` option:

```shell
grep -Pnr --color=always codes README.md
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

Use `--color=auto` to let grep decide whether to use colors based on your terminal. Use `--color=never` to force no-color mode.

## Final thoughts

That's it! We've covered just about everything grep can do. Unfortunately, it doesn't support replacing text, reading options from a configuration file, or other fancy features provided by grep alternatives like `ack` or `ripgrep`. But grep is still quite powerful, as you can probably see now.

Use `grep --help` to quickly see all supported options and see the [official guide](https://www.gnu.org/software/grep/manual/grep.html) for option descriptions.

Have fun grepping!
