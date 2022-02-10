#' nhs_grid_2_col Function
#'
#' @noRd
#'
#' @importFrom shiny tagList
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


#' nhs_grid_3_col Function
#'
#' @noRd
#'
#' @importFrom shiny tagList
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
