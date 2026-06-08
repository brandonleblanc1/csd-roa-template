// Some definitions presupposed by pandoc's typst output.
#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let horizontalrule = line(start: (25%, 0%), end: (75%, 0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms.item: it => block(breakable: false)[
  #text(weight: "bold")[#it.term]
  #block(inset: (left: 1.5em, top: -0.4em))[#it.description]
]

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
  fill: luma(230),
  width: 100%,
  inset: 8pt,
  radius: 2pt,
)

#let block_with_new_content(old_block, new_content) = {
  let fields = old_block.fields()
  let _ = fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }
}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
        kind: kind,
        supplement: supplement,
        caption: caption,
        {
          show figure.where(kind: kind): set figure(numbering: _ => {
            let subfloat-idx = quartosubfloatcounter.get().first() + 1
            subfloat-numbering(n-super, subfloat-idx)
          })
          show figure.where(kind: kind): set figure.caption(position: position)

          show figure: it => {
            let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
            show figure.caption: it => block({
              num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
              [ ]
              it.body
            })

            quartosubfloatcounter.step()
            it
            counter(figure.where(kind: it.kind)).update(n => n - 1)
          }

          quartosubfloatcounter.update(0)
          body
        },
      )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let children = old_title_block.body.body.children
  let old_title = if children.len() == 1 {
    children.at(0) // no icon: title at index 0
  } else {
    children.at(1) // with icon: title at index 1
  }

  // TODO use custom separator if available
  // Use the figure's counter display which handles chapter-based numbering
  // (when numbering is a function that includes the heading counter)
  let callout_num = it.counter.display(it.numbering)
  let new_title = if empty(old_title) {
    [#kind #callout_num]
  } else {
    [#kind #callout_num: #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block,
    block_with_new_content(
      old_title_block.body,
      if children.len() == 1 {
        new_title // no icon: just the title
      } else {
        children.at(0) + new_title // with icon: preserve icon block + new title
      },
    ),
  )

  align(left, block_with_new_content(old_callout, block(below: 0pt, new_title_block) + old_callout.body.children.at(1)))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(
  body: [],
  title: "Callout",
  background_color: rgb("#dddddd"),
  icon: none,
  icon_color: black,
  body_background_color: white,
) = {
  block(
    breakable: false,
    fill: background_color,
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"),
    width: 100%,
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%,
      below: 0pt,
      block(
        fill: background_color,
        width: 100%,
        inset: 8pt,
      )[#if icon != none [#text(icon_color, weight: 900)[#icon] ]#title],
    )
      + if (body != []) {
        block(
          inset: 1pt,
          width: 100%,
          block(fill: body_background_color, width: 100%, inset: 8pt, body),
        )
      },
  )
}

$if(margin-geometry)$
// Margin layout support using marginalia package
#import "@preview/marginalia:0.3.1" as marginalia: note, notefigure, wideblock

// Render footnote as margin note using standard footnote counter
// Used via show rule: #show footnote: it => column-sidenote(it.body)
// The footnote element already steps the counter, so we just display it
#let column-sidenote(body) = {
  context {
    let num = counter(footnote).display("1")
    // Superscript mark in text
    super(num)
    // Content in margin with matching number
    note(
      alignment: "baseline",
      shift: auto,
      counter: none, // We display our own number from footnote counter
    )[
      #super(num) #body
    ]
  }
}

// Note: Margin citations are now emitted directly from Lua as #note() calls
// with #cite(form: "full") + locator text, preserving citation locators.

// Utility: compute padding for each side based on side parameter
#let side-pad(side, left-amount, right-amount) = {
  let l = if side == "both" or side == "left" or side == "inner" { left-amount } else { 0pt }
  let r = if side == "both" or side == "right" or side == "outer" { right-amount } else { 0pt }
  (left: l, right: r)
}

// body-outset: extends ~15% into margin area
#let column-body-outset(side: "both", body) = context {
  let r = marginalia.get-right()
  let out = 0.15 * (r.sep + r.width)
  pad(..side-pad(side, -out, -out), body)
}

// page-inset: wideblock minus small inset from page boundary
#let column-page-inset(side: "both", body) = context {
  let l = marginalia.get-left()
  let r = marginalia.get-right()
  // Inset is a small fraction of the extension area (wideblock stops at far)
  let left-inset = 0.15 * l.sep
  let right-inset = 0.15 * (r.sep + r.width)
  wideblock(side: side)[#pad(..side-pad(side, left-inset, right-inset), body)]
}

// screen-inset: full width minus `far` distance from edges
#let column-screen-inset(side: "both", body) = context {
  let l = marginalia.get-left()
  let r = marginalia.get-right()
  wideblock(side: side)[#pad(..side-pad(side, l.far, r.far), body)]
}

// screen-inset-shaded: screen-inset with gray background
#let column-screen-inset-shaded(body) = context {
  let l = marginalia.get-left()
  wideblock(side: "both")[
    #block(fill: luma(245), width: 100%, inset: (x: l.far, y: 1em), body)
  ]
}
$endif$

$if(highlighting-definitions)$
// syntax highlighting functions from skylighting:
$highlighting-definitions$

$endif$

// BPL custom definitions.
// Package imports.
#import "@preview/decasify:0.11.3": sentencecase, titlecase

// Function for formatting dates.
//
// param: `dt`
//   A datetime object.
#let format-date(
  dt,
) = {
  if type(dt) == datetime {
    dt.display("[day padding:zero] [month repr:long] [year repr:full]")
  } else {
    panic("Argument must be a datetime!")
  }
}

// Function to format SI units given a value and common unit.
//
// param: `content`
//   Content to format. Should be specified as [`value` `units`], where
//   `value` is the magnitude and `units` is one of the following: percent
//   (or %), ppm, or ppb.
#let make-units(
  content,
) = {
  content = content.text.split()
  let value = [#float(content.at(0))]
  let units = content.at(1)

  let prefix = if units in ("percent", "%") {
    [c]
  } else if units == "ppm" {
    sym.mu
  } else if units == "ppb" {
    [n]
  } else {
    panic("This unit has not been implemented!")
  }

  (
    value + sym.space.nobreak + prefix + [mol] + sym.space.nobreak + [mol] + super(sym.minus + [1])
  )
}

// Function to generate references section.
//
// param: `sources`
//   Content to format the references section. Should be specified as
//   [`sources` `style`], where `sources` is either a .bib or Hayagriva .yml
//   file containing references information, and `style` is a valid Typst
//   style identifier.
#let make-refs(
  sources,
) = {
  sources = sources.children.at(1).text.split()
  bibliography(sources.at(0), style: sources.at(1))
}

// Function to format author names.
//
// param: `name`
//   Author's first and last name.
// param: `title`
//   Position title of author.
// param: `email`
//   Optional author email. Defaults to "first.last@nist.gov" if not provided.
#let add-author(
  name: none,
  title: none,
  email: none,
) = {
  if email == none {
    email = name.split().map(lower).join(".") + "@nist.gov"
  }

  set par(justify: false)

  // Adding mail emoji with mailto link
  (
    box(
      name
        + sym.space.nobreak
        + box(
          baseline: -0.1em,
          link(
            "mailto:" + email,
            text(
              size: 0.6em,
              emoji.mail,
            ),
          ),
        ),
    )
      + linebreak()
      + title
  )
}

// Function to display author names in a grid.
//
// param: `authors`
//   Dictionary of authors with the following keys: name, title, email.
#let display-authors(
  authors,
) = {
  let ncols = 3
  let count = authors.len()
  let rem = calc.rem(count, ncols)
  let empty = (title: "")

  // Specifying where blank content should go depending on number of authors
  if rem != 0 and count != 1 {
    if rem == 1 {
      authors.insert(-3, empty)
    }

    authors.insert(-1, empty)
  }

  grid(
    align: left,
    columns: (1fr,) * ncols,
    inset: (top: 0.5in),
    row-gutter: 1em,
    ..authors.map(
      author => {
        if "name" in author {
          add-author(..author)
        } else []
      },
    )
  )
}

// Function to display correct font for equation numberings.
#let equation-numbering(
  num,
) = {
  text(
    font: $brand.typography.base.family$,
    [(#num)],
  )
}

// Other useful variables.
#let today-date = format-date(datetime.today())
