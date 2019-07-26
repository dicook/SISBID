
## ----echo=FALSE----------------------------------------------------------
library(tidyverse)
library(plotly)
library(gganimate)
library(datasauRus)


## ---- echo=FALSE, fig.width=10, fig.height = 8---------------------------
interactive <- read_csv("../data/package-info-Jul-2019.csv")
inter.summary <- interactive %>%
  group_by(package) %>%
  summarise(maxdown = max(downloads),
            maxtime = start[which.max(downloads)])

interactive %>%
  filter(start < lubridate::ymd("2019-07-01")) %>%
  ggplot(aes(x = start, y = downloads, colour=package)) +
  geom_line() +
  theme_bw() +
  theme(legend.position="none") +
  geom_text(
    aes(x = maxtime, y = 1.05*maxdown, label=package),
    data = inter.summary %>% filter(maxdown > 10000)) +
  ylab("Monthly downloads") +
  xlab("Time")

## ----eval=FALSE----------------------------------------------------------
library(ggvis)
data("economics", package = "ggplot2")

ggvis(economics, x=~date, y=~psavert)


## ----eval=FALSE----------------------------------------------------------
economics %>%
  ggvis(~date, ~psavert) %>%
  layer_points() %>%
  layer_smooths()


## ----eval=FALSE----------------------------------------------------------
economics %>%
  ggvis(~date, ~psavert) %>%
  layer_points(opacity := 0.2) %>%
  layer_smooths(
    span = input_slider(0.2, 0.5),
    stroke := "red"
  )


## ---- echo =FALSE, eval=FALSE--------------------------------------------
economics %>%
  ggvis(~date, ~psavert) %>%
  layer_points(
    opacity := input_slider(0,1, label="opacity")) %>%
  layer_smooths(
    span = input_slider(0.02, 0.5, label="span"),
    stroke := "red"
  )


## ----eval=FALSE----------------------------------------------------------
all_values <- function(x) {
  if (is.null(x)) return(NULL)
  paste0(names(x), ": ", format(x), collapse = "<br />")
}

economics %>%
  ggvis(~unemploy, ~psavert) %>%
  layer_points() %>%
  add_tooltip(all_values, "hover")


## ----echo=FALSE, eval=FALSE----------------------------------------------
all_values <- function(x) {
  if (is.null(x)) return(NULL)
  paste0(names(x), ": ", format(x), collapse = "<br />")
}

economics %>%
  ggvis(~unemploy, ~psavert) %>%
  layer_points() %>%
  add_tooltip(all_values, "hover")


## ----eval=FALSE----------------------------------------------------------
model_type <- input_checkbox(label = "Use loess curve",
  map = function(val) if(val) "loess" else "lm")
economics %>%
  ggvis(~date, ~psavert) %>%
  layer_points() %>%
    layer_model_predictions(
        model = model_type)


## ----eval=FALSE----------------------------------------------------------
plot_ly(data = economics, x = ~date, y = ~unemploy / pop)


## ----echo=FALSE----------------------------------------------------------
plot_ly(data = economics, x = ~date, y = ~unemploy / pop)


## ------------------------------------------------------------------------
ggplot(data=economics, aes(x = date, y = unemploy / pop)) +
        geom_point() + geom_line()


## ------------------------------------------------------------------------
ggplotly()


## ----fig.width=6, fig.height=6-------------------------------------------
library(GGally)
p <- ggpairs(economics[,3:6])
ggplotly(p)


## ------------------------------------------------------------------------
data(canada.cities, package = "maps")
viz <- ggplot(canada.cities, aes(long, lat)) +
  borders(regions = "canada") +
  coord_equal() +
  geom_point(aes(text = name, size = log2(pop)), colour = "red", alpha = 1/4)
 ggplotly(viz)


## ----eval=FALSE----------------------------------------------------------
#devtools::install_github("ropenscilabs/eechidna")
library(eechidna)
launch_app(age = c("Age20_24", "Age85plus"),
  religion = c("Christianity", "Catholic", "NoReligion"),
  other = c("Unemployed", "AusCitizen", "MedianPersonalIncome")
)


## ---- echo=FALSE, fig.width = 8, fig.height = 6--------------------------
library(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7) +
  scale_colour_manual(values = country_colors, guide=FALSE) +
  scale_size("Population size", range = c(2, 12), breaks=c(1*10^8, 2*10^8, 5*10^8, 10^9, 2*20^9)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  theme(legend.position = "bottom") +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  gganimate::transition_time(year) +
  gganimate::ease_aes('linear')


## ----plot1, eval=FALSE, echo=TRUE----------------------------------------
ggplot(economics) #<<

## ----plot2, eval=FALSE, echo=TRUE----------------------------------------
ggplot(economics) +
  aes(date, unemploy) #<<

## ----plot3, eval=FALSE, echo=TRUE----------------------------------------
ggplot(economics) +
  aes(date, unemploy) +
  geom_line() #<<

## ----plot5-anim, eval=FALSE, echo=TRUE-----------------------------------
ggplot(economics) +
  aes(date, unemploy) +
  geom_line() +
  transition_reveal(date) #<<

## ----plot5, eval=FALSE, echo=TRUE----------------------------------------
ggplot(datasaurus_dozen)#<<

## ----plot6, eval=FALSE, echo=TRUE----------------------------------------
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset)#<<

## ----plot7, eval=FALSE, echo=TRUE----------------------------------------
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) +
  geom_point() #<<

## ----plot8, eval=FALSE, echo=TRUE----------------------------------------
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) +
  geom_point() +
  facet_wrap(~dataset)#<<

## ----plot9, eval=FALSE, echo=TRUE----------------------------------------
ggplot(datasaurus_dozen) +
  aes(x, y) +
  geom_point() +
  transition_states(dataset, 3, 1) + #<<
  labs(title = "Dataset: {closest_state}") #<<

## ------------------------------------------------------------------------
library(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7) +
  scale_colour_manual(values = country_colors, guide=FALSE) +
  scale_size("Population size", range = c(2, 12), breaks=c(1*10^8, 2*10^8, 5*10^8, 10^9, 2*20^9)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  theme(legend.position = "bottom")

## ---that's all folks----
