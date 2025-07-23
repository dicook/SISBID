## ----echo = FALSE, message = FALSE, warning = FALSE, warning = FALSE----
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## ----load packages, echo=FALSE-----------------------------------------
#library(tidyverse)
library(ggplot2)
library(ggmap)
library(plotly)
library(gganimate)


## ----eval = F----------------------------------------------------------
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

## ----eval=F, echo = T--------------------------------------------------
# library(tidyverse)
# library(DT)
# tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>%
#   select(country, iso3, year, new_sp_m04:new_sp_fu) %>%
#   pivot_longer(cols=new_sp_m04:new_sp_fu, names_to="sexage", values_to="count") %>%
#   mutate(sexage = str_replace(sexage, "new_sp_", "")) %>%
#   mutate(sex=substr(sexage, 1, 1),
#          age=substr(sexage, 2, length(sexage))) %>%
#   select(-sexage)  %>%
#   filter(country == "United States of America") %>%
#   filter(!(age %in% c("04", "014", "514", "u"))) %>%
#   filter(year > 1996, year < 2013)
# 
# datatable(tb)


## ----eval=F------------------------------------------------------------
# ggplot(tb, aes(x=year)) +
#   geom_bar(aes(weight = count))


## ----eval = F----------------------------------------------------------
# library(learnr)
# knitr::opts_chunk$set(
#   echo = FALSE,
#   message = FALSE,
#   warning = FALSE,
#   error = FALSE)


## ----eval = F----------------------------------------------------------
# quiz(
#   question("Which package contains functions for installing other R packages?",
#     answer("base"),
#     answer("tools"),
#     answer("utils", correct = TRUE),
#     answer("codetools")
#   )
# )


## ----eval=F------------------------------------------------------------
# library(plotly)
# p <- tb %>%
#   group_by(year, age) %>%
#   summarise(p_males = count[sex=="m"]/sum(count)) %>%
#   ggplot() +
#     geom_point(aes(x=age, y=p_males, frame=year))
# ggplotly(p)


## ----eval=F------------------------------------------------------------
# set.seed(20190709)
# emo::ji("fantasy")
# emo::ji("clock")


## ----eval=F------------------------------------------------------------
# anicon::nia("You've got 30 seconds!", colour="#FA700A", anitype="hover")
# anicon::faa("hand-paper", animate="spin", grow=20, color="#B78ED2",
#   position=c(0,0,0,200))

