#' ---
#' title: Interactive graphics
#' ---
#' 


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


#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(plotly)
library(gganimate)
library(datasauRus)


# Download cran data from metacran
library(cranlogs)
library(lubridate)


cran_dls <- cran_downloads(c("ggplot2", "plotly", "leaflet", "ggvis", "animint2", "rCharts", "gridSVG", "R2D3", "shiny", "crosstalk"), 
                           from = "2019-01-01", to = "2023-06-30")
write_csv(cran_dls, file = "../../data/package-info-Jul-2023.csv")


cran_dls <- read_csv(here::here("data/package-info-Jul-2023.csv"))
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


library(plotly)
plot_ly(data = economics, x = ~date, y = ~unemploy / pop)


gg <- ggplot(data=economics, aes(x = date, y = unemploy / pop)) +  
        geom_point() + geom_line()

ggplotly(gg)

#| output-location: column
library(GGally)
p <- ggpairs(economics[,3:6])
ggplotly(p, width=450, height=450)


data(canada.cities, package = "maps")
viz <- ggplot(canada.cities, aes(long, lat)) +
  borders(regions = "canada") +
  coord_equal() +
  geom_point(aes(text = name, size = log2(pop)), colour = "red", alpha = 1/4)


#viz
ggplotly(viz)


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


sd <- highlight_key(txhousing, ~year)

p <- ggplot(sd, aes(month, median)) +
   geom_line(aes(group = year)) + 
   geom_smooth(data = txhousing, method = "gam") + 
   facet_wrap(~ city)

gg <- ggplotly(p, height = 600, width = 1000) %>%
   plotly::layout(title = "Click on a line to highlight a year")

#p
highlight(gg)


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

#| output-location: column
ggplot(economics) #<<

#| output-location: column
ggplot(economics) +
  aes(date, unemploy) #<<

#| output-location: column
ggplot(economics) +
  aes(date, unemploy) +
  geom_line() #<<

#| output-location: column
ggplot(economics) +
  aes(date, unemploy) +
  geom_line() +
  transition_reveal(date) #<<

#| output-location: column
ggplot(datasaurus_dozen)#<<

#| output-location: column
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset)#<<

#| output-location: column
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) +
  geom_point() #<<

#| output-location: column
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) +
  geom_point() +
  facet_wrap(~dataset)#<<

#| output-location: column
ggplot(datasaurus_dozen) +
  aes(x, y) +
  geom_point() +
  transition_states(dataset, 3, 1) + #<<
  labs(title = "Dataset: {closest_state}") #<<



library(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7) +
  scale_colour_manual(values = country_colors, guide=FALSE) +
  scale_size("Population size", range = c(2, 12), breaks=c(1*10^8, 2*10^8, 5*10^8, 10^9, 2*20^9)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  theme(legend.position = "bottom")

