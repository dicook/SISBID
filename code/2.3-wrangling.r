## ---- echo = FALSE---------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  collapse = TRUE,
  comment = "",
  fig.height = 4,
  fig.width = 8,
  fig.align = "center",
  cache = FALSE
)


## ----load packages, echo = FALSE-------------------------------------------------------------------------------------
#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(broom)
library(broom.mixed)
library(lme4)


## ----setting up, echo=FALSE------------------------------------------------------------------------------------------
load(here::here("data/french_fries.rda"))


## ----models and model output-----------------------------------------------------------------------------------------

ff_long <- french_fries %>% pivot_longer(potato:painty, names_to = "type", values_to = "rating")
ff_lm <- lm(rating~type+treatment+time+subject, 
data=ff_long)


## ----examine the model fit-------------------------------------------------------------------------------------------
summary(ff_lm)


## ----goodness of fit statistics--------------------------------------------------------------------------------------
glance(ff_lm)


## ----model estimates-------------------------------------------------------------------------------------------------
ff_lm_tidy <- tidy(ff_lm)
glimpse(ff_lm_tidy)


## ----model diagnostics-----------------------------------------------------------------------------------------------
ff_lm_all <- augment(ff_lm)
glimpse(ff_lm_all)


## ----residual plot---------------------------------------------------------------------------------------------------
ggplot(ff_lm_all, aes(x=.fitted, y=.resid)) + geom_point()


## ----add random intercepts for each subject, results='hide'----------------------------------------------------------
library(lme4)
fries_lmer <- lmer(rating~type+treatment+time+subject + ( 1 | subject ), 
data = ff_long)


## ----solution to french fries modeling, eval=FALSE, echo=FALSE-------------------------------------------------------
## ## the model is pretty bad:
## glance(fries_lmer)
## tidy(fries_lmer)
## 
## ff_lmer_all <- augment(fries_lmer)
## 
## ggplot(ff_lmer_all, aes(x=.fitted, y=.resid)) + geom_point() +
##   coord_equal()
## 
## ggplot(ff_lmer_all, aes(x=.fitted, y=rating)) + geom_point() +
##   coord_equal()


## ----select a subset of the observations-----------------------------------------------------------------------------
load(here::here("data/french_fries.rda"))
french_fries %>%
    filter(subject == 3, time == 1)


## ----order the observations------------------------------------------------------------------------------------------
french_fries %>%
    arrange(desc(rancid)) %>%
    head


## ----select a subset of the variables--------------------------------------------------------------------------------
french_fries %>%
    select(time, treatment, subject, rep, potato) %>%
    head


## ----summarize observations into one-number statistic----------------------------------------------------------------
french_fries %>%
    summarise(mean_rancid = mean(rancid, na.rm=TRUE), 
              sd_rancid = sd(rancid, na.rm = TRUE))


## ----summarise and group_by------------------------------------------------------------------------------------------
french_fries %>%
    group_by(time, treatment) %>%
    summarise(mean_rancid = mean(rancid), sd_rancid = sd(rancid))


## ----checking design completeness------------------------------------------------------------------------------------
french_fries %>% 
  group_by(subject) %>% 
  summarize(n = n()) 


## ----counts for subject by time--------------------------------------------------------------------------------------
french_fries %>% 
  na.omit() %>%
  count(subject, time) %>%
  spread(time, n)


## ----do-scores-change-over-time, fig.show='hide'---------------------------------------------------------------------
ggplot(data=ff_long, aes(x=time, y=rating, colour=treatment)) +
  geom_point() +
  facet_grid(subject~type) 


## ----ref.label="do-scores-change-over-time", echo=FALSE, fig.width=12, fig.height=9, out.width="80%"-----------------


## ----echo=FALSE, fig.width=12, fig.height=9, out.width="60%"---------------------------------------------------------
ff_av <- ff_long %>% 
  group_by(subject, time, type, treatment) %>%
  summarise(rating=mean(rating))

ggplot(data=ff_long, aes(x=time, y=rating, colour=treatment)) + 
  facet_grid(subject~type) +
  geom_line(data=ff_av, aes(group=treatment))

