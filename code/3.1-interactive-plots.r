## ----echo = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  collapse = TRUE,
  comment = "#>",
  fig.height = 4,
  fig.width = 8,
  fig.align = "center",
  cache = FALSE
)

## ----echo=FALSE-----------------------------------------------------------
#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(plotly)
library(gganimate)
library(datasauRus)
library(ggthemes)
library(conflicted)
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::slice)
conflicts_prefer(palmerpenguins::penguins)
library(here)

library(palmerpenguins)
stdd <- function(x) (x-mean(x))/sd(x)
penguins <- penguins |>
  filter(!is.na(bill_length_mm)) |>
  rename(bl = bill_length_mm,
         bd = bill_depth_mm,
         fl = flipper_length_mm,
         bm = body_mass_g) |>
  mutate_at(vars(bl:bm), stdd) |>
  select(species, bl:bm)


## ----include = F----------------------------------------------------------
# Download cran data from metacran
library(cranlogs)
library(lubridate)

## ----include=F, eval=FALSE------------------------------------------------
## cran_dls <- cran_downloads(c("ggplot2", "plotly", "leaflet", "ggvis", "animint2", "rCharts", "gridSVG", "R2D3", "shiny", "crosstalk"),
##                            from = "2018-01-01", to = "2024-07-27")
## write_csv(cran_dls, file = here("data/package-info-Jul-2024.csv"))


## ----echo=FALSE, fig.width=10, fig.height = 8-----------------------------
cran_dls <- read_csv(here::here("data/package-info-Jul-2024.csv"))
cran_summary <- cran_dls %>%
  mutate(date = ymd(date) %>% floor_date("week")) %>%
  group_by(package, date) %>%
  summarise(totaldown = sum(count))

label_summary <- cran_summary %>%
  ungroup() %>%
  group_by(package) %>%
  filter(totaldown == max(totaldown))

cran_summary %>%
  ggplot(aes(x = date, y = totaldown, colour=package)) +
  geom_line() +
  theme_bw() +
  theme(legend.position="none") +
  geom_text(
    aes(x = date, y = 1.05*totaldown, label=package),
    data = label_summary) +
  ylab("Monthly downloads") +
  xlab("Time") +
  scale_y_log10()


## ----plotly---------------------------------------------------------------
library(plotly)
plot_ly(data = penguins, x = ~fl, y = ~bl,
  color = ~species, size = 3, width=420, height=300)


## -------------------------------------------------------------------------
gg <- ggplot(data=penguins, aes(x = fl, y = bl, colour = species)) +
  geom_point(alpha=0.5) + geom_smooth(method = "lm", se=F)
ggplotly(gg, width=390, height=300)


## ----scatterplotly, fig.show='hide'---------------------------------------
library(GGally)
p <- ggpairs(penguins, columns = 2:5,
             ggplot2::aes(colour = species))


## -------------------------------------------------------------------------
ggplotly(p, width=450, height=450)


## -------------------------------------------------------------------------
data(canada.cities, package = "maps")
viz <- ggplot(canada.cities, aes(long, lat)) +
  borders(regions = "canada") +
  coord_equal() +
  geom_point(aes(text = name, size = log2(pop)),
             colour = "red", alpha = 1/4) +
  theme_map()


## ----out.width="100%"-----------------------------------------------------
#viz
ggplotly(viz)


## ----eval=TRUE------------------------------------------------------------
txh_shared <- highlight_key(txhousing, ~year)

p <- ggplot(txh_shared, aes(month, median)) +
   geom_line(aes(group = year)) +
   geom_smooth(data = txhousing, method = "gam") +
   scale_x_continuous("", breaks=seq(1, 12, 1),
        labels=c("J", "F", "M", "A", "M", "J",
                 "J", "A", "S", "O", "N", "D")) +
   scale_y_continuous("Median price ('00,000)",
                      breaks = seq(0,300000,100000),
                      labels = seq(0,3,1)) +
   facet_wrap(~ city)

gg <- ggplotly(p, height = 600, width = 1000) %>%
   plotly::layout(title = "Click on a line to highlight a year")

#highlight(gg)


## ----echo=FALSE, out.width="70%", fig.height=10, fig.width=12-------------
sd <- highlight_key(txhousing, ~year)

p <- ggplot(sd, aes(month, median)) +
   geom_line(aes(group = year)) +
   geom_smooth(data = txhousing, method = "gam") +
   facet_wrap(~ city)

gg <- ggplotly(p, height = 600, width = 1000) %>%
   plotly::layout(title = "Click on a line to highlight a year")

#p
highlight(gg)


## ----echo=FALSE, fig.width = 8, fig.height = 6----------------------------
library(gapminder)
library(gganimate)

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


## ----plot1, eval=FALSE, echo=TRUE-----------------------------------------
## ggplot(economics) #<<


## ----plot1, echo=FALSE, fig.height = 6------------------------------------
ggplot(economics) #<<


## ----plot2, eval=FALSE, echo=TRUE-----------------------------------------
## ggplot(economics) +
##   aes(date, unemploy) #<<


## ----plot2, echo=FALSE, fig.height = 6------------------------------------
ggplot(economics) +
  aes(date, unemploy) #<<


## ----plot3, eval=FALSE, echo=TRUE-----------------------------------------
## ggplot(economics) +
##   aes(date, unemploy) +
##   geom_line() #<<


## ----plot3, echo=FALSE, fig.height = 6------------------------------------
ggplot(economics) +
  aes(date, unemploy) +
  geom_line() #<<


## ----plot5-anim, eval=FALSE, echo=TRUE------------------------------------
## ggplot(economics) +
##   aes(date, unemploy) +
##   geom_line() +
##   transition_reveal(date) #<<


## ----plot5-anim, echo=FALSE,  fig.height = 6------------------------------
ggplot(economics) +
  aes(date, unemploy) +
  geom_line() +
  transition_reveal(date) #<<


## ----plot5, eval=FALSE, echo=TRUE-----------------------------------------
## ggplot(datasaurus_dozen) #<<


## ----plot5, echo=FALSE, cache=TRUE, fig.height = 6------------------------
ggplot(datasaurus_dozen) #<<


## ----plot6, eval=FALSE, echo=TRUE-----------------------------------------
## ggplot(datasaurus_dozen) +
##   aes(x, y, color=dataset) #<<


## ----plot6, echo=FALSE, cache=TRUE, fig.height = 6------------------------
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) #<<


## ----plot7, eval=FALSE, echo=TRUE-----------------------------------------
## ggplot(datasaurus_dozen) +
##   aes(x, y, color=dataset) +
##   geom_point() #<<


## ----plot7, echo=FALSE, cache=TRUE, fig.height = 6------------------------
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) +
  geom_point() #<<


## ----plot8, eval=FALSE, echo=TRUE-----------------------------------------
## ggplot(datasaurus_dozen) +
##   aes(x, y, color=dataset) +
##   geom_point() +
##   facet_wrap(~dataset) #<<


## ----plot8, echo=FALSE, cache=TRUE, fig.height = 6------------------------
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) +
  geom_point() +
  facet_wrap(~dataset) #<<


## ----plot9, eval=FALSE, echo=TRUE-----------------------------------------
## ggplot(datasaurus_dozen) +
##   aes(x, y) +
##   geom_point() +
##   transition_states(dataset, 3, 1) + #<<
##   labs(title = "Dataset: {closest_state}") #<<
##


## ----plot9, echo=FALSE, cache=TRUE, fig.height = 6------------------------
ggplot(datasaurus_dozen) +
  aes(x, y) +
  geom_point() +
  transition_states(dataset, 3, 1) + #<<
  labs(title = "Dataset: {closest_state}") #<<



## ----fig.show='hide'------------------------------------------------------
library(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7) +
  scale_colour_manual(values = country_colors, guide=FALSE) +
  scale_size("Population size", range = c(2, 12), breaks=c(1*10^8, 2*10^8, 5*10^8, 10^9, 2*20^9)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  theme(legend.position = "bottom")

