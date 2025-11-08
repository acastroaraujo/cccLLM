# Constitution of Colombia

The `constitution` dataset 380 articles of the Colombian Constitution.

## Usage

``` r
constitution
```

## Format

A data frame with two variables:

- `article`:

  Article number

- `title_num`:

  Title number

- `chapter_num`:

  Chapter number

- `title`:

  Title

- `chapter`:

  Chapter

- `text`:

  text

## Source

https://www.constitucioncolombia.com/

## Examples

``` r
  constitution
#> # A tibble: 380 × 6
#>    article title_num chapter_num title                           chapter text   
#>      <int>     <int>       <int> <chr>                           <chr>   <chr>  
#>  1       1         1          NA De los principios fundamentales NA      "Artíc…
#>  2       2         1          NA De los principios fundamentales NA      "Artíc…
#>  3       3         1          NA De los principios fundamentales NA      "Artíc…
#>  4       4         1          NA De los principios fundamentales NA      "Artíc…
#>  5       5         1          NA De los principios fundamentales NA      "Artíc…
#>  6       6         1          NA De los principios fundamentales NA      "Artíc…
#>  7       7         1          NA De los principios fundamentales NA      "Artíc…
#>  8       8         1          NA De los principios fundamentales NA      "Artíc…
#>  9       9         1          NA De los principios fundamentales NA      "Artíc…
#> 10      10         1          NA De los principios fundamentales NA      "Artíc…
#> # ℹ 370 more rows
```
