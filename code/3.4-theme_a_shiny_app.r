## ---- echo = FALSE, warning = FALSE, message = FALSE-----------------------------------------------------------------
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
library(shinydashboard)


## ----eval = F--------------------------------------------------------------------------------------------------------
## shinyApp(
##   ui = dashboardPage(
##     dashboardHeader(
##       title = "Example of a long title that needs more space",
##       titleWidth = 450
##     ),
##     dashboardSidebar(),
##     dashboardBody(
##       # Also add some custom CSS to make the title
##       # background area the same
##       # color as the rest of the header.
##       tags$head(tags$style(HTML('
##         .skin-blue .main-header .logo {
##           background-color: #3c8dbc;
##         }
##         .skin-blue .main-header .logo:hover {
##           background-color: #3c8dbc;
##         }
##       ')))
##     )
##   ),
##   server = function(input, output) { }
## )


## ----eval = F--------------------------------------------------------------------------------------------------------
## shinyApp(
##   ui = dashboardPage(
##     dashboardHeader(
##       title = "Title and sidebar 350 pixels wide",
##       titleWidth = 350
##     ),
##     dashboardSidebar(
##       width = 350,
##       sidebarMenu(
##         menuItem("Menu Item")
##       )
##     ),
##     dashboardBody()
##   ),
##   server = function(input, output) { }
## )


## ----eval = F--------------------------------------------------------------------------------------------------------
## shinyApp(
##   ui = dashboardPage(
##     dashboardHeader(
##       title = HTML(paste(icon("cog", lib="glyphicon"), "My app is a cog in the machine!")),
##       titleWidth = 450
##     ),
##     dashboardSidebar(),
##     dashboardBody()
##   ),
##   server = function(input, output) { }
## )

