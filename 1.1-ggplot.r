## ----load libraries, echo=FALSE------------------------------------------
library(tidyverse)
library(ggmap)
library(here)


## ----make a word cloud of plot names, fig.width=10, fig.height=8, out.width="70%"----
library(wordcloud)
namedplots <- c("histogram", "barchart", "scatterplot", "piechart", "lineplot", "density_plot", "boxplot", "dendrogram", "treemap", "scatterplot_matrix", "parallel_coordinate_plot", "biplot", "contourplot", "stem_and_leafplot", "rug_plot", "dotplot", "mosaic_plot", "spine_plot", "forest_plot", "heatmap", "qqplot", "star_plot", "chernoff_face","graph", "beeswarm", "violin_plot", "tour", "choropleth_map", "glyph_map", "cartogram", "bubble_plot", "correlogram", "area_chart", "population_pyramid", "seasonal_plot", "frequency_polygon", "biplot", "profile_plot", "funnel_plot")
pal <- c("#A1719D","#03329B","#0774E4","#702E8D","#6B44B7","#B71452","#D50321","#F39E9C","#FCB52C","#B78ED2")
wordcloud(namedplots, freq = sample(1:10, length(namedplots), replace=TRUE), colors=pal)


## ----read TB data and wrangle and subset to USA--------------------------
tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>%
  select(country, iso3, year, new_sp_m04:new_sp_fu) %>%
  gather(stuff, count, new_sp_m04:new_sp_fu) %>%
  separate(stuff, c("stuff1", "stuff2", "sexage")) %>%
  select(-stuff1, -stuff2) %>%
  mutate(sex=substr(sexage, 1, 1),
         age=substr(sexage, 2, length(sexage))) %>%
  select(-sexage)

# Filter years between 1997 and 2012 due to missings
tb_us <- tb %>%
  filter(country == "United States of America") %>%
  filter(!(age %in% c("04", "014", "514", "u"))) %>%
  filter(year > 1996, year < 2013)


## ----make a bar chart of US TB incidence, echo=TRUE, out.width="60%", fig.width=10, fig.height=3----
ggplot(tb_us, aes(x = year, y = count, fill = sex)) +
  geom_bar(stat = "identity") +
  facet_grid(~ age)

## ----colour and axes fixes, echo=TRUE, fig.height=3----------------------
# This uses a color blind proof scale
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  facet_wrap(~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2")


## ----compare proportions of males/females, out.width="70%", echo=TRUE, fig.height=3----
# Fill the bars, note the small change to the code
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") +
  facet_wrap(~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2") + ylab("proportion")


## ----compare counts of males/females, out.width="100%", echo=TRUE, fig.height=5----
# Make separate plots for males and females, focus on counts by category
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  facet_wrap(sex~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2")

## ----rose plot of males/females, out.width="60%", echo=TRUE, fig.height=5----
# How to make a pie instead of a barchart - not straight forward
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  facet_wrap(sex~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  coord_polar()


## ----stacked barchart of males/females, out.width="60%", echo=TRUE, fig.height=5----
# Step 1 to make the pie
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") +
  facet_wrap(sex~age, ncol=6) +
  scale_fill_viridis_d("", option="inferno")


## ----pie chart of males/females, out.width="60%", echo=TRUE, fig.height=5----
# Now we have a pie, note the mapping of variables
# and the modification to the coord_polar
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") +
  facet_wrap(sex~age, ncol=6) +
  scale_fill_viridis_d("", option="inferno") +
  coord_polar(theta = "y")


## ----use a line plot instead of bar, fig.height=3------------------------
ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  scale_colour_brewer("", palette="Dark2")


## ----use a line plot of proportions, fig.height=3------------------------
tb_us %>% group_by(year, age) %>%
  summarise(p = count[sex=="m"]/sum(count)) %>%
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="white", size=2) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  ylab("proportion of males")

# Your turn
## ----use a line plot instead of bar, fig.height=3------------------------
ggplot(tb_us, aes(x=year, y=count, colour=age)) +
  geom_line() + geom_point() +
  facet_wrap(~sex, ncol=6) +
  scale_colour_brewer("", palette="Dark2")

ggplot(tb_us, aes(x=year, y=count, colour=age)) +
  geom_point() +
  geom_smooth(method="lm", se=FALSE) +
  facet_wrap(~sex, ncol=6) +
  scale_colour_brewer("", palette="Dark2")

tb_us$sex <- factor(tb_us$sex, levels = c("f", "m"),
                    labels=c("female", "male"))
ggplot(tb_us, aes(x=year, y=count)) +
  geom_point(aes(colour=age)) +
  geom_smooth(method="lm",
              se=FALSE, colour="black") +
  facet_wrap(~sex, ncol=6) +
  scale_colour_brewer("", palette="Dark2")


## ----load the platypus obervation data, echo=TRUE------------------------
load(here::here("data/platypus.rda"))
platydata <- platypus$data
ggplot(data=platydata) + geom_point(aes(x=longitude, y=latitude))


## ----Add some transparency to see density of locations, echo=TRUE--------
ggplot(data=platydata) + geom_point(aes(x=longitude, y=latitude), alpha=0.1)


## ----making a map projection, echo=TRUE, fig.height=10, out.width="100%"----
ggplot(data=platydata) +
  geom_point(aes(x=longitude, y=latitude), alpha=0.1) +
  coord_map()


## ----load the saved map data, echo=TRUE----------------------------------
load(here::here("data/oz.rda"))
ggmap(oz) +
  geom_point(data=platydata, aes(x=longitude, y=latitude),
              alpha=0.1, colour="orange")

## Your turn: density plot
ggmap(oz) +
  geom_density2d(data=platydata, aes(x=longitude, y=latitude),
             colour="orange")

## ----create a date variable, echo=TRUE-----------------------------------
library(lubridate)
platydata <- platydata %>%
  mutate(eventDate = ymd(eventDate))


## ----show sightings ovre time, echo=TRUE, out.width="60%"----------------
ggplot(data=platydata) +
  geom_point(aes(x=eventDate, y=1))

## ----focus on records since 1900 and count the number for each year, echo=TRUE, out.width="60%"----
platydata1900 <- platydata %>% filter(year>1900) %>%
  count(year)
ggplot(data=platydata1900) +
  geom_point(aes(x=year, y=n))

## ----add a trend line, echo=TRUE, out.width="60%"------------------------
ggplot(data=platydata1900, aes(x=year, y=n)) +
  geom_point() +
  geom_smooth(se=F)

## ----make it interactive to investigate some observations, echo=TRUE-----
library(plotly)
ggplotly()
