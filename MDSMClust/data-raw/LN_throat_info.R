## code to prepare `Logistic_normal_throat_logitnorminfo` dataset goes here

# rm(list = ls())

# retrieve paths to datafiles
filename = system.file(
  "extdata",
  "LN_throat_info.RData",
  package = "MDS for Microbiome Clustering"
)

# read the file
load(file = filename)

usethis::use_data(LN_throat_info, overwrite = TRUE)
