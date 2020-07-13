# SISBID 2020 Module 4: Visualization of Biomedical Big Data

Instructors: Dianne Cook and Heike Hofmann

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

## Schedule

All times are in Pacific Day Time:

Wednesday:

  - Lecture 1: 11:30-12:15
  - Lecture 2: 12:45-1:30
  - Lecture 3: 1:45-2:30

Thursday, Friday:

  - Lecture 1: 8-8:45
  - Lecture 2: 9-9:45
  - Lecture 3: 10:15-11
  - Lecture 4: 11:15-noon
  - Lecture 5: 12:30-1:15
  - Lecture 6: 1:30-2:15


## Course outline

### Day 1 [zip file](https://github.com/dicook/SISBID/blob/master/SISBID_day1.zip)

1. The grammar of graphics and ggplot2 (Di).
1. Visual perception and effective plot construction (Heike)

### Day 2 [zip file](https://github.com/dicook/SISBID/blob/master/SISBID_day2.zip)

1. Tidy data and tidying your messy data with tidyr (Heike).
1. Data manipulation with dplyr, purrr and broom (Heike).
1. Multivariate plots using ggplot2, GGally and tourr (Di).
1. Advanced graphics, and statistical inference (Di) 

### Day 3 [zip file](https://github.com/dicook/SISBID/blob/master/SISBID_day3.zip)

1. Interactive and animated graphics using plotly and gganimate (Heike).
1. Building interactive documents with Rmarkdown tools, learnr, flexdashboard (Di).
1. How to build a shiny app (Heike).
1. Polish and share your own shiny app (Di).

## Examples

- [Cyber Bullying](https://ztimpe.shinyapps.io/apppractice)

## Software list

Download [RStudio >= 1.2.1335 ](https://www.rstudio.com/products/rstudio/download/), [R version 3.6.1 (2019-07-05) -- "Action of the Toes"](https://cran.r-project.org)

Open RStudio, and run the code below to install these packages and their dependencies:

```
# CRAN packages
packages <- c("tidyverse", "ggmap", "RColorBrewer", "gridExtra", "dichromat", "janitor",
"forcats", "ggthemes", "here", "wordcloud", "lubridate", "plotly", "broom", "GGally",
"gapminder", "nullabor", "shiny", "ggenealogy", "ggmosaic", "HLMdiag",  "gganimate", "remotes",
"naniar", "htmltools")

install.packages(packages, dep=TRUE, repos = "https://cloud.r-project.org/")

# github packages
remotes::install_github("wmurphyrd/fiftystater")
```
