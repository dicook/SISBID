
## ----load packages, echo=FALSE-------------------------------------------
library(tidyverse)
library(lubridate)
library(broom)


## ----read TB incidence data and check------------------------------------
tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv"))
tb %>%                                  # first we get the tb data
  filter(year == 2016) %>%              # then we focus on just the year 2016
  group_by(country) %>%                 # then we group by country
  summarize(
    cases = sum(c_newinc, na.rm=TRUE)   # to create a summary of all new cases
    ) %>%
  arrange(desc(cases))                  # then we sort countries to show highest number new cases first


## ----example 1 What are the variables, echo=FALSE------------------------
grad <- read_csv("../data/graduate-programs.csv")
head(grad[c(2,3,4,6)])


## ----example 2 whats in the column names, echo=FALSE---------------------
genes <- read_csv("../data/genes.csv")
head(genes)


## ----example 3 what are the variables and records, echo=FALSE------------
melbtemp <- read.fwf("../data/ASN00086282.dly",
   c(11, 4, 2, 4, rep(c(5, 1, 1, 1), 31)), fill=T)
head(melbtemp[,c(1,2,3,4,seq(5,100,4))])


## ----example 4 what are the variables and experimental units, echo=FALSE----
tb <- read_csv(here::here("data/tb.csv"))
tail(tb)
#colnames(tb)


## ----example 4 what are the variables and observations, echo=FALSE-------
pew <- read.delim(
  file = "http://stat405.had.co.nz/data/pew.txt",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = F
)
pew[1:5, 1:5]


## ----example 6 what are the factors measurements and experimental units, echo = FALSE----
load(here::here("data/french_fries.rda"))
head(french_fries, 4)


## ----setup a simple example, echo = FALSE--------------------------------
dframe <- data.frame(id = 1:2, trtA=c(2.5,4.6), trtB = c(45, 35))


## ----gather the example data into long form------------------------------
dframe
dframe %>% gather(treatment, outcome, trtA, trtB)


## ----read in and process the TB data-------------------------------------
read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>%
  select(country, iso3, year, starts_with("new_sp_")) %>%
  head()


## ----turn TB data into long form-----------------------------------------
tb1 <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>%
  select(country, iso3, year, starts_with("new_sp_")) %>%
  gather(key, count, starts_with("new_sp_"))
tb1 %>% na.omit() %>% head()


## ----extract variable names from original column names-------------------
tb2 <- tb1 %>%
  separate(key, sep = "_", into=c("foo_new", "foo_sp", "sexage"))
tb2 %>% na.omit() %>% head()


## ----continue extracting variable names----------------------------------
tb3 <- tb2 %>% select(-starts_with("foo")) %>%
  mutate(sex=substr(sexage, 1, 1),
         age=substr(sexage, 2, length(sexage))) %>%
  select(-sexage)
tb3 %>% na.omit() %>% head()


## ----your turn to work on the french fries data, echo=FALSE--------------
head(french_fries)


## ----put french fries in long form---------------------------------------
ff_long <- gather(french_fries, key = type, value =
                    rating, potato:painty)
head(ff_long)


## ----spread it back into wide form---------------------------------------
french_fries_weeks <- spread(ff_long, key = time,
                             value = rating)

head(french_fries_weeks)

## ----week 1 vs week 9, fig.width=5, fig.height = 5-----------------------
french_fries_weeks %>%
  ggplot(aes(x = `1`, y = `9`)) + geom_point()


## ----ratings on the different scales-------------------------------------
ff.m <- french_fries %>%
gather(type, rating, -subject, -time, -treatment, -rep)
head(ff.m)


## ---- fig.height=2, fig.width=8------------------------------------------
ggplot(data=ff.m, aes(x=rating)) + geom_histogram(binwidth=2) +
facet_wrap(~type, ncol=5)


## ----side-by-Side boxplots, fig.width=8, fig.height=5--------------------
ggplot(data=ff.m, aes(x=type, y=rating, fill=type)) +
geom_boxplot()


## ----ratings by week, fig.width=8, fig.height=5--------------------------
ff.m$time <- as.numeric(ff.m$time)
ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) +
geom_point(size=.75) +
geom_smooth() +
facet_wrap(~type)


## ------------------------------------------------------------------------
genes <- read_csv("../data/genes.csv")


## ----compute group means--------------------------------
gmean <- gtidy %>%
  group_by(id, trt, time) %>%
  summarise(expr = mean(expr))
## ----plot the genes data overlais with group means, echo=FALSE, fig.width=5, fig.height = 5----
gtidy %>%
  ggplot(aes(x = trt, y = expr, colour=time)) +
  geom_point() +
  geom_line(data = gmean, aes(group = time)) +
  facet_wrap(~id)


## ----models and model output---------------------------------------------
ff_long <- gather(french_fries, key = type, value =
rating, potato:painty)
ff_lm <- lm(rating~type+treatment+time+subject,
data=ff_long)


## ----examine the model fit-----------------------------------------------
summary(ff_lm)


## ----goodness of fit statistics------------------------------------------
glance(ff_lm)


## ----model estimates-----------------------------------------------------
ff_lm_tidy <- tidy(ff_lm)
glimpse(ff_lm_tidy)


## ----model diagnostics---------------------------------------------------
ff_lm_all <- augment(ff_lm)
glimpse(ff_lm_all)


## ----residual plot-------------------------------------------------------
ggplot(ff_lm_all, aes(x=.fitted, y=.resid)) + geom_point()


## ----add random intercepts for each subject, results='hide'--------------
library(lme4)
fries_lmer <- lmer(rating~type+treatment+time+subject + ( 1 | subject ),
data = ff_long)

## the model is pretty bad:
ff_lmer_all <- augment(fries_lmer)

ggplot(ff_lmer_all, aes(x=.fitted, y=.resid)) + geom_point() +
  coord_equal()

ggplot(ff_lmer_all, aes(x=.fitted, y=rating)) + geom_point() +
  coord_equal()


