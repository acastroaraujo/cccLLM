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
  ## To do: Change code to `sample(texts_left, 1)` when you move to usage tier 4
  ## https://platform.openai.com/settings/organization/limits

  id <- texts_left[[i]]

  SP <- glue::glue(
    paste(readLines("prompts/system.md"), collapse = "\n"),
    .envir = rlang::new_environment(data = list(ruling_id = id)),
  )

  chat <- ellmer::chat_openai(
    system_prompt = SP,
    model = "gpt-4o-2024-08-06",
    api_args = list(temperature = 0)
  )

  url <- lookup[[id]]
  txt <- try(ccc::ccc_txt(url))

  if (inherits(txt, "try-error")) next

  out <- try(
    chat$extract_data(
      txt,
      type = ruling_summary,
      echo = "text",
      convert = TRUE
    )
  )

  if (inherits(out, "try-error")) next

  out$url <- url
  out$id <- id
  out$model <- "gpt-4o"

  readr::write_rds(
    x = out,
    file = stringr::str_glue("{outfolder}/{id}_gpt.rds"),
    compress = "gz"
  )

  texts_done <- c(texts_done, id)

  cli::cli_alert_success(stringr::str_glue(
    "Progress: {length(texts_done)} / {length(texts)}"
  ))

  Sys.sleep(runif(1, min = 0, max = 2))
}

# x <- sample(texts_done, size = 1)
# x <- "T-132-04"
# out <- readRDS(str_glue("~/Repositories/cccLLM/out_raw/{x}_gpt.rds"))
# out
