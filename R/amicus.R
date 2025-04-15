#' Data set of amicus interventions in each ruling
#'
#' The `amicus` dataset contains a list of individuals and organizations who 
#' intervened in the ruling by presenting an "amicus curiae."
#' 
#' Unlike the other datasets in this package, this one is not very well standardized.
#' So you might have to do a lot of cleaning to work with this.
#'
#' @format A data frame with three variables:
#' \describe{
#' \item{\code{id}}{Ruling ID}
#' \item{\code{name}}{Name of the individual}
#' \item{\code{affiliation}}{An organization, government agency, university, NGO, union, social movement, etc.}
#' }
#' 
#' @examples
#'   amicus
"amicus"