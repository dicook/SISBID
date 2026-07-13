## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
# source(here::here("knitr-setup.R"))
# source(here::here("libraries.R"))

library(tidyr)
library(dplyr)
library(ggplot2)
library(stringr)
library(knitr)
library(here)
theme_set(theme_bw())


## -----------------------------------------------------------------------------
#| label: example 6 what are the factors measurements and experimental units
#| echo: false
load(here("data/french_fries.rda"))


## -----------------------------------------------------------------------------
#| label: your turn to work on the french fries data
#| echo: false
head(french_fries)


## -----------------------------------------------------------------------------
#| label: put french fries in long form
ff_long <- french_fries |> 
  pivot_longer(potato:painty, names_to = "type", values_to = "rating")


head(ff_long)




## -----------------------------------------------------------------------------
#| label: spread it back into wide form
french_fries_weeks <- ff_long |> 
  pivot_wider(names_from = "time", values_from = "rating")




## -----------------------------------------------------------------------------
#| label: spread
head(french_fries_weeks)


## -----------------------------------------------------------------------------
#| label: week 1 vs week 9
#| message: false
#| warning: false
#| eval: false
#| fig-width: 5
#| fig-height: 5
# french_fries_weeks |>
#   ggplot(aes(x = `1`, y = `9`)) +
#   geom_point()


## -----------------------------------------------------------------------------
#| label: week 1 vs week 9
#| message: false
#| warning: false
#| echo: false
#| fig-width: 5
#| fig-height: 5
french_fries_weeks |>
  ggplot(aes(x = `1`, y = `9`)) +
  geom_point()


## -----------------------------------------------------------------------------
#| label: solution to do the replicates look like each other
#| echo: false
#| eval: false
# ff.s <- ff_long |> pivot_wider(names_from=rep, values_from=rating)
# ggplot(data=ff.s, aes(x=`1`, y=`2`)) + geom_point() +
#   theme(aspect.ratio=1)
# ggplot(data=ff.s, aes(x=`1`, y=`2`)) + geom_point() +
#   theme(aspect.ratio=1) +
#   xlab("Rep 1") + ylab("Rep 2") + facet_wrap(~type, ncol=5)


## -----------------------------------------------------------------------------
#| label: ratings on the different scales
ff.m <- french_fries |> 
pivot_longer(-(time:rep), names_to="type", values_to="rating")

## -----------------------------------------------------------------------------
#| echo: false
#| include: true
head(ff.m)


## -----------------------------------------------------------------------------
#| fig-height: 2
#| fig-width: 8
ggplot(data=ff.m, aes(x=rating)) + 
  geom_histogram(binwidth=2) + 
  facet_wrap(~type, ncol=5) 


## -----------------------------------------------------------------------------
#| label: side-by-Side boxplots
#| fig-width: 8
#| fig-height: 5
ggplot(data=ff.m, aes(x=type, y=rating, fill=type)) + 
  geom_boxplot()


## -----------------------------------------------------------------------------
#| label: solution to whether scales look like each other
#| echo: false
#| eval: false
# ff.scales <- ff_long |> pivot_wider(names_from=type, values_from=rating)
# 
# cor(ff.scales[,5:9], use="pairwise.complete")
# 
# ggplot(data=ff.scales, aes(x=potato, y=buttery)) + geom_point() +
#   theme(aspect.ratio=1)


## -----------------------------------------------------------------------------
#| label: ratings by week
#| message: false
#| warning: false
#| fig-width: 8
#| fig-height: 3
ff.m$time <- as.numeric(ff.m$time)
ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) + 
geom_point(size=.75) +
geom_smooth() +
facet_wrap(~type, ncol = 5)


## -----------------------------------------------------------------------------
#| label: ratings by week again
#| echo: false
#| message: false
#| warning: false
#| fig-width: 8
#| fig-height: 2.5
ff.m$time <- as.numeric(ff.m$time)
ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) + 
geom_point(size=.75) +
geom_smooth() +
facet_wrap(~type, ncol = 5)


## -----------------------------------------------------------------------------
#| label: solution to model
#| echo: false
#| eval: false
# # long model is fine to use for a single model:
# 
# model <- lm(rating ~ type*time-1, data = ff_long)
# 
# ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) +
# geom_smooth(method="lm", se=FALSE, aes(colour = type))

