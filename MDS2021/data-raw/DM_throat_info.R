## code to prepare `DM_throat_info` dataset goes here

# rm(list = ls())

# retrieve paths to datafiles
filename = system.file(
  "extdata",
  "DM_throat_info.RData",
  package = "MDS2021"
)

# read the file
load(file = filename)

usethis::use_data(DM_throat_info, overwrite = TRUE)
