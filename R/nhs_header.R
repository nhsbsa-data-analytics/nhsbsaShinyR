#' nhs_header
#'
#' NHS style header element
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_header()
nhs_header <- function() {
  tagList(
    tags$header(
      class = "nhsuk-header",
      role = "banner",
      shiny::tags$div(
        class = "nhsuk-width-container nhsuk-header__container",
        shiny::tags$div(
          class = "nhsuk-header__logo nhsuk-header__logo--only",
          tags$a(
            class = "nhsuk-header__link",
            href = "https://www.nhsbsa.nhs.uk/",
            `aria-label` = "NHSBSA home",
            tags$image(
              class = "nhsuk-logo",
              src = "www/assets/logos/logo-nhsbsa.svg",
              name = "NHSBSA logo",
              alt = "NHS Business Services Authority"
            )
          )
        )
      )
    )
  )
}
