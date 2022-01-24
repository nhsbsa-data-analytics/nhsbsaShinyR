#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  mod_00_header_server("00_header_ui_1")
  mod_markdown_example_server("markdown_example_ui_1")
  mod_chart_example_server("chart_example_ui_1")
  mod_99_footer_server("99_footer_ui_1")
}
