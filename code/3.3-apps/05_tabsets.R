library(shiny)
library(shinydashboard)
library(DT)


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
    ),
    
    tabItem(tabName = "cars",
            h2("What do you want to know about Cars?"),
            plotOutput("myplot"),
            DTOutput("mytable")
    )
  )
)

ui <- dashboardPage(
  dashboardHeader(title = "My really complex app"),
  sidebar = sidebar,
  body = body
)

server <- function(input, output, session) {
  output$myplot <- renderPlot({
    gg <- ggplot(data = mtcars, aes(x = mpg, y = disp)) +
      geom_point() 
    
    idx <- input$mytable_rows_selected
    if (!is.null(idx))
      gg + geom_point(size = 5, data = mtcars %>% slice(idx)) 
    else gg
  })
  
  output$mytable <- DT::renderDT({
    mtcars
  })
}

shinyApp(ui, server)
