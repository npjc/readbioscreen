
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
path <- "inst/extdata/2014_06_06 Bioscreen growth curves.csv"
d <- read_bioscreen(path)
d
#> # A tibble: 193,200 x 3
#>    Time    well     measure
#>    <chr>   <chr>      <dbl>
#>  1 0:00:04 Well 101   0.176
#>  2 0:15:06 Well 101   0.171
#>  3 0:30:06 Well 101   0.183
#>  4 0:45:06 Well 101   0.179
#>  5 1:00:06 Well 101   0.186
#>  6 1:15:05 Well 101   0.19 
#>  7 1:30:05 Well 101   0.193
#>  8 1:45:05 Well 101   0.193
#>  9 2:00:05 Well 101   0.191
#> 10 2:15:05 Well 101   0.191
#> # … with 193,190 more rows
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

Parser Specification defined by a test set of files:

``` r
bioscreen_test_set()
#> # A tibble: 28 x 1
#>    url                                                                     
#>    <chr>                                                                   
#>  1 https://raw.githubusercontent.com/philipjsweet/BioscreenC-Processing/ma…
#>  2 https://github.com/dacb/lidlab/raw/master/als/R_Shiny_Growth_Curve_App/…
#>  3 https://raw.githubusercontent.com/dacb/lidlab/master/als/R_Shiny_Growth…
#>  4 https://raw.githubusercontent.com/dacb/lidlab/master/als/R_Shiny_Growth…
#>  5 https://raw.githubusercontent.com/dacb/lidlab/master/als/R_Shiny_Growth…
#>  6 https://raw.githubusercontent.com/dacb/lidlab/master/als/R_Shiny_Growth…
#>  7 https://raw.githubusercontent.com/ptonner/gp_growth_phenotype/master/da…
#>  8 https://github.com/wleepang/BioscreenUtils/raw/master/data/20110908/201…
#>  9 https://github.com/cwrussell/bioscreen/raw/master/example/data.csv      
#> 10 https://github.com/goody-g/Growth-Curve-Analysis--ISB-/raw/master/Datab…
#> # … with 18 more rows
```
