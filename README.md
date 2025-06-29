# MDSMClust

**Multidimensional scaling improves distance-based clustering for microbiome data**

[![DOI](https://img.shields.io/badge/DOI-10.1093/bioinformatics/btaf042-blue)](https://doi.org/10.1093/bioinformatics/btaf042)

`MDSMClust` is an R package for microbiome sample clustering based on various distance measures. It supports flexible unsupervised clustering and offers tools to assess clustering quality, particularly suited for microbiome data with sparsity and compositional constraints.

The package implements a two-step procedure: it first applies classical multidimensional scaling (MDS) to denoise and reduce the dimensionality of high-dimensional microbiome data, and then performs distance-based clustering in the low-dimensional space. This approach improves clustering performance, especially under sparse signal scenarios.

> 📄 The methods implemented in this package are described in the paper:
> **Multidimensional scaling improves distance-based clustering for microbiome data**
> *Bioinformatics (2025), Volume 41, Issue 2, btaf042*
> 
> [Read the article](https://academic.oup.com/bioinformatics/article/41/2/btaf042/7985707)



## Features

* Multidimensional Scaling (MDS) with support for distances:

  * Bray-Curtis
  * Jaccard
  * UniFrac (unweighted/weighted/generalized)
  * PhILR
  * CLR (centered log-ratio)
 
  * or fit Dirichlet Multinomial Models (DMM)

* Clustering with:

  * Gap statistic
  * Silhouette Index
  * Prediction Strength

* Evaluation of clustering accuracy using Adjusted Rand Index (ARI) with several indices supported:

  * "Rand" – Rand Index
  * "HA" – Hubert and Arabie’s Adjusted Rand Index
  * "MA" – Morey and Agresti’s Adjusted Rand Index (default)
  * "FM" – Fowlkes and Mallows Index
  * "Jaccard" – Jaccard Index



## Installation

You can install the development version of `MDSMClust` directly from GitHub or manually:

```r
############################################################
# Installation Script for MDSMClust and Required Packages
# Last Updated: 2025.06
#
# This script installs necessary packages to use MDSMClust,
# including archived CRAN packages, GitHub packages, and Bioconductor.
############################################################

# Step 1: Install the archived 'clues' package from CRAN
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/clues/clues_0.6.2.2.tar.gz",
  repos = NULL,
  type = "source"
)

# Step 2: Install 'devtools' if not already installed (for GitHub packages)
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
library(devtools)

# Step 3: Install the 'SpiecEasi' package from GitHub
install_github("zdk123/SpiecEasi")
library(SpiecEasi)

# Step 4: Install 'philr' from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("philr")

# Step 5: Install MDSMClust from GitHub (official version)
install_github("wxy929/MDS/MDSMClust")

# Step 6 (Optional): Install MDSMClust from local source (if downloaded)
# Replace "path_to_MDSMClust" with your local file path
# install.packages("path_to_MDSMClust", repos = NULL, type = "source")

# Done! You can now load MDSMClust using:
# library(MDSMClust)
```



## Example Datasets

* `Martinez`: Papua New Guinean gut microbiota data
* `Smits`: Seasonal Hadza microbiome profiles
* `DM_throat_info`, `LN_throat_info`: Simulation Source Data



## Usage

See detailed instructions [here](https://github.com/wxy929/MDS/tree/main/MDSMClust/vignettes). We provide the materials in Rmd, HTML, and PDF formats.



## Citation

If you use `MDSMClust` in your research, please cite:

Guanhua Chen, Xinyue Wang, Qiang Sun, Zheng-Zheng Tang, Multidimensional scaling improves distance-based clustering for microbiome data, Bioinformatics, Volume 41, Issue 2, February 2025, btaf042, https://doi.org/10.1093/bioinformatics/btaf042


