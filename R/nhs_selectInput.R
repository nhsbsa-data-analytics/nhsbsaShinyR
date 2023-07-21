#' nhs_selectInput
#'
#' NHS styled selectInput
#'
#' @param inputId Element id
#' @param label Element label
#' @param choices Character vector (optionally named) giving available choices
#' @param selected Initially selected choices
#' @param full_width Boolean, controls if full width or not
#' @param ... Further named args passed to \code{shiny::selectInput}
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_selectInput(
#'   "fruit",
#'   "Choose some fruit",
#'   choices = c("Apple", "Banana", "Cherry"),
#'   selected = "Banana",
#'   full_width = TRUE
#' )
nhs_selectInput <- function(inputId,
                            label,
                            choices,
                            selected = NULL,
                            full_width = FALSE,
                            ...) {

  # Create select input
  nhs_selectInput <- selectInput(
    inputId = inputId,
    label = label,
    choices = choices,
    selected = selected,
    selectize = FALSE,
    ...
  )

  # Hack the CSS to look like an NHS select input
  nhs_selectInput$attribs$class <- "nhsuk-form-group"
  nhs_selectInput$children[[1]]$attribs$class <- "nhsuk-label"

  if (full_width) {
    # need form-control to fit max width if required
    nhs_selectInput$children[[2]]$
      children[[1]]$attribs$class <- "nhsuk-select form-control"
    # form-control rounds the edges so we need this
    nhs_selectInput$children[[2]]$
      children[[1]]$attribs$style <- "border-radius: 0;"
  } else {
    nhs_selectInput$children[[2]]$
      children[[1]]$attribs$class <- "nhsuk-select"
  }

  nhs_selectInput
}
