#' 99_footer UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_99_footer_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$footer(
      role = "contentinfo",
      tags$div(
        class = "nhsuk-footer",
        id = "nhsuk-footer",
        tags$div(
          class = "nhsuk-width-container app-width-container",
          p(
            class = "nhsuk-footer__list",
            "Developed by the ",
            a(
              class = "nhsuk-footer__list-item-link",
              style = "text-decoration: underline;",
              "NHS Business Services Authority",
              href = "https://www.nhsbsa.nhs.uk/",
              target = "_blank"
            ),
            " and available to view on ",
            a(
              class = "nhsuk-footer__list-item-link",
              style = "text-decoration: underline;",
              "GitHub",
              href = "https://github.com/nhsbsa-data-analytics/nhsbsaShinyR",
              target = "_blank"
            ),
            "."
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

#' 99_footer Server Functions
#'
#' @noRd
mod_99_footer_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}

## To be copied in the UI
# mod_99_footer_ui("99_footer_ui_1")

## To be copied in the server
# mod_99_footer_server("99_footer_ui_1")
