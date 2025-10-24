library(tidyverse)
library(ccc)

data(metadata, package = "ccc")
tutelas <- read_csv("data-raw/official/tutelas_radicadas_1992_2024.csv")
review <- read_csv("data-raw/official/cantidad_procesos_1991_2025.csv")

# Source: https://www.corteconstitucional.gov.co/lacorte/estadisticas

# OK, so this is what happened. The original data is wrong. It does not agree
# with different publications. It must be wrong. So I pivoted to a different
# source of information.
# 
# https://publicaciones.defensoria.gov.co/desarrollo1/ABCD/bases/marc/documentos/textos/La_Tutela_y_los_Derechos_a_la_Salud_y_a_la_Seguridad_Social_2015_completo_(1).pdf
# https://www.consultorsalud.com/wp-content/uploads/2014/10/la-tutela-y-el-derecho-a-la-salud-2012---informe-defensoria-del-pueblo.pdf
#
# So I combined the early years in these tables with the one provided by the
# court's website. I think this is a reasonable thing to do.

# Tutelas ----------------------------------------------------------------

court <- metadata |>
  filter(type != "C") |>
  count(year, name = "rulings")

tutelas <- tutelas |>
  rename(year = "Año", files = "Tutelas radicadas") |>
  mutate_all(as.integer) |>
  filter(year < 2024, year > 1991) |>
  left_join(court)

usethis::use_data(tutelas, overwrite = TRUE, compress = "xz")

# Revisión de Constitucionalidad -----------------------------------------
# 
# https://www.datos.gov.co/Justicia-y-Derecho/Procesos-de-constitucionalidad-radicados-en-la-Cor/4akn-42rj/about_data
# 

court <- metadata |>
  filter(type == "C") |>
  count(year, name = "rulings")

reviews <- review |>
  rename(year = "Año", files = "Cantidad procesos") |>
  mutate_all(as.integer) |>
  filter(year < 2024, year > 1991) |>
  left_join(court) |>
  drop_na()

usethis::use_data(reviews, overwrite = TRUE, compress = "xz")
