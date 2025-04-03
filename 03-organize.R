# Packages ---------------------------------------------------------------

library(tidyverse)
library(cli)

# Helpers ----------------------------------------------------------------

create_index <- function(vals_list, data) {
  ldf <- vals_list |>
    tibble::enframe("id", "name") |>
    tidyr::unnest(name)

  index <- purrr::pmap_dbl(ldf, function(id, name) {
    which(data$id == id & data$name == name)
  })

  out <- vector("logical", nrow(data))
  out[index] <- TRUE
  out
}

# Data -------------------------------------------------------------------

outfolder <- "out_raw"

output <- dir(outfolder, full.names = TRUE) |>
  purrr::map(function(x) readr::read_rds(x), .progress = TRUE)

names(output) <- map_chr(output, pluck, "id")

# Fix idiosyncracies -----------------------------------------------------

# For example, having mp and sv simultaneously. This problem arises when
# information about dissenting opinions is found in the footnotes but not
# in the main text. I was not able to fix this with better prompts, so
# the best fix is to identify instances in which `mp == TRUE` & `sv == FALSE`,
# and make the corresponding changes.

make_all_sv_false <- c(
  "C-076-04",
  "C-1096-03",
  "C-509-09",
  "C-011-00"
)

make_all_av_false <- c(
  "C-567-93"
)

make_some_sv_false <- c(
  "C-482-96", # Jorge Arango Mejía
  "C-373-95", # Carlos Gaviria Díaz
  "T-539A-93", # Carlos Gaviria Díaz
  "T-539A-93" # José Gregorio Hernández Galindo
)

make_some_av_false <- c(
  "C-560-95", # Antonio Barrera Carbonell
  "C-011-00", # Alfredo Beltrán Sierra
  "C-011-00" # Carlos Gaviria Díaz
)

these_are_NOT_ok <- c(
  make_all_sv_false,
  make_all_av_false,
  make_some_sv_false,
  make_some_av_false
)

# However, it turns out some of these are correct. They are weird, but
# nonetheless correct...

these_are_ok <- c(
  "C-214-93",
  "C-338-94",
  "C-152-95",
  "C-582-95",
  "C-625-96",
  "C-002-96",
  "C-451-96",
  "C-127-97",
  "C-135-97",
  "C-136-97",
  "C-139-97",
  "C-885-07"
)

person <- map_df(output, function(x) {
  out <- x$person
  cbind(id = x$id, out)
})

check1 <- person |>
  filter(mp, sv, av) |>
  pull(id)

check2 <- person |>
  filter(mp, sv) |>
  pull(id)

check3 <- person |>
  filter(mp, av) |>
  pull(id)

check4 <- person |>
  filter(av, sv) |>
  pull(id)

# You are here... at the end of the process, all these `check_` diffs should be empty

#setdiff(c(these_are_NOT_ok, these_are_ok), check1)
setdiff(check1, c(these_are_NOT_ok, these_are_ok))
setdiff(check2, c(these_are_NOT_ok, these_are_ok))
setdiff(check3, c(these_are_NOT_ok, these_are_ok))
setdiff(check4, c(these_are_NOT_ok, these_are_ok))

output[["C-011-00"]]

# Standardize names (no accents, lowercase, etc.) ------------------------

person <- person |>
  mutate(name = stringr::str_to_title(name)) |>
  mutate(name = stringi::stri_trans_general(name, "Latin-ASCII"))

## Fix mispellings.

nms_count <- table(person$name) |> sort(decreasing = TRUE)
i <- which(nms_count >= 50)
editM <- adist(names(nms_count[i]), names(nms_count))
dimnames(editM) <- list(names(nms_count[i]), names(nms_count))

lookup <- apply(editM, 1, function(x) {
  i <- which(x != 0 & x <= 5)
  names(x)[i]
})

lookup[str_detect(names(lookup), "Sachica")] <- NULL

lookup[["Martha Victoria Sachica Mendez"]] <- c(
  "Martha Victoria Sachica De Moncaleano",
  "Martha Sachica De Moncaleano",
  "Martha V. Sachica De Moncaleano",
  "Martha Victoria Sachica Moncaleano",
  "Martha V. Sachica Mendez",
  "Marta Victoria Sachica De Moncaleano",
  "Martha Sachica Mendez",
  "Marta Victoria Sachica Mendez",
  "Martha Victoria Sachica"
)

ok <- map_lgl(lookup, \(x) !rlang::is_empty(x))

lookup <- lookup[ok] |>
  enframe() |>
  unnest(value) |>
  select(value, name) |>
  deframe()

person <- person |>
  mutate(
    name = if_else(
      condition = name %in% names(lookup),
      true = lookup[name],
      false = name
    )
  )

person |> count(name, sort = TRUE)

## Finish fixing names

# Adriana Guillen should always be `interim`, look for other mostly
# interim judges and make changes accordingly

# Standardize chamber ----------------------------------------------------

df <- map_df(output, function(x) {
  null <- map_lgl(x, rlang::is_empty) ## turn null output into
  x[null] <- NA_character_ ## missing

  out <- as_tibble(x[c("id", "chamber_raw", "rj", "url")])

  # out$spanish <- x$summary$spanish
  # out$english <- x$summary$english

  out$person <- list(x$person)
  return(out)
})

df <- df |>
  mutate(n = map_dbl(person, nrow))

df <- df |>
  mutate(
    chamber = case_when(
      n <= 3 ~ "SR",
      n > 3 ~ "SP"
    )
  )

df |>
  ggplot(aes(factor(n))) +
  geom_bar()

df |>
  filter(n == 10)

filter_out <- list(
  "C-153-96" = "Martha Victoria Sachica Mendez",
  "T-254-01" = "Jose Gregorio Hernandez Galindo",
  "C-382-12" = c(
    "Nilson Pinilla Pinilla",
    "Maria Victoria Calle Correa",
    "Adriana Maria Guillen Arango",
    "Luis Ernesto Vargas Silva",
    "Jorge Ivan Palacio Palacio"
  )
)

switch_sv <- list(
  "T-254-01" = "Jaime Cordoba Trivino",
  "C-482-96" = "Jorge Arango Mejia",
  "C-373-95" = "Carlos Gaviria Diaz",
  "T-539A-93" = "Carlos Gaviria Diaz",
  "T-539A-93" = "Jose Gregorio Hernandez Galindo",
  "C-509-09" = "Mauricio Gonzalez Cuervo",
  "C-076-04" = c(
    "Luis Eduardo Montealegre Lynett",
    "Rodrigo Escobar Gil",
    "Manuel Jose Cepeda Espinosa"
  ),
  "C-1096-03" = c(
    "Jaime Araujo Renteria",
    "Alfredo Beltran Sierra"
  ),
  "C-011-00" = c(
    "Alfredo Beltran Sierra",
    "Carlos Gaviria Diaz"
  )
)

switch_av <- list(
  "C-560-95" = "Antonio Barrera Carbonell",
  "C-011-00" = c(
    "Alfredo Beltran Sierra",
    "Carlos Gaviria Diaz"
  ),
  "C-567-93" = c(
    "Fabio Moron Diaz",
    "Alejandro Martinez Caballero",
    "Carlos Gaviria Diaz",
    "Eduardo Cifuentes Munoz"
  )
)

## use ! to change TRUE to FALSE and vice versa
i <- create_index(switch_av, person)
person$av[i] <- !person$av[i]

i <- create_index(switch_sv, person)
person$sv[i] <- !person$sv[i]

i <- create_index(filter_out, person)
person <- person[!i, ]

# Standardize citations --------------------------------------------------

# asdfasdf

# Fix amicus -------------------------------------------------------------

# office holder to office
