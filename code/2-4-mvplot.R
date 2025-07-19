#' ---
#' title: Multivariate data plots
#' ---
#' 


knitr::opts_chunk$set(
  echo=TRUE, 
  message = FALSE,
  warning = FALSE,
  error = FALSE,
  collapse = TRUE,
  comment = "",
  fig.height = 4,
  fig.width = 8,
  fig.align = "center",
  fig.retina = 3,
  cache = FALSE
)


#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(GGally)
library(tourr)
library(broom)
library(plotly)
library(palmerpenguins)


countdown::countdown(1,0)


# Make a simple scatterplot matrix of the new penguins data
penguins <- penguins %>% filter(!is.na(bill_length_mm)) 
ggpairs(penguins, columns=c(3:6))




# Re-make mapping colour to species (class)
ggpairs(penguins, columns=c(3:6), 
        ggplot2::aes(colour=species))




# Look at one species only
adelie <- penguins %>% 
  filter(species == "Adelie") %>%
  select(bill_length_mm:body_mass_g)
ggcorr(adelie)



