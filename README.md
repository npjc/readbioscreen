
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/readbioscreen)](https://cran.r-project.org/package=readbioscreen)

Read, Validate, Simulate and Write Bioscreen Instrument
Files.

## Installation

<!-- You can install the released version of bioscreen from [CRAN](https://CRAN.R-project.org) with: -->

``` r
# install.packages("readbioscreen") # not yet
remotes::install.github("npjc/readbioscreen")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
library(readbioscreen)
file <- "inst/extdata/2014_06_06 Bioscreen growth curves.csv"
read_bioscreen(file)
#> # A tibble: 193,200 x 3
#>    well     runtime measure
#>    <chr>      <dbl>   <dbl>
#>  1 well_101       4   0.176
#>  2 well_101     906   0.171
#>  3 well_101    1806   0.183
#>  4 well_101    2706   0.179
#>  5 well_101    3606   0.186
#>  6 well_101    4505   0.19 
#>  7 well_101    5405   0.193
#>  8 well_101    6305   0.193
#>  9 well_101    7205   0.191
#> 10 well_101    8105   0.191
#> # … with 193,190 more rows
# inconsistent formatting in test cases means you should look at all the fields:
file <- bioscreen_example('data.csv')
read_bioscreen(file, all_fields = TRUE)
#> # A tibble: 4,559 x 4
#>    time  runtime well  measure
#>    <chr>   <dbl> <chr>   <dbl>
#>  1 0          NA 0       0.094
#>  2 0.5        NA 0       0.094
#>  3 1          NA 0       0.095
#>  4 1.5        NA 0       0.095
#>  5 2          NA 0       0.096
#>  6 2.5        NA 0       0.097
#>  7 3          NA 0       0.098
#>  8 3.5        NA 0       0.099
#>  9 4          NA 0       0.1  
#> 10 4.5        NA 0       0.101
#> # … with 4,549 more rows
file <- bioscreen_example('data-2.csv')
read_bioscreen(file, all_fields = TRUE)
#> # A tibble: 6,205 x 6
#>    time     runtime well  measure label  info  
#>    <chr>      <dbl> <chr>   <dbl> <chr>  <chr> 
#>  1 00:01:07      67 blank       0 "\"\"" "\"\""
#>  2 00:20:06    1206 blank       0 "\"\"" "\"\""
#>  3 00:40:06    2406 blank       0 "\"\"" "\"\""
#>  4 01:00:06    3606 blank       0 "\"\"" "\"\""
#>  5 01:20:06    4806 blank       0 "\"\"" "\"\""
#>  6 01:40:06    6006 blank       0 "\"\"" "\"\""
#>  7 02:00:06    7206 blank       0 "\"\"" "\"\""
#>  8 02:20:06    8406 blank       0 "\"\"" "\"\""
#>  9 02:40:06    9606 blank       0 "\"\"" "\"\""
#> 10 03:00:06   10806 blank       0 "\"\"" "\"\""
#> # … with 6,195 more rows
```

## About the Bioscreen instrument:

The Bioscreen C Microbiology Reader uses specialized ‘honeycomb’ plates
with 100 wells, each run can contain 2 plates.

``` r
plot_bioscreen()
```

<img src='inst/bioscreen-layout.png'>

More info: [1](http://www.bioscreen.fi/bioscreencmbr.html),
[2](http://docs.exdat.com/docs/index-90565.html). Bioscreen has
accompanying software:
[link](http://www.growthcurvesusa.com/software.html)

## Test set data

Parser Specification defined by a test set of files, these are provided
as installed files with this pkg.
