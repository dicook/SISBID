## ----echo = FALSE----------------------------------------------
knitr::opts_chunk$set(
  echo=TRUE, 
  message = FALSE,
  warning = FALSE,
  error = FALSE,
  collapse = TRUE,
  comment = "",
  fig.height = 4,
  fig.width = 8,
  fig.align = "center",
  fig.retina = 3,
  cache = FALSE
)


## ----echo=FALSE------------------------------------------------
#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(GGally)
library(tourr)
library(broom)
library(plotly)
library(palmerpenguins)
library(ggpcp)
library(colorspace)
library(conflicted)
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::slice)
conflicts_prefer(dplyr::rename)
conflicts_prefer(palmerpenguins::penguins)
library(here)


## ----echo=FALSE------------------------------------------------
countdown::countdown(1,0)


## ----scatterplot matrix, echo=TRUE, eval=FALSE-----------------
## # Make a simple scatterplot matrix of the new penguins data
## stdd <- function(x) (x-mean(x))/sd(x)
## penguins <- penguins |>
##   filter(!is.na(bill_length_mm)) |>
##   rename(bl = bill_length_mm,
##          bd = bill_depth_mm,
##          fl = flipper_length_mm,
##          bm = body_mass_g) |>
##   mutate_at(vars(bl:bm), stdd)
## ggpairs(penguins, columns=c(3:6))


## ----ref.label="scatterplot matrix", echo=FALSE, fig.width=6, fig.height=6----


## ----scatterplot matrix with colour, echo=TRUE, fig.show='hide'----
# Re-make mapping colour to species (class)
ggpairs(penguins, columns=c(3:6), 
        ggplot2::aes(colour=species)) +
  scale_color_viridis_d(option = "plasma", begin=0.2, end=0.8) +
  scale_fill_viridis_d(option = "plasma", begin=0.2, end=0.8)


## ----ref.label="scatterplot matrix with colour", echo=FALSE, fig.width=6, fig.height=6----


## ----correlation heatmap, echo=TRUE, fig.show='hide'-----------
# Look at one species only
adelie <- penguins |> 
  filter(species == "Adelie") |>
  select(bl:bm)
ggcorr(adelie)


## ----ref.label="correlation heatmap", echo=FALSE, fig.width=4, fig.height=4, out.width="90%"----


## ----corrgram, echo=TRUE, fig.show='hide'----------------------
# install.packages("corrgram")
library(corrgram)
corrgram(adelie, 
  lower.panel=corrgram::panel.ellipse)


## ----ref.label="corrgram", echo=FALSE, fig.width=4, fig.height=4, out.width="90%"----


## ----hexbin scatterplot, fig.width=6, fig.height=6, eval=FALSE----
## # Data downloaded from https://archive.ics.uci.edu/dataset/401/gene+expression+cancer+rna+seq
## # This chunk takes some time to run, so evaluated off-line
## tcga <- data.table(read.csv(here("data/TCGA-PANCAN-HiSeq-801x20531/data.csv")))
## tcga_t <- t(as.matrix(tcga[,2:20532]))
## colnames(tcga_t) <- tcga$X
## tcga_t_pc <- prcomp(tcga_t, scale = FALSE)$x
## ggally_hexbin <- function (data, mapping, ...)  {
##     p <- ggplot(data = data, mapping = mapping) + geom_hex(binwidth=20, ...)
##     p
## }
## ggpairs(tcga_t_pc, columns=c(1:4),
##         lower = list(continuous = "hexbin")) +
##   scale_fill_gradient(trans="log",
##     low="#E24C80", high="#FDF6B5")


## ----generalised pairs plot, fig.show='hide'-------------------
# Matrix plot when variables are not numeric
data(australia_PISA2012)
australia_PISA2012 <- australia_PISA2012 |>
  mutate(desk = factor(desk), 
         room = factor(room),
         study = factor(study), 
         computer = factor(computer),
         software = factor(software), 
         internet = factor(internet),
         literature = factor(literature), 
         poetry= factor(poetry),
         art = factor(art), 
         textbook = factor(textbook),
         dictionary = factor(dictionary),
         dishwasher = factor(dishwasher))
australia_PISA2012 |> 
  filter(!is.na(dishwasher)) |> 
  ggpairs(columns=c(3, 15, 16, 21, 26))


## ----ref.label='generalised pairs plot', echo=FALSE, fig.width=6, fig.height=6, out.width="90%"----


## ----generalised pairs plot enhance plots, echo=TRUE, fig.width=6, fig.height=6----
# Modify the defaults, set the transparency of points since there is a lot of data
australia_PISA2012 |> 
  filter(!is.na(dishwasher)) |> 
  ggpairs(columns=c(3, 15, 16, 21, 26), 
          lower = list(continuous = wrap("points", alpha=0.05)))


## ----design own plot function----------------------------------
# Make a special style of plot to put in the matrix
my_fn <- function(data, mapping, method="loess", ...){
      p <- ggplot(data = data, mapping = mapping) + 
      geom_point(alpha=0.2, size=1) + 
      geom_smooth(method="lm", ...)
      p
}


## ----generalised pairs plot enhance more, echo=TRUE, fig.show='hide'----
australia_PISA2012 |> 
  filter(!is.na(dishwasher)) |> 
  ggpairs(columns=c(3, 15, 16, 21, 26), 
          lower = list(continuous = my_fn))



## ----ref.label='generalised pairs plot enhance more', echo=FALSE, fig.width=6, fig.height=6, outwidth="90%"----
australia_PISA2012 |> 
  filter(!is.na(dishwasher)) |> 
  ggpairs(columns=c(3, 15, 16, 21, 26), 
          lower = list(continuous = my_fn))



## ----echo=FALSE------------------------------------------------
countdown::countdown(8,0)


## ----echo=FALSE, eval=FALSE------------------------------------
## australia_PISA2012 |>
##   filter(!is.na(dishwasher)) |>
##   ggpairs(columns=c(3, 15, 16, 21, 26),
##           lower = list(combo = "box_no_facet"),
##           upper = list(continuous = "density"))


## ----wrangle housing data--------------------------------------
housing <- read_csv(here::here("data/housing.csv")) |>
  mutate(date = dmy(date)) |>
  mutate(year = year(date)) |>
  filter(year == 2016) |>
  filter(!is.na(bedroom2), !is.na(price)) |>
  filter(bedroom2 < 7, bathroom < 5) |>
  mutate(bedroom2 = factor(bedroom2), 
         bathroom = factor(bathroom)) 


## ----make a regression style pairs plot, out.width="100%", fig.width=8, fig.height=3----
ggduo(housing[, c(4,3,8,10,11)], 
      columnsX = 2:5, columnsY = 1, 
      aes(colour=type, fill=type), 
      types = list(continuous = 
                     wrap("smooth", 
                       alpha = 0.10)))


## ----generalised pcp, echo=TRUE, eval=FALSE, fig.width=6, fig.height=6----
## library(ggpcp)
## library(colorspace)
## penguins |>
##   pcp_select(species, bl:bm) |>
##   pcp_arrange() |>
##   ggplot(aes_pcp()) +
##     geom_pcp(aes(colour=species)) +
##     geom_pcp_boxes() +
##     geom_pcp_labels() +
##     scale_colour_discrete_divergingx(palette = "Zissou 1") +
##     theme_pcp() +
##     theme(legend.position = "none")


## ----ref.label='generalised pcp', echo=FALSE, eval=TRUE, fig.width=6, fig.height=6----


## ----organise data pcp, eval=FALSE, echo=FALSE-----------------
## tcga_t_pc_pcp <- tcga_t_pc |>
##   as_tibble() |>
##   pcp_select(PC1:PC10) |>
##   pcp_scale() |>
##   pcp_arrange()
## probs <- c(0.025, 0.25, 0.75, 0.975)
## 
## dframe <-
##   tcga_t_pc_pcp |>
##   summarise(
##     value = quantile(pcp_y, prob = probs),
##     quantile = probs,
##     lower = probs < 0.5,
##     level = round(10 * abs(quantile - 0.5), digits = 1)
##   ) |>
##   select(-quantile) |>
##   mutate(lower = factor(lower, labels = c("upper", "lower"))) |>
##   pivot_wider(names_from = "lower", values_from = "value") |>
##   ungroup() |>
##   mutate(
##     level = ifelse(level > 2.5, "Inner 95%", "Inner 50%"),
##     level = factor(level, levels = c("Inner 50%", "Inner 95%"))
##   )
## 
## tcga_t_pc_pcp_sub <- tcga_t_pc_pcp |>
##   slice_head(n=5)


## ----ribbon pcp, eval=FALSE------------------------------------
## ggplot() +
##     geom_ribbon(data = dframe,
##               aes(x=pcp_x, ymin = lower, ymax = upper,
##               group = level), alpha=0.5) +
##     geom_pcp_axes(data=tcga_t_pc_pcp_sub,
##              aes_pcp()) +
##     geom_pcp_boxes(data=tcga_t_pc_pcp_sub,
##              aes_pcp(), boxwidth = 0.1) +
##     geom_pcp(data=tcga_t_pc_pcp_sub,
##              aes_pcp(), colour="orange") +
##     theme_pcp()

