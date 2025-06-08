# MDSMClust

**Multidimensional scaling improves distance-based clustering for microbiome data**

[![DOI](https://img.shields.io/badge/DOI-10.1093/bioinformatics/btaf042-blue)](https://doi.org/10.1093/bioinformatics/btaf042)

`MDSMClust` is an R package designed to perform microbiome sample clustering using classical multidimensional scaling (MDS) combined with various ecological and compositional distances. It provides flexible support for both unsupervised clustering and validation of clustering quality, particularly in microbiome data characterized by sparsity and compositionality.

> 📄 The methods implemented in this package are described in the paper:
> **Multidimensional scaling improves distance-based clustering for microbiome data**
> *Bioinformatics (2025), Volume 41, Issue 2, btaf042*
> [Read the article](https://academic.oup.com/bioinformatics/article/41/2/btaf042/7985707)

---

## Features

* Multidimensional Scaling (MDS) with support for:

  * Bray-Curtis
  * Jaccard
  * UniFrac (unweighted/weighted/generalized)
  * PhILR
  * CLR (centered log-ratio)

* Clustering with:

  * Gap statistic
  * Silhouette Index
  * Prediction Strength

* Evaluation of clustering accuracy using:

  * Adjusted Rand Index (ARI)
  * Multiple external indices (MA, HA, FM, Jaccard, etc.)

* Comparison with Dirichlet Multinomial Models (DMM)

---

## Installation

You can install the development version of `MDSMClust` directly from GitHub or manually:

```r
# Install devtools if not already installed
install.packages("devtools")

# Install MDSMClust from GitHub
devtools::install_github("wxy929/MDSMClust")

# Install MDSMClust from source
# (Assuming you've downloaded or cloned the package repo)
install.packages("path_to_MDSMClust", repos = NULL, type = "source")
```

---

## Example Datasets

* `Martinez`: Papua New Guinean gut microbiota data
* `Smits`: Seasonal Hadza microbiome profiles
* `DM_throat_info`, `LN_throat_info`: Simulated templates for evaluation

---

## Citation

If you use `MDSMClust` in your research, please cite:

Guanhua Chen, Xinyue Wang, Qiang Sun, Zheng-Zheng Tang, Multidimensional scaling improves distance-based clustering for microbiome data, Bioinformatics, Volume 41, Issue 2, February 2025, btaf042, https://doi.org/10.1093/bioinformatics/btaf042

---
