#' internal_link_example UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_internal_link_example_ui <- function(id) {
  ns <- NS(id)
  tagList(
    includeMarkdown("inst/app/www/assets/markdown/mod_internal_link_example.md")
  )
}

#' internal_link_example Server Function
#'
#' @noRd
mod_internal_link_example_server <- function(id) { # Exclude Linting
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}
