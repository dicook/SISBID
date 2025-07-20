#' ---
#' title: Advancing the Grammar of Graphics
#' ---
#' 


source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


# Data extracted from ALA with this code
# Note that package ALA4Ris being replaced by package galah
# install.packages("galah")
library(galah)

galah_config(email = YOUR_EMAIL_HERE #"dicook@monash.edu",
             atlas = "Australia")

search_taxa(c("Ornithorhynchus", "Tachyglossidae"))

galah_call() |>
  galah_identify(c("Ornithorhynchus", "Tachyglossidae")) |>
  count() |> 
  collect()

monotremes <- galah_call() |>
  galah_identify(c("Ornithorhynchus", "Tachyglossidae")) |>
  galah_filter(year == 2024) |>   
  select(scientificName, eventDate, basisOfRecord, 
         decimalLongitude, decimalLatitude) |>
  atlas_occurrences()

monotremes <- monotremes |> 
  rename(
    longitude = decimalLongitude,
    latitude = decimalLatitude,
    datetime = eventDate,
    obs_type = basisOfRecord
  ) |>
  mutate(
    day = ymd(str_sub(datetime, 1, 10),
              tz="Australia/Sydney"), 
    hour = as.numeric(str_sub(datetime, 15, 16))) |>
    separate(scientificName, into = c("family", "species")) |>
  mutate(family = if_else(family == "TACHYGLOSSIDAE", "Tachyglossus", family)) |>
  mutate(common_name = if_else(
    family == "Tachyglossus", "echidna",
                              "platypus"))
save(monotremes, file="data/monotremes.rda")


load(here::here("data/platypus.rda"))
platydata <- platypus
ggplot(data=platydata) + geom_point(aes(x=longitude, y=latitude))


load(here::here("data/monotremes.rda"))
ggplot(data=monotremes) + 
  geom_point(aes(x = longitude, 
                 y = latitude, 
                 colour = family),
             alpha=0.5)


ggplot(data=monotremes) + 
  geom_point(aes(x=longitude, 
                 y=latitude, 
                 colour = common_name), 
             alpha=0.1) +
  scale_colour_brewer("", palette = "Dark2") +
  coord_map()




library(ggmap)
library(osmdata)
oz_bbox <- c(112.9, # min long
              -45, # min lat
              159, # max long
              -10) # max lat
oz_map <- get_map(location = oz_bbox, source = "osm") 
save(oz, file="data/oz.rda")


load(here::here("data/oz.rda"))
ggmap(oz) + 
  geom_point(data=monotremes, 
             aes(x=longitude, 
                 y=latitude, 
                 colour=common_name), 
              alpha=0.1) +
  scale_colour_brewer("", palette = "Dark2")

#| output-location: column
library(leaflet)
monotremes |>
  filter(family == "Ornithorhynchus") |>
  filter(!is.na(latitude), 
         !is.na(longitude)) |>
  leaflet() |>
  addTiles() |>
  addCircleMarkers(
    radius=1, 
    opacity = 0.5, 
    color = "orange", 
    label = ~day,
    lat = ~latitude, lng = ~longitude) 


SOME STUFF HERE |>
  mutate(
    day = ymd(str_sub(datetime, 1, 10),
              tz="Australia/Sydney"), 
    hour = as.numeric(str_sub(datetime, 15, 16)))


monotremes |>
  group_by(day, common_name) |>
  summarise(n = n()) |>
  ungroup() |>
  ggplot(aes(x=day, y=n)) +
    geom_point() +
    facet_wrap(~common_name)


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


monotremes |>
  group_by(day, common_name) |>
  summarise(n = n()) |>
  ungroup() |>
  ggplot(aes(x=day, y=n)) +
    geom_point() +
    geom_smooth(se=F) +
    facet_wrap(~common_name) 




library(plotly)
ggplotly()


ggmap(oz) + 
  geom_density2d(data=monotremes, 
                 aes(x=longitude, y=latitude), 
              colour="orange") +
  facet_wrap(~common_name, ncol=2)


monotremes |>
  group_by(day, common_name) |>
  summarise(n = n(), .groups = "drop") |>
  mutate(month = month(day, label = TRUE, abbr = TRUE)) |>
  ggplot(aes(x=month, y=n)) +
    geom_boxplot() +
    facet_wrap(~common_name, ncol=2) 

