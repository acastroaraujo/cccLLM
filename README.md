
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cccLLM

<!-- badges: start -->

[![R-CMD-check](https://github.com/acastroaraujo/cccLLM/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/acastroaraujo/cccLLM/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

This package contains a collection of datasets about the Colombian
Constitutional Court collected with the help of Large Language Models.
It is meant to complement the datasets collected in the ccc package.

## Installation

You can install the development version of cccLLM from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("acastroaraujo/cccLLM")
```

A BibTeX entry for LaTeX users is:

    @Manual{,
      title = {cccLLM: Colombian Constitutional Court LLM Dataset},
      author = {andrés {castro araújo}},
      year = {2025},
      note = {R package version 0.1.0},
    }

## Overview

- `rulings`

- `person`

- `rj_citations`

- `articles`

- `amicus`

- `appointed_judges`

## Example

``` r
library(cccLLM)

appointed_judges
#> # A tibble: 44 × 3
#>    name                            start      end       
#>    <chr>                           <date>     <date>    
#>  1 jaime sanin greiffenstein       1992-02-01 1993-02-01
#>  2 simon rodriguez rodriguez       1992-02-01 1993-02-01
#>  3 fabio moron diaz                1992-02-01 2001-02-01
#>  4 alejandro martinez caballero    1992-02-01 2001-02-01
#>  5 jose gregorio hernandez galindo 1992-02-01 2001-03-01
#>  6 eduardo cifuentes munoz         1992-02-01 2000-02-01
#>  7 ciro angarita baron             1992-02-01 1993-02-01
#>  8 jorge arango mejia              1993-03-01 1998-04-01
#>  9 hernando herrera vergara        1993-03-01 1999-01-01
#> 10 vladimiro naranjo mesa          1993-03-01 2001-02-01
#> # ℹ 34 more rows
rulings
#> # A tibble: 28,242 × 9
#>    id     date       type  chamber rj    n_person n_amicus summary_en summary_es
#>    <chr>  <date>     <fct> <fct>   <fct>    <int>    <int> <chr>      <chr>     
#>  1 T-001… 1992-04-03 T     SR      no           3        0 "The ruli… "La sente…
#>  2 C-004… 1992-05-07 C     SP      no           7        3 "The Cons… "La Corte…
#>  3 T-002… 1992-05-08 T     SR      no           3        0 "The ruli… "La sente…
#>  4 C-005… 1992-05-11 C     SP      no           7        1 "The ruli… "La sente…
#>  5 T-003… 1992-05-11 T     SR      no           3        0 "The ruli… "La sente…
#>  6 T-006… 1992-05-12 T     SR      no           3        0 "The ruli… "La sente…
#>  7 T-007… 1992-05-13 T     SR      no           3        0 "The ruli… "La sente…
#>  8 T-008… 1992-05-18 T     SR      no           3        0 "The ruli… "La sente…
#>  9 T-009… 1992-05-22 T     SR      no           3        0 "The ruli… "La sente…
#> 10 T-010… 1992-05-22 T     SR      no           3        0 "The case… "El caso …
#> # ℹ 28,232 more rows
person
#> # A tibble: 131,457 × 7
#>    id       name                          mp    av    sv    interim conjuez
#>    <chr>    <chr>                         <lgl> <lgl> <lgl> <lgl>   <lgl>  
#>  1 C-001-18 luis guillermo guerrero perez FALSE FALSE FALSE FALSE   FALSE  
#>  2 C-001-18 carlos bernal pulido          FALSE FALSE TRUE  FALSE   FALSE  
#>  3 C-001-18 diana fajardo rivera          TRUE  FALSE FALSE FALSE   FALSE  
#>  4 C-001-18 alejandro linares cantillo    FALSE FALSE FALSE FALSE   FALSE  
#>  5 C-001-18 antonio jose lizarazo ocampo  FALSE FALSE FALSE FALSE   FALSE  
#>  6 C-001-18 gloria stella ortiz delgado   FALSE FALSE FALSE FALSE   FALSE  
#>  7 C-001-18 cristina pardo schlesinger    FALSE FALSE FALSE FALSE   FALSE  
#>  8 C-001-18 jose fernando reyes cuartas   FALSE FALSE FALSE FALSE   FALSE  
#>  9 C-001-18 alberto rojas rios            FALSE FALSE FALSE FALSE   FALSE  
#> 10 C-002-18 luis guillermo guerrero perez FALSE FALSE FALSE FALSE   FALSE  
#> # ℹ 131,447 more rows
articles
#> # A tibble: 125,156 × 2
#>    id       article
#>    <chr>      <int>
#>  1 C-001-18       1
#>  2 C-001-18      13
#>  3 C-001-18      17
#>  4 C-001-18     241
#>  5 C-001-18     243
#>  6 C-002-18      29
#>  7 C-002-18     158
#>  8 C-002-93      13
#>  9 C-002-93      25
#> 10 C-002-93      26
#> # ℹ 125,146 more rows
rj_citations
#> # A tibble: 4,763 × 2
#>    from     to      
#>    <chr>    <chr>   
#>  1 C-002-98 C-191-96
#>  2 C-003-99 C-018-93
#>  3 C-004-03 C-578-02
#>  4 C-004-93 C-517-92
#>  5 C-004-98 C-109-95
#>  6 C-006-03 C-008-94
#>  7 C-006-98 C-185-97
#>  8 C-007-01 C-533-00
#>  9 C-007-16 C-511-94
#> 10 C-007-98 C-010-97
#> # ℹ 4,753 more rows
```

And here’s a plot.

``` r
library(tidyverse)

theme_set(theme_light(base_family = "Avenir Next Condensed"))

lvls <- with(appointed_judges, str_to_title(name[order(start, end)]))

appointed_judges |>
  mutate(name = str_to_title(name)) |> 
  mutate(name = factor(name, lvls)) |>
  ggplot(aes(y = name)) +
  geom_segment(aes(x = start, xend = end)) +
  labs(
    x = NULL, y = NULL, 
    title = "The Colombian Constitutional Court",
    subtitle = "1992-2024"
    ) + 
  scale_x_date(date_breaks = "2 years", date_labels = "'%y")
```

<img src="man/figures/README-court-cohorts-1.png" width="100%" />
