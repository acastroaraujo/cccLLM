
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

## Structured Output

The JSON schema I used was constructed using the ellmer package in R.

See
[here](https://acastroaraujo.github.io/blog/posts/2025-03-17-llms-for-researchers/#structured-output)
for more information on the “structured output” capabilities of some
LLMs.

You can find both the system prompt and JSON schema in the `prompts`
directory.

``` r
source("prompts/ruling_summary.R")
ruling_summary
#> <ellmer::TypeObject>
#>  @ description          : chr "Información de la sentencia."
#>  @ required             : logi TRUE
#>  @ properties           :List of 7
#>  .. $ summary        : <ellmer::TypeObject>
#>  ..  ..@ description          : chr "Resumen detallado de la sentencia. Debe contener los hechos del caso y la decisión tomada por la Corte."
#>  ..  ..@ required             : logi TRUE
#>  ..  ..@ properties           :List of 2
#>  .. .. .. $ spanish: <ellmer::TypeBasic>
#>  .. .. ..  ..@ description: chr "En español."
#>  .. .. ..  ..@ required   : logi TRUE
#>  .. .. ..  ..@ type       : chr "string"
#>  .. .. .. $ english: <ellmer::TypeBasic>
#>  .. .. ..  ..@ description: chr "In English."
#>  .. .. ..  ..@ required   : logi TRUE
#>  .. .. ..  ..@ type       : chr "string"
#>  ..  ..@ additional_properties: logi FALSE
#>  .. $ chamber_raw    : <ellmer::TypeBasic>
#>  ..  ..@ description: chr "Nombre de la sala, en caso de que la información sea explícita."
#>  ..  ..@ required   : logi FALSE
#>  ..  ..@ type       : chr "string"
#>  .. $ person         : <ellmer::TypeArray>
#>  ..  ..@ description: chr "Información sobre los magistrados que firmaron la sentencia. El secretario general está excluído de esta lista."
#>  ..  ..@ required   : logi TRUE
#>  ..  ..@ items      : <ellmer::TypeObject>
#>  .. .. .. @ description          : NULL
#>  .. .. .. @ required             : logi TRUE
#>  .. .. .. @ properties           :List of 6
#>  .. .. .. .. $ name   : <ellmer::TypeBasic>
#>  .. .. .. ..  ..@ description: chr "Nombre."
#>  .. .. .. ..  ..@ required   : logi TRUE
#>  .. .. .. ..  ..@ type       : chr "string"
#>  .. .. .. .. $ av     : <ellmer::TypeBasic>
#>  .. .. .. ..  ..@ description: chr "Incluye aclaración de voto?"
#>  .. .. .. ..  ..@ required   : logi TRUE
#>  .. .. .. ..  ..@ type       : chr "boolean"
#>  .. .. .. .. $ sv     : <ellmer::TypeBasic>
#>  .. .. .. ..  ..@ description: chr "Incluye salvamento de voto?"
#>  .. .. .. ..  ..@ required   : logi TRUE
#>  .. .. .. ..  ..@ type       : chr "boolean"
#>  .. .. .. .. $ mp     : <ellmer::TypeBasic>
#>  .. .. .. ..  ..@ description: chr "Es el magistrado ponente?"
#>  .. .. .. ..  ..@ required   : logi TRUE
#>  .. .. .. ..  ..@ type       : chr "boolean"
#>  .. .. .. .. $ interim: <ellmer::TypeBasic>
#>  .. .. .. ..  ..@ description: chr "Es magistrado encargado?"
#>  .. .. .. ..  ..@ required   : logi TRUE
#>  .. .. .. ..  ..@ type       : chr "boolean"
#>  .. .. .. .. $ conjuez: <ellmer::TypeBasic>
#>  .. .. .. ..  ..@ description: chr "Es conjuez?"
#>  .. .. .. ..  ..@ required   : logi TRUE
#>  .. .. .. ..  ..@ type       : chr "boolean"
#>  .. .. .. @ additional_properties: logi FALSE
#>  .. $ articles       : <ellmer::TypeArray>
#>  ..  ..@ description: chr "Lista de artículos de la Constitución (o \"Carta Política\") que son mencionadas por número en la sentencia de "| __truncated__
#>  ..  ..@ required   : logi FALSE
#>  ..  ..@ items      : <ellmer::TypeBasic>
#>  .. .. .. @ description: NULL
#>  .. .. .. @ required   : logi TRUE
#>  .. .. .. @ type       : chr "integer"
#>  .. $ rj             : <ellmer::TypeEnum>
#>  ..  ..@ description: chr "Indica si la decisión se fundamenta en cosa juzgada, es decir, si ya ha sido resuelta previamente por la Corte "| __truncated__
#>  ..  ..@ required   : logi FALSE
#>  ..  ..@ values     : chr [1:3] "sí" "no" "parcial"
#>  .. $ rj_citation_raw: <ellmer::TypeArray>
#>  ..  ..@ description: chr "Lista de sentencias previas que llevaron a la Corte a decidir que el caso es \"cosa juzgada\". Las sentencias q"| __truncated__
#>  ..  ..@ required   : logi FALSE
#>  ..  ..@ items      : <ellmer::TypeBasic>
#>  .. .. .. @ description: chr "Nombre de la sentencia"
#>  .. .. .. @ required   : logi TRUE
#>  .. .. .. @ type       : chr "string"
#>  .. $ amicus         : <ellmer::TypeArray>
#>  ..  ..@ description: chr "Información sobre intervinientes en calidad de \"amicus curiae\" en el proceso. Esta lista puede incluir person"| __truncated__
#>  ..  ..@ required   : logi FALSE
#>  ..  ..@ items      : <ellmer::TypeObject>
#>  .. .. .. @ description          : NULL
#>  .. .. .. @ required             : logi TRUE
#>  .. .. .. @ properties           :List of 2
#>  .. .. .. .. $ name       : <ellmer::TypeBasic>
#>  .. .. .. ..  ..@ description: chr "Nombre del interviniente, en caso de que la información sea explícita."
#>  .. .. .. ..  ..@ required   : logi FALSE
#>  .. .. .. ..  ..@ type       : chr "string"
#>  .. .. .. .. $ affiliation: <ellmer::TypeBasic>
#>  .. .. .. ..  ..@ description: chr "Organización a la cual pertenece el interviniente. Si el interviniente no pertence a ninguna organización su af"| __truncated__
#>  .. .. .. ..  ..@ required   : logi FALSE
#>  .. .. .. ..  ..@ type       : chr "string"
#>  .. .. .. @ additional_properties: logi FALSE
#>  @ additional_properties: logi FALSE
```

## Example

``` r
out <- readRDS("out_raw/C-1060A-01_gpt.rds")
out
#> $summary
#> $summary$spanish
#> [1] "La Corte Constitucional de Colombia revisó la constitucionalidad del artículo 206, numeral 7, del Estatuto Tributario y el artículo 20 de la Ley 488 de 1998, que eximían del impuesto sobre la renta a ciertos altos funcionarios públicos por los gastos de representación, considerando estos como el 50% de sus salarios. La demandante, María Lugari Castrillón, argumentó que estas disposiciones violaban los principios constitucionales de igualdad, equidad y progresividad, ya que otorgaban un privilegio injustificado a funcionarios con altos ingresos. La Corte encontró que estas exenciones eran inconstitucionales porque rompían con los principios de equidad y progresividad del sistema tributario, al otorgar un trato preferencial a ciertos funcionarios sin una justificación razonable. La Corte declaró inexequible el numeral 7 del artículo 206 del Estatuto Tributario, tal como fue modificado por el artículo 20 de la Ley 488 de 1998."
#> 
#> $summary$english
#> [1] "The Constitutional Court of Colombia reviewed the constitutionality of Article 206, numeral 7, of the Tax Statute and Article 20 of Law 488 of 1998, which exempted certain high-ranking public officials from income tax for representation expenses, considering these as 50% of their salaries. The plaintiff, María Lugari Castrillón, argued that these provisions violated the constitutional principles of equality, equity, and progressivity, as they granted an unjustified privilege to officials with high incomes. The Court found these exemptions unconstitutional because they violated the principles of equity and progressivity of the tax system by granting preferential treatment to certain officials without reasonable justification. The Court declared numeral 7 of Article 206 of the Tax Statute, as amended by Article 20 of Law 488 of 1998, unconstitutional."
#> 
#> 
#> $chamber_raw
#> [1] "Sala Plena de conjueces"
#> 
#> $person
#>                            name    av    sv    mp interim conjuez
#> 1        Ramiro Bejarano Guzmán FALSE FALSE FALSE   FALSE    TRUE
#> 2         Lucy Cruz de Quiñones FALSE FALSE  TRUE   FALSE    TRUE
#> 3 Hernán Guillermo Aldana Duque FALSE FALSE FALSE   FALSE    TRUE
#> 4     Juan Manuel Charry Urueña FALSE FALSE FALSE   FALSE    TRUE
#> 5         Pedro Lafontt Pianeta FALSE  TRUE FALSE   FALSE    TRUE
#> 6       Susana Montes Echeverri FALSE FALSE FALSE   FALSE    TRUE
#> 7           Jairo Parra Quijano FALSE  TRUE FALSE   FALSE    TRUE
#> 8         Humberto Sierra Porto FALSE FALSE FALSE   FALSE    TRUE
#> 9          Gustavo Zafra Roldán FALSE FALSE FALSE   FALSE    TRUE
#> 
#> $articles
#> [1]  13  95 133 154 158 182 183 363
#> 
#> $rj
#> [1] "no"
#> 
#> $rj_citation_raw
#> character(0)
#> 
#> $amicus
#>                         name
#> 1                       NULL
#> 2      Alvaro Leyva Zambrano
#> 3       Jaime Bernal Cuéllar
#> 4 Eduardo Montealegre Lynett
#>                                           affiliation
#> 1 Dirección General de Impuestos y Aduanas Nacionales
#> 2          Instituto Colombiano de Derecho Tributario
#> 3                     Procurador General de la Nación
#> 4                 Viceprocurador General de la Nación
#> 
#> $url
#> [1] "https://www.corteconstitucional.gov.co/relatoria/2001/C-1060A-01.htm"
#> 
#> $id
#> [1] "C-1060A-01"
#> 
#> $model
#> [1] "gpt-4o"
```

## Manual Coding of Very Large Files

Some documents exceed the maximum context length of 128000 tokens. This
happens, for example, when a lengthy appendix is included in the file.
This means I couldn’t parse them in the same ways as the others.

These documents were manually coded, with the exception of the English
and Spanish summaries which were written using the file upload option in
the OpenAI platform.

They can be found in the `out_raw_exceeded` directory.

*Working with the document embeddings provided by OpenAI’s RAG system
produce very unreliable results.* There is a higher chance that the
somes fields here — e.g., `articles` and `amicus` — are miscoded. I’ve
tried my best to keep things reliable via manual inspection! This is why
there is a `model` variable in the codebook that distinguishes between
“gpt-4o” and “acastroaraujo”.

I recommend you double-check these rulings if you are going to analyze
the `articles` variable.

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

## Misc.

The `amicus` field contains information about participants acting as
amicus curiae (“friends of the court”) in the corresponding ruling. The
output may include individual people, NGOs, professional associations,
labor unions, universities, government entities, and other types of
public or private organizations.

There is one inconsistency in how the Office of The Inspector General
(“Procuraduría General de La Nación”) is coded in this field. Since it
is mandatory for each `C` ruling to contain the input of this office
(see article 242 of the Colombian Constitution), this intervention is
sometimes separated from the interventions of other third parties. Thus,
this government agency shows up in the `amicus` field in an inconsistent
fashion. The best way to treat this issue is to remove this office from
all `amicus` fields in all `C` rulings.
