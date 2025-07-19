#' ---
#' title: Polish and share your own shiny app
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
library(ggplot2)
library(shiny)
library(bslib)


server <- function(input, output) {
    output$distPlot <- renderPlot({
        ggplot(faithful, aes(x=waiting)) + geom_histogram(bins = input$bins)
    })
}


server <- function(input, output) {

    output$distPlot <- renderPlotly({
        p <- ggplot(faithful, aes(x=waiting)) +
            geom_histogram(bins = input$bins)
        print(ggplotly(p))
    })
}


mainPanel(
  plotlyOutput("distPlot")
)


sidebarLayout(
  sidebarPanel(
    numericInput("bins", "nbins", 30)
  ),

