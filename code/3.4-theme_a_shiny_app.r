## ---- echo = FALSE, warning = FALSE, message = FALSE-----------------------------------------------------------------
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
library(ggplot2)
library(shiny)
library(bslib)

xaringanExtra::use_xaringan_extra(
  include = c("panelset")
)


## ---- eval = F-------------------------------------------------------------------------------------------------------
## title = div(
##   img(src = "wave.gif", width = "40px"),
##   img(src = "globe.png", width = "40px"),
##   "Hello World", style = "display: inline;"),


## ---- eval = F-------------------------------------------------------------------------------------------------------
## nav_panel(
##   title = "Dashboard", body,
##   icon = bs_icon("bar-chart", a11y = "deco")
##   # marks icon as decorative for screen readers
## ),


## ----eval = F--------------------------------------------------------------------------------------------------------
## side <- sidebar(
##   width = "20%",
##   h2("Inputs"),
##   sliderInput(
##     "mpg", label = "MPG range",
##     min = min(floor(mtcars$mpg), na.rm = T),
##     max = max(ceiling(mtcars$mpg), na.rm = T),
##     step = 1, value = range(mtcars$mpg))
## )

