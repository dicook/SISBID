#' ---
#' title: Building interactive documents with Rmarkdown tools, learnr, flexdashboard
#' ---
#' 


source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


#library(tidyverse)
library(ggplot2)
library(ggmap)
library(plotly)
library(gganimate)


install.packages("flexdashboard")


library(tidyverse)
library(DT)
tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>% 
  select(country, iso3, year, new_sp_m04:new_sp_fu) %>%
  pivot_longer(cols=new_sp_m04:new_sp_fu, names_to="sexage", values_to="count") %>%
  mutate(sexage = str_replace(sexage, "new_sp_", "")) %>%
  mutate(sex=substr(sexage, 1, 1), 
         age=substr(sexage, 2, length(sexage))) %>%
  select(-sexage)  %>%
  filter(country == "United States of America") %>%
  filter(!(age %in% c("04", "014", "514", "u"))) %>%
  filter(year > 1996, year < 2013) 

datatable(tb)


ggplot(tb, aes(x=year)) +
  geom_bar(aes(weight = count)) 


library(learnr)
knitr::opts_chunk$set(
  echo = FALSE,
  message = FALSE, 
  warning = FALSE,
  error = FALSE)


quiz(
  question("Which package contains functions for installing other R packages?",
    answer("base"),
    answer("tools"),
    answer("utils", correct = TRUE),
    answer("codetools")
  )
)

