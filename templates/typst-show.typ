#show: doc => report(
  title: [$title$],
  date: [$date$],
$if(columns)$
  cols: $columns$,
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$elseif(brand.typography.base.family)$
  font: $brand.typography.base.family$,
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$elseif(brand.typography.base.size)$
  fontsize: $brand.typography.base.size$,
$endif$
$if(linestretch)$
  line-height: $linestretch$,
$elseif(brand.typography.base.line-height)$
  line-height: $brand.typography.base.line-height$,
$endif$
$if(brand.typography.headings.family)$
  heading-family: $brand.typography.headings.family$,
$endif$
$if(brand.typography.headings.line-height)$
  heading-line-height: $brand.typography.headings.line-height$,
$endif$
$if(toc)$
  toc: $toc$,
$endif$
  doc
)