#' nhs_selectInput Function
#'
#' @importFrom shiny tagList
nhs_selectInput <- function(inputId,
                            label,
                            choices,
                            selected = NULL,
                            full_width = FALSE) {

  # Create select input
  nhs_selectInput <- shiny::selectInput(
    inputId = inputId,
    label = label,
    choices = choices,
    selected = selected,
    selectize = FALSE
  )

  # Hack the CSS to look like an NHS select input
  nhs_selectInput$attribs$class <- "nhsuk-form-group"
  nhs_selectInput$children[[1]]$attribs$class <- "nhsuk-label"

  if (full_width) {
    nhs_selectInput$children[[2]]$children[[1]]$attribs$class <- "nhsuk-select form-control" # need form-control to fit max width if required
    nhs_selectInput$children[[2]]$children[[1]]$attribs$style <- "border-radius: 0;" # form-control rounds the edges so we need this
  } else {
    nhs_selectInput$children[[2]]$children[[1]]$attribs$class <- "nhsuk-select"
  }

  tagList(
    nhs_selectInput
  )
}
