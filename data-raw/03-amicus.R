# Setup -------------------------------------------------------------------

library(tidyverse)

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

# amicus ------------------------------------------------------------------

ok <- map_lgl(output, \(x) !rlang::is_empty(x[["amicus"]]))

amicus <- purrr::map_df(output[ok], function(x) {
  if (nrow(x[["amicus"]]) == 0)
    return(data.frame(
      id = character(),
      name = character(),
      affiliation = character()
    ))
  cbind(id = x$id, x$amicus)
})

amicus <- as_tibble(amicus) |>
  mutate(across(
    c(name, affiliation),
    \(x) ifelse(x == "NULL" | x == "", NA_character_, x)
  )) |>
  mutate(across(c(name, affiliation), stringr::str_to_lower)) |>
  mutate(across(
    c(name, affiliation),
    \(x) stringi::stri_trans_general(x, "Latin-ASCII")
  )) |>
  distinct()

amicus <- amicus |>
  mutate(type = str_extract(id, "^(C|SU|T|A)")) |>
  # Remove Procuraduría from `C` cases
  filter(!(type == "C" & str_detect(affiliation, "^(vice)?procurad"))) |>
  mutate(
    affiliation = if_else(
      affiliation == "persona natural",
      NA_character_,
      affiliation
    )
  ) |>
  select(!type)

# lookup <- function(x, .default) {
#   case_when(
#     str_detect(x, "defensor(ia)? del pueblo") ~ "defensoria del pueblo",
#     TRUE ~ .default
#   )
# }
#
# clean_name <- function(x) {
#   rgx <- c(
#     "defensor(ia)? del pueblo",
#     "ministerio de hacienda",
#     "procura(dor|duria) general de la nacion",
#     "ministerio de justicia"
#   )
#   i <- map_lgl(x, \(x) any(str_detect(x, rgx)))
#   if_else(i, NA_character_, x)
# }
#
# amicus |>
#   mutate(affiliation = lookup(name, affiliation)) |>
#   mutate(name = clean_name(name)) |>
#   count(name, sort = TRUE)
#
# amicus |>
#   filter(str_detect(name, "defensor(ia)? del pueblo")) |>
#   count(name)

usethis::use_data(amicus, overwrite = TRUE, compress = "xz")


