
# devtools::install_github("acastroaraujo/ccc")
library(ccc)
library(tidyverse)
library(elmer)

# Text samples ------------------------------------------------------------

url <- sample(ccc::metadata$url, 1)
## sin sala
# url <- "https://www.corteconstitucional.gov.co/relatoria/1999/T-446-99.htm"
## normal
# url <- "https://www.corteconstitucional.gov.co/relatoria/1992/T-001-92.htm"

## sólo conjueces
#url <- "https://www.corteconstitucional.gov.co/relatoria/2001/C-1060A-01.htm"

## weird formatting
url <- "https://www.corteconstitucional.gov.co/relatoria/1992/T-015-92.htm"


txt <- ccc::ccc_txt(url)

# Spec --------------------------------------------------------------------

ruling_sum <- type_object(
  "Información de la sentencia.",
  person = type_array(
    'Lista de nombres de los magistrados que firmaron la setentencia. 
    
    Excluir al secretario general de esta lista.
    
    Las salas de revisión usualmente tienen 3 magistrados, mientras que la
    sala plena usualmente tiene 9 magistrados.',
    items = type_object(
      name = type_string(description = "Nombre."), 
      sv = type_boolean(description = "Incluye salvamento de voto?", required = FALSE),
      conjuez = type_boolean(description = "Es conjuez?", required = FALSE),
      mp = type_boolean(description = "Es el magistrado ponente?", required = FALSE)
    ),
    required = TRUE
  ),
  chamber = type_string(
    'Nombre de la sala, en caso de que la información sea explicíta.', 
    required = FALSE),
  summary = type_object(
    'Resumen de la sentencia, debe contener los hechos del caso y la decisión
    tomada por la corte.',
    en = type_string("En español."), 
    es = type_string("Traducido al inglés.")
  )
)

# Parameters --------------------------------------------------------------

## To do:
## -  add seed 

system_prompt <- "You are a research assistant tasked with extracting information from court rulings written in Spanish and made by the Colombian Constitutional Court."
# LLM <- "gpt-4o-mini"
LLM <- "gpt-4o" ## more expensive, but works better

# Extraction --------------------------------------------------------------

chat <- elmer::chat_openai(system_prompt, model = LLM)
out <- chat$extract_data(txt, spec = ruling_sum)

out$chamber
do.call(rbind, out$person)
out$summary
out$url

# out$url <- url
# write_rds(out, "example.rds")

# Extra -------------------------------------------------------------------

## - Distinguir entre salvamiento y salvamiento parcial?
## - Agregar Secretario General?
