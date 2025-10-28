#' Get ruling summary
#'
#' This is a convenience function that finds the summary of
#' a ruling in the `rulings` dataset and then prints it to
#' the console.
#'
#' @param x ruling id
#'
#' @returns Spanish and English summaries
#' @export
#'
#' @examples
#'
#' summary_ruling("C-055-22")
#'
summary_ruling <- function(x) {
  stopifnot(length(x) == 1)
  i <- which(x == cccLLM::rulings[["id"]])
  if (length(i) == 0) {
    stop("`id` not found", call. = FALSE)
  }

  en <- cccLLM::rulings[["summary_en"]][[i]]
  es <- cccLLM::rulings[["summary_es"]][[i]]

  cli::cli_h1("Ruling: {x}")
  cli::cli_text(es)
  cli::cli_rule()
  cli::cli_text(en)
  invisible(list(es = es, en = en))
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
  get(match.arg(x))
}


#' Get ruling summary
#'
#' This is a convenience function that finds the summary of
#' a ruling in the `rulings` dataset and then prints it to
#' the console.
#'
#' @param x ruling id
#'
#' @returns Spanish and English summaries
#' @export
#'
#' @examples
#'
#' print_article(363)
#'
print_article <- function(x) {
  x <- as.integer(x)
  stopifnot(x %in% 1:380 & length(x) == 1)

  cli::cli_h1("Art. {x}")
  cli::cli_text(cccLLM::constitution$text[[x]])
  cli::cli_rule()
  cli::cli_text(
    "T\u00edtulo {cccLLM::constitution$title_num[x]}: {cccLLM::constitution$title[x]}"
  )
  if (!is.na(cccLLM::constitution$chapter_num[x])) {
    cli::cli_text(
      "Cap\u00edtulo {cccLLM::constitution$chapter_num[x]}: {cccLLM::constitution$chapter[x]}"
    )
  }
  invisible(cccLLM::constitution$text[[x]])
}
