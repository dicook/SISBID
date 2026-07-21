## ---------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## ---------------------------------------------------------------------------------
#| eval: false
# server <- function(input, output) {
#     output$distPlot <- renderPlot({
#         ggplot(faithful, aes(x=waiting)) + geom_histogram(bins = input$bins)
#     })
# }


## ---------------------------------------------------------------------------------
#| eval: false
# server <- function(input, output) {
# 
#     output$distPlot <- renderPlotly({
#         p <- ggplot(faithful, aes(x=waiting)) +
#             geom_histogram(bins = input$bins)
#         print(ggplotly(p))
#     })
# }


## ---------------------------------------------------------------------------------
#| eval: false
# mainPanel(
#   plotlyOutput("distPlot")
# )


## ---------------------------------------------------------------------------------
#| eval: false
# sidebarLayout(
#   sidebarPanel(
#     numericInput("bins", "nbins", 30)
#   ),

