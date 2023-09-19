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
    tagList(
      tags$html(lang = "en"),
      bootstrapLib(),
      a(id = "skiplink", "Skip to Main Content", href = "#maincontent"),
      nhs_header(),
      br(),
      div(id = "maincontent"),
      div(
        class = "nhsuk-width-container",
        div(
          class = "nhsuk-main-wrapper",
          role = "main",
          nhs_navlistPanel(
            id = "mainTabs",
            well = FALSE,
            widths = c(3, 9),
            tabPanel(
              title = "Introduction",
              mod_markdown_example_ui("markdown_example_ui_1")
            ),
            tabPanel(
              title = "Charts",
              mod_chart_example_ui("chart_example_ui_1")
            ),
            tabPanel(
              title = "Scrolly example",
              mod_scrollytell_example_ui("scrollytell_example_1")
            )
          )
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
  resources <- app_sys("app/www")
  addResourcePath("www", resources)

  tags$head(
    favicon("assets/favicons/favicon"),
    tags$title("nhsbsaShinyR"),

    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()

    # Javascript resources
    htmltools::htmlDependency(
      name = "resources",
      version = "0.0.1",
      src = resources,
      script = list.files(resources, pattern = "\\.js$", recursive = TRUE),
      package = NULL,
      all_files = TRUE
    ),
    # CSS resources
    lapply(
      list.files(resources, pattern = "\\.css$", recursive = TRUE),
      function(x) tags$link(href = file.path("www", x), rel = "stylesheet")
    )
  )
}
