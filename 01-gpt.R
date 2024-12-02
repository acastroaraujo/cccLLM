
# devtools::install_github("acastroaraujo/ccc")
library(ccc)
library(tidyverse)
library(elmer)

source("ruling_summary.R")

outfolder <- "out_raw"
if (!dir.exists(outfolder)) dir.create(outfolder)

df <- ccc::metadata |> 
  arrange(word_count) |> 
  select(id, url)

df <- df[-(1:6), ] ## anuladas

texts_done <- dir(outfolder) |> str_remove("_gpt\\.rds$")
texts_left <- setdiff(df$id, texts_done)

for (i in seq_along(texts_left)) {
  
  chat <- elmer::chat_openai(
    system_prompt = "
    You are a research assistant tasked with extracting information from court 
    rulings written in Spanish by the Colombian Constitutional Court.
    ", 
    model = "gpt-4o"
  )
  
  url <- df |> 
    filter(id == texts_left[[i]]) |> 
    pull(url)
  
  txt <- ccc::ccc_txt(url)
  out <- try(chat$extract_data(txt, spec = ruling_summary))
  
  out$person <- lapply(out$person, function(x) {
    as.data.frame(lapply(x, \(x) ifelse(is.null(x), FALSE, x)))
  })
  
  out$person <- dplyr::bind_rows(out$person)
  out$url <- url
  out$id <- texts_left[[i]]
  
  out$model <- "gpt-4o"
  
  readr::write_rds(out, stringr::str_glue("{outfolder}/{texts_left[[i]]}_gpt.rds"), compress = "gz")
  
  texts_left <- texts_left[-i]
  
}

#d <- read_rds(str_glue("{outfolder}/T-283-99_gpt.rds"))

