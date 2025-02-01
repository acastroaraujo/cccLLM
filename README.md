
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cccLLM

<!-- badges: start -->
<!-- badges: end -->

This repository contains code to extract information from court rulings
using LLMs via the new [ellmer](https://ellmer.tidyverse.org/) package.

For using LLMs like ChatGPT you will have to add something like this to
your `.Renviron` file:

    OPENAI_API_KEY = "you_api_goes_here"

If you don’t know where this file is located, you can use the following
function:

    usethis::edit_r_environ(scope = "user")

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

    | name                        | av      | sv      | mp      | conjuez |
    |-----------------------------|---------|---------|---------|---------|
    | `Vladimiro Naranjo Mesa`    | `FALSE` | `FALSE` | `TRUE`  | `FALSE` |
    | `Antonio Barrera Carbonell` | `FALSE` | `FALSE` | `FALSE` | `FALSE` |
    | `Alfredo Beltrán Sierra`    | `FALSE` | `FALSE` | `FALSE` | `FALSE` |

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

## Example

``` r
out <- readRDS("old_out_raw/C-1060A-01_gpt.rds")
out$id
#> [1] "C-1060A-01"
out$url
#> [1] "https://www.corteconstitucional.gov.co/relatoria/2001/C-1060A-01.htm"
out$chamber
#> [1] "Sala Plena de Conjueces"
out$person
#>                            name    av    sv conjuez    mp
#> 1        Ramiro Bejarano Guzmán FALSE FALSE    TRUE FALSE
#> 2         Lucy Cruz de Quiñones FALSE FALSE    TRUE  TRUE
#> 3 Hernán Guillermo Aldana Duque FALSE FALSE    TRUE FALSE
#> 4     Juan Manuel Charry Urueña FALSE FALSE    TRUE FALSE
#> 5         Pedro Lafontt Pianeta FALSE  TRUE    TRUE FALSE
#> 6       Susana Montes Echeverri FALSE FALSE    TRUE FALSE
#> 7           Jairo Parra Quijano FALSE  TRUE    TRUE FALSE
#> 8         Humberto Sierra Porto FALSE FALSE    TRUE FALSE
#> 9          Gustavo Zafra Roldán FALSE FALSE    TRUE FALSE
cat(stringr::str_wrap(out$summary$en))
#> The Colombian Constitutional Court, through its Sala Plena de Conjueces,
#> declared unconstitutional Article 206, numeral 7 of the Tax Statute, as amended
#> by Article 20 of Law 488 of 1998. The article in question allowed certain
#> high-ranking public officials to exempt their representation expenses from
#> income tax, with representation expenses considered 50% of their salaries. The
#> court determined that these provisions violated constitutional principles of
#> equality, tax equity, and progressivity by unjustly privileging high-income
#> officials with a tax advantage not available to other citizens. The court ruled
#> that tax exemptions should not undermine the general duty of solidarity and
#> fiscal responsibility, emphasizing that even individuals in high positions must
#> contribute to public expenses according to their capacity. The court's decision
#> underscores the importance of tax justice and equitable treatment across all
#> citizens, maintaining that exemptions must be justified by relevant social
#> or economic needs, within the framework established by the Constitution of
#> Colombia.
cat(stringr::str_wrap(out$summary$es))
#> La Corte Constitucional de Colombia, a través de su Sala Plena de Conjueces,
#> declaró inconstitucional el artículo 206, numeral 7 del Estatuto Tributario,
#> tal como fue modificado por el artículo 20 de la Ley 488 de 1998. Dicho artículo
#> permitía que ciertos altos funcionarios públicos eximieran del impuesto sobre
#> la renta sus gastos de representación, considerándose estos gastos el 50%
#> de sus salarios. El tribunal determinó que estas disposiciones violan los
#> principios constitucionales de igualdad, equidad tributaria y progresividad al
#> privilegiar injustamente a los funcionarios con mayores ingresos, otorgándoles
#> ventajas fiscales no disponibles para otros ciudadanos. La corte estipuló que
#> las exenciones fiscales no deben socavar el deber general de solidaridad y
#> responsabilidad fiscal, enfatizando que incluso las personas en altos cargos
#> deben contribuir al gasto público conforme a su capacidad. La decisión de
#> la corte subraya la importancia de la justicia tributaria y el tratamiento
#> equitativo para todos los ciudadanos, manteniendo que las exenciones deben estar
#> justificadas por necesidades sociales o económicas relevantes, dentro del marco
#> constitucional de Colombia.
```
