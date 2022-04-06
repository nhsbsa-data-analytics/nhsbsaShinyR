#' nhs_footer Function
#'
#' @importFrom shiny tagList
nhs_footer <- function() {
  tagList(
    tags$footer(
      role = "contentinfo",
      tags$div(
        class = "nhsuk-footer",
        id = "nhsuk-footer",
        tags$div(
          class = "nhsuk-width-container app-width-container",
          tags$ul(
            class = "nhsuk-footer__list",
            tags$li(
              class = "nhsuk-footer__list-item",
              a(
                class = "nhsuk-footer__list-item-link",
                style = "text-decoration: underline;",
                href = "#",
                target = "_blank",
                "Accessibility statement"
              )
            ),
            tags$li(
              class = "nhsuk-footer__list-item",
              a(
                class = "nhsuk-footer__list-item-link",
                style = "text-decoration: underline;",
                href = "mailto:@nhs.net",
                target = "_blank",
                "Contact us"
              )
            ),
            tags$li(
              class = "nhsuk-footer__list-item",
              a(
                class = "nhsuk-footer__list-item-link",
                style = "text-decoration: underline;",
                href = "https://github.com/nhsbsa-data-analytics/nhsbsaShinyR",
                target = "_blank",
                "GitHub"
              )
            )
          ),
          p(
            class = "nhsuk-footer__copyright",
            "© APLv2"
          )
        )
      )
    )
  )
}
