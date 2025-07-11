library(rmarkdown)
library(tidyverse)


# List all slides
slides <- list.files("slides", "*.Rmd", full.names = T, recursive = T)

# First, remove all index_files in slides
index_files_list <- list.files("slides", "index_files", recursive = T, include.dirs = T, full.names = T)
unlink(index_files_list, force = T)

default_yaml <- yaml::read_yaml(
  text = '    css: ["default", "myremark.css"]
    self_contained: false
    nature:
      ratio: "16:9"
      highlightStyle: github
      highlightLines: true
      countIncrementalSlides: false')

xaringanfn <- function(., ...)
  rmarkdown::render(., xaringan::moon_reader(css = default_yaml$css,
                                             self_contained = FALSE,
                                             nature = default_yaml$nature), ...)
safe_xaringan <- safely(xaringanfn)

# Render to html
res <- purrr::map(slides, ~safe_xaringan(.))

stopifnot(is.null(purrr::map(res, "error") %>% unlist()))


# Purl to code folder
purrr::walk(slides, function(i) {
  knitr::purl(i)
  code_file <- str_replace(i, "slides/(.*)/index.Rmd", "code/\\1.r")
  file.copy("index.R", to = code_file, overwrite = T)
  file.remove("index.R")
})


# Remove old zip files to prevent file accumulation
file.remove(list.files(".", "*.zip"))

# Create zip files
# Day 1
code <- list.files("code/", pattern = "^[01]", full.names = T)
data <- list.files("data/", ".*", full.names = T)
slides <- list.files("slides/", recursive = T, full.names = T)
slides <- slides[str_detect(slides, "slides//[01]")]
slides <- slides[!str_detect(slides, "index_cache")]
zip("SISBID_day1.zip", files = c(code, data, slides, "SISBID.Rproj"))

# Day 2
code <- list.files("code/", pattern = "^[2]", full.names = T)
data <- list.files("data/", ".*", full.names = T)
slides <- list.files("slides/", recursive = T, full.names = T)
slides <- slides[str_detect(slides, "slides//2")]
slides <- slides[!str_detect(slides, "index_cache")]
zip("SISBID_day2.zip", files = c(code, data, slides, "SISBID.Rproj"))

# Day 3
code <- list.files("code/", pattern = "^[3]", full.names = T, recursive = T)
code <- c(code, list.files("code/3.3-apps/", full.names = T, recursive = T))
code <- c(code, list.files("code/3.4-theme/", full.names = T, recursive = T))
data <- list.files("data/", ".*", full.names = T)
slides <- list.files("slides/", recursive = T, full.names = T)
slides <- slides[str_detect(slides, "slides//3")]
slides <- slides[!str_detect(slides, "index_cache")]
slides <- c(slides, list.files("example_apps/", full.names = T, recursive = T))
zip("SISBID_day3.zip", files = c(code, data, slides, "SISBID.Rproj"))
