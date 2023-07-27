## ---- echo = FALSE, warning = FALSE, message = FALSE----------------------------------------------------------------
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
#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(xaringanExtra)

use_xaringan_extra(
  include = c("panelset")
)


## ---- eval = F------------------------------------------------------------------------------------------------------
## rval <- reactive({
##   ...
## })


## ---- eval = F------------------------------------------------------------------------------------------------------
## rval <- eventReactive(actionbutton, {
##   ...
## })


## ----eval = F-------------------------------------------------------------------------------------------------------
## runApp("03_submission/", display.mode = "showcase")


## ---- eval = F------------------------------------------------------------------------------------------------------
## card1 <- card(
##   card_header("Hi, I'm a card"),
##   class = "bg-primary",
##   "I contain some information - ",
##   "text, plot, image, input area...",
##   "your choice!")


## ---- eval = F------------------------------------------------------------------------------------------------------
## body <- page_fillable(
##   layout_columns(
##     col_widths = c(2, 4, 4, 2), # 12 cols per row
##     row_heights = "600px",
##     card1,
##     layout_columns(card2, card3, card5,
##                    col_widths = c(12, 12, 12),
##                    row_heights = "auto"),
##     card4, card6)
## )


## ---- eval = F------------------------------------------------------------------------------------------------------
## body <- page_fillable(
##   layout_columns(
##     col_widths = c(2, 4, 4, 2), # 12 cols per row
##     row_heights = "600px",
##     card1,
##     layout_columns(card2, card3, card5,
##                    col_widths = c(12, 12, 12),
##                    row_heights = "auto"),
##     card4, card6)
## )


## ---- eval = F------------------------------------------------------------------------------------------------------
## layout_column_wrap(
##   width = NULL, height = 300, fill = FALSE,
##   style = css(grid_template_columns = "2fr 1fr 2fr"),
##   card1, card2, card3
## )


## ----xaringan-panelset, echo=FALSE----------------------------------------------------------------------------------
xaringanExtra::use_panelset()

