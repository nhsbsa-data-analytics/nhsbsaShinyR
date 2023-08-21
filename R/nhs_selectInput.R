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
nhs_selectInput <- function(inputId, # Exclude Linting
                            label,
                            choices,
                            selected = NULL,
                            full_width = FALSE,
                            ...) {
  # Create select input
  nsi <- selectInput(
    inputId = inputId,
    label = label,
    choices = choices,
    selected = selected,
    selectize = FALSE,
    ...
  )

  # Hack the CSS to look like an NHS select input
  nsi$attribs$class <- "nhsuk-form-group"
  nsi$children[[1]]$attribs$class <- "nhsuk-label"

  if (full_width) {
    # need form-control to fit max width if required
    nsi$children[[2]]$
      children[[1]]$attribs$class <- "nhsuk-select form-control"
    # form-control rounds the edges so we need this
    nsi$children[[2]]$
      children[[1]]$attribs$style <- "border-radius: 0;"
  } else {
    nsi$children[[2]]$
      children[[1]]$attribs$class <- "nhsuk-select"
  }

  nsi
}
