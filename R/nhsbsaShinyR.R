#' \code{nhsbsaShinyR} package
#'
#' Template app using `golem` for NHSBSA DALL `shiny` apps.
#'
#' @docType package
#' @name nhsbsaShinyR
#'
#' @importFrom rlang := .data
#'
NULL

if (getRversion() >= "2.15.1") {
  utils::globalVariables(
    c(
      # data column names
      "Sepal.Length",
      "Sepal.Width",
      "group_lvl",
      "point_col"
    )
  )
}
