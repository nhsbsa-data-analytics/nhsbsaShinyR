#' chart_example UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_chart_example_ui <- function(id) {
  ns <- NS(id)
  tagList(
    nhs_selectInput(
      inputId = ns("bins"),
      label = "Number of bins:",
      choices = c(5, 10, 15, 20)
    ),
    highcharter::highchartOutput(
      outputId = ns("chart")
    )
  )
}

#' chart_example Server Functions
#'
#' @noRd
mod_chart_example_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$chart <- highcharter::renderHighchart({

      # Generate bins based on input$bins from ui.R
      x <- nhsbsaShinyR::faithful[, 2]
      bins <- seq(min(x), max(x), length.out = as.numeric(input$bins) + 1)

      # Draw the histogram with the specified number of bins
      chart <- hist(x, breaks = bins)

      # Output interactive chart
      chart %>%
        highcharter::hchart() %>%
        theme_nhsbsa()
    })
  })
}

## To be copied in the UI
# mod_chart_example_ui("chart_example_ui_1")

## To be copied in the server
# mod_chart_example_server("chart_example_ui_1")
