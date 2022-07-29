## ---- echo = FALSE, message = FALSE, warning = FALSE, warning = FALSE--------------
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  error = FALSE, 
  collapse = TRUE,
  comment = "",
  fig.height = 8,
  fig.width = 12,
  fig.align = "center",
  cache = FALSE
)


## ----eval=FALSE, echo=FALSE--------------------------------------------------------
#> # THIS CODE IS NOT TO BE RUN
#> # These packages are only used to make the slides prettier
#> install.packages("remotes")
#> install.packages("xaringan")
#> remotes::install_github("hadley/emo")
#> remotes::install_github("mitchelloharawild/icons")
#> remotes::install_github("emitanaka/anicon")
#> remotes::install_github("dicook/gretchenalbrecht")
#> remotes::install_github("gadenbuie/countdown")


## ----eval=FALSE--------------------------------------------------------------------
#> install.packages("ggenealogy")


## ----eval=FALSE--------------------------------------------------------------------
#> if (!requireNamespace("BiocManager", quietly = TRUE))
#>     install.packages("BiocManager")
#> 
#> BiocManager::install("bigPint")


## ----eval=FALSE--------------------------------------------------------------------
#> remotes::install_github("heike/vinference")


## ----eval=FALSE--------------------------------------------------------------------
#> # CRAN packages
#> packages <- c("tidyverse", "ggmap", "RColorBrewer", "gridExtra", "dichromat",
#>               "janitor", "forcats", "ggthemes", "here", "wordcloud", "lubridate",
#>               "plotly", "broom", "GGally", "gapminder", "nullabor", "shiny",
#>               "ggenealogy", "ggmosaic", "HLMdiag",  "gganimate", "remotes",
#>               "naniar", "htmltools", "mapproj", "leaflet", "broom.mixed", "lme4")
#> 
#> install.packages(packages, dep=TRUE, repos = "https://cloud.r-project.org/")
#> 
#> # github packages
#> remotes::install_github("wmurphyrd/fiftystater")

