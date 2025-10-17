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
        h2(class = "nhsuk-u-visually-hidden", "Support links"),
        tags$div(
          class = "nhsuk-width-container app-width-container",
          div(
            class = "nhsuk-footer__top-row",
            tags$ul(
              class = "nhsuk-footer__list",
              tags$li(
                class = "nhsuk-footer__list-item",
                a(
                  class = "nhsuk-footer__list-item-link",
                  href = a11y_statement_url,
                  target = "_blank",
                  "Accessibility"
                )
              ),
              tags$li(
                class = "nhsuk-footer__list-item",
                a(
                  class = "nhsuk-footer__list-item-link",
                  href = paste0("mailto:@", email),
                  target = "_blank",
                  "Contact us"
                )
              ),
              tags$li(
                class = "nhsuk-footer__list-item",
                a(
                  class = "nhsuk-footer__list-item-link",
                  href = github_url,
                  target = "_blank",
                  "GitHub"
                )
              )
            ),
            span(
              class = "nhsuk-footer__copyright",
              HTML("&copy; Crown Copyright")
            )
          ),
          div(
            class = "nhsuk-ogl-footer",
            tags$image(
              class = "nhsuk-ogl-logo",
              src = "www/assets/logos/logo-ogl.svg",
              name = "Open Government License logo",
              alt = "Open Government License"
            ),
            span(
              class = "nhsuk-ogl-footer--text",
              "All content is available under the",
              tags$a(
                href = "https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/", # Exclude Linting
                rel = "license",
                target = "_blank",
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
