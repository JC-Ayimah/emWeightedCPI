#' Expenditure-Based Index
#'
#' @param price_data Dataset of prices that must contain columns of a base and current year prices.
#' There must be equal number of base and current year price variables.
#' @param expenditure_data Dataset containing List of items and their respective
#' expenditure prices. Consequently a price dataset with only two columns/variables;
#' `item` and `expenditure`. This dataset is the base year expenditure prices from `price_data`.
#' Hence the number of columns for the base year prices in `price_data` should correspond to
#' the number of rows in `expenditure_data`.
#'
#' @return a float number representing the Laspeyres' index
#' @export
#' @importFrom stats cor weighted.mean
#' @importFrom dplyr all_of
#'
#' @examples
#' eb_cpi(price_data = empirical_Data1, expenditure_data = expenditure_Data)
#' eb_cpi(empirical_Data1, expenditure_Data)
eb_cpi <- function(price_data, expenditure_data){

  #split price_data into current and base year prices
  p <- ncol(price_data)/2
  base_prices <- price_data |> dplyr::select(1:all_of(p))
  current_prices<- price_data|> dplyr::select(p+1 :p)

  #extract expenditure price values from expenditure_data
  expenditure <- expenditure_data[[2]]

  #create a relative price_data from the current and base price data obtained from price_data
  relative_prices <- current_prices/base_prices

  #Calculate Laspeyres' index from relative and expenditure prices datasets
  mwCPI_Lasp <- apply(relative_prices, 1, weighted.mean, expenditure)

  #Determine Consumer Price Index from Laspeyres' index
  NationalCPI <- mean(mwCPI_Lasp)

  return(structure(NationalCPI, names = ('mwCPI_Lasp')))
}
