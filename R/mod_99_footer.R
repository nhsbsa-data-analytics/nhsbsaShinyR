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
    fluidRow(
      style = "background-color: #005EB8; width: 100%; height: 3px"
    ),
    fluidRow(
      style = "background-color: #D8DDE0; width: 100%",
      align = "center",
      fluidRow(
        style = "background-color: #D8DDE0; max-width: 950px; padding: 15px",
        column(
          width = 9,
          align = "left",
          p(
            "Developed by the ",
            a(
              style = "color: #768692;",
              "NHS Business Services Authority",
              href = "https://www.nhsbsa.nhs.uk/",
              target = "_blank"
            ),
            " and available to view on ",
            a(
              style = "color: #768692;",
              "GitHub",
              href = "https://github.com/nhsbsa-data-analytics/nhsbsaShinyR",
              target = "_blank"
            ),
            "."
          )
        ),
        column(
          width = 3,
          align = "right",
          p("© APLv2")
        )
      )
    )
  )
}

#' 99_footer Server Function
#'
#' @noRd
mod_99_footer_server <- function(input, output, session) {
  ns <- session$ns
}

## To be copied in the UI
# mod_99_footer_ui("99_footer_1")

## To be copied in the server
# callModule(mod_99_footer, "99_footer_1")
