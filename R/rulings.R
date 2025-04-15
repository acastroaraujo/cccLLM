#' Data set of rulings
#'
#' The `rulings` dataset contains high-level information on each rulings.
#'
#' @format A data frame with nine variables:
#' \describe{
#' \item{\code{id}}{Ruling ID}
#' \item{\code{date}}{Date}
#' \item{\code{type}}{Type of Ruling}
#' \item{\code{chamber}}{The kind of chamber that authored the ruling}
#' \item{\code{rj}}{Indicator of Res Judicata (or "Cosa Juzgada")}
#' \item{\code{n_person}}{Number of Judges}
#' \item{\code{n_amicus}}{Number of Judges}
#' \item{\code{summary_en}}{Short summary in English.}
#' \item{\code{summary_es}}{Short summary in Spanish.}
#' }
#' 
#' @examples
#'   rulings
"rulings"