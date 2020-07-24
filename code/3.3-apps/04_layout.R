library(shiny)
library(shinydashboard)


body <- dashboardBody(
  fluidRow(
  box(title = "Box with a width of 12 columns", width = 12,
      status = "primary", "The status of the box is primary"),
  box(title = "Box with a width of 6 columns", 
      status = "success", "Status is success! Something must have gone right",
      width = 6, height = 200),
  box(title = "Another box with a width of 6 columns", 
      status = "info", "the status of the box is 'info'. 
      Note how you can use single quotes?",
      width = 6, height = 200),
  box(title = "Box #4 - 6 columns wide", 
      status = "warning", "the status of the box indicates a 'warning'.",
      width = 6, height = 200),
  box(title = "Box #5 - 6 columns wide", 
      status = "danger", "Status is DANGER!",
      width = 6, height = 200)
  )
)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  body = body
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
