#' ---
#' title: Touring multivariate data
#' ---
#' 


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
source("../code/utils.R")


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
library(viridis)


ggplot(penguins, 
   aes(x=flipper_length_mm, 
       y=body_mass_g,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
  theme_bw() + 
  theme(aspect.ratio=1,
  legend.position="bottom")





# Pre-process the data
penguins_std <- penguins %>%
  rename(bl = bill_length_mm,
         bd = bill_depth_mm, 
         fl = flipper_length_mm, 
         bm = body_mass_g) %>%
  select(species, bl:bm) %>%
  na.omit() %>%
  mutate_if(is.numeric, function(x) (x-mean(x))/sd(x))


clrs <- scales::pal_hue()(3)
col <- clrs[as.numeric(penguins_std$species)]


# Run the tour
animate_xy(penguins_std[,2:5], 
           col=col, 
           axes="off", 
           fps=15)


# This code was used to make the animated gif
set.seed(20200622)
render_gif(penguins_std[,2:5], grand_tour(), 
           display_xy(col=col, axes="bottomleft"), 
           "images/penguins2d.gif", frames=100, width=400, height=400)


ggscatmat(penguins[,c(1,3:6)], columns = 2:5, color="species") + 
  theme(legend.position="bottom")


# Generate a plotly animation to demonstrate
library(plotly)
library(htmltools)

# Standardise data
scale2 <- function(x) {(x-mean(x))/sd(x)}
penguins_s <- penguins %>% 
  mutate_if(is.numeric, scale2)

# Generate sequence of bases
# set.seed(3)
set.seed(4)
random_start <- basis_random(4)
bases <- save_history(penguins_std[,2:5], grand_tour(2), 
    start=random_start, max = 5)
class(bases) <- "history_array"
# bases[,,1] <- random_start # something needs fixing
tour_path <- tourr::interpolate(bases, 0.1)
d <- dim(tour_path)

# Make really big data of all projections
penguins_d <- NULL; penguins_axes <- NULL
for (i in 1:d[3]) {
  fp <- as.matrix(penguins_s[,3:6]) %*% 
    matrix(tour_path[,,i], ncol=d[2])
  fp <- tourr::center(fp)
  colnames(fp) <- c("d1", "d2")
  penguins_d <- rbind(penguins_d, cbind(fp, rep(i+10, nrow(fp))))
  fa <- cbind(matrix(0, d[1], d[2]), 
              matrix(tour_path[,,i], ncol=d[2]))
  colnames(fa) <- c("origin1", "origin2", "d1", "d2") 
  penguins_axes <- rbind(penguins_axes, 
                         cbind(fa, rep(i+10, nrow(fa))))
}
colnames(penguins_d)[3] <- "indx"
colnames(penguins_axes)[5] <- "indx"

df <- as_tibble(penguins_d) %>% 
  mutate(species = rep(penguins_s$species, d[3]))
dfaxes <- as_tibble(penguins_axes) %>%
  mutate(labels=rep(colnames(penguins_s[,3:6]), d[3]))
dfaxes_mat <- dfaxes %>%
  mutate(xloc = rep(max(df$d1)+1, d[3]*d[1]), 
         yloc=rep(seq(-1.2, 1.2, 0.8), d[3]), 
         coef=paste(round(dfaxes$d1, 2), ", ", 
                    round(dfaxes$d2, 2)))
p <- ggplot() +
       geom_segment(data=dfaxes, 
                    aes(x=d1*2-5, xend=origin1-5, 
                        y=d2*2, yend=origin2, 
                        frame = indx), colour="grey70") +
       geom_text(data=dfaxes, aes(x=d1*2-5, y=d2*2, label=labels, 
                                  frame = indx), colour="grey70") +
       geom_point(data = df, aes(x = d1, y = d2, colour=species, 
                                 frame = indx), size=1) +
       geom_text(data=dfaxes_mat, aes(x=xloc, y=yloc, 
                                  label=coef, frame = indx)) + 
       theme_void() +
       coord_fixed() +
  theme(legend.position="none")
pg <- ggplotly(p, width=700, height=400) %>%
  animation_opts(200, redraw = FALSE, 
                 easing = "linear", transition=0)
save_html(pg, file="html/penguins.html")


ggplot(penguins, 
   aes(x=flipper_length_mm, 
       y=bill_depth_mm,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
  theme(aspect.ratio=1,
  legend.position="bottom")


ggplot(penguins, 
   aes(x=bill_length_mm, 
       y=body_mass_g,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
  theme(aspect.ratio=1,
  legend.position="bottom")


set.seed(2093467)
render_gif(penguins_std[,2:5], guided_tour(lda_pp(penguins_std$species)), 
           display_xy(col=col, axes="bottomleft"), 
           "images/penguins2d_guided.gif", 
           frames=100, width=400, height=400, loop=FALSE)


animate_xy(penguins_std[,2:5], grand_tour(),
           axes = "bottomleft", col=col)
set.seed(2022)
pp <- animate_xy(penguins_std[,2:5],
           guided_tour(lda_pp(penguins_std$species)),
           axes = "bottomleft", col=col)
best_proj <- pp$basis[length(pp$basis)][[1]] # Save the final projection


render_gif(data=penguins_std[,2:5],
           tour_path = radial_tour(as.matrix(best_proj), mvar = 2),
           display = display_xy(col = col),
           gif_file = "images/penguins_rt_bd.gif",
           apf = 1/20, 
           frames = 100, 
           width = 300, height = 300)

render_gif(data=penguins_std[,2:5],
           tour_path = radial_tour(as.matrix(best_proj), mvar = 1),
           display = display_xy(col = col),
           gif_file = "images/penguins_rt_bl.gif",
           apf = 1/20, 
           frames = 100, 
           width = 300, height = 300)

render_gif(data=penguins_std[,2:5],
           tour_path = radial_tour(as.matrix(best_proj), mvar = 3),
           display = display_xy(col = col),
           gif_file = "images/penguins_rt_fl.gif",
           apf = 1/20, 
           frames = 100, 
           width = 300, height = 300)

render_gif(data=penguins_std[,2:5],
           tour_path = radial_tour(as.matrix(best_proj), mvar = 4),
           display = display_xy(col = col),
           gif_file = "images/penguins_rt_bm.gif",
           apf = 1/20, 
           frames = 100, 
           width = 300, height = 300)



# Check contribution of bl, change mvar to switch variables
animate_xy(penguins_std[,2:5], 
           radial_tour(as.matrix(best_proj), mvar = 2),
           col = col)


render_gif(penguins_std[,2:5], local_tour(start=best_proj, 0.9), 
           display_xy(col=col, axes="bottomleft"), 
           "images/penguins2d_local.gif", 
           frames=200, width=400, height=400)


animate_xy(penguins_std[,2:5], local_tour(start=best_proj, 0.9),
           axes = "bottomleft", col=col)


library(geozoo)
sphere2 <- sphere.solid.random(p=4)$points %>% as_tibble()
animate_slice(sphere2, axes="bottomleft")


render_gif(sphere2, grand_tour(), 
           display_slice(axes="bottomleft"), 
           "images/sphere4d_solid_slice.gif", frames=100, width=400, height=400)



sphere1 <- sphere.hollow(p=4)$points %>% as_tibble()
animate_slice(sphere1, axes="bottomleft", half_range=0.6)


render_gif(sphere1, grand_tour(), 
           display_slice(axes="bottomleft", half_range=0.6), 
           "images/sphere4d_slice.gif", frames=100, width=400, height=400)


torus <- torus(p = 4, n = 5000, radius=c(8, 4, 1))$points %>% as_tibble()
animate_slice(torus, axes="bottomleft", half_range=0.8)


render_gif(torus, grand_tour(), 
           display_slice(axes="bottomleft", half_range=0.8), 
           "images/torus4d_slice.gif", frames=100, width=400, height=400)


cube1 <- cube.face(p=4)$points %>% as_tibble()
# Slicing needs data to be on a standard scale
cube1_std <- cube1 %>% 
  mutate(across(where(is.numeric),  ~ scale(.)[,1]))
animate_slice(cube1_std, axes="bottomleft")


render_gif(cube1_std, grand_tour(), 
           display_slice(axes="bottomleft"), 
           "images/cube4d_slice.gif", frames=100, width=400, height=400)


penguins_pca <- prcomp(penguins_std[,2:5], center = FALSE)
penguins_coefs <- penguins_pca$rotation[, 1:3]
penguins_scores <- penguins_pca$x[, 1:3]

animate_pca(penguins_scores, pc_coefs = penguins_coefs, col=col)


render_gif(penguins_scores, grand_tour(), 
           display_pca(pc_coefs = penguins_coefs, 
                       col=col, axes="bottomleft"), 
           "images/penguins2d_pca.gif", 
           frames=100, width=400, height=400)



render_gif(data=penguins_std[,2:5],
           tour_path = grand_tour(1),
           display = display_dist(half_range = 1.3),
           gif_file = "images/penguins1d.gif",
           apf = 1/20, 
           frames = 100, 
           width = 400, height = 400)
render_gif(penguins_std[,2:5], 
           tour_path = grand_tour(d=2), 
           display = display_density2d(col=col, axes="bottomleft"), 
           gif_file = "images/penguins2d_dens.gif", 
           apf = 1/20,
           frames=100,
           width=400, height=400)


animate_dist_cl(penguins_std[,2:5], half_range=1.3)
animate_density2d(penguins_std[,2:5], col=col, axes="bottomleft")


library(tourr)
data(flea)
?animate_xy
# On a Mac, start quartz window with:  quartz()
# On windows, start X11 window with:   X11()

animate_xy(flea[, 2:7])
# RStudio graphics windows: may want to reduce frame rate
animate_xy(flea[, 2:7], fps=10)


countdown::countdown(2,0)


clrs <- scales::pal_hue()(3)
col <- clrs[as.numeric(penguins_std$species)]
render_gif(    
  penguins_std[,2:5], 
  grand_tour(), 
  display_xy(col=col, 
             axes="bottomleft"), 
  gif_file="images/penguins2d.gif", 
  frames=100, 
  width=400, 
  height=400)


set.seed(209)
b <- basis_random(4, 2)
penguins_pct <- tourr::save_history(penguins_std[,2:5], 
                    tour_path = grand_tour(),
                    start = b,
                    max_bases = 5)
save(penguins_pct,
     file="../data/p_tour_path.rda")
penguins_pcti <- interpolate(penguins_pct, 0.2)
penguins_anim <- render_anim(penguins_std,
      vars = 2:5,
      frames=penguins_pcti,
      obs_labels=penguins_std$species)


penguins_gp <- ggplot() +
     geom_path(data=penguins_anim$circle, 
               aes(x=c1, y=c2,
                   frame=frame), linewidth=0.1) +
     geom_segment(data=penguins_anim$axes, 
                  aes(x=x1, y=y1, 
                      xend=x2, yend=y2, 
                      frame=frame), 
                  linewidth=0.1) +
     geom_text(data=penguins_anim$axes, 
               aes(x=x2, y=y2, 
                   frame=frame, 
                   label=axis_labels), 
               size=5) +
     geom_point(data=penguins_anim$frames, 
                aes(x=P1, y=P2, colour=species,
                    frame=frame, 
                    label=obs_labels), 
                alpha=0.8) +


     xlim(-1,1) + ylim(-1,1) +
     coord_equal() +
     theme_bw() +
     theme(legend.position = "none",
           axis.text=element_blank(),
         axis.title=element_blank(),
         axis.ticks=element_blank(),
         panel.grid=element_blank())
penguins_tour <- ggplotly(penguins_gp,
                        width=500,
                        height=550) %>%
       animation_button(label="Go") %>%
       animation_slider(len=0.8, x=0.5,
                        xanchor="center") %>%
       animation_opts(
         easing="linear", 
         transition = 0)
penguins_tour

htmlwidgets::saveWidget(penguins_tour,
          file="html/penguins.html",
          selfcontained = TRUE)


load(here::here("data/p_tour_path.rda"))
penguins_pcti <- interpolate(penguins_pct, 0.2)
f27 <- matrix(penguins_pcti[,,27], ncol=2)
p27 <- render_proj(penguins_std[,2:5],
          f27,
          obs_labels=penguins_std$species)


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
  xlim(-1,1) + ylim(-1, 1) +
  ggtitle("Frame 27") +
  theme_bw() +
  theme(aspect.ratio=1,
    legend.position = "none",
    axis.text=element_blank(),
    axis.title=element_blank(),
    axis.ticks=element_blank(),
    panel.grid=element_blank())


# pg27
ggplotly(pg27, width=450, height=450)

