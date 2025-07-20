# library(rmarkdown)
library(tidyverse)
library(quarto) # Requires dev version at least as recent as 07-2025
library(stringr)

# List all slides
slides <- list.files("slides", "*.qmd", full.names = T, recursive = T)

code_files <- str_replace_all(slides, "slides/", "code/") |>
  str_replace_all("\\.qmd$", ".R")

unlink(list.files("code", "^\\d-*.R", full.names = T))
purrr::map2(slides, code_files, qmd_to_r_script)

common_to_all <- c(
  list.files("data/", full.names = T),
  list.files("slides/images", full.names = T),
  list.files("slides/css", full.names = T),
  "slides/_metadata.yml"
)


# Create zip files
# Day 1
# Common files don't need to be re-downloaded each day, so just include
# them in Day 1 to save bandwidth and git storage
code <- list.files("code/", pattern = "^[01]-", full.names = T)
slides <- list.files("slides", recursive = F, full.names = T)
slides <- slides[str_detect(slides, "slides/[01]-")]
zip("SISBID_day1.zip", files = c(common_to_all, code, slides, "SISBID.Rproj"))

# Day 2
code <- list.files("code/", pattern = "^[2]-", full.names = T)
slides <- list.files("slides", recursive = T, full.names = T)
slides <- slides[str_detect(slides, "slides/2-")|str_detect(slides, "slides/html/")]
zip("SISBID_day2.zip", files = c(code, slides, "SISBID.Rproj"))

# Day 3
code <- list.files("code/", pattern = "^[3]-", full.names = T, recursive = T)
code <- c(code, list.files("code/3.3-apps/", full.names = T, recursive = T))
code <- c(code, list.files("code/3.4-theme/", full.names = T, recursive = T))
slides <- list.files("slides", recursive = T, full.names = T)
slides <- slides[str_detect(slides, "slides/3")]
slides <- c(slides, list.files("example_apps/", full.names = T, recursive = T))
zip("SISBID_day3.zip", files = c(code, slides, "SISBID.Rproj"))
