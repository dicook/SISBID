## ----echo = FALSE, message = FALSE, warning = FALSE, warning = FALSE----
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## ----------------------------------------------------------------------
# Better formatted penguins data
# data(penguins, package="palmerpenguins")
# Use default penguins
stdd <- function(x) (x-mean(x))/sd(x)
penguins_std <- penguins |>
  filter(!is.na(bill_len)) |>
  rename(bl = bill_len,
         bd = bill_dep,
         fl = flipper_len,
         bm = body_mass) |>
  mutate_at(vars(bl:bm), stdd) |>
  select(species, bl:bm)



## ----echo=FALSE--------------------------------------------------------
countdown::countdown(1,0)


## ----scatterplot matrix, echo=TRUE, eval=FALSE-------------------------
# ggpairs(penguins_std, columns=c(2:5))


## ----ref.label="scatterplot matrix", echo=FALSE, fig.width=6, fig.height=6----


## ----scatterplot matrix with colour, echo=TRUE, fig.show='hide'--------
# Re-make mapping colour to species (class)
ggpairs(penguins_std, columns=c(2:5), 
        ggplot2::aes(colour=species)) +
  scale_color_viridis_d(option = "plasma", begin=0.2, end=0.8) +
  scale_fill_viridis_d(option = "plasma", begin=0.2, end=0.8)


## ----ref.label="scatterplot matrix with colour", echo=FALSE, fig.width=6, fig.height=6----


## ----correlation heatmap, echo=TRUE, fig.show='hide'-------------------
# Look at one species only
adelie <- penguins_std |> 
  filter(species == "Adelie") |>
  select(bl:bm)
ggcorr(adelie)


## ----ref.label="correlation heatmap", echo=FALSE, fig.width=4, fig.height=4, out.width="90%"----


## ----corrgram, echo=TRUE-----------------------------------------------
#| output-location: "column"
corrgram(adelie, 
  lower.panel=
    corrgram::panel.ellipse)


## ----hexbin scatterplot, fig.width=6, fig.height=6, echo =T------------
#| eval: false
#| output-location: "column"
# # Data downloaded from https://archive.ics.uci.edu/dataset/401/gene+expression+cancer+rna+seq
# # This chunk takes some time to run, so evaluated off-line
# if (!file.exists(here("data", "TCGA-PANCAN-HiSeq-801x20531", "data.csv"))) {
#   download.file(url = "https://archive.ics.uci.edu/static/public/401/gene+expression+cancer+rna+seq.zip",
#                 destfile = here::here("data", "TCGA-PANCAN-HiSeq-801x20531.zip"), mode = "wb")
#   unzip(here::here("data", "TCGA-PANCAN-HiSeq-801x20531.zip"),
#         exdir = here::here("data/TCGA-PANCAN-HiSeq-801x20531/"))
#   # Untar into folder
#   untar(here::here("data/TCGA-PANCAN-HiSeq-801x20531/TCGA-PANCAN-HiSeq-801x20531.tar.gz"),
#         exdir = here("data"))
# }
# 
# tcga <- tibble(read.csv(here("data", "TCGA-PANCAN-HiSeq-801x20531", "data.csv")))
# 
# tcga_t <- t(as.matrix(tcga[,2:20532]))
# colnames(tcga_t) <- tcga$X
# tcga_t_pc <- prcomp(tcga_t, scale = FALSE)$x
# ggally_hexbin <- function (data, mapping, ...)  {
#     p <- ggplot(data = data, mapping = mapping) + geom_hex(binwidth=20, ...)
#     p
# }
# ggpairs(tcga_t_pc, columns=c(1:4),
#         lower = list(continuous = "hexbin")) +
#   scale_fill_gradient(trans="log",
#     low="#E24C80", high="#FDF6B5")


## ----generalised pairs plot, fig.show='hide', error=F, message = F, warning = F, echo = T----
#| output-location: "column"
# Matrix plot when variables are not numeric
data(australia_PISA2012)
australia_PISA2012 <- australia_PISA2012 %>%
  mutate(across(desk:dishwasher, factor))
australia_PISA2012 %>% 
  filter(!is.na(dishwasher)) %>% 
  ggpairs(columns=c(3, 15, 16, 21, 26))


## ----generalised pairs plot enhance plots, echo=TRUE, fig.width=6, fig.height=6----
#| output-location: 'column'
# Modify the defaults, set the transparency of points since there is a lot of data
australia_PISA2012 %>% 
  filter(!is.na(dishwasher)) %>% 
  ggpairs(
    columns=c(3, 15, 16, 21, 26), 
    lower = list(continuous = wrap("points", alpha=0.05)))


## ----generalised pairs plot enhance more, echo=TRUE, fig.show='hide'----
#| output-location: "column"

# Make a special style of plot to put in the matrix
my_fn <- function(data, mapping, method="loess", ...){
      p <- ggplot(data = data, mapping = mapping) + 
      geom_point(alpha=0.2, size=1) + 
      geom_smooth(method="lm", ...)
      p
}
australia_PISA2012 |> 
  filter(!is.na(dishwasher)) |> 
  ggpairs(columns=c(3, 15, 16, 21, 26), 
          lower = list(continuous = my_fn))



## ----ref.label='generalised pairs plot enhance more', echo=FALSE, fig.width=6, fig.height=6, outwidth="90%"----
australia_PISA2012 |> 
  filter(!is.na(dishwasher)) |> 
  ggpairs(columns=c(3, 15, 16, 21, 26), 
          lower = list(continuous = my_fn))



## ----echo=FALSE--------------------------------------------------------
countdown::countdown(8,0)


## ----echo=FALSE, eval=FALSE--------------------------------------------
# australia_PISA2012 |>
#   filter(!is.na(dishwasher)) |>
#   ggpairs(columns=c(3, 15, 16, 21, 26),
#           lower = list(combo = "box_no_facet"),
#           upper = list(continuous = "density"))


## ----wrangle housing data and make a regression style pairs plot, out.width="100%", fig.width=8, fig.height=3----
#| output-location: 'column'
housing <- read_csv(here::here("data/housing.csv")) |>
  mutate(date = dmy(date)) |>
  mutate(year = year(date)) |>
  filter(year == 2016) |>
  filter(!is.na(bedroom2), !is.na(price)) |>
  filter(bedroom2 < 7, bathroom < 5) |>
  mutate(bedroom2 = factor(bedroom2), 
         bathroom = factor(bathroom)) 
ggduo(housing[, c(4,3,8,10,11)], 
      columnsX = 2:5, columnsY = 1, 
      aes(colour=type, fill=type), 
      types = list(continuous = 
                     wrap("smooth", 
                       alpha = 0.10)))


## ----generalised pcp, fig.width=6, fig.height=6, eval=FALSE------------
#| output-location: "column"

# library(ggpcp)
# penguins_std |>
#   pcp_select(species, bl:bm) |>
#   pcp_arrange() |>
#   ggplot(aes_pcp()) +
#     geom_pcp(aes(colour=species)) +
#     geom_pcp_boxes() +
#     geom_pcp_labels() +
#     scale_colour_discrete_divergingx(palette = "Zissou 1") +
#     theme_pcp() +
#     theme(legend.position = "none")


## ----organise data pcp, eval=T, echo=FALSE, eval=FALSE-----------------
# tcga_t_pc_pcp <- tcga_t_pc |>
#   as_tibble() |>
#   pcp_select(PC1:PC10) |>
#   pcp_scale() |>
#   pcp_arrange()
# probs <- c(0.025, 0.25, 0.75, 0.975)
# 
# dframe <- tcga_t_pc_pcp |>
#   summarise(
#     value = quantile(pcp_y, prob = probs),
#     quantile = probs,
#     lower = probs < 0.5,
#     level = round(10 * abs(quantile - 0.5), digits = 1)
#   ) |>
#   select(-quantile) |>
#   mutate(lower = factor(lower, labels = c("upper", "lower"))) |>
#   pivot_wider(names_from = "lower", values_from = "value") |>
#   ungroup() |>
#   mutate(
#     level = ifelse(level > 2.5, "Inner 95%", "Inner 50%"),
#     level = factor(level, levels = c("Inner 50%", "Inner 95%"))
#   )
# 
# tcga_t_pc_pcp_sub <- tcga_t_pc_pcp |>
#   slice_head(n=5)


## ----ribbon pcp, eval=FALSE--------------------------------------------
#| output-location: "column"

# ggplot() +
#     geom_ribbon(data = dframe,
#               aes(x=pcp_x, ymin = lower, ymax = upper,
#               group = level), alpha=0.5) +
#     geom_pcp_axes(data=tcga_t_pc_pcp_sub,
#              aes_pcp()) +
#     geom_pcp_boxes(data=tcga_t_pc_pcp_sub,
#              aes_pcp(), boxwidth = 0.1) +
#     geom_pcp(data=tcga_t_pc_pcp_sub,
#              aes_pcp(), colour="orange") +
#     theme_pcp()


## ----eval=FALSE, echo=FALSE--------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("bigPint")


## ----soybean_scat, fig.show='hide', eval=FALSE-------------------------
# # if (!require("BiocManager", quietly = TRUE))
# #    install.packages("BiocManager")
# # BiocManager::install("bigPint")
# library(bigPint)
# data(soybean_ir_sub)
# soybean_ir_sub[,-1] <- log(soybean_ir_sub[,-1]+1)
# ggplot(soybean_ir_sub,
#        aes(x=N.1, y=P.1)) +
#   geom_point() +
#   theme(aspect.ratio=1)


## ----ref.label='soybean_scat', fig.width=4, fig.height=4, out.width="90%", echo=FALSE, eval=FALSE----
# NA


## ----soybean_litre, fig.show='hide', eval=FALSE------------------------
# geneList = soybean_ir_sub_metrics[["N_P"]][1:5,]$ID
# ret <- plotLitre(data = soybean_ir_sub,
#                  geneList = geneList,
#                  pointColor = "deeppink")
# names(ret)
# ret[["N_P_Glyma.19G168700.Wm82.a2.v1"]]


## ----ref.label='soybean_litre', fig.width=6, fig.height=6, out.width="90%", echo=FALSE, results='hide', eval=FALSE----
# NA


## ----soybean_litre_sm, fig.show='hide',eval=FALSE----------------------
# ret <- plotSM(soybean_cn_sub,
#               soybean_cn_sub_metrics,
#               option = "hexagon",
#               xbins = 5,
#               pointSize = 0.1,
#               saveFile = FALSE)
# ret[[2]]


## ----ref.label='soybean_litre_sm', fig.width=6, fig.height=6, out.width="110%", echo=FALSE, results='hide', eval=FALSE----
# NA


## ----soybean_pcp, fig.show='hide',eval=FALSE---------------------------
# ret <- plotPCP(data = soybean_ir_sub,
#                geneList = geneList,
#                lineSize = 0.3,
#                saveFile = FALSE)
# ret[[1]]


## ----ref.label='soybean_pcp', fig.width=6, fig.height=6, out.width="90%", echo=FALSE, results='hide',eval=FALSE----
# NA

