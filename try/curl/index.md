---
x: curl
title: Try curl in Y minutes
image: /try/cover.png
lastmod: 2023-09-04
canonical: https://antonz.org/mastering-curl/
original: https://antonz.org/mastering-curl/
license: Apache-2.0
contributors:
    - ["Daniel Stenberg", "https://daniel.haxx.se/"]
    - ["Anton Zhiyanov", "https://antonz.org"]
---

[Curl](https://curl.se/) stands for "client for URLs". It's a tool for client-side _internet transfers_ with URLs. An internet transfer is an _upload_ or _download_ using a specific protocol (curl supports quite a few), where the endpoint is identified by a URL.

Curl supports a crazy number of protocols, from HTTP, FTP and TELNET to IMAP, LDAP and GOPHER. It runs on 92 operating systems and has over 20 billion installations worldwide.

[Command line options](#command-line-options) ·
[URLs](#urls) ·
[Curl basics](#curl-basics) ·
[HTTP](#http) ·
[Further reading](#further-reading)

Curl has an extensive [reference documentation](https://curl.se/docs/manpage.html). To see the short version, try this:

```sh
curl --help
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To see the full version, try `curl --manual` (be careful, it's _huge_).

## Command line options

Curl performs internet transfers, where it acts as a client, uploading or downloading data from a remote server. The data can be anything: text, images, audio, video, and so on.

Curl supports both unauthenticated protocols (such as HTTP or FTP) and their authenticated counterparts (such as HTTPS or FTPS). Data transferred over an unauthenticated protocol can be intercepted and tampered with, so it's better to always use authenticated ones. Curl can disable server verification with an `--insecure` flag, but you better not do this in production.

Curl currently has about 250 options, and the number is growing at a rate of ≈10/year.

There are short command line options (single dash):

```sh
curl -V
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

And long options (double dash):

```sh
curl --version
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

All options are available in "long" format, but only some of them have "short" counterparts.

Some options are of boolean type. You can turn such options on:

```sh
curl --silent http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Or off:

```sh
curl --no-silent http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Some options accept arguments:

```sh
curl --output /tmp/uuid.json http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Arguments that contain spaces should be enclosed in quotes:

```sh
curl -o /dev/null --write-out "type: %{content_type}" http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

## URLs

Curl supports URLs (URIs, really) similar to how [RFC 3986](https://datatracker.ietf.org/doc/html/rfc3986) defines them:

```text
scheme://user:password@host:port/path?query#fragment
```

-   `scheme` defines a protocol (like `https` or `ftp`). If omitted, curl will try to guess one.
-   `user` and `password` are authentication credentials (passing credentials in URLs is generally not used anymore for the security reasons).
-   `host` is the hostname, domain name or IP address of the server.
-   `port` is the port number. If omitted, curl will use the default port associated with the scheme (such as 80 for `http` or 443 for `https`).
-   `path` is the path to the resource on the server.
-   `query` is usually a sequence of `name=value` pairs separated by `&`.

For curl, anything starting with `-` or `--` is an option, and everything else is a URL.

### Query

If you pass a lot of URL parameters, the query part can become quite long. The `--url-query` option allows you to specify query parts separately:

```sh
curl http://httpbingo.org/get --url-query "name=Alice" --url-query "age=25"
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Multiple URLs

Curl accepts any number of URLs, each of which requires a destination — stdout or a file. For example, this command saves the first UUID to `/tmp/uuid1.json` and the second UUID to `tmp/uuid2.json`:

```sh
curl
  -o /tmp/uuid1.json http://httpbingo.org/uuid
  -o /tmp/uuid2.json http://httpbingo.org/uuid

&& cat /tmp/uuid1.json
&& cat /tmp/uuid2.json
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

_(Here and beyond, I will sometimes show multiline commands for illustrative purposes. In reality curl expects a single line or line breaks with `\`)_

The `-O` derives the filename from the URL:

```sh
curl --output-dir /tmp
  -O http://httpbingo.org/anything/one
  -O http://httpbingo.org/anything/two

&& ls /tmp
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To write both responses to the same file, you can use redirection:

```sh
curl http://httpbingo.org/uuid http://httpbingo.org/uuid > /tmp/uuid.json

&& cat /tmp/uuid.json
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### URL globbing

Curl automatically expands glob expressions in URLs into multiple specific URLs.

For example, this command requests three different paths (`al`, `bt`, `gm`), each with two different parameters (`num=1` and `num=2`), for a total of six URLs:

```sh
curl --output-dir /tmp -o "out_#1_#2.txt"
  http://httpbingo.org/anything/{al,bt,gm}?num=[1-2]

&& ls /tmp
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

You can disable globbing with the `--globoff` option if `[]{}` characters are valid in your URLs. Then curl will treat them literally.

### Config file

As the number of options increases, the curl command becomes harder to decipher. To make it more readable, you can prepare a config file that lists one option per line (<code class="nowrap">--</code> is optional):

```text
output-dir /tmp
show-error
silent
```

By default, curl reads the config from `$HOME/.curlrc`, but you can change this with the `--config` (`-K`) option:

```sh
curl --config /sandbox/.curlrc http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Progress meters

Curl has two progress meters. The default is verbose:

```sh
curl --no-silent http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

(I have a `silent` option in my config file, so I have to turn it off explicitly; by default, it's not set, so `--no-silent` is not needed)

The other is compact:

```sh
curl --no-silent --progress-bar http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

The `--silent` option turns the meter off completely:

```sh
curl --silent http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### State reset

When you set options, they apply to all URLs curl processes. For example, here both headers are sent to both URLs:

```sh
curl
  -H "x-num: one" http://httpbingo.org/headers?1
  -H "x-num: two" http://httpbingo.org/headers?2
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Sometimes that's not what you want. To reset the state between URL calls, use the `--next` option:

```sh
curl
  -H "x-num: one" http://httpbingo.org/headers?1
  --next
  -H "x-num: two" http://httpbingo.org/headers?2
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

## Curl basics

Now that we understand how curl handles URLs and options, let's talk about specific features.

### Version

`--version` (`-V`) knows everything about the installed version of curl:

```sh
curl -V
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

It lists (line by line) ➊ versions of curl itself and its dependencies, ➋ the release date, ➌ available protocols, and ➍ enabled features.

### Verbose

`--verbose` (`-v`) makes curl verbose, which is useful for debugging:

```sh
curl -v http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

If `--verbose` is not enough, try `--trace` (the single `-` sends the trace output to stdout):

```sh
curl --trace - http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Or `--trace-ascii`:

```sh
curl --trace-ascii - http://httpbingo.org/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Use `--write-out` (`-w`) to extract specific information about the response. It supports over [50 variables](https://everything.curl.dev/usingcurl/verbose/writeout). For example, here we extract the status code and response content type:

```sh
curl
  -w "\nstatus: %{response_code}\ntype: %{content_type}"
  http://httpbingo.org/status/429
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Or some response headers:

```sh
curl
  -w "\ndate: %header{date}\nlength: %header{content-length}"
  http://httpbingo.org/status/429
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Downloads

`--remote-name` (`-O`) tells curl to save the output to a file specified by the URL (specifically, by the part after the last `/`). It's often used together with `--output-dir`, which tells curl where exactly to save the file:

```sh
curl --output-dir /tmp -O http://httpbingo.org/uuid

&& cat /tmp/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

If the directory does not exist, `--output-dir` won't create it for you. Use `--create-dirs` for this:

```sh
curl --output-dir /tmp/some/place --create-dirs
  -O http://httpbingo.org/uuid

&& cat /tmp/some/place/uuid
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

You can use `--max-filesize` (in bytes) to limit the allowed response size, but often it isn't known in advance, so it may not work.

### Retry

Sometimes the remote host is temporarily unavailable. To deal with these situations, curl provides the `--retry [num]` option. If a request fails, curl will try it again, but no more than `num` times:

```sh
curl -i --retry 3 http://httpbingo.org/unstable
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

_(this URL fails 50% of the time)_

You can set the maximum time curl will spend retrying with `--retry-max-time` (in seconds) or the delay between retries with `--retry-delay` (also in seconds):

```sh
curl -i --retry 3 http://httpbingo.org/unstable
  --retry-max-time 2
  --retry-delay 1
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

For curl, "request failed" means one of the following HTTP codes: 408, 429, 500, 502, 503 or 504. If the request fails with a "connection refused" error, curl will not retry. But you can change this with `--retry-connrefused`, or even enable retries for all kinds of problems with `--retry-all-errors`.

### Uploads

Curl is often used to download data from the server, but you can also upload it. Use the `--upload-file` (`-T`) option:

```sh
echo hello > /tmp/hello.txt &&

curl -T /tmp/hello.txt http://httpbingo.org/put
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

For HTTP uploads, curl uses the `PUT` method.

### Transfer controls

To stop slow transfers, set the minimum allowed download speed (in bytes per second) with `--speed-limit`. By default, curl checks the speed in 30 seconds intervals, but you can change this with `--speed-time`.

For example, allow no less than 10 bytes/sec during a 3-second interval:

```sh
curl -v --speed-limit 10 --speed-time 3 http://httpbingo.org/get
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To limit bandwidth usage, set `--limit-rate`. It accepts anything from bytes to petabytes:

```sh
curl --limit-rate 3 http://httpbingo.org/get
curl --limit-rate 3k http://httpbingo.org/get
curl --limit-rate 3m http://httpbingo.org/get
curl --limit-rate 3g http://httpbingo.org/get
curl --limit-rate 3t http://httpbingo.org/get
curl --limit-rate 3p http://httpbingo.org/get
```

Another thing to limit is the number of concurrent requests (e.g. if you download a lot of files). Use `--rate` for this. It accepts seconds, minutes, hours or days:

```sh
curl --rate 3/s http://httpbingo.org/anything/[1-9].txt
curl --rate 3/m http://httpbingo.org/anything/[1-9].txt
curl --rate 3/h http://httpbingo.org/anything/[1-9].txt
curl --rate 3/d http://httpbingo.org/anything/[1-9].txt
```

### Name resolving

By default, curl uses your DNS server to resolve hostnames to IP addresses. But you can force it to resolve to a specific IP with `--resolve`:

```sh
curl --resolve httpbingo.org:8080:127.0.0.1
  http://httpbingo.org:8080/get
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

_(this one fails because no one is listening on 127.0.0.1)_

Or you can even map a `hostname:port` pair to another `hostname:port` pair with `--connect-to`:

```sh
curl --connect-to httpbingo.org:8080:httpbingo.org:80
  http://httpbingo.org:8080/get
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

_(this one works fine)_

### Timeouts

To limit the maximum amount of time curl will spend interacting with a single URL, use `--max-time` (in fractional seconds):

```sh
curl --max-time 0.5 http://httpbingo.org/delay/1
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

_(this one fails)_

Instead of limiting the total time, you can use `--connect-timeout` to limit only the time it takes to establish a network connection:

```sh
curl --connect-timeout 0.5 http://httpbingo.org/delay/1
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

_(this one works fine)_

### Credentials

You almost never want to pass the username and password in the curl command itself. One way to avoid this is to use the `.netrc` file. It specifies hostnames and credentials for accessing them:

```text
machine httpbingo.org
login alice
password cheese

machine example.com
login bob
password nuggets
```

Pass the `--netrc` option to use the `$HOME/.netrc` file, or `--netrc-file` to use a specific one:

```sh
echo -e "machine httpbingo.org\nlogin alice\npassword cheese" > /tmp/netrc &&

curl --netrc-file /tmp/netrc
  http://httpbingo.org/basic-auth/alice/cheese
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Exit status

When curl exits, it returns a numeric value to the shell. For success, it's 0, and for errors, there are about [100 different values](https://everything.curl.dev/usingcurl/returns).

For example, here is an exit status 7 (failed to connect to host):

```sh
curl http://httpbingo.org:1313/get
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

You can access the exit status through the `$?` shell variable.

## HTTP

Curl is mostly used to work with HTTP, so let's talk about it.

HTTP/1.x is a plain-text protocol that describes the communication between the client and the server. The client sends messages like this:

```text
POST /anything/chat HTTP/1.1
host: httpbingo.org
content-type: application/json
user-agent: curl/7.87.0

{
    "message": "Hello!"
}
```

-   The first line is a _request line_. The _method_ (`POST`) defines the operation the client wants to perform. The _path_ (`/anything/chat`) is the URL of the requested resource (without the protocol, domain and port). The _version_ (`HTTP/1.1`) indicates the version of the HTTP protocol.
-   Next lines (until the empty line) are _headers_. Each header is a key-value pair that tells the server some useful information about the request. In our case it's the hostname of the server (`httpbingo.org`), the type of the content (`application/json`) and the client's self-identification (`user-agent`).
-   Finally, there is the actual data that the client sends to the server.

Client receives messages like this in response:

```text
HTTP/1.1 200 OK
date: Mon, 28 Aug 2023 07:51:49 GMT
content-type: application/json

{
    "message": "Hi!"
}
```

-   The first line is a _status line_. The _version_ (`HTTP/1.1`) indicates the version of the HTTP protocol. The _status code_ (`200`) tells whether the request was successful or not, and why (there are many status codes for [different situations](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)). The _status message_ is a human-readable description of the status code (HTTP/2 does not have it).
-   Next lines (until the empty line) are _headers_. Similar to request headers, these provide useful information about the response to the client.
-   Finally, there is the actual data that the server sends to the client.

The HTTP protocol is stateless, so any state must be contained within the request itself, either in the headers or in the body.

### HTTP method

Curl supports all HTTP methods (sometimes called _verbs_).

GET (the default one, requires no options):

```sh
curl http://httpbingo.org/get
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

HEAD (`-I`/`--head`, returns headers only):

```sh
curl -I http://httpbingo.org/head
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

POST (`-d`/`--data` for data or `-F`/`--form` for HTTP form):

```sh
curl -d "name=alice" http://httpbingo.org/post
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Or any other method with `--request` (`-X`):

```sh
curl -X PATCH -d "name=alice" http://httpbingo.org/patch
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Response code

Typically, status codes 2xx (specifically 200) are considered "success", while 4xx are treated as client-side errors and 5xx as server-side errors. But curl doesn't care about codes: to it, every HTTP response is a success:

```sh
curl http://httpbingo.org/status/503 && echo OK
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To make curl treat 4xx and 5xx codes as errors, use `--fail` (`-f`):

```sh
curl -f http://httpbingo.org/status/503 && echo OK
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To print the response code, use `--write-out` with the `response_code` variable:

```sh
curl -w "%{response_code}" http://httpbingo.org/status/200
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Response headers

To display response headers, use `--head` (`-i`):

```sh
curl -i http://httpbingo.org/status/200
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Or save them to a file using `--dump-header` (`-D`):

```sh
curl -D /tmp/headers http://httpbingo.org/status/200

&& cat /tmp/headers
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Response body

Response body, sometimes called _payload_, is what curl outputs by default:

```sh
curl http://httpbingo.org/get
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

You can ask the server to compress the data with `--compressed`, but curl will still show it as uncompressed:

```sh
curl --compressed http://httpbingo.org/get
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

_(note how the Accept-Encoding request header has changed)_

### Ranges

To ask the server for a piece of data instead of the whole thing, use the `--range` (`r`) option. This will cause curl to request the specified [byte range](https://curl.se/docs/manpage.html#-r).

For example, here we request 50 bytes starting with the 100th byte:

```sh
curl --range 100-150 http://httpbingo.org/range/1024
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Note that the server may ignore the ask and return the entire response.

If you are downloading data from a server, you can also use `--continue-at` (`-C`) to continue the previous transfer at the specified offset:

```sh
curl --continue-at 1000 http://httpbingo.org/range/1024
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### HTTP versions

By default, curl uses HTTP/1.1 for the `http` scheme and HTTP/2 for `https`. You can change this with flags:

```text
--http0.9
--http1.0
--http1.1
--http2
--http3
```

To find out which version the server supports, use the `http_version` response variable:

```sh
curl -w "%{http_version}" http://httpbingo.org/status/200
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Conditional requests

Conditional requests are useful when you want to avoid downloading already downloaded data (assuming it is not stale). Curl supports two different conditions: file timestamp and etag.

Timestamp conditions use `--time-cond` (`-z`).

Download the data only if the remote resource is newer (condition holds):

```sh
curl --time-cond "Aug 30, 2023" http://httpbingo.org/etag/etag
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Or older (condition fails):

```sh
curl -i --time-cond "-Aug 30, 2023" http://httpbingo.org/etag/etag
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Etag conditions are a bit more involved. An _etag_ is a value returned by the server that uniquely identifies the current version of the requested resource. It is often a hash of the data.

To checks an etag, curl must first to save it with `--etag-save`:

```sh
curl --etag-save /tmp/etags http://httpbingo.org/etag/etag
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

And use `--etag-compare` in subsequent requests:

```sh
curl --etag-save /tmp/etags -o /dev/null http://httpbingo.org/etag/etag &&

curl -i --etag-compare /tmp/etags http://httpbingo.org/etag/etag
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Timestamp conditions rely on the Last-Modified response header, so if the server does not provide it, the resource will always be considered newer. The same goes for etag conditions and the Etag response header.

### HTTP POST

POST sends data to the server. By default, it's a set of key-value pairs encoded in a single string with a `application/x-www-form-urlencoded` Content-Type header.

You can use `--data` (`-d`) to specify individual key-value pairs (or the entire string):

```sh
curl -d name=alice -d age=25 http://httpbingo.org/post
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To send data from a file, use `@` with a file path. Use `--header` (`-H`) to change the Content-Type header with according to the file contents:

```sh
echo "Alice, age 25" > /tmp/data.txt &&

curl -d @/tmp/data.txt -H "content-type: text/plain"
  http://httpbingo.org/post
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

`--data-raw` posts data similar to `--data`, but without the special interpretation of the `@` character.

To post JSON data, use `--json`. It automatically sets the Content-Type and Accept headers accordingly:

```sh
curl --json '{"name": "alice"}' http://httpbingo.org/post
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To URL-encode data (escape all symbols not allowed in URLs), use `--data-urlencode`:

```sh
curl --data-urlencode "Name: Alice Barton" http://httpbingo.org/post
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Multipart formpost

POST can send data as a sequence of "parts" with a `multipart/form-data` content type. It's often used for HTML forms that contain both text fields and files.

Each part has a name, headers, and data. Parts are separated by a "mime boundary":

```text
--------------------------d74496d66958873e
Content-Disposition: form-data; name="person"

anonymous
--------------------------d74496d66958873e
Content-Disposition: form-data; name="secret"; filename="file.txt"
Content-Type: text/plain

contents of the file
--------------------------d74496d66958873e--
```

To construct multipart requests with curl, use `--form` (`F`). Each of these options adds a part to the request:

```sh
touch /tmp/alice.png &&

curl -F name=Alice -F age=25 -F photo=@/tmp/alice.png
  http://httpbingo.org/post
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Redirects

A _redirect_ is when the server, instead of returning the requested resource, tells the client that the resource is located elsewhere (as indicated by the Location header). A redirect always has a 3xx response code.

Curl does not follow redirects by default, it returns the response as is:

```sh
curl -i http://httpbingo.org/redirect/1
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To make curl follow redirects, use `--follow` (`-L`):

```sh
curl -L http://httpbingo.org/redirect/1
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

To protect against endless loop redirects, use `--max-redirs`:

```sh
curl -L --max-redirs 3 http://httpbingo.org/redirect/10
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### HTTP PUT

The PUT method is often used to send files to the server. Use `--upload-file` (`-T`) for this:

```sh
echo hello > /tmp/hello.txt &&

curl -T /tmp/hello.txt http://httpbingo.org/put
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Sometimes PUT is used for requests in REST APIs. For these, use `--request` (`-X`) to set the method and `--data` (`-d`) to send the data:

```sh
curl -X PUT -H "content-type: application/json"
  -d '{"name": "alice"}'
  http://httpbingo.org/put
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### Cookies

The HTTP protocol is stateless. Cookies are an ingenious way around this:

1.  The server wants to associate some state with the client session.
2.  The server returns that state in the Set-Cookie response header.
3.  The client recognizes the cookies and sends them back with each request in the Cookie request header.

Each cookie has an expiration date — either explicit one or "end of session" one (for browser clients, this is often when the user closes the browser).

Curl ignores cookies by default. To enable them, use the `--cookie` (`-b`) option. To make curl persist cookies between calls, use `--cookie-jar` (`-c`).

Here the server sets the cookie `sessionid` to `123456` and curl stores it in the cookie jar `/tmp/cookies`:

```sh
curl -b "" -c /tmp/cookies
  http://httpbingo.org/cookies/set?sessionid=123456

&& cat /tmp/cookies
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

Subsequent curl calls with `-b /tmp/cookies` will send the `sessionid` cookie back to the server.

Curl automatically discards cookies from the cookie jar when they expire (this requires an explicit expiration date set by the server). To discard session-based cookies, use `--junk-session-cookies` (`-j`):

```sh
curl -j -b /tmp/cookies http://httpbingo.org/get
```

### Alternative services

The Alt-Svc HTTP response header indicates that there is another network location (an _alternative service_) that the client can use for future requests.

To enable alternative services, use `--alt-svc`. This tells curl to store the services in the specified file and consider them for future requests.

```sh
curl --alt-svc /tmp/altsvc -o /dev/null
  http://httpbingo.org/get

&& cat /tmp/altsvc
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

### HTTP Strict Transport Security

The HTTP Strict-Transport-Security response header (also known as HSTS) informs the client that the server should only be accessed via HTTPS, and that any future attempts to access it via HTTP should automatically be converted to HTTPS.

To make curl respect HSTS, use `--hsts`. This tells curl to store HSTS-enabled servers in the specified file and automatically convert http → https when accessing them.

```sh
curl --hsts /tmp/hsts -o /dev/null
  http://httpbingo.org/get

&& cat /tmp/hsts
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>

## Further reading

There are two great resources if you want to dig deeper:

-   [man curl](https://curl.se/docs/manpage.html)
-   [Everything curl](https://everything.curl.dev/)

Here are some final words of wisdom for you:

```sh
curl http://httpbingo.org/status/418
```

<codapi-snippet sandbox="net-tools" command="curl" editor="basic">
</codapi-snippet>
