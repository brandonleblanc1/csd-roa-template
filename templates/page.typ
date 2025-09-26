#set page(
  paper: "us-letter",
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
  numbering: "$page-numbering$",
  header: align(right)[$params.roa-number$],
  background: context {
  if counter(page).get().first() == 1 {
    align($params.logo.location$,
                    box(inset: $params.logo.inset$,
                        image("$params.logo.path$", width: $params.logo.width$)))
    }
})