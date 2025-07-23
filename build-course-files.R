#!/usr/bin/R

# library(rmarkdown)
library(tidyverse)
library(quarto) # Requires dev version at least as recent as 07-2025
library(stringr)
library(here)

# List all slides
slides <- list.files("slides", "*.qmd", full.names = T, recursive = T)

code_files <- str_replace_all(slides, "slides/", "code/") |>
  str_replace_all("\\.qmd$", ".R")

update <- file.mtime(slides) > file.mtime(code_files)
if (any(update)) {
  unlink(code_files[update])
  purrr::walk2(slides[update], code_files[update], qmd_to_r_script)
}

misc_code <- setdiff(list.files("code", ".[Rr]", full.names = T, recursive=F),
                     code_files)
common_to_all <- c(
  list.files("data", full.names = T),
  list.files("slides/images", full.names = T),
  list.files("slides/css", full.names = T),
  misc_code,
  "slides/_metadata.yml",
  "SISBID.Rproj"
)
# Exclude genetics files -- too big
common_to_all <- common_to_all[!str_detect(common_to_all, "PANCAN")]
# Exclude video files
common_to_all <- common_to_all[!str_detect(common_to_all, "shiny-app-start-2025")]

# Create zip files
# Day 1
# Common files don't need to be re-downloaded each day, so just include
# them in Day 1 to save bandwidth and git storage
day1code <- list.files("code/", pattern = "^[01]-", full.names = T)
day1slides <- list.files("slides", recursive = F, full.names = T)
day1slides <- day1slides[str_detect(day1slides, "slides/[01]-")]
day1files <- c(common_to_all, day1code, day1slides)
day1zip <- "SISBID_day1.zip"
if(any(file.mtime(day1files) > file.mtime(day1zip))) {
  unlink(day1zip)
  zip(day1zip, files = day1files)
}

# Day 2
day2code <- list.files("code/", pattern = "^[2]-", full.names = T)
day2slides <- list.files("slides", recursive = T, full.names = T)
day2slides <- day2slides[str_detect(day2slides, "slides/2-")|
                           str_detect(day2slides, "slides/html/")]
day2files <- c(day2code, day2slides, "SISBID.Rproj")
day2zip <- "SISBID_day2.zip"
if(any(file.mtime(day2files) > file.mtime(day2zip))) {
  unlink(day2zip)
  zip(day2zip, files = day2files)
}

# Day 3
day3code <- list.files("code/", pattern = "^[3]-", full.names = T, recursive = T)
day3code <- c(day3code, list.files("code/3.3-apps/", full.names = T, recursive = T))
day3code <- c(day3code, list.files("code/3.4-theme/", full.names = T, recursive = T))
day3slides <- list.files("slides", recursive = T, full.names = T)
day3slides <- day3slides[str_detect(day3slides, "slides/3")]
day3slides <- c(day3slides, list.files("example_apps/", full.names = T, recursive = T))
day3files <- c(day3code, day3slides, "SISBID.Rproj")
day3zip <- "SISBID_day3.zip"
if(any(file.mtime(day3files) > file.mtime(day3zip))) {
  unlink(day3zip)
  zip(day3zip, files = day3files)
}
