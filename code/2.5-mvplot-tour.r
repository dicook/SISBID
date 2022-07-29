## ----echo = FALSE------------------------------------------------------------------
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


## ----echo=FALSE--------------------------------------------------------------------
library(tidyverse)
library(lubridate)
library(GGally)
# remotes::install_github("ggobi/tourr")
library(tourr)
library(plotly)
library(palmerpenguins)
# remotes::install_github("ropenscilabs/ochRe")
library(ochRe)

## ----penguins, echo=TRUE, eval=FALSE, fig.show='hide'-----
ggplot(penguins,
    aes(x=flipper_length_mm,
        y=body_mass_g,
        colour=species,
        shape=species)) +
   geom_point(alpha=0.7,
              size=2) +
  scale_colour_ochre(
     palette="nolan_ned") +
   theme(aspect.ratio=1,
   legend.position="bottom")

## ----ref.label='penguins', echo=FALSE, fig.width=5, fig.height=5, out.width="100%"----


## ----echo=TRUE, eval=FALSE---------------------------------------------------------
#> clrs <- ochre_pal(
#>   palette="nolan_ned")(3)
#> col <- clrs[
#>   as.numeric(
#>     penguins$species)]
#> animate_xy(penguins[,3:6],
#>            col=col,
#>            axes="off",
#>            fps=15)


## ----eval=FALSE, echo=FALSE--------------------------------------------------------
#> # This code was used to make the animated gif
#> set.seed(20200622)
#> clrs <- ochre_pal(palette="nolan_ned")(3)
#> col <- clrs[as.numeric(penguins$species)]
#> penguins <- penguins %>%
#>   rename(bl = bill_length_mm,
#>          bd = bill_depth_mm,
#>          fl = flipper_length_mm,
#>          bm = body_mass_g)
#> render_gif(penguins[,3:6], grand_tour(),
#>            display_xy(col=col, axes="bottomleft"),
#>            "penguins2d.gif", frames=100, width=300, height=300)


## ----reading axes, eval=FALSE, echo=FALSE------------------------------------------
#> # Generate a plotly animation to demonstrate
#> library(plotly)
#> library(htmltools)
#>
#> # Standardise data
#> scale2 <- function(x) {(x-mean(x))/sd(x)}
#> penguins_s <- penguins %>%
#>   mutate_if(is.numeric, scale2)
#>
#> # Generate sequence of bases
#> # set.seed(3)
#> set.seed(4)
#> random_start <- basis_random(4)
#> bases <- save_history(penguins[,3:6], grand_tour(2),
#>     start=random_start, max = 5)
#> bases[,,1] <- random_start # something needs fixing
#> tour_path <- interpolate(bases, 0.1)
#> d <- dim(tour_path)
#>
#> # Make really big data of all projections
#> penguins_d <- NULL; penguins_axes <- NULL
#> for (i in 1:d[3]) {
#>   fp <- as.matrix(penguins_s[,3:6]) %*%
#>     matrix(tour_path[,,i], ncol=d[2])
#>   fp <- tourr::center(fp)
#>   colnames(fp) <- c("d1", "d2")
#>   penguins_d <- rbind(penguins_d, cbind(fp, rep(i+10, nrow(fp))))
#>   fa <- cbind(matrix(0, d[1], d[2]),
#>               matrix(tour_path[,,i], ncol=d[2]))
#>   colnames(fa) <- c("origin1", "origin2", "d1", "d2")
#>   penguins_axes <- rbind(penguins_axes,
#>                          cbind(fa, rep(i+10, nrow(fa))))
#> }
#> colnames(penguins_d)[3] <- "indx"
#> colnames(penguins_axes)[5] <- "indx"
#>
#> df <- as_tibble(penguins_d) %>%
#>   mutate(species = rep(penguins_s$species, d[3]))
#> dfaxes <- as_tibble(penguins_axes) %>%
#>   mutate(labels=rep(colnames(penguins_s[,3:6]), d[3]))
#> dfaxes_mat <- dfaxes %>%
#>   mutate(xloc = rep(max(df$d1)+1, d[3]*d[1]),
#>          yloc=rep(seq(-1.2, 1.2, 0.8), d[3]),
#>          coef=paste(round(dfaxes$d1, 2), ", ",
#>                     round(dfaxes$d2, 2)))
#> p <- ggplot() +
#>        geom_segment(data=dfaxes,
#>                     aes(x=d1*2-5, xend=origin1-5,
#>                         y=d2*2, yend=origin2,
#>                         frame = indx), colour="grey70") +
#>        geom_text(data=dfaxes, aes(x=d1*2-5, y=d2*2, label=labels,
#>                                   frame = indx), colour="grey70") +
#>        geom_point(data = df, aes(x = d1, y = d2, colour=species,
#>                                  frame = indx), size=1) +
#>        scale_colour_ochre(palette="nolan_ned") +
#>        geom_text(data=dfaxes_mat, aes(x=xloc, y=yloc,
#>                                   label=coef, frame = indx)) +
#>        theme_void() +
#>        coord_fixed() +
#>   theme(legend.position="none")
#> pg <- ggplotly(p, width=700, height=400) %>%
#>   animation_opts(200, redraw = FALSE,
#>                  easing = "linear", transition=0)
#> save_html(pg, file="penguins.html")


## ----runthis13, fig.width=4, fig.height=4, out.width="90%"-------------------------
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

## ----runthis14, fig.width=4, fig.height=4, out.width="90%"-------------------------
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


## ----eval=FALSE, echo=FALSE--------------------------------------------------------
#> clrs <- ochre_pal(
#>   palette="nolan_ned")(3)
#> col <- clrs[
#>   as.numeric(
#>     penguins$species)]
#> set.seed(20200622)
#> render_gif(penguins[,3:6], guided_tour(lda_pp(penguins$species)),
#>            display_xy(col=col, axes="bottomleft"),
#>            "penguins2d_guided.gif",
#>            frames=17, width=300, height=300, loop=FALSE)


## ----runthis15, eval=FALSE, echo=FALSE---------------------------------------------
#> animate_xy(penguins[,3:6], grand_tour(),
#>            axes = "bottomleft", col=col)
#> animate_xy(penguins[,3:6], guided_tour(lda_pp(penguins$species)),
#>            axes = "bottomleft", col=col)
#> best_proj <- matrix(c(0.940, 0.058, -0.253, 0.767,
#>                       -0.083, -0.393, -0.211, -0.504), ncol=2,
#>                     byrow=TRUE)


## ----eval=FALSE, echo=FALSE--------------------------------------------------------
#> mtour1 <- manual_tour(basis = best_proj, manip_var = 3)
#> render_manual(penguins_s[,3:6], mtour1, "penguins_manual_fl.gif", col=col, dir = "images/manual1/")
#> mtour2 <- manual_tour(basis = best_proj, manip_var = 1)
#> render_manual(penguins_s[,3:6], mtour2, "penguins_manual_bl.gif", col=col, dir = "images/manual2")


## ----eval=FALSE, echo=FALSE--------------------------------------------------------
#> render_gif(penguins[,3:6], local_tour(start=best_proj, 0.9),
#>            display_xy(col=col, axes="bottomleft"),
#>            "penguins2d_local.gif",
#>            frames=200, width=300, height=300)


## ----runthis16, eval=FALSE, echo=FALSE---------------------------------------------
#> animate_xy(penguins[,3:6], local_tour(start=best_proj, 0.9),
#>            axes = "bottomleft", col=col)


## ----eval=FALSE, echo=FALSE--------------------------------------------------------
#> render_gif(penguins[,3:6], grand_tour(),
#>            display_dist(half_range=1.3),
#>            "penguins1d.gif",
#>            frames=100, width=400, height=300)
#> render_gif(penguins[,3:6], grand_tour(),
#>            display_density2d(col=col, axes="bottomleft"),
#>            "penguins2d_dens.gif",
#>            frames=100, width=300, height=300)


## ----runthis17, eval=FALSE, echo=FALSE---------------------------------------------
#> animate_dist(penguins[,3:6], half_range=1.3)
#> animate_density2d(penguins[,3:6], col=col, axes="bottomleft")


## ----eval=FALSE--------------------------------------------------------------------
#> library(tourr)
#> data(flea)
#> ?animate_xy
#> # On a Mac, you may need to start a quartz graphics window
#> # quartz()
#> # On windows, you may need to start an X11 graphics window
#> # X11()
#> animate_xy(flea[, 1:6])
#> # If you want to use your RStudio graphics window, it might show up better
#> # if you reduce the frame rate for drawing.
#> animate_xy(flea[, 1:6], fps=10)


## ----echo=FALSE--------------------------------------------------------------------
countdown::countdown(2,0)

