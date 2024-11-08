#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  shinyusertracking::use_logging()
  
  # Your application server logic
  mod_chart_example_server("chart_example")
  mod_scrollytell_example_server("scrollytell_example")
}
