#library(tidyverse)
library(rmarkdown) # to be able to knit a document
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(ggmap)
library(here)
library(lubridate)
library(stringr)
library(ggbeeswarm)
library(leaflet)
library(plotly)
library(RColorBrewer)
library(gridExtra)
library(scales)
library(dichromat)
library(broom)
library(broom.mixed)
library(lme4)
library(ggpcp)
library(colorspace)
library(corrgram)
library(GGally)
library(htmltools)
library(tourr)
library(viridis)
library(nullabor)
library(forecast)
library(readxl)
library(ggthemes)
library(maps)
library(splitstackshape)
library(MASS)
library(gganimate)
library(datasauRus)
library(gapminder)
library(cranlogs)
library(shiny)
library(bslib)
library(DT)

library(remotes)
# remotes::install_github("wmurphyrd/fiftystater")
library(fiftystater)
# remotes::install_github("heike/vinference")
library(vinference)

# For slides
library(xaringan)
library(xaringanExtra)
xaringanExtra::use_xaringan_extra(
  include = c("panelset")
)

library(conflicted)
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::slice)
conflicts_prefer(dplyr::rename)
conflicts_prefer(palmerpenguins::penguins)

# Better formatted penguins data
stdd <- function(x) (x-mean(x))/sd(x)
penguins_std <- penguins |>
  filter(!is.na(bill_len)) |>
  rename(bl = bill_len,
         bd = bill_dep,
         fl = flipper_len,
         bm = body_mass) |>
  mutate_at(vars(bl:bm), stdd) |>
  select(species, bl:bm)
