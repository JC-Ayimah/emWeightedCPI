#' Inflation Value
#'
#' @description
#' The inflation value is calculated from  the `mvw_cpi` function. The value calculated
#' is for the period specified in the price data provided in the `mvw_cpi` function.
#' SInce the `mvw_cpi` randomly selects either of the two price data provided locally in
#' the package, the inflation value can be calculated from either the `empirical_Data1` or
#' `emperical_Data2`. Check the help documentation on the datasets for more details.
#'
#' @param weights takes any of the indexes from the multivariate weighted indices that is:
#'            the output from the `mvw_cpi` function, which are either Fishers index (fisher),
#'            Paashe's index (paashe),Laspeyres index (laspeyres) or Drobish Bowleys index (drobish)
#'
#' @return the inflation value for the period used to determine mvw_cpi indices
#' @export
#'
#' @examples inflation('drobish')
#' @examples inflation(weights = 'fisher')
inflation <- function(weights = c('fisher', 'paashe','laspeyres','drobish')){
  #call mvw_cpi function
  indices <- mvw_cpi() * 100

  #check validity of specified weight
  if(!weights %in% c('fisher', 'paashe','laspeyres','drobish')){
    stop("Error: Invalid weight provided, please choose from
         'fisher','paashe','laspeyres', or 'drobish'")
  }

  #calculate inflation based on the specified weight
  if(weights == 'fisher'){
    value = as.numeric(indices['mwCPI_Fish'] - 100)

  } else if(weights == 'paashe'){
    value = as.numeric(indices['mwCPI_Paas'] - 100)

  } else if(weights == 'laspeyres'){
    value = as.numeric(indices['mwCPI_Lasp'] - 100)

  } else if(weights == 'drobish'){
    value = as.numeric(indices['mwCPI_Drob'] - 100)
  }

  #return a rounded value of the inflation to two decimal places
  out = paste('Inflation is', round(value, 2))
  return(out)
}
