#' Custom NHSBSA highcharter theme
#'
#' Based on the nhsbsaR highcharter theme, since it returns a list we can edit
#' it to the specific theme for this shiny app.
#'
#' @param palette Which colour palette to use from the `nhsbsaR` package.
#' @param stack Stack option for highcharter.
#'
#' @return
#' @export
theme_nhsbsa <- function(hc, palette = NA, stack = "normal") {

  # Load theme from nhsbsaR package
  theme_nhsbsa_hc <- nhsbsaR::theme_nhsbsa_hc(family = "Frutiger W01")

  # Add the plot options
  theme_nhsbsa_hc$plotOptions <- list(
    series = list(stacking = stack, borderWidth = 0),
    bar = list(groupPadding = 0.1)
  )

  # Add the palettes (hack the highlight palette to have a lighter grey)
  theme_nhsbsa_hc$colors <- nhsbsaR::palette_nhsbsa(palette = palette)
  theme_nhsbsa_hc$colors[theme_nhsbsa_hc$colors == "#768692"] <- "#d1d5d6"
  theme_nhsbsa_hc$colAxis <- list(
    min = 0,
    minColor = nhsbsaR::palette_nhsbsa(palette = "gradient")[1],
    maxColor = nhsbsaR::palette_nhsbsa(palette = "gradient")[2]
  )

  # Style based on the NHS frontend toolkit
  theme_nhsbsa_hc$xAxis$className <- "nhsuk-body-s"
  theme_nhsbsa_hc$yAxis$className <- "nhsuk-body-s"

  # Add the theme to the chart and then remove the credits afterwards (currently
  # does not work to do this within the theme)
  hc %>%
    highcharter::hc_add_theme(hc_thm = theme_nhsbsa_hc) %>%
    highcharter::hc_xAxis(title = list(text = "")) %>%
    highcharter::hc_yAxis(title = list(text = "")) %>%
    highcharter::hc_credits(enabled = TRUE)
}
