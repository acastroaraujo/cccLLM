# devtools::install_github("acastroaraujo/ccc")
library(ccc)
library(tidyverse)
library(ellmer)

outfolder <- "rulings_length_exceeded"
if (!dir.exists(outfolder)) dir.create(outfolder)

lookup <- ccc::metadata |>
  dplyr::arrange(word_count) |>
  dplyr::filter(word_count >= 200) |> ## anuladas
  dplyr::select(id, url) |>
  tibble::deframe()

texts <- names(lookup)
texts_done <- stringr::str_remove(dir("out_raw"), "_gpt\\.rds$")
texts_left <- setdiff(texts, texts_done)

for (i in seq_along(texts_left)) {
  id <- texts_left[[i]]
  url <- lookup[[id]]
  txt <- try(ccc::ccc_txt(url))
  readr::write_file(txt, glue::glue("{outfolder}/{id}.txt"))
  cat(i / length(texts_left), "\n")
  Sys.sleep(runif(1))
}
