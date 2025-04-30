#' Data set of appointed judges
#'
#' The `appointed_judges` dataset contains information on the start and end periods
#' of the appointed judges. The cutoff date for all of them is April 3, 2024, which
#' note a real ending date but it is the moment in which I stopped collecting data.
#'
#' @format A data frame with three variables:
#' \describe{
#' \item{\code{name}}{Name of the judge}
#' \item{\code{start}}{Start Date}
#' \item{\code{end}}{End Date}
#' }
#'
#' @examples
#'   appointed_judges
"appointed_judges"


#' Historical dataset of filed Tutelas
#'
#' The `tutelas` dataset contains historical information extracted from the
#' Court's official website.
#'
#' @source https://www.corteconstitucional.gov.co/lacorte/estadisticas
#'
#' @format A data frame with three variables:
#' \describe{
#' \item{\code{year}}{Year}
#' \item{\code{files}}{Number of tutelas received by the Court}
#' \item{\code{rulings}}{Number of tutela rulings made by the Court}
#' }
#'
#' @examples
#'   tutelas
"tutelas"


#' Historical dataset of filed claims for Judicial Review
#'
#' The `reviews` dataset contains historical information extracted from the
#' Court's official website.
#'
#' @source https://www.corteconstitucional.gov.co/lacorte/estadisticas
#'
#' @format A data frame with three variables:
#' \describe{
#' \item{\code{year}}{Year}
#' \item{\code{files}}{Number of review files in the Court}
#' \item{\code{rulings}}{Number of constitutional review rulings made by the Court}
#' }
#'
#' @examples
#'   reviews
"reviews"
