#' ---
#' title: Making a mess again - with the data
#' ---
#' 


source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


load(here::here("data/french_fries.rda"))


head(french_fries)


ff_long <- french_fries |> 
  pivot_longer(potato:painty, names_to = "type", values_to = "rating")


head(ff_long)


knitr::kable(head(ff_long, 3))


french_fries_weeks <- ff_long |> 
  pivot_wider(names_from = "time", values_from = "rating")


knitr::kable(head(french_fries_weeks,3))


head(french_fries_weeks)


french_fries_weeks |>
  ggplot(aes(x = `1`, y = `9`)) + geom_point()


ff.s <- ff_long |> pivot_wider(names_from=rep, values_from=rating)
ggplot(data=ff.s, aes(x=`1`, y=`2`)) + geom_point() +
  theme(aspect.ratio=1) 
ggplot(data=ff.s, aes(x=`1`, y=`2`)) + geom_point() +
  theme(aspect.ratio=1) + 
  xlab("Rep 1") + ylab("Rep 2") + facet_wrap(~type, ncol=5)


ff.m <- french_fries |> 
pivot_longer(-(time:rep), names_to="type", values_to="rating")
head(ff.m)


ff.m <- french_fries |> 
pivot_longer(-(time:rep), names_to="type", values_to="rating")
head(ff.m)


ggplot(data=ff.m, aes(x=rating)) + geom_histogram(binwidth=2) + 
facet_wrap(~type, ncol=5) 


ggplot(data=ff.m, aes(x=type, y=rating, fill=type)) + 
geom_boxplot()


ff.scales <- ff_long |> pivot_wider(names_from=type, values_from=rating)

cor(ff.scales[,5:9], use="pairwise.complete")

ggplot(data=ff.scales, aes(x=potato, y=buttery)) + geom_point() +
  theme(aspect.ratio=1) 


ff.m$time <- as.numeric(ff.m$time)
ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) + 
geom_point(size=.75) +
geom_smooth() +
facet_wrap(~type)


ff.m$time <- as.numeric(ff.m$time)
ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) + 
geom_point(size=.75) +
geom_smooth() +
facet_wrap(~type)


# long model is fine to use for a single model:

model <- lm(rating ~ type*time-1, data = ff_long)

ggplot(data=ff.m, aes(x=time, y=rating, colour=type)) + 
geom_smooth(method="lm", se=FALSE, aes(colour = type))

