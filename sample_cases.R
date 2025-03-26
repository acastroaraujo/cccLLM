# Text samples ------------------------------------------------------------

url <- sample(ccc::metadata$url, 1)

## sin sala
# url <- "https://www.corteconstitucional.gov.co/relatoria/1999/T-446-99.htm"

## normal
# url <- "https://www.corteconstitucional.gov.co/relatoria/1992/T-001-92.htm"

## sólo conjueces
#url <- "https://www.corteconstitucional.gov.co/relatoria/2001/C-1060A-01.htm"

## weird formatting
# url <- "https://www.corteconstitucional.gov.co/relatoria/1992/T-015-92.htm"

## salvamento
# url <- "https://www.corteconstitucional.gov.co/relatoria/2018/t-443-18.htm"

## Two magistrados ponentes
# id <- "C-246-99"
# url <- "https://www.corteconstitucional.gov.co/relatoria/1999/C-246-99.htm"

# salvamentos múltiples
# id <- "C-702-99"
# url <- "https://www.corteconstitucional.gov.co/relatoria/1999/c-702-99.htm"

# Debug ------------------------------------------------------------------

# txt <- ccc::ccc_txt(url)
#
# source("prompts/ruling_summary.R")
# SP <- glue::glue(paste(readLines("prompts/system.md"), collapse = "\n"))
#
# chat <- ellmer::chat_openai(
#   system_prompt = SP,
#   model = "gpt-4o",
#   api_args = list(temperature = 0)
# )
#
# out <- chat$extract_data(txt, type = ruling_summary)
# out$url <- url
# out$id <- id
# out$model <- "gpt-4o"
#
# outfolder <- "out_raw"
#
# readr::write_rds(
#   x = out,
#   file = stringr::str_glue("{outfolder}/{id}_gpt.rds"),
#   compress = "gz"
# )
