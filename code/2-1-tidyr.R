#' ---
#' title: Tidying your data
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


tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv"))
tb |>                                  # first we get the tb data
  filter(year == 2016) |>              # then we focus on just the year 2016
  group_by(country) |>                 # then we group by country
  summarize(
    cases = sum(c_newinc, na.rm=TRUE)   # to create a summary of all new cases
    ) |> 
  arrange(desc(cases))                  # then we sort countries to show highest number new cases first


tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv"))
tb |>                                  # first we get the tb data
  filter(year == 2016) |>              # then we focus on just the year 2016
  group_by(country) |>                 # then we group by country
  summarize(
    cases = sum(c_newinc, na.rm=TRUE)   # to create a summary of all new cases
    ) |> 
  arrange(desc(cases))                  # then we sort countries to show highest number new cases first


grad <- read_csv(here::here("data/graduate-programs.csv"))
head(grad[c(2,3,4,6)])


genes <- read_csv(here::here("data/genes.csv"))
head(genes)


melbtemp <- read.fwf(here::here("data/ASN00086282.dly"), 
   c(11, 4, 2, 4, rep(c(5, 1, 1, 1), 31)), fill=T)
head(melbtemp[,c(1,2,3,4,seq(5,100,4))])


tb <- read_csv(here::here("data/tb.csv"))
tail(tb)
#colnames(tb)


pew <- read.delim(
  file = "http://stat405.had.co.nz/data/pew.txt",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = F
)
pew[1:5, 1:5]


load(here::here("data/french_fries.rda"))
head(french_fries, 4)


dframe <- data.frame(id = 1:2, trtA=c(2.5,4.6), trtB = c(45, 35))


# wide format
dframe

# long format
dframe |> pivot_longer(trtA:trtB, names_to="treatment", values_to="outcome")


read_csv(here::here("data/TB_notifications_2019-07-01.csv")) |> 
  dplyr::select(country, iso3, year, starts_with("new_sp_")) |>
  na.omit() |>
  head()


tb1 <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) |> 
  dplyr::select(country, iso3, year, starts_with("new_sp_")) |>
  pivot_longer(starts_with("new_sp_")) 

tb1 |> na.omit() |> head()


tb2 <- tb1 |> 
  separate(name, sep = "_", into=c("foo_new", "foo_sp", "sexage")) 


tb2 |> na.omit() |> head()


tb3 <- tb2 |> dplyr::select(-starts_with("foo")) |> # remove the `foo` variables
  mutate(
    sex = substr(sexage, 1, 1),                # extract the first character 
    age = substr(sexage, 2, length(sexage))    # get all but first character
  ) |>
  dplyr::select(-sexage)


tb3 |> na.omit() |> head()


genes <- read_csv(here::here("data/genes.csv"))

names(genes)


gtidy <- genes |>
pivot_longer(-id, names_to="variable", values_to="expr") |>
separate(variable, c("trt", "leftover"), "-") |>
separate(leftover, c("time", "rep"), "\\.") |>
mutate(trt = sub("W", "", trt)) |>
mutate(rep = sub("R", "", rep))


head(gtidy)


gmean <- gtidy |> 
  group_by(id, trt, time) |> 
  summarise(expr = mean(expr))
gtidy |> 
  ggplot(aes(x = trt, y = expr, colour=time)) +
  geom_point() +
  geom_line(data = gmean, aes(group = time)) +
  facet_wrap(~id) +
  scale_colour_brewer("", palette="Set1")


gtidy |> 
  ggplot(aes(x = trt, y = expr, colour=time)) +
  geom_point() +
  geom_line(data = gmean, aes(group = time)) +
  facet_wrap(~id) +
  scale_colour_brewer("", palette="Set1")

