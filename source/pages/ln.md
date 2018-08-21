---
title: "Shell tips: ln"
created: 2018-08-20

tags: [tech, shell, linux]
abstract: A simple way to remember how to use the "ln" command

---

## Argument order

Don't remember how to use `ln` to create a symbolic link?

Was it `ln -s original link` or `ln -s link original`?

For commands like `cp` and `mv`, there is a clear concept of `SOURCE` and
`DESTINATION`. You **copy**/**move** the **source** to the **destination**.
But for ln, are you creating a link **from** or **to** the original?


## How to remember

Back in college, I had a friend who mentioned to me a simple way to remember,
and I have never forgotten since then.

If you use ln with only one argument, the original, it will automatically
create the link in your current working directory.

For example, `ln -s /path/to/original` will create the link:

`original -> /path/to/original`

Thus, providing a second argument is simply giving the filename for the link.


## TL;DR

`ln -s original link`
