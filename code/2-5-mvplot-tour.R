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
library(wesanderson)
library(colorspace)

theme_set(theme_bw())


# source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


# Pre-process the data
penguins_std <- penguins %>%
  rename(bl = bill_length_mm,
         bd = bill_depth_mm, 
         fl = flipper_length_mm, 
         bm = body_mass_g) %>%
  select(species, bl:bm) %>%
  na.omit() %>%
  mutate_if(is.numeric, function(x) (x-mean(x))/sd(x))


clrs <- divergingx_hcl(3, palette = "Zissou1")
col <- clrs[as.numeric(penguins_std$species)]


ggplot(penguins_std, 
   aes(x=fl, 
       y=bm,
       colour=species,
       shape=species)) +
  xlab("Flipper Length (mm)") + 
  ylab("Body Mass (g)") + 
  geom_point(alpha=0.7, 
             size=2) +
  scale_color_discrete_divergingx(palette = "Zissou 1")+
  theme(aspect.ratio=1,
  legend.position="bottom")




# Make a simple scatterplot matrix of the new penguins data
ggpairs(penguins_std, columns=c(2:5), 
        ggplot2::aes(colour=species)) +
  scale_color_discrete_divergingx(palette = "Zissou 1") +
  scale_fill_discrete_divergingx(palette = "Zissou 1")


# Run the tour
animate_xy(penguins_std[,2:5], 
           col=penguins_std$species, 
           axes="off", 
           fps=15)


# This code was used to make the animated gif
set.seed(20200622)
render_gif(penguins_std[,2:5], grand_tour(), 
           display_xy(col=col, axes="bottomleft"), 
           "images/penguins2d.gif", frames=100, width=400, height=400)


ggscatmat(penguins_std, columns = 2:5, color="species") +  
    scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(legend.position="bottom")


# Generate a plotly animation to demonstrate
library(plotly)
library(htmltools)

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
  fp <- as.matrix(penguins_std[,2:5]) %*% 
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

df <- as_tibble(penguins_d) |> 
  mutate(species = rep(penguins_std$species, d[3]))
dfaxes <- as_tibble(penguins_axes) |>
  mutate(labels=rep(colnames(penguins_std[,2:5]), d[3]))
dfaxes_mat <- dfaxes |>
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
       scale_colour_discrete_divergingx(palette = "Zissou 1") + 
       theme_void() +
       coord_fixed() +
  theme(legend.position="none")
pg <- ggplotly(p, width=700, height=400) |>
  animation_opts(200, redraw = FALSE, 
                 easing = "linear", transition=0)
save_html(pg, file="html/penguins.html")


ggplot(penguins_std, 
   aes(x=fl, 
       y=bd,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
  scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(aspect.ratio=1,
  legend.position="bottom") 


ggplot(penguins_std, 
   aes(x=bl, 
       y=bm,
       colour=species,
       shape=species)) +
  geom_point(alpha=0.7, 
             size=2) +
  scale_colour_discrete_divergingx(palette = "Zissou 1") + 
  theme(aspect.ratio=1,
  legend.position="bottom")


set.seed(20694727)
render_gif(penguins_std[,2:5], guided_tour(lda_pp(penguins_std$species)), 
           display_xy(col=penguins_std$species, 
                      axes="bottomleft"), 
           "images/penguins2d_guided.gif", 
           frames=34, width=400, height=400, loop=FALSE)


animate_xy(penguins_std[,2:5], grand_tour(),
           axes = "bottomleft", col=penguins_std$species)
animate_xy(penguins_std[,2:5], 
           guided_tour(lda_pp(penguins_std$species)),
           axes = "bottomleft", col=penguins_std$species)
best_proj <- matrix(c(0.940, 0.058, -0.253, 0.767, 
                      -0.083, -0.393, -0.211, -0.504), ncol=2,
                    byrow=TRUE)


render_gif(data=penguins_std[,2:5],
           tour_path = radial_tour(as.matrix(best_proj), mvar = 2),
           display = display_xy(col = col),
           gif_file = "images/penguins_rt_bd.gif",
           apf = 1/20, 
           frames = 100, 
           width = 400, height = 400)

render_gif(data=penguins_std[,2:5],
           tour_path = radial_tour(as.matrix(best_proj), mvar = 1),
           display = display_xy(col = col),
           gif_file = "images/penguins_rt_bl.gif",
           apf = 1/20, 
           frames = 100, 
           width = 400, height = 400)

render_gif(data=penguins_std[,2:5],
           tour_path = radial_tour(as.matrix(best_proj), mvar = 3),
           display = display_xy(col = col),
           gif_file = "images/penguins_rt_fl.gif",
           apf = 1/20, 
           frames = 100, 
           width = 400, height = 400)

render_gif(data=penguins_std[,2:5],
           tour_path = radial_tour(as.matrix(best_proj), mvar = 4),
           display = display_xy(col = col),
           gif_file = "images/penguins_rt_bm.gif",
           apf = 1/20, 
           frames = 100, 
           width = 400, height = 400)

<<<<<<< HEAD:slides/2-5-mvplot-tour.qmd
=======
```{r eval=FALSE, echo=FALSE}
render_gif(penguins_std[,2:5], 
           radial_tour(best_proj, mvar=3),
           display_xy(col=penguins_std$species, axes="bottomleft"),
           "penguins_manual_fl.gif", 
           frames=200, width=400, height=400)
render_gif(penguins_std[,2:5], 
           radial_tour(best_proj, mvar=1),
           display_xy(col=penguins_std$species, axes="bottomleft"),
           "penguins_manual_bl.gif", 
           frames=200, width=400, height=400)
>>>>>>> 4878b57bfe0f02cf286f5e601203113922ee28c5:slides/2.5-mvplot-tour/index.Rmd


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
=======
```{r eval=FALSE, echo=FALSE}
render_gif(penguins_std[,2:5], 
           local_tour(start=best_proj, 0.9), 
           display_xy(col=penguins_std$species, axes="bottomleft"), 
           "penguins2d_local.gif", 
           frames=200, width=400, height=400)


animate_xy(penguins_std[,2:5], 
           local_tour(start=best_proj, 0.9),
           axes = "bottomleft", col=penguins_std$species)
>>>>>>> 4878b57bfe0f02cf286f5e601203113922ee28c5:slides/2.5-mvplot-tour/index.Rmd


library(geozoo)
sphere2 <- sphere.solid.random(p=4)$points %>% as_tibble()
animate_slice(sphere2, axes="bottomleft")

