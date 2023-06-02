#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    shinyjs::useShinyjs(),
    # Leave this function for adding external resources
    golem_add_external_resources(),
    tags$html(lang = "en"),
    bootstrapLib(),
    # Your application UI logic
    tags$a(id = "skiplink", "Skip to Main Content", href = "#maincontent"),
    tags$style(HTML("
      #skiplink {
        position: absolute;
        transform: translateY(-100%);
      }
      #skiplink:focus {
      transform: translateY(0%);
      background-color: lightyellow;
      padding: 20px;
      z-index: 9999;
      }
      /* Customize selectizeInput appearance 
      Similar to NHS selectInput*/ 
      .selectize-input {
        color: #4c6272;
        border-radius: 0;
        border:2px solid;
        line-height:1.2;
      }
      ")),
    nhs_header(),
    br(),
    tags$div(
      class = "nhsuk-width-container",
      tags$div(
        class = "nhsuk-main-wrapper",
        id = "maincontent",
        role = "main",
        nhs_navlistPanel(
          id = "mainTabs",
          well = FALSE,
          widths = c(3, 9),
          tabPanel(
            title = "Article",
            mod_markdown_example_ui("markdown_example_ui_1"),
            mod_chart_example_ui("chart_example_ui_1"),
            mod_scrollytell_example_ui("scrollytell_example_1")
          ),
          # Whenever tab button is clicked, windows scroll to the top
          tags$script(" $(document).ready(function () {
            $('#mainTabs a[data-toggle=\"tab\"]').on('click', function (e) {
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
