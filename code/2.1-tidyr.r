## ----echo = FALSE------------------------------------------------------------------
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


## ----load packages, echo=FALSE-----------------------------------------------------
library(tidyverse)
library(lubridate)
library(broom)


## ----read TB incidence data and check, results='hide'------------------------------
tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv"))
tb %>%                                  # first we get the tb data
  filter(year == 2016) %>%              # then we focus on just the year 2016
  group_by(country) %>%                 # then we group by country
  summarize(
    cases = sum(c_newinc, na.rm=TRUE)   # to create a summary of all new cases
    ) %>% 
  arrange(desc(cases))                  # then we sort countries to show highest number new cases first


## ----example 1 What are the variables, echo=FALSE----------------------------------
grad <- read_csv(here::here("data/graduate-programs.csv"))
head(grad[c(2,3,4,6)])


## ----echo=FALSE, eval=FALSE--------------------------------------------------------
#> in the columns, subject, Inst, AvNumPubs, ...


## ----example 2 whats in the column names, echo=FALSE-------------------------------
genes <- read_csv(here::here("data/genes.csv"))
head(genes)


## ----echo=FALSE, eval=FALSE--------------------------------------------------------
#> the experimental design is coded into the variable names, genotype:WI/WM, time:6/12, rep:1/2/4


## ----example 3 what are the variables and records, echo=FALSE----------------------
melbtemp <- read.fwf(here::here("data/ASN00086282.dly"), 
   c(11, 4, 2, 4, rep(c(5, 1, 1, 1), 31)), fill=T)
head(melbtemp[,c(1,2,3,4,seq(5,100,4))])


## ----echo=FALSE, eval=FALSE--------------------------------------------------------
#> variables are TMAX, TMIN, PRCP, year, month, day, stationid. Each row contains the values for one month!


## ----example 4 what are the variables and experimental units, echo=FALSE-----------
tb <- read_csv(here::here("data/tb.csv"))
tail(tb)
#colnames(tb)


## ----example 4 what are the variables and observations, echo=FALSE-----------------
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


## ----setup a simple example, echo = FALSE------------------------------------------
dframe <- data.frame(id = 1:2, trtA=c(2.5,4.6), trtB = c(45, 35))


## ----gather the example data into long form----------------------------------------
# wide format
dframe

# long format
dframe %>% pivot_longer(trtA:trtB, names_to="treatment", values_to="outcome")


## ----read in and process the TB data-----------------------------------------------
read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>% 
  dplyr::select(country, iso3, year, starts_with("new_sp_")) %>%
  na.omit() %>%
  head()


## ----turn TB data into long form---------------------------------------------------
tb1 <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>% 
  dplyr::select(country, iso3, year, starts_with("new_sp_")) %>%
  pivot_longer(starts_with("new_sp_")) 

tb1 %>% na.omit() %>% head()


## ----extract variable names from original column names-----------------------------
tb2 <- tb1 %>% 
  separate(name, sep = "_", into=c("foo_new", "foo_sp", "sexage")) 


tb2 %>% na.omit() %>% head()


## ----continue extracting variable names--------------------------------------------
tb3 <- tb2 %>% dplyr::select(-starts_with("foo")) %>% # remove the `foo` variables
  mutate(
    sex = substr(sexage, 1, 1),                # extract the first character 
    age = substr(sexage, 2, length(sexage))    # get all but first character
  ) %>%
  dplyr::select(-sexage)


tb3 %>% na.omit() %>% head()


## ----------------------------------------------------------------------------------
genes <- read_csv(here::here("data/genes.csv"))

names(genes)


## ----code solution to genes wrangling, echo=FALSE----------------------------------
gtidy <- genes %>%
pivot_longer(-id, names_to="variable", values_to="expr") %>%
separate(variable, c("trt", "leftover"), "-") %>%
separate(leftover, c("time", "rep"), "\\.") %>%
mutate(trt = sub("W", "", trt)) %>%
mutate(rep = sub("R", "", rep))


## ----------------------------------------------------------------------------------
head(gtidy)


## ----compute group means, fig.show='hide'------------------------------------------
gmean <- gtidy %>% 
  group_by(id, trt, time) %>% 
  summarise(expr = mean(expr))
gtidy %>% 
  ggplot(aes(x = trt, y = expr, colour=time)) +
  geom_point() +
  geom_line(data = gmean, aes(group = time)) +
  facet_wrap(~id) +
  scale_colour_brewer("", palette="Set1")


## ----plot the genes data overlais with group means, echo=FALSE, fig.width=5, fig.height = 5----
gtidy %>% 
  ggplot(aes(x = trt, y = expr, colour=time)) +
  geom_point() +
  geom_line(data = gmean, aes(group = time)) +
  facet_wrap(~id) +
  scale_colour_brewer("", palette="Set1")

