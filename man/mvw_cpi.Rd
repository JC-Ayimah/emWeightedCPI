% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mvw_cpi.R
\name{mvw_cpi}
\alias{mvw_cpi}
\title{Multivariate Weighted Indices}
\usage{
mvw_cpi(data)
}
\arguments{
\item{data}{Dataset of prices that must contain columns of a base and current year prices.
There must be equal number of base and current year price variables.}
}
\value{
a vector of consumer price indexes for calculating inflation
}
\description{
Multivariate Weighted Indices
}
\examples{
mvw_cpi(empirical_Data1)
mvw_cpi(data = empirical_Data2)
}
