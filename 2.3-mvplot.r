## ----load packages ----------------------------------------------------------
library(tidyverse)
library(lubridate)
library(GGally)
# remotes::install_github("ggobi/tourr")
library(tourr)
library(broom)
library(plotly)
library(spinifex) # missing from original .r file
library(RColorBrewer) # missing from original .r file

## ----scatterplot matrix, echo=TRUE, fig.width=6, fig.height=6------------
# Make a simple scatterplot matrix of a classic data set
data(flea)
ggscatmat(flea, columns = 1:6)


## ----scatterplot matrix with colour, echo=TRUE, fig.width=8, fig.height=8----
# Re-make mapping colour to species (class)
data(flea)
ggscatmat(flea, columns = 1:6, color = "species") +
  theme(legend.position="bottom")


## ----PISA data wrangling-------------------------------------------------
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


## ----generalised pairs plot, echo=TRUE, fig.width=6, fig.height=6--------
australia_PISA2012 %>%
  filter(!is.na(dishwasher)) %>%
  ggpairs(columns=c(3, 15, 16, 21, 26))


## ----generalised pairs plot enhance plots, echo=TRUE, fig.width=6, fig.height=6----
# Modify the defaults, set the transparency of points since there is a lot of data
australia_PISA2012 %>%
  filter(!is.na(dishwasher)) %>%
  ggpairs(columns=c(3, 15, 16, 21, 26),
          lower = list(continuous = wrap("points", alpha=0.05)))


## ----design own plot function--------------------------------------------
# Make a special style of plot to put in the matirx
my_fn <- function(data, mapping, method="loess", ...){
      p <- ggplot(data = data, mapping = mapping) +
      geom_point(alpha=0.2, size=1) +
      geom_smooth(method="lm", ...)
      p
}


## ----generalised pairs plot enhance more, echo=TRUE, fig.width=6, fig.height=6----
australia_PISA2012 %>%
  filter(!is.na(dishwasher)) %>%
  ggpairs(columns=c(3, 15, 16, 21, 26),
          lower = list(continuous = my_fn))

australia_PISA2012 %>%
  filter(!is.na(dishwasher)) %>%
  ggpairs(columns=c(3, 15, 16, 21, 26),
          lower = list(continuous = my_fn, combo = "box"),
          upper = list(combo = "facethist"))


## ----wrangle housing data------------------------------------------------
housing <- read_csv(here::here("data/housing.csv")) %>%
  mutate(date = dmy(date)) %>%
  mutate(year = year(date)) %>%
  filter(year == 2016) %>%
  filter(!is.na(bedroom2), !is.na(price)) %>%
  filter(bedroom2 < 7, bathroom < 5) %>%
  mutate(bedroom2 = factor(bedroom2),
         bathroom = factor(bathroom))


## ----make a regression style pairs plot, out.width="100%", fig.width=8, fig.height=3----
ggduo(housing[, c(4,3,8,10,11)],
      columnsX = 2:5, columnsY = 1,
      aes(colour=type, fill=type),
      types = list(continuous =
                     wrap("smooth",
                       alpha = 0.10)))

## ----compute statistics on tb mortality trends---------------------------
# A more complex example of using the scatterplot matrix to explore
# a large collection of time series. Compute statistics for each time
# series, which might be called tignostics, and plot these. Explore
# the scatterplot matrix for anomalies and clusters.
load(here::here("data/tb_burden.rda"))
# Fit a model for each country, and extract statistics
tb_reg1 <- tb_burden %>%
  group_by(country) %>%
  nest() %>%
  mutate(model = purrr::map(data, ~lm(e_mort_exc_tbhiv_100k ~ year, data = .x) %>%
                       tidy)) %>%
  unnest(model) %>%
  select(country, term, estimate) %>%
  spread(term, estimate) %>%
  rename(intercept = `(Intercept)`, slope=year)
tb_reg2 <- tb_burden %>%
  group_by(country) %>%
  nest() %>%
  mutate(model = purrr::map(data, ~lm(e_mort_exc_tbhiv_100k ~ year, data = .x) %>%
                       glance)) %>%
  unnest(model) %>%
  select(country, r.squared, sigma, BIC, deviance)
tb_reg <- left_join(tb_reg1, tb_reg2)
# Drop the 0 deviance, 0 sigma countries
tb_reg <- tb_reg %>% filter(sigma > 0, BIC > -400)


## ----explore tb mortality trends, echo=TRUE, fig.width=6, fig.height=6----
ggscatmat(tb_reg, columns=3:7)


## ----wranglw data to show labels interactively, echo=TRUE----------------
# Add interaction to find the id's for countries that are anomalies
tb_reg_m <- as.data.frame(tb_reg[,3:7])
rownames(tb_reg_m) <- tb_reg$country


## ----explore tb mortality trends interactively, echo=TRUE, fig.width=8, fig.height=7----
tb_reg_m %>% ggpairs() %>% ggplotly()


## ----plot the countries that have decreasing mortality trend, echo=TRUE, fig.width=7, fig.height=4----
# Use a dotplot with model overlaid, to better match analysis conducted
declining <- tb_reg %>% filter(slope < -3.5)
tb_burden %>% filter(country %in% declining$country) %>%
  ggplot(aes(x=year, y=e_mort_exc_tbhiv_100k)) +
    geom_point() +
    geom_smooth(method="lm", se=F) +
  facet_wrap(~country, scales = "free_y")


## ----explore tb mortality trends problem countries, echo=TRUE,  fig.width=7, fig.height=3----
increasing <- tb_reg %>% filter(slope > 1, r.squared > 0.5)
tb_burden %>% filter(country %in% increasing$country) %>%
  ggplot(aes(x=year, y=e_mort_exc_tbhiv_100k)) +
    geom_point() +
    geom_smooth(method="lm", se=F) +
  facet_wrap(~country, scales = "free_y")

ggplot(tb_burden, aes(x=year, y=e_mort_exc_tbhiv_100k)) +
  geom_line(aes(group=country), alpha=0.2) +
  geom_smooth(se=F, colour="black") +
  scale_y_log10()

## ----guided tour 6D, eval=FALSE, echo=TRUE-------------------------------
# The tour requires making many plots, and updating.
# The RStudio graphics device doesn't work well
# Open a graphics window
# quartz()  # Mac OSX
# X11()     # Windows
animate_xy(flea[,1:6], guided_tour(lda_pp(flea$species)), axes="bottomleft")


## ----generate a sequence to rotate a variable out of a projection, eval=FALSE, echo=TRUE----
# When you find a low dimensional projection from some other technique
# such as principal component analysis, linear discriminant analysis or
# projection pursuit, it is useful to examine the sensitivity of structure
# to variables in the projection. This is the purpose of the manual tour.
# Take a variable, and rotate it out of the projection and see if the structure
# persists or disappears.
flea_std <- tourr::rescale(flea[, 1:6])

rb <- basis_random(n = ncol(flea_std))
mtour <- manual_tour(basis = rb, manip_var = 4)
sshow <- array2df(array = mtour, data = flea_std)
render_plotly(slides = sshow)

render_plotly(slides = sshow, col = col_of(flea$species),
  fps = 2)


## ----read and tour on in a classic data set, echo=TRUE, eval=FALSE-------
olive <- read_csv("http://www.ggobi.org/book/data/olive.csv") %>%
  rename(name=X1)
olive <- olive %>%
  filter(region == 1) %>%
  mutate(area = factor(area))
pal <- brewer.pal(4, "Dark2")
col <- pal[olive$area]
# drop eicosenoic, all low for south
animate_xy(olive[,4:10], axes="bottomleft", col=col)
# Drop Sicily
animate_xy(olive[olive$area!=4,4:10], axes="bottomleft", col=col[olive$area!=4])


## ----Fit a randomForest model an examine the vote matrix, echo=TRUE, eval=FALSE----
olive_rf <- randomForest(area~., data=olive[,-c(1, 2, 11)], importance=TRUE, proximity=TRUE)
olive_rf
vt <- data.frame(olive_rf$votes)
vt$area <- olive$area
ggscatmat(vt, columns=1:4, col="area") +
  scale_colour_brewer("", palette="Dark2")
proj <- t(geozoo::f_helmert(4)[-1,])
vtp <- as.matrix(vt[,-5])%*%proj
vtp <- data.frame(vtp, area=vt$area)
ggscatmat(vtp, columns=1:3, col="area") +
  scale_colour_brewer("", palette="Dark2")
pal <- brewer.pal(4, "Dark2")
col <- pal[as.numeric(vtp[, 4])]
animate_xy(vtp[,1:3], col=col, axes = "bottomleft")
# Add simplex
simp <- simplex(p=3)
sp <- data.frame(simp$points)
colnames(sp) <- c("x1", "x2", "x3")
colnames(vtp) <- c("x1", "x2", "x3")
vtp_s <- bind_rows(sp, vtp[,1:3])
animate_xy(vtp_s, col=col, axes = "bottomleft", edges=as.matrix(simp$edges), center=TRUE)


## ----tb pca analysis, eval=FALSE, echo=TRUE------------------------------
library(naniar) # Have missings!
tb_burden_wide <- tb_burden %>%
  select(country, g_whoregion, year,
         e_mort_exc_tbhiv_100k) %>%
  spread(year, e_mort_exc_tbhiv_100k) %>%
  filter(complete.cases(.)) %>%
  rename(region = g_whoregion) %>%
  mutate(country = factor(country),
         region = factor(region))
# vis_miss(tb_burden_wide)
tb_pca <- prcomp(tb_burden_wide[,-c(1:2)],
                 scale=FALSE, retx=TRUE)
screeplot(tb_pca, type="line")
tb_pcs <- bind_cols(as_tibble(tb_pca$x),
                    tb_burden_wide[,1:2])
ggscatmat(tb_pcs, columns=1:3, color="region")
# quartz()
# X11()
pal <- brewer.pal(6, "Dark2")
col <- pal[as.numeric(as.factor(tb_pcs$region))]
animate_xy(tb_pcs[,1:4], col=col,
           axes = "bottomleft")


## ----tb mortality line plots, eval=FALSE, echo=FALSE---------------------
tb_burden <- tb_burden %>%
  rename(region = g_whoregion)
ggplot(tb_burden, aes(x=year, y=e_mort_exc_tbhiv_100k,
                      group=country, colour=region)) +
  geom_line() + facet_wrap(~region)


## ----nonlinear dimension reduction, eval=FALSE, echo=TRUE----------------
# remotes::install_github("sa-lee/sneezy")
library(gganimate) # required for printing tours
library(sneezy)
# Read a benchmark data set
spheres <- subset(multi, key %in% c("A", "D"))
labels <- ifelse(spheres$key == "A", "sub-gaussian", "10-d 2x cluster")
spheres <- as.matrix(spheres[, -c(1,2)])
##
# t-SNE plot
set.seed(1010010)
coords <- basic_tsne(spheres, perplexity = 30)
pl <- ggplot(as.data.frame(coords$Y), aes(V1, V2)) +
  geom_point(aes(colour = labels)) +
  coord_equal() +
  scale_color_brewer(palette = "Dark2") +
  theme(axis.title = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank())
##
pl +  add_triangles(coords)
##
# in data space, with a triangulation of the points from the tSNE view
# quartz()
# X11()
pal <- c("#1B9E77", "#D95F02")[as.integer(as.factor(labels))]
sneezy_triangles(spheres, coords, col = pal)


## ----tour again for comparison, eval=FALSE, echo=FALSE-------------------
# quartz()
# X11()
pal <- brewer.pal(4, "Dark2")
col <- pal[olive$area]
# drop eicosenoic, all low for south
animate_xy(olive[,4:10], axes="bottomleft", col=col)
# Drop Sicily
animate_xy(olive[olive$area!=4,4:10], axes="bottomleft", col=col[olive$area!=4])


## ----make a parallel coordinate plot of the olive data, eval=FALSE, echo=TRUE----
ggparcoord(olive, columns=4:10, groupColumn=3, order="anyClass") +
  scale_colour_brewer("", palette="Dark2")


## ----make a heatmap of the olive data, eval=FALSE, echo=TRUE-------------
library(superheat)
superheat(olive[,4:10], scale=TRUE,
          pretty.order.rows=TRUE, pretty.order.cols=TRUE,
          row.dendrogram = TRUE)


## ----plotly tourr, eval=FALSE, echo=TRUE---------------------------------
flea_std <- rescale(tourr::flea[,1:6])
tpath    <- save_history(flea_std, max = 3)
##
pg <- play_tour_path(tour_path = tpath, data = flea_std, angle = .15)
pg
save_html(pg, file="mytour.html")


## ----saving a tour as an animated fig using gganimate, eval=FALSE, echo=TRUE----
library(gganimate)
render_gif(flea[,1:6], grand_tour(), display_xy(axes="off"),
           frames=200,
           gif_file="mytour.gif")

