## ----echo = FALSE----------------------------------------------------------------------------------------
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


## ----load packages, echo=FALSE---------------------------------------------------------------------------
library(tidyverse)
library(lubridate)
library(broom)


## ----example 6 what are the factors measurements and experimental units, echo = FALSE--------------------
load(here::here("data/french_fries.rda"))


## ----your turn to work on the french fries data, echo=FALSE----------------------------------------------
head(french_fries)


## ----put french fries in long form-----------------------------------------------------------------------
ff_long <- french_fries %>% 
  pivot_longer(potato:painty, names_to = "type", values_to = "rating")


head(ff_long)


## ----spread it back into wide form-----------------------------------------------------------------------
head(ff_long, 3)

french_fries_weeks <- ff_long %>% 
  pivot_wider(names_from = "time", values_from = "rating")

head(french_fries_weeks)


## ----spread----------------------------------------------------------------------------------------------
head(french_fries_weeks)


## ----week 1 vs week 9, fig.width=5, fig.height = 5-------------------------------------------------------
french_fries_weeks %>%
  ggplot(aes(x = `1`, y = `9`)) + geom_point()


## ----solution to do the replicates look like each other, echo=FALSE, eval=FALSE--------------------------
ff.s <- ff_long %>% pivot_wider(names_from=rep, values_from=rating)
ggplot(data=ff.s, aes(x=`1`, y=`2`)) + geom_point() +
  theme(aspect.ratio=1) 
ggplot(data=ff.s, aes(x=`1`, y=`2`)) + geom_point() +
  theme(aspect.ratio=1) + 
  xlab("Rep 1") + ylab("Rep 2") + facet_wrap(~type, ncol=5)


## ----ratings on the different scales---------------------------------------------------------------------
ff.m <- french_fries %>% 
pivot_longer(-(time:rep), names_to="type", values_to="rating")
head(ff.m)


## ----ratings on the different scales too-----------------------------------------------------------------
ff.m <- french_fries %>% 
pivot_longer(-(time:rep), names_to="type", values_to="rating")
head(ff.m)


## ---- fig.height=2, fig.width=8--------------------------------------------------------------------------
ggplot(data=ff.m, aes(x=rating)) + geom_histogram(binwidth=2) + 
facet_wrap(~type, ncol=5) 


## ----side-by-Side boxplots, fig.width=8, fig.height=5----------------------------------------------------
ggplot(data=ff.m, aes(x=type, y=rating, fill=type)) + 
geom_boxplot()


## ----solution to whether scales look like each other, echo=FALSE, eval=FALSE-----------------------------
ff.scales <- ff_long %>% pivot_wider(names_from=type, values_from=rating)

cor(ff.scales[,5:9], use="pairwise.complete")

ggplot(data=ff.scales, aes(x=potato, y=buttery)) + geom_point() +
  theme(aspect.ratio=1) 


## ----ratings by week, fig.width=8, fig.height=5----------------------------------------------------------
ff.m$time <- as.numeric(ff.m$time)
ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) + 
geom_point(size=.75) +
geom_smooth() +
facet_wrap(~type)


## ----ratings by week again, echo=FALSE, fig.width=8, fig.height=5----------------------------------------
ff.m$time <- as.numeric(ff.m$time)
ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) + 
geom_point(size=.75) +
geom_smooth() +
facet_wrap(~type)


## ----solution to model, echo=FALSE, eval=FALSE-----------------------------------------------------------
# long model is fine to use for a single model:

model <- lm(rating ~ type*time-1, data = ff_long)

ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) + 
geom_smooth(method="lm", se=FALSE, aes(colour = type))

