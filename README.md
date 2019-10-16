
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/readbioscreen)](https://cran.r-project.org/package=readbioscreen)
<!-- badges: end -->

Read, Validate, Simulate and Write Bioscreen Instrument
Files.

## Installation

<!-- You can install the released version of bioscreen from [CRAN](https://CRAN.R-project.org) with: -->

``` r
# install.packages("readbioscreen") # not yet
remotes::install.github("npjc/readbioscreen")
```

## Example

Parse bioscreen-formatted files into tidy data structure:

``` r
## basic example code
library(readbioscreen)
file <-  bioscreen_example('bioscreen-example1.csv')
read_bioscreen(file)
#> # A tibble: 193,200 x 4
#>    plate well  runtime measure
#>    <chr> <chr>   <dbl>   <dbl>
#>  1 1     A01         4   0.176
#>  2 1     A01       906   0.171
#>  3 1     A01      1806   0.183
#>  4 1     A01      2706   0.179
#>  5 1     A01      3606   0.186
#>  6 1     A01      4505   0.19 
#>  7 1     A01      5405   0.193
#>  8 1     A01      6305   0.193
#>  9 1     A01      7205   0.191
#> 10 1     A01      8105   0.191
#> # … with 193,190 more rows
# inconsistent formatting in test cases means you should look at all the fields:
file <- bioscreen_example('data.csv')
read_bioscreen(file, all_fields = TRUE)
#> Warning in .f(.x[[i]], ...): cannot translate well mapping: 0
#> # A tibble: 4,559 x 6
#>    time  runtime col_name measure plate well 
#>    <chr>   <dbl> <chr>      <dbl> <chr> <chr>
#>  1 0          NA 0          0.094 <NA>  <NA> 
#>  2 0.5        NA 0          0.094 <NA>  <NA> 
#>  3 1          NA 0          0.095 <NA>  <NA> 
#>  4 1.5        NA 0          0.095 <NA>  <NA> 
#>  5 2          NA 0          0.096 <NA>  <NA> 
#>  6 2.5        NA 0          0.097 <NA>  <NA> 
#>  7 3          NA 0          0.098 <NA>  <NA> 
#>  8 3.5        NA 0          0.099 <NA>  <NA> 
#>  9 4          NA 0          0.1   <NA>  <NA> 
#> 10 4.5        NA 0          0.101 <NA>  <NA> 
#> # … with 4,549 more rows
file <- bioscreen_example('data-2.csv')
read_bioscreen(file, all_fields = TRUE)
#> Warning in .f(.x[[i]], ...): cannot translate well mapping: blank
#> # A tibble: 6,205 x 8
#>    time     runtime col_name measure plate well  label info 
#>    <chr>      <dbl> <chr>      <dbl> <chr> <chr> <chr> <chr>
#>  1 00:01:07      67 blank          0 <NA>  <NA>  <NA>  <NA> 
#>  2 00:20:06    1206 blank          0 <NA>  <NA>  <NA>  <NA> 
#>  3 00:40:06    2406 blank          0 <NA>  <NA>  <NA>  <NA> 
#>  4 01:00:06    3606 blank          0 <NA>  <NA>  <NA>  <NA> 
#>  5 01:20:06    4806 blank          0 <NA>  <NA>  <NA>  <NA> 
#>  6 01:40:06    6006 blank          0 <NA>  <NA>  <NA>  <NA> 
#>  7 02:00:06    7206 blank          0 <NA>  <NA>  <NA>  <NA> 
#>  8 02:20:06    8406 blank          0 <NA>  <NA>  <NA>  <NA> 
#>  9 02:40:06    9606 blank          0 <NA>  <NA>  <NA>  <NA> 
#> 10 03:00:06   10806 blank          0 <NA>  <NA>  <NA>  <NA> 
#> # … with 6,195 more rows
```

## About the Bioscreen instrument:

The Bioscreen C Microbiology Reader uses specialized ‘honeycomb’ plates
with 100 wells, each run can contain 2 plates.

``` r
plot_bioscreen() #' not yet.
```

<img src='inst/bioscreen-layout.png'>

More info: [1](http://www.bioscreen.fi/bioscreencmbr.html),
[2](http://docs.exdat.com/docs/index-90565.html). Bioscreen has
accompanying software:
[link](http://www.growthcurvesusa.com/software.html)

## Test set data

Parser Specification defined by a test set of files, these are provided
as installed files with this pkg.
