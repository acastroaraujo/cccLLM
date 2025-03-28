# helpers ----------------------------------------------------------------

read_prompt <- function(file_path, ...) {
  ok <- purrr::map_lgl(list(...), \(x) length(x) == 1 & class(x) == "character")

  if (!all(ok) & length(ok) != 0) {
    dots <- names(list(...)[!ok])
    cli::cli_abort("{.var {dots}} must be {.emph named character}")
  }

  txt <- paste(readLines(here::here(file_path)), collapse = "\n")
  vars <- unlist(stringr::str_extract_all(txt, "(?<=\\{)[^{}]+(?=\\})"))

  self_contained <- rlang::new_environment(list(...))

  redundant <- setdiff(names(self_contained), unique(vars))
  if (length(redundant) > 0) {
    cli::cli_abort("{.var {redundant}} do not exist in the file provided.")
  }

  return(stringr::str_glue(txt, .envir = self_contained))
}

read_prompt("prompts/system.md")

# structured output ------------------------------------------------------

library(ellmer)

calendarEvent <- type_object(
  "Extract the event information.",
  name = type_string(description = "Name of the event."),
  date = type_string(description = "The date of the event."),
  participants = type_array(
    description = "A list of participants attending the event.",
    items = type_string()
  )
)

chat <- chat_openai(
  model = "gpt-4o-mini",
  api_args = list(temperature = 0)
)

out <- chat$extract_data(
  "Alice and Bob are going to a science fair on Friday.",
  type = calendarEvent
)

str(out)
