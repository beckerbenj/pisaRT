#' PISA Example Responses and Response Times Data (wide format)
#'
#' A small example data set from the Canadian sample of the PISA 2015 assessment. Contains responses, response times
#' and log transformed response times of a single math booklet.
#' This data set is in the wide format, with each row containing the scored responses and response times of a person on all booklet items. For
#' further explanations see \code{\link{pisaRT}}.
#'
#' @format A data.frame with 500 rows and 23 variables:
#' \describe{
#'   \item{ID}{Person ID variable}
#'   \item{y_x}{Scored responses on item x}
#'   \item{RT_x}{Response time in seconds on item x}
#'   \item{log_RT_x}{Log Response time on item x}
#' }
#'
#' @docType data
#' @keywords datasets
#' @source \url{https://www.oecd.org/pisa/data/2015database/}
"pisaW"
