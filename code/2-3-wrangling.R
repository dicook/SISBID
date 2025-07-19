#' ---
#' title: Wrangling Data and Models
#' ---
#' 


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


#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(broom)
library(broom.mixed)
library(lme4)


load(here::here("data/french_fries.rda"))



ff_long <- french_fries %>% pivot_longer(potato:painty, names_to = "type", values_to = "rating")
ff_lm <- lm(rating~type+treatment+time+subject, 
data=ff_long)


summary(ff_lm)


glance(ff_lm)


ff_lm_tidy <- tidy(ff_lm)
glimpse(ff_lm_tidy)


ff_lm_all <- augment(ff_lm)
glimpse(ff_lm_all)


ggplot(ff_lm_all, aes(x=.fitted, y=.resid)) + geom_point()


library(lme4)
fries_lmer <- lmer(rating~type+treatment+time+subject + ( 1 | subject ), 
data = ff_long)


## the model is pretty bad:
glance(fries_lmer)
tidy(fries_lmer)

ff_lmer_all <- augment(fries_lmer)

ggplot(ff_lmer_all, aes(x=.fitted, y=.resid)) + geom_point() +
  coord_equal()

ggplot(ff_lmer_all, aes(x=.fitted, y=rating)) + geom_point() +
  coord_equal() 


load(here::here("data/french_fries.rda"))
french_fries %>%
    filter(subject == 3, time == 1)


french_fries %>%
    arrange(desc(rancid)) %>%
    head


french_fries %>%
    select(time, treatment, subject, rep, potato) %>%
    head


french_fries %>%
    summarise(mean_rancid = mean(rancid, na.rm=TRUE), 
              sd_rancid = sd(rancid, na.rm = TRUE))


french_fries %>%
    group_by(time, treatment) %>%
    summarise(mean_rancid = mean(rancid), sd_rancid = sd(rancid))


french_fries %>% 
  group_by(subject) %>% 
  summarize(n = n()) 


french_fries %>% 
  na.omit() %>%
  count(subject, time) %>%
  spread(time, n)


ggplot(data=ff_long, aes(x=time, y=rating, colour=treatment)) +
  geom_point() +
  facet_grid(subject~type) 




ff_av <- ff_long %>% 
  group_by(subject, time, type, treatment) %>%
  summarise(rating=mean(rating))

ggplot(data=ff_long, aes(x=time, y=rating, colour=treatment)) + 
  facet_grid(subject~type) +
  geom_line(data=ff_av, aes(group=treatment))

