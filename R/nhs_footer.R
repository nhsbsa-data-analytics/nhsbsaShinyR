#' nhs_footer
#'
#' NHS style footer element
#'
#' @param a11y_statement_url URL of accessibility statement
#' @param email Contact email, by default 'dall@nhsbsa.nhs.uk'
#' @param github_url URL of app GitHub repo, by default
#'   https://github.com/nhsbsa-data-analytics
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_footer()
nhs_footer <- function(a11y_statement_url = "#",
                       email = "dall@nhsbsa.nhs.uk",
                       github_url = "https://github.com/nhsbsa-data-analytics") {
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
                href = a11y_statement_url,
                target = "_blank",
                "Accessibility statement"
              )
            ),
            tags$li(
              class = "nhsuk-footer__list-item",
              a(
                class = "nhsuk-footer__list-item-link",
                style = "text-decoration: underline;",
                href = paste0("mailto:@", email),
                target = "_blank",
                "Contact us"
              )
            ),
            tags$li(
              class = "nhsuk-footer__list-item",
              a(
                class = "nhsuk-footer__list-item-link",
                style = "text-decoration: underline;",
                href = github_url,
                target = "_blank",
                "GitHub"
              )
            )
          ),
          p(
            class = "nhsuk-footer__copyright",
            "\u00A9 APLv2"
          )
        )
      )
    )
  )
}
