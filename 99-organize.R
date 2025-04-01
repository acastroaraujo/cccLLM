df <- map_df(output, function(x) {
  empty <- map_lgl(x, rlang::is_empty)
  x[empty] <- NA_character_

  out <- as_tibble(x[c("id", "chamber", "model", "url")])

  out$es <- x$summary$es
  out$en <- x$summary$en

  out$person <- list(x$person)
  return(out)
})

df

df |>
  mutate(n = map_dbl(person, nrow)) |>
  mutate(
    chamber2 = case_when(
      n <= 3 ~ "SR",
      n > 3 ~ "SP"
    )
  ) |>
  mutate(chamber2 = factor(chamber2)) |>
  relocate(chamber, chamber2) |>
  count(chamber, chamber2, sort = TRUE) |>
  print(n = Inf)

df |>
  mutate(n = map_dbl(person, nrow)) |>
  mutate(
    chamber2 = case_when(
      n <= 3 ~ "SR",
      n > 3 ~ "SP"
    )
  ) |>
  mutate(chamber2 = factor(chamber2)) |>
  count(chamber2, sort = TRUE) |>
  print(n = Inf)

df |>
  unnest(person) |>
  summarize(av = any(av), sv = any(sv), .by = id) |>
  summarize(
    dissent = scales::percent(mean(av + sv), accuracy = 0.1),
    sv = scales::percent(mean(sv), accuracy = 0.1),
    av = scales::percent(mean(av), accuracy = 0.1)
  )

df |>
  mutate(n = map_dbl(person, nrow)) |>
  mutate(
    chamber2 = case_when(
      n <= 3 ~ "SR",
      n > 3 ~ "SP"
    )
  ) |>
  filter(chamber2 == "SR") |>
  unnest(person) |>
  summarize(av = any(av), sv = any(sv), .by = id) |>
  summarize(
    dissent = scales::percent(mean(av + sv), accuracy = 0.1),
    sv = scales::percent(mean(sv), accuracy = 0.1),
    av = scales::percent(mean(av), accuracy = 0.1)
  )


df |>
  select(id, person) |>
  unnest(person) |>
  mutate(name = tolower(textclean::replace_non_ascii(name))) |>
  filter(name == "vladimiro naranjo mejia")

df |>
  select(id, person) |>
  unnest(person) |>
  View()


output[["T-040-01"]]$person


a <- transpose(output)

asdf <- map(a$summary, \(x) {
  substr(x$en, 0, 200)
})


en <- enframe(asdf, name = "id", value = "en") |>
  unnest(en)

full_join(df, en) |>
  drop_na() |>
  View()


right_join(df, en)

left_join(df, en) |>
  drop_na() |>
  View()

change <- c(
  "T-650-98",
  "T-621-99",
  "C-059-98",
  "T-042-97",
  "C-676-99",
  "T-162-95",
  "T-700-98",
  "T-441-99" ## 65
)

"T-239-99"
"T-240-99"
