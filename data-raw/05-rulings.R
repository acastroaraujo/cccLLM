# Setup -------------------------------------------------------------------

library(tidyverse)
load("data/person.rda")
load("data/amicus.rda")
load("data/rj_citations.rda")

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

# Standardize chamber ----------------------------------------------------

rulings <- map_df(output, function(x) {
  ## turn null output into missing data
  null <- map_lgl(x, rlang::is_empty)
  x[null] <- NA_character_

  out <- as_tibble(x[c("id", "rj", "model")])

  out$summary_en <- x$summary$english
  out$summary_es <- x$summary$spanish

  return(out)
})

rulings <- rulings |>
  full_join(summarize(person, n_person = n(), .by = "id")) |>
  full_join(summarize(amicus, n_amicus = n(), .by = "id")) |>
  mutate(n_amicus = if_else(is.na(n_amicus), 0L, n_amicus)) |>
  mutate(type = str_extract(id, "^(C|SU|T|A)")) |>
  mutate(chamber = if_else(n_person <= 3, "SR", "SP")) |>
  full_join(select(ccc::metadata, id, date)) |>
  arrange(date)

rulings <- rulings |>
  relocate(
    id,
    date,
    type,
    chamber,
    rj,
    n_person,
    n_amicus,
    summary_en,
    summary_es,
    model
  ) |>
  mutate(
    type = factor(type),
    chamber = factor(chamber),
    rj = case_when(
      rj == "sí" ~ "yes",
      rj == "parcial" ~ "partial",
      rj == "no" ~ "no"
    )
  )

rulings$rj <- if_else(
  condition = !rulings$id %in% unique(rj_citations$from),
  true = "no",
  false = rulings$rj
)

rulings$rj <- factor(rulings$rj)

usethis::use_data(rulings, overwrite = TRUE, compress = "xz")
