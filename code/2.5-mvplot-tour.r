## ----echo = FALSE----------------------------------------------------------------------------------------------------
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


## ----echo=FALSE------------------------------------------------------------------------------------------------------
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
library(ochRe)


## ----penguins, echo=TRUE, eval=FALSE, fig.show='hide'----------------------------------------------------------------
## ggplot(penguins,
##    aes(x=flipper_length_mm,
##        y=body_mass_g,
##        colour=species,
##        shape=species)) +
##   geom_point(alpha=0.7,
##              size=2) +
##   scale_colour_ochre(
##     palette="nolan_ned") +
##   theme(aspect.ratio=1,
##   legend.position="bottom")


## ----ref.label='penguins', echo=FALSE, fig.width=5, fig.height=5, out.width="100%"-----------------------------------


## --------------------------------------------------------------------------------------------------------------------
# Pre-process the data
penguins_std <- penguins %>%
  rename(bl = bill_length_mm,
         bd = bill_depth_mm, 
         fl = flipper_length_mm, 
         bm = body_mass_g) %>%
  select(species, bl:bm) %>%
  na.omit() %>%
  mutate_if(is.numeric, function(x) (x-mean(x))/sd(x))


## ----echo=TRUE, eval=FALSE-------------------------------------------------------------------------------------------
## # Run the tour
## clrs <- ochre_pal(
##   palette="nolan_ned")(3)
## col <- clrs[
##   as.numeric(
##     penguins$species)]
## animate_xy(penguins_std[,2:5],
##            col=col,
##            axes="off",
##            fps=15)


## ----eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------
## # This code was used to make the animated gif
## set.seed(20200622)
## clrs <- ochre_pal(palette="nolan_ned")(3)
## col <- clrs[as.numeric(penguins$species)]
## render_gif(penguins_std[,2:5], grand_tour(),
##            display_xy(col=col, axes="bottomleft"),
##            "penguins2d.gif", frames=100, width=300, height=300)


## ----echo=FALSE, out.width="100%", fig.width=6, fig.height=6, fig.retina=5-------------------------------------------
ggscatmat(penguins[,c(1,3:6)], columns = 2:5, color="species") + scale_colour_ochre(palette="nolan_ned") +
  theme(legend.position="bottom")


## ----reading axes, eval=FALSE, echo=FALSE----------------------------------------------------------------------------
## # Generate a plotly animation to demonstrate
## library(plotly)
## library(htmltools)
## 
## # Standardise data
## scale2 <- function(x) {(x-mean(x))/sd(x)}
## penguins_s <- penguins %>%
##   mutate_if(is.numeric, scale2)
## 
## # Generate sequence of bases
## # set.seed(3)
## set.seed(4)
## random_start <- basis_random(4)
## bases <- save_history(penguins_std[,2:5], grand_tour(2),
##     start=random_start, max = 5)
## bases[,,1] <- random_start # something needs fixing
## tour_path <- interpolate(bases, 0.1)
## d <- dim(tour_path)
## 
## # Make really big data of all projections
## penguins_d <- NULL; penguins_axes <- NULL
## for (i in 1:d[3]) {
##   fp <- as.matrix(penguins_s[,3:6]) %*%
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
## df <- as_tibble(penguins_d) %>%
##   mutate(species = rep(penguins_s$species, d[3]))
## dfaxes <- as_tibble(penguins_axes) %>%
##   mutate(labels=rep(colnames(penguins_s[,3:6]), d[3]))
## dfaxes_mat <- dfaxes %>%
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
##        scale_colour_ochre(palette="nolan_ned") +
##        geom_text(data=dfaxes_mat, aes(x=xloc, y=yloc,
##                                   label=coef, frame = indx)) +
##        theme_void() +
##        coord_fixed() +
##   theme(legend.position="none")
## pg <- ggplotly(p, width=700, height=400) %>%
##   animation_opts(200, redraw = FALSE,
##                  easing = "linear", transition=0)
## save_html(pg, file="penguins.html")


## ----runthis13, fig.width=4, fig.height=4, out.width="90%"-----------------------------------------------------------
ggplot(penguins, 
   aes(x=flipper_length_mm, 
       y=bill_depth_mm,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
  scale_colour_ochre(
    palette="nolan_ned") + 
  theme(aspect.ratio=1,
  legend.position="bottom")


## ----runthis14, fig.width=4, fig.height=4, out.width="90%"-----------------------------------------------------------
ggplot(penguins, 
   aes(x=bill_length_mm, 
       y=body_mass_g,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
  scale_colour_ochre(
    palette="nolan_ned") + 
  theme(aspect.ratio=1,
  legend.position="bottom")


## ----eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------
## clrs <- ochre_pal(
##   palette="nolan_ned")(3)
## col <- clrs[
##   as.numeric(
##     penguins$species)]
## set.seed(20200622)
## render_gif(penguins_std[,2:5], guided_tour(lda_pp(penguins$species)),
##            display_xy(col=col, axes="bottomleft"),
##            "penguins2d_guided.gif",
##            frames=17, width=300, height=300, loop=FALSE)


## ----runthis15, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------
## animate_xy(penguins_std[,2:5], grand_tour(),
##            axes = "bottomleft", col=col)
## animate_xy(penguins_std[,2:5], guided_tour(lda_pp(penguins$species)),
##            axes = "bottomleft", col=col)
## best_proj <- matrix(c(0.940, 0.058, -0.253, 0.767,
##                       -0.083, -0.393, -0.211, -0.504), ncol=2,
##                     byrow=TRUE)


## ----eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------
## mtour1 <- manual_tour(basis = best_proj, manip_var = 3)
## render_manual(penguins_s[,3:6], mtour1, "penguins_manual_fl.gif", col=col, dir = "images/manual1/")
## mtour2 <- manual_tour(basis = best_proj, manip_var = 1)
## render_manual(penguins_s[,3:6], mtour2, "penguins_manual_bl.gif", col=col, dir = "images/manual2")


## ----eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------
## render_gif(penguins_std[,2:5], local_tour(start=best_proj, 0.9),
##            display_xy(col=col, axes="bottomleft"),
##            "penguins2d_local.gif",
##            frames=200, width=300, height=300)


## ----runthis16, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------
## animate_xy(penguins_std[,2:5], local_tour(start=best_proj, 0.9),
##            axes = "bottomleft", col=col)


## ----eval=FALSE, echo=FALSE------------------------------------------------------------------------------------------
## render_gif(penguins_std[,2:5], grand_tour(),
##            display_dist(half_range=1.3),
##            "penguins1d.gif",
##            frames=100, width=400, height=300)
## render_gif(penguins_std[,2:5], grand_tour(),
##            display_density2d(col=col, axes="bottomleft"),
##            "penguins2d_dens.gif",
##            frames=100, width=300, height=300)


## ----runthis17, eval=FALSE, echo=FALSE-------------------------------------------------------------------------------
## animate_dist(penguins_std[,2:5], half_range=1.3)
## animate_density2d(penguins_std[,2:5], col=col, axes="bottomleft")


## ----eval=FALSE------------------------------------------------------------------------------------------------------
## library(tourr)
## data(flea)
## ?animate_xy
## # On a Mac, you may need to start a quartz graphics window
## # quartz()
## # On windows, you may need to start an X11 graphics window
## # X11()
## animate_xy(flea[, 1:6])
## # If you want to use your RStudio graphics window, it might show up better
## # if you reduce the frame rate for drawing.
## animate_xy(flea[, 1:6], fps=10)


## ----echo=FALSE------------------------------------------------------------------------------------------------------
countdown::countdown(2,0)


## ----eval=FALSE------------------------------------------------------------------------------------------------------
## render_gif(
##   penguins_std[,2:5],
##   grand_tour(),
##   display_xy(col=col,
##              axes="bottomleft"),
##   file="penguins2d.gif",
##   frames=100,
##   width=300,
##   height=300)


## ----eval=FALSE------------------------------------------------------------------------------------------------------
## set.seed(209)
## b <- basis_random(4, 2)
## penguins_pct <- tourr::save_history(penguins_std[,2:5],
##                     tour_path = grand_tour(),
##                     start = b,
##                     max_bases = 5)
## save(penguins_pct,
##      file="data/p_tour_path.rda")
## penguins_pcti <- interpolate(penguins_pct, 0.2)
## penguins_anim <- render_anim(penguins_std,
##       vars = 2:5,
##       frames=penguins_pcti,
##       obs_labels=penguins_std$species)


## ----eval=FALSE------------------------------------------------------------------------------------------------------
## penguins_gp <- ggplot() +
##      geom_path(data=penguins_anim$circle,
##                aes(x=c1, y=c2,
##                    frame=frame), linewidth=0.1) +
##      geom_segment(data=penguins_anim$axes,
##                   aes(x=x1, y=y1,
##                       xend=x2, yend=y2,
##                       frame=frame),
##                   linewidth=0.1) +
##      geom_text(data=penguins_anim$axes,
##                aes(x=x2, y=y2,
##                    frame=frame,
##                    label=axis_labels),
##                size=5) +
##      geom_point(data=penguins_anim$frames,
##                 aes(x=P1, y=P2, colour=species,
##                     frame=frame,
##                     label=obs_labels),
##                 alpha=0.8) +


## ----eval=FALSE------------------------------------------------------------------------------------------------------
##      xlim(-1,1) + ylim(-1,1) +
##      scale_colour_ochre(palette="nolan_ned") +
##      coord_equal() +
##      theme_bw() +
##      theme(legend.position = "none",
##            axis.text=element_blank(),
##          axis.title=element_blank(),
##          axis.ticks=element_blank(),
##          panel.grid=element_blank())
## penguins_tour <- ggplotly(penguins_gp,
##                         width=500,
##                         height=550) %>%
##        animation_button(label="Go") %>%
##        animation_slider(len=0.8, x=0.5,
##                         xanchor="center") %>%
##        animation_opts(
##          easing="linear",
##          transition = 0)
## penguins_tour
## 
## htmlwidgets::saveWidget(penguins_tour,
##           file="html/penguins.html",
##           selfcontained = TRUE)


## --------------------------------------------------------------------------------------------------------------------
load(here::here("data/p_tour_path.rda"))
penguins_pcti <- interpolate(penguins_pct, 0.2)
f27 <- matrix(penguins_pcti[,,27], ncol=2)
p27 <- render_proj(penguins_std[,2:5],
          f27,
          obs_labels=penguins_std$species)


## ----echo=FALSE------------------------------------------------------------------------------------------------------
p27$data_prj <- p27$data_prj %>%
  mutate(species = penguins_std$species)
pg27 <- ggplot() +
  geom_path(data=p27$circle, aes(x=c1, y=c2)) +
  geom_segment(data=p27$axes, aes(x=x1, y=y1, xend=x2, yend=y2)) +
  geom_text(data=p27$axes, aes(x=x2, y=y2, label=rownames(p27$axes))) +
  geom_point(data=p27$data_prj, 
             aes(x=P1, y=P2,
                 colour=species,
                 label=obs_labels)) +
  scale_colour_ochre(palette="nolan_ned") +
  xlim(-1,1) + ylim(-1, 1) +
  ggtitle("Frame 27") +
  theme_bw() +
  theme(aspect.ratio=1,
    legend.position = "none",
    axis.text=element_blank(),
    axis.title=element_blank(),
    axis.ticks=element_blank(),
    panel.grid=element_blank())


## ----echo=FALSE, out.width="80%", fig.width=7, fig.height=6----------------------------------------------------------
# pg27
ggplotly(pg27, width=450, height=450)

