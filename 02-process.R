library(tidyverse)
library(cli)

outfolder <- "out_raw"

output <- dir(outfolder, full.names = TRUE) |>
  map(function(x) read_rds(x), .progress = TRUE)

# Danger -----------------------------------------------------------------

ok <- map_lgl(output, \(x) class(x) == "list" & length(x) == 10)

if (sum(!ok) > 0) {
  cli_abort("There is something fundamentally wrong going on.", )
}

# Chamber Anomalies ------------------------------------------------------

ok <- map_lgl(output, \(x) nrow(x$person) == 3 | nrow(x$person) == 9)
cli_warn("There are {sum(!ok)} rulings with an anomalous number of judges.")

names(output) <- map_chr(output, pluck("id"))

problem <- output[!ok]
names(problem) <- map_chr(problem, pluck("id"))

not_problems <- c(
  "C-017-93", ## No information on who's missing
  "C-039-93", ## No information on who's missing
  "C-041-93", ## No information on who's missing
)

## YO ARE HERE!!

# weird_but_ok <- c(
#   "C-041-93", ## No information on who's missing
#   "C-545-92", ## No information on who's missing
#   "C-598-99", ## No information on who's missing
#   "C-520-99", ## No information on who's missing
#   "C-147-03", ## EDUARDO MONTEALEGRE LYNETT (recused)
#   "T-434-97", ## HERNANDO HERRERA VERGARA (out of country)
#   "T-436-97", ## HERNANDO HERRERA VERGARA (out of country)
#   "T-565-03" ## MANUEL JOSÉ CEPEDA ESPINOSA (excused)
# )

# Problem 1: JOSÉ GREGORIO HERNÁNDEZ GALINDO (malformed) ------------------
#
# missing_jose <- c(
#   "T-105-99",
#   "T-151-99",
#   "T-146-99",
#   "T-240-99",
#   "T-278-99",
#   "T-291-99",
#   "T-316-99",
#   "T-345-99",
#   "T-350-99",
#   "T-378-99",
#   "T-379-99",
#   "T-381-99",
#   "T-425-99",
#   "T-432-99",
#   "T-433-99",
#   "T-435-99",
#   "T-438-99",
#   "T-441-99",
#   "T-445-99",
#   "T-447-99",
#   "T-449-99"
# )
#
# for (j in missing_jose) {
#   output[[j]]$person <- bind_rows(
#     problem[[j]]$person,
#     data.frame(
#       name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO",
#       av = FALSE,
#       sv = FALSE,
#       conjuez = FALSE,
#       mp = FALSE
#     )
#   )
# }
#

# Problem 2: Misc. --------------------------------------------------------

# output[["T-648-98"]]$person <- bind_rows(
#   problem[["T-648-98"]]$person,
#   data.frame(
#     name = "CARLOS GAVIRIA DÍAZ",
#     av = FALSE,
#     sv = FALSE,
#     conjuez = FALSE,
#     mp = FALSE
#   )
# )
#
# output[["T-699-98"]]$person <- problem[["T-699-98"]]$person |>
#   filter(name != "Martha Victoria Sáchica de Moncaleano")
#
# output[["T-1039-01"]]$person <- problem[["T-1039-01"]]$person |>
#   filter(name != "Martha Victoria Sáchica de Moncaleano")
#
# output[["T-254-01"]]$person <- problem[["T-254-01"]]$person |>
#   filter(name != "José Gregorio Hernández Galindo") |>
#   mutate(mp = c(TRUE, FALSE, FALSE))
#
# output[["T-241-03"]]$person <- problem[["T-241-03"]]$person |>
#   filter(name != "Ricardo Monroy Church")

# Problem 3: Anomalies ----------------------------------------------------

# weird_but_ok <- c(
#   "C-041-93", ## No information on who's missing
#   "C-545-92", ## No information on who's missing
#   "C-598-99", ## No information on who's missing
#   "C-520-99", ## No information on who's missing
#   "C-147-03", ## EDUARDO MONTEALEGRE LYNETT (recused)
#   "T-434-97", ## HERNANDO HERRERA VERGARA (out of country)
#   "T-436-97", ## HERNANDO HERRERA VERGARA (out of country)
#   "T-565-03" ## MANUEL JOSÉ CEPEDA ESPINOSA (excused)
# )

# Annulments --------------------------------------------------------------

# df <- ccc::metadata |>
#   arrange(word_count) |>
#   select(id, url)
#
# df <- df[-(1:6), ] ## anuladas

# Final Check -------------------------------------------------------------

# ok <- map_lgl(output, \(x) nrow(x$person) == 3 | nrow(x$person) == 9)
# message("Total: ", length(output))
# message("Remaining problems: ", sum(!ok) - length(weird_but_ok))

# problem <- output[!ok]
# problem <- problem[!names(problem) %in% weird_but_ok]
