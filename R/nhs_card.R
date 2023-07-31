#' nhs_card
#'
#' NHS style card element
#'
#' @param heading Card title
#' @param ... Card content
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_card("A card", shiny::p("Some content"))
nhs_card <- function(heading, ...) {
  tagList(
    div(
      class = "nhsuk-card",
      div(
        class = "nhsuk-card__content",
        h3_tabstop(
          class = "nhsuk-card__heading",
          heading
        ),
        div(
          class = "nhsuk-card__description",
          ...
        )
      )
    )
  )
}
