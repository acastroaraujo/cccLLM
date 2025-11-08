# Data set of amicus interventions in each ruling

The `amicus` dataset contains a list of individuals and organizations
who intervened in the ruling by presenting an "amicus curiae."

## Usage

``` r
amicus
```

## Format

A data frame with three variables:

- `id`:

  Ruling ID

- `name`:

  Name of the individual

- `affiliation`:

  An organization, government agency, university, NGO, union, social
  movement, etc.

## Details

Unlike the other datasets in this package, this one is not very well
standardized. So you might have to do a lot of cleaning to work with
this.

## Examples

``` r
  amicus
#> # A tibble: 41,133 × 3
#>    id       name                           affiliation                          
#>    <chr>    <chr>                          <chr>                                
#>  1 C-001-18 NA                             ministerio de justicia y del derecho 
#>  2 C-001-18 NA                             ministerio del trabajo               
#>  3 C-001-18 NA                             defensoria delegada para asuntos con…
#>  4 C-001-18 NA                             universidad autonoma de bucaramanga  
#>  5 C-001-18 NA                             universidad de cartagena             
#>  6 C-001-18 NA                             universidad externado de colombia    
#>  7 C-001-18 NA                             universidad industrial de santander  
#>  8 C-002-18 maria del mar arciniegas perea NA                                   
#>  9 C-002-18 NA                             universidad externado de colombia    
#> 10 C-002-18 NA                             ministerio de hacienda y credito pub…
#> # ℹ 41,123 more rows
```
