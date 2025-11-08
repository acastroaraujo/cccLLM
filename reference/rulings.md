# Data set of rulings

The `rulings` dataset contains high-level information on each rulings.

## Usage

``` r
rulings
```

## Format

A data frame with nine variables:

- `id`:

  Ruling ID

- `date`:

  Date

- `type`:

  Type of Ruling

- `chamber`:

  The kind of chamber that authored the ruling

- `rj`:

  Indicator of Res Judicata (or "Cosa Juzgada")

- `n_person`:

  Number of judges

- `n_av`:

  Number of concurring opinions

- `n_sv`:

  Number of dissenting opinions

- `n_amicus`:

  Number of Amicus interventions

- `summary_en`:

  Short summary in English.

- `summary_es`:

  Short summary in Spanish.

- `model`:

  Indicator of manual coding.

## Examples

``` r
  rulings
#> # A tibble: 28,245 × 12
#>    id    date       type  chamber rj    n_person  n_av  n_sv n_amicus summary_en
#>    <chr> <date>     <fct> <fct>   <fct>    <int> <int> <int>    <int> <chr>     
#>  1 T-00… 1992-04-03 T     SR      no           3     0     0        0 "The ruli…
#>  2 C-00… 1992-05-07 C     SP      no           7     0     1        3 "The Cons…
#>  3 T-00… 1992-05-08 T     SR      no           3     0     0        0 "The ruli…
#>  4 C-00… 1992-05-11 C     SP      no           7     0     2        1 "The ruli…
#>  5 T-00… 1992-05-11 T     SR      no           3     0     0        0 "The ruli…
#>  6 T-00… 1992-05-12 T     SR      no           3     0     1        0 "The ruli…
#>  7 T-00… 1992-05-13 T     SR      no           3     0     0        0 "The ruli…
#>  8 T-00… 1992-05-18 T     SR      no           3     0     0        0 "The ruli…
#>  9 T-00… 1992-05-22 T     SR      no           3     0     0        0 "The ruli…
#> 10 T-01… 1992-05-22 T     SR      no           3     0     0        0 "The case…
#> # ℹ 28,235 more rows
#> # ℹ 2 more variables: summary_es <chr>, model <chr>
```
