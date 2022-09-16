## code to prepare `size_distributions` dataset goes here
size_distributions <- rio::import("data-raw/lab_gradations.xlsx")

usethis::use_data(size_distributions, overwrite = TRUE)
