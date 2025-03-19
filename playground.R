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
