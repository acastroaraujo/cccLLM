
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cccLLM

<!-- badges: start -->
<!-- badges: end -->

This repository contains code to extract information from court rulings
using LLMs via the new [elmer package](https://elmer.tidyverse.org/).

For using LLMs like ChatGPT you will have to add something like this to
your `.Renviron` file:

    OPENAI_API_KEY = "you_api_goes_here"

If you don’t know where this file is located, you can use the following
function:

    usethis::edit_r_environ(scope = "user")

## Example

``` r
out <- readRDS("example.rds")

out$url
#> [1] "https://www.corteconstitucional.gov.co/relatoria/2001/C-1060A-01.htm"
out$chamber
#> [1] "Sala Plena de conjueces"
out$summary
#> $en
#> [1] "The Constitutional Court of Colombia reviewed the constitutionality of article 206, numeral 7, of the Tax Statute as modified by article 20 of Law 488 of 1998, which exempted certain representation expenses of public officials from income tax. The plaintiff argued the provision violated the constitutional principles of equality, equity, and progressivity, as it granted tax exemptions on representation expenses for high-ranking public officials, which constituted a privilege not justified by social or economic ends. The Court declared the exoneration unconstitutional, noting that the exemption violated the principles of justice and equality, as it disproportionately benefited high-income individuals and was incongruous with the duties of social solidarity. Dissenting opinions argued that such exemptions could be justified as a form of recognition for the dignified status of these positions."
#> 
#> $es
#> [1] "La Corte Constitucional de Colombia revisó la constitucionalidad del artículo 206, numeral 7, del Estatuto Tributario, modificado por el artículo 20 de la Ley 488 de 1998, que eximía de impuestos sobre la renta ciertos gastos de representación de altos funcionarios públicos. La demandante alegaba que la disposición violaba los principios constitucionales de igualdad, equidad y progresividad, al conceder exenciones tributarias sobre los gastos de representación de estos funcionarios, constituyendo un privilegio no justificado por fines sociales o económicos. La Corte declaró inconstitucional la exoneración, destacando que violaba los principios de justicia e igualdad, al beneficiar desproporcionadamente a personas con altos ingresos y era incongruente con los deberes de solidaridad social. Opiniones disidentes argumentaron que dichas exenciones podrían justificarse como una forma de reconocimiento del estatus digno de estos cargos."
do.call(rbind, out$person)
#>       name                            sv   conjuez mp   
#>  [1,] "Ramiro Bejarano Guzmán"        NULL TRUE    FALSE
#>  [2,] "Hernán Guillermo Aldana Duque" NULL TRUE    FALSE
#>  [3,] "Juan Manuel Charry Urueña"     NULL TRUE    FALSE
#>  [4,] "Lucy Cruz de Quiñones"         NULL TRUE    TRUE 
#>  [5,] "Pedro Lafontt Pianeta"         TRUE TRUE    FALSE
#>  [6,] "Susana Montes Echeverri"       NULL TRUE    FALSE
#>  [7,] "Jairo Parra Quijano"           TRUE TRUE    FALSE
#>  [8,] "Humberto Sierra Porto"         NULL TRUE    FALSE
#>  [9,] "Gustavo Zafra Roldán"          NULL TRUE    FALSE
```
