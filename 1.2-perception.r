## ----load libraries, echo=FALSE------------------------------------------
library(tidyverse)
library(RColorBrewer)
library(gridExtra)
library(dichromat)
library(here)


## ----read TB data and wrangle and subset to USA--------------------------
tb <- read_csv(here::here("data/TB_notifications_2019-07-01.csv")) %>%
  select(country, iso3, year, new_sp_m04:new_sp_fu) %>%
  gather(stuff, count, new_sp_m04:new_sp_fu) %>%
  separate(stuff, c("stuff1", "stuff2", "sexage")) %>%
  select(-stuff1, -stuff2) %>%
  mutate(sex=substr(sexage, 1, 1),
         age=substr(sexage, 2, length(sexage))) %>%
  select(-sexage)

# Filter years between 1997 and 2012 due to missings
tb_us <- tb %>%
  filter(country == "United States of America") %>%
  filter(!(age %in% c("04", "014", "514", "u"))) %>%
  filter(year > 1996, year < 2013)


## ----focus on one year gender, side-by-side bars of males/females, fig.height=3----
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=sex, y=count, fill=sex)) +
  geom_bar(stat="identity", position="dodge") +
  facet_wrap(~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Arrangement A")


## ----focus on one year age, side-by-side bars of age group, fig.height=3----
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=age, y=count, fill=age)) +
  geom_bar(stat="identity", position="dodge") +
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Arrangement B")


## ----use a line plot instead of bar, fig.height=3------------------------
ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  scale_colour_brewer("", palette="Dark2") +
  ggtitle("Type A")


## ----colour and axes fixes, fig.height=3---------------------------------
# This uses a color blind proof scale
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  facet_wrap(~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Type B")


## ----use a line plot for proportions, fig.height=3-----------------------
tb_us %>% group_by(year, age) %>%
  summarise(p = count[sex=="m"]/sum(count)) %>%
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="white", size=2) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  ylab("proportion of males") +
  ggtitle("Type A")


## ----compare proportions of males/females, fig.height=4------------------
# Fill the bars, note the small change to the code
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") +
  facet_wrap(~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2") + ylab("proportion") +
  ggtitle("Type B") + theme(legend.position = "bottom")


## ----show different types of color palettes, fig.height=7, fig.width=12----
display.brewer.all()


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


## ----using the dichromat package to check color blind appearance, echo=TRUE, fig.show='hide'----
library(scales)
library(dichromat)
clrs <- hue_pal()(9)
d + theme(legend.position = "none")
clrs <- dichromat(hue_pal()(9))
d + scale_fill_manual("", values=clrs) + theme(legend.position = "none")


## ----show the default colour scheme and dichromat adjusted colors, echo=FALSE, fig.height=8----
clrs <- hue_pal()(9)
p1 <- d + theme(legend.position = "none") + scale_color_discrete()

clrs <- dichromat(hue_pal()(9))
p2 <- d + scale_color_manual("", values=clrs) + theme(legend.position = "none")

grid.arrange(p1, p2, ncol=1)


## ----is shape preattentive, echo=FALSE-----------------------------------
set.seed(20190715)
df <- data.frame(x=runif(100), y=runif(100), cl=sample(c(rep("A", 1), rep("B", 99))))
ggplot(data=df, aes(x, y, shape=cl)) + theme_bw() +
  geom_point(size=3) +
  theme(legend.position="None", aspect.ratio=1)


## ----is color preattentive, echo=FALSE-----------------------------------
ggplot(data=df, aes(x, y, colour=cl)) +
  geom_point(size=3) +
  theme_bw() +
  scale_colour_brewer(palette="Set1") +
  theme(legend.position="None", aspect.ratio=1)


## ----a line plot on sex, fig.height=3------------------------------------
ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  scale_colour_brewer("", palette="Dark2") +
  ggtitle("Arrangement A")


## ----a line plot on age, fig.height=3, fig.width=6-----------------------
ggplot(tb_us, aes(x=year, y=count, colour=age)) +
  geom_line() + geom_point() +
  facet_wrap(~sex, ncol=6) +
  scale_colour_brewer("", palette="Dark2") +
  ggtitle("Arrangement B")


## ----side-by-side bars of males/females, fig.height=3--------------------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=sex, y=count, fill=sex)) +
  geom_bar(stat="identity", position="dodge") +
  facet_wrap(~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Position - common scale ")


## ----piecharts of males/females, fig.height=3----------------------------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=1, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") +
  facet_wrap(~age, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Angle") + xlab("") + ylab("") +
  coord_polar(theta = "y")


## ----side-by-side bars of age, fig.height=3------------------------------
tb_us %>% filter(year == 2012) %>%
  ggplot(aes(x=age, y=count, fill=age)) +
  geom_bar(stat="identity", position="dodge") +
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Position - common scale ")


## ----piecharts of age, fig.height=3--------------------------------------
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

