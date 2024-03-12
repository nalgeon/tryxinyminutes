# Contributing

Feel free to add your own interactive guides or improve existing ones. Here is how to do it.

[Setup local environment](#setup-local-environment) •
[Add a new guide](#add-a-new-guide) •
[Make the guide interactive](#make-the-guide-interactive) •
[Improve an existing guide](#improve-an-existing-guide) •
[Explain by example](#explain-by-example) •
[Make a pull request](#make-a-pull-request)

## Setup local environment

Fork the [repo](https://github.com/nalgeon/tryxinyminutes) on GitHub and clone the fork locally:

```sh
git clone https://github.com/yourname/tryxinyminutes.git
```

Install [MkDocs](https://www.mkdocs.org/):

```sh
pip install mkdocs
```

Start the local server:

```sh
cd tryxinyminutes
mkdocs serve
```

Open the site in the browser:

```
http://localhost:3000/try/
```

While `mkdocs serve` is running, it automatically applies any changes you make and refreshes the page in the browser.

## Add a new guide

You can pick any guide from [Learn X in Y minutes](https://github.com/adambard/learnxinyminutes-docs/), any other guide available under a permissive license (like Creative Commons, MIT, or Apache), or write your own.

Let's say you've decided to write about the `date` POSIX command.

Create a directory and an index file:

```sh
mkdir try/date
touch try/date/index.md
```

Edit `index.md` and add some metadata:

```yaml
---
x: date
title: Try `date` in Y minutes
image: /try/cover.png
lastmod: 2024-02-16
license: CC BY-SA 4.0
contributors:
    - ["Your Name", "https://github.com/yourname"]
---
```

Add some examples:

````
`date` display or sets the system date and time.

Display the current local date in the default format:

```
date
```

Display the current UTC date:

```
date --utc
```

Display the date in a custom format:

```
date +%Y-%m-%d
```

...
````

To view the guide in a browser, visit http://localhost:3000/try/date

## Make the guide interactive

To make examples interactive, use the [codapi-js](https://github.com/nalgeon/codapi-js) widget. It's already enabled in your local environment, so all you need to do is use it in the guide. There is no need to install the Codapi server — your local environment uses the cloud instance.

Add a `codapi-snippet` for each static code example:

````
`date` display or sets the system date and time.

Display the current local date in the default format:

```
date
```

<codapi-snippet sandbox="shell" editor="basic">
</codapi-snippet>

Display the date in a custom format:

```
date +%Y-%m-%d
```

<codapi-snippet sandbox="shell" editor="basic">
</codapi-snippet>

...
````

Open the guide in a browser: http://localhost:3000/try/date

You'll see Run and Edit buttons below each example. Try them out to see how they work.

Learn more about the widget features in the `codapi-js` [documentation](https://github.com/nalgeon/codapi-js#advanced-features). In particular, read about templates and code cells — you'll probably use them a lot when writing more complex examples.

See the list of available sandboxes on the [Codapi website](https://codapi.org/#sandboxes). If you need a specific sandbox that's currently missing — [let me know](https://github.com/orgs/codapi-org/discussions/1).

## Improve an existing guide

Some guides need improvement (they usually say so), so feel free to contribute to them. The process is the same as creating a new guide, but you work with an existing `try/someguide/index.md` file instead of creating a new one.

## Explain by example

Use clear, simple language that's approachable for a wide range of technical readers. Use the active voice whenever possible. When contributing to existing guides, follow the original style and tone of the guide so that it looks and reads consistent.

Do not write long, theory-heavy passages. Always explain by example. If you can't explain something with an example, it's probably best not to mention it at all.

Make sure all examples work. There should be no errors when the reader clicks _Run_ (unless the error is expected according to the example).

## Make a pull request

When the guide looks good, commit and push the code. Then [make a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) on GitHub.

I'll review the pull request and let you know if there are any issues. When everything is resolved, I'll merge the changes and publish the updated guide to [codapi.org/try](https://codapi.org/try/).

That's it!
