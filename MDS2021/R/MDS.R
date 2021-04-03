#' Cluster OTU Data and Evaluate the Result with Adjusted ARI
#'
#' This function can conduct classical multidimensional scaling (MDS) with
#' seven different distances and then calculate agreement indices between any
#' two partitions for a data set.
#'
#' @usage MDS(otu.count, distance, tree, mdsrank, k, est, threshold = 0.9,
#'            K.max, group, randMethod = "MA", seed = 2021)
#'
#' @param otu.count OTUs with count numbers or a data matrix. The samples are the rows.
#' @param distance character string specifying the distance to be used for calculating dissimilarities between observations.
#' The currently available options are "bray", "jaccard", "unweighted UniFrac",
#' "weighted UniFrac", "generalized UniFrac", "PhILR" and "clr" which are corresponding to Bray-Curtis distance, Jaccard Index,
#' unweighted, weighted, generalized UniFrac, Euclidean after Phylogenetic ILR (PhILR) transformation and center logratio (CLR) transformation.
#' @param tree specifies the corresponding tree if choose "unweighted UniFrac", "weighted UniFrac", "generalized UniFrac" or "PhILR" as the distance.
#' @param mdsrank the maximum dimension of the space which the data are to be represented in when conduct the MDS; must be less than or equal to n-1.
#' @param k true number of the clusters. If not specified, please choose one of the three methods using parameter "est" to estimate the number.
#' @param est specifies the preferred methods to estimate the number of clusters. Available choices are "gap" (Gap statistic), "ps" (Prediction Strength), "si" (Silhouette Index).
#' @param threshold the threshold for prediction strength method mentioned in "est" taking value from 0 to 1. By default, it's 0.9. In practice, 0.8 or a higher one is preferred.
#' @param K.max integer. Specify the maximum number of clusters if use some methods to estimate k.
#' @param group a numeric vector of class labels. The length of group should be the same as the number of samples.
#' @param randMethod specifies the preferred external index to measure the agreement between the clustering result and the given group.
#' Available indices are:  "Rand", "HA" (Hubert and Arabie's adjusted Rand index), "MA" (Morey and Agresti's adjusted Rand index), "FM" (Fowlkes and Mallows's index), "Jaccard" (Jaccard index).
#' By default, "MA" will be output.
#' @param seed set.seed with the given number. By default, set.seed(2021).
#'
#' @keywords MDS, ARI
#'
#' @return A list of 3 containing bestk (the best number of clusters), ARI (the corresponding adjusted
#' Rand Index) and cluster (the clustering results).
#'
#' @export
#'
#' @examples
#' data(Martinez)
#' tree = Martinez$tree
#' otu.table = Martinez$otutable
#' otu.count = t(otu.table)
#' MDS(otu.count, distance = "bray", mdsrank = 5, est = "gap", K.max = 16,
#' group = as.numeric(as.factor(Martinez$sampleinfo)), randMethod = "MA")

MDS = function(otu.count, distance, tree, mdsrank, k = c(), est, threshold = 0.9, K.max, group, randMethod = "MA", seed = 2021){
  if (!requireNamespace("SpiecEasi", quietly = TRUE)){
    install_github("zdk123/SpiecEasi")
  }
  if (!requireNamespace("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")
  }
  if (!requireNamespace("philr", quietly = TRUE)){
    BiocManager::install("philr")
  }
  if (!requireNamespace("fpc", quietly = TRUE)){
    install.packages("fpc")
  }
  if (!requireNamespace("MiSPU", quietly = TRUE)){
    install.packages("MiSPU")
  }
  if (!requireNamespace("GUniFrac", quietly = TRUE)){
    install.packages("GUniFrac")
  }
  if (!requireNamespace("miProfile", quietly = TRUE)){
    print("Please install package miProfile.")
  }
  if (!requireNamespace("dirmult", quietly = TRUE)){
    install.packages("dirmult")
  }
  if (!requireNamespace("cluster", quietly = TRUE)){
    install.packages("cluster")
  }
  if (!requireNamespace("clues", quietly = TRUE)){
    install.packages("clues")
  }
  if (!requireNamespace("DirichletMultinomial", quietly = TRUE)){
    BiocManager::install("DirichletMultinomial")
  }
  if (!requireNamespace("MASS", quietly = TRUE)){
    install.packages("MASS")
  }
  if (!requireNamespace("vegan", quietly = TRUE)){
    install.packages("vegan")
  }
  if (!requireNamespace("reshape2", quietly = TRUE)){
    install.packages("reshape2")
  }

  library("SpiecEasi")
  library("philr")
  library("fpc")
  library("MiSPU")
  library("GUniFrac")
  library("miProfile")
  library("dirmult")
  library("cluster")
  library("clues")
  library("DirichletMultinomial")
  library("MASS")
  library("vegan")
  library("reshape2")

  set.seed(seed)

  otu.prop = otu.count/rowSums(otu.count)

  if(distance == "bray"){
    d = vegdist(otu.prop, method = "bray")
  }else if(distance == "jaccard"){
    d = vegdist(otu.prop, method = "jaccard")
  }else if(distance == "unweighted UniFrac"){
    a = MiSPU::GUniFrac(otu.count, tree, alpha = c(0,0.5,1))
    d = as.dist(a$d0)
  }else if(distance == "weighted UniFrac"){
    a = MiSPU::GUniFrac(otu.count, tree, alpha = c(0,0.5,1))
    d = as.dist(a$dw)
  }else if(distance == "generalized UniFrac"){
    a = MiSPU::GUniFrac(otu.count, tree, alpha = c(0,0.5,1))
    d = as.dist(a$d5)
  }else if(distance == "PhILR"){
    PhILR = philr(otu.count+1, tree, part.weights = "enorm.x.gm.counts", ilr.weights = "blw.sqrt")
    d = dist(PhILR, method = "euclidean")
  }else if(distance == "clr"){
    CLR = SpiecEasi::clr(otu.count+0.5)
    d = dist(CLR, method = "euclidean")
  }else{
    print("This distance is not available now.")
  }

  mds_d = cmdscale(d, k = mdsrank)

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

  if(is.numeric(k)){
    truek = k
  }else{
    if(est == "gap"){
      gs = clusGap(mds_d, FUN = pam, K.max = K.max, B = 50)
      truek = maxSE(gs$Tab[, "gap"], gs$Tab[, "SE.sim"])
    }else if(est == "ps"){
      gs = prediction.strength(mds_d, 2, K.max, clustermethod=pamkCBI, cutoff=threshold, M=10)
      truek = gs$optimalk
      numk = which(gs$mean.pred > gs$cutoff)
      if(length(numk)>1){truek = which.max(gs$mean.pred[-1]) + 1}
    }else if(est == "si"){
      final = 0
      best = 1
      clusters_dd = list(clustering = c())
      for(i in 1:K.max){
        truek = i
        clusters_d = pam(mds_d, k = truek)
        temp = ifelse(length(clusters_d$silinfo$avg.width)==0, 0, clusters_d$silinfo$avg.width)
        out1 = adjustedRand(clusters_d$cluster, group)[index]
        if(temp>final){
          best = truek
          final = temp
          out = out1
          clusters_dd = clusters_d
        }
      }
      truek = best
      return(list(bestk = truek, ARI = out, cluster = clusters_dd$clustering))
    }else{
      print("Need to specify the method to estimate the number of clusters.")
    }
  }

  clusters_dd = pam(mds_d, k = truek)
  out = adjustedRand(clusters_dd$clustering, group)[index]
  return(list(bestk = truek, ARI = out, cluster = clusters_dd$cluster))
}
