# CRAN packages
packages <- c(
  "here", "readr", "readxl", "splitstackshape", "tidyr", "dplyr", "lubridate",
  "stringr", "purrr", "ggplot2", "ggthemes", "RColorBrewer", "scales",
  "dichromat", "colorspace", "viridis", "ggbeeswarm", "ggmap", "gridExtra",
  "GGally", "ggpcp", "corrgram", "tourr", "gganimate", "maps","datasauRus",
  "gapminder", "cranlogs", "shiny", "bslib", "DT", "leaflet", "plotly",
  "htmltools", "broom", "broom.mixed", "lme4", "MASS", "forecast", "nullabor",
  "ggdist")

# Install packages and their dependencies
install.packages(packages, dep=TRUE, repos = "https://cloud.r-project.org/")

# Install some packages from GitHub
remotes::install_github("wmurphyrd/fiftystater")
remotes::install_github("heike/vinference")

# For sharing web apps,
# but you need adminstrator rights to your computer:

install.packages("rsconnect")
