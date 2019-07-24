
## ----load packages, echo = FALSE-----------------------------------------
library(tidyverse)
library(lubridate)
library(gapminder)


## ----select a subset of the observations---------------------------------
load(here::here("data/french_fries.rda"))
french_fries %>%
    filter(subject == 3, time == 1)


## ----order the observations----------------------------------------------
french_fries %>%
    arrange(desc(rancid)) %>%
    head


## ----select a subset of the variables------------------------------------
french_fries %>%
    select(time, treatment, subject, rep, potato) %>%
    head


## ----summarize observations into one-number statistic--------------------
french_fries %>%
    summarise(mean_rancid = mean(rancid, na.rm=TRUE),
              sd_rancid = sd(rancid, na.rm = TRUE))


## ----summarise and group_by----------------------------------------------
french_fries %>%
    group_by(time, treatment) %>%
    summarise(mean_rancid = mean(rancid), sd_rancid = sd(rancid))


## ----checking design completeness----------------------------------------
french_fries %>%
  group_by(subject) %>%
  summarize(n = n())


## ----counts for subject by time------------------------------------------
french_fries %>%
  na.omit() %>%
  count(subject, time) %>%
  spread(time, n)


## ----do scores change over time, fig.show='hide'-------------------------
ff.m <- french_fries %>%
  gather(type, rating, -subject, -time, -treatment, -rep)
ggplot(data=ff.m, aes(x=time, y=rating, colour=treatment)) +
  geom_point() +
  facet_grid(subject~type)


## ----get means over reps, and connect the dots, fig.show='hide'----------
ff.m.av <- ff.m %>%
  group_by(subject, time, type, treatment) %>%
  summarise(rating=mean(rating))

ggplot(data=ff.m, aes(x=time, y=rating, colour=treatment)) +
  facet_grid(subject~type) +
  geom_line(data=ff.m.av, aes(group=treatment))


## ----first look at gapminder data----------------------------------------
library(gapminder)
ggplot(data=gapminder,
       aes(x=year, y=lifeExp, group=country)) +
  geom_line()


## ----using models as exploratory tools, echo=FALSE, fig.width=6.5, fig.height=5----
library(dplyr)
library(tidyr)
library(purrr)

gapminder2 <- gapminder %>% mutate(year = year-1950)
by_country <- gapminder2 %>%
  group_by(continent, country) %>%
  nest()

by_country <- by_country %>% mutate(
    model = purrr::map(data, ~ lm(lifeExp ~ year, data = .))
)

by_country <- by_country %>% unnest(model %>% purrr::map(broom::tidy))
country_coefs <- by_country %>% select(continent, country, term, estimate) %>% spread(term, estimate)

p <- ggplot(data=country_coefs, aes(x=`(Intercept)`, y=year, colour=continent, label=country)) +
  geom_point() +
  scale_colour_brewer(palette="Dark2") +
  xlab("Average Life Expectancy in 1950") +
  ylab("Average Gain in Life Expectancy per Year")
plotly::ggplotly(p)


## ----start with a single country-----------------------------------------
usa <- gapminder %>% filter(country=="United States")
head(usa)


## ----life expectancy in the U.S. since 1950------------------------------
ggplot(data=usa, aes(x=year, y=lifeExp)) +
  geom_point() +
  geom_smooth(method="lm")


## ------------------------------------------------------------------------
usa.lm <- lm(lifeExp~year, data=usa)
usa.lm


## ------------------------------------------------------------------------
gapminder <- gapminder %>% mutate(year = year-1950)


## ----nesting data--------------------------------------------------------
by_country <- gapminder %>% group_by(continent, country) %>% nest()
head(by_country)


## ----fitting multiple models---------------------------------------------
by_country$model <- by_country$data %>% purrr::map(~lm(lifeExp~year, data=.))
head(by_country)


## ----broom again---------------------------------------------------------
broom::tidy(by_country$model[[1]])


## ----extract all countries automatically---------------------------------
by_country$coefs <- by_country$model %>% purrr::map(broom::tidy)
by_country


## ----get the coefficients into one data set------------------------------
by_country_coefs <- by_country %>% unnest(coefs)
by_country_coefs



## ----and finally a visualization-----------------------------------------
coefs <- by_country_coefs %>%
  select(country, continent, term, estimate) %>%
  spread(term, estimate)
ggplot(data=coefs, aes(x=`(Intercept)`, y=year, colour=continent)) +
  geom_point()
