# Packages and Helpers ---------------------------------------------------

library(tidyverse)

# Check for interim judges that are not mentioned, like Adriana Guillen and Alexei Julio Estrada.
# The easiest way to do this, I think, is to get a list of permament judges, and then change the
# other ones that are not conjuez to interim.

#' Slice the "person" component of the `output` object
#'
#' @param x The subset of the output corresponding to a ruling id — i.e, `output[[x]]`
#' @param i the integers for the `dplyr::slice()` function
#'
#' @return The modified subset of the output corresponding to a ruling id
#'
slice_person_output <- function(x, i) {
  x[["person"]] <- purrr::pluck(x, "person") |>
    dplyr::slice(i)
  x
}

# Data -------------------------------------------------------------------

out_gpt <- dir("data-raw/out_raw", full.names = TRUE) |>
  purrr::map(function(x) readr::read_rds(x), .progress = TRUE)

names(out_gpt) <- purrr::map_chr(out_gpt, pluck, "id")

out_json <- dir("data-raw/out_raw_exceeded", full.names = TRUE) |>
  purrr::map(
    function(x) {
      output <- jsonlite::read_json(x, simplifyVector = TRUE)
      output$model <- "acastroaraujo"
      output
    },
    .progress = TRUE
  )

names(out_json) <- purrr::map_chr(out_json, pluck, "id")

output <- append(out_gpt, out_json)

# Fix extra people -------------------------------------------------------

# i <- map_lgl(output, function(x) {
#   if (rlang::is_empty(x$chamber_raw)) return(FALSE)
#
#   chamber <- x$chamber_raw |>
#     stringi::stri_trans_general("Latin-ASCII") |>
#     tolower()
#
#   str_detect(chamber, "revision") & nrow(x$person) > 3
# })
#
# which(i)

d <- dplyr::bind_rows(
  tibble::tibble(x = "T-570-98", i = list(c(1, 4, 5))),
  tibble::tibble(x = "T-254-01", i = list(c(-1))),
  tibble::tibble(x = "T-795-08", i = list(c(1, 4)))
)

out_fix <- pmap(d, \(x, i) slice_person_output(output[[x]], i))
names(out_fix) <- map_chr(out_fix, pluck, "id")
output[names(out_fix)] <- out_fix

# i <- map_lgl(output, \(x) nrow(x$person) > 9)
# which(i)

d <- dplyr::bind_rows(
  tibble::tibble(x = "C-013-14", i = list(c(-7))),
  tibble::tibble(x = "C-049-18", i = list(c(-7))),
  tibble::tibble(x = "C-034-14", i = list(c(-8))),
  tibble::tibble(x = "C-123-14", i = list(c(-7, -6))),
  tibble::tibble(x = "C-153-96", i = list(c(-10))),
  tibble::tibble(x = "C-224-16", i = list(c(-8))),
  tibble::tibble(x = "C-246-13", i = list(c(-10))),
  tibble::tibble(x = "C-294-19", i = list(c(-9))),
  tibble::tibble(x = "C-308-19", i = list(c(-8))),
  tibble::tibble(x = "C-322-23", i = list(c(-5))),
  tibble::tibble(x = "C-333-03", i = list(c(-2))),
  tibble::tibble(x = "C-364-93", i = list(c(-4))),
  tibble::tibble(x = "C-382-12", i = list(c(-2, -5, -6, -7, -10))),
  tibble::tibble(x = "C-492-15", i = list(c(-9))),
  tibble::tibble(x = "C-568-19", i = list(c(-9))),
  tibble::tibble(x = "C-619-03", i = list(c(-4))),
  tibble::tibble(x = "C-741-06", i = list(c(-10))),
  tibble::tibble(x = "C-788-02", i = list(c(-3))),
  tibble::tibble(x = "C-795-04", i = list(c(-4))),
  tibble::tibble(x = "C-811-07", i = list(c(-9))),
  tibble::tibble(x = "C-914-13", i = list(c(-9))),
  tibble::tibble(x = "SU-032-22", i = list(c(-2))),
  tibble::tibble(x = "SU-363-21", i = list(c(-2, -6))),
  tibble::tibble(x = "SU-539-12", i = list(c(-3, -4))),
  tibble::tibble(x = "SU-881-05", i = list(c(-6)))
)

out_fix <- pmap(d, \(x, i) slice_person_output(output[[x]], i))
names(out_fix) <- map_chr(out_fix, pluck, "id")
output[names(out_fix)] <- out_fix

# Fix Missing People ------------------------------------------------------

# Very annoying, this is not the fault of ChatGPT.
output[["C-557-92"]][["person"]] <- data.frame(
  name = c(
    "Simón Rodríguez Rodríguez",
    "Ciro Angarita Barón",
    "Eduardo Cifuentes Muñoz",
    "José Gregorio Hernández Galindo",
    "Alejandro Martínez Caballero",
    "Fabio Morón Díaz",
    "Jaime Sanín Greiffenstein"
  ),
  av = rep(FALSE, 7),
  sv = c(FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE),
  mp = c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE),
  interim = rep(FALSE, 7),
  conjuez = rep(FALSE, 7)
)

output[["SU-073-20"]][["person"]] <- bind_rows(
  output[["SU-073-20"]][["person"]],
  data.frame(
    name = c(
      "Ruth Stella Correa Palacio",
      "Emilssen González de Cancino",
      "Luis Fernando López Roca",
      "Mauricio Piñeros Perdomo"
    ),
    av = rep(FALSE, 4),
    sv = rep(FALSE, 4),
    mp = rep(FALSE, 4),
    interim = rep(FALSE, 4),
    conjuez = rep(TRUE, 4)
  )
)

output[["C-556-92"]][["person"]] <- bind_rows(
  output[["C-556-92"]][["person"]],
  data.frame(
    name = c(
      "Fabio Morón Díaz",
      "Jaime Sanín Greiffenstein",
      "José Gregorio Hernández Galindo"
    ),
    av = rep(FALSE, 3),
    sv = rep(FALSE, 3),
    mp = rep(FALSE, 3),
    interim = rep(FALSE, 3),
    conjuez = rep(FALSE, 3)
  )
)

output[["C-579-92"]][["person"]] <- bind_rows(
  output[["C-579-92"]][["person"]],
  data.frame(
    name = c(
      "Fabio Morón Díaz",
      "Jaime Sanín Greiffenstein",
      "José Gregorio Hernández Galindo",
      "Eduardo Cifuentes Muñoz"
    ),
    av = rep(FALSE, 4),
    sv = rep(FALSE, 4),
    mp = rep(FALSE, 4),
    interim = rep(FALSE, 4),
    conjuez = rep(FALSE, 4)
  )
)

# Fix idiosyncracies -----------------------------------------------------

# Ok, so at first I thought that the reporting judge ("magistrado ponente")
# was in charge of authoring the ruling. This is not exact. The reporting
# judge is in charge of writing down the ruling, but it is not in charge of
# being its sole author. Thus, it is possible that the reporter also writes
# down a dissenting and/or concurring opinion.
#
# In only just realized this.
#
# It is a miracle that I didn't incorporate this misunderstanding in the prompt.
#
# Originally I thought that it would always be a bug whenever `mp == TRUE` and
# `sv == TRUE` or `av == TRUE`. But this is not true.
#
# However, after checking some of these rulings (which are rare) I found rare
# instances in which the information about the `sv` or `av` was glimpsed from
# a footnote that referred to a previous ruling in which the same judges
# participated. This does not happen very often.
#
# I was not able to fix this with better prompts.
#
# The best I can do is run a search on occurences of the phrase "En relación con
# esta sentencia salvaron su voto los magistrados" which appears in the footnotes.
# I did that in an adhoc script in the `ccc/data-raw` folder.
#
# ```
# library(tidyverse)
# id <- str_remove(dir("data-raw/texts/"), "\\.rds$")
# index <- map_lgl(
#   str_glue("data-raw/texts/{id}.rds"),
#   function(x) {
#     txt <- read_rds(x)
#     str_detect(txt, "En relación con (esta sentencia|la decisión adoptada sobre este artículo) salvaron (su|el) voto")
#   },
#   .progress = TRUE
# )
# id[index]
# ```
#
# This is what I found: "C-076-04", "C-1096-03"

output[["C-076-04"]][["person"]][["sv"]] <- rep(FALSE, 9)
output[["C-1096-03"]][["person"]][["sv"]] <- rep(FALSE, 9)

# I could not remove the wrongful attribution of a dissenting opinion in "C-509-09" via prompt.
# This is an ad hoc change:

output[["C-509-09"]][["person"]][["sv"]] <- rep(FALSE, 8)
output[["C-062-93"]][["person"]][["conjuez"]] <- rep(TRUE, 7)

# Standardize names (no accents, lowercase, etc.) ------------------------

person <- purrr::map_df(output, \(x) cbind(id = x$id, x$person))

person <- person |>
  mutate(name = stringr::str_to_lower(name)) |>
  mutate(name = stringi::stri_trans_general(name, "Latin-ASCII"))

## Heuristic Search:
##   The `adist()` function calculates the edit distance between names.
##   Here I only calculate edit distance `from` frequent names.

names_count <- table(person$name) |> sort(decreasing = TRUE)
i <- which(names_count >= 150)
editM <- adist(names(names_count[i]), names(names_count))
dimnames(editM) <- list(names(names_count[i]), names(names_count))

lookup <- apply(editM, 1, function(x) {
  i <- which(x != 0 & x <= 5)
  names(x)[i]
})

ok <- map_lgl(lookup, \(x) !rlang::is_empty(x))
lookup <- lookup[ok]

# To do: Figure out a way to make the following code prettier

lookup[str_detect(names(lookup), "martelo")] <- NULL
lookup[["gabriel eduardo mendoza martelo"]] <- c(
  "gabriel eduardo mendoza martello",
  "grabriel eduardo mendoza martelo",
  "gabriel eduardo medonza martelo",
  "gabriel e. mendoza martelo",
  "gabriel mendoza martelo",
  "gabiel eduardo martelo",
  "gabriel eduardo martelo mendoza",
  "gabriel eduardo mendoza m.",
  "gabriel eduardo mendoza"
)

lookup[str_detect(names(lookup), "pinilla")] <- NULL
lookup[["nilson pinilla pinilla"]] <- c(
  "nelson pinilla pinilla",
  "nilson e. pinilla pinilla",
  "nilson elias pinilla pinilla"
)

lookup[str_detect(names(lookup), "sachica")] <- NULL
lookup[["martha victoria sachica mendez"]] <- c(
  "marta sachica mendez",
  "martha sachica mendez",
  "martha sachica de moncaleano",
  "martha victoria sachica",
  "marta victoria sachica mendez",
  "maria victoria sachica mendez",
  "martha victoria sachica moncaleano",
  "marta victoria sachica de moncaleano",
  "martha victoria sachica de moncaleano",
  "martha v. sachica de moncaleano",
  "martha v. sachica mendez"
)

lookup[["susana montes de echeverri"]] <- c(
  "susana montes de echeverry",
  "susana montes",
  "susana montes echeverri",
  "susana montes echeverry"
)

lookup[["mario madrid-malo garizabal"]] <- c(
  "mario madrid malo garizabal"
)

lookup[["juan carlos henao perez"]] <- c(
  "juan carlos henao"
)

lookup[["jose antonio cepeda amaris"]] <- c(
  "jose antonio cepedas amaris"
)

lookup[["catalina botero marino"]] <- c(
  "catalina botero",
  "catalina botero merino"
)

lookup[["maria victoria calle correa"]] <- c(
  lookup[["maria victoria calle correa"]],
  "maria victoria calle de gomez",
  "maria victoria calle"
)

lookup[["cristina pardo schlesinger"]] <- c(
  lookup[["cristina pardo schlesinger"]],
  "cristina pardo s."
)

lookup[["paola andrea meneses mosquera"]] <- c(
  lookup[["paola andrea meneses mosquera"]],
  "paola andrea meneses",
  "paula andrea meneses mosquera",
  "paola meneses mosquera"
)

lookup[["alejandro linares cantillo"]] <- c(
  lookup[["alejandro linares cantillo"]],
  "alejandro linares estrada"
)

lookup[["alejandro martinez caballero"]] <- c(
  lookup[["alejandro martinez caballero"]],
  "alejandro martinez"
)

lookup[["alexei julio estrada"]] <- c(
  lookup[["alexei julio estrada"]],
  "alexei julio"
)

lookup[["richard s. ramirez grisales"]] <- c(
  "richard steve ramirez grisales",
  "richard ramirez grisales",
  "richard s. grisales ramirez"
)

lookup[["jaime araujo renteria"]] <- c(
  lookup[["jaime araujo renteria"]],
  "alvaro araujo renteria"
)

lookup[["clara elena reales gutierrez"]] <- c(
  "clara helena reales gutierrez",
  "clara elena reales guierrez"
)

lookup[["diana fajardo rivera"]] <- c(
  "diana constanza fajardo rivera",
  "diana cristina fajardo rivera"
)

lookup[["diego lopez medina"]] <- c("diego eduardo lopez medina")
lookup[["fernando hinestrosa forero"]] <- c(
  "fernando hinestrosa",
  "fernando hinestroza forero"
)

lookup[["gloria stella ortiz delgado"]] <- c(
  lookup[["gloria stella ortiz delgado"]],
  "gloria stella delgado",
  "gloria stella ortiz"
)

lookup[["jorge ivan palacio palacio"]] <- c(
  "jorge ivan palacio",
  "jorge ivan palacio pinilla"
)

lookup[["jorge ignacio pretelt chaljub"]] <- c(
  lookup[["jorge ignacio pretelt chaljub"]],
  "jorge pretelt chaljub",
  "jorge pretel chaljub"
)

lookup[["jorge gabino pinzon sanchez"]] <- c("jorge pinzon sanchez")

lookup[["manuel jose cepeda espinosa"]] <- c(
  lookup[["manuel jose cepeda espinosa"]],
  "manuel jose cepeda"
)

lookup[["carlos bernal pulido"]] <- c("carlos libardo bernal pulido")

lookup[["adriana maria guillen arango"]] <- c(
  lookup[["adriana maria guillen arango"]],
  "adriana maria guillen",
  "adriana guillen arango",
  "adriana guillen"
)

lookup[["luis guillermo guerrero perez"]] <- c(
  lookup[["luis guillermo guerrero perez"]],
  "luis guillermo perez"
)

lookup[["luis ernesto vargas silva"]] <- c("luis ernesto vargas")

lookup[["antonio jose lizarazo ocampo"]] <- c(
  lookup[["antonio jose lizarazo ocampo"]],
  "jose antonio lizarazo ocampo"
)

lookup[["eduardo cifuentes munoz"]] <- c(
  lookup[["eduardo cifuentes munoz"]],
  "eduardo cifuentes caballero"
)

lookup[["maria teresa garces lloreda"]] <- c(
  "maria teresa garces llorada",
  "maria teresa garces"
)

lookup[["alfredo beltran sierra"]] <- c(
  lookup[["alfredo beltran sierra"]],
  "alfredo tulio beltran sierra"
)

lookup[str_detect(names(lookup), "sierra porto")] <- NULL
lookup[["humberto antonio sierra porto"]] <- c(
  "humberto a. sierra porto",
  "humberto sierra porto"
)

lookup[["marco gerardo monroy cabra"]] <- c(
  lookup[["marco gerardo monroy cabra"]],
  "marco gerardo monroy"
)

lookup[["jose gregorio hernandez galindo"]] <- c(
  lookup[["jose gregorio hernandez galindo"]],
  "jose gregorio hernandez"
)

lookup[["carmenza isaza de gomez"]] <- c("carmenza isaza gomez")

lookup[["hernan correa cardozo"]] <- c("hernan leandro correa cardozo")

lookup[["ivan humberto escruceria mayolo"]] <- c("ivan escruceria mayolo")

lookup[["ruth stella correa palacio"]] <- c("ruth stella correa")

lookup[["aquiles arrieta gomez"]] <- c("aquiles ignacio arrieta gomez")

lookup[["myriam avila roldan"]] <- c(
  lookup[["myriam avila roldan"]],
  "myriam avila"
)

lookup[["pedro lafont pianetta"]] <- c("pedro lafontt pianeta")

lookup[["miguel polo rosero"]] <- c(
  "miguel efrain polo rosero",
  "miguel efrain polo roseo"
)

lookup[["martin gonzalo bermudez munoz"]] <- c("martin bermudez munoz")

lookup[["luis javier moreno ortiz"]] <- c("luis javier moreno")

lookup[["karena caselles hernandez"]] <- c("karena elisama caselles hernandez")

lookup[["jose miguel de la calle restrepo"]] <- c("jose miguel de la calle")

lookup[["jairo charry rivas"]] <- c("jairo rivas charry")

lookup[["edgardo jose maya villazon"]] <- c("edgardo maya villazon")

lookup[["carmen millan de benavides"]] <- c("carmen milan de benavides")

lookup[["julio cesar ortiz gutierrez"]] <- c("julio cesar sanchez gutierrez")

lookup_d <- lookup |>
  enframe() |>
  unnest(value) |>
  select(value, name) |>
  deframe()

person <- person |>
  mutate(
    name = if_else(
      condition = name %in% names(lookup_d),
      true = lookup_d[name],
      false = name
    )
  )

person <- person |>
  as_tibble() |>
  relocate(id, name, mp, av, sv, interim, conjuez)


# Fix missing `mp` -------------------------------------------------------

missing_mp <- person |>
  summarize(mp = sum(mp), .by = id) |>
  filter(mp == 0L) |>
  pull(id)

missing_mp ## there are 11 rulings with a missing `mp`

person |>
  rowid_to_column() |>
  filter(id %in% missing_mp)

i <- c(
  "C-071-20" = 6006, # cristina pardo schlesinger
  "C-093-21" = 7820, # antonio jose lizarazo ocampo
  "C-093-21" = 7827, # jose fernando reyes cuartas
  "C-530-13" = 45541, # mauricio gonzalez cuervo
  "C-556-92" = 47535, # simon rodriguez rodriguez
  "C-579-92" = 48925, # simon rodriguez rodriguez
  "T-007-97" = 69920, # eduardo cifuentes munoz
  "T-125-97" = 81935, # eduardo cifuentes munoz
  "T-225-92" = 89819, # jaime sanin greiffenstein
  "T-254-01" = 91661, # jaime cordoba trivino
  "T-671-96" = 117690 # eduardo cifuentes munoz
)

person[i, ]$mp <- TRUE

# Use `appointed_judges` data to fix missing interim ---------------------

load("data/appointed_judges.rda")

check <- pmap_lgl(
  .l = person[c("name", "interim", "conjuez")],
  .f = function(name, interim, conjuez) {
    !name %in% appointed_judges$name & !interim & !conjuez
  }
)

person[which(check), ]$interim <- !person[which(check), ]$interim

# Export -----------------------------------------------------------------

# unname name vector

usethis::use_data(person, overwrite = TRUE, compress = "xz")
