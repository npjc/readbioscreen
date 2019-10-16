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


    d <- tidyr::gather(d, 'col_name', 'measure', -.data$time, -.data$runtime)

    # translate col names into plate and well vars
    col_names <- dplyr::distinct(d, .data$col_name)
    plate_wells <- translate_well_int(col_names$col_name)
    d <- dplyr::left_join(d, plate_wells, by = c("col_name"))

    if (!all_fields) {
        d <- dplyr::select(d, .data$plate, .data$well, .data$runtime, .data$measure)
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

#' translate column names to plate and 'a01' style well notation
#'
#' @param x <chr> column name to translate
#' translate_well_int(c(1,10,11,99,100,101,200,201, "well_1", "well_101"))
#' @keywords internal
translate_well_int <- function(v) {
    tbl <- purrr::map_df(v, translate_well_int_one)
    bioscreen_a01_wells <- sprintf("%s%02d", rep(LETTERS[1:10], each = 10), rep(1:10, 10))

    tbl$well <- bioscreen_a01_wells[tbl$well]
    tbl
}

translate_well_int_one <- function(x){
    i <- stringr::str_extract(x, "\\d+")
    if (is.na(i) | i == '0') {
        warning(paste("cannot translate well mapping:", x))
        return(list(plate = NA_character_, well = NA_integer_))
    }
    i <- as.integer(i)
    if (nchar(i) < 3) {
        out <- list(plate = '0', well = i)
    }
    if (nchar(i) == 3) {
        m <- stringr::str_match(i, '(\\d{1})(\\d{2})')
        well <- as.integer(m[,3])
        plate <- m[,2]
        if (well == 0) {
            plate <- as.character(as.integer(m[,2]) - 1)
            well <- 100
        }
        out <- list(plate = plate, well = well)
    }
    if (nchar(i) > 3) {
        warning('cannot translate well names with more than 3 int')
        out <- list(plate = NA_character_, well = NA_integer_)
    }
    tibble::as_tibble(c(list(col_name = x), out))
}
