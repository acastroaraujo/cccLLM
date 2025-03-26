# devtools::install_github("acastroaraujo/ccc")
library(ccc)
library(tidyverse)
library(ellmer)

outfolder <- "out_raw"
if (!dir.exists(outfolder)) dir.create(outfolder)

lookup <- ccc::metadata |>
  arrange(word_count) |>
  filter(word_count >= 200) |> ## anuladas
  select(id, url) |>
  deframe()

source("ruling_summary.R")

texts_done <- dir(outfolder) |> str_remove("_gpt\\.rds$")
texts_left <- setdiff(names(lookup), texts_done)

# You are here -----------------------------------------------------------

# i <- which(texts_left == "T-406-92")
# i <- which(texts_left == "C-1060A-01")
# i <- which(texts_left == "T-151-99")
# i <- which(texts_left == "T-909-11") ## too long
# i <- which(texts_left == "C-093-93") ## too long
# i <- which(texts_left == "SU-039-97") ## too long
# i <- which(texts_left == "T-1691-00")
# i <- which(texts_left == "C-811-07")
# i <- which(texts_left == "T-248-12")

for (i in seq_along(texts_left)) {
  id <- texts_left[[i]]
  url <- lookup[[id]]

  txt <- ccc::ccc_txt(url)
  SP <- glue::glue(paste(readLines("prompts/system.md"), collapse = "\n"))

  chat <- ellmer::chat_openai(
    system_prompt = SP,
    model = "gpt-4o",
    api_args = list(temperature = 0)
  )

  out <- chat$extract_data(txt, type = ruling_summary)
  out$url <- url
  out$id <- texts_left[[i]]

  out$model <- "gpt-4o"

  readr::write_rds(
    out,
    stringr::str_glue("{outfolder}/{texts_left[[i]]}_gpt.rds"),
    compress = "gz"
  )

  texts_left <- texts_left[-i]
}

# new <- readRDS("~/Repositories/cccLLM/out_raw/T-1699-00_gpt.rds")
# old <- readRDS("~/Repositories/cccLLM/old_out_raw/T-1699-00_gpt.rds")
#
# new
#
# old

#old <- readRDS("~/Repositories/cccLLM/out_raw/T-1699-00_gpt.rds")
texts_done <- dir(outfolder) |> str_remove("_gpt\\.rds$")

x <- sample(texts_done, size = 1)
out <- readRDS(str_glue("~/Repositories/cccLLM/out_raw/{x}_gpt.rds"))
out
