# Packages and Functions -------------------------------------------------

library(tidyverse)

parse_es_date <- function(x) {
  readr::parse_date(x, locale = locale("es"), format = "%B de %Y")
}

tolower_ascii <- function(x) {
  stringi::stri_trans_general(tolower(x), "Latin-ASCII")
}

# Data -------------------------------------------------------------------

d <- read_tsv("data-raw/official/judges_appointed.tsv")

appointed_judges <- d |>
  separate_wider_delim(dates, delim = " a ", names = c("start", "end")) |>
  mutate(across(c(start, end), parse_es_date)) |>
  mutate(name = tolower_ascii(name)) |>
  filter(start <= as.Date("2024-04-03")) |>
  mutate(
    end = if_else(
      condition = end > as.Date("2024-04-03"),
      true = as.Date("2024-04-03"),
      false = end
    )
  )

usethis::use_data(appointed_judges, overwrite = TRUE, compress = "xz")
