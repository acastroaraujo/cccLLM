# Setup -------------------------------------------------------------------

library(tidyverse)
load("data/person.rda")

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

  out <- as_tibble(x[c("id", "chamber_raw", "rj")])

  out$summary_en <- x$summary$english
  out$summary_es <- x$summary$spanish

  return(out)
})

rulings <- full_join(rulings, summarize(person, n = n(), .by = "id"))

rulings |> 
  mutate(chamber_raw = tolower(chamber_raw)) |> 
  mutate(type = str_extract(id, "^(C|SU|T|A)")) |> 
  count(n, type)

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

# Standardize citations --------------------------------------------------

# asdfasdf
