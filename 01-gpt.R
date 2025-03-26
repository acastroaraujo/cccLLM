# devtools::install_github("acastroaraujo/ccc")
library(ccc)
library(tidyverse)
library(ellmer)

source("prompts/ruling_summary.R")

outfolder <- "out_raw"
if (!dir.exists(outfolder)) dir.create(outfolder)

lookup <- ccc::metadata |>
  dplyr::arrange(word_count) |>
  dplyr::filter(word_count >= 200) |> ## anuladas
  dplyr::select(id, url) |>
  tibble::deframe()

texts <- names(lookup)
texts_done <- stringr::str_remove(dir(outfolder), "_gpt\\.rds$")
texts_left <- setdiff(texts, texts_done)

for (i in seq_along(texts_left)) {
  id <- texts_left[[i]]
  SP <- glue::glue(paste(readLines("prompts/system.md"), collapse = "\n"))

  chat <- ellmer::chat_openai(
    system_prompt = SP,
    model = "gpt-4o",
    api_args = list(temperature = 0)
  )

  url <- lookup[[id]]
  txt <- ccc::ccc_txt(url)

  out <- chat$extract_data(txt, type = ruling_summary)
  out$url <- url
  out$id <- id
  out$model <- "gpt-4o"

  readr::write_rds(
    x = out,
    file = stringr::str_glue("{outfolder}/{id}_gpt.rds"),
    compress = "gz"
  )

  texts_left <- texts_left[-i]
  texts_done <- setdiff(texts, texts_left)

  message(length(texts_done), "/", length(texts))
  Sys.sleep(runif(1, min = 0, max = 2))
}

# x <- sample(texts_done, size = 1)
# out <- readRDS(str_glue("~/Repositories/cccLLM/out_raw/{x}_gpt.rds"))
# out
