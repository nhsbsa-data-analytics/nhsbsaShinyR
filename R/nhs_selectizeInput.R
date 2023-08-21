#' nhs_selectizeInput
#'
#' NHS styled selectizeInput
#'
#' @param inputId Element id
#' @param label Element label
#' @param full_width Boolean, controls if full width or not
#' @param ... Further named args passed to \code{shiny::selectInput}
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_selectizeInput(
#'   "fruit",
#'   "Choose some fruit",
#'   full_width = TRUE
#' )
nhs_selectizeInput <- function(inputId, # Exclude Linting
                               label,
                               full_width = FALSE,
                               ...) {
  # Create selectize input
  nhs_selectizeInput <- selectizeInput( # Exclude Linting
    inputId = inputId,
    label = label,
    choices = NULL,
    multiple = FALSE,
    options = list(
      placeholder = "Please select an option below",
      onInitialize = I('function() { this.setValue(""); }'),
      options = list(maxItems = 5, closeAfterSelect = TRUE)
    ),
    ...
  )

  # Hack the CSS to look like an NHS select input
  nhs_selectizeInput$attribs$class <- "nhsuk-form-group" # Exclude Linting
  nhs_selectizeInput$children[[1]]$attribs$class <- "nhsuk-label" # Exclude Linting

  if (full_width) {
    # need form-control to fit max width if required
    nhs_selectizeInput$children[[2]]$ # Exclude Linting
      children[[1]]$attribs$class <- "nhsuk-select form-control"
    # form-control rounds the edges so we need this
    nhs_selectizeInput$children[[2]]$ # Exclude Linting
      children[[1]]$attribs$style <- "border-radius: 0;"
  } else {
    nhs_selectizeInput$children[[2]]$ # Exclude Linting
      children[[1]]$attribs$class <- "nhsuk-select"
  }

  nhs_selectizeInput
}
