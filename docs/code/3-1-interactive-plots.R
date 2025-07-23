#' ---
#' title: Interactive graphics
#' ---
#' 


#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(plotly)
library(gganimate)
library(datasauRus)
library(palmerpenguins)
library(lubridate)
library(ggthemes)
library(gapminder)
# Pre-process the data
data(penguins)
penguins <- penguins |> filter(!is.na(bill_length_mm))


cran_dls <- cran_downloads(c("ggplot2", "plotly", "leaflet", "ggvis", "animint2", "rCharts", "gridSVG", "R2D3", "shiny", "crosstalk"), 
                           from = "2018-01-01", to = "2025-07-22")
write_csv(cran_dls, file = here("data/package-info-Jul-2025.csv"))


cran_dls <- read_csv(here::here("data/package-info-Jul-2025.csv"))
cran_summary <- cran_dls %>%
  mutate(date = ymd(date) %>% floor_date("week")) %>%
  filter(date != "2025-07-20") |>
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


plot_ly(data = penguins, x = ~flipper_length_mm, y = ~bill_length_mm, 
  color = ~species, size = 3, width=420, height=300)


plot_ly(data = penguins, x = ~flipper_length_mm, y = ~bill_length_mm, 
  color = ~species, size = 3, width=650, height=490, type="scatter", mode="markers")


gg <- ggplot(data=penguins, aes(x = flipper_length_mm, y = bill_length_mm, colour = species)) +  
  geom_point(alpha=0.5) + geom_smooth(method = "lm", se=F)
ggplotly(gg, width=600, height=490)


library(GGally)
p <- ggpairs(penguins[,c(1, 3:5)], mapping = ggplot2::aes(color = species, alpha = 0.8))
ggplotly(p, width=600, height=490)


data(canada.cities, package = "maps")
viz <- ggplot(canada.cities, aes(long, lat)) +
  borders(regions = "canada") +
  coord_equal() +
  geom_point(aes(text = name, size = log2(pop)), 
             colour = "red", alpha = 1/4) +
  theme_map()


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

gg <- ggplotly(p, height = 800, width = 1000) %>%
   plotly::layout(title = "Click on a line to highlight a year")


highlight(gg)


ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7) +
  scale_colour_manual(values = country_colors) +
  scale_size("Population size", range = c(2, 12), breaks=c(1*10^8, 2*10^8, 5*10^8, 10^9, 2*20^9)) +
  scale_x_log10() +
  guides(colour = "none") +
  facet_wrap(~continent) +
  theme(legend.position = "bottom") +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  gganimate::transition_time(year) +
  gganimate::ease_aes('linear')

#| output-location: column
#| code-line-numbers: '1'
ggplot(economics) #<<

#| output-location: column
#| code-line-numbers: '2'
ggplot(economics) +
  aes(date, unemploy) #<<

#| output-location: column
#| code-line-numbers: '3'
ggplot(economics) +
  aes(date, unemploy) +
  geom_line() #<<

#| output-location: column
#| code-line-numbers: '4'
ggplot(economics) +
  aes(date, unemploy) +
  geom_line() +
  transition_reveal(date) #<<

#| output-location: column
#| code-line-numbers: '1'
ggplot(datasaurus_dozen)#<<

#| output-location: column
#| code-line-numbers: '2'
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) #<<

#| output-location: column
#| code-line-numbers: '3'
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) +
  geom_point() #<<

#| output-location: column
#| code-line-numbers: '4'
ggplot(datasaurus_dozen) +
  aes(x, y, color=dataset) +
  geom_point() +
  facet_wrap(~dataset) #<<

#| output-location: column
#| code-line-numbers: '4,5'
ggplot(datasaurus_dozen) +
  aes(x, y) +
  geom_point() +
  transition_states(dataset, 2, 3) + #<<
  labs(title = "Dataset: {closest_state}") #<<



ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7) +
  scale_colour_manual(values = country_colors) +
  scale_size("Population size", range = c(2, 12), breaks=c(1*10^8, 2*10^8, 5*10^8, 10^9, 2*20^9)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  theme(legend.position = "bottom") +
  guides(colour = "none") 

