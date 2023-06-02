#' h1_tabstop Function
#'
#' @noRd
#'
h1_tabstop <- function(header, tabindex = 0, ...) {

  # create header as typical header plus tabindex attribute
  # ensures header will be stopped at when pressing keyboard tab
  h1_tabstop <- h1(header, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}


#' h2_tabstop Function
#'
#' @noRd
#'
h2_tabstop <- function(header, tabindex = 0, ...) {

  # create header as typical header plus tabindex attribute
  # ensures header will be stopped at when pressing keyboard tab
  h2_tabstop <- h2(header, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}


#' h3_tabstop Function
#'
#' @noRd
#'
h3_tabstop <- function(header, tabindex = 0, ...) {

  # create header as typical header plus tabindex attribute
  # ensures header will be stopped at when pressing keyboard tab
  h3_tabstop <- h3(header, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}


#' h4_tabstop Function
#'
#' @noRd
#'
h4_tabstop <- function(header, tabindex = 0, ...) {

  # create header as typical header plus tabindex attribute
  # ensures header will be stopped at when pressing keyboard tab
  h4_tabstop <- h4(header, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}


#' h5_tabstop Function
#'
#' @noRd
#'
h5_tabstop <- function(header, tabindex = 0, ...) {

  # create header as typical header plus tabindex attribute
  # ensures header will be stopped at when pressing keyboard tab
  h5_tabstop <- h5(header, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}


#' h6_tabstop Function
#'
#' @noRd
#'
h6_tabstop <- function(header, tabindex = 0, ...) {

  # create header as typical header plus tabindex attribute
  # ensures header will be stopped at when pressing keyboard tab
  h6_tabstop <- h6(header, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}


#' nhs_card_tabstop Function
#'
#' @noRd
#'
nhs_card_tabstop <- function(header, tabindex = 0, ...) {

  # create nhs_card as typical nhs_card plus tabindex attribute
  # ensures nhs_card will be stopped at when pressing keyboard tab
  nhs_card_tabstop <- nhs_card(header, ...) %>%
    htmltools::tagAppendAttributes(`tabindex` = tabindex)
}
