#' Martinez Data
#'
#' Martinez data is a data set from the R package "MicrobiomeCluster" including OTU table,
#' tree and sample geographic information.
#'
#' @docType data
#'
#' @usage data(Martinez)
#'
#' @format A large list with 3 components which are tree, sampleinfo and otutable.
#'
#' @keywords datasets
#'
#' @references Martinez, I., Stegen, J. C., Maldonado-Gomez, M. X., Eren, A. M., Siba, P. M., Green- hill, A. R., and Walter, J. (2015). The gut microbiota of rural Papua New Guineans: composition, diversity patterns, and ecological processes. Cell reports, 11(4):527-538.
#'
#' @examples
#' data(Martinez)
#' table(Martinez$sampleinfo)
#'
"Martinez"
