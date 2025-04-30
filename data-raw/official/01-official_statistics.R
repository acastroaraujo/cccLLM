library(tidyverse)
library(ccc)

metadata <- ccc::metadata
tutelas <- read_csv("data-raw/official/tutelas_radicadas_1992_2024.csv")
review <- read_csv("data-raw/official/cantidad_procesos_1991_2025.csv")

# Source: https://www.corteconstitucional.gov.co/lacorte/estadisticas

# Tutelas ----------------------------------------------------------------

court <- metadata |>
  filter(type != "C") |>
  count(year, name = "rulings")

tutelas <- tutelas |>
  rename(year = "Año", files = "Tutelas radicadas") |>
  slice(-1) |>
  mutate_all(as.integer) |>
  filter(year != 2024) |>
  left_join(court)

usethis::use_data(tutelas, overwrite = TRUE, compress = "xz")

# Revisión de Constitucionalidad -----------------------------------------

court <- metadata |>
  filter(type == "C") |>
  count(year, name = "rulings")

reviews <- review |>
  rename(year = "Año", files = "Cantidad procesos") |>
  mutate_all(as.integer) |>
  filter(year < 2024) |>
  left_join(court) |>
  drop_na()

usethis::use_data(reviews, overwrite = TRUE, compress = "xz")
