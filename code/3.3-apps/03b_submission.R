library(shiny)
library(lubridate) # install.packages("lubridate")
library(tidyverse)
library(colourpicker)

ui <- fluidPage(
  h3("Submission Form"),
  textInput("name", "Enter your Name"),
  dateInput("date", "Enter your favorite day of the year", value=today()),
  actionButton("submit", "Submit"),
  colourInput("wheel", "Which colour should the points be?", value="#CCCCCC"),
  h2(textOutput("greeting")),
  plotOutput("histogram")
)

server <- function(input, output, session) {
  rval_favs <- eventReactive(input$submit, {
    if (!file.exists("favorite-days.csv")) {
      favs <- data.frame(name=input$name, date = input$date, stringsAsFactors = FALSE)
    } else {
      favs <- read.csv("favorite-days.csv", stringsAsFactors = FALSE)
      favs <- rbind(favs, data.frame(name=input$name, date = as.character(input$date), stringsAsFactors = FALSE))
    }
    favs <- favs %>% mutate(date = lubridate::ymd(date))
    write.csv(favs, "favorite-days.csv", row.names=FALSE)

    favs
  })
  
  
  output$greeting <- eventReactive(input$submit, {
    daysdiff <- today() - input$date
    if (daysdiff > 1) dateout <- paste0("it has been ", daysdiff, " days since your favorite day.")
    else if (daysdiff == 1) dateout <- paste0("yesterday was your favorite day, I hope you enjoyed it!")
    else if (daysdiff == 0) dateout <- paste0("today is your favorite day, how fabulous!")
    else if (daysdiff == -1) dateout <- paste0("tomorrow is your favorite day, how exciting!")
    else dateout <- paste0("it is ", -daysdiff, " days until your favorite day.")
    
    
    paste0("Hello ", input$name, ", ", dateout)
  })
  
  output$histogram <- renderPlot({
    gg <- ggplot() + ggtitle("When are our favorite days?") 
    if (nrow(rval_favs()) > 0) {
      gg <- gg +  geom_dotplot(aes(x = date), fill = input$wheel, binwidth = 7, data = rval_favs()) 
    }
    gg
  })
}

shinyApp(ui, server)