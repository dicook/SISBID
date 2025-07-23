#' ---
#' title: Theme a shiny app
#' filters:
#' - quarto
#' - line-highlight
#' ---
#' 


# source(here::here("knitr-setup.R"))
# source(here::here("libraries.R"))


title = div(
  img(src = "wave.gif", 
      width = "40px"),
  img(src = "globe.png", 
      width = "40px"),
  "Hello World", 
  style = "display: inline;"),


nav_panel(
  title = "Dashboard", body, 
  icon = bs_icon("bar-chart", 
                 a11y = "deco") 
  # marks icon as decorative 
  # for screen readers
),

#| code-line-numbers: '2'
#| class-source: numberLines
side <- sidebar(
  width = "20%", h2("Inputs"), #<<
  sliderInput(
    "mpg", label = "MPG range", step = 1, value = range(mtcars$mpg)
    min = min(floor(mtcars$mpg), na.rm = T), max = max(ceiling(mtcars$mpg), na.rm = T),
))

