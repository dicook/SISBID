## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
# source(here::here("knitr-setup.R"))
# source(here::here("libraries.R"))
library(shiny)
library(bsicons)
library(showtext)
library(ragg)
library(thematic)


## -----------------------------------------------------------------------------
#| eval: false
# # Additional packages for Shiny
# install.packages(c("bsicons", "showtext", "ragg", "thematic"))
# remotes::install_github("rstudio/bslib") # Get the latest version


## -----------------------------------------------------------------------------
#| echo: false
#| warning: false
#| message: false
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


## -----------------------------------------------------------------------------
#| eval: false
# ui <- fluidPage(
# )


## -----------------------------------------------------------------------------
server <- function(input, output, session) {
}


## -----------------------------------------------------------------------------
#| eval: false
#| echo: true
# library(shiny)
# 
# ui <- fluidPage(
# )
# 
# server <- function(input, output, session) {
# }
# 
# shinyApp(ui, server)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: true
# library(shiny)
# sidebar <-  sidebarPanel(width = 3, "Fun inputs")
# 
# main_col <- column(width = 9, "Some results")
# 
# ui <- fluidPage(
#   title = "App Title",
#   sidebar,
#   main_col
# )
# 
# server <- function(input, output, session) {
# }
# 
# shinyApp(ui, server)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: true
# library(shiny)
# sidebar <-  sidebarPanel(
#   width = 3,
#   textInput("name", "Enter your name:", value = "Susan")
# )
# 
# main_col <- column(width = 9, "Some results")
# 
# ui <- fluidPage(
#   title = "App Title",
#   sidebar,
#   main_col
# )
# 
# server <- function(input, output, session) {
# }
# 
# shinyApp(ui, server)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: true
# library(shiny)
# 
# sidebar <-  sidebarPanel(
#   width = 3,
#   textInput("name", "Enter your name:", value = "Susan")
# )
# 
# main_col <- column(width = 9, "Some results")
# 
# ui <- fluidPage(
#   title = "App Title",
#   sidebar,
#   main_col
# )
# 
# server <- function(input, output, session) {
# }
# 
# shinyApp(ui, server)


## -----------------------------------------------------------------------------
#| label: your-turn-solution
#| echo: false
#| eval: false

# library(shiny)
# 
# sidebar <-  sidebarPanel(
#   width = 3,
#   selectInput(
#     "country", "Pick your favorite country:",
#     choices = c("Australia", "Brazil", "China"))
# )
# 
# main_col <- column(width = 9, "Some results")
# 
# ui <- fluidPage(
#   title = "App Title",
#   sidebar,
#   main_col
# )
# 
# server <- function(input, output, session) {
# }
# 
# shinyApp(ui, server)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: true
#| code-line-numbers: "13-16,23-27"
#| class-source: "numberLines"
# library(shiny)
# library(ggplot2)
# library(dplyr)
# 
# sidebar <-  sidebarPanel(
#   width = 3,
#   selectInput(
#     "country", "Pick your favorite country:",
#               choices = c("Australia", "Brazil", "China")
#   )
# )
# 
# main_col <- column(                               #<<
#   width = 9,                                      #<<
#   plotOutput("scatter")                           #<<
# )                                                 #<<
# 
# ui <- fluidPage(
#   title = "App Title", sidebar, main_col
# )
# 
# server <- function(input, output, session) {
#   output$scatter <- renderPlot({                  #<<
#     mtcars %>% ggplot(aes(x = disp, y = mpg)) +   #<<
#       geom_point() +                              #<<
#       ggtitle(input$country)                      #<<
#   })                                              #<<
# }
# 
# shinyApp(ui, server)


## -----------------------------------------------------------------------------
#| label: your-turn-solutions-2
#| echo: false
#| eval: false
# library(shiny)
# library(ggplot2)
# library(dplyr)
# library(tidyr)
# tb <- read.csv(
#   here::here(
#     "data/TB_notifications_2025-07-22.csv"
#   )
# )
# 
# sidebar <-  sidebarPanel(
#   width = 3,
#   selectInput(
#     "country", "Pick a country:",
#     choices = unique(tb$country),
#     multiple = TRUE,
#     selected = "United States of America")
# )
# 
# main_col <- column(
#   width = 9,
#   plotOutput("scatter", height = "600px")
# )
# 
# ui <- fluidPage(
#   title = "App Title",
#   sidebar, main_col
# )
# 
# server <- function(input, output, session) {
#   output$scatter <- renderPlot({
#     tb %>%
#       filter(country %in% input$country) %>%
#       pivot_longer(new_sp_m04:new_sp_fu,
#                    values_to="cases", names_to="sex_age") %>%
#       filter(!is.na(cases)) %>%
#       ggplot(aes(x = year, y = cases)) +
#       geom_line(aes(colour=sex_age)) +
#       facet_grid(country~.)
#   })
# }
# 
# shinyApp(ui, server)

