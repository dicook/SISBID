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
library(plotly)
library(palmerpenguins)
library(colorspace)
library(conflicted)
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::slice)
conflicts_prefer(dplyr::rename)
conflicts_prefer(palmerpenguins::penguins)
library(here)


## ----scatterplot matrix, echo=FALSE, eval=TRUE, fig.width=6, fig.height=6----
# Make a simple scatterplot matrix of the new penguins data
stdd <- function(x) (x-mean(x))/sd(x)
penguins <- penguins |> 
  filter(!is.na(bill_length_mm)) |>
  rename(bl = bill_length_mm,
         bd = bill_depth_mm,
         fl = flipper_length_mm,
         bm = body_mass_g) |>
  mutate_at(vars(bl:bm), stdd) |>
  select(species, bl:bm)
ggpairs(penguins, columns=c(2:5), 
        ggplot2::aes(colour=species)) +
  scale_color_discrete_divergingx(palette = "Zissou 1") +
  scale_fill_discrete_divergingx(palette = "Zissou 1")


## ----echo=TRUE, eval=FALSE-------------------------------------
## # Run the tour
## animate_xy(penguins[,2:5],
##            col=penguins$species,
##            axes="off",
##            fps=15)


## ----eval=FALSE, echo=FALSE------------------------------------
## # This code was used to make the animated gif
## set.seed(20200622)
## render_gif(penguins[,2:5], grand_tour(),
##            display_xy(col=penguins$species, axes="bottomleft"),
##            "penguins2d.gif", frames=100, width=300, height=300)


## ----echo=FALSE, out.width="100%", fig.width=6, fig.height=6, fig.retina=5----
ggscatmat(penguins, columns = 2:5, color="species") +   scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(legend.position="bottom")


## ----reading axes, eval=FALSE, echo=FALSE----------------------
## # Generate a plotly animation to demonstrate
## library(plotly)
## library(htmltools)
## 
## # Generate sequence of bases
## # set.seed(3)
## set.seed(4)
## random_start <- basis_random(4)
## bases <- save_history(penguins[,2:5], grand_tour(2),
##     start=random_start, max = 5)
## bases[,,1] <- random_start # something needs fixing
## tour_path <- interpolate(bases, 0.1)
## d <- dim(tour_path)
## 
## # Make really big data of all projections
## penguins_d <- NULL; penguins_axes <- NULL
## for (i in 1:d[3]) {
##   fp <- as.matrix(penguins[,2:5]) %*%
##     matrix(tour_path[,,i], ncol=d[2])
##   fp <- tourr::center(fp)
##   colnames(fp) <- c("d1", "d2")
##   penguins_d <- rbind(penguins_d, cbind(fp, rep(i+10, nrow(fp))))
##   fa <- cbind(matrix(0, d[1], d[2]),
##               matrix(tour_path[,,i], ncol=d[2]))
##   colnames(fa) <- c("origin1", "origin2", "d1", "d2")
##   penguins_axes <- rbind(penguins_axes,
##                          cbind(fa, rep(i+10, nrow(fa))))
## }
## colnames(penguins_d)[3] <- "indx"
## colnames(penguins_axes)[5] <- "indx"
## 
## df <- as_tibble(penguins_d) |>
##   mutate(species = rep(penguins$species, d[3]))
## dfaxes <- as_tibble(penguins_axes) |>
##   mutate(labels=rep(colnames(penguins[,2:5]), d[3]))
## dfaxes_mat <- dfaxes |>
##   mutate(xloc = rep(max(df$d1)+1, d[3]*d[1]),
##          yloc=rep(seq(-1.2, 1.2, 0.8), d[3]),
##          coef=paste(round(dfaxes$d1, 2), ", ",
##                     round(dfaxes$d2, 2)))
## p <- ggplot() +
##        geom_segment(data=dfaxes,
##                     aes(x=d1*2-5, xend=origin1-5,
##                         y=d2*2, yend=origin2,
##                         frame = indx), colour="grey70") +
##        geom_text(data=dfaxes, aes(x=d1*2-5, y=d2*2, label=labels,
##                                   frame = indx), colour="grey70") +
##        geom_point(data = df, aes(x = d1, y = d2, colour=species,
##                                  frame = indx), size=1) +
##          scale_colour_discrete_divergingx(palette = "Zissou 1") +
##        geom_text(data=dfaxes_mat, aes(x=xloc, y=yloc,
##                                   label=coef, frame = indx)) +
##        theme_void() +
##        coord_fixed() +
##   theme(legend.position="none")
## pg <- ggplotly(p, width=700, height=400) |>
##   animation_opts(200, redraw = FALSE,
##                  easing = "linear", transition=0)
## save_html(pg, file="penguins.html")


## ----runthis13, fig.width=4, fig.height=4, out.width="90%"-----
ggplot(penguins, 
   aes(x=fl, 
       y=bd,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
    scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(aspect.ratio=1,
  legend.position="bottom")


## ----runthis14, fig.width=4, fig.height=4, out.width="90%"-----
ggplot(penguins, 
   aes(x=bl, 
       y=bm,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
    scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(aspect.ratio=1,
  legend.position="bottom")


## ----eval=FALSE, echo=FALSE------------------------------------
## set.seed(20200622)
## render_gif(penguins[,2:5], guided_tour(lda_pp(penguins$species)),
##            display_xy(col=penguins$species,
##                       axes="bottomleft"),
##            "penguins2d_guided.gif",
##            frames=45, width=300, height=300, loop=FALSE)


## ----runthis15, eval=FALSE, echo=FALSE-------------------------
## animate_xy(penguins[,2:5], grand_tour(),
##            axes = "bottomleft", col=penguins$species)
## animate_xy(penguins[,2:5],
##            guided_tour(lda_pp(penguins$species)),
##            axes = "bottomleft", col=penguins$species)
## best_proj <- matrix(c(0.940, 0.058, -0.253, 0.767,
##                       -0.083, -0.393, -0.211, -0.504), ncol=2,
##                     byrow=TRUE)


## ----eval=FALSE, echo=FALSE------------------------------------
## render_gif(penguins[,2:5],
##            radial_tour(best_proj, mvar=3),
##            display_xy(col=penguins$species, axes="bottomleft"),
##            "penguins_manual_fl.gif",
##            frames=200, width=300, height=300)
## render_gif(penguins[,2:5],
##            radial_tour(best_proj, mvar=1),
##            display_xy(col=penguins$species, axes="bottomleft"),
##            "penguins_manual_bl.gif",
##            frames=200, width=300, height=300)


## ----eval=FALSE, echo=FALSE------------------------------------
## render_gif(penguins[,2:5],
##            local_tour(start=best_proj, 0.9),
##            display_xy(col=penguins$species, axes="bottomleft"),
##            "penguins2d_local.gif",
##            frames=200, width=300, height=300)


## ----runthis16, eval=FALSE, echo=FALSE-------------------------
## animate_xy(penguins[,2:5],
##            local_tour(start=best_proj, 0.9),
##            axes = "bottomleft", col=penguins$species)


## ----eval=FALSE------------------------------------------------
## library(tourr)
## data(flea)
## ?animate_xy
## animate_xy(flea[, 1:6])


## ----echo=FALSE------------------------------------------------
countdown::countdown(2,0)


## ----eval=FALSE------------------------------------------------
## render_gif(
##   penguins[,2:5],
##   grand_tour(),
##   display_xy(col=penguins$species,
##              axes="bottomleft"),
##   file="penguins2d.gif",
##   frames=100,
##   width=300,
##   height=300)


## --------------------------------------------------------------
load(here::here("data/p_tour_path.rda"))
penguins_pcti <- interpolate(penguins_pct, 0.2)
f27 <- matrix(penguins_pcti[,,27], ncol=2)
p27 <- render_proj(penguins[,2:5],
          f27,
          obs_labels=penguins$species)


## ----echo=FALSE------------------------------------------------
p27$data_prj <- p27$data_prj |>
  mutate(species = penguins$species)
pg27 <- ggplot() +
  geom_path(data=p27$circle, aes(x=c1, y=c2)) +
  geom_segment(data=p27$axes, aes(x=x1, y=y1, xend=x2, yend=y2)) +
  geom_text(data=p27$axes, aes(x=x2, y=y2, label=rownames(p27$axes))) +
  geom_point(data=p27$data_prj, 
             aes(x=P1, y=P2,
                 colour=species,
                 label=obs_labels)) +
  scale_colour_discrete_divergingx(palette = "Zissou 1") +
  xlim(-1,1) + ylim(-1, 1) +
  ggtitle("Frame 27") +
  theme_bw() +
  theme(aspect.ratio=1,
    legend.position = "none",
    axis.text=element_blank(),
    axis.title=element_blank(),
    axis.ticks=element_blank(),
    panel.grid=element_blank())


## ----echo=FALSE, out.width="80%", fig.width=7, fig.height=6----
# pg27
ggplotly(pg27, width=450, height=450)

