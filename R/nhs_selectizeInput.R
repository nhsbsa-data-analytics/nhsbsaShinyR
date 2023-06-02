#' nhs_selectizeInput Function
#'
#' @importFrom shiny tagList
nhs_selectizeInput <- function(inputId,
                               label,
                               full_width = FALSE) {
  # Create selectize input
  nhs_selectizeInput <- shiny::selectizeInput(
    inputId = inputId,
    label = label,
    choices = NULL,
    multiple = FALSE,
    options = list(
      placeholder = 'Please select an option below',
      onInitialize = I('function() { this.setValue(""); }'),
      options = list(maxItems = 5, closeAfterSelect = TRUE)
    )
  )

  
  # Hack the CSS to look like an NHS select input
  nhs_selectizeInput$attribs$class <- "nhsuk-form-group"
  nhs_selectizeInput$children[[1]]$attribs$class <- "nhsuk-label"
  
  if (full_width) {
    nhs_selectizeInput$children[[2]]$children[[1]]$attribs$class <- "nhsuk-select form-control" # need form-control to fit max width if required
    nhs_selectizeInput$children[[2]]$children[[1]]$attribs$style <- "border-radius: 0;" # form-control rounds the edges so we need this
  } else {
    nhs_selectizeInput$children[[2]]$children[[1]]$attribs$class <- "nhsuk-select"
  }
  

  tagList(
    nhs_selectizeInput
  )
}
