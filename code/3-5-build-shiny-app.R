#' ---
#' title: Polish and share your own shiny app
#' ---
#' 


source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


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

