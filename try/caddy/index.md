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

This tutorial will explore the basics of using Caddy and help you get familiar with it at a high level.

[Running Caddy](#running-caddy) ·
[Your first config](#your-first-config) ·
[Your first Caddyfile](#your-first-caddyfile) ·
[JSON vs. Caddyfile](#json-vs-caddyfile) ·
[API vs. Config files](#api-vs-config-files) ·
[Start, stop, run](#start-stop-run) ·
[Reloading config](#reloading-config) ·
[Further reading](#further-reading)

<div class="tryx__panel">
<p>✨ This is an open source guide. Feel free to <a href="https://github.com/nalgeon/tryxinyminutes/blob/main/try/caddy/index.md">improve it</a>!</p>
</div>

## Running Caddy

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

<codapi-snippet sandbox="caddy" command="exec" editor="basic" output>
</codapi-snippet>

```
null
```

`null` is an actual response from Caddy. It's not very informative because of the empty config.

> localhost:2019 is not your website: this administration endpoint is used for controlling Caddy and is restricted to localhost by default.

We can make Caddy useful by giving it a config. This can be done many ways, but we'll start by making a POST request to the [/load](https://caddyserver.com/docs/api#post-load) endpoint using `curl` in the next section.

## Your first config

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

<codapi-snippet sandbox="caddy" command="exec" editor="basic" files="#caddy.json" output>
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

## Your first Caddyfile

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

<codapi-snippet sandbox="caddy" command="exec" editor="basic" files="#Caddyfile" output>
</codapi-snippet>

```
Hello, world!
```

Try changing the `Caddyfile` contents above and note how the `curl` response changes.

As you can see, there are several ways you can start Caddy with an initial config:

-   A file named Caddyfile in the current directory
-   The `--config` flag (optionally with the `--adapter` flag)
-   The `--resume` flag (if a config was loaded previously)

## JSON vs. Caddyfile

Now you know that the Caddyfile is just converted to JSON for you.

The Caddyfile seems easier than JSON, but should you always use it? There are pros and cons to each approach. The answer depends on your requirements and use case. JSON is easy to generate and automate, so it's meant for programs. Caddyfile is easy to craft by hand, so it's meant for humans.

It is important to note that both JSON and the Caddyfile (and any other supported [config adapter](https://caddyserver.com/docs/config-adapters)) can be used with [Caddy's API](https://caddyserver.com/docs/api). However, you get the full range of Caddy's functionality and API features if you use JSON. If using a config adapter, the only way to load or change the config with the API is the [/load endpoint](https://caddyserver.com/docs/api#post-load).

## API vs. Config files

You will also want to decide whether your workflow is API-based or CLI-based. (You _can_ use both the API and config files on the same server, but we don't recommend it: best to have one source of truth.)

> Under the hood, even config files go through Caddy's API endpoints; the `caddy` command just wraps up those API calls for you.

The choice of API or config file workflow is orthogonal to the use of config adapters: you can use JSON but store it in a file and use the command line interface; conversely, you can also use the Caddyfile with the API.

But most people will use JSON+API or Caddyfile+CLI combinations.

As you can see, Caddy is well-suited for a wide variety of use cases and deployments!

## Start, stop, run

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

## Reloading config

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

## Further reading

If you only have a few minutes and need to hit the ground running, try one of the [quick starts](https://caddyserver.com/docs/quick-starts).

It is highly recommended to follow-up by reading [API](https://caddyserver.com/docs/api-tutorial) and [Caddyfile](https://caddyserver.com/docs/caddyfile-tutorial) tutorials and other [documentation](https://caddyserver.com/docs/) to fully understand how your web server works.
