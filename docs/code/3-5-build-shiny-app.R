## ----echo = FALSE, message = FALSE, warning = FALSE, warning = FALSE----------
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## ----eval = F-----------------------------------------------------------------
# server <- function(input, output) {
#     output$distPlot <- renderPlot({
#         ggplot(faithful, aes(x=waiting)) + geom_histogram(bins = input$bins)
#     })
# }


## ----eval = F-----------------------------------------------------------------
# server <- function(input, output) {
# 
#     output$distPlot <- renderPlotly({
#         p <- ggplot(faithful, aes(x=waiting)) +
#             geom_histogram(bins = input$bins)
#         print(ggplotly(p))
#     })
# }


## ----eval = F-----------------------------------------------------------------
# mainPanel(
#   plotlyOutput("distPlot")
# )


## ----eval = F-----------------------------------------------------------------
# sidebarLayout(
#   sidebarPanel(
#     numericInput("bins", "nbins", 30)
#   ),

