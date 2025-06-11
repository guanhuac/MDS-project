## code to prepare `Smits` dataset goes here

rm(list = ls())

# retrieve paths to datafiles
filename = system.file(
  "extdata",
  "Smits.RData",
  package = "MDSMClust"
)

# read the file
load(file = filename)

usethis::use_data(Smits, overwrite = TRUE)
