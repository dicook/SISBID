# Most of the code lines in this file don't run on their own
# They are to help you add them to the interactive document

## ----load packages, echo=FALSE-------------------------------------------
library(tidyverse)
library(ggmap)
library(plotly)
library(gganimate)
# install.packages("learnr")


# This is current tuberculosis data taken from
# [WHO](http://www.who.int/tb/country/data/download/en/), the case notifications table.
# It is read into R using this code:


## ----echo=FALSE, fig.width=10, fig.height=8, out.width="100%"------------
tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>%
  select(country, iso3, year, g_whoregion, new_sp_m04:new_sp_fu) %>%
  gather(stuff, count, new_sp_m04:new_sp_fu) %>%
  separate(stuff, c("stuff1", "stuff2", "sexage")) %>%
  select(-stuff1, -stuff2) %>%
  mutate(sex=substr(sexage, 1, 1),
         age=substr(sexage, 2, length(sexage))) %>%
  select(-sexage) %>%
  filter(year > 1996, year < 2013) %>%
  filter(!(age %in% c("04", "014", "514", "u")))
p <- tb %>% filter(iso3 == "IND") %>%
  filter(!is.na(count)) %>%
  ggplot() +
  geom_point(aes(x=year, y=count, colour=sex, frame=age, label=iso3)) +
  geom_smooth(aes(x=year, y=count, colour=sex, frame=age),  se=FALSE) +
  scale_colour_brewer(palette = "Dark2") +
  ylim(c(0, 100000))
ggplotly(p)

# Add to the header of your Rmd
knitr::opts_chunk$set(
  echo = FALSE,
  message = FALSE,
  warning = FALSE,
  error = FALSE)

# Example quiz format
quiz(
  question("Which package contains functions for installing other R packages?",
           answer("base"),
           answer("tools"),
           answer("utils", correct = TRUE),
           answer("codetools")
  )
)

# Adding a shiny element
library(plotly)
p <- tb %>% filter(iso3 == "IND") %>%
  filter(!is.na(count)) %>%
  ggplot() +
  geom_point(aes(x=year, y=count, colour=sex, frame=age, label=iso3)) +
  geom_smooth(aes(x=year, y=count, colour=sex, frame=age),  se=FALSE) +
  scale_colour_brewer(palette = "Dark2") +
  ylim(c(0, 100000))
ggplotly(p)

# Styling and cuteness
# remotes::install_github("hadley/emo")
library(emo)
set.seed(20190709)
emo::ji("fantasy")
emo::ji("clock")

# remotes::install_github('emitanaka/anicon')
library(anicon)
anicon::nia("You've got 30 seconds!", colour="#FA700A", anitype="hover")
anicon::faa("hand-paper", animate="spin", grow=20, color="#B78ED2",
            position=c(0,0,0,200))

# Data dashboard
# install.packages("flexdashboard")
