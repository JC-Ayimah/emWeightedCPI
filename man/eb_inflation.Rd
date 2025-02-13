% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eb_inflation.R
\name{eb_inflation}
\alias{eb_inflation}
\title{Inflation From Expenditure Based Index}
\usage{
eb_inflation(price_data, expenditure_data)
}
\arguments{
\item{price_data}{Dataset of prices that must contain columns of a base and current year prices.
There must be equal number of base and current year price variables.}

\item{expenditure_data}{Dataset containing List of items and their respective
expenditure prices. Consequently a price dataset with only two columns/variables;
\code{item} and \code{expenditure}. This dataset is the base year expenditure prices from \code{price_data}.
Hence the number of columns for the base year prices in \code{price_data} should correspond to
the number of rows in \code{expenditure_data}.}
}
\value{
the inflation value calculated from Laspeyres' index
}
\description{
Inflation From Expenditure Based Index
}
\examples{
eb_inflation(empirical_Data1, expenditure_Data)
}
