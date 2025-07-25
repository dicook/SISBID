## ----echo = FALSE, message = FALSE, warning = FALSE, warning = FALSE----------
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## ----load packages, echo=FALSE------------------------------------------------
#library(tidyverse)
library(ggplot2)
library(ggmap)
library(plotly)
library(gganimate)


## ----eval = F-----------------------------------------------------------------
# install.packages("flexdashboard")


## ### Chart 1

## Column {data-width=600}
## -------------------------------------

## ---
## title: "TB Incidence Around the Globe"
## author: "Di Cook"
## output: learnr::tutorial
## runtime: shiny_prerendered
## ---

## ## Data description
## 
## This is current tuberculosis data taken from [WHO](http://www.who.int/tb/country/data/download/en/),
## the case notifications table. The data looks like this:

## ----eval=F, echo = T---------------------------------------------------------
# library(tidyverse)
# library(DT)
# tb <- read_csv(here::here("data/TB_burden_countries_2025-07-22.csv")) |>
#   select(country, iso3, year, e_inc_100k)
# 
# datatable(tb)


## ----eval=F-------------------------------------------------------------------
# ggplot(tb, aes(x=year)) +
#   geom_bar(aes(weight = e_inc_100k)) +
#   xlab("") +
#   ylab("TB incidence per 100k")


## ----eval = F-----------------------------------------------------------------
# library(learnr)
# knitr::opts_chunk$set(
#   echo = FALSE,
#   message = FALSE,
#   warning = FALSE,
#   error = FALSE)


## ----eval = F-----------------------------------------------------------------
# quiz(
#   question("Which package contains functions for installing other R packages?",
#     answer("base"),
#     answer("tools"),
#     answer("utils", correct = TRUE),
#     answer("codetools")
#   )
# )


## ----eval=F-------------------------------------------------------------------
# library(plotly)
# library(plotly)
# p <- tb |>
#   filter(iso3 %in% c("AUS", "USA", "CAN", "KEN", "IND", "COL", "ASM")) |>
#   ggplot() +
#     geom_point(aes(x=iso3, y=e_inc_100k, frame=year))
# ggplotly(p)


## ----eval=F-------------------------------------------------------------------
# set.seed(20190709)
# emo::ji("fantasy")
# emo::ji("clock")


## ----eval=F-------------------------------------------------------------------
# anicon::nia("You've got 30 seconds!", colour="#FA700A", anitype="hover")
# anicon::faa("hand-paper", animate="spin", grow=20, color="#B78ED2",
#   position=c(0,0,0,200))

