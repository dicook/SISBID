#' ---
#' title: Theme a shiny app
#' ---
#' 


source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


title = div(
  img(src = "wave.gif", width = "40px"),
  img(src = "globe.png", width = "40px"),
  "Hello World", style = "display: inline;"),


nav_panel(
  title = "Dashboard", body, 
  icon = bs_icon("bar-chart", a11y = "deco") 
  # marks icon as decorative for screen readers
),


side <- sidebar(
  width = "20%",
  h2("Inputs"),
  sliderInput(
    "mpg", label = "MPG range",
    min = min(floor(mtcars$mpg), na.rm = T),
    max = max(ceiling(mtcars$mpg), na.rm = T),
    step = 1, value = range(mtcars$mpg))
)

