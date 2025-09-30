#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
  numbering: "1 of 1",
  header: align(right)[
    $params.roa-number$
  ],
  background: context if counter(page).get().first() == 1 {
    align(left + top)[
      #box(inset: 0.25in)[
        #image("$params.logo$", width: 2.5in)
      ]
    ]
  }
)