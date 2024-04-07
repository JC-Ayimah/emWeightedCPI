
<!-- README.md is generated from README.Rmd. Please edit that file -->

# emWeightedCPI Package

<!-- badges: start -->
<!-- badges: end -->

The goal of emWeightedCPI package is to automate a proposed multivariate
weighted indexing scheme for price data. The multivariate weighted
consumer price index (MVWCPI) generates weights for both base and
current years, respectively, from base and current year price datasets
using communality obtained after performing factor analysis. The package
takes base and current year price data as inputs. This approach is
convenient since it does not require incurring additional cost for
conducting household expenditure survey to generate CPI for the
determination of inflation figures. However, the package can still
generate the Laspeyres’ CPI and inflation using base year expenditure
data only. More information
[here](http://dx.doi.org/10.9734/bpi/mono/978-81-19315-32-1).

## Installation

You can install the development version of mvWeightedCPI from
[GitHub](https://github.com/) like so:

``` r
install.packages("devtools")
devtools::install_github("JC-Ayimah/emWeightedCPI")
```

## Package Functions

### mvw_cpi function

The function that calculates the multivariate weighted indices is the
`mvw_cpi` function. It requires only one argument *`(data)`*; the price
data from which to calculate the indices.

``` r
library(emWeightedCPI)
#create an arbitrary price data
mypriceData <- data.frame(x1=runif(50, 9.9, 13.7),
                    x2=rnorm(50, 10.9, 2.1),
                    x3=runif(50, 12.2, 15),
                    x4=runif(50,19.4, 24), # base year prices
                    y1=runif(50, 26, 30),
                    y2=runif(50, 31, 38.9),
                    y3=runif(50, 28.2, 33.1),
                    y4=runif(50, 51.8, 60) # current year prices
)
#call the function and specify the price data
mvw_cpi(data = mypriceData)
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   2.646119   2.307647   2.468863   2.476883
```

### mvw_inflation function

The `mvw_inflation` function uses the determined multivariate weighted
indices from the `mvw_cpi` to further calculate inflation. Four index
values are generated from the `mvw_cpi` function and you will have to
specify which index to use in the `mvw_inflaion` function. The function
takes two arguments *`index`* and *`data`* . the *`index`* argument
takes one of four possible values(index); *`'fisher'`*,
*`'paashe'`*,*`'laspeyres'`* and *`'drobish'`*. The *`data`* argument
requires the price dataset from which the inflation is to be determined.

``` r
#calculating inflation using Fishers index
mvw_inflation(index = 'fisher', data = mypriceData)
#> [1] "Inflation is 146.89"
```

Fishers’ is the ideal index for calculating inflation. The rest of the
indices generates a warning after calculating inflation

``` r
#generates warning after calculating inflation
mvw_inflation(index = 'drobish', data = mypriceData)
#> Warning in mvw_inflation(index = "drobish", data = mypriceData): Fishers index
#> is the ideal index for Inflation calculation
#> [1] "Inflation is 147.69"
```

### eb_cpi Function

This function also calculates consumer price index. Whiles `mvw_cpi`
uses multivariate weights, the `eb_cpi` determines CPI from expenditure
based expenses. The function takes in two inputs, a price data and an
expenditure data.The index calculated from this function is the
*`'Laspeyres index'`*

``` r
#pick base year prices from mypriceData
n_vec <- apply(mypriceData[, 1:4], 2, mean)

#combine the output above into a dataframe with two columns and same 
#number of rows as number of price items to create expenditure data
myexpData <- cbind.data.frame(item = names(n_vec), price = (unname(n_vec)))

#calculate CPI 
eb_cpi(price_data = mypriceData, expenditure_data = myexpData)
#> mwCPI_Lasp 
#>   2.591228
```

### eb_inflation Function

Like the `mvw_inflation` function, the `eb_inflation` function also
calculates inflation based on the index calculated from the `eb_cpi`
function. The function takes the same arguments specified in the
`eb_cpi` function.

``` r
eb_inflation(mypriceData, myexpData)
#> [1] "Inflation is 159.12"
```

## Package Datasets

The package contains some price datasets
`(empirical_Data1, empirical_Data2 and expenditure_Data)` \[more
information on them in the help documentation\], that can be used with
the above functions. The data is Lazy loaded into your session once you
import the package with `library()` so you can just view the data by
calling the name of the data

``` r
# inspect empirical_Data1 provided in package
head(empirical_Data1)
#> # A tibble: 6 × 38
#>      B1    B2    B3    B4    B5    B6    B7    B8    B9   B10   B11   B12   B13
#>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1  1.65     2   7.5   1.7  7.67  1.44   0.5   0.4   0.5  1.03   0.5   1.5  266.
#> 2  2        2   7.5   1.7  7.93  1.44   0.5   0.4   0.5  1.03   0.5   1.5  266.
#> 3  2        2   7.5   1.7  7.93  1.44   0.5   0.4   0.5  1.03   0.5   1.5  266.
#> 4  2        2   7.5   1.7  7.93  1.44   0.5   0.4   0.5  1.03   0.5   1.5  266.
#> 5  2        2   7.5   1.7  8.15  1.5    0.5   0.4   0.5  1.03   0.5   1.5  266.
#> 6  2        2   7.5   1.7  8.15  1.5    0.5   0.4   0.5  1.03   0.5   1.5  266.
#> # ℹ 25 more variables: B14 <dbl>, B15 <dbl>, B16 <dbl>, B17 <dbl>, B18 <dbl>,
#> #   B19 <dbl>, C1 <dbl>, C2 <dbl>, C3 <dbl>, C4 <dbl>, C5 <dbl>, C6 <dbl>,
#> #   C7 <dbl>, C8 <dbl>, C9 <dbl>, C10 <dbl>, C11 <dbl>, C12 <dbl>, C13 <dbl>,
#> #   C14 <dbl>, C15 <dbl>, C16 <dbl>, C17 <dbl>, C18 <dbl>, C19 <dbl>
dim(empirical_Data1)
#> [1] 120  38
# calculate mvw_cpi indices and mvw_inflation using empirical_Data1
mvw_cpi(data = empirical_Data1)
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   5.590217   5.719170   5.654180   5.654694
mvw_inflation(index='fisher', data = empirical_Data1)
#> [1] "Inflation is 465.42"
```

``` r
# inspect empirical_Data2 provided in package
head(empirical_Data2)
#> # A tibble: 6 × 110
#>      B1    B2    B3    B4    B5    B6    B7    B8    B9   B10   B11   B12   B13
#>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 24.2  101.  14.1   7.06  6.05  3.98  3.3   1.6   2.68  5.39 23.2   1.24 12.1 
#> 2  5.5   22.8  4.56  1.37  1.71  1.06  0.55  1.08  0.56  1.59  5.08  0.48  5.69
#> 3  2.53  12.7  3.38  1.27  1.69  0.52  0.2   0.46  0.14  1.17  6.71  0.26  6.33
#> 4  6.67  21.4  4.94  1.87  2.13  1.01  0.8   0.79  1.09  1.42  5.33  0.84  4   
#> 5  5.67  24.7  5.15  1.24  1.7   0.63  0.43  0.86  0.49  1.53  4.53  0.5   5.15
#> 6 12.9   57.3  7.87  5.73  5.73  2.31  1.93  1.03  1.8   3.05  6.25  1.29 10.7 
#> # ℹ 97 more variables: B14 <dbl>, B15 <dbl>, B16 <dbl>, B17 <dbl>, B18 <dbl>,
#> #   B19 <dbl>, B20 <dbl>, B21 <dbl>, B22 <dbl>, B23 <dbl>, B24 <dbl>,
#> #   B25 <dbl>, B26 <dbl>, B27 <dbl>, B28 <dbl>, B29 <dbl>, B30 <dbl>,
#> #   B31 <dbl>, B32 <dbl>, B33 <dbl>, B34 <dbl>, B35 <dbl>, B36 <dbl>,
#> #   B37 <dbl>, B38 <dbl>, B39 <dbl>, B40 <dbl>, B41 <dbl>, B42 <dbl>,
#> #   B43 <dbl>, B44 <dbl>, B45 <dbl>, B46 <dbl>, B47 <dbl>, B48 <dbl>,
#> #   B49 <dbl>, B50 <dbl>, B51 <dbl>, B52 <dbl>, B53 <dbl>, B54 <dbl>, …
dim(empirical_Data2)
#> [1]  89 110
# calculate indices and inflation using empirical_Data2
mvw_cpi(data = empirical_Data2)
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   7.270705   7.270705   7.270705   7.270705
mvw_inflation(index='fisher', data = empirical_Data2)
#> [1] "Inflation is 627.07"
```

``` r
#inspect expenditure_Data provided in The package
head(expenditure_Data)
#> # A tibble: 6 × 2
#>   Item  Expenditure
#>   <chr>       <dbl>
#> 1 P1           5.42
#> 2 P2           2.97
#> 3 P3           2.13
#> 4 P4          13.6 
#> 5 P5           5.02
#> 6 P6           4.13
dim(expenditure_Data)
#> [1] 19  2
#calculate eb_cpi and eb_inflation using empirical_Data1 and expenditure_Data
eb_cpi(empirical_Data1, expenditure_Data)
#> mwCPI_Lasp 
#>   4.647541
eb_inflation(empirical_Data1, expenditure_Data)
#> [1] "Inflation is 364.75"
```
