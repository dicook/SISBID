---
title: "Polish and share your own shiny app"
subtitle: "SISBID 2021 <br> https://github.com/dicook/SISBID"
author: "Di Cook (dicook@monash.edu, @visnut) <br> Heike Hofmann (heike.hofmann@gmail.com, @heike_hh) <br> Susan VanderPlas (susan.vanderplas@unl.edu, @srvanderplas)"
date: "07/21-23/2021"
output:
  xaringan::moon_reader:
    css: ["default", "myremark.css"]
    self_contained: false
    nature:
      ratio: '16:9'
      highlightStyle: github
      highlightLines: true
      countIncrementalSlides: false
---

```{r, echo = FALSE, warning = FALSE, message = FALSE}
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
```

class: inverse middle

# Your turn

- Join forces with your neighbours or work alone
- You need to make your own app, or interactive document, on a topic of your choice
- Some ideas are data from [TidyTuesday](https://github.com/rfordatascience/tidytuesday) or [fivethirtyeight](https://github.com/fivethirtyeight/data)
- Your app needs to have 
    - at least one interactive plot
    - some GUI element like a menu or checkboxes
    - some nice styling

`r emo::ji("scream")` If this is too scary, work through the steps in the next few slides instead, to make an app.

---
# Initiate

`r emo::ji("white_check_mark")` Using the RStudio `File` menu, 

- choose `New file`, 
- choose "Shiny web app"
- Give it a name, and choose `Single file`

This will create a folder in your workspace with the same name as you gave your app. It will also open the `app.R` file in your text editor pane. 

`r emo::ji("stop_sign")` Click the `Run App` button on the RStudio window. 

`r emo::ji("white_check_mark")` Click `Publish` to upload your app to the shinyapps.io server. 

`r emo::ji("congratulations")` You've just published your first app

---
# Make it yours

Change the plot to use `ggplot`, this involves changing the server function to be this:

```{r eval = F}
server <- function(input, output) {

    output$distPlot <- renderPlot({
        ggplot(faithful, aes(x=waiting)) + geom_histogram(bins = input$bins)
    })
}
```

You will also need to add `library(ggplot2)` at the top of the file, just after `library(shiny)`.

`r emo::ji("stop_sign")` Click the `Run App` button on the RStudio window. (Fix any errors) 

`r emo::ji("white_check_mark")` Click `Publish` to re-upload your app to the shinyapps.io server. 

`r emo::ji("congratulations")` You've just published your first modifed app

---
# Make the plot interactive

Change from a static ggplot plot, to an interactive plotly plot, by 

1. changing the server function to look like this. Note `renderPlotly`

```{r eval = F}
server <- function(input, output) {

    output$distPlot <- renderPlotly({
        p <- ggplot(faithful, aes(x=waiting)) +
            geom_histogram(bins = input$bins)
        print(ggplotly(p))
    })
}
```

2. Changing the `ui` function to render plotly output

```{r eval = F}
mainPanel(
  plotlyOutput("distPlot")
)
```

3. Adding `library(plotly)` to the top of the file.

`r emo::ji("stop_sign")` Click the `Run App` button on the RStudio window. (Fix any errors) 

---
# Change the UI

Convert the slide into a numeric input, by changing the `ui` function to be:

```{r eval = F}
sidebarLayout(
  sidebarPanel(
    numericInput("bins", "nbins", 30)
  ),
```

(The `numericInput` replaces the `sliderInput` code)

`r emo::ji("stop_sign")` Click the `Run App` button on the RStudio window. (Fix any errors) 

`r emo::ji("white_check_mark")` Click `Publish` to re-upload your app to the shinyapps.io server. 

`r emo::ji("congratulations")` You've just published your second modifed app

---
# Share and share alike

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
