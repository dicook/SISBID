library(shiny)
library(bslib)
library(DT)
library(ggplot2)

card1 <- card(
  card_header("Card in a single column"),
  class = "bg-primary",
  "The status of this box is primary")

card2 <- card(
  card_header("Card in 2 columns", class = "bg-secondary"),
  class = "border-secondary",
  "The status of this box is secondary, and the color is shown in the border.",
  markdown("Color in the header is added by using `class='bg-secondary'`"))

card3 <- card(
  card_header("Success Card"),
  class = "bg-success",
  "The status of the box is 'success'. Note how you can use single quotes?")

card4 <- card(
  card_header("Warning Card"),
  class = "bg-warning",
  card_body("The status of this box is warning"),
  card_body("I can have multiple card body pieces"),
  card_footer("I can also have a footer"))

card5 <- card(
  card_header("Danger!"),
  class = "bg-danger",
  "The status of this box is danger")

card6 <- card(
  card_header("Info"),
  class = "bg-info",
  "The status of this box is info")

body <- page_fillable(
  layout_columns(
    col_widths = c(2, 4, 4, 2), # 12 cols per row
    row_heights = "600px",
    card1,
    layout_columns(card2, card3, card5,
                   col_widths = c(12, 12, 12),
                   row_heights = "auto"),
    card4, card6)
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


ui <- page_fillable(
  navset_pill_list(
    nav_panel(title = h2("App Title"), "Some information about my app"),
    nav_panel(title = "Dashboard", body),
    nav_panel(title = "Cars",
              h2("What do you want to know about Cars?"),
              plotOutput("myplot"),
              DTOutput("mytable")),
    widths = c(2, 10)
  )
)

shinyApp(ui, server)


