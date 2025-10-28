#' Edge list of rulings and articles of the Colombian Constitution
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


#' Edge list of citations to binding precedent ("cosa juzgada")
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


#' Constitution of Colombia
#'
#' The `constitution` dataset 380 articles of the Colombian Constitution.
#'
#' @source https://www.constitucioncolombia.com/
#'
#' @format A data frame with two variables:
#' \describe{
#' \item{\code{article}}{Article number}
#' \item{\code{title_num}}{Title number}
#' \item{\code{chapter_num}}{Chapter number}
#' \item{\code{title}}{Title}
#' \item{\code{chapter}}{Chapter}
#' \item{\code{text}}{text}
#' }
#'
#' @examples
#'   constitution
"constitution"
