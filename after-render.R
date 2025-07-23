#!/usr/bin/R

library(here)

readme_md = here("docs", "README.md")

if(file.exists(readme_md)) {
  file.copy(readme_md, here())
}

html_lib = here("slides", "html", "lib")
if(dir.exists(html_lib)) {
  html_lib_files = list.files(html_lib, all.files=T, full.names = T, recursive = T)
  html_lib_new = gsub(
    html_lib,
    here("docs", "slides", "html", "lib"),
    html_lib_files, fixed=T)
    dir_created <- sapply(unique(dirname(html_lib_new)), dir.create, recursive = T)
    file.copy(html_lib_files, html_lib_new, overwrite=T)
}

# Make sure r-pkg-deps.R is available
file.copy("r-pkg-deps.R", "docs/", overwrite = T)

missed_dirs <- list.dirs("slides", recursive = F)
missed_dirs <- missed_dirs[grepl("files", missed_dirs)]

file.copy(missed_dirs, to = "docs/slides", recursive = T, overwrite = T)

missed_html_files <- list.files("slides", ".html", full.names = T)
file.copy(missed_html_files, "docs", overwrite = T)

unlink(missed_dirs, recursive = T)
unlink(missed_html_files)
