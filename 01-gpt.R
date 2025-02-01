
# devtools::install_github("acastroaraujo/ccc")
library(ccc)
library(tidyverse)
library(ellmer)

source("ruling_summary.R")

outfolder <- "out_raw"
if (!dir.exists(outfolder)) dir.create(outfolder)

lookup <- ccc::metadata |> 
  arrange(word_count) |> 
  filter(word_count >= 200) |> ## anuladas
  select(id, url) |> 
  deframe()

texts_done <- dir(outfolder) |> str_remove("_gpt\\.rds$")
texts_left <- setdiff(names(lookup), texts_done)


## TO DO. MAKE AN INDIVIDUALIZED PROMPT FOR EACH CHAT INSTANCE.
glue::glue(paste(readLines("prompts/system.md"), collapse = "\n"))

## https://ellmer.tidyverse.org/articles/prompt-design.html?q=md#structured-data-1


for (i in seq_along(texts_left)) {
  
  id <- texts_left[[i]]
  url <- lookup[[id]]
  
  txt <- ccc::ccc_txt(url)
  
  chat <- ellmer::chat_openai(
    system_prompt = "
    You are a research assistant tasked with extracting information from court 
    rulings written in Spanish by the Colombian Constitutional Court.
    ", 
    model = "gpt-4o", 
    api_args = list(temperature = 0)
  )
  
  out <- chat$extract_data(txt, type = ruling_summary)
  out$url <- url
  out$id <- texts_left[[i]]
  
  out$model <- "gpt-4o"
  
  readr::write_rds(out, stringr::str_glue("{outfolder}/{texts_left[[i]]}_gpt.rds"), compress = "gz")
  
  texts_left <- texts_left[-i]
  
}


# new <- readRDS("~/Repositories/cccLLM/out_raw/T-1699-00_gpt.rds")
# old <- readRDS("~/Repositories/cccLLM/old_out_raw/T-1699-00_gpt.rds")
# 
# new
# 
# old
