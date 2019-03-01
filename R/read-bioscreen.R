#' @export
read_bioscreen <- function(path) {
    d <- readr::read_csv(path, col_types = readr::cols(
        .default = readr::col_double(),
        Time = readr::col_character()
    ))
    d <- dplyr::group_by(d, Time)
    d <- tidyr::gather(d, 'well', 'measure', -Time)
    dplyr::ungroup(d)
}

#' @export
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
