## -----------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## -----------------------------------------------------------------------------------------
#| label: load packages
#| echo: false
#library(tidyverse)
library(ggplot2)
library(ggmap)
library(plotly)
library(gganimate)


## -----------------------------------------------------------------------------------------
#| eval: false
# install.packages("flexdashboard")


### Chart 1

Column {data-width=600}
-------------------------------------

---
title: "TB Incidence Around the Globe"
author: "Di Cook"
output: learnr::tutorial
runtime: shiny_prerendered
---

## Data description

This is current tuberculosis data taken from [WHO](http://www.who.int/tb/country/data/download/en/), 
the case notifications table. The data looks like this:

## -----------------------------------------------------------------------------------------
#| eval: false
#| echo: true
# library(tidyverse)
# library(DT)
# tb <- read_csv(here::here("data/TB_burden_countries_2025-07-22.csv")) |>
#   select(country, iso3, year, e_inc_100k)
# 
# datatable(tb)


## -----------------------------------------------------------------------------------------
#| eval: false
# ggplot(tb, aes(x=year)) +
#   geom_bar(aes(weight = e_inc_100k)) +
#   xlab("") +
#   ylab("TB incidence per 100k")


## -----------------------------------------------------------------------------------------
#| eval: false
# library(learnr)
# knitr::opts_chunk$set(
#   echo = FALSE,
#   message = FALSE,
#   warning = FALSE,
#   error = FALSE)


## -----------------------------------------------------------------------------------------
#| eval: false
# quiz(
#   question("Which package contains functions for installing other R packages?",
#     answer("base"),
#     answer("tools"),
#     answer("utils", correct = TRUE),
#     answer("codetools")
#   )
# )


## -----------------------------------------------------------------------------------------
#| eval: false
# library(plotly)
# p <- tb |>
#   filter(iso3 %in% c("AUS", "USA", "CAN", "KEN", "IND", "COL", "ASM")) |>
#   ggplot() +
#     geom_point(aes(x=iso3, y=e_inc_100k, frame=year))
# ggplotly(p)


## -----------------------------------------------------------------------------------------
#| eval: false
# set.seed(20190709)
# emo::ji("fantasy")
# emo::ji("clock")


## -----------------------------------------------------------------------------------------
#| eval: false
# anicon::nia("You've got 30 seconds!", colour="#FA700A", anitype="hover")
# anicon::faa("hand-paper", animate="spin", grow=20, color="#B78ED2",
#   position=c(0,0,0,200))

