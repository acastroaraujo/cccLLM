# Historical dataset of filed Tutelas

The `tutelas` dataset contains historical information extracted from the
Court's official website.

## Usage

``` r
tutelas
```

## Format

A data frame with three variables:

- `year`:

  Year

- `files`:

  Number of tutelas received by the Court

- `rulings`:

  Number of tutela rulings made by the Court

## Source

https://www.corteconstitucional.gov.co/lacorte/estadisticas

## Examples

``` r
  tutelas
#> # A tibble: 32 × 3
#>     year  files rulings
#>    <int>  <int>   <int>
#>  1  1992  10732     182
#>  2  1993  20181     394
#>  3  1994  26715     360
#>  4  1995  29950     403
#>  5  1996  31248     370
#>  6  1997  33663     376
#>  7  1998  38248     565
#>  8  1999  86313     706
#>  9  2000 131764    1341
#> 10  2001 133272     976
#> # ℹ 22 more rows
```
