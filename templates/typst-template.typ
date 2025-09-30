#let report-header(
  title: none,
  date: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 11pt,
  line-height: 1em,
  heading-family: "libertinus serif",
  heading-line-height: 1em,
  toc: false,
  doc
) = {
  set par(justify: true,
          spacing: line-height)

  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)

  set table(inset: 6pt,
            stroke: none)

  show heading: it => {
    let heading-size = 1em
    let heading-scale = 1
    let heading-weight = "bold"
    let heading-style = "normal"
    let heading-font = heading-family

    if it.level == 1 {
      heading-size = 1.2em
      heading-scale = 1.4
    } else if it.level == 2 {
      heading-size = 1.2em
      heading-scale = 1.2
      heading-weight = "regular"
      heading-style = "italic"
    } else {
      heading-font = font
    }

    block(above: 1.5em/heading-scale, below: 1.5em/heading-scale)[
      #text(font: heading-font, size: heading-size/heading-scale,
            weight: heading-weight, style: heading-style)[
        #it
      ]
    ]
  }

  align(center)[
    #block()[
      #text(weight: "bold", size: 0.8em)[
        $params.department$ \
        $params.agency.full$ \
        $params.laboratory$ \
        $params.division$ \
        $params.location$
      ]
    ]
  ]

  align(center)[
    #block(above: 1.5em, below: 1.5em)[
      #text(font: heading-family, size: 1.5em, weight: "bold")[
        #title
      ]
    ]
  ]

  align(center)[
    #block()[
      #date
    ]
  ]

  if toc {
    block(above: 2em, below: 2em)[
      #outline(title: "Contents",
               depth: 2)
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}