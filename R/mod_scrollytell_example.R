#' scrollytell_example UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_scrollytell_example_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h1_tabstop("Demo of scrollytelling using iris dataset"),
    p(
      "This section shows an example of a scrolly chart in action using the 'iris'
       dataset. The scatter chart will remain in place and react to changes as the
       user scrolls."
    ),
    # start with the overall container object that will hold the different
    # sections to scroll through
    scrollytell::scrolly_container(
      # the outputID will hold the reference for the input showing the current
      # scroll section
      outputId = ns("scroll_level"),
      h2_tabstop("The iris dataset"),
      # define the container for the static part of the scrolly
      scrollytell::scrolly_graph(
        # place the sticky part in the center of the page
        # for aesthetics stops the chart hitting top of page
        div(
          style = "margin-top: 10vh" # change based on size of sticky graph
        ),
        # use a nhs_card element to hold the chart
        nhs_card_tabstop(
          # this could be made dynamic if required by using a textOutput() object
          heading = "Iris Dataset: Sepal Length v Width",
          highcharter::highchartOutput(outputId = ns("example_scroll_chart"))
        )
      ),

      # create the container for the scrolling sections of the scrolly
      scrollytell::scrolly_sections(
        scrollytell::scrolly_section(
          # each section needs a unique ID to reference, use meaningful names
          id = "section_1_all",
          # bump the start of each section to avoid top of screen
          div(
            style = "height: 20vh"
          ),
          # text output, including header if required
          h3_tabstop("Length v Width"),
          p(
            "Looking purely at the Sepal length and width does not suggest a
             strong relationship."
          ),
        ),
        scrollytell::scrolly_section(
          id = "section_2_group", # each section needs a unique ID to reference
          # bump the start of each section to avoid top of screen
          div(
            style = "height: 20vh"
          ),
          # text output, including header if required
          h3_tabstop("Split by species"),
          p(
            "When highlighting by species type we start to see that there is
             correlation within each species."
          )
        ),
        scrollytell::scrolly_section(
          id = "section_3_setosa", # each section needs a unique ID to reference
          # bump the start of each section to avoid top of screen
          div(
            style = "height: 20vh"
          ),
          # text output, including header if required
          h3_tabstop("Setosa"),
          p(
            "This species has the largest sepal width but some of the smallest
             sepal lengths."
          )
        ),
        scrollytell::scrolly_section(
          # each section needs a unique ID to reference
          id = "section_4_versicolor",
          # bump the start of each section to avoid top of screen
          div(
            style = "height: 20vh"
          ),
          # text output, including header if required
          h3_tabstop("Versicolor"),
          p("This species has the some of the smallest sepal widths.")
        ),
        scrollytell::scrolly_section(
          # each section needs a unique ID to reference
          id = "section_5_virginica",
          # bump the start of each section to avoid top of screen
          div(
            style = "height: 20vh"
          ),
          # text output, including header if required
          h3_tabstop("Setosa"),
          p("This species has the largest sepal lengths."),
          # Bump the height of the last section so that the top of it aligns
          # with the top of the sticky image when you scroll
          div(
            style = "height: 30vh" # change based on size of section
          )
        )
      )
    )
  )
}

#' scrollytell_example Server Functions
#'
#' @noRd
mod_scrollytell_example_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # create the chart object
    output$example_scroll_chart <- highcharter::renderHighchart({
      # require the scroll input to prevent errors on initialisation
      req(input$scroll_level)

      # create a custom chart dataset based on the scrolly section inputs the
      # input$scroll_level will allow you to define the chart input this input
      # is based on section of the report that is currently active during the
      # scroll
      chart_data <- datasets::iris |>
        dplyr::filter(
          .data$Species %in% switch(input$scroll_level,
            "section_3_setosa" = c("setosa"),
            "section_4_versicolor" = c("versicolor"),
            "section_5_virginica" = c("virginica"),
            c("setosa", "versicolor", "virginica")
          )
        )

      if (input$scroll_level == "section_1_all") {
        chart_data <- chart_data |>
          dplyr::mutate(group_lvl = "Species") |>
          dplyr::mutate(point_col = "#0000FF")
      } else {
        chart_data <- chart_data |>
          dplyr::mutate(group_lvl = .data$Species) |>
          dplyr::mutate(
            point_col = dplyr::case_when(
              .data$Species == "setosa" ~ "#fdb863",
              .data$Species == "versicolor" ~ "#b2abd2",
              .data$Species == "virginica" ~ "#5e3c99",
              TRUE ~ "#000000"
            )
          )
      }

      # produce the chart object
      chart_data |>
        highcharter::hchart(
          type = "scatter",
          highcharter::hcaes(
            x = Sepal.Length,
            y = Sepal.Width,
            group = group_lvl,
            color = point_col
          )
        ) |>
        highcharter::hc_xAxis(
          min = 4,
          max = 8
        ) |>
        highcharter::hc_yAxis(
          min = 1,
          max = 5
        ) |>
        # remove plot animations
        highcharter::hc_plotOptions(series = list(animation = FALSE)) |>
        # disable the legend
        highcharter::hc_legend(enabled = FALSE)
    })

    # output the scrolly object - MUST BE INCLUDED FOR SCROLLY OBJECT TO BE RENDERED
    output$scroll_level <- scrollytell::renderScrollytell({
      scrollytell::scrollytell()
    })
  })
}
