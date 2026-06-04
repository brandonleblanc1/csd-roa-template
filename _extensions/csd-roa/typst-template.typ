// Main Report of Analysis template.
//
#let report-template(
  roa-num,
  submitted-to,
  title,
  purpose,
  lab-dates,
  methods,
  controls,
  quality-docs,
  srms: none,
  constituents: none,
  assigned-value: none,
  exp-date: none,
  collaborators: none,
  agreements: none,
  approvals: none,
  copies-to: none,
  prepared-by,
  reviewed-by,
  doc
) = {
  // setting general properties associated with body text
  set text(
    font: $brand.typography.base.family$,
    size: $brand.typography.base.size$,
    hyphenate: false,
  )
  // setting general paragraph properties
  set par(
    justify: true,
    spacing: 1em,
    leading: 0.5em,
  )
  // setting page properties for document body
  set page(
    paper: "us-letter",
    margin: 1in,
    header: align(right, [ROA #roa-num]),
    footer: context {
      let current = counter(page).display()
      let total = counter(page).final().first()
      align(center, [Page #current of #total])
    },
  )
  set rect(inset: 0pt)
  // customizing how bibliography is shown
  set bibliography(title: none)
  show bibliography: it => {
    show underline: it => it.body
    it
  }
  // changing indentation style of bulleted lists
  set list(
    indent: 0.25in,
    body-indent: 1.5em
  )
  // underline links
  show link: underline
  // setting font for math equations
  show math.equation: set text(font: "$fonts.math-font$")
  // modifying how headings are displayed
  show heading: it => {
    let heading-size = 1em
    // Typst automatically scales level 1 and 2 headings
    let heading-scale = 1
    let heading-weight = "regular"
    let heading-style = "normal"
    let heading-content = [#sentencecase(it.body)]

    if it.level == 1 {
      heading-size = 1.2em
      heading-scale = 1.4
      heading-weight = "bold"
      heading-content = [#titlecase(it.body)]
    } else if it.level == 2 {
      heading-size = 1.1em
      heading-scale = 1.2
      heading-weight = "bold"
      heading-style = "italic"
    } else if it.level == 3 {
      heading-style = "italic"
    }

    block(
      above: 1em,
      text(
        font: $brand.typography.headings.family$,
        size: heading-size / heading-scale,
        weight: heading-weight,
        style: heading-style,
        heading-content
      ),
    )
  }

  // customizing the cover page of the ROA
  {
    set page(
      background: align(
        left + top,
        box(
          inset: (
            left: 0.3in,
            top: 0.25in,
          ),
          image(
            "$logos.nist-logo$",
            width: 2.5in,
          ),
        ),
      )
    )

    align(
      center,
      block(
        text(
          size: 0.8em,
          weight: "bold",
          [
            U.S. Department of Commerce \
            National Institute of Standards and Technology \
            Material Measurement Laboratory \
            Chemical Sciences Division \
            Gaithersburg, MD 20899
          ]
        )
      )
    )

    align(
      center,
      block(
        spacing: 1.5em,
        text(
          font: $brand.typography.headings.family$,
          size: 1.8em,
          weight: "bold",
          [REPORT OF ANALYSIS]
        )
      )
    )

    align(
      center,
      block(
        below: 0.3in,
        today-date
      )
    )

    show grid.cell.where(x: 0): set text(weight: "bold")

    grid(
      columns: (1fr, 3fr),
      row-gutter: 1em,
      [Submitted to:],                                          submitted-to,
      [Title:],                                                 title,
      [Purpose:],                                               purpose,
      [Date(s) of Lab Work:],                                   lab-dates,
      [Method(s):],                                             methods,
      [Control(s):],                                            controls,
      [Quality Documents:],                                     quality-docs,
      [SRM(s):],                                                if srms != none {srms} else [NA],
      [Constituent(s):],                                        if constituents != none {constituents} else [NA],
      [Assigned Value  (#math.equation(math.italic[k = 2])):],  if assigned-value != none {assigned-value} else [NA],
      [Expiration Date:],                                       if exp-date != none {exp-date} else [NA],
      [Collaborator(s):],                                       if collaborators != none {collaborators} else [NA],
      [Agreements:],                                            if agreements != none {agreements} else [NA],
      [Approvals:],                                             if approvals != none {approvals} else [NA],
      [Copies to:],                                             if copies-to != none {copies-to} else [NA]
    )

    show grid.cell: set text(weight: "regular")

    [*Prepared By:*]
    display-authors(prepared-by)

    [*Reviewed By:*]
    display-authors(reviewed-by)
  }

  doc
}
