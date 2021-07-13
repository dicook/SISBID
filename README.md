# SISBID 2021 Module 4: Visualization of Biomedical Big Data

Instructors: Di Cook and Heike Hofmann

Website: [https://dicook.github.io/SISBID/](https://dicook.github.io/SISBID/)

Module description: In this module, we will present general-purpose techniques for visualizing any sort of large data sets, 
as well as specific techniques for visualizing common types of biological data sets. Often the challenge of visualizing Big Data 
is to aggregate it down to a suitable level. Understanding Big Data involves an iterative cycle of visualization and modeling. 
We will illustrate this with several case studies during the workshop. The first segment of this module will focus on structured 
development of graphics using static graphics. This will use the ggplot2 package in R. It enables building plots using 
grammatically defined elements, and producing templates for use with multiple data sets. We will show how to extend these 
principles for genomic data using the ggplot2-based ggbio package. The second segment will focus on interactive graphics 
for rapid exploration of Big Data. We will also demonstrate interactive techniques using plotly, animint and ggvis. In addition 
we will explain how to create simple web GUIs for managing complex summaries of biological data using the shiny package. 
We will use a hands-on teaching methodology that combines short lectures with longer practice sessions. As students learn about 
new techniques, they will also be able to put them into practice and receive feedback from experts. We will teach using R and Rstudio. 
We will assume some familiarity with R.

Recommended Reading: Cookbook for R, by Winston Chang, available at <http://www.cookbook-r.com>, and R for Data Science, by Garrett Grolemund and Hadley Wickham, available at <http://r4ds.had.co.nz>.

## Course Logistics

We use zoom for lectures. All sessions will be recorded and made available. 

Communication with the instructors should be in Zoom or on the slack channel. 

Zoom etiquette: 

- mute yourself when not talking, 
- don't share the link. 

## Course Schedule


| Wednesday, Jul 21 |         Pacific | Melbourne (Di) | Central (Heike) |     East Coast |
|-------------------|----------------:|---------------:|----------------:|---------------:|
| [Meet & Greet](https://dicook.github.io/SISBID/slides/0-preamble/index.html)        |   11:30 - 11:45 am | 4:30 - 4:45 am |  1:30 - 1:45 pm | 2:30 - 2:45 pm |
| [Lecture 1](https://dicook.github.io/SISBID/slides/1.1-ggplot/index.html)        |   11:45 - 12:30 | 4:45 - 5:30 am |  1:45 - 2:30 pm | 2:45 - 3:30 pm |
| [Lecture 2](https://dicook.github.io/SISBID/slides/1.2-ggplot-adv/index.html)         | 12:45 - 1:30 pm | 5:45 - 6:30 am |  2:45 - 3:30 pm | 3:45 - 4:30 pm |
| [Lecture 3](https://dicook.github.io/SISBID/slides/1.3-perception/index.html)         |  1:45 - 2:30 pm | 6:45 - 7:30 am |  3:45 - 4:30 pm | 4:45 - 5:30 pm |


  
  | Thursday, Friday |         Pacific | Melbourne (Di) | Central (Heike) |     East Coast |
|------------------|----------------:|---------------:|----------------:|---------------:|
| Lecture 1         |   8:00 - 8:45 am | 1:00 - 1:45 am |  10:00 - 10:45 am | 11:00 - 11:45 am 
| Lecture 2         | 9:00 - 9:45 am | 2:00 - 2:45 am |  11:00 - 11:45 am | 12:00 - 12:45 pm |
| Lecture 3         |  10:00 - 10:45 am | 3:00 - 3:45 am|   12:00 - 12:45 pm | 1:00 - 1:45 pm  |
| Break |||||
| Lecture 4         |   11:45 - 12:30 | 4:45 - 5:30 am |  1:45 - 2:30 pm | 2:45 - 3:30 pm |
| Lecture 5         | 12:45 - 1:30 pm | 5:45 - 6:30 am |  2:45 - 3:30 pm | 3:45 - 4:30 pm |
| Lecture 6         |  1:45 - 2:30 pm | 6:45 - 7:30 am |  3:45 - 4:30 pm | 4:45 - 5:30 pm |
  

## Course outline

### Wednesday afternoon [zip file](SISBID_day1.zip)

1. [Setting things up](https://dicook.github.io/SISBID/slides/0-preamble/index.html)
1. [The grammar of graphics and ggplot2](https://dicook.github.io/SISBID/slides/1.1-ggplot/index.html) (Heike)
1. [Advancing the grammar to maps, time and interactivity](https://dicook.github.io/SISBID/slides/1.2-ggplot-adv/index.html) (Heike)
1. [Visual perception and effective plot construction](https://dicook.github.io/SISBID/slides/1.3-perception/index.html) (Di)


### Thursday [zip file](SISBID_day2.zip)

Morning: 

1.  [Tidy data and tidying your messy data with tidyr](https://dicook.github.io/SISBID/slides/2.1-tidyr/index.html) (Heike) 
1. [Making Data Messy again](https://dicook.github.io/SISBID/slides/2.2-messy-it-up/index.html) (Heike) 
1. [Wrangling data and models](https://dicook.github.io/SISBID/slides/2.3-wrangling/index.html) (Heike) 

Afternoon: 

1. [Multivariate plots using ggplot2, GGally](https://dicook.github.io/SISBID/slides/2.4-mvplot/index.html) (Di)
1. [Touring on multivariate data](https://dicook.github.io/SISBID/slides/2.5-mvplot-tour/index.html) (Di)
1. [Advanced graphics, and statistical inference](https://dicook.github.io/SISBID/slides/2.6-adv-graphics/index.html) (Di) 


### Friday [zip file](SISBID_day3.zip)

Morning:

1. [Interactive and animated graphics using plotly and gganimate](https://dicook.github.io/SISBID/slides/3.1-interactive-plots/index.html) (Heike).
1. [How to build a shiny app](https://dicook.github.io/SISBID/slides/3.2-shiny-apps/index.html) (Heike).
1. [Reactive elements in shiny](https://github.com/dicook/SISBID/raw/master/slides/3.3-shiny-reactivity/3.3-shiny-reactivity.pdf) (Heike).

Afternoon:

1. [Polish and share your own shiny app](https://dicook.github.io/SISBID/slides/3.4-build_a_shiny_app) (Di).
1. [Building interactive documents with Rmarkdown tools, learnr, flexdashboard](https://dicook.github.io/SISBID/slides/3.5-make_your_own_interactive_document/index.html) (Di). 
1. Show us what you've made (Di)

## Software list

Download [RStudio >= 1.3.959 ](https://www.rstudio.com/products/rstudio/download/), [R version >= 4.0.1 (2020-06-06) -- "See Things Now"](https://cran.r-project.org)

Open RStudio, and run the code below to install these packages and their dependencies:

```
# CRAN packages
packages <- c("tidyverse", "ggmap", "RColorBrewer", "gridExtra", "dichromat", "janitor",
"forcats", "ggthemes", "here", "wordcloud", "lubridate", "plotly", "broom", "GGally",
"gapminder", "nullabor", "shiny", "ggenealogy", "ggmosaic", "HLMdiag",  "gganimate", "remotes",
"naniar", "htmltools", "mapproj", "leaflet", "broom.mixed", "lme4")

install.packages(packages, dep=TRUE, repos = "https://cloud.r-project.org/")

# github packages
remotes::install_github("wmurphyrd/fiftystater")
```
