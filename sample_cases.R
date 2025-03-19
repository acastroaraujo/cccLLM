
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
# url <- "https://www.corteconstitucional.gov.co/relatoria/1999/C-246-99.htm"

# salvamentos múltiples
# url <- "https://www.corteconstitucional.gov.co/relatoria/1999/c-702-99.htm"


txt <- ccc::ccc_txt(url)
out <- try(chat$extract_data(txt, spec = ruling_summary))

out$chamber
do.call(rbind, out$person)
out$summary
url
