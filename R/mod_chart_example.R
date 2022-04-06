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
    h1("First level"),
    h2("second level"),
    nhs_card(
      heading = "example chart title",
      nhs_selectInput(
        inputId = ns("bins"),
        label = "Number of bins:",
        choices = c(5, 10, 15, 20),
        selected = 20
      ),
      highcharter::highchartOutput(
        outputId = ns("chart"),
        height = "400px",
        width = "80%"
      ),
      mod_nhs_download_ui(
        id = ns("download_test")
      )
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
      x <- faithful[, 2]
      bins <- seq(min(x), max(x), length.out = as.numeric(input$bins) + 1)

      # Draw the histogram with the specified number of bins
      chart <- hist(x, breaks = bins)

      # Output interactive chart
      chart %>%
        highcharter::hchart() %>%
        theme_nhsbsa()
    })

    mod_nhs_download_server(
      id = "download_test",
      filename = "test.csv",
      export_data = faithful
    )
  })
}

## To be copied in the UI
# mod_chart_example_ui("chart_example_ui_1")

## To be copied in the server
# mod_chart_example_server("chart_example_ui_1")
