#' footer UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_footer_ui <- function(id) {
  ns <- NS(id)
  tagList()
}

#' footer Server Functions
#'
#' @noRd
mod_footer_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}

## To be copied in the UI
# mod_footer_ui("footer_ui_1")

## To be copied in the server
# mod_footer_server("footer_ui_1")
