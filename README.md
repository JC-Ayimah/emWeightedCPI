
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mvWeightedCPI

<!-- badges: start -->
<!-- badges: end -->

The goal of mvWeightedCPI is to generate multivariate weighted indices
for a price data. mvWeightedCPI generates these weights from base and
current year price datasets. You provide the needed data and
mvWeightedCPI works behind the scene to generate these weights. This
approach is convenient since it does not require incurring additional
cost for conducting household expenditure survey to generate CPI for the
determination of inflation figures.

## Installation

You can install the development version of mvWeightedCPI like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Example Usage

The package already contains price data that it uses to calculate the
weighted indices. The datasets contained in the package are two;
`empirical_Data1` and `empirical_Data2`. You can just call the function
without specifying the data and it will randomly pick one of the two
datasets to determine the weights.

``` r
library(mvWeightedCPI)
#calling the function without any arguments
mvw_cpi()
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   7.270705   7.270705   7.270705   7.270705
```

When you specify which dataset to use, the output indices always remain
the same. The indices might change if you call the function more than
once without specifying the data due to the random selection of the
price data.

``` r
# choose which dataset to use for calculating weights
mvw_cpi(data = 'empirical_Data2')
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   7.270705   7.270705   7.270705   7.270705
```

``` r
#output might change when function is called more than once without specifying data 
#firs call
mvw_cpi()
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   5.590217   5.719170   5.654180   5.654694

#second call
mvw_cpi()
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   5.590217   5.719170   5.654180   5.654694

#third call
mvw_cpi()
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   7.270705   7.270705   7.270705   7.270705
```

The package also contains another function; `inflation` that uses the
determined multivariate weighted indices from the `mvw_cpi` to further
calculate inflation. Four index values are generated from the `mvw_cpi`
function. The function has only one argument *`weights`* which takes
four possible values(index); *`'fisher'`*, *`'paashe'`*,*`'laspeyres'`*
and *`'drobish'`*. You can however specify only one possible index

``` r
#calculating inflation using Fishers index
inflation(weights = 'fisher')
#> [1] "Inflation is 465.42"
```
