% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read-bioscreen.R
\name{read_bioscreen}
\alias{read_bioscreen}
\title{Read a raw bioscreen data file into a tidy tibble}
\usage{
read_bioscreen(file, all_fields = FALSE)
}
\arguments{
\item{file}{\code{<chr>} path to results file}

\item{all_fields}{\code{<lgl>} should all fields be included? Defaults to \link{FALSE}.}
}
\value{
\code{\link[=tibble]{tibble()}} with the following cols:
\itemize{
\item \strong{well} identifier,
\item \strong{runtime} time since run start in seconds,
\item \strong{measure} numeric value of measurement as recorded,
}

if \code{all_fields = TRUE}:
\itemize{
\item \strong{time} character representation of time as recorded in raw file.
\item \strong{label} label column from optional file header
\item \strong{info} label column from optional file header
}
}
\description{
Read a raw bioscreen data file into a tidy tibble
}
\examples{
file <- bioscreen_example('data.csv')
read_bioscreen(file)
read_bioscreen(file, all_fields = TRUE)
}
