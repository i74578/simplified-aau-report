#import "/setup/macros.typ": *
= Problem Analysis

It is easy to test a layout by providing blind text...

#lorem(30)


== Basic Syntax

A lot of the syntax is inspired by the Markdown syntax, like *bold* and _emphasised_ text.
The same goes with lists:

- Item 1
- Item 2
  - A sub-item

And enumerations:

1. Ordered item using a specified number
5. Another ordered item using a specified number
+ Ordered item using the previous number + 1

And even a terms list (like `description` in LaTeX):

/ Term: Description

This text is a new paragraph and is not attached to the term.

/ Another term: #[
  It is possible to have multiple paragraphs on the right-hand side of a paragraph though.

  Just nest it in a content block using the `#[]` notation.
]

The documentation also has a #link("https://typst.app/docs/guides/guide-for-latex-users/")[guide for LaTeX users].


== Revisioning

In the `setup/macros.typ` file you'll find macros to control revisions.
Use them if you want, or delete / ignore them.
The revision can be set in `main.typ` using ```typ #set-revision(n)```.

#rmv(1)[This is removed content for this revision and is highlighted as such.]
#add(1)[This is added content, highlighted for clarity.]
Doing both at once is also easy.
How #change(1)[is this great][great is this]!

#rmv(2)[Removed content in a future revision is not shown as removed yet.] // does show up
#rmv(0)[And removed content in an old revision is completely gone!] // does not show up
#add(2)[Likewise with added content, I am not shown yet] // does not show up
#add(0)[I was added in a previous iteration, and show up normally.] // does show up

These macros can be wrapped in pretty much anything, including chapters, figures and tables.
#alice[Does not flow well, rewrite later.]
#bob[I disagree]


== Figures <sec:figures>

Unlike LaTeX, Typst does not have floats.
All figures are placed immediately, or at the top or bottom of the page.
The default is immediately, but can be changed with ```typst placement: auto``` (or specifically `top` or `bottom`)

Labels for figures and headings are denoted by the ```typ <i-am-a-label>``` syntax, and referenced with an `@` sign.

In @sec:figures we show how figures work, specifically @tab:example.

#figure(
  table(
    columns: 2,
    stroke: none,
    [*Name*], [*Age*],
    table.hline(),
    [Alice], [25],
    [Bob], [28],
    [Chad], [24]
  ),
  caption: [I am placed is put in the document, and may cause bad page breaks.]
) <tab:example>

There are even functions to load data from various file formats including CSV and JSON or even plain text files
#footnote[https://typst.app/docs/reference/data-loading/].

=== Subfigures

Write subfigures using `subfig`, which uses the `subpar` package internally (see `macros.typ`).

These can be individually referenced as @a, @b and @full.

#subfig(
  figure(
    // normally, you would put `image("../figures/image.png")` here
    [_First image goes here_],
    caption: [
      The subcaption
    ]
  ), <a>,

  figure(
    [_Second image goes here_],
    caption: [
      The second subcaption
    ]
  ), <b>,

  columns: (1fr, 1fr),
  caption: [A figure composed of two sub figures.],
  label: <full>,
)

#figure([content], caption: "yess")


== Citing

The citation style is determined by the ```typ bibliography()``` command in `main.typ`
#footnote[https://typst.app/docs/reference/model/bibliography/].

Citing works the same as referencing, by using `@`. @einstein
It's also possible to add a supplement to the source using ```typ @source[supplement]``` notation.
@einstein[pp.~10]

We can also change the citation style using the ```typ #cite()``` command:

... This has been shown by #cite(form: "prose", <einstein>).


== Math

The math syntax is fundamentally different from its LaTeX counterpart.
We can make inline math $a^2 + b^2 = c^2$.

And blocked equations by adding spaces in the `$` notation, as seen in @eq:quad-polym-roots.
$ x = (-b plus.minus sqrt(b^2 − 4 a c)) / (2 dot a)  $ <eq:quad-polym-roots>


== Listings

Typst has bulitin support for raw code blocks with syntax-highlighting.

These can be placed as is:

```typ
This is `typst` source code.

This means that *bold* is _highlighted_, and
#show: block
are also highlighted as expected
```
#bob(side: left)[I'm manually placed on the left]
#alice[Notice the blank line in the raw code block.]

Or inside a figure:

#figure(
  // it is also possible to load an external file and syntax higlight it.
  // raw(read("main.rs"), lang: "rust")
  ```rust
fn main() {
  println!("Hello, World!");
}
  ```,
  caption: [A piece of Rust code.]
)

== A note on `todonotes`

The todo macros attempts to mimic the `todonotes` package for LaTeX.
It is not perfect, but it works in most scenarios.

Please note 4 or more notes in a row will give a compiler warning (if they overlap), as the Typst compiler tries to move the notes and eventually gives up.
You can either ignore the warning (at some point the notes will just be placed immediately and overlap), or move the notes around using the `side: (left | right | auto)` argument.
