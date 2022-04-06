#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    tags$html(lang = "en"),
    bootstrapLib(),
    # Your application UI logic
    nhs_header(),
    br(),
    tags$div(
      class = "nhsuk-width-container",
      tags$div(
        class = "nhsuk-main-wrapper",
        id = "maincontent",
        role = "main",
        nhs_navlistPanel(
          well = FALSE,
          widths = c(2, 10),
          tabPanel(
            title = "Article",
            mod_markdown_example_ui("markdown_example_ui_1"),
            mod_chart_example_ui("chart_example_ui_1")
          ),
          # Whenever tab button is clicked, windows scroll to the top
          tags$script(" $(document).ready(function () {
            $('#maincontent a[data-toggle=\"tab\"]').on('click', function (e) {
            window.scrollTo(0, 0)
            });
            });")
        )
      )
    ),
    br(),
    nhs_footer()
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www", app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "nhsbsaShinyR"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
