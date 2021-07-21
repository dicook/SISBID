library(rmarkdown)
library(tidyverse)


# List all slides
slides <- list.files("slides", "*.Rmd", full.names = T, recursive = T)

# Render to html
purrr::walk(slides, rmarkdown::render)

# Purl to code folder
purrr::walk(slides, function(i) {
  knitr::purl(i)
  file.copy(i, str_replace(i, "slides/(.*)/index.Rmd", "code/\\1.r"))
  #file.unlink("index.R")
})
file.remove("index.R")


# Create zip files
# Day 1
code <- list.files("code/", pattern = "^[01]", full.names = T)
data <- list.files("data/", ".*", full.names = T)
slides <- list.files("slides/", recursive = T, full.names = T)
slides <- slides[str_detect(slides, "slides//[01]")]
slides <- slides[!str_detect(slides, "lib|index_files")]
zip("SISBID_day1.zip", files = c(code, data, slides, "SISBID.Rproj"))

# Day 2
code <- list.files("code/", pattern = "^[2]", full.names = T)
data <- list.files("data/", ".*", full.names = T)
slides <- list.files("slides/", recursive = T, full.names = T)
slides <- slides[str_detect(slides, "slides//2")]
slides <- slides[!str_detect(slides, "lib|index_files")]
zip("SISBID_day2.zip", files = c(code, data, slides, "SISBID.Rproj"))

# Day 3
code <- list.files("code/", pattern = "^[3]", full.names = T, recursive = T)
data <- list.files("data/", ".*", full.names = T)
slides <- list.files("slides/", recursive = T, full.names = T)
slides <- slides[str_detect(slides, "slides//3")]
slides <- slides[!str_detect(slides, "lib|index_files")]
slides <- c(slides, list.files("example_apps/", full.names = T, recursive = T))
zip("SISBID_day3.zip", files = c(code, data, slides, "SISBID.Rproj"))
