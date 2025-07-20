# Studying tb in Australia

tb_oz <- tb |>
  filter(country == "Australia") |>
  filter(!(age %in% c("04", "014", "514", "u"))) |>
  filter(year > 1996, year < 2013) |>
  mutate(
    age_group = factor(age, labels = c("15-24", "25-34", "35-44", "45-54", "55-64", "65+"))
  )

ggplot(tb_oz, aes(x=year, y=count, colour=sex)) +
  geom_point() +
  geom_smooth(method="lm", se=F) +
  facet_grid(~age_group) +
  scale_colour_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ylim(c(0,NA))

ggplot(tb_oz, aes(x=year, y=count, colour=sex)) +
  geom_point() +
  geom_smooth(se=F) +
  facet_grid(~age_group) +
  scale_colour_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ylim(c(0,NA))
