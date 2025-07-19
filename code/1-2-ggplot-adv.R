#' ---
#' title: Advancing the Grammar of Graphics
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


# Data extracted from ALA with this code
# Note that package ALA4Ris being replaced by package galah
# install.packages("galah")
library(galah)
ala_config(atlas = "Australia", download_reason_id=)
l <- ala_species("Platypus")

taxa <- select_taxa("Ornithorhynchus anatinus", counts = TRUE)

platypus <- ala_occurrences(taxa = taxa)

platypus <- platypus %>% rename(
  longitude = decimalLongitude,
  latitude = decimalLatitude
)
save(platypus, file="data/platypus.rda")


load(here::here("data/platypus.rda"))
platydata <- platypus
ggplot(data=platydata) + geom_point(aes(x=longitude, y=latitude))


ggplot(data=platydata) + geom_point(aes(x=longitude, y=latitude), alpha=0.1)


ggplot(data=platydata) + 
  geom_point(aes(x=longitude, y=latitude), alpha=0.1) +
  coord_map()




library(leaflet)
platydata %>%
  filter(!is.na(latitude), !is.na(longitude), !(eventDate=="")) %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(
    radius=1, opacity = 0.5, color = "orange", label = ~eventDate,
    lat = ~latitude, lng = ~longitude) 


library(lubridate)
platydata <- platydata %>% 
  mutate(eventDate = ymd_hms(eventDate))


ggplot(data=platydata) +
  geom_point(aes(x=eventDate, y=1))


ggplot(data=platydata) +
  geom_jitter(aes(x=eventDate, y=1), alpha = .2)


platydata1900 <- platydata %>% 
  filter(year>1900) %>%
  count(year) 
ggplot(data=platydata1900) +
  geom_point(aes(x=year, y=n))




# Check odd cases
platydata %>% filter(latitude < (-50)) 
# These just have the lat/long wrong
platydata %>% filter(eventDate < ymd("1850-01-01")) 


ggplot(data=platydata1900, 
       aes(x=year, y=n)) +
  geom_point() +
  geom_smooth(se=F)




library(plotly)
ggplotly()


ggmap(oz) + 
  geom_density2d(data=platydata, aes(x=longitude, y=latitude), 
              colour="orange") 


platydata_50_10 <- platydata %>% filter(year>1949, year<2020) %>%
  mutate(decade = cut(year, breaks=seq(1950, 2020, 10),
   include.lowest=TRUE, 
   labels=c("50-59", "60-69", "70-79", "80-89", "90-99", "00-09", "10-19")))
ggmap(oz) + geom_point(data=platydata_50_10, mapping=aes(x=longitude, y=latitude), colour="orange", alpha=0.1) +
  facet_wrap(~decade)

