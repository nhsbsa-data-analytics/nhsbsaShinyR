% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nhs_card.R
\name{nhs_card}
\alias{nhs_card}
\title{nhs_card}
\usage{
nhs_card(heading, ...)
}
\arguments{
\item{heading}{Card title}

\item{...}{Card content}
}
\value{
HTML
}
\description{
NHS style card element
}
\examples{
nhs_card("A card", shiny::p("Some content"))
}
