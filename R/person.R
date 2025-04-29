#' Data set of individual judges participating in the rulings
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


