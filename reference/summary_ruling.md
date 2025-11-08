# Get ruling summary

This is a convenience function that finds the summary of a ruling in the
`rulings` dataset and then prints it to the console.

## Usage

``` r
summary_ruling(x)
```

## Arguments

- x:

  ruling id

## Value

Spanish and English summaries

## Examples

``` r
summary_ruling("C-055-22")
#> 
#> ── Ruling: C-055-22 ────────────────────────────────────────────────────────────
#> La Corte Constitucional de Colombia, en la Sentencia C-055 de 2022, revisó la
#> constitucionalidad del artículo 122 del Código Penal, que penaliza el aborto
#> consentido. La demanda fue presentada por un grupo de ciudadanas que
#> argumentaron que la norma violaba varios derechos constitucionales, incluyendo
#> el derecho a la salud, la igualdad, la libertad de conciencia y los principios
#> de la política criminal. La Corte concluyó que, aunque la protección de la vida
#> en gestación es una finalidad constitucional imperiosa, la penalización
#> absoluta del aborto consentido afecta intensamente otros derechos
#> fundamentales. Por lo tanto, la Corte declaró la exequibilidad condicionada del
#> artículo 122, estableciendo que el aborto solo será punible después de la
#> vigésimo cuarta semana de gestación, excepto en los casos ya despenalizados por
#> la Sentencia C-355 de 2006. Además, exhortó al Congreso y al Gobierno a
#> formular una política pública integral que proteja tanto la vida en gestación
#> como los derechos de las mujeres gestantes.
#> ────────────────────────────────────────────────────────────────────────────────
#> The Constitutional Court of Colombia, in Ruling C-055 of 2022, reviewed the
#> constitutionality of Article 122 of the Penal Code, which criminalizes
#> consensual abortion. The lawsuit was filed by a group of citizens who argued
#> that the rule violated several constitutional rights, including the right to
#> health, equality, freedom of conscience, and principles of criminal policy. The
#> Court concluded that although the protection of life in gestation is an
#> imperative constitutional purpose, the absolute criminalization of consensual
#> abortion intensely affects other fundamental rights. Therefore, the Court
#> declared the conditional enforceability of Article 122, establishing that
#> abortion will only be punishable after the twenty-fourth week of gestation,
#> except in cases already decriminalized by Ruling C-355 of 2006. Additionally,
#> it urged Congress and the Government to formulate a comprehensive public policy
#> that protects both life in gestation and the rights of pregnant women.
```
