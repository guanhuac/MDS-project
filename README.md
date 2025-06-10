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
# Install devtools if not already installed
install.packages("devtools")

# Install MDSMClust from GitHub
devtools::install_github("wxy929/MDS/MDSMClust")

# Install MDSMClust from source
# (Assuming you've downloaded or cloned the package repo)
install.packages("path_to_MDSMClust", repos = NULL, type = "source")
```



## Example Datasets

* `Martinez`: Papua New Guinean gut microbiota data
* `Smits`: Seasonal Hadza microbiome profiles
* `DM_throat_info`, `LN_throat_info`: Simulation Source Data



## Usage

See detailed instructions [here]().



## Citation

If you use `MDSMClust` in your research, please cite:

Guanhua Chen, Xinyue Wang, Qiang Sun, Zheng-Zheng Tang, Multidimensional scaling improves distance-based clustering for microbiome data, Bioinformatics, Volume 41, Issue 2, February 2025, btaf042, https://doi.org/10.1093/bioinformatics/btaf042


