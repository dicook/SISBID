## ---- echo = FALSE, warning = FALSE, message = FALSE---------------------------------
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


## ----eval = FALSE--------------------------------------------------------------------
## library(shiny)
## 
## ui <- fluidPage(
## )
## 
## server <- function(input, output, session) {
## }
## 
## shinyApp(ui, server)


## ----eval = FALSE--------------------------------------------------------------------
## library(shiny)
## library(shinydashboard)
## 
## ui <- dashboardPage(
##   dashboardHeader(),
##   dashboardSidebar(),
##   dashboardBody()
## )
## 
## server <- function(input, output, session) {
## }
## 
## shinyApp(ui, server)


## ----eval = FALSE--------------------------------------------------------------------
## library(shiny)
## library(shinydashboard)
## 
## sidebar <- dashboardSidebar(
##   textInput("name", "Enter your name:", value = "Heike")
## )
## 
## ui <- dashboardPage(
##   dashboardHeader(),
##   sidebar = sidebar,
##   dashboardBody()
## )
## 
## server <- function(input, output, session) {
## }
## 
## shinyApp(ui, server)


## ----eval=FALSE----------------------------------------------------------------------
## library(shiny)
## library(shinydashboard)
## 
## sidebar <- dashboardSidebar(
##   textInput("name", "Enter your name:", value = "Heike")
## )
## 
## ui <- dashboardPage(
##   dashboardHeader(),
##   sidebar = sidebar,
##   dashboardBody()
## )
## 
## server <- function(input, output, session) {
## }
## 
## shinyApp(ui, server)


## ----echo=FALSE, eval=FALSE----------------------------------------------------------
## sidebar <- dashboardSidebar(
##   textInput("name", "Enter your name:", value = "Heike"),
##   selectInput("state", "Pick your favorite country:",
##               choices = c("Australia", "United States", "Germany"))
## )
## 
## 
## ui <- dashboardPage(
##   dashboardHeader(),
##   sidebar = sidebar,
##   dashboardBody()
## )
## 
## server <- function(input, output, session) {
## }
## 
## shinyApp(ui, server)


## ----eval=FALSE----------------------------------------------------------------------
## sidebar <- dashboardSidebar(
##   textInput("name", "Enter your name:", value = "Heike"),
##   selectInput("country", "Pick your favorite country:",
##               choices = c("Australia", "United States", "Germany"))
## )
## 
## body <- dashboardBody(     #<<
##   plotOutput("scatter")    #<<
## )                          #<<
## 
## ui <- dashboardPage(
##   dashboardHeader(),
##   sidebar = sidebar,
##   body = body,
## )
## 
## server <- function(input, output, session) {
##   output$scatter <- renderPlot({                  #<<
##     mtcars %>% ggplot(aes(x = disp, y = mpg)) +   #<<
##       geom_point() +                              #<<
##       ggtitle(input$country)                      #<<
##   })
## }
## 
## shinyApp(ui, server)


## ----echo=FALSE, eval=FALSE----------------------------------------------------------
## library(ggplot2)
## library(dplyr)
## library(shinydashboard)
## tb <- read_csv(here::here("data/TB_notifications_2020-07-01.csv"))
## sidebar <- dashboardSidebar(
##   selectInput("country", "Pick a country:",
##               choices = unique(tb$country),
##               multiple = TRUE,
##               selected = "United States of America")
## )
## 
## body <- dashboardBody(
##   plotOutput("scatter")
## )
## 
## ui <- dashboardPage(
##   dashboardHeader(),
##   sidebar = sidebar,
##   body = body
## )
## 
## server <- function(input, output, session) {
##   output$scatter <- renderPlot({
##     tb %>% filter(country %in% input$country) %>%
##       pivot_longer(new_sp_m04:new_sp_fu,
##                    values_to="cases", names_to="sex_age") %>%
##       filter(!is.na(cases)) %>%
##       ggplot(aes(x = year, y = cases)) +
##       geom_line(aes(colour=sex_age)) +
##       facet_grid(country~.)
##   })
## }
## 
## shinyApp(ui, server)

