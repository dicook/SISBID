#' ---
#' title: A Grammar of Graphics
#' filters:
#' - quarto
#' - line-highlight
#' ---
#' 


source(here::here("knitr-setup.R"))
source(here::here("libraries.R"))

#| label: read-and-wrangle-TB-data
#| echo: false
tb <- readr::read_csv(here::here("data/TB_notifications_2025-07-22.csv")) |>
  dplyr::select(country, iso3, year, new_sp_m04:new_sp_fu) |>
  pivot_longer(new_sp_m04:new_sp_fu, names_to="stuff", values_to="count") |>
  separate(stuff, c("stuff1", "stuff2", "sexage")) |>
  dplyr::select(-stuff1, -stuff2) |>
  mutate(sex=substr(sexage, 1, 1), 
         age=substr(sexage, 2, length(sexage))) |>
  dplyr::select(-sexage)

# Filter data to get the US
tb_us <- tb |> 
  filter(iso3 == "USA") |>
  filter(!(age %in% c("04", "014", "514", "u"))) |>
  mutate(
    age_group = factor(age, labels = c("15-24", "25-34", "35-44", "45-54", "55-64", "65+"))
  )

#| label: make-a-barchart-of-US-TB-incidence
#| echo: true
#| out-width: 80%
#| fig-width: 10
#| fig-height: 3
ggplot(tb_us, aes(x = year, 
                  y = count, 
                  fill = sex)) +
  geom_bar(stat = "identity") +
  facet_grid(~ age) 

#| label: colour-and-axes-fixes
#| echo: true
#| fig-height: 3
#| code-line-numbers: '5,6'
# This uses a color blind friendly scale
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(~age_group)  + 
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) + 
  theme_bw() 

#| label: compare-proportions-of-males-females
#| echo: true
#| out-width: 80%
#| fig-height: 3
#| code-line-numbers: '3,4'
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +  
  geom_bar(stat="identity", position="fill") + 
  ylab("proportion") + 
  facet_grid(~age_group) +  
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) 

#| label: compare-counts-of-males-females
#| echo: true
#| out-width: 100%
#| fig-height: 5
#| code-line-numbers: '5'
# Make separate plots for males and females, focus on counts by category
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") +
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) + 
  facet_grid(sex~age_group) + 
  theme_bw()

#| label: rose-plot-of-males-females
#| echo: true
#| fig-height: 5
#| code-line-numbers: '6'
# How to make a pie instead of a barchart - not straight forward
ggplot(tb_us, aes(x=year, y=count, fill=sex)) +
  geom_bar(stat="identity") + 
  facet_grid(sex~age_group) + 
  scale_fill_manual("Sex", values = c("#DC3220", "#005AB5")) +
  coord_polar() + 
  theme_bw()

#| label: stacked-barchart-of-males-females
#| echo: true
#| fig-height: 5
#| code-line-numbers: '3'
# Step 1 to make the pie
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) +
  geom_bar(stat="identity", position="fill") + 
  facet_grid(sex~age_group) +
  scale_fill_viridis_d("", option="inferno") 

#| label: pie-chart-of-males-females
#| echo: true
#| out-width: 60%
#| fig-height: 5
#| code-line-numbers: '3,4,7'
# Now we have a pie, note the mapping of variables
# and the modification to the coord_polar
ggplot(tb_us, aes(x = 1, y = count, fill = factor(year))) + 
  geom_bar(stat="identity", position="fill") + 
  facet_grid(sex~age_group) +
  scale_fill_viridis_d("", option="inferno") +
  coord_polar(theta = "y") 

#| echo: false
#| out-width: 60%
#| fig-height: 5
#| code-line-numbers: '1,3'
#| eval: false
# age for segments, facet by year and sex
ggplot(tb_us, aes(x = 1, y = count, fill = factor(age_group))) + 
  geom_bar(stat="identity", position="fill") + 
  facet_grid(sex~year) + 
  scale_fill_viridis_d("", option="inferno") +
  coord_polar(theta = "y") +
  theme(legend.position="bottom")


ggplot(tb_us, aes(x=year, y=count, colour=sex)) +
  geom_line() + geom_point() +
  facet_grid(~age_group) +
  scale_colour_manual("Sex", values = c("#DC3220", "#005AB5")) +
  ylim(c(0,NA)) +
  theme_bw()


tb_us |> group_by(year, age_group) |> 
  summarise(p = count[sex=="m"]/sum(count)) |>
  ggplot(aes(x=year, y=p)) +
  geom_hline(yintercept = 0.50, colour="grey50", linewidth=2) +
  geom_line() + geom_point() +
  facet_grid(~age_group) +
  ylab("Proportion of Males") +
  theme_bw()

