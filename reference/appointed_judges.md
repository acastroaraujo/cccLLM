# Data set of appointed judges

The `appointed_judges` dataset contains information on the start and end
periods of the appointed judges. The cutoff date for all of them is
April 3, 2024, which note a real ending date but it is the moment in
which I stopped collecting data.

## Usage

``` r
appointed_judges
```

## Format

A data frame with three variables:

- `name`:

  Name of the judge

- `start`:

  Start Date

- `end`:

  End Date

## Examples

``` r
  appointed_judges
#> # A tibble: 44 × 3
#>    name                            start      end       
#>    <chr>                           <date>     <date>    
#>  1 jaime sanin greiffenstein       1992-02-01 1993-02-28
#>  2 simon rodriguez rodriguez       1992-02-01 1993-02-28
#>  3 fabio moron diaz                1992-02-01 2001-02-28
#>  4 alejandro martinez caballero    1992-02-01 2001-02-28
#>  5 jose gregorio hernandez galindo 1992-02-01 2001-03-31
#>  6 eduardo cifuentes munoz         1992-02-01 2000-08-31
#>  7 ciro angarita baron             1992-02-01 1993-02-28
#>  8 jorge arango mejia              1993-03-01 1998-04-30
#>  9 hernando herrera vergara        1993-03-01 1999-01-31
#> 10 vladimiro naranjo mesa          1993-03-01 2001-02-28
#> # ℹ 34 more rows
```
