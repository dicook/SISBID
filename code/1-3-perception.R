#' ---
#' title: Visual perception and effective plot construction
#' title-slide-attributes:
#'   data-background-image: images/who_wore_it_better.jpg
#'   data-background-size: 20%
#'   data-background-position: 99% 50%
#' message: false
#' warning: false
#' ---
#' 


# source(here::here("knitr-setup.R"))
# source(here::here("libraries.R"))
library(readr)
library(here)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(dichromat)
library(scales)
library(RColorBrewer)
theme_set(theme_bw())

data(diamonds, package="ggplot2")
diamonds <- diamonds |>
  mutate(clarity = factor(clarity, levels = c("I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"), ordered = T))


tb <- read_csv(here::here("data/TB_notifications_2025-07-22.csv")) |> 
  dplyr::select(country, iso3, year, new_sp_m04:new_sp_fu) |>
  pivot_longer(cols=new_sp_m04:new_sp_fu, names_to="sexage", values_to="count") |>
  mutate(sexage = str_replace(sexage, "new_sp_", "")) |>
  mutate(sex=substr(sexage, 1, 1), 
         age=substr(sexage, 2, length(sexage))) |>
  dplyr::select(-sexage)

# Filter years between 1997 and 2012 due to missings
tb_kn <- tb |> 
  filter(country == "Kenya") |>
  filter(!(age %in% c("04", "014", "514", "u"))) |>
  filter(!is.na(count)) |>
  mutate(age = str_replace(age, "(\\d{2})(\\d{2})", "\\1-\\2") |>
           str_replace("65", "65+"))


tb_kn |> 
  filter(year == 2012) |> 
  dplyr::select(sex, age, count) |>
  head()


tb_kn |> filter(year == 2012) |>
  ggplot(aes(x=sex, y=count, fill=sex)) +
  geom_bar(stat="identity", position="dodge") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ggtitle("Arrangement A")


tb_kn |> filter(year == 2012) |>
  ggplot(aes(x=age, y=count, fill=age)) +
  geom_bar(stat="identity", position="dodge") + 
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Arrangement B")






tb_kn |> select(year, sex, age, count) |> head(10)


ggplot(tb_kn, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  scale_color_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ggtitle("Type A")


# This uses a color blind friendly scale
ggplot(tb_kn, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ggtitle("Type B")


countdown::countdown(1,50)






countdown::countdown(0, 30)


countdown::countdown(1, 5)


tb_kn |> group_by(year, age) |> 
  summarise(p = count[sex=="m"]/sum(count)) |>
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="grey70", size=2) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  ylab("proportion of males") +
  ggtitle("Type A")


# Fill the bars, note the small change to the code
ggplot(tb_kn, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) + ylab("proportion") +
  ggtitle("Type B") + theme(legend.position = "bottom")


countdown::countdown(1, 40, top=100, right=100)


display.brewer.all()




dsamp <- diamonds |>
  sample_n(1000)
(d <- ggplot(
  dsamp, aes(carat, price)) +
  geom_point(aes(
    colour = clarity)))


d + scale_colour_brewer(direction = -1)


d + scale_colour_brewer(palette="PRGn")


d + scale_colour_brewer(palette="Set1")


countdown::countdown(0, 50, right=50, bottom=0)


clrs <- hue_pal()(9)
d + theme(legend.position = "none")
clrs <- dichromat(hue_pal()(9))
d + scale_colour_manual("", values=clrs) + theme(legend.position = "none")


clrs <- hue_pal()(9)
p1 <- d + theme(legend.position = "none") + scale_color_discrete()
p1


clrs <- dichromat(hue_pal()(9))
p2 <- d + scale_color_manual("", values=clrs) + theme(legend.position = "none")

p2


set.seed(20190715)
df <- data.frame(x=runif(100), y=runif(100), cl=sample(c(rep("A", 1), rep("B", 99))))
ggplot(data=df, aes(x, y, shape=cl)) + theme_bw() + 
  geom_point(size=3) +
  theme(legend.position="None", aspect.ratio=1, axis.text = element_blank(), axis.ticks=element_blank(), axis.title = element_blank()) 


ggplot(data=df, aes(x, y, colour=cl)) + 
  geom_point(size=3) +
  theme_bw() + 
  scale_colour_brewer(palette="Set1") +
  theme(legend.position="None", aspect.ratio=1, axis.text = element_blank(), axis.ticks=element_blank(), axis.title = element_blank()) 


ggplot(tb_kn, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_wrap(~age, ncol=6) +
  scale_color_manual("Sex", values = c("#DC3220", "#005AB5"))  +
  ggtitle("Arrangement A")


ggplot(tb_kn, aes(x=year, y=count, colour=age)) +
  geom_line() + geom_point() +
  facet_wrap(~sex, ncol=6) +
  scale_colour_brewer("", palette="Dark2") +
  ggtitle("Arrangement B")


tb_kn |> filter(year == 2012) |>
  ggplot(aes(x=sex, y=count, fill=sex)) +
  geom_bar(stat="identity", position="dodge") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5"))  +
  ggtitle("Position - common scale ")


tb_kn |> filter(year == 2012) |>
  ggplot(aes(x=1, y=count, fill=sex)) +
  geom_bar(stat="identity", position="fill") + 
  facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ggtitle("Angle") + xlab("") + ylab("") +
  coord_polar(theta = "y")


tb_kn |> filter(year == 2012) |>
  ggplot(aes(x=age, y=count, fill=age)) +
  geom_bar(stat="identity", position="dodge") + 
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Position - common scale ")


tb_kn |> filter(year == 2012) |>
  ggplot(aes(x=1, y=count, fill=age)) +
  geom_bar(stat="identity", position="fill") + 
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Angle") + xlab("") + ylab("") +
  coord_polar(theta = "y")


tb_kn |> filter(year == 2012) |>
  ggplot(aes(x=1, y=count, fill=age)) +
  geom_bar(stat="identity", position="fill") + 
  facet_wrap(~sex, ncol=6) +
  scale_fill_brewer("", palette="Dark2") +
  ggtitle("Position - nonaligned") + xlab("") + ylab("")


ggplot(dsamp, aes(x=carat, y=price, colour = clarity)) +
  geom_point() +
  geom_smooth(se=FALSE) +
  scale_color_brewer(palette="Set1") +
  facet_wrap(~clarity, ncol=4)


ggplot(dsamp, aes(x=carat, y=price, 
                  colour = clarity)) +
  geom_point() +
  geom_smooth(se=FALSE) +
  scale_color_brewer(palette="Set1") 


countdown::countdown(7, 0)

