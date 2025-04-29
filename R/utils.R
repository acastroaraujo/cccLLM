


#' Get ruling summary
#' 
#' This is a convenience function that prints the summary of a ruling to the
#' console.
#'
#' @param x ruling id
#'
#' @returns English and Spanish summaries
#' @export
#'
#' @examples
#' 
#' summary_ruling("C-055-22")
#' 
summary_ruling <- function(x) {
  stopifnot(length(x) == 1)
  i <- which(x == cccLLM::rulings[["id"]])
  if (length(i) == 0) stop("`id` not found", call. = FALSE)
  
  en <- cccLLM::rulings[["summary_en"]][[i]]
  es <- cccLLM::rulings[["summary_es"]][[i]]
  
  cli::cli_h1("Ruling: {x}")
  cli::cli_text(en)
  cli::cli_rule()
  cli::cli_text(es)
  invisible(list(en = en, es = es))
}


#' Get Collection of Rulings
#' 
#' All collections come from the Court's official website, with the exception of
#' `jctt`, which comes from the "Justicia Constitucional en Tiempos de Transición" 
#' project.
#' 
#' https://www.corteconstitucional.gov.co/relatoria/temas-interes
#' http://justiciatransicional.uniandes.edu.co/web/
#'
#' @param x collection name
#'
#' @returns a list of ruling ids corresponding to that collection
#' @export
#'
#' @examples
#' 
#' get_collection("peace")
#' 
get_collection <- function(
    x = c("gender", "peace", "treaties", "legislative_decrees", "codes", "jctt")
) {
  x <- match.arg(x)
  get(x, envir = asNamespace("cccLLM"))
}

