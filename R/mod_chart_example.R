#' chart_example UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_chart_example_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h1_tabstop("First level"),
    h2_tabstop("Second level"),
    nhs_card_tabstop(
      heading = "example chart title",
      nhs_selectInput(
        inputId = ns("bins"),
        label = "Number of bins:",
        choices = c(5, 10, 15, 20),
        selected = 20,
        full_width = TRUE
      ),
      highcharter::highchartOutput(
        outputId = ns("chart"),
        height = "400px"
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
      x <- nhsbsaShinyR::faithful[, 2]
      bins <- seq(min(x), max(x), length.out = as.numeric(input$bins) + 1)

      # Draw the histogram with the specified number of bins
      chart <- graphics::hist(x, breaks = bins, plot = FALSE)

      # Output interactive chart
      chart %>%
        highcharter::hchart() %>%
        nhsbsaR::theme_nhsbsa_highchart()
    })

    mod_nhs_download_server(
      id = "download_test",
      filename = "test.csv",
      export_data = nhsbsaShinyR::faithful
    )
  })
}
