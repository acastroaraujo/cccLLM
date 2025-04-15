#' Person
#'
#' The `person` dataset contains information on the judges that signed off on a
#' particular ruling.
#'
#' @format A data frame with two variables:
#' \describe{
#' \item{\code{id}}{Ruling ID}
#' \item{\code{name}}{Name of the judge}
#' \item{\code{mp}}{Reporting judge ("Magistrado Ponente")}
#' \item{\code{av}}{Concurring Opinion Indicator ("Aclaración de Voto")}
#' \item{\code{sv}}{Dissenting Opinion Indicator ("Salvamento de Voto")}
#' \item{\code{interim}}{Interim Judge Indicator ("Magistrado Encargado")}
#' \item{\code{conjuez}}{Substitute Judge Indicator ("Conjuez")}
#' }
#'
#' @examples
#'   person
"person"


#' Appointed Judges
#'
#' The `appointed_judges` dataset contains information on the start and end periods
#' of the appointed judges. The cutoff date for all of them is April 3, 2024, which
#' note a real ending date but it is the moment in which I stopped collecting data.
#'
#' @format A data frame with two variables:
#' \describe{
#' \item{\code{name}}{Name of the judge}
#' \item{\code{start}}{Start Date}
#' \item{\code{end}}{End Date}
#' }
#'
#' @examples
#'   appointed_judges
"appointed_judges"
