#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)
tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>%
    select(country, iso3, year, g_whoregion, new_sp_m04:new_sp_fu) %>%
    gather(stuff, count, new_sp_m04:new_sp_fu) %>%
    separate(stuff, c("stuff1", "stuff2", "sexage")) %>%
    select(-stuff1, -stuff2) %>%
    mutate(sex=substr(sexage, 1, 1),
           age=substr(sexage, 2, length(sexage))) %>%
    select(-sexage) %>%
    filter(year > 1996, year < 2013) %>%
    filter(!(age %in% c("04", "014", "514", "u")))

countries <- unique(tb$country)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("TB incidence by gender and age group"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel = (
            selectInput("country", label="country",
                        countries, selected = countries[3])
            ),

        # Show a plot of the generated distribution
        mainPanel(
           plotlyOutput("tbtrend")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$tbtrend <- renderPlotly({
        p <- tb %>% filter(country == input$country) %>%
            filter(!is.na(count)) %>%
            ggplot() +
            geom_point(aes(x=year, y=count, colour=sex, frame=age, label=iso3)) +
            geom_smooth(aes(x=year, y=count, colour=sex, frame=age),  se=FALSE) +
            scale_colour_brewer(palette = "Dark2")
        ggplotly(p)
        })
}

# Run the application
shinyApp(ui = ui, server = server)
