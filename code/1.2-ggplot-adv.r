## ----echo=FALSE------------------------------------------------------------------------------------------
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


## ----load libraries, echo=FALSE--------------------------------------------------------------------------
library(tidyverse)
library(ggmap)
library(here)


## ----not to run this code, eval=FALSE--------------------------------------------------------------------
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


## ----load the platypus obervation data, echo=TRUE--------------------------------------------------------
load(here::here("data/platypus.rda"))
platydata <- platypus
ggplot(data=platydata) + geom_point(aes(x=longitude, y=latitude))


## ----Add some transparency to see density of locations, echo=TRUE----------------------------------------
ggplot(data=platydata) + geom_point(aes(x=longitude, y=latitude), alpha=0.1)


## ----making a map projection, echo=TRUE, fig.height=10, out.width="100%"---------------------------------
ggplot(data=platydata) + 
  geom_point(aes(x=longitude, y=latitude), 
             alpha=0.1) +
  coord_map()


## ----you need a developer API to run this code, echo=FALSE, eval=FALSE-----------------------------------
library(ggmap)
oz_bbox <- c(112.9, # min long
              -45, # min lat
              159, # max long
              -10) # max lat
oz_map <- get_map(location = oz_bbox, source = "osm") 
save(oz, file="data/oz.rda")


## ----load the saved map data, echo=TRUE------------------------------------------------------------------
load(here::here("data/oz.rda"))
ggmap(oz) + 
  geom_point(data=platydata, aes(x=longitude, y=latitude), 
              alpha=0.1, colour="orange")


## ----leaflet map, echo=TRUE------------------------------------------------------------------------------
library(leaflet)
platydata %>%
  filter(!is.na(latitude), !is.na(longitude), !(eventDate=="")) %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(
    radius=1, opacity = 0.5, color = "orange", label = ~eventDate,
    lat = ~latitude, lng = ~longitude) 


## ----create a date variable, echo=TRUE-------------------------------------------------------------------
library(lubridate)
platydata <- platydata %>% 
  mutate(eventDate = ymd_hms(eventDate))


## ----show sightings over time, echo=TRUE, out.width="60%"------------------------------------------------
ggplot(data=platydata) +
  geom_point(aes(x=eventDate, y=1))


## ----show jittered sightings over time, echo=TRUE, out.width="60%"---------------------------------------
ggplot(data=platydata) +
  geom_jitter(aes(x=eventDate, y=1))


## ----focus on records since 1900 and count the number for each year, echo=TRUE, out.width="60%"----------
platydata1900 <- platydata %>% filter(year>1900) %>%
  count(year) 
ggplot(data=platydata1900) +
  geom_point(aes(x=year, y=n))


## ----solution code for filtering on location and time, eval=FALSE----------------------------------------
# Check odd cases
platydata %>% filter(latitude < (-50)) 
# These just have the lat/long wrong
platydata %>% filter(eventDate < ymd("1850-01-01")) 


## ----add a trend line, echo=TRUE, out.width="60%"--------------------------------------------------------
ggplot(data=platydata1900, aes(x=year, y=n)) +
  geom_point() +
  geom_smooth(se=F)


## ----make it interactive to investigate some observations, echo=TRUE-------------------------------------
library(plotly)
ggplotly()


## ----solution code to density plot on map, eval=FALSE, echo=FALSE----------------------------------------
ggmap(oz) + 
  geom_density2d(data=platydata, aes(x=longitude, y=latitude), 
              colour="orange") 


## ----eval=FALSE, echo=FALSE------------------------------------------------------------------------------
Not a lot different. It shows perhaps high density regions around Melbourne, Brisbane and south of Sydney. These match high population sites, though, and maybe reiterates the sampling being convenience sampling. We miss the smaller areas of sightings, like northern Queensland.


## ----solution code for exploring population trend, echo=FALSE, eval=FALSE--------------------------------
platydata_50_10 <- platydata %>% filter(year>1949, year<2020) %>%
  mutate(decade = cut(year, breaks=seq(1950, 2020, 10),
   include.lowest=TRUE, 
   labels=c("50-59", "60-69", "70-79", "80-89", "90-99", "00-09", "10-19")))
ggmap(oz) + geom_point(data=platydata_50_10, mapping=aes(x=longitude, y=latitude), colour="orange", alpha=0.1) +
  facet_wrap(~decade)

