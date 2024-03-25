
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mvWeightedCPI Package

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

## Package Functions

### mvw_cpi function

The function that calculates the multivariate weighted indices is the
`mvw_cpi` function. It requires only one argument *`(data)`*; the price
data from which to calculate the indices.

``` r
library(mvWeightedCPI)
#create an arbitrary price data
myData <- data.frame(x1=runif(50, 9.9, 13.7),
                    x2=rnorm(50, 10.9, 2.1),
                    x3=runif(50, 12.2, 15),
                    x4=runif(50,19.4, 24),
                    y1=runif(50, 26, 30),
                    y2=runif(50, 31, 38.9),
                    y3=runif(50, 28.2, 33.1),
                    y4=runif(50, 51.8, 60)
)
#call the function and specify the price data
mvw_cpi(data = myData)
#> mwCPI_Lasp mwCPI_Paas mwCPI_Fish mwCPI_Drob 
#>   2.567858   2.608901   2.588270   2.588379
```

### mvw_inflation function

The package also contains another function; `mvw_inflation` that uses
the determined multivariate weighted indices from the `mvw_cpi` to
further calculate inflation. Four index values are generated from the
`mvw_cpi` function and you will have to specify which index to use in
the `mvw_inflaion` function. The function takes two arguments *`index`*
and *`data`* . the *`index`* argument takes one of four possible
values(index); *`'fisher'`*, *`'paashe'`*,*`'laspeyres'`* and
*`'drobish'`*. The *`data`* argument requires the price dataset from
which the inflation is to be determined.

``` r
#calculating inflation using Fishers index
mvw_inflation(index = 'fisher', data = myData)
#> [1] "Inflation is 158.83"
```

Fishers’ is the ideal index for calculating inflation. The rest of the
indices generates a warning after calculating inflation

``` r
mvw_inflation(index = 'drobish', data = myData)
#> Warning in mvw_inflation(index = "drobish", data = myData): Fishers index is
#> the ideal index for Inflation calculation
#> [1] "Inflation is 158.84"
```

## Package Datasets

The package contains some price datasets
`(empirical_Data1 and empirical_Data2)` \[more information on them in
the help documentation\], that can be used with the function. The data
is Lazy loaded into your session once you import the package with
`library()` so you can just view the data by calling the name of the
data

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
# calculate indices and inflation using empirical_Data1
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
