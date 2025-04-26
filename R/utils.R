


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
#' ruling_summary("C-055-22")
#' 
ruling_summary <- function(x) {
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


