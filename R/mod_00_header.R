#' 00_header UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_00_header_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      style = "background-color: #005EB8; width: 100%",
      align = "center",
      fluidRow(
        style = "background-color: #005EB8; max-width: 950px",
        align = "left",
        splitLayout(
          cellArgs = list(style = "padding: 15px"),
          tags$a(
            href = "https://www.nhs.uk/",
            target = "_blank",
            img(src = "www/logo.jpg", height = "10%", width = "10%")
          )
        )
      )
    )
  )
}

#' 00_header Server Function
#'
#' @noRd
mod_00_header_server <- function(input, output, session) {
  ns <- session$ns
}

## To be copied in the UI
# mod_00_header_ui("00_header_1")

## To be copied in the server
# callModule(mod_00_header, "00_header_1")
