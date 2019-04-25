#' @importFrom rlang .data
.data

#' get a gp1 example data file
#'
#' @param file `<chr>` name of the file
#' @export
#' @examples
#'     bioscreen_example('data.csv')
#'     bioscreen_example('data-2.csv')
bioscreen_example <- function(file) {
    system.file("extdata", file, package = "readbioscreen", mustWork = TRUE)
}

#' Read a raw bioscreen data file into a tidy tibble
#'
#' @param file `<chr>` path to results file
#' @param all_fields `<lgl>` should all fields be included? Defaults to [FALSE].
#'
#' @return
#' [tibble()] with the following cols:
#'
#' - **well** identifier,
#' - **runtime** time since run start in seconds,
#' - **measure** numeric value of measurement as recorded,
#'
#' if `all_fields = TRUE`:
#'
#' - **time** character representation of time as recorded in raw file.
#' - **label** label column from optional file header
#' - **info** label column from optional file header
#' @export
#'
#' @examples
#' file <- bioscreen_example('data.csv')
#' read_bioscreen(file)
#' read_bioscreen(file, all_fields = TRUE)
read_bioscreen <- function(file, all_fields = FALSE) {
    header_l <- infer_header(file)
    d <- readr::read_delim(file,
                    delim = header_l$delim,
                    skip = header_l$skip,
                    col_names = header_l$col_names,
                    col_types = readr::cols(time = readr::col_character(),
                                     .default = readr::col_double()))
    d <- dplyr::mutate(d, runtime = time_to_runtime(.data$time))


    d <- tidyr::gather(d, 'well', 'measure', -.data$time, -.data$runtime)

    if (!all_fields) {
        d <- dplyr::select(d, .data$well, .data$runtime, .data$measure)
        return(d)
    }

    label_info_tbl <- tibble::tibble(well = header_l$col_names)

    if (!is.null(header_l$labels))
        label_info_tbl <- dplyr::mutate(label_info_tbl, label = header_l$labels)
    if (!is.null(header_l$infos))
        label_info_tbl <- dplyr::mutate(label_info_tbl, info = header_l$infos)

    d <- dplyr::left_join(d, label_info_tbl, by = "well")
    d

}

#' infer the header parameters of bioscreen file
#'
#' @param file <chr> path to file
#'
#' @keywords internal
infer_header <- function(file) {
    lines <- readr::read_lines(file, n_max = 3)
    lines <- stringr::str_to_lower(lines)

    # time row not optional
    time_row_index <- which(stringr::str_starts(lines, 'time'))
    stopifnot(length(time_row_index) == 1)
    skip <- 1

    label_row_index <- which(stringr::str_starts(lines, 'label'))
    info_row_index <- which(stringr::str_starts(lines, 'info'))

    labels <- NULL
    infos <- NULL
    if(length(label_row_index) == 1) {
        labels <- stringr::str_split(lines[label_row_index], ',')[[1]]
        skip <- skip + 1
    }
    if(length(info_row_index) == 1) {
        infos <- stringr::str_split(lines[info_row_index], ',')[[1]]
        skip <- skip + 1
    }

    col_names <- stringr::str_split(lines[time_row_index], ',')[[1]]
    col_names <- stringr::str_replace_all(col_names, ' ', '_')

    # some are .csv or are .tsv... infer delim
    delim <- stringr::str_count(lines[time_row_index], c(',', '\t'))
    delim <- c(',','\t')[which.max(delim)]

    list(col_names = col_names,
         delim = delim,
         skip = skip,
         labels = labels,
         infos = infos)
}

#' convert the raw bioscreen time format to runtime in seconds.
#'
#' @param x <chr> string of the form 'hours:minutes:seconds' where minutes and
#'   seconds are represented by 1-2 digits while hours (elapsed) can be >=1
#'
#' @keywords internal
time_to_runtime <- function(x) {
    matches <- stringr::str_match(x, '(\\d+):(\\d{1,2}):(\\d{1,2})')
    h <- as.integer(matches[,2])
    m <- as.integer(matches[,3])
    s <- as.integer(matches[,4])

    (h * 3600) + (m * 60) + s
}


bioscreen_test_set <- function() {
    tibble::tribble(
        ~url,
    'https://raw.githubusercontent.com/philipjsweet/BioscreenC-Processing/master/Bioscreen%20Example/Example_BioscreenExperimentData.csv',
    'https://github.com/dacb/lidlab/raw/master/als/R_Shiny_Growth_Curve_App/2014_06_06%20Bioscreen%20growth%20curves.csv',
    'https://raw.githubusercontent.com/dacb/lidlab/master/als/R_Shiny_Growth_Curve_App/2014_07_22%20data.csv',
    'https://raw.githubusercontent.com/dacb/lidlab/master/als/R_Shiny_Growth_Curve_App/2014_07_22_tubedata.csv',
    'https://raw.githubusercontent.com/dacb/lidlab/master/als/R_Shiny_Growth_Curve_App/2014_07_24%20more%203k3%20fdhfoca.csv',
    'https://raw.githubusercontent.com/dacb/lidlab/master/als/R_Shiny_Growth_Curve_App/2014_07_24_tubedata.csv',
    'https://raw.githubusercontent.com/ptonner/gp_growth_phenotype/master/data/example/data.csv',
    'https://github.com/wleepang/BioscreenUtils/raw/master/data/20110908/20110908_data.csv',
    'https://github.com/cwrussell/bioscreen/raw/master/example/data.csv',
    'https://github.com/goody-g/Growth-Curve-Analysis--ISB-/raw/master/Database/201101271KB/ResultsKB201101271.csv',
    'https://github.com/goody-g/Growth-Curve-Analysis--ISB-/raw/master/Database/201102171KB/ResultsKB201102171.csv',
    'https://github.com/hezhaobin/pho/raw/45c8265998fbd8b04df5958cb4ce75014e71c680/Growth_rate_analysis/20130816_growth_rate_starvation/BioscreenExperiment20130816.csv',
    'https://github.com/hezhaobin/pho/raw/45c8265998fbd8b04df5958cb4ce75014e71c680/Growth_rate_analysis/20130827_growth_rate_starvation/BioscreenExperiment20130827.csv',
    'https://github.com/hezhaobin/pho/raw/45c8265998fbd8b04df5958cb4ce75014e71c680/Growth_rate_analysis/20130924_growth_rate_starvation/BioscreenExperiment20130924.csv',
    'https://github.com/hezhaobin/pho/raw/45c8265998fbd8b04df5958cb4ce75014e71c680/Growth_rate_analysis/20131001_growth_rate_starvation/BioscreenExperiment20131001.csv',
    'https://github.com/hezhaobin/pho/raw/45c8265998fbd8b04df5958cb4ce75014e71c680/Growth_rate_analysis/20131001_growth_rate_starvation/BioscreenExperiment20131002.csv',
    'https://github.com/hezhaobin/pho/blob/45c8265998fbd8b04df5958cb4ce75014e71c680/Growth_rate_analysis/20131004_growth_rate_starvation/BioscreenExperiment20131004.csv',
    'https://github.com/amyschmid/miniterm2019/raw/master/Bioscreen_data_and_analysis/20190222_miniterm_hca.csv',
    'https://github.com/amyschmid/miniterm2019/raw/master/Bioscreen_data_and_analysis/20190222_miniterm_hca.xls',
    'https://github.com/joey0214/GCurver/raw/master/GCurver/testData/BioscreenExperiment_10_02_15.small.csv',
    'https://github.com/joey0214/GCurver/raw/master/GCurver/testData/BioscreenExperiment_10_02_15_all.csv',
    'https://github.com/joey0214/GCurver/raw/master/GCurver/testData/wildstrains37deg2012_11_28.csv',
    'https://github.com/yasab27/Yeast-Outgrowth-Data-Analyzer/raw/master/Day9.txt',
    'https://github.com/yasab27/Yeast-Outgrowth-Data-Analyzer/raw/master/Day6.txt',
    'https://github.com/yasab27/Yeast-Outgrowth-Data-Analyzer/raw/master/Day4.txt',
    'https://github.com/yasab27/Yeast-Outgrowth-Data-Analyzer/raw/master/Day2.txt',
    'https://github.com/yasab27/Yeast-Outgrowth-Data-Analyzer/raw/master/Day13.txt',
    'https://github.com/yasab27/Yeast-Outgrowth-Data-Analyzer/raw/master/Day11.txt'
    )
}
