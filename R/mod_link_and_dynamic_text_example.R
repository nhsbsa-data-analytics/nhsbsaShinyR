#' internal_link_example UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_link_and_dynamic_text_example_ui <- function(id) {
  ns <- NS(id)
  tagList(
    include_dynamic_md("inst/app/www/assets/markdown/mod_link_and_dynamic_text_example.md")
  )
}

#' internal_link_example Server Function
#'
#' @noRd
mod_link_and_dynamic_text_example_server <- function(id) { # Exclude Linting
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}
