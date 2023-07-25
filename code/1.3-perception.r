## ----echo=FALSE----------------------------------------------------------------------
knitr::opts_chunk$set(
  echo=FALSE,
  message = FALSE,
  warning = FALSE,
  error = FALSE, 
  collapse = TRUE,
  comment = "",
  fig.height = 6,
  fig.width = 10,
  fig.align = "center",
  fig.retina = 3,
  cache = FALSE
)


## ----load libraries, echo=FALSE------------------------------------------------------
#library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)
library(stringr)
library(RColorBrewer)
library(gridExtra)
library(dichromat)
library(here)

# just to make sure that we use the dplyr filter and select function when in doubt
library(conflicted)

conflict_prefer("select", "dplyr")
conflict_prefer("filter", "dplyr")


## ----read TB data and wrangle and subset to USA--------------------------------------
tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>% 
  dplyr::select(country, iso3, year, new_sp_m04:new_sp_fu) %>%
  pivot_longer(cols=new_sp_m04:new_sp_fu, names_to="sexage", values_to="count") %>%
  mutate(sexage = str_replace(sexage, "new_sp_", "")) %>%
  mutate(sex=substr(sexage, 1, 1), 
         age=substr(sexage, 2, length(sexage))) %>%
  dplyr::select(-sexage)

# Filter years between 1997 and 2012 due to missings
tb_us <- tb %>% 
  filter(country == "United States of America") %>%
  filter(!(age %in% c("04", "014", "514", "u"))) %>%
  filter(year > 1996, year < 2013)


## ------------------------------------------------------------------------------------
tb_us %>% filter(year == 2012) %>% dplyr::select(sex, age, count)


## ----focus on one year gender side-by-side bars of males/females, fig.height=3-------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=sex, y=count, fill=sex)) +
  geom_bar(stat="identity", position="dodge") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ggtitle("Arrangement A")


## ----focus on one year age side-by-side bars of age group, fig.height=3--------------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=age, y=count, fill=age)) +
  geom_bar(stat="identity", position="dodge") + 
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Arrangement B")


## ----ref.label='focus on one year gender side-by-side bars of males/females', fig.height=3----


## ----ref.label='focus on one year age side-by-side bars of age group', fig.height=3----


## ------------------------------------------------------------------------------------
tb_us %>% select(year, sex, age, count) %>% head(10)


## ----eval=FALSE----------------------------------------------------------------------
## - Plot type A makes it easier to examine trend for each group. This plot should probably have used 0 as the lower limit.
## - Plot type  B is really only allowing the overall trend in count to be examined separately by age. It is also possible to see trend for males. Trend for females is buried because the bars start at irregular heights. The separated bars distract from digesting the overall count.


## ----use a line plot instead of bar, fig.height=3------------------------------------
ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  scale_color_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ggtitle("Type A")


## ----colour and axes fixes, fig.height=3---------------------------------------------
# This uses a color blind proof scale
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ggtitle("Type B")


## ------------------------------------------------------------------------------------
countdown::countdown(1,50, top=0, right=0)


## ----ref.label='use a line plot instead of bar', fig.height=3------------------------


## ----ref.label='colour and axes fixes', fig.height=3---------------------------------


## ------------------------------------------------------------------------------------
countdown::countdown(0, 30, top=0, right=0)


## ------------------------------------------------------------------------------------
countdown::countdown(1, 5, top=100, right=0)


## ----use a line plot for proportions, fig.height=3-----------------------------------
tb_us %>% group_by(year, age) %>% 
  summarise(p = count[sex=="m"]/sum(count)) %>%
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="white", size=2) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  ylab("proportion of males") +
  ggtitle("Type A")


## ----compare proportions of males/females, fig.height=4------------------------------
# Fill the bars, note the small change to the code
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) + ylab("proportion") +
  ggtitle("Type B") + theme(legend.position = "bottom")


## ----eval=FALSE----------------------------------------------------------------------
## - Plot A makes it easier to examine the trend in proportion. It is easy to miss that all the proportions are greater than 0.5, despite having a guideline (white) at 0.5. It could be argued that setting the vertical axis limits could alleviate this.  The fluctuations from year to year are more visible. Maybe adding a trend model could be helpful, to reduce this noise. Without colour its less visually appealing.
## - Plot B makes it easier to see that the proportion for males is almost always higher than for females. It also suggests that there is little temporal trend, because the small fluctuations between years is less visible. Having colour makes it more visually appealing. There s less data processing.


## ------------------------------------------------------------------------------------
countdown::countdown(1, 40, top=100, right=100)


## ----eval=FALSE----------------------------------------------------------------------
## 1. scatterplot, barchart
## 2. side-by-side boxplot, stacked barchart
## 3. piechart, rose plot, gauge plot, donut, wind direction map, starplot
## 4. treemap, bubble chart, mosaicplot
## 5. chernoff face
## 6. choropleth map


## ----show different types of color palettes, fig.height=7, fig.width=12, echo=TRUE, fig.show='hide'----
display.brewer.all()


## ----ref.label='show different types of color palettes', fig.height=7, fig.width=12----


## ----mapping numbers to rainbow sequential scale, echo=TRUE, out.width="60%", fig.width=7, fig.height=4----
dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
(d <- ggplot(dsamp, aes(carat, price)) +
  geom_point(aes(colour = clarity)))


## ----mapping numbers to sequential scale, echo=TRUE, fig.width=7, fig.height=4, out.width="60%"----
d + scale_colour_brewer()


## ----mapping numbers to diverging scale, echo=TRUE, fig.width=7, fig.height=4, out.width="60%"----
d + scale_colour_brewer(palette="PRGn")


## ----mapping numbers to qualitative palette, echo=TRUE, , fig.width=7, fig.height=4, out.width="60%"----
d + scale_colour_brewer(palette="Set1")


## ------------------------------------------------------------------------------------
countdown::countdown(0, 50, right=50, bottom=0)


## ----using the dichromat package to check color blind appearance, echo=TRUE, fig.show='hide'----
library(scales)
library(dichromat)
clrs <- hue_pal()(9)
d + theme(legend.position = "none")
clrs <- dichromat(hue_pal()(9))
d + scale_colour_manual("", values=clrs) + theme(legend.position = "none")


## ----show the default colour scheme, echo=FALSE, fig.width=4, fig.height=4, out.width="100%"----
clrs <- hue_pal()(9)
p1 <- d + theme(legend.position = "none") + scale_color_discrete()
p1


## ----show the dichromat adjusted colors, echo=FALSE, fig.width=4, fig.height=4, out.width="100%"----
clrs <- dichromat(hue_pal()(9))
p2 <- d + scale_color_manual("", values=clrs) + theme(legend.position = "none")

p2


## ----is shape preattentive, echo=FALSE-----------------------------------------------
set.seed(20190715)
df <- data.frame(x=runif(100), y=runif(100), cl=sample(c(rep("A", 1), rep("B", 99))))
ggplot(data=df, aes(x, y, shape=cl)) + theme_bw() + 
  geom_point(size=3) +
  theme(legend.position="None", aspect.ratio=1)


## ----is color preattentive, echo=FALSE-----------------------------------------------
ggplot(data=df, aes(x, y, colour=cl)) + 
  geom_point(size=3) +
  theme_bw() + 
  scale_colour_brewer(palette="Set1") +
  theme(legend.position="None", aspect.ratio=1)


## ----a line plot on sex, fig.height=3------------------------------------------------
ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  ylim(c(0,1150)) +
  scale_color_manual("Sex", values = c("#DC3220", "#005AB5"))  +
  ggtitle("Arrangement A")


## ----a line plot on age, fig.height=3, fig.width=6-----------------------------------
ggplot(tb_us, aes(x=year, y=count, colour=age)) +
  geom_line() + geom_point() +
  facet_wrap(~sex, ncol=6) +
  ylim(c(0,1150)) +
  scale_colour_brewer("", palette="Dark2") +
  ggtitle("Arrangement B")


## ----side-by-side bars of males/females, fig.height=3--------------------------------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=sex, y=count, fill=sex)) +
  geom_bar(stat="identity", position="dodge") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5"))  +
  ggtitle("Position - common scale ")


## ----piecharts of males/females, fig.height=3----------------------------------------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=1, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ggtitle("Angle") + xlab("") + ylab("") +
  coord_polar(theta = "y")


## ----side-by-side bars of age, fig.height=3------------------------------------------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=age, y=count, fill=age)) +
  geom_bar(stat="identity", position="dodge") + 
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Position - common scale ")


## ----piecharts of age, fig.height=3--------------------------------------------------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=1, y=count, fill=age)) +
  geom_bar(stat="identity", position="fill") + 
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Angle") + xlab("") + ylab("") +
  coord_polar(theta = "y")


## ----facetting plots can result in change blindness, echo=TRUE, out.width="50%", fig.width=6.5, fig.height=3.5----
ggplot(dsamp, aes(x=carat, y=price, colour = clarity)) +
  geom_point() +
  geom_smooth(se=FALSE) +
  scale_color_brewer(palette="Set1") +
  facet_wrap(~clarity, ncol=4)


## ----averlaying makes comparisons easier, echo=TRUE, out.width="70%", fig.width=7, fig.height=4----
ggplot(dsamp, aes(x=carat, y=price, colour = clarity)) +
  geom_point() +
  geom_smooth(se=FALSE) +
  scale_color_brewer(palette="Set1") 


## ------------------------------------------------------------------------------------
countdown::countdown(7, 0)

