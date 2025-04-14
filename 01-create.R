# Packages ---------------------------------------------------------------

library(ccc) # devtools::install_github("acastroaraujo/ccc")
library(tidyverse)
library(ellmer)

# Very Large Rulings -----------------------------------------------------

# Some documents exceed the maximum "context" length of 128000 tokens. I
# coded these rulings separately and stored them in a different folder.

rulings_json <- stringr::str_remove(dir("out_raw_exceeded"), "\\.json$")

# Set up -----------------------------------------------------------------

outfolder <- "out_raw"
if (!dir.exists(outfolder)) dir.create(outfolder)

lookup <- ccc::metadata |>
  dplyr::arrange(word_count) |>
  dplyr::select(id, url) |>
  tibble::deframe()

texts <- names(lookup)
texts_done <- stringr::str_remove(dir(outfolder), "_gpt\\.rds$")
texts_done <- c(texts_done, rulings_json)
texts_left <- setdiff(texts, texts_done)

source("prompts/ruling_summary.R") # JSON Schema

for (i in seq_along(texts_left)) {
  # I would have preffered to do `id <- sample(texts_left, 1)` but the more you use
  # the API the more you move up the "usage tier" ladder, which means you can process
  # larger documents. So this is why I process the rulings in order them from smaller
  # to larger. See: https://platform.openai.com/settings/organization/limits

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

# Debug ------------------------------------------------------------------

# library(tidyverse)
#
# output <- dir("out_raw", full.names = TRUE) |>
#   purrr::map(function(x) readr::read_rds(x), .progress = TRUE)
#
# names(output) <- purrr::map_chr(output, pluck, "id")
#
# index <- map_lgl(output, function(x) {
#   str_detect(
#     x[["summary"]][["spanish"]],
#     "\\003n|\\u000f3|\\u0000f1|\\\177|\\u0000f3|\\023|\\u00133|\\u0013|\\u007f"
#   )
# })
#
# names(output)[index]
#
# file.remove(str_glue("out_raw/{names(output)[index]}_gpt.rds"))
