## ---- echo = FALSE, warning = FALSE, message = FALSE---------------------
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


## ---- eval = F-----------------------------------------------------------
rval <- reactive({
  ...
})


## ---- eval = F-----------------------------------------------------------
rval <- eventReactive(actionbutton, {
  ...
})


## ----eval = F------------------------------------------------------------
runApp("03_submission/", display.mode = "showcase")


## ---- eval = F-----------------------------------------------------------
box(..., title = NULL, width = 6, height = NULL)


## ---- eval = F-----------------------------------------------------------
body <- dashboardBody(
  fluidRow(
    box(title = "Box with a width of 12 columns", 
        width = 12),
    box(title = "Box with a width of 6 columns", 
        width = 6, height = 200),
    box(title = "Another box with a width of 6 cols", 
        width = 6, height = 200), ...
  )
)


## ---- eval = F-----------------------------------------------------------
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", 
             icon = icon("dashboard")),
    menuItem("Cars", icon = icon("th"), tabName = "cars",
             badgeLabel = "new", badgeColor = "green")
  )
)


## ---- eval = F-----------------------------------------------------------

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Cars", icon = icon("th"), tabName = "cars",
             badgeLabel = "new", badgeColor = "green")
  )
)


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard",
            h2("Dashboard tab content"),
            fluidRow(
              # Boxes
              ...
            )
    ),
    
    tabItem(tabName = "cars",
            h2("What do you want to know about Cars?"),
            plotOutput("myplot"),
            DTOutput("mytable")
    )
  )
)

