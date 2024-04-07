#' Inflation From Expenditure Based Index
#'
#' @param price_data Dataset of prices that must contain columns of a base and current year prices.
#' There must be equal number of base and current year price variables.
#' @param expenditure_data Dataset containing List of items and their respective
#' expenditure prices. Consequently a price dataset with only two columns/variables;
#' `item` and `expenditure`. This dataset is the base year expenditure prices from `price_data`.
#' Hence the number of columns for the base year prices in `price_data` should correspond to
#' the number of rows in `expenditure_data`.
#'
#' @return the inflation value calculated from Laspeyres' index
#' @export
#'
#' @examples
#' eb_inflation(empirical_Data1, expenditure_Data)
eb_inflation<-function(price_data, expenditure_data){

  #check condition for extreme case when dataset is null
  if ( is.null(price_data) || is.null(expenditure_data)){
    return('Inflation is NA')
  } else {

  #call eb_cpi function
  index <- eb_cpi(price_data, expenditure_data)

  #calculate inflation for period
  value <- as.numeric(100*index)-100

  #return a rounded figure of inflation value to two decimal places
  out = paste('Inflation is', round(value, 2))
  return(out)
}
}
