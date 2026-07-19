## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## -----------------------------------------------------------------------------
#| eval: false
# rval <- reactive({
#   ...
# })


## -----------------------------------------------------------------------------
#| eval: false
# rval <- eventReactive(actionbutton, {
#   ...
# })


## -----------------------------------------------------------------------------
#| eval: false
# runApp("code/12-apps/03_submission/",
#        display.mode = "showcase")


## -----------------------------------------------------------------------------
#| eval: false
# card1 <- card(
#   card_header("Hi, I'm a card"),
#   class = "bg-primary",
#   "I contain some information - ",
#   "text, plot, image, input area...",
#   "your choice!")


## -----------------------------------------------------------------------------
#| eval: false
# body <- page_fillable(
#   layout_columns(
#     col_widths = c(2, 4, 4, 2), # 12 cols per row
#     row_heights = "600px",
#     card1,
#     layout_columns(card2, card3, card5,
#                    col_widths = c(12, 12, 12),
#                    row_heights = "auto"),
#     card4, card6)
# )


## -----------------------------------------------------------------------------
#| eval: false
# body <- page_fillable(
#   layout_columns(
#     col_widths = c(2, 4, 4, 2), # 12 cols per row
#     row_heights = "600px",
#     card1,
#     layout_columns(card2, card3, card5,
#                    col_widths = c(12, 12, 12),
#                    row_heights = "auto"),
#     card4, card6)
# )


## -----------------------------------------------------------------------------
#| eval: false
# layout_column_wrap(
#   width = NULL, height = 300, fill = FALSE,
#   style = css(grid_template_columns = "2fr 1fr 2fr"),
#   card1, card2, card3
# )


## -----------------------------------------------------------------------------
#| label: xaringan-panelset
#| echo: false
xaringanExtra::use_panelset()

