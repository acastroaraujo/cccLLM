
library(tidyverse)
outfolder <- "out_raw"

# Organize ----------------------------------------------------------------

output <- dir(outfolder, full.names = TRUE) |> 
  map(\(x) read_rds(x))

## encoding error
ok <- map_lgl(output, \(x) class(x) == "list" & length(x) == 6)
sum(!ok)

## suspicious looking
ok <- map_lgl(output, \(x) nrow(x$person) == 3 | nrow(x$person) == 9)
sum(!ok)

# Problem Cases -----------------------------------------------------------

names(output) <- map_chr(output, pluck("id"))

problem <- output[!ok]
names(problem) <- map_chr(problem, pluck("id"))

# Ok, without modification ------------------------------------------------

problem["C-041-93"] 
problem["C-545-92"] 
problem["C-598-99"]

ok_without <- 3

# Manual modification -----------------------------------------------------

output[["T-105-99"]]$person <- bind_rows(
  problem[["T-105-99"]]$person, 
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-146-99"]]$person <- bind_rows(
  problem[["T-146-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-278-99"]]$person <- bind_rows(
  problem[["T-278-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-291-99"]]$person <- bind_rows(
  problem[["T-291-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-316-99"]]$person <- bind_rows(
  problem[["T-316-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-350-99"]]$person <- bind_rows(
  problem[["T-350-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-379-99"]]$person <- bind_rows(
  problem[["T-379-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-381-99"]]$person <- bind_rows(
  problem[["T-381-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-432-99"]]$person <- bind_rows(
  problem[["T-432-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-433-99"]]$person <- bind_rows(
  problem[["T-433-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)
 
output[["T-435-99"]]$person <- bind_rows(
  problem[["T-435-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-441-99"]]$person <- bind_rows(
  problem[["T-441-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-445-99"]]$person <- bind_rows(
  problem[["T-445-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-447-99"]]$person <- bind_rows(
  problem[["T-447-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-240-99"]]$person <- bind_rows(
  problem[["T-240-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-345-99"]]$person <- bind_rows(
  problem[["T-345-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-425-99"]]$person <- bind_rows(
  problem[["T-425-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-438-99"]]$person <- bind_rows(
  problem[["T-438-99"]]$person,
  data.frame(
    name = "JOSÉ GREGORIO HERNÁNDEZ GALINDO", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-648-98"]]$person <- bind_rows(
  problem[["T-648-98"]]$person,
  data.frame(
    name = "CARLOS GAVIRIA DÍAZ", 
    av = FALSE, sv = FALSE, conjuez = FALSE, mp = FALSE
  )
)

output[["T-699-98"]]$person <- problem[["T-699-98"]]$person[-4, ]

# Check -------------------------------------------------------------------

ok <- map_lgl(output, \(x) nrow(x$person) == 3 | nrow(x$person) == 9)
sum(!ok) - ok_without

problem <- output[!ok]
names(problem) <- map_chr(problem, pluck("id"))

output

