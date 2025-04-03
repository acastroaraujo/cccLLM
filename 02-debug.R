library(tidyverse)
library(cli)

outfolder <- "out_raw"

output <- dir(outfolder, full.names = TRUE) |>
  purrr::map(function(x) readr::read_rds(x), .progress = TRUE)

# Danger -----------------------------------------------------------------

ok <- map_lgl(output, \(x) class(x) == "list" & length(x) == 10)

if (sum(!ok) > 0) {
  cli_abort("There is something fundamentally wrong going on.", )
}

# Chamber Anomalies ------------------------------------------------------

ok <- map_lgl(output, \(x) nrow(x$person) == 3 | nrow(x$person) == 9)
cli_warn("There are {sum(!ok)} rulings with an anomalous number of judges.")

names(output) <- map_chr(output, pluck("id"))

problems <- output[!ok]
names(problems) <- map_chr(problems, pluck("id"))

not_problems <- c(
  "C-039-93",
  "C-041-93",
  "C-055-93",
  "C-061-93",
  "C-017-93",
  "C-062-93",
  "C-076-93",
  "C-082-93",
  "C-085-93",
  "C-086-93",
  "C-087-93",
  "C-089-93",
  "C-098-93",
  "C-138-97",
  "C-095-00",
  "C-1158-00",
  "C-1516-00",
  "C-180-02",
  "C-180-02", # :)
  "C-239-05",
  "C-274-03",
  "C-286-97", # :)
  "C-417-92",
  "C-472-92",
  "C-477-06",
  "C-509-09",
  "C-513-92",
  "C-520-99",
  "C-545-92",
  "C-553-92", # :)
  "C-561-92",
  "C-562-95",
  "C-580-92", # :)
  "C-598-99",
  "C-600-92",
  "C-607-92",
  "C-672-04",
  "C-732-05",
  "C-984-02",
  "T-545-14",
  "T-560A-14",
  "T-545-14"
)

ok <- names(problems) %in% not_problems

problems <- problems[!ok]
length(problems)
names(problems)

# typos, wtf do I do with these??? fix this and then add to no problem
"T-254-01" ## remove José Gregorio Hernández
"T-570-98"

output[["C-455-06"]]

ccc::citations |>
  dplyr::filter(from == "C-672-04")

# Extra people -----------------------------------------------------------

# T-242-93 Alvaro Lecompte Luna

# Manual Delete ----------------------------------------------------------

# delete_me <- c(
#   "C-239-09",
#   "C-283-02",
#   "C-312-93",
#   "C-319-98",
#   "C-455-06",
#   "T-001-03",
#   "T-005-00",
#   "T-1069-00"
# )
#
# delete_me_paths <- glue::glue("{outfolder}/{delete_me}_gpt.rds")
# file.remove(delete_me_paths)

# Delete -----------------------------------------------------------------

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
