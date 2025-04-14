#' Articles
#'
#' The `articles` dataset contains a list of articles from the Colombian 
#' Constitution that were mentioned during the ruling.
#'
#' @format A data frame with two variables:
#' \describe{
#' \item{\code{id}}{Ruling ID}
#' \item{\code{article}}{Article number}
#' }
#' 
#' @examples
#'   articles
"articles"


#' Citations (Cosa Juzgada)
#'
#' The `rj_citations` dataset contains and edge list of rulings that referenced
#' a previous ruling as binding precedent for the current ruling. The Latin 
#' word for this is "res judicata" and the Colombian Court uses the expression
#' "cosa juzgada"
#'
#' @format A data frame with two variables:
#' \describe{
#' \item{\code{from}}{Ruling ID}
#' \item{\code{to}}{Ruling ID of precedent}
#' }
#' 
#' @examples
#'   rj_citations
"rj_citations"