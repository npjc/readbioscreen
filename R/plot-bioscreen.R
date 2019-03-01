#' @export
plot_bioscreen <- function(data, width = NULL, height = NULL) {
    r2d3::r2d3(
        data = 1:2,
        script = system.file("bioscreen.js", package = "bioscreen"),
        width = width,
        height = height
    )
}
