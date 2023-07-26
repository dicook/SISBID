## ----echo=FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  echo=FALSE,
  message = FALSE,
  warning = FALSE,
  error = FALSE, 
  collapse = TRUE,
  comment = "",
  out.width = "80%", 
  fig.height = 6,
  fig.width = 10,
  fig.align = "center",
  fig.retina = 3,
  cache = FALSE
)


## ----load libraries, echo=FALSE------------------------------------------
#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(ggmap)
library(here)


## ----read TB data and wrangle and subset to USA--------------------------
tb <- read_csv(here::here("data/TB_notifications_2020-07-01.csv")) %>% 
  dplyr::select(country, iso3, year, new_sp_m04:new_sp_fu) %>%
  pivot_longer(new_sp_m04:new_sp_fu, names_to="stuff", values_to="count") %>%
  separate(stuff, c("stuff1", "stuff2", "sexage")) %>%
  dplyr::select(-stuff1, -stuff2) %>%
  mutate(sex=substr(sexage, 1, 1), 
         age=substr(sexage, 2, length(sexage))) %>%
  dplyr::select(-sexage)

# Filter years between 1997 and 2012 due to missings
tb_us <- tb %>% 
  filter(country == "United States of America") %>%
  filter(!(age %in% c("04", "014", "514", "u"))) %>%
  filter(year > 1996, year < 2013) %>%
  mutate(
    age_group = factor(age, labels = c("15-24", "25-34", "35-44", "45-54", "55-64", "65+"))
  )


## ----make a bar chart of US TB incidence, echo=TRUE, out.width="60%", fig.width=10, fig.height=3----
ggplot(tb_us, aes(x = year, y = count, fill = sex)) +
  geom_bar(stat = "identity") +
  facet_grid(~ age) 


## ----colour and axes fixes, echo=TRUE, fig.height=3----------------------
# This uses a color blind friendly scale
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(~age_group) + #<<
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) #<<


## ----compare proportions of males/females, out.width="70%", echo=TRUE, fig.height=3----
# Fill the bars, note the small change to the code
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") + #<<
  facet_grid(~age_group) + 
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5"))  + 
  ylab("proportion") #<<


## ----side-by-side bars of males/females, fig.height=3, eval=FALSE, echo=FALSE----
# This code does something strange to the axis tick marks
# We will skip it for now
# ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
#  geom_bar(stat="identity", position="dodge") +
#  facet_wrap(~age, ncol=6) +
#  scale_fill_brewer("", palette="Dark2") +
#  scale_x_continuous("year", breaks=seq(1995, 2012, 5), labels=c("95", "00", "05", "10"))


## ----compare counts of males/females, out.width="100%", echo=TRUE, fig.height=5----
# Make separate plots for males and females, focus on counts by category
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(sex~age_group) + #<<
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) 


## ----eval=FALSE----------------------------------------------------------
- Counts are generally higher for males than females 
- There are very few female cases in the middle years
- Perhaps something of a older male outbreak in 2007-8, and possibly a young female outbreak in the same years


## ----rose plot of males/females, out.width="60%", echo=TRUE, fig.height=5----
# How to make a pie instead of a barchart - not straight forward
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(sex~age_group) + 
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  coord_polar() #<<


## ----stacked barchart of males/females, out.width="60%", echo=TRUE, fig.height=5----
# Step 1 to make the pie
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") + #<<
  facet_grid(sex~age_group) +
  scale_fill_viridis_d("", option="inferno") 


## ----pie chart of males/females, out.width="60%", echo=TRUE, fig.height=5----
# Now we have a pie, note the mapping of variables
# and the modification to the coord_polar
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") + 
  facet_grid(sex~age_group) +
  scale_fill_viridis_d("", option="inferno") +
  coord_polar(theta = "y") #<<


## ----use a line plot instead of bar, fig.height=3------------------------
ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_grid(~age_group) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ylim(c(0,NA))


## ----use a line plot of proportions, fig.height=3------------------------
tb_us %>% group_by(year, age_group) %>% 
  summarise(p = count[sex=="m"]/sum(count)) %>%
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="white", linewidth=2) +
  geom_line() + geom_point() +
  facet_grid(~age_group) +
  ylab("proportion of males") 

