# Historical dataset of filed claims for Judicial Review

The `reviews` dataset contains historical information extracted from the
Court's official website.

## Usage

``` r
reviews
```

## Format

A data frame with three variables:

- `year`:

  Year

- `files`:

  Number of review files in the Court

- `rulings`:

  Number of constitutional review rulings made by the Court

## Source

https://www.corteconstitucional.gov.co/lacorte/estadisticas

## Examples

``` r
  reviews
#> # A tibble: 32 × 3
#>     year files rulings
#>    <int> <int>   <int>
#>  1  1992   274      52
#>  2  1993   315     204
#>  3  1994   383     222
#>  4  1995   348     227
#>  5  1996   419     347
#>  6  1997   450     304
#>  7  1998   380     240
#>  8  1999   515     288
#>  9  2000   644     394
#> 10  2001   551     368
#> # ℹ 22 more rows
```
