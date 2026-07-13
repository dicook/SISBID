# CRAN packages
packages <- c(
  "here", "readr", "readxl", "splitstackshape", "tidyr", "dplyr", "lubridate",
  "stringr", "purrr", "ggplot2", "ggthemes", "RColorBrewer", "scales",
  "dichromat", "colorspace", "viridis", "ggbeeswarm", "ggmap", "gridExtra",
  "GGally", "ggpcp", "corrgram", "tourr", "gganimate", "maps","datasauRus",
  "gapminder", "cranlogs", "shiny", "bslib", "DT", "leaflet", "plotly",
  "htmltools", "broom", "broom.mixed", "lme4", "MASS", "forecast", "nullabor",
  "ggdist", "bsicons", "ragg", "showtext", "thematic", "remotes", "quarto",
  "superheat", "bslib")

# Install packages and their dependencies
to_install <- setdiff(packages, installed.packages())
install.packages(to_install, dep=TRUE, repos = "https://cloud.r-project.org/")

# Install some packages from GitHub
# If you can't install these,
# it won't affect your ability to participate
remotes::install_github("wmurphyrd/fiftystater")
remotes::install_github("heike/vinference")
remotes::install_github("rstudio/bslib")

# For sharing web apps,
# but you need administrator rights to your computer:
install.packages("rsconnect")
