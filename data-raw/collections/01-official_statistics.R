library(tidyverse)
library(readxl)

## Accesed on 2025-04-29

# Helpers ----------------------------------------------------------------

read_parse <- function(path) {
  out <- suppressMessages(readxl::read_excel(path, skip = 11)) |>
    dplyr::filter(!stringr::str_detect(Sentencia, "^A")) |>
    dplyr::pull(Sentencia) |>
    stringr::str_replace_all("\\.", "-") |>
    paste(collapse = "; ") |>
    ccc::extract_citations()

  out <- list(out)
  names(out) <- stringr::str_replace(path, ".*/([^/]+)\\.xlsx$", "\\1")
  out
}

# Legislative Decrees ----------------------------------------------------

paths <- dir("data-raw/collections/legislative_decrees/", full.names = TRUE)
legislative_decrees <- map(paths, read_parse) |> unlist(recursive = FALSE)

# Treaties ---------------------------------------------------------------

paths <- dir("data-raw/collections/treaties/", full.names = TRUE)
treaties <- map(paths, read_parse) |> unlist(recursive = FALSE)

# Peace ------------------------------------------------------------------

paths <- dir("data-raw/collections/peace/", full.names = TRUE)
peace <- map(paths, read_parse) |> unlist(recursive = FALSE)

# Gender -----------------------------------------------------------------

paths <- dir("data-raw/collections/gender/", full.names = TRUE)
gender <- map(paths, read_parse) |> unlist(recursive = FALSE)

# Codes ------------------------------------------------------------------

paths <- dir("data-raw/collections/codes/", full.names = TRUE)
codes <- map(paths, read_parse) |> unlist(recursive = FALSE)

# Internal Save -----------------------------------------------------------

usethis::use_data(
  legislative_decrees,
  treaties, 
  peace, 
  gender,
  codes,
  internal = TRUE,
  overwrite = TRUE
)
