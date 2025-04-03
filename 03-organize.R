library(tidyverse)
library(cli)

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

# YOU ARE HERE... I just deleted the NOT ok files, to see if they are picked up again.
# Now I have to check them all again

make_all_sv_false <- c(
  "C-011-00",
  "C-076-04",
  "C-1096-03",
  "C-509-09",
  "C-455-06"
)

make_some_sv_false <- c(
  "C-482-96" # Jorge Arango Mejía
)

make_some_av_false <- c(
  "C-560-95" # Antonio Barrera Carbonell
)

these_are_NOT_ok <- c(
  make_all_sv_false,
  make_some_sv_false,
  make_some_av_false
)

# However, it turns out some of these are correct. They are weird, but
# nonetheless correct...

these_are_ok <- c(
  "C-338-94",
  "C-127-97",
  "C-135-97",
  "C-136-97",
  "C-139-97",
  "C-582-95",
  "C-625-96",
  "C-002-96"
)

person <- map_df(output, function(x) {
  out <- x$person
  cbind(id = x$id, out)
})

person |>
  filter(mp, sv, av)

person |>
  filter(mp, sv)

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

# Standardize citations --------------------------------------------------

# asdfasdf

# Fix amicus -------------------------------------------------------------

# office holder to office
