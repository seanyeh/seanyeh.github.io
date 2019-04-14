---
title: Revisiting the Monty Hall Problem with Elm
created: 2018-09-24

tags: [probability, tech, elm]

---

## Monty Hall Variant

I came across the
[Monty Hall Problem](https://en.wikipedia.org/wiki/Monty_Hall_problem)
again the other day, and thought of a variant to the original problem: what if,
after the player chooses the initial door, the host opens a door randomly? Now, if
the host accidentally opens the door with the car, then the problem becomes
pointless. But, let's say that if the host opens a random door, **given** it's
a goat, is it still advantageous to swap choices? This is a case of
[conditional probability](https://en.wikipedia.org/wiki/Conditional_probability),
and I suspect that this is part of the reason why the solution to the original
problem seems so counter-intuitive.


It turns out that this variant (among many many others) has been discussed
before, and the consensus is that the chance of winning becomes 50-50. However,
I still went ahead and built a simulation to see the results for myself.


## First steps in Elm

I took this opportunity to dive into a programming language that I've been
interested in for a while: [Elm](http://elm-lang.org/). After a quiet 2 years
(almost) of no major releases or posts on their official blog, Elm finally came
out with version 0.19 last month.

Despite having some experience with functional programming languages (OCaml,
Lisp), I initially found it challenging to wrap my mind around some
of the concepts in Elm, such as subscriptions, commands, and
[random number generation](https://guide.elm-lang.org/effects/random.html).
I also have noticed that, as of this writing, a **lot** of resources online are
outdated, including [https://elm-tutorial.org](https://elm-tutorial.org),
making the learning process a bit more difficult.
(Even all the `elm` build commands have changed!).

Nevertheless, I was able to get through the basics, and wrote the
[simulation](https://seanyeh.github.io/monty-elm/).
I look forward to working with Elm more in the future!


