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

articles_init <- articles |>
  enframe(name = "id", value = "article") |>
  unnest(article) |> 
  filter(dplyr::between(article, 1, 380)) |> 
  distinct()

articles_init |> 
  count(id, sort = TRUE)

articles[["T-485-15"]] <- 
  c(1, 2, 3, 7, 38, 40, 49, 53, 93, 94, 241, 329, 330)

articles[["T-1291-05"]] <- 
  c(1, 2, 4, 13, 25, 42, 43, 44, 45, 46, 47, 48, 50, 53, 
    54, 58, 68, 86, 93, 150, 228, 229, 241, 366)

articles[["T-360-97"]] <- NULL

articles[["C-089-94"]] <- 
  c(1, 2, 3, 5, 7, 9, 13, 20, 29, 34, 37, 38, 40, 57, 60, 
    64, 73, 75, 77, 83, 86, 93, 95, 103, 104, 105, 107, 108, 
    109, 111, 112, 116, 124, 127, 136, 145, 150, 152, 154, 
    155, 156, 157, 158, 182, 209, 229, 230, 241, 243, 244, 
    259, 264, 265, 270, 303, 314, 335, 342, 350, 357, 372, 
    373, 375, 377)

articles[["C-142-01"]] <- 
  c(1, 2, 3, 4, 5, 6, 13, 14, 15, 16, 18, 21, 29, 37, 40, 
    83, 84, 90, 93, 95, 98, 99, 100, 103, 104, 105, 106, 
    107, 108, 109, 111, 113, 120, 121, 132, 133, 152, 153, 
    155, 170, 171, 176, 188, 190, 202, 228, 229, 230, 258, 
    259, 260, 261, 262, 263, 264, 265, 266, 287, 293, 299, 
    303, 304, 307, 311, 312, 314, 316, 318, 319, 321, 323, 
    326, 327, 375, 377, 378, 379, 380)


articles <- articles |>
  enframe(name = "id", value = "article") |>
  unnest(article) |> 
  filter(dplyr::between(article, 1, 380)) |> 
  distinct()

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

# On close inspection, most of these omissions seem OK, but I should check 
# more systematically.
filter(rj_citations, is.na(to)) 

rj_citations <- rj_citations |>
  select(!to_raw) |>
  drop_na()

rj_citations <- rj_citations |>
  filter(to %in% ccc::metadata$id) |> 
  distinct()

usethis::use_data(rj_citations, overwrite = TRUE, compress = "xz")
