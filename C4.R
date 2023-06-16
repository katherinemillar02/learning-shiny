# loading the packages in 
library(shiny)
library(vroom)
library(tidyverse)

# get data on your own computer 
dir.create("neiss")
#> Warning in dir.create("neiss"): 'neiss' already exists
download <- function(name) {
  url <- "https://github.com/hadley/mastering-shiny/raw/master/neiss/"
  download.file(paste0(url, name), paste0("neiss/", name), quiet = TRUE)
}
download("neiss/injuries.tsv.gz")
download("population.tsv")
download("products.tsv")


# leave this chapter for now until you can work the data? 