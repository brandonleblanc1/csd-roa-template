#show: doc => report-template(
  [$roa-num$],
  [$submitted-to$],
  [$cover-title$],
  (
    $for(authors-list)$
    "$it$",
    $endfor$
  ),
  (
    $for(methods-list)$
    "$it$",
    $endfor$
  ),
  [$purpose$],
  (
    $for(controls-list)$
    "$it$",
    $endfor$
  ),
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
  (
    $for(qualdocs-list)$
    "$it$",
    $endfor$
  ),
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
  $if(srms-list)$
    srms: (
      $for(srms-list)$
      "$it$",
      $endfor$
    ),
  $endif$
  $if(assigned-value.value)$
    assigned-value: [$assigned-value$],
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
  $if(constituents-list)$
    constituents: (
      $for(constituents-list)$
      "$it$",
      $endfor$
    ),
  $endif$
  $if(collaborators-list)$
    collaborators: (
      $for(collaborators-list)$
      "$it$",
      $endfor$
    ),
  $endif$
  $if(agreements-list)$
    agreements: (
      $for(agreements-list)$
      "$it$",
      $endfor$
    ),
  $endif$
  $if(approvals-list)$
    approvals: (
      $for(approvals-list)$
      "$it$",
      $endfor$
    ),
  $endif$
  $if(copies-to)$
    copies-to: [$copies-to$],
  $endif$
  doc
)
