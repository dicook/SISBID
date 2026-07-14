## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## -----------------------------------------------------------------------------
#| label: tb-comparisons1
#| fig-width: 5
#| fig-height: 4
tb_inc_100k <- read_csv(here::here("data/TB_burden_countries_2025-07-22.csv")) |>
  filter(iso3 %in% c("USA", "AUS"))
ggplot(tb_inc_100k, aes(y = iso3, 
                        x = e_inc_100k)) +
  stat_gradientinterval(fill = "darkorange") +
  ylab("") +
  xlab("Inc per 100k") +
  theme_ggdist()


## -----------------------------------------------------------------------------
#| label: tb-comparisons2
#| fig-width: 5
#| fig-height: 4
ggplot(tb_inc_100k, aes(y = iso3, 
                        x = e_inc_100k)) +
  stat_halfeye(side = "right") +
  geom_dots(side="left", 
                    fill = "darkorange", color = "darkorange") +
  ylab("") +
  xlab("Inc per 100k") +
  theme_ggdist()


## -----------------------------------------------------------------------------
#| label: not to run this code
#| eval: false
#| echo: false
# # Data extracted from ALA with this code
# # Note that package ALA4Ris being replaced by package galah
# # install.packages("galah")
# library(galah)
# 
# galah_config(email = YOUR_EMAIL_HERE #"dicook@monash.edu",
#              atlas = "Australia")
# 
# search_taxa(c("Ornithorhynchus", "Tachyglossidae"))
# 
# galah_call() |>
#   galah_identify(c("Ornithorhynchus", "Tachyglossidae")) |>
#   count() |>
#   collect()
# 
# monotremes <- galah_call() |>
#   galah_identify(c("Ornithorhynchus", "Tachyglossidae")) |>
#   galah_filter(year == 2024) |>
#   galah_select(scientificName, eventDate, basisOfRecord,
#                decimalLongitude, decimalLatitude) |>
#   atlas_occurrences()
# 
# monotremes <- monotremes |>
#   rename(
#     longitude = decimalLongitude,
#     latitude = decimalLatitude,
#     datetime = eventDate,
#     obs_type = basisOfRecord
#   ) |>
#   mutate(
#     day = ymd(str_sub(datetime, 1, 10),
#               tz="Australia/Sydney"),
#     hour = as.numeric(str_sub(datetime, 15, 16))) |>
#     separate(scientificName, into = c("family", "species")) |>
#   mutate(family = if_else(family == "TACHYGLOSSIDAE", "Tachyglossus", family)) |>
#   mutate(common_name = if_else(
#     family == "Tachyglossus", "echidna",
#                               "platypus"))
# save(monotremes, file="data/monotremes.rda")


## -----------------------------------------------------------------------------
#| label: Add some transparency to see density of locations
#| echo: true
#| fig-width: 8
#| fig-height: 4
#| out-width: 80%
load(here::here("data/monotremes.rda"))
ggplot(data=monotremes) + 
  geom_point(aes(x = longitude, 
                 y = latitude, 
                 colour = family),
             alpha=0.5)


## -----------------------------------------------------------------------------
#| label: making a map projection
#| echo: false
#| fig-width: 5
#| fig-height: 4
#| out-width: 100%
ggplot(data=monotremes) + 
  geom_point(aes(x=longitude, 
                 y=latitude, 
                 colour = common_name), 
             alpha=0.1) +
  scale_colour_brewer("", palette = "Dark2") +
  coord_sf()


## -----------------------------------------------------------------------------
#| label: making a map projection
#| echo: true
#| eval: false
#| fig-show: hold
#| out-width: 100%
# ggplot(data=monotremes) +
#   geom_point(aes(x=longitude,
#                  y=latitude,
#                  colour = common_name),
#              alpha=0.1) +
#   scale_colour_brewer("", palette = "Dark2") +
#   coord_sf()


## -----------------------------------------------------------------------------
#| label: you need a developer API to run this code
#| echo: false
#| eval: false
# library(ggmap)
# library(osmdata)
# oz_bbox <- c(112.9, # min long
#               -45, # min lat
#               159, # max long
#               -10) # max lat
# oz_map <- get_map(location = oz_bbox, source = "osm")
# save(oz, file="data/oz.rda")


## -----------------------------------------------------------------------------
#| label: load the saved map data
#| echo: true
#| output-location: "column"
load(here::here("data/oz.rda"))
ggmap(oz) + 
  geom_point(data=monotremes, 
             aes(x=longitude, 
                 y=latitude, 
                 colour=common_name), 
              alpha=0.2) +
  scale_color_manual(values = c("#e66100", "#5d3a9b"))


## -----------------------------------------------------------------------------
#| label: leaflet map
#| echo: true
#| fig-width: 8
#| fig-height: 4
#| output-location: "column"
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


## -----------------------------------------------------------------------------
#| eval: false
# SOME STUFF HERE |>
#   mutate(
#     day = ymd(str_sub(datetime, 1, 10),
#               tz="Australia/Sydney"),
#     hour = as.numeric(str_sub(datetime, 15, 16)))


## -----------------------------------------------------------------------------
#| label: show sightings over time
#| echo: true
#| out-width: 60%
#| fig-height: 4
#| fig-width: 8
monotremes |>
  group_by(day, common_name) |>
  summarise(n = n()) |>
  ungroup() |>
  ggplot(aes(x=day, y=n)) +
    geom_point() +
    facet_wrap(~common_name)


## -----------------------------------------------------------------------------
#| label: add a trend line
#| echo: false
#| out-width: 100%
#| fig-height: 4
#| fig-width: 8
monotremes |>
  group_by(day, common_name) |>
  summarise(n = n()) |>
  ungroup() |>
  ggplot(aes(x=day, y=n)) +
    geom_point() +
    geom_smooth(se=F) +
    facet_wrap(~common_name) 


## -----------------------------------------------------------------------------
#| label: add a trend line
#| echo: true
#| eval: false
# monotremes |>
#   group_by(day, common_name) |>
#   summarise(n = n()) |>
#   ungroup() |>
#   ggplot(aes(x=day, y=n)) +
#     geom_point() +
#     geom_smooth(se=F) +
#     facet_wrap(~common_name)


## -----------------------------------------------------------------------------
#| label: make it interactive to investigate some observations
#| echo: true
#| out-width: 60%
#| fig-width: 10
#| fig-height: 5
library(plotly)
ggplotly(width=800, height=500)


## -----------------------------------------------------------------------------
#| label: solution code to density plot on map
#| eval: false
#| echo: false
# ggmap(oz) +
#   geom_density2d(data=monotremes,
#                  aes(x=longitude, y=latitude),
#               colour="orange") +
#   facet_wrap(~common_name, ncol=2)


## -----------------------------------------------------------------------------
#| label: solution code to boxplot task
#| eval: false
#| echo: false
# monotremes |>
#   group_by(day, common_name) |>
#   summarise(n = n(), .groups = "drop") |>
#   mutate(month = month(day, label = TRUE, abbr = TRUE)) |>
#   ggplot(aes(x=month, y=n)) +
#     geom_boxplot() +
#     facet_wrap(~common_name, ncol=2)

