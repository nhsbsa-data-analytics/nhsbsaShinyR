#' nhs_card Function
#'
#' @noRd
#'
#' @importFrom shiny tagList
nhs_card <- function(heading, ...) {
  tagList(
    div(
      class = "nhsuk-card",
      div(
        class = "nhsuk-card__content",
        h3(
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
