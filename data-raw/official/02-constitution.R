library(httr2)
library(purrr)

arts <- 1:380

output <- vector("list", length(arts))

url <- "https://www.constitucioncolombia.com/buscar.php"

output <- map(arts, \(x) {
  out <- request(url) |>
    req_url_query(query = x) |>
    req_retry(max_tries = 3) |>
    req_perform(verbosity = 1)

  website <- resp_body_html(out)

  Sys.sleep(runif(1))

  tibble::tibble(
    article = x,
    text = rvest::html_text(rvest::html_element(website, "body div.texto")),
    nav = rvest::html_text(rvest::html_element(website, "body div.nav"))
  )
})

constitution <- bind_rows(output) |>
  mutate(text = str_remove(text, "^\\r\\n +")) |>
  mutate(text = str_replace_all(text, "\\r", "\\\n\\\n")) |>
  mutate(nav = str_squish(nav))

art1 <- "Artículo 1o. Colombia es un Estado social de derecho, organizado en forma de República unitaria, descentralizada, con autonomía de sus entidades territoriales, democrática, participativa y pluralista, fundada en el respeto de la dignidad humana, en el trabajo y la solidaridad de las personas que la integran y en la prevalencia del interés general."
nav1 <- "Índice / Título 1 - De los principios fundamentales / Artículo 1"
constitution[1, "text"] <- art1
constitution[1, "nav"] <- nav1

usethis::use_data(constitution, overwrite = TRUE, compress = "xz")
