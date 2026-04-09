#show: doc => report-template(
  [$roa-num$],
  [$submitted-to.person$ \ $submitted-to.association$],
  [$cover-title.line1$$if(cover-title.line2)$ \ $cover-title.line2$ $endif$],
  [$purpose$],
  [
    #format-date(datetime(
      day: $lab-dates.from.day$,
      month: $lab-dates.from.month$,
      year: $lab-dates.from.year$
    )) -- #format-date(datetime(
      day: $lab-dates.to.day$,
      month: $lab-dates.to.month$,
      year: $lab-dates.to.year$,
    ))
  ],
  [$methods$],
  [$controls-used$],
  [$quality-docs$],
  $if(srms)$
    srms: [$srms$],
  $endif$
  $if(constituents)$
    constituents: [$constituents$],
  $endif$
  $if(assigned-value.value)$
    assigned-value: (
      [#float($assigned-value.value$)]
      + sym.space.nobreak
      + sym.plus.minus
      + sym.space.nobreak
      + make-units[$assigned-value.uncertainty$ $assigned-value.units$]
    ),
  $endif$
  $if(exp-date.day)$
    exp-date: [
      #format-date(datetime(
        day: $exp-date.day$,
        month: $exp-date.month$,
        year: $exp-date.year$
      ))
    ],
  $endif$
  $if(collaborators)$
    collaborators: [$collaborators$],
  $endif$
  $if(agreements)$
    agreements: [$agreements$],
  $endif$
  $if(approvals)$
    approvals: [$approvals$],
  $endif$
  $if(copies-to)$
    copies-to: [$copies-to$],
  $endif$
  (
    $for(prepared-by)$
      (
        name: "$it.name$",
        title: "$it.title$",
        $if(it.email)$email: "$it.email$"$endif$
      ),
    $endfor$
  ),
  (
    $for(reviewed-by)$
      (
        name: "$it.name$",
        title: "$it.title$",
        $if(it.email)$email: "$it.email$"$endif$
      ),
    $endfor$
  ),
  doc
)