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
  
  out <- out[out %in% ccc::metadata$id]

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


# JCTT --------------------------------------------------------------------

env_jctt <- new.env()
source("data-raw/collections/transitional_justice_uniandes.R", local = env_jctt)
jctt <- get("jctt", env_jctt)


# Fix Bugs ----------------------------------------------------------------

peace[[3]] <- setdiff(peace[[3]], "SU-337-17")

# Internal Save -----------------------------------------------------------

usethis::use_data(
  legislative_decrees,
  treaties, 
  peace, 
  gender,
  codes,
  jctt,
  internal = TRUE,
  overwrite = TRUE
)
