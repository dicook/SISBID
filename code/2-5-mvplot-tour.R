## -----------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


## -----------------------------------------------------------------------------
#| echo: false
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


## -----------------------------------------------------------------------------
#| label: scatterplot matrix
#| echo: false
#| eval: true
#| fig-width: 6
#| fig-height: 6
# Make a simple scatterplot matrix of the new penguins data
ggpairs(penguins_std, columns=c(2:5), 
        ggplot2::aes(colour=species)) +
  scale_color_discrete_divergingx(palette = "Zissou 1") +
  scale_fill_discrete_divergingx(palette = "Zissou 1")


## -----------------------------------------------------------------------------
#| echo: true
#| eval: false
# # Run the tour
# animate_xy(penguins_std[,2:5],
#            col=penguins_std$species,
#            axes="off",
#            fps=10)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false
# # This code was used to make the animated gif
# set.seed(20200622)
# render_gif(penguins_std[,2:5],
#            grand_tour(),
#            display_xy(col=penguins_std$species,
#                       axes="bottomleft"),
#            gif_file = "slides/images/penguins2d.gif",
#            apf = 1/20,
#            frames=100,
#            width=400,
#            height=400)


## -----------------------------------------------------------------------------
#| echo: false
#| out-width: 100%
#| fig-width: 6
#| fig-height: 6
#| fig-retina: 5
ggscatmat(penguins_std, columns = 2:5, color="species") +  
    scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(legend.position="bottom")


## -----------------------------------------------------------------------------
#| label: reading-axes
#| eval: false
#| echo: false
# # Generate a plotly animation to demonstrate
# library(plotly)
# library(htmltools)
# 
# # Generate sequence of bases
# # set.seed(3)
# set.seed(4)
# random_start <- basis_random(4)
# bases <- save_history(penguins_std[,2:5], grand_tour(2),
#     start=random_start, max = 5)
# class(bases) <- "history_array"
# # bases[,,1] <- random_start # something needs fixing
# tour_path <- tourr::interpolate(bases, 0.1)
# d <- dim(tour_path)
# 
# # Make really big data of all projections
# penguins_d <- NULL; penguins_axes <- NULL
# for (i in 1:d[3]) {
#   fp <- as.matrix(penguins_std[,2:5]) %*%
#     matrix(tour_path[,,i], ncol=d[2])
#   fp <- tourr::center(fp)
#   colnames(fp) <- c("d1", "d2")
#   penguins_d <- rbind(penguins_d, cbind(fp, rep(i+10, nrow(fp))))
#   fa <- cbind(matrix(0, d[1], d[2]),
#               matrix(tour_path[,,i], ncol=d[2]))
#   colnames(fa) <- c("origin1", "origin2", "d1", "d2")
#   penguins_axes <- rbind(penguins_axes,
#                          cbind(fa, rep(i+10, nrow(fa))))
# }
# colnames(penguins_d)[3] <- "indx"
# colnames(penguins_axes)[5] <- "indx"
# 
# df <- as_tibble(penguins_d) |>
#   mutate(species = rep(penguins_std$species, d[3]))
# dfaxes <- as_tibble(penguins_axes) |>
#   mutate(labels=rep(colnames(penguins_std[,2:5]), d[3]))
# dfaxes_mat <- dfaxes |>
#   mutate(xloc = rep(max(df$d1)+1, d[3]*d[1]),
#          yloc=rep(seq(-1.2, 1.2, 0.8), d[3]),
#          coef=paste(round(dfaxes$d1, 2), ", ",
#                     round(dfaxes$d2, 2)))
# p <- ggplot() +
#        geom_segment(data=dfaxes,
#                     aes(x=d1*2-5, xend=origin1-5,
#                         y=d2*2, yend=origin2,
#                         frame = indx), colour="grey70") +
#        geom_text(data=dfaxes, aes(x=d1*2-5, y=d2*2, label=labels,
#                                   frame = indx), colour="grey70") +
#        geom_point(data = df, aes(x = d1, y = d2, colour=species,
#                                  frame = indx), size=1) +
#        geom_text(data=dfaxes_mat, aes(x=xloc, y=yloc,
#                                   label=coef, frame = indx)) +
#        scale_colour_discrete_divergingx(palette = "Zissou 1") +
#        theme_void() +
#        coord_fixed() +
#   theme(legend.position="none")
# pg <- ggplotly(p, width=1100, height=700) |>
#   animation_opts(200, redraw = FALSE,
#                  easing = "linear", transition=0)
# save_html(pg, file="html/penguins.html", libdir="lib")


## -----------------------------------------------------------------------------
#| label: runthis1
#| fig-width: 4
#| fig-height: 4
#| out-width: 80%
ggplot(penguins_std, 
   aes(x=fl, y=bd,
       colour=species)) +
  geom_point(alpha=0.7, size=2) +
  scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(aspect.ratio=1,
  legend.position="bottom") 


## -----------------------------------------------------------------------------
#| label: runthis2
#| fig-width: 4
#| fig-height: 4
#| out-width: 80%
ggplot(penguins_std, 
   aes(x=bl, y=bm,
       colour=species)) +
  geom_point(alpha=0.7, size=2) +
  scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(aspect.ratio=1,
  legend.position="bottom")


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false
# set.seed(20694727)
# render_gif(penguins_std[,2:5], guided_tour(lda_pp(penguins_std$species)),
#            display_xy(col=penguins_std$species,
#                       axes="bottomleft"),
#            "slides/images/penguins2d_guided.gif",
#            frames=34, width=400, height=400, loop=FALSE)


## -----------------------------------------------------------------------------
#| label: runthis3
#| eval: false
#| echo: false
# animate_xy(penguins_std[,2:5], grand_tour(),
#            axes = "bottomleft", col=penguins_std$species)
# animate_xy(penguins_std[,2:5],
#            guided_tour(lda_pp(penguins_std$species)),
#            axes = "bottomleft", col=penguins_std$species)
# best_proj <- matrix(c(0.940, 0.058, -0.253, 0.767,
#                       -0.083, -0.393, -0.211, -0.504), ncol=2,
#                     byrow=TRUE)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false
# render_gif(data=penguins_std[,2:5],
#            tour_path = radial_tour(as.matrix(best_proj), mvar = 2),
#            display = display_xy(col = penguins_std$species),
#            gif_file = "slides/images/penguins_rt_bd.gif",
#            apf = 1/20,
#            frames = 100,
#            width = 400, height = 400)
# 
# render_gif(data=penguins_std[,2:5],
#            tour_path = radial_tour(as.matrix(best_proj), mvar = 1),
#            display = display_xy(col = penguins_std$species),
#            gif_file = "slides/images/penguins_rt_bl.gif",
#            apf = 1/20,
#            frames = 100,
#            width = 400, height = 400)
# 
# render_gif(data=penguins_std[,2:5],
#            tour_path = radial_tour(as.matrix(best_proj), mvar = 3),
#            display = display_xy(col = penguins_std$species),
#            gif_file = "slides/images/penguins_rt_fl.gif",
#            apf = 1/20,
#            frames = 100,
#            width = 400, height = 400)
# 
# render_gif(data=penguins_std[,2:5],
#            tour_path = radial_tour(as.matrix(best_proj), mvar = 4),
#            display = display_xy(col = penguins_std$species),
#            gif_file = "slides/images/penguins_rt_bm.gif",
#            apf = 1/20,
#            frames = 100,
#            width = 400, height = 400)
# 
# render_gif(penguins_std[,2:5],
#            radial_tour(best_proj, mvar=3),
#            display_xy(col=penguins_std$species, axes="bottomleft"),
#            "slides/images/penguins_manual_fl.gif",
#            frames=200, width=400, height=400)
# render_gif(penguins_std[,2:5],
#            radial_tour(best_proj, mvar=1),
#            display_xy(col=penguins_std$species, axes="bottomleft"),
#            "slides/images/penguins_manual_bl.gif",
#            frames=200, width=400, height=400)


## -----------------------------------------------------------------------------
#| label: runthis4
#| eval: false
# # Check contribution of bl,
# # change mvar to switch variables
# animate_xy(penguins_std[,2:5],
#            radial_tour(as.matrix(best_proj), mvar = 2),
#            col = penguins_std$species)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false
# render_gif(penguins_std[,2:5],
#            local_tour(start=best_proj, 0.9),
#            display_xy(col=penguins_std$species, axes="bottomleft"),
#            "slides/images/penguins2d_local.gif",
#            frames=200, width=400, height=400)


## -----------------------------------------------------------------------------
#| label: runthis16
#| eval: false
#| echo: false
# animate_xy(penguins_std[,2:5],
#            local_tour(start=best_proj, 0.9),
#            axes = "bottomleft", col=penguins_std$species)


## -----------------------------------------------------------------------------
#| label: runthis6
#| eval: false
# library(geozoo)
# sphere2 <- sphere.solid.random(p=4)$points %>% as_tibble()
# animate_slice(sphere2, axes="bottomleft")


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false
# render_gif(
#   sphere2, grand_tour(),
#   display_slice(axes="bottomleft"),
#   "slides/images/sphere4d_solid_slice.gif",
#   frames=100, width=400, height=400)


## -----------------------------------------------------------------------------
#| label: runthis7
#| eval: false
# sphere1 <- sphere.hollow(p=4)$points %>% as_tibble()
# animate_slice(sphere1, axes="bottomleft", half_range=0.6)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false
# render_gif(
#   sphere1, grand_tour(),
#   display_slice(axes="bottomleft", half_range=0.6),
#   "slides/images/sphere4d_slice.gif",
#   frames=100, width=400, height=400)


## -----------------------------------------------------------------------------
#| label: runthis8
#| eval: false
# torus <- torus(p = 4, n = 5000, radius=c(8, 4, 1))$points %>% as_tibble()
# animate_slice(torus, axes="bottomleft", half_range=0.8)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false
# render_gif(torus, grand_tour(),
#            display_slice(axes="bottomleft", half_range=0.8),
#            "slides/images/torus4d_slice.gif", frames=100, width=400, height=400)


## -----------------------------------------------------------------------------
#| label: runthis9
#| eval: false
# cube1 <- cube.face(p=4)$points %>% as_tibble()
# # Slicing needs data to be on a standard scale
# cube1_std <- cube1 %>%
#   mutate(across(where(is.numeric),  ~ scale(.)[,1]))
# animate_slice(cube1_std, axes="bottomleft")


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false
# render_gif(cube1_std, grand_tour(),
#            display_slice(axes="bottomleft"),
#            "slides/images/cube4d_slice.gif", frames=100, width=400, height=400)


## -----------------------------------------------------------------------------
#| label: runthis10
#| eval: false
#| echo: true
# penguins_pca <- prcomp(penguins_std[,2:5],
#                        center = FALSE)
# penguins_coefs <- penguins_pca$rotation[, 1:3]
# penguins_scores <- penguins_pca$x[, 1:3]
# 
# animate_pca(penguins_scores, pc_coefs = penguins_coefs, col=penguins_std$species)


## -----------------------------------------------------------------------------
#| eval: false
# render_gif(
#   penguins_scores, grand_tour(),
#   display_pca(pc_coefs = penguins_coefs,
#               col=penguins_std$species,
#               axes="bottomleft"),
#   "slides/images/penguins2d_pca.gif",
#   frames=100, width=400, height=400)


## -----------------------------------------------------------------------------
#| eval: false
#| echo: false

# render_gif(data=penguins_std[,2:5],
#            tour_path = grand_tour(1),
#            display = display_dist(half_range = 1.3),
#            gif_file = "slides/images/penguins1d.gif",
#            apf = 1/20,
#            frames = 100,
#            width = 400, height = 400)
# render_gif(penguins_std[,2:5],
#            tour_path = grand_tour(d=2),
#            display = display_density2d(col=penguins_std$species, axes="bottomleft"),
#            gif_file = "slides/images/penguins2d_dens.gif",
#            apf = 1/20,
#            frames=100,
#            width=400, height=400)


## -----------------------------------------------------------------------------
#| label: runthis11
#| eval: false
# animate_dist_cl(penguins_std[,2:5],
#                 half_range=1.3)


## -----------------------------------------------------------------------------
#| label: runthis12
#| eval: false
# animate_density2d(
#   penguins_std[,2:5],
#   col=penguins_std$species, axes="bottomleft")


## -----------------------------------------------------------------------------
#| eval: false
# library(tourr)
# data(flea)
# ?animate_xy
# # On a Mac, start quartz window with:  quartz()
# # On windows, start X11 window with:   X11()
# 
# animate_xy(flea[, 1:6])
# # RStudio graphics windows: may want to reduce frame rate
# animate_xy(flea[, 1:6], fps=10)
# 
# # Also
# animate_xy(flea[, -7], col = flea$species)
# animate_xy(flea[, 1:6], tour_path = guided_tour(lda_pp(flea$species)), col=flea$species)


## -----------------------------------------------------------------------------
#| echo: false
countdown::countdown(2,0)


## -----------------------------------------------------------------------------
#| eval: false
# render_gif(
#   penguins_std[,2:5],
#   grand_tour(),
#   display_xy(
#     col=penguins_std$species,
#     axes="bottomleft"),
#   gif_file="slides/images/penguins2d.gif",
#   frames=100,
#   width=400,
#   height=400
# )


## -----------------------------------------------------------------------------
load(here::here("data/p_tour_path.rda"))
penguins_pcti <- interpolate(
  penguins_pct, 0.2)
f27 <- matrix(
  penguins_pcti[,,27], 
  ncol=2)
p27 <- render_proj(
  penguins_std[,2:5],
  f27,
  obs_labels=
    penguins_std$species)


## -----------------------------------------------------------------------------
#| echo: false
p27$data_prj <- p27$data_prj |>
  mutate(species = penguins_std$species)
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


## -----------------------------------------------------------------------------
#| echo: false
#| out-width: 80%
#| fig-width: 7
#| fig-height: 6
# pg27
ggplotly(pg27, width=550, height=550)

