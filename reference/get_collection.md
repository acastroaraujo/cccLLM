# Get Collection of Rulings

All collections come from the Court's official website, with the
exception of `jctt`, which comes from the "Justicia Constitucional en
Tiempos de Transición" project.

## Usage

``` r
get_collection(
  x = c("gender", "peace", "treaties", "legislative_decrees", "codes", "jctt")
)
```

## Arguments

- x:

  collection name

## Value

a list of ruling ids corresponding to that collection

## Details

https://www.corteconstitucional.gov.co/relatoria/temas-interes
http://justiciatransicional.uniandes.edu.co/web/

## Examples

``` r
get_collection("peace")
#> $`Ley de justicia y paz`
#>  [1] "C-249-17"  "C-006-17"  "C-494-16"  "C-404-16"  "C-330-16"  "C-161-16" 
#>  [7] "C-160-16"  "C-069-16"  "C-694-15"  "C-017-15"  "C-795-14"  "C-577-14" 
#> [13] "C-286-14"  "C-287-14"  "C-255-14"  "C-180-14"  "C-015-14"  "C-911-13" 
#> [19] "C-912-13"  "C-827-13"  "C-752-13"  "C-753-13"  "C-753-13"  "C-753-13" 
#> [25] "C-614-13"  "C-579-13"  "C-581-13"  "C-532-13"  "C-462-13"  "C-438-13" 
#> [31] "C-280-13"  "C-099-13"  "C-1054-12" "C-820-12"  "C-781-12"  "C-715-12" 
#> [37] "C-609-12"  "C-333-12"  "C-253A-12" "C-250-12"  "C-052-12"  "C-771-11" 
#> [43] "C-936-10"  "C-1199-08" "C-719-06"  "C-670-06"  "C-650-06"  "C-575-06" 
#> [49] "C-531-06"  "C-476-06"  "C-455-06"  "C-426-06"  "C-400-06"  "C-370-06" 
#> [55] "C-319-06"  "C-127-06" 
#> 
#> $`Marco jurídico para la paz`
#> [1] "C-309-17" "C-214-17" "C-379-16" "C-577-14" "C-579-13"
#> 
#> $`Procedimiento legislativo especial para la paz (Fast Track)`
#>  [1] "C-073-18" "C-067-18" "C-038-18" "C-027-18" "C-025-18" "C-026-18"
#>  [7] "C-019-18" "C-020-18" "C-018-18" "C-017-18" "C-007-18" "C-730-17"
#> [13] "C-674-17" "C-644-17" "C-630-17" "C-607-17" "C-608-17" "C-569-17"
#> [19] "C-570-17" "C-565-17" "C-554-17" "C-555-17" "C-541-17" "C-535-17"
#> [25] "C-527-17" "C-516-17" "C-518-17" "C-492-17" "C-493-17" "C-469-17"
#> [31] "C-470-17" "C-438-17" "C-433-17" "C-408-17" "C-331-17" "C-332-17"
#> [37] "C-253-17" "C-224-17" "C-174-17" "C-160-17" "C-699-16"
#> 
```
