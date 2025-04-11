# Packages ---------------------------------------------------------------

library(tidyverse)
library(cli)

# Data -------------------------------------------------------------------

outfolder <- "out_raw_exceeded"

output <- dir(outfolder, full.names = TRUE) |>
  purrr::map(
    function(x) jsonlite::read_json(x, simplifyVector = TRUE),
    .progress = TRUE
  )


names(output) <- map_chr(output, pluck, "id")
