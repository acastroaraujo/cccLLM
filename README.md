
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cccLLM

<!-- badges: start -->
<!-- badges: end -->

This package contains information about the Colombian Constitutional
Court collected with the help of Large Language Models.

## Installation

You can install the development version of cccLLM from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("acastroaraujo/cccLLM")
```

## Overview

``` r
library(cccLLM)
person
#> # A tibble: 131,443 × 7
#>    id       name                          av    sv    mp    interim conjuez
#>    <chr>    <chr>                         <lgl> <lgl> <lgl> <lgl>   <lgl>  
#>  1 C-001-18 luis guillermo guerrero perez FALSE FALSE FALSE FALSE   FALSE  
#>  2 C-001-18 carlos bernal pulido          FALSE TRUE  FALSE FALSE   FALSE  
#>  3 C-001-18 diana fajardo rivera          FALSE FALSE TRUE  FALSE   FALSE  
#>  4 C-001-18 alejandro linares cantillo    FALSE FALSE FALSE FALSE   FALSE  
#>  5 C-001-18 antonio jose lizarazo ocampo  FALSE FALSE FALSE FALSE   FALSE  
#>  6 C-001-18 gloria stella ortiz delgado   FALSE FALSE FALSE FALSE   FALSE  
#>  7 C-001-18 cristina pardo schlesinger    FALSE FALSE FALSE FALSE   FALSE  
#>  8 C-001-18 jose fernando reyes cuartas   FALSE FALSE FALSE FALSE   FALSE  
#>  9 C-001-18 alberto rojas rios            FALSE FALSE FALSE FALSE   FALSE  
#> 10 C-002-18 luis guillermo guerrero perez FALSE FALSE FALSE FALSE   FALSE  
#> # ℹ 131,433 more rows
```

## Codebook

1.  `id`: Ruling ID.

    Each ruling has a standardized name. The infix carries no meaning;
    the suffix indicates the year in which the ruling was made; and the
    prefix refers to the type of ruling.

    Type of ruling:

    - `C`. Refers to *sentencia de constitucionalidad,* or the cases in
      which the CCC decides whether a law, rule, or administrative
      decision is compatible with constitutional norms.

    - `T`. Refers to *tutela*, which is an individual complaint
      mechanism aimed at the protection of fundamental rights (or
      special protection writ).

    - `SU`. Refers *sentencia de unificación,* or decisions in which the
      Court has decided to compile and standardize the decisions made in
      various `T` rulings.

    <span style="font-size: 0.8em;">For example: *T-406-92, SU-039-97,
    C-225-1995, C-776-03, T-025-04, SU-1184-01*</span>

2.  `url`: Document address in CCC website.

    <span style="font-size: 0.8em;">*For example:
    <https://www.corteconstitucional.gov.co/relatoria/1994/c-221-94.htm>*</span>

3.  `chamber_raw`: Refers to the parsed non-standardized name of the
    chamber that authored the ruling.

    <span style="font-size: 0.8em;">For example: *Sala Séptima de
    Revisión de Tutelas*, *Sala Plena de Conjueces*</span>

4.  `chamber`: Refers to the kind of chamber that authored the ruling,
    which can be either a three-person chamber (`SR`, *sala de
    revisión)* or a full-chamber (`SP`, *sala plena).*

5.  `person`:

    - `name`: Name of judge.

    - `mp`: Authoring judge *(magistrado ponente).*

    - `sv`: Dissenting opinion *(salvamento de voto).*

    - `av`: Concurring opinion *(aclaración de voto).*

    - `conjuez`: Whether the judge is holds a permanent position in the
      court or was appointed for this specific ruling. This happens, for
      example, when one of the judges in the CCC recuses themselves.

    *Note. Most of the time this is a three row data frame in case the
    chamber composed of a three-person chamber (`SR`) or a nine row data
    frame in case of full-chamber (`SP`).*

    For example:

    | name                        | av      | sv      | mp      | interim | conjuez |
    |-----------------------------|---------|---------|---------|---------|---------|
    | `Vladimiro Naranjo Mesa`    | `FALSE` | `FALSE` | `TRUE`  | `FALSE` | `FALSE` |
    | `Antonio Barrera Carbonell` | `FALSE` | `FALSE` | `FALSE` | `FALSE` | `FALSE` |
    | `Alfredo Beltrán Sierra`    | `FALSE` | `FALSE` | `FALSE` | `FALSE` | `FALSE` |

6.  `articles`: List of articles of the Constitution that are object of
    discussion.

    <span style="font-size: 0.8em;">For example: *23, 212, 213,
    215*</span>

7.  `summary_en`: Two paragraph summary in English.

8.  `summary_es`: Two paragraph summary in Spanish.

9.  `rj`: Refers to *res judicata (cosa juzgada)* and notes whether the
    court’s decision is determined by previous binding rulings or not.
    This meant to prevent the same constitutional issue from being
    raised again in future cases.

10. `rj_citation_raw` (only if `rj` is `TRUE`): List of rulings cited as
    binding.

    <span style="font-size: 0.8em;">For example: *Sentencia T-406 de
    1992, Sentencia C-225/95*</span>

11. `rj_citation:` Standardized list of rulings cited as binding.

    <span style="font-size: 0.8em;">For example: *T-406-92,
    C-225-95*</span>
