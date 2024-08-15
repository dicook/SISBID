## ----echo = FALSE-------------------------------------------------------------------------------
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


## ----echo=FALSE---------------------------------------------------------------------------------
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


## ----echo=FALSE---------------------------------------------------------------------------------
countdown::countdown(1,0)


## ----scatterplot matrix, fig.show='hide'--------------------------------------------------------
# Make a simple scatterplot matrix of the new penguins data
penguins <- penguins %>% filter(!is.na(bill_length_mm)) 
ggpairs(penguins, columns=c(3:6))


## ----ref.label="scatterplot matrix", echo=FALSE, fig.width=6, fig.height=6----------------------


## ----scatterplot matrix with colour, echo=TRUE, fig.show='hide'---------------------------------
# Re-make mapping colour to species (class)
ggpairs(penguins, columns=c(3:6), 
        ggplot2::aes(colour=species))


## ----ref.label="scatterplot matrix with colour", echo=FALSE, fig.width=6, fig.height=6----------


## ----correlation heatmap, echo=TRUE, fig.show='hide'--------------------------------------------
# Look at one species only
adelie <- penguins %>% 
  filter(species == "Adelie") %>%
  select(bill_length_mm:body_mass_g)
ggcorr(adelie)


## ----ref.label="correlation heatmap", echo=FALSE, fig.width=4, fig.height=4, out.width="90%"----


## ----corrgram, echo=TRUE, fig.show='hide'-------------------------------------------------------
# install.packages("corrgram")
library(corrgram)
corrgram(adelie, 
  lower.panel=corrgram::panel.ellipse)


## ----ref.label="corrgram", echo=FALSE, fig.width=4, fig.height=4, out.width="90%"---------------


## ----generalised pairs plot, fig.show='hide'----------------------------------------------------
# Matrix plot when variables are not numeric
data(australia_PISA2012)
australia_PISA2012 <- australia_PISA2012 %>%
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
australia_PISA2012 %>% 
  filter(!is.na(dishwasher)) %>% 
  ggpairs(columns=c(3, 15, 16, 21, 26))


## ----ref.label='generalised pairs plot', echo=FALSE, fig.width=6, fig.height=6, out.width="90%"----


## ----generalised pairs plot enhance plots, echo=TRUE, fig.width=6, fig.height=6-----------------
# Modify the defaults, set the transparency of points since there is a lot of data
australia_PISA2012 %>% 
  filter(!is.na(dishwasher)) %>% 
  ggpairs(columns=c(3, 15, 16, 21, 26), 
          lower = list(continuous = wrap("points", alpha=0.05)))


## ----design own plot function-------------------------------------------------------------------
# Make a special style of plot to put in the matrix
my_fn <- function(data, mapping, method="loess", ...){
      p <- ggplot(data = data, mapping = mapping) + 
      geom_point(alpha=0.2, size=1) + 
      geom_smooth(method="lm", ...)
      p
}


## ----generalised pairs plot enhance more, echo=TRUE, fig.show='hide'----------------------------
australia_PISA2012 %>% 
  filter(!is.na(dishwasher)) %>% 
  ggpairs(columns=c(3, 15, 16, 21, 26), 
          lower = list(continuous = my_fn))



## ----ref.label='generalised pairs plot enhance more', echo=FALSE, fig.width=6, fig.height=6, outwidth="90%"----
australia_PISA2012 %>% 
  filter(!is.na(dishwasher)) %>% 
  ggpairs(columns=c(3, 15, 16, 21, 26), 
          lower = list(continuous = my_fn))



## ----echo=FALSE---------------------------------------------------------------------------------
countdown::countdown(8,0)


## ----echo=FALSE, eval=FALSE---------------------------------------------------------------------
## australia_PISA2012 %>%
##   filter(!is.na(dishwasher)) %>%
##   ggpairs(columns=c(3, 15, 16, 21, 26),
##           lower = list(combo = "box_no_facet"),
##           upper = list(continuous = "density"))


## ----wrangle housing data-----------------------------------------------------------------------
housing <- read_csv(here::here("data/housing.csv")) %>%
  mutate(date = dmy(date)) %>%
  mutate(year = year(date)) %>%
  filter(year == 2016) %>%
  filter(!is.na(bedroom2), !is.na(price)) %>%
  filter(bedroom2 < 7, bathroom < 5) %>%
  mutate(bedroom2 = factor(bedroom2), 
         bathroom = factor(bathroom)) 


## ----make a regression style pairs plot, out.width="100%", fig.width=8, fig.height=3------------
ggduo(housing[, c(4,3,8,10,11)], 
      columnsX = 2:5, columnsY = 1, 
      aes(colour=type, fill=type), 
      types = list(continuous = 
                     wrap("smooth", 
                       alpha = 0.10)))


## ----eval=FALSE, echo=FALSE---------------------------------------------------------------------
## if (!requireNamespace("BiocManager", quietly = TRUE))
##     install.packages("BiocManager")
## BiocManager::install("bigPint")


## ----soybean_scat, fig.show='hide', eval=FALSE--------------------------------------------------
## # if (!require("BiocManager", quietly = TRUE))
## #    install.packages("BiocManager")
## # BiocManager::install("bigPint")
## library(bigPint)
## data(soybean_ir_sub)
## soybean_ir_sub[,-1] <- log(soybean_ir_sub[,-1]+1)
## ggplot(soybean_ir_sub,
##        aes(x=N.1, y=P.1)) +
##   geom_point() +
##   theme(aspect.ratio=1)


## ----ref.label='soybean_scat', fig.width=4, fig.height=4, out.width="90%", echo=FALSE, eval=FALSE----
## NA


## ----soybean_litre, fig.show='hide', eval=FALSE-------------------------------------------------
## geneList = soybean_ir_sub_metrics[["N_P"]][1:5,]$ID
## ret <- plotLitre(data = soybean_ir_sub,
##                  geneList = geneList,
##                  pointColor = "deeppink")
## names(ret)
## ret[["N_P_Glyma.19G168700.Wm82.a2.v1"]]


## ----ref.label='soybean_litre', fig.width=6, fig.height=6, out.width="90%", echo=FALSE, results='hide', eval=FALSE----
## NA


## ----soybean_litre_sm, fig.show='hide', eval=FALSE----------------------------------------------
## ret <- plotSM(soybean_cn_sub,
##               soybean_cn_sub_metrics,
##               option = "hexagon",
##               xbins = 5,
##               pointSize = 0.1,
##               saveFile = FALSE, eval=FALSE)
## ret[[2]]


## ----ref.label='soybean_litre_sm', fig.width=6, fig.height=6, out.width="110%", echo=FALSE, results='hide', eval=FALSE----
## NA


## ----soybean_pcp, fig.show='hide', eval=FALSE---------------------------------------------------
## ret <- plotPCP(data = soybean_ir_sub,
##                geneList = geneList,
##                lineSize = 0.3,
##                saveFile = FALSE)
## ret[[1]]


## ----ref.label='soybean_pcp', fig.width=6, fig.height=6, out.width="90%", echo=FALSE, results='hide', eval=FALSE----
## NA

