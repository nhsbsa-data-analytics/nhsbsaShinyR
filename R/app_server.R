#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  mod_markdown_example_server("markdown_example_ui_1")
  mod_chart_example_server("chart_example_ui_1")
}
