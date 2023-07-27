## ---- echo = FALSE, message = FALSE, warning = FALSE, warning = FALSE-----------------------------------------------
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


## ----eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------
## # THIS CODE IS NOT TO BE RUN
## # These packages are only used to make the slides prettier
## install.packages("remotes")
## install.packages("xaringan")
## remotes::install_github("hadley/emo")
## remotes::install_github("mitchelloharawild/icons")
## remotes::install_github("emitanaka/anicon")
## remotes::install_github("dicook/gretchenalbrecht")
## remotes::install_github("gadenbuie/countdown")


## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## install.packages("nullabor")


## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## if (!requireNamespace("BiocManager", quietly = TRUE))
##     install.packages("BiocManager")
## 
## BiocManager::install("bigPint")


## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## remotes::install_github("heike/vinference")


## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## # CRAN packages
## packages <- c("tidyr", "dplyr", "readr", "ggplot2", "stringr", "ggmap", "here", "leaflet", "lubridate",
##               "plotly", "RColorBrewer", "gridExtra", "dichromat", "conflicted", "scales", "broom",
##               "broom.mixed", "lme4", "GGally", "palmerpenguins", "corrgram", "tourr", "htmltools",
##               "ggthemes", "maps", "viridis", "nullabor", "splitstackshape", "forecast", "readxl",
##               "MASS", "datasauRus", "cranlogs", "gapminder", "shiny", "shinydashboard", "learnr",
##               "ggmosaic", "gganimate", "remotes", "mapproj")
## 
## install.packages(packages, dep=TRUE, repos = "https://cloud.r-project.org/")
## 
## # Bioconductor packages
## if (!require("BiocManager", quietly = TRUE))
##     install.packages("BiocManager")
## BiocManager::install("bigPint")
## 
## # github packages
## remotes::install_github("wmurphyrd/fiftystater")
## remotes::install_github("heike/vinference")
## remotes::install_github("hollylkirk/ochRe")
## 
## # For sharing web apps,
## # but you need adminstrator rights to your computer:
## 
## install.packages("rsconnect")

