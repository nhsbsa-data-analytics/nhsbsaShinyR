#' nhs_download UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_nhs_download_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      style = "position:relative; height:55px;",
      tags$div(
        class = "nhsuk-action-link",
        style = "position:absolute; bottom:0; right:0; margin-bottom:0;",
        shiny::downloadLink(
          outputId = ns("download"),
          class = "nhsuk-action-link__link",
          tags$svg(
            class = "nhsuk-icon nhsuk-icon__arrow-right-circle",
            xmlns = "http://www.w3.org/2000/svg",
            viewBox = "0 0 24 24",
            `aria-hidden` = "true",
            width = "36",
            height = "36",
            tags$path(
              d = "M0 0h24v24H0z",
              fill = "none"
            ),
            tags$path(
              d = "M12 2a10 10 0 0 0-9.95 9h11.64L9.74 7.05a1 1 0 0 1 1.41-1.41l5.66 5.65a1 1 0 0 1 0 1.42l-5.66 5.65a1 1 0 0 1-1.41 0 1 1 0 0 1 0-1.41L13.69 13H2.05A10 10 0 1 0 12 2z"
            )
          ),
          tags$span(
            class = "nhsuk-action-link__text",
            "Download Data"
          )
        )
      )
    )
  )
}

#' nhs_download Server Functions
#'
#' @noRd
mod_nhs_download_server <- function(id, filename, export_data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$download <- downloadHandler(
      filename = filename,
      content = function(file) {
        write.csv(
          # Handle possibility of reactive input
          x = if (is.data.frame(export_data)) export_data else export_data(),
          file = file,
          row.names = FALSE
        )
      }
    )
  })
}
## To be copied in the UI
# mod_nhs_download_ui("nhs_download_ui_1")

## To be copied in the server
# mod_nhs_download_server("nhs_download_ui_1")
