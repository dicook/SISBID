## ----echo = FALSE--------------------------------------------------------------------
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


## /* custom.css */

## .left-code {

##   color: #777;

##   width: 48%;

##   height: 92%;

##   float: left;

## }

## .right-plot {

##   width: 50%;

##   float: right;

##   padding-left: 1%;

## }

## ----echo=FALSE----------------------------------------------------------------------
#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(plotly)
library(gganimate)
library(datasauRus)


## ---- include = F--------------------------------------------------------------------
# Download cran data from metacran
library(cranlogs)
library(lubridate)

## ---- include=F, eval=FALSE----------------------------------------------------------
## cran_dls <- cran_downloads(c("ggplot2", "plotly", "leaflet", "ggvis", "animint2", "rCharts", "gridSVG", "R2D3", "shiny", "crosstalk"),
##                            from = "2019-01-01", to = "2023-06-30")
## write_csv(cran_dls, file = "../../data/package-info-Jul-2023.csv")


## ---- echo=FALSE, fig.width=10, fig.height = 8---------------------------------------

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




## ----plotly--------------------------------------------------------------------------
library(plotly)
plot_ly(data = economics, x = ~date, y = ~unemploy / pop)


## ------------------------------------------------------------------------------------
gg <- ggplot(data=economics, aes(x = date, y = unemploy / pop)) +  
        geom_point() + geom_line()

ggplotly(gg)


## ----scatterplotly, fig.show='hide'--------------------------------------------------
library(GGally)
p <- ggpairs(economics[,3:6])


## ----out.width="80%"-----------------------------------------------------------------
ggplotly(p, width=450, height=450)


## ------------------------------------------------------------------------------------
data(canada.cities, package = "maps")
viz <- ggplot(canada.cities, aes(long, lat)) +
  borders(regions = "canada") +
  coord_equal() +
  geom_point(aes(text = name, size = log2(pop)), colour = "red", alpha = 1/4)


## ------------------------------------------------------------------------------------
viz
#ggplotly(viz)


## ----eval=FALSE----------------------------------------------------------------------
## txh_shared <- highlight_key(txhousing, ~year)
## 
## p <- ggplot(txh_shared, aes(month, median)) +
##    geom_line(aes(group = year)) +
##    geom_smooth(data = txhousing, method = "gam") +
##    scale_x_continuous("", breaks=seq(1, 12, 1),
##         labels=c("J", "F", "M", "A", "M", "J",
##                  "J", "A", "S", "O", "N", "D")) +
##    scale_y_continuous("Median price ('00,000)",
##                       breaks = seq(0,300000,100000),
##                       labels = seq(0,3,1)) +
##    facet_wrap(~ city)
## 
## gg <- ggplotly(p, height = 600, width = 1000) %>%
##    layout(title = "Click on a line to highlight a year")
## 
## highlight(gg)


## ----echo=FALSE, out.width="70%", fig.height=10, fig.width=12------------------------
sd <- highlight_key(txhousing, ~year)

p <- ggplot(sd, aes(month, median)) +
   geom_line(aes(group = year)) + 
   geom_smooth(data = txhousing, method = "gam") + 
   facet_wrap(~ city)

gg <- ggplotly(p, height = 600, width = 1000) %>%
   layout(title = "Click on a line to highlight a year")

p
#highlight(gg)


## ---- echo=FALSE, fig.width = 8, fig.height = 6--------------------------------------
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


## ----plot1, eval=FALSE, echo=TRUE----------------------------------------------------
## ggplot(economics) #<<


## ----output1, ref.label="plot1", echo=FALSE, cache=TRUE, fig.height = 6--------------


## ----plot2, eval=FALSE, echo=TRUE----------------------------------------------------
## ggplot(economics) +
##   aes(date, unemploy) #<<


## ----output2, ref.label="plot2", echo=FALSE, cache=TRUE, fig.height = 6--------------


## ----plot3, eval=FALSE, echo=TRUE----------------------------------------------------
## ggplot(economics) +
##   aes(date, unemploy) +
##   geom_line() #<<


## ----output3, ref.label="plot3", echo=FALSE, cache=TRUE, fig.height = 6--------------


## ----plot5-anim, eval=FALSE, echo=TRUE-----------------------------------------------
## ggplot(economics) +
##   aes(date, unemploy) +
##   geom_line() +
##   transition_reveal(date) #<<


## ----output5-anim, ref.label="plot5-anim", echo=FALSE, cache=TRUE, fig.height = 6----


## ----plot5, eval=FALSE, echo=TRUE----------------------------------------------------
## ggplot(datasaurus_dozen)#<<


## ----output5, ref.label="plot5", echo=FALSE, cache=TRUE, fig.height = 6--------------


## ----plot6, eval=FALSE, echo=TRUE----------------------------------------------------
## ggplot(datasaurus_dozen) +
##   aes(x, y, color=dataset)#<<


## ----output6, ref.label="plot6", echo=FALSE, cache=TRUE, fig.height = 6--------------


## ----plot7, eval=FALSE, echo=TRUE----------------------------------------------------
## ggplot(datasaurus_dozen) +
##   aes(x, y, color=dataset) +
##   geom_point() #<<


## ----output7, ref.label="plot7", echo=FALSE, cache=TRUE, fig.height = 6--------------


## ----plot8, eval=FALSE, echo=TRUE----------------------------------------------------
## ggplot(datasaurus_dozen) +
##   aes(x, y, color=dataset) +
##   geom_point() +
##   facet_wrap(~dataset)#<<


## ----output8, ref.label="plot8", echo=FALSE, cache=TRUE, fig.height = 6--------------


## ----plot9, eval=FALSE, echo=TRUE----------------------------------------------------
## ggplot(datasaurus_dozen) +
##   aes(x, y) +
##   geom_point() +
##   transition_states(dataset, 3, 1) + #<<
##   labs(title = "Dataset: {closest_state}") #<<
## 


## ----output9, ref.label="plot9", echo=FALSE, cache=TRUE, fig.height = 6--------------


## ----fig.show='hide'-----------------------------------------------------------------
library(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7) +
  scale_colour_manual(values = country_colors, guide=FALSE) +
  scale_size("Population size", range = c(2, 12), breaks=c(1*10^8, 2*10^8, 5*10^8, 10^9, 2*20^9)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  theme(legend.position = "bottom")

