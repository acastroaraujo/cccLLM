# Edge list of citations to binding precedent ("cosa juzgada")

The `rj_citations` dataset contains and edge list of rulings that
referenced a previous ruling as binding precedent for the current
ruling. The Latin word for this is "res judicata" and the Colombian
Court uses the expression "cosa juzgada"

## Usage

``` r
rj_citations
```

## Format

A data frame with two variables:

- `from`:

  Ruling ID

- `to`:

  Ruling ID of precedent

## Examples

``` r
  rj_citations
#> # A tibble: 4,755 × 2
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
#> # ℹ 4,745 more rows
```
