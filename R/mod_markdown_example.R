#' markdown_example UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_markdown_example_ui <- function(id) {
  ns <- NS(id)
  tagList(
    includeMarkdown("inst/app/www/assets/markdown/mod_markdown_example.md")
  )
}

#' markdown_example Server Functions
#'
#' @noRd
mod_markdown_example_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}
