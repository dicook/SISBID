#' ---
#' title: A Grammar of Graphics
#' ---
#' 


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


#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(ggmap)
library(here)


# This uses a color blind friendly scale
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(~age_group) + #<<
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) #<<


# Fill the bars, note the small change to the code
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +  
  geom_bar(stat="identity", position="fill") + #<<
  ylab("proportion") + #<<
  facet_grid(~age_group) + 
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) 


ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
 geom_bar(stat="identity", position="dodge") +
 facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) + 
 scale_x_continuous("year", breaks=seq(1995, 2012, 5), labels=c("95", "00", "05", "10"))


# Make separate plots for males and females, focus on counts by category
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) + 
  facet_grid(sex~age_group)  #<<


# How to make a pie instead of a barchart - not straight forward
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(sex~age_group) + 
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  coord_polar() #<<


# Step 1 to make the pie
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") + #<<
  facet_grid(sex~age_group) +
  scale_fill_viridis_d("", option="inferno") 


# Now we have a pie, note the mapping of variables
# and the modification to the coord_polar
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") + 
  facet_grid(sex~age_group) +
  scale_fill_viridis_d("", option="inferno") +
  coord_polar(theta = "y") #<<


ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_grid(~age_group) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ylim(c(0,NA))


tb_us %>% 
  group_by(year, age_group) %>% 
  summarise(p = count[sex=="m"]/sum(count)) %>%
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="grey50", linewidth=2) +
  geom_line() + geom_point() +
  facet_grid(~age_group) +
  ylab("Proportion of Males") 

