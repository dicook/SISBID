## ----echo=FALSE--------------------------------------------------------
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


## ----load libraries, echo=FALSE----------------------------------------
library(tidyverse)
library(ggmap)
library(here)


## ----make a word cloud of plot names, fig.width=10, fig.height=8, out.width="70%"----
library(wordcloud)
namedplots <- c("histogram", "barchart", "scatterplot", "piechart", "lineplot", "density_plot", "boxplot", "dendrogram", "treemap", "scatterplot_matrix", "parallel_coordinate_plot", "biplot", "contourplot", "stem_and_leafplot", "rug_plot", "dotplot", "mosaic_plot", "spine_plot", "forest_plot", "heatmap", "qqplot", "star_plot", "chernoff_face","graph", "beeswarm", "violin_plot", "tour", "choropleth_map", "glyph_map", "cartogram", "bubble_plot", "correlogram", "area_chart", "population_pyramid", "seasonal_plot", "frequency_polygon", "biplot", "profile_plot", "funnel_plot")
pal <- c("#A1719D","#03329B","#0774E4","#702E8D","#6B44B7","#B71452","#D50321","#F39E9C","#FCB52C","#B78ED2")
wordcloud(namedplots, freq = sample(1:10, length(namedplots), replace=TRUE), colors=pal)


## ----read TB data and wrangle and subset to USA------------------------
tb <- read_csv(here::here("data/TB_notifications_2020-07-01.csv")) %>%
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
  filter(year > 1996, year < 2013) %>%
  mutate(
    age_group = factor(age, labels = c("15-24", "25-34", "35-44", "45-54", "55-64", "65-"))
  )


## ----make a bar chart of US TB incidence, echo=TRUE, out.width="60%", fig.width=10, fig.height=3----
ggplot(tb_us, aes(x = year, y = count, fill = sex)) +
  geom_bar(stat = "identity") +
  facet_grid(~ age)


## ----eval=FALSE--------------------------------------------------------
- Incidence is declining, in all age groups, except possibly 15-24
- Much higher incidence for over 65s and 35-44 year olds
- We do not know the underlying population size
- There appears to be a structural change around 2008. Either a recording change or a policy change?
- Missing information for 1998 # no longer true
- Cannot compare counts for male/female using stacked bars, maybe fill to 100% to focus on proportion
- Colour scheme is not color blind proof, switch to colorbrewer Dark2 palette
- Axis labels, and tick marks?


## ----colour and axes fixes, echo=TRUE, fig.height=3--------------------
# This uses a color blind proof scale
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  facet_wrap(~age_group, ncol=6) +
  scale_fill_brewer("Sex", palette="Dark2")


## ----compare proportions of males/females, out.width="70%", echo=TRUE, fig.height=3----
# Fill the bars, note the small change to the code
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") +
  facet_wrap(~age_group, ncol=6) +
  scale_fill_brewer("Sex", palette="Dark2") + ylab("proportion")


## ----eval=FALSE--------------------------------------------------------
- Focus is now on proportions of male and female each year, within age group
- Proportions are similar across year
- Roughly equal proportions at young and old age groups, more male incidence in middle years


## ----side-by-side bars of males/females, fig.height=3, eval=FALSE, echo=FALSE----
# This code does something strange to the axis tick marks
# We will skip it for now
#ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
#  geom_bar(stat="identity", position="dodge") +
#  facet_wrap(~age, ncol=6) +
#  scale_fill_brewer("", palette="Dark2") +
#  scale_x_continuous("year", breaks=seq(1995, 2012, 5), labels=c("95", "00", "05", "10"))


## ----compare counts of males/females, out.width="100%", echo=TRUE, fig.height=5----
# Make separate plots for males and females, focus on counts by category
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  facet_wrap(sex~age_group, ncol=6) +
  scale_fill_brewer("", palette="Dark2")


## ----eval=FALSE--------------------------------------------------------
- Counts are generally higher for males than females
- There are very few female cases in the middle years
- Perhaps something of a older male outbreak in 2007-8, and possibly a young female outbreak in the same years


## ----rose plot of males/females, out.width="60%", echo=TRUE, fig.height=5----
# How to make a pie instead of a barchart - not straight forward
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  facet_wrap(sex~age_group, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  coord_polar()


## ----stacked barchart of males/females, out.width="60%", echo=TRUE, fig.height=5----
# Step 1 to make the pie
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") +
  facet_wrap(sex~age_group, ncol=6) +
  scale_fill_viridis_d("", option="inferno")


## ----pie chart of males/females, out.width="60%", echo=TRUE, fig.height=5----
# Now we have a pie, note the mapping of variables
# and the modification to the coord_polar
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") +
  facet_wrap(sex~age_group, ncol=6) +
  scale_fill_viridis_d("", option="inferno") +
  coord_polar(theta = "y")


## ----use a line plot instead of bar, fig.height=3----------------------
ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_wrap(~age_group, ncol=6) +
  scale_colour_brewer("", palette="Dark2")


## ----use a line plot of proportions, fig.height=3----------------------
tb_us %>% group_by(year, age_group) %>%
  summarise(p = count[sex=="m"]/sum(count)) %>%
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="white", size=2) +
  geom_line() + geom_point() +
  facet_wrap(~age_group, ncol=6) +
  ylab("proportion of males")

