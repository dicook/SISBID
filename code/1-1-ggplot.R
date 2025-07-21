#' ---
#' title: A Grammar of Graphics
#' ---
#' 


source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))


tb <- readr::read_csv(here::here("data/TB_notifications_2020-07-01.csv")) |>
  dplyr::select(country, iso3, year, new_sp_m04:new_sp_fu) |>
  pivot_longer(new_sp_m04:new_sp_fu, names_to="stuff", values_to="count") |>
  separate(stuff, c("stuff1", "stuff2", "sexage")) |>
  dplyr::select(-stuff1, -stuff2) |>
  mutate(sex=substr(sexage, 1, 1), 
         age=substr(sexage, 2, length(sexage))) |>
  dplyr::select(-sexage)

# Filter years between 1997 and 2012 due to missings
tb_us <- tb |> 
  filter(country == "United States of America") |>
  filter(!(age %in% c("04", "014", "514", "u"))) |>
  filter(year > 1996, year < 2013) |>
  mutate(
    age_group = factor(age, labels = c("15-24", "25-34", "35-44", "45-54", "55-64", "65+"))
  )


ggplot(tb_us, aes(x = year, y = count, fill = sex)) +
  geom_bar(stat = "identity") +
  facet_grid(~ age) 


# This uses a color blind friendly scale
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(~age_group) + #<<
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) #<<


# Fill the bars, note the small change to the code
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +  
  geom_bar(stat="identity", position="fill") + #<<
  ylab("proportion") + #<<
  facet_grid(~age_group) + 
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) 


ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
 geom_bar(stat="identity", position="dodge") +
 facet_wrap(~age, ncol=6) +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) + 
 scale_x_continuous("year", breaks=seq(1995, 2012, 5), labels=c("95", "00", "05", "10"))


# Make separate plots for males and females, focus on counts by category
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) + 
  facet_grid(sex~age_group)  #<<


# How to make a pie instead of a barchart - not straight forward
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(sex~age_group) + 
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  coord_polar() #<<


# Step 1 to make the pie
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") + #<<
  facet_grid(sex~age_group) +
  scale_fill_viridis_d("", option="inferno") 


# Now we have a pie, note the mapping of variables
# and the modification to the coord_polar
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") + 
  facet_grid(sex~age_group) +
  scale_fill_viridis_d("", option="inferno") +
  coord_polar(theta = "y") #<<


# age for segments, facet by year and sex
ggplot(tb_us, aes(x = 1, y = count, fill = factor(age_group))) + #<<
  geom_bar(stat="identity", position="fill") + 
  facet_grid(sex~year) + #<<
  scale_fill_viridis_d("", option="inferno") +
  coord_polar(theta = "y") +
  theme(legend.position="bottom")


ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_grid(~age_group) +
  scale_colour_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ylim(c(0,NA))


tb_us |> group_by(year, age_group) |> 
  summarise(p = count[sex=="m"]/sum(count)) |>
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="grey50", linewidth=2) +
  geom_line() + geom_point() +
  facet_grid(~age_group) +
  ylab("Proportion of Males") 

