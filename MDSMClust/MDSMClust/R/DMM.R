#' Fit Dirichlet Multinomial Models to count Data and Evaluate the Result with Adjusted ARI
#'
#' This function fits Dirichlet Multinomial Models (DMM) to a count matrix and then calculate agreement indices between any
#' two partitions for the data set.
#'
#' @usage DMM(otu.count, k, group, randMethod = "MA",
#'     seed = 2021, trim = FALSE, threshold)
#'
#' @param otu.count OTUs with count numbers or a data matrix. The samples are the rows.
#' @param k an integer or a numeric vector. Specify the numbers of Dirichlet components to fit.
#' @param group a numeric vector of class labels. The length of group should be the same as the number of samples.
#' @param randMethod specifies the preferred external index to measure the agreement between the clustering result and the given group.
#' Available indices are:  "Rand", "HA" (Hubert and Arabie's adjusted Rand index), "MA" (Morey and Agresti's adjusted Rand index), "FM" (Fowlkes and Mallows's index), "Jaccard" (Jaccard index).
#' By default, "MA" will be output.
#' @param seed set.seed with the given number. By default, set.seed(2021).
#' @param trim logical. By default, it's FALSE. If TRUE, please indicate the threshold.
#' @param threshold trim the matrix with otu.count\[ , which(colSums(otu.count) > threshold)\].
#'
#' @keywords DMM, ARI
#'
#' @return A list of 3 containing k (the numbers of Dirichlet components), ARI (the corresponding adjusted
#' Rand Indices) and cluster (the clustering results).
#'
#' @export
#'
#' @examples
#' data(Martinez)
#' tree = Martinez$tree
#' otu.table = Martinez$otutable
#' otu.count = t(otu.table)
#' DMM(otu.count, group = as.numeric(as.factor(Martinez$sampleinfo)),
#' k = c(2,3,5), trim = TRUE, threshold = 5)

DMM = function(otu.count, k, group, randMethod = "MA", seed = 2021, trim = FALSE, threshold){
  if (!requireNamespace("DirichletMultinomial", quietly = TRUE)){
    BiocManager::install("DirichletMultinomial")
  }
  if (!requireNamespace("clues", quietly = TRUE)){
    install.packages("clues")
  }
  suppressMessages(library("DirichletMultinomial"))
  suppressMessages(library("clues"))

  set.seed(seed)

  if(trim){
    otu.count = otu.count[, which(colSums(otu.count) > threshold)]
  }

  if(randMethod == "Rand"){
    index = 1
  }else if(randMethod == "HA"){
    index = 2
  }else if(randMethod == "MA"){
    index = 3
  }else if(randMethod == "FM"){
    index = 4
  }else if(randMethod == "Jaccard"){
    index = 5
  }else{
    print("Wrong randMethod specified!")
  }

  dmm.member = list()
  out = c()
  p = 0
  for(i in k){
    p = p + 1
    dmm_clusters = dmn(count = otu.count, k = i, verbose = TRUE)
    dmm.member[[p]] = as.numeric(apply(dmm_clusters@group, 1, which.max))
    out[p] = adjustedRand(dmm.member[[p]], group)[index]
  }
  names(dmm.member) = paste0("k=", k)

  return(list(k = k, ARI = out, cluster = dmm.member))
}
