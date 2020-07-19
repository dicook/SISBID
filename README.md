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

## Course Schedule


| Wednesday, Jul 22 |         Pacific | Melbourne (Di) | Central (Heike) |     East Coast |
|-------------------|----------------:|---------------:|----------------:|---------------:|
| Meet & Greet         |   11:30 - 11:45 am | 4:30 - 4:45 am |  1:30 - 1:45 pm | 2:30 - 2:45 pm |
| Lecture 1         |   11:45 - 12:30 | 4:45 - 5:30 am |  1:45 - 2:30 pm | 2:45 - 3:30 pm |
| Lecture 2         | 12:45 - 1:30 pm | 5:45 - 6:30 am |  2:45 - 3:30 pm | 3:45 - 4:30 pm |
| Lecture 3         |  1:45 - 2:30 pm | 6:45 - 7:30 am |  3:45 - 4:30 pm | 4:45 - 5:30 pm |


  
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

### Day 1 [zip file](https://github.com/dicook/SISBID/blob/master/SISBID_day1.zip)

1. [Preamble](0-preamble/index.html)
1. The grammar of graphics and ggplot2 (Heike)
1. Advancing the grammar to maps, time and interactivity (Heike)
1. Visual perception and effective plot construction (Di)

### Day 2 [zip file](https://github.com/dicook/SISBID/blob/master/SISBID_day2.zip)

Morning: 

1. Tidy data and tidying your messy data with tidyr (Heike)
1. Tidying model data with broom (Heike)
1. Data manipulation with dplyr, purrr and broom (Heike)

Afternoon: 

1. Multivariate plots using ggplot2, GGally (Di)
1. Touring on multivariate data (Di)
1. Advanced graphics, and statistical inference (Di) 

### Day 3 [zip file](https://github.com/dicook/SISBID/blob/master/SISBID_day3.zip)

Morning:

1. Interactive and animated graphics using plotly and gganimate (Heike).
1. Building interactive documents with Rmarkdown tools, learnr, flexdashboard (Di). XXX do we need this? I could expand more into leaflet and shiny and start with shiny in the morning. 
1. How to build a shiny app (Heike).

Afternoon:

1. Polish and share your own shiny app (Di).


## Examples

- [Cyber Bullying](https://ztimpe.shinyapps.io/apppractice)

## Software list

Download [RStudio >= 1.3.959 ](https://www.rstudio.com/products/rstudio/download/), [R version 4.0.1 (2020-06-06) -- "See Things Now"](https://cran.r-project.org)

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
