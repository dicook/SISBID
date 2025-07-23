#' ---
#' title: Preamble
#' ---
#' 


knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  error = FALSE, 
  collapse = TRUE,
  comment = "",
  fig.height = 8,
  fig.width = 12,
  fig.align = "center",
  cache = FALSE,
  echo=TRUE
)


# THIS CODE IS NOT TO BE RUN
# These packages are only used to make the slides prettier
install.packages("remotes")
remotes::install_github("hadley/emo")
remotes::install_github("mitchelloharawild/icons")
remotes::install_github("emitanaka/anicon")
remotes::install_github("dicook/gretchenalbrecht")
remotes::install_github("gadenbuie/countdown")


install.packages("nullabor")


if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("bigPint")


remotes::install_github("wmurphyrd/fiftystater")

