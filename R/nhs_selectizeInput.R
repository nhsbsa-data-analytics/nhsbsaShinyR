#' nhs_selectizeInput
#'
#' NHS styled selectizeInput. This is meant to be used with options passed in
#' from the server. For example, long lists of organisations or drugs. It allows
#' to search for options by typing as well as dropdown.
#'
#' @param inputId Element id
#' @param label Element label
#' @param full_width Boolean, controls if full width or not
#' @param ... Further named args passed to \code{shiny::selectizeInput}
#'
#' @return HTML
#' @export
#'
#' @examples
#' # In module UI function
#' nhs_selectizeInput(
#'   "fruit",
#'   "Choose some fruit",
#'   full_width = TRUE
#' )
#'
#' \dontrun{
#' # In module server function
#' shiny::updateSelectizeInput(
#'   session,
#'   "fruit",
#'   choices = sort(fruit_list),
#'   server = TRUE
#' )
#' }
nhs_selectizeInput <- function(inputId, # Exclude Linting
                               label,
                               full_width = FALSE,
                               ...) {
  # Create selectize input
  nsi <- selectizeInput( # Exclude Linting
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
  nsi$attribs$class <- "nhsuk-form-group" # Exclude Linting
  nsi$children[[1]]$attribs$class <- "nhsuk-label" # Exclude Linting

  # Accessibility
  # Associate the label with the select input for accessibility
  label_id <- paste0(inputId, "-label")
  # for attribute in label
  # (https://www.w3schools.com/accessibility/accessibility_labels.php)
  nsi$children[[1]]$attribs$`for` <- inputId
  nsi$children[[1]]$attribs$id <- label_id # id for the label
  nsi$children[[2]]$children[[1]]$attribs$`aria-labelledby` <- label_id # label

  if (full_width) {
    # need form-control to fit max width if required
    nsi$children[[2]]$ # Exclude Linting
      children[[1]]$attribs$class <- "nhsuk-select form-control"
    # form-control rounds the edges so we need this
    nsi$children[[2]]$ # Exclude Linting
      children[[1]]$attribs$style <- "border-radius: 0;"
  } else {
    nsi$children[[2]]$ # Exclude Linting
      children[[1]]$attribs$class <- "nhsuk-select"
  }

  nsi
}
