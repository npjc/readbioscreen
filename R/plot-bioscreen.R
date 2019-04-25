# plot_bioscreen <- function(data, width = NULL, height = NULL) {
#     r2d3::r2d3(
#         data = 1:2,
#         script = system.file("bioscreen.js", package = "bioscreen"),
#         width = width,
#         height = height
#     )
# }
#
# bioscreen_layout <- function() {
#     d <- tibble::tibble(well = 1:100L,
#                         row = rep(c(seq(1, 20, by = 2), seq(2, 20, by = 2)), 5),
#                         col = rep(1:10L, each = 10))
#     d <- tidyr::crossing(d, plate = 1:2L)
#     d <- dplyr::select(d, plate, well, row, col)
#     dplyr::arrange(d, plate, well, row, col)
# }
#
# plot_bioscreen_layout <- function() {
#     ggplot(bioscreen_layout()) +
#         geom_point(aes(x = col, y = row), shape = 21, fill = NA, color = 'black', size = 10) +
#         geom_text(aes(x = col, y = row, label = well)) +
#         facet_wrap(~plate, nrow = 1) +
#         scale_y_reverse() +
#         theme_bw()
# }
