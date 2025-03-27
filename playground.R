# helpers ----------------------------------------------------------------

read_prompt <- function(file_path, ...) {
  ok <- purrr::map_lgl(list(...), \(x) length(x) == 1 & class(x) == "character")
  if (!all(ok) & length(ok) != 0) {
    cli::cli_abort(
      "Each of the arguments supplied to `...` must be a named character"
    )
  }

  out <- paste(readLines(here::here(file_path)), collapse = "\n")

  self_contained <- rlang::new_environment(list(...))
  return(stringr::str_glue(out, .envir = self_contained))
}


glue::glue(
  "asdfasdf {id} asdfasdf",
  # only the `id` string is being interpolated
  .envir = rlang::new_environment(data = list(id = 2)),
)

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
