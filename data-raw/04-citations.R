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


# articles ----------------------------------------------------------------

articles <- map(output, pluck, "articles")

articles <- articles |> 
  enframe(name = "id", value = "article") |> 
  unnest(article)

usethis::use_data(articles, overwrite = TRUE, compress = "xz")

# rj_citations ------------------------------------------------------------

rj_citations <- map(output, pluck, "rj_citation_raw")

ok <- map_lgl(output, \(x) x[["rj"]] != "no")

rj_citations <- rj_citations[ok] |> 
  enframe("from", "to_raw") |> 
  unnest(to_raw) 

rj_citations$to <- map_chr(rj_citations[["to_raw"]], function(x) {
  out <- ccc::extract_citations(x)
  if (rlang::is_empty(out)) return(NA_character_)
  out
})

filter(rj_citations, is.na(to)) # To do: manual check

rj_citations <- rj_citations |> 
  select(!to_raw) |> 
  drop_na()

usethis::use_data(rj_citations, overwrite = TRUE, compress = "xz")



