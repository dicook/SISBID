library(shiny)
library(bslib)

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
    col_widths = c(12, 6, 6, -1, 3, 5, 2, -1), # 12 cols per row
    row_heights = c("100px", "200px", "300px"),
    card1, card2, card3, card4, card5, card6)
)

ui <- page_fillable(
  title = "App Title",
  body
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
