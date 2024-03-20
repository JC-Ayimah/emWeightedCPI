#' Multivariate Weighted Indices
#'
#' @param data Dataset of prices that must contain columns of prices
#' from a base year and a current year. There must be equal number
#' of base and current year price variables.
#'
#' @return a vector of indices for calculating consumer price index (CPI)/inflation
#' @export
#' @importFrom stats cor weighted.mean
#' @importFrom dplyr all_of
#'
#' @examples mvw_cpi()
#' @examples mvw_cpi(data = empirical_Data1)
#' @examples mvw_cpi(data = empirical_Data2)
mvw_cpi <- function(data = NULL) {
  #check if user provided data
  if (is.null(data)){
  #use default data if user does not provide any
    #create list of empirical data
    empirical_Data1 <- empirical_Data1
    empirical_Data2 <- empirical_Data2
    data_list <- list(empirical_Data1,
                      empirical_Data2 )
    #choose a random empirical data for the multivariate weights function
    random_index = sample(length(data_list), size = 1, replace = T)
    random_data = dplyr::as_tibble(data_list[[random_index]])

    data <- random_data
  }

  #split data into current and base prices data sets
  p <- ncol(data)/2
  base_prices <- data |> dplyr::select(1:all_of(p))
  current_prices <- data |> dplyr::select(p + 1:p)

  #create a relative data by dividing the current prices by the base prices
  relative_price <- dplyr::as_tibble(current_prices/base_prices)

  #create a correlation matrix for both current and base prices data sets
  cor_base <- cor(base_prices)
  cor_current <- cor(current_prices)

  #generate eigen values from the correlation matrices
  eigen_base <- eigen(cor_base)$values
  eigen_current <- eigen(cor_current)$values

  #evaluate the principal component analysis factor based on eigen values greater than 1
  m1 <- length(eigen_base[eigen_base > 1]) # number of base prices eigen values greater than 1
  m2 <- length(eigen_base[eigen_base > 1]) # number of current prices eigen values greater than 1
  PCF_base <- psych::principal(base_prices, nfactors = m1, rotate = 'varimax')
  PCF_current <- psych::principal(current_prices, nfactors = m2, rotate = 'varimax')

  #pick comunality values to calculate Fischer's, Drobish Bowley's, Laspeyres' and
  # Paasche's indices
  base_communality <- PCF_base$communality
  current_communality <- PCF_current$communality

  #Lapeyres' index
  mwCPI_Lasp <- apply(relative_price, 1, weighted.mean, base_communality)

  #Paasche's index
  mwCPI_Paas <- apply(relative_price, 1, weighted.mean, current_communality)

  #Fisher's index
  mwCPI_Fish <- sqrt(mwCPI_Lasp * mwCPI_Paas)

  #Drobish Bowley's index
  mwCPI_Drob <- (mwCPI_Lasp + mwCPI_Paas)/2

  #combine all the above indices into a dataset
  index_data <- dplyr::tibble(mwCPI_Lasp, mwCPI_Paas, mwCPI_Fish, mwCPI_Drob)

  #Finally calculate indices for determining national consumer price index
  national_CPI <- apply(index_data, 2, mean)

  return(national_CPI)

}
