#' nhs_grid_2_col
#'
#' NHS style 2 column grid element
#'
#' @param col_1 First column content
#' @param col_2 Second column content
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_grid_2_col(shiny::p("Column one"), shiny::p("Column two"))
nhs_grid_2_col <- function(col_1, col_2) {
  tagList(
    div(
      class = "nhsuk-grid-row",
      div(
        class = "nhsuk-grid-column-one-half",
        col_1
      ),
      div(
        class = "nhsuk-grid-column-one-half",
        col_2
      )
    )
  )
}

#' nhs_grid_3_col
#'
#' NHS style 3 column grid element
#'
#' @param col_1 First column content
#' @param col_2 Second column content
#' @param col_3 Third column content
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_grid_3_col(
#'   shiny::p("Column one"),
#'   shiny::p("Column two"),
#'   shiny::p("Column three")
#' )
nhs_grid_3_col <- function(col_1, col_2, col_3) {
  tagList(
    div(
      class = "nhsuk-grid-row",
      div(
        class = "nhsuk-grid-column-one-third",
        col_1
      ),
      div(
        class = "nhsuk-grid-column-one-third",
        col_2
      ),
      div(
        class = "nhsuk-grid-column-one-third",
        col_3
      )
    )
  )
}

#' nhs_grid_4_col
#'
#' NHS style 4 column grid element
#'
#' @param col_1 First column content
#' @param col_2 Second column content
#' @param col_3 Third column content
#' @param col_4 Fourth column content
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_grid_4_col(
#'   shiny::p("Column one"),
#'   shiny::p("Column two"),
#'   shiny::p("Column three"),
#'   shiny::p("Column four")
#' )
nhs_grid_4_col <- function(col_1, col_2, col_3, col_4) {
  tagList(
    div(
      class = "nhsuk-grid-row",
      div(
        class = "nhsuk-grid-column-one-quarter",
        col_1
      ),
      div(
        class = "nhsuk-grid-column-one-quarter",
        col_2
      ),
      div(
        class = "nhsuk-grid-column-one-quarter",
        col_3
      ),
      div(
        class = "nhsuk-grid-column-one-quarter",
        col_4
      )
    )
  )
}
