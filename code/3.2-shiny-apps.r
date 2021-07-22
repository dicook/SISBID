## ---- echo = FALSE, warning = FALSE, message = FALSE----------------------------
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
library(tidyverse)


## ----eval = FALSE---------------------------------------------------------------
## library(shiny)
## 
## ui <- fluidPage(
## )
## 
## server <- function(input, output, session) {
## }
## 
## shinyApp(ui, server)


## ----eval = FALSE---------------------------------------------------------------
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


## ----eval = FALSE---------------------------------------------------------------
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


## ----eval=FALSE-----------------------------------------------------------------
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

## ----echo=FALSE, eval=FALSE-----------------------------------------------------
## sidebar <- dashboardSidebar(
##   textInput("name", "Enter your name:", value = "Heike"),
##   selectInput("state", "Pick your favorite state:",
##               choices = c("Iowa", "Washington", "Michigan"))
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


## ----eval=FALSE-----------------------------------------------------------------
## sidebar <- dashboardSidebar(
##   textInput("name", "Enter your name:", value = "Heike"),
##   selectInput("state", "Pick your favorite state:",
##               choices = c("Iowa", "Washington", "Michigan"))
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


## ----echo=FALSE, eval=FALSE-----------------------------------------------------
## sidebar <- dashboardSidebar(
##   textInput("name", "Enter your name:", value = "Heike"),
##   selectInput("state", "Pick your favorite state:",
##               choices = c("Iowa", "Washington", "Michigan"))
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
##     mtcars %>% ggplot(aes(x = disp, y = mpg)) +
##       geom_point() +
##       ggtitle(input$state)
##   })
## }
## 
## shinyApp(ui, server)


## ----echo=FALSE, eval=FALSE-----------------------------------------------------
## library(ggplot2)
## library(dplyr)
## tb <- read_csv(here::here("data/tb.csv"))
## sidebar <- dashboardSidebar(
##   selectInput("country", "Pick a country:",
##               choices = unique(tb$iso2))
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
##     tb %>% filter(iso2 == input$country) %>%
##       pivot_longer(m_04:f_u,
##                    values_to="cases", names_to="sex_age") %>%
##       filter(!is.na(cases)) %>%
##       ggplot(aes(x = year, y = cases)) +
##       geom_line(aes(colour=sex_age))
##   })
## }
## 
## shinyApp(ui, server)

