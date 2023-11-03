#' h1_tabstop
#'
#' @param heading Heading text
#' @param tabindex Number for tabindex, default 0
#' @inheritDotParams shiny::h1
#'
#' @return HTML
#' @export
#'
#' @examples
#' h1_tabstop("Heading")
h1_tabstop <- function(heading, tabindex = 0, ...) {
  # create heading as typical heading plus tabindex attribute
  # ensures heading will be stopped at when pressing keyboard tab
  h1_tabstop <- h1(heading, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}

#' h2_tabstop
#'
#' @param heading Heading text
#' @param tabindex Number for tabindex, default 0
#' @inheritDotParams shiny::h2
#'
#' @return HTML
#' @export
#'
#' @examples
#' h2_tabstop("Heading")
h2_tabstop <- function(heading, tabindex = 0, ...) {
  # create heading as typical heading plus tabindex attribute
  # ensures heading will be stopped at when pressing keyboard tab
  h2_tabstop <- h2(heading, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}

#' h3_tabstop
#'
#' @param heading Heading text
#' @param tabindex Number for tabindex, default 0
#' @inheritDotParams shiny::h3
#'
#' @return HTML
#' @export
#'
#' @examples
#' h3_tabstop("Heading")
h3_tabstop <- function(heading, tabindex = 0, ...) {
  # create heading as typical heading plus tabindex attribute
  # ensures heading will be stopped at when pressing keyboard tab
  h3_tabstop <- h3(heading, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}

#' h4_tabstop
#'
#' @param heading Heading text
#' @param tabindex Number for tabindex, default 0
#' @inheritDotParams shiny::h4
#'
#' @return HTML
#' @export
#'
#' @examples
#' h4_tabstop("Heading")
h4_tabstop <- function(heading, tabindex = 0, ...) {
  # create heading as typical heading plus tabindex attribute
  # ensures heading will be stopped at when pressing keyboard tab
  h4_tabstop <- h4(heading, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}

#' h5_tabstop
#'
#' @param heading Heading text
#' @param tabindex Number for tabindex, default 0
#' @inheritDotParams shiny::h5
#'
#' @return HTML
#' @export
#'
#' @examples
#' h5_tabstop("Heading")
h5_tabstop <- function(heading, tabindex = 0, ...) {
  # create heading as typical heading plus tabindex attribute
  # ensures heading will be stopped at when pressing keyboard tab
  h5_tabstop <- h5(heading, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}

#' h6_tabstop
#'
#' @param heading Heading text
#' @param tabindex Number for tabindex, default 0
#' @inheritDotParams shiny::h6
#'
#' @return HTML
#' @export
#'
#' @examples
#' h6_tabstop("Heading")
h6_tabstop <- function(heading, tabindex = 0, ...) {
  # create heading as typical heading plus tabindex attribute
  # ensures heading will be stopped at when pressing keyboard tab
  h6_tabstop <- h6(heading, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}


#' nhs_card_tabstop
#'
#' @param heading Card title
#' @param tabindex Number for tabindex, default 0
#' @param ... Card content
#'
#' @return HTML
#' @export
#'
#' @examples
#' nhs_card_tabstop("A card", shiny::p("Some content"))
nhs_card_tabstop <- function(heading, tabindex = 0, ...) {
  # create nhs_card as typical nhs_card plus tabindex attribute
  # ensures nhs_card will be stopped at when pressing keyboard tab
  htmltools::tagQuery(nhs_card(heading, ...))$
    find(".nhsuk-card__heading")$
    removeAttr("tabindex")$
    addAttr("tabindex" = tabindex)$
    allTags() # Exclude Linting
}
