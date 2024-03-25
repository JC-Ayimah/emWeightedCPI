#' Inflation Value from multivariate weighted indices
#'
#'
#' @param index takes any of the indexes from the multivariate weighted indices that is:
#'            the output from the `mvw_cpi` function, which are either Fishers index (fisher),
#'            Paashe's index (paashe),Laspeyres index (laspeyres) or Drobish Bowleys index (drobish)
#'
#' @param data price dataset provided by user from which inflation is calculated. Must be in
#'            the same format as that used in the `mvw_cpi` function.
#'
#' @return the inflation value for the period used to determine mvw_cpi indices
#' @export
#'
#' @examples
#' # generates a warning message if index provided is not fishers'
#' mvw_inflation('drobish', empirical_Data1)
#' mvw_inflation(index = 'fisher', data = empirical_Data1)
mvw_inflation <- function(index = c('fisher', 'paashe','laspeyres','drobish'), data ){
  #call mvw_cpi function
  indices <- mvw_cpi(data) * 100

  #check validity of specified weight
  if(!index %in% c('fisher', 'paashe','laspeyres','drobish')){
    stop("Error: Invalid weight provided, please choose from
         'fisher','paashe','laspeyres', or 'drobish'")
  }

  #calculate inflation based on the specified weight
  if(index == 'fisher'){
    value = as.numeric(indices['mwCPI_Fish'] - 100)

  } else if(index == 'paashe'){
    value = as.numeric(indices['mwCPI_Paas'] - 100)
    warning("Fishers index is the ideal index for Inflation calculation")

  } else if(index == 'laspeyres'){
    value = as.numeric(indices['mwCPI_Lasp'] - 100)
    warning("Fishers index is the ideal index for Inflation calculation")

  } else if(index == 'drobish'){
    value = as.numeric(indices['mwCPI_Drob'] - 100)
    warning("Fishers index is the ideal index for Inflation calculation")
  }

  #return a rounded value of the inflation to two decimal places
  out = paste('Inflation is', round(value, 2))
  return(out)
}
