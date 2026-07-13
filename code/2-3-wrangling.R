## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## -----------------------------------------------------------------------------
#| label: load packages
#| echo: false
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(broom)
library(broom.mixed) # includes tidying functions for glmmTMB
library(lme4)
library(glmmTMB)


## -----------------------------------------------------------------------------
#| label: setting_up
#| echo: false
load(here::here("data/french_fries.rda"))


## -----------------------------------------------------------------------------
#| label: models and model output

ff_long <- french_fries |> pivot_longer(potato:painty, names_to = "type", values_to = "rating")
ff_lm <- lm(rating~type+treatment+time+subject, 
data=ff_long)


## -----------------------------------------------------------------------------
#| label: examine the model fit
summary(ff_lm)


## -----------------------------------------------------------------------------
#| label: goodness of fit statistics
glance(ff_lm)


## -----------------------------------------------------------------------------
#| label: model estimates
ff_lm_tidy <- tidy(ff_lm)
head(ff_lm_tidy)


## -----------------------------------------------------------------------------
#| label: model diagnostics
ff_lm_all <- augment(ff_lm)
glimpse(ff_lm_all)


## -----------------------------------------------------------------------------
#| label: residual plot
ggplot(ff_lm_all, aes(x=.fitted, y=.resid)) + geom_point()


## -----------------------------------------------------------------------------
#| label: add random intercepts for each subject
#| results: hide
fries_lmer <- lmer(rating~type+treatment+time + ( 1 | subject ), 
data = ff_long)


## -----------------------------------------------------------------------------
#| label: solution to french fries modeling
#| eval: false
#| echo: false
# ## the model is pretty bad:
# glance(fries_lmer)
# tidy(fries_lmer)
# 
# ff_lmer_all <- augment(fries_lmer)
# 
# ggplot(ff_lmer_all, aes(x=.fitted, y=.resid)) + geom_point() +
#   coord_equal()
# 
# ggplot(ff_lmer_all, aes(x=.fitted, y=rating)) + geom_point() +
#   coord_equal()


## -----------------------------------------------------------------------------
#| label: select_a_subset_of_the_observations
#| code-line-numbers: "3"
load(here::here("data/french_fries.rda"))
french_fries |>
    filter(subject == 3, time == 1) #<<


## -----------------------------------------------------------------------------
#| label: order the observations
#| code-line-numbers: "2"
french_fries |>
    arrange(desc(rancid)) |> #<<
    head()


## -----------------------------------------------------------------------------
#| label: select a subset of the variables
#| code-line-numbers: "2"
french_fries |>
    select(time, treatment, subject, rep, potato) |> #<<
    head()


## -----------------------------------------------------------------------------
#| label: summarize observations into one-number statistic
#| code-line-numbers: "2,5"
french_fries |>
    summarise( #<<
      mean_rancid = mean(rancid, na.rm=TRUE), 
      sd_rancid = sd(rancid, na.rm = TRUE)
      ) #<<


## -----------------------------------------------------------------------------
#| label: summarise and group_by
french_fries |>
    group_by(time, treatment) |>
    summarise(mean_rancid = mean(rancid), sd_rancid = sd(rancid))


## -----------------------------------------------------------------------------
#| label: checking design completeness
french_fries |> 
  group_by(subject) |> 
  summarize(n = n()) 


## -----------------------------------------------------------------------------
#| label: counts for subject by time
french_fries |>
  na.omit() |>
  count(subject, time) |>
  pivot_wider(names_from="time", values_from="n")


## -----------------------------------------------------------------------------
#| label: do-scores-change-over-time
#| fig-show: hide
ggplot(data=ff_long, aes(x=time, y=rating, colour=treatment)) +
  geom_point() +
  facet_grid(subject~type) 


## -----------------------------------------------------------------------------
#| echo: false
#| ref-label: do-scores-change-over-time
#| fig-width: 12
#| fig-height: 9
#| out-width: 80%


## -----------------------------------------------------------------------------
#| echo: false
#| fig-width: 12
#| fig-height: 9
#| out-width: 60%
ff_av <- ff_long |> 
  group_by(subject, time, type, treatment) |>
  summarise(rating=mean(rating))

ggplot(data=ff_long, aes(x=time, y=rating, colour=treatment)) + 
  facet_grid(subject~type) +
  geom_line(data=ff_av, aes(group=treatment))

