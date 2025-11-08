# Data set of individual judges participating in the rulings

The `person` dataset contains information on the judges that signed off
on a particular ruling.

## Usage

``` r
person
```

## Format

A data frame with two variables:

- `id`:

  Ruling ID

- `name`:

  Name of the judge

- `mp`:

  Reporting judge ("Magistrado Ponente")

- `av`:

  Concurring Opinion Indicator ("Aclaración de Voto")

- `sv`:

  Dissenting Opinion Indicator ("Salvamento de Voto")

- `interim`:

  Interim Judge Indicator ("Magistrado Encargado")

- `conjuez`:

  Substitute Judge Indicator ("Conjuez")

## Examples

``` r
  person
#> # A tibble: 131,484 × 7
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
#> # ℹ 131,474 more rows
```
