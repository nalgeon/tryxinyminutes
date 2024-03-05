---
x: Caddy
title: Try Caddy in Y minutes
image: /try/caddy/cover.png
lastmod: 2024-03-03
original: https://caddyserver.com/docs/getting-started
license: Apache-2.0
contributors:
    - ["Caddy contributors", "https://caddyserver.com/"]
    - ["Anton Zhiyanov", "https://antonz.org/"]
---

[Caddy](https://caddyserver.com/) is a powerful, extensible server platform to serve your sites, services, and apps. Most people use Caddy as a web server or proxy.

This interactive guide introduces the basics of Caddy, Caddy API and the Caddyfile. You can try all examples without leaving the browser or installing anything.

[**Getting started**](#getting-started) -
[Running Caddy](#running-caddy) ·
[Your first config](#your-first-config) ·
[Your first Caddyfile](#your-first-caddyfile) ·
[JSON vs. Caddyfile](#json-vs-caddyfile) ·
[API vs. Config files](#api-vs-config-files) ·
[Start, stop, run](#start-stop-run)

[**Caddy API**](#caddy-api) -
[Reloading config](#reloading-config) ·
[Basic config](#basic-config) ·
[Config traversal](#config-traversal) ·
[Using @id tag](#using-id-tag)

[**Caddyfile**](#caddyfile) -
[First site](#first-site) ·
[Adding functionality](#adding-functionality) ·
[Multiple sites](#multiple-sites) ·
[Matchers](#matchers) ·
[Environment variables](#environment-variables) ·
[Comments](#comments)

<div class="tryx__panel">
<p>✨ This is an open source guide. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/caddy/index.md">improve it</a>!</p>
</div>

## Getting started

Let's explore the basics of using Caddy and get familiar with it at a high level.

### Running Caddy

Let's start by running it:

```sh
caddy
```

<codapi-snippet sandbox="caddy" editor="basic" template="head.sh" output>
</codapi-snippet>

```
Caddy is an extensible server platform written in Go.

At its core, Caddy merely manages configuration. Modules are plugged
in statically at compile-time to provide useful functionality. Caddy's
standard distribution includes common modules to serve HTTP, TLS,
and PKI applications, including the automation of certificates.
```

Oops; without a subcommand, the `caddy` command only displays help text. You can use this any time you forget what to do.

To start Caddy as a daemon, use the `run` subcommand:

```sh
caddy run
```

<codapi-snippet sandbox="caddy" editor="basic" template="bg.sh" output>
</codapi-snippet>

```

```

This blocks forever, but what is it doing? At the moment... nothing. By default, Caddy's configuration ("config") is blank. We can verify this using the [admin API](https://caddyserver.com/docs/api) in another terminal:

```sh
curl localhost:2019/config/
```

<codapi-snippet sandbox="caddy" command="exec" template="exec.sh" editor="basic" output>
</codapi-snippet>

```
null
```

`null` is an actual response from Caddy. It's not very informative because of the empty config.

> localhost:2019 is not your website: this administration endpoint is used for controlling Caddy and is restricted to localhost by default.

We can make Caddy useful by giving it a config. This can be done many ways, but we'll start by making a POST request to the [/load](https://caddyserver.com/docs/api#post-load) endpoint using `curl` in the next section.

### Your first config

To prepare our request, we need to make a config. At its core, Caddy's configuration is simply a [JSON document](https://caddyserver.com/docs/json/).

Save this to a JSON file (e.g. `caddy.json`):

```json
{
    "apps": {
        "http": {
            "servers": {
                "example": {
                    "listen": [":2015"],
                    "routes": [
                        {
                            "handle": [
                                {
                                    "handler": "static_response",
                                    "body": "Hello, world!"
                                }
                            ]
                        }
                    ]
                }
            }
        }
    }
}
```

<codapi-snippet id="caddy.json" sandbox="caddy" command="validate-json" editor="basic" output>
</codapi-snippet>

```
Valid configuration
```

> You do not have to use config files, but we are for this tutorial. Caddy's [admin API](https://caddyserver.com/docs/api) is designed for use by other programs or scripts.

Then upload it:

```sh
curl localhost:2019/load \
    -H "Content-Type: application/json" \
    -w "status: %{response_code}" \
    -d @caddy.json
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="#caddy.json" output>
</codapi-snippet>

```
status: 200
```

We can verify that Caddy applied our new config with another GET request:

```sh
curl localhost:2019/config/
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="load.sh" files="#caddy.json" output>
</codapi-snippet>

```
{"apps":{"http":{"servers":{"example":{"listen":[":2015"],"routes":[{"handle":[{"body":"Hello, world!","handler":"static_response"}]}]}}}}}
```

Test that it works by going to `localhost:2015` in your browser or use `curl`:

```sh
curl localhost:2015
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="load.sh" files="#caddy.json" output>
</codapi-snippet>

```
Hello, world!
```

If you see _Hello, world!_, then congrats — it's working! It's always a good idea to make sure your config works as you expect, especially before deploying into production.

Try changing the `body` in the `caddy.json` above and note how the `curl` response changes.

### Your first Caddyfile

That was _kind of a lot of work_ just for Hello World.

Another way to configure Caddy is with the [Caddyfile](https://caddyserver.com/docs/caddyfile). The same config we wrote in JSON above can be expressed simply as:

```text
:2015

respond "Hello, world!"
```

<codapi-snippet id="Caddyfile" sandbox="caddy" command="validate" editor="basic" output>
</codapi-snippet>

```
Valid configuration
```

Save that to a file named `Caddyfile` (no extension) in the current directory.

Stop Caddy if it is already running (`Ctrl`+`C`), then run:

```sh
# or if your Caddyfile is somewhere else:
# caddy adapt --config /path/to/Caddyfile
caddy adapt
```

<codapi-snippet sandbox="caddy" editor="basic" files="#Caddyfile" output>
</codapi-snippet>

```
{"apps":{"http":{"servers":{"srv0":{"listen":[":2015"],"routes":[{"handle":[{"body":"Hello, world!","handler":"static_response"}]}]}}}}}
```

You will see JSON output! What happened here?

We just used a [config adapter](https://caddyserver.com/docs/config-adapters) to convert our Caddyfile to Caddy's native JSON structure.

While we could take that output and make another API request, we can skip all those steps because the `caddy` command can do it for us. If there is a file called Caddyfile in the current directory and no other config is specified, Caddy will load the Caddyfile, adapt it for us, and run it right away.

Now that there is a Caddyfile in the current folder, let's do `caddy run` again:

```sh
# or if your Caddyfile is somewhere else:
# caddy run --config /path/to/Caddyfile
caddy run
```

<codapi-snippet sandbox="caddy" editor="basic" template="bg.sh" files="#Caddyfile" output>
</codapi-snippet>

```

```

(If it is called something else that doesn't start with "Caddyfile", you will need to specify `--adapter caddyfile`)

You can now try loading your site again and you will see that it is working:

```sh
curl localhost:2015
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="#Caddyfile" output>
</codapi-snippet>

```
Hello, world!
```

Try changing the `Caddyfile` contents above and note how the `curl` response changes.

As you can see, there are several ways you can start Caddy with an initial config:

-   A file named Caddyfile in the current directory
-   The `--config` flag (optionally with the `--adapter` flag)
-   The `--resume` flag (if a config was loaded previously)

### JSON vs. Caddyfile

Now you know that the Caddyfile is just converted to JSON for you.

The Caddyfile seems easier than JSON, but should you always use it? There are pros and cons to each approach. The answer depends on your requirements and use case. JSON is easy to generate and automate, so it's meant for programs. Caddyfile is easy to craft by hand, so it's meant for humans.

It is important to note that both JSON and the Caddyfile (and any other supported [config adapter](https://caddyserver.com/docs/config-adapters)) can be used with [Caddy's API](https://caddyserver.com/docs/api). However, you get the full range of Caddy's functionality and API features if you use JSON. If using a config adapter, the only way to load or change the config with the API is the [/load endpoint](https://caddyserver.com/docs/api#post-load).

### API vs. Config files

You will also want to decide whether your workflow is API-based or CLI-based. (You _can_ use both the API and config files on the same server, but we don't recommend it: best to have one source of truth.)

> Under the hood, even config files go through Caddy's API endpoints; the `caddy` command just wraps up those API calls for you.

The choice of API or config file workflow is orthogonal to the use of config adapters: you can use JSON but store it in a file and use the command line interface; conversely, you can also use the Caddyfile with the API.

But most people will use JSON+API or Caddyfile+CLI combinations.

As you can see, Caddy is well-suited for a wide variety of use cases and deployments!

### Start, stop, run

Since Caddy is a server, it runs indefinitely. That means your terminal won't unblock after you execute `caddy run` until the process is terminated (usually with `Ctrl`+`C`).

Although `caddy run` is the most common and is usually recommended (especially when making a system service!), you can alternatively use `caddy start` to start Caddy and have it run in the background:

```sh
caddy start
```

<codapi-snippet sandbox="caddy" editor="basic" output>
</codapi-snippet>

```
Successfully started Caddy (pid=42) - Caddy is running in the background
```

This will let you use your terminal again, which is convenient in some interactive headless environments.

You will then have to stop the process yourself, since `Ctrl`+`C` won't stop it for you:

```sh
caddy stop
```

<codapi-snippet sandbox="caddy" editor="basic" template="start.sh" output-mode="hidden">
</codapi-snippet>

Or use the [/stop endpoint](https://caddyserver.com/docs/api#post-stop) of the API.

### Reloading config

Your server can perform zero-downtime config reloads/changes.

All [API endpoints](https://caddyserver.com/docs/api) that load or change config are graceful with zero downtime.

When using the command line, however, it may be tempting to use `Ctrl`+`C` to stop your server and then restart it again to pick up the new configuration. Don't do this: stopping and starting the server is orthogonal to config changes, and will result in downtime.

> Stopping your server will cause the server to go down.

Instead, use the `caddy reload` command for a graceful config change:

```sh
caddy reload
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" files="#Caddyfile" output>
</codapi-snippet>

```
{"level":"info","ts":1709475992.0607605,"msg":"using adjacent Caddyfile"}
```

This actually just uses the API under the hood. It will load and, if necessary, adapt your config file to JSON, then gracefully replace the active configuration without downtime.

If there are any errors loading the new config, Caddy rolls back to the last working config.

> Technically, the new config is started before the old config is stopped, so for a brief time, both configs are running! If the new config fails, it aborts with an error, while the old one is simply not stopped.

## Caddy API

Let's explore Caddy's admin API, which makes it possible to automate in a programmable fashion.

### Basic config

Let's get back to our JSON config in `caddy.json`:

```json
{
    "apps": {
        "http": {
            "servers": {
                "example": {
                    "listen": [":2015"],
                    "routes": [
                        {
                            "handle": [
                                {
                                    "handler": "static_response",
                                    "body": "Hello, world!"
                                }
                            ]
                        }
                    ]
                }
            }
        }
    }
}
```

As you probably remember, we used the `/load` API method to apply it:

```sh
curl localhost:2019/load \
    -H "Content-Type: application/json" \
    -d @caddy.json
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="caddy.json" output-mode="hidden">
</codapi-snippet>

### Config traversal

Suppose we want to change the `body` from `Hello, world!` to some other phrase. Instead of uploading the entire config file for a small change, let's use a powerful feature of Caddy's API to make the change without ever touching our config file.

> Making little changes to production servers by replacing the entire config can be dangerous; it's like having root access to a file system. Caddy's API lets you limit the scope of your changes to guarantee that other parts of your config don't get changed accidentally.

Using the request URI's path, we can traverse into the config structure and update only the message string (be sure to scroll right if clipped):

```sh
curl \
    localhost:2019/config/apps/http/servers/example/routes/0/handle/0/body \
    -H "Content-Type: application/json" \
    -d '"Work smarter, not harder."'
```

<codapi-snippet id="update-body-1" sandbox="caddy" command="exec" editor="basic" template="load.sh" files="caddy.json" output-mode="hidden">
</codapi-snippet>

> Every time you change the config using the API, Caddy persists a copy of the new config so you can [--resume it later](https://caddyserver.com/docs/command-line#caddy-run)!

You can verify that it worked with a similar GET request, for example:

```sh
curl localhost:2019/config/apps/http/servers/example/routes
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="load.sh" files="caddy.json" depends-on="update-body-1" output>
</codapi-snippet>

```
[{"handle":[{"body":"Work smarter, not harder.","handler":"static_response"}]}]
```

You can use the `jq` command to prettify JSON output:

```sh
curl localhost:2019/config/apps/http/servers/example/routes | jq
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="load.sh" files="caddy.json" depends-on="update-body-1" output>
</codapi-snippet>

```
[
  {
    "handle": [
      {
        "body": "Work smarter, not harder.",
        "handler": "static_response"
      }
    ]
  }
]
```

**Important note**: This should be obvious, but once you use the API to make a change that is not in your original config file, your config file becomes obsolete. There are a few ways to handle this:

-   Use the `--resume` of the [caddy run](https://caddyserver.com/docs/command-line#caddy-run) command to use the last active config.
-   Don't mix the use of config files with changes via the API; have one source of truth.
-   [Export Caddy's new configuration](https://caddyserver.com/docs/api#get-configpath) with a subsequent GET request (less recommended than the first two options).

### Using @id tag

Config traversal is certainly useful, but the paths are little long, don't you think?

We can give our handler object an [`@id` tag](https://caddyserver.com/docs/api#using-id-in-json) to make it easier to access:

```sh
curl \
    localhost:2019/config/apps/http/servers/example/routes/0/handle/0/@id \
    -H "Content-Type: application/json" \
    -d '"msg"'
```

<codapi-snippet id="set-id" sandbox="caddy" command="exec" editor="basic" template="load.sh" files="caddy.json" depends-on="update-body-1" output-mode="hidden">
</codapi-snippet>

This adds a property to our handler object: `"@id": "msg"`, so it now looks like this:

```json
{
    "@id": "msg",
    "body": "Work smarter, not harder.",
    "handler": "static_response"
}
```

> `@id` tags can go in any object and can have any primitive value (usually a string). [Learn more](https://caddyserver.com/docs/api#using-id-in-json)

We can then access it directly:

```sh
curl localhost:2019/id/msg
```

<codapi-snippet id="set-id" sandbox="caddy" command="exec" editor="basic" template="load.sh" files="caddy.json" depends-on="set-id" output>
</codapi-snippet>

```
{"@id":"msg","body":"Work smarter, not harder.","handler":"static_response"}
```

And now we can change the message with a shorter path:

```sh
curl \
    localhost:2019/id/msg/body \
    -H "Content-Type: application/json" \
    -d '"Some shortcuts are good."'
```

<codapi-snippet id="update-body-2" sandbox="caddy" command="exec" editor="basic" template="load.sh" files="caddy.json" depends-on="set-id" output-mode="hidden">
</codapi-snippet>

And check it again:

```sh
curl localhost:2019/id/msg/body
```

<codapi-snippet id="set-id" sandbox="caddy" command="exec" editor="basic" template="load.sh" files="caddy.json" depends-on="update-body-2" output>
</codapi-snippet>

```
"Some shortcuts are good."
```

## Caddyfile

Let's explore the basics of the [HTTP Caddyfile](https://caddyserver.com/docs/caddyfile) so that you can quickly and easily produce good-looking, functional site configs.

### First site

Create a new text file named `Caddyfile` (no extension).

The first thing you should type is your site's [address](https://caddyserver.com/docs/caddyfile/concepts#addresses):

```text
localhost
```

> If the HTTP and HTTPS ports (80 and 443, respectively) are privileged ports on your OS, you will either need to run with elevated privileges or use a higher port. To use a higher port, just change the address to something like `localhost:2015` and change the HTTP port using the [http_port](https://caddyserver.com/docs/caddyfile/options) Caddyfile option.

Then hit enter and type what you want it to do. For this tutorial, make your Caddyfile look like this:

```text
http://localhost

respond "Hello, world!"
```

<codapi-snippet id="caddyfile-1" editor="basic">
</codapi-snippet>

Save that and run Caddy (since this is a training tutorial, we'll use the `--watch` flag so changes to our Caddyfile are applied automatically):

```sh
caddy run --watch
```

<codapi-snippet sandbox="caddy" command="run" editor="basic" template="bg.sh" files="#caddyfile-1:Caddyfile" output-mode="hidden">
</codapi-snippet>

> If you get permissions errors, try using a higher port in your address (like `localhost:2015`) and [change the HTTP port](https://caddyserver.com/docs/caddyfile/options), or run with elevated privileges.

Caddy serves all sites over HTTPS by default as long as a host or IP is part of the site's address. [Automatic HTTPS](https://caddyserver.com/docs/automatic-https) can be disabled by prefixing the address with `http://` explicitly (that's what I did in the `Caddyfile` above).

Open `http://localhost` in your browser and see your web server working, complete with HTTPS! I'll use `curl` instead of the browser:

```sh
curl localhost
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="#caddyfile-1:Caddyfile" output>
</codapi-snippet>

```
Hello, world!
```

That's not particularly exciting, so let's change our static response to a [file server](https://caddyserver.com/docs/caddyfile/directives/file_server) with directory listings enabled:

```text
http://localhost

file_server browse
```

<codapi-snippet id="caddyfile-2" editor="basic">
</codapi-snippet>

Save your Caddyfile, then refresh your browser tab. You should either see a list of files or an HTML page if there is an index file in the current directory:

```sh
curl localhost
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="#caddyfile-2:Caddyfile" output-mode="iframe">
</codapi-snippet>

### Adding functionality

Let's do something interesting with our file server: serve a templated page. Create a new file and paste this into it:

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Caddy tutorial</title>
    </head>
    <body>
        Page loaded at: {{now | date "Mon Jan 2 15:04:05 MST 2006"}}
    </body>
</html>
```

<codapi-snippet id="caddy.html" editor="basic">
</codapi-snippet>

Save this as `caddy.html` in the current directory and load it in your browser:

```sh
curl localhost/caddy.html
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="#caddyfile-2:Caddyfile #caddy.html" output-mode="iframe">
</codapi-snippet>

Wait a minute. We should see today's date. Why didn't it work? It's because the server hasn't yet been configured to evaluate templates! Easy to fix, just add a line to the Caddyfile so it looks like this:

```text
http://localhost

templates
file_server browse
```

<codapi-snippet id="caddyfile-3" editor="basic">
</codapi-snippet>

Save that, then reload the browser tab:

```sh
curl localhost/caddy.html
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="#caddyfile-3:Caddyfile #caddy.html" output-mode="iframe">
</codapi-snippet>

With Caddy's [templates module](https://caddyserver.com/docs/modules/http.handlers.templates), you can do a lot of useful things with static files, such as including other HTML files, making sub-requests, setting response headers, working with data structures, and more!

Try changing the `caddy.html` template above, re-run the `curl` command, and see how the result changes.

It's good practice to compress responses with a quick and modern compression algorithm. Let's enable Gzip and Zstandard support using the [encode](https://caddyserver.com/docs/caddyfile/directives/encode) directive:

```text
http://localhost

encode zstd gzip
templates
file_server browse
```

> Browsers don't support Zstandard encodings yet. Hopefully soon!

That's the basic process for getting a semi-advanced, production-ready site up and running!

When you're ready to turn on [automatic HTTPS](https://caddyserver.com/docs/automatic-https), just replace your site's address (`http://localhost` in our tutorial) with your domain name. See the [HTTPS quick-start guide](https://caddyserver.com/docs/quick-starts/https) for more information.

### Multiple sites

With our current Caddyfile, we can only have the one site definition! Only the first line can be the address(es) of the site, and then all the rest of the file has to be directives for that site.

But it is easy to make it so we can add more sites!

Our Caddyfile so far:

```text
localhost

encode zstd gzip
templates
file_server browse
```

is equivalent to this one:

```text
localhost {
	encode zstd gzip
	templates
	file_server browse
}
```

except the second one allows us to add more sites.

By wrapping our site block in curly braces `{ }` we are able to define multiple, different sites in the same Caddyfile.

For example:

```text
:8080 {
	respond "I am 8080"
}

:8081 {
	respond "I am 8081"
}
```

<codapi-snippet id="caddyfile-4" editor="basic">
</codapi-snippet>

Let's try the port 8080:

```sh
curl localhost:8080
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="#caddyfile-4:Caddyfile" output>
</codapi-snippet>

```
I am 8080
```

Now try changing the port in the `curl` command to 8081 and see how the result changes.

When wrapping site blocks in curly braces, only [addresses](https://caddyserver.com/docs/caddyfile/concepts#addresses) appear outside the curly braces and only [directives](https://caddyserver.com/docs/caddyfile/directives) appear inside them.

For multiple sites which share the same configuration, you can add more addresses, for example:

```text
:8080, :8081 {
	...
}
```

You can then define as many different sites as you want, as long as each address is unique.

### Matchers

We may want to apply some directives only to certain requests. For example, let's suppose we want to have both a file server and a reverse proxy, but we obviously can't do both on every request! Either the file server will write a static file, or the reverse proxy will proxy the request to a backend.

This config will not work like we want:

```text
http://localhost

file_server
reverse_proxy 127.0.0.1:9005
```

In practice, we may want to use the reverse proxy only for API requests, i.e. requests with a base path of `/api/`. This is easy to do by adding a [matcher token](https://caddyserver.com/docs/caddyfile/matchers#syntax):

```text
http://localhost

file_server
reverse_proxy /api/* 127.0.0.1:9005
```

<codapi-snippet id="caddyfile-5" editor="basic">
</codapi-snippet>

There; now the reverse proxy will be prioritized for all requests starting with `/api/`:

```sh
curl -v localhost/api/status
```

<codapi-snippet sandbox="caddy" command="exec" editor="basic" template="exec.sh" files="#caddyfile-5:Caddyfile" output>
</codapi-snippet>

```
> GET /api/status HTTP/1.1
> Host: localhost
> User-Agent: curl/8.5.0
> Accept: */*
>
< HTTP/1.1 502 Bad Gateway
< Server: Caddy
< Date: Mon, 04 Mar 2024 19:42:42 GMT
< Content-Length: 0
```

(Caddy proxies the request to port 9005, where no one is listening, hence the 502 Bad Gateway response)

The `/api/*` token we just added is called a _matcher token_. You can tell it's a matcher token because it starts with a forward slash `/` and it appears right after the directive (but you can always look it up in the [directive's docs](https://caddyserver.com/docs/caddyfile/directives) to be sure).

Matchers are really powerful. You can name matchers and use them like `@name` to match on more than just the request path! Take a moment to [learn more about matchers](https://caddyserver.com/docs/caddyfile/matchers) before continuing!

### Environment variables

The Caddyfile adapter allows substituting [environment variables](https://caddyserver.com/docs/caddyfile/concepts#environment-variables) before the Caddyfile is parsed.

First, set an environment variable (in the same shell that runs Caddy):

```
export SITE_ADDRESS=localhost:9055
```

Then you can use it like this in the Caddyfile:

```text
{$SITE_ADDRESS}

respond "Hello from {$SITE_ADDRESS}"
```

<codapi-snippet id="caddyfile-6" editor="basic">
</codapi-snippet>

Before the Caddyfile is parsed, it will be expanded to:

```text
localhost:9055

respond "Hello from localhost:9055"
```

Let's check this:

```sh
export SITE_ADDRESS=localhost:9055
caddy start
curl localhost:2019/config/ | jq '.. | .body? // empty'
```

<codapi-snippet sandbox="caddy" command="run" editor="basic" template="exec.sh" files="#caddyfile-6:Caddyfile" output>
</codapi-snippet>

```
Successfully started Caddy (pid=42) - Caddy is running in the background
"Hello from localhost:9055"
```

### Comments

One last thing that you will find most helpful: if you want to remark or note anything in your Caddyfile, you can use comments, starting with `#`:

```text
# this starts a comment
```

## Further reading

For more information about Caddy, see the [documentation](https://caddyserver.com/docs/).
