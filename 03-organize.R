
df <- map_df(output, function(x) {
  
  empty <- map_lgl(x, rlang::is_empty)
  x[empty] <- NA_character_
  
  out <- as_tibble(x[c("id", "chamber", "model", "url")])
  
  out$es <- x$summary$es
  out$en <- x$summary$en
  
  out$person <- list(x$person)
  return(out)
  
})

df |> 
  unnest(person) |> View(
  )

