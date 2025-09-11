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
          style = "display: flex; flex-direction: column; align-items: flex-start; color: grey;",
          div(
            class = "nhsuk-footer__top-row",
            style = "display: flex; justify-content: space-between; align-items: center; width: 100%;",
            tags$ul(
              class = "nhsuk-footer__list",
              tags$li(
                class = "nhsuk-footer__list-item",
                a(
                  class = "nhsuk-footer__list-item-link",
                  style = "text-decoration: underline;",
                  href = a11y_statement_url,
                  target = "_blank",
                  "Accessibility"
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
            span(
              style = "font-size: 1rem;",
              HTML("&copy; Crown Copyright")
            )
          ),
          div(
            class = "nhsuk-footer__copyright",
            style = "margin-top: 1rem; display: flex; align-items: center; gap: 0.5rem; flex-wrap: nowrap; white-space: nowrap;",  # Exclude linting
            tags$image(
              class = "nhsuk-logo",
              style = "height: 17; width: 41;",
              src = "www/assets/logos/logo-ogl.svg",
              name = "Open Government License logo",
              alt = "Open Government License"
            ),
            span(
              "All content is available under the",
              tags$a(
                href = "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/", # Exclude Linting
                rel = "license",
                style = "color: grey; text-decoration: underline;",
                "Open Government Licence v3.0,",
              ),
              "except where otherwise stated"
            )
          )
        )
      )
    )
  )
}