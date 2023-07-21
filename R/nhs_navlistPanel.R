#' nhs_navlistPanel
#'
#' NHS style navlist element
#'
#' @inheritParams shiny::navlistPanel 
#' 
#' @return HTML
#' @export
#'
#' @examples
#' nhs_navlistPanel(
#'   "nav_panel",
#'   shiny::tabPanel(title = "Introduction", shiny::p("This is an intro")),
#'   shiny::tabPanel(title = "Article", shiny::p("This is an article"))
#' )
nhs_navlistPanel <- function(id = NULL,
                             selected = NULL,
                             header = NULL,
                             footer = NULL,
                             fluid = TRUE,
                             widths = c(4, 8),
                             ...) {
  #browser()
  # Create navlist panel
  nvp <- navlistPanel(
    id = id,
    selected = selected,
    header = header,
    footer = footer,
    fluid = fluid,
    widths = widths,
    ...
  )

  # Hack the CSS to look like an NHS list
  nvp$children[[1]]$
    children[[1]]$attribs$class <- "nhsuk-list app-side-nav__list"

  tagList(nvp)
}
