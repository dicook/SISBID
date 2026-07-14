

# SISBID 2026 Module 2: Data Visualization

Instructors: Di Cook, Heike Hofmann and Susan Vanderplas

Website: <https://dicook.github.io/SISBID/>

## Module description

We will present general-purpose techniques for visualizing a variety of
data, as well as specific techniques for visualizing common types of
biological data sets. Some strategies for working with large data will
be provided. Understanding data involves an iterative cycle of
visualization and modeling. We will illustrate this with several
examples during the workshop.

The first segment of this module will focus on structured development of
graphics using static graphics. This will use the ggplot2 package in R.
It enables building plots using grammatically defined elements, and
producing templates for use with multiple data sets. We will include
some these principles for working with biological and genomic data.

The second segment will focus on interactive graphics for rapid
exploration. We will also demonstrate interactive techniques for
high-performance local display, and for easily creating interactive web
graphics. In addition, we will explain how to create simple web GUIs for
managing interactive analysis tools for data using shiny.

We will use a hands-on teaching methodology that combines short lectures
with longer practice sessions. As students learn about new techniques,
they will also be able to put them into practice and receive feedback
from experts.

Module assumes some familiarity with R. We will teach using R and
Rstudio.

Recommended Reading:

- [Cookbook for R, by Winston Chang](http://www.cookbook-r.com)
- [R for Data Science, by Hadley Wickham, Mine Çetinkaya-Rundel, and
  Garrett Grolemund](http://r4ds.had.co.nz).

## Course Logistics

We use zoom for lectures. All sessions will be recorded and made
available.

Communication with the instructors should be in Zoom or on the slack
channel.

Zoom etiquette:

- mute yourself when not talking,
- don’t share the link.

## Course Schedule

<div class="panel-tabset">

### Monday morning

| Monday | US Pacific | US Central | US Eastern | Accra | London | Korea | Melbourne |
|----|---:|---:|---:|---:|---:|---:|---:|
| [Meet & Greet](slides/0-preamble.rjs.html) | 7:45 - 8:00 am | 9:45 - 10:00 am | 10:45 - 11:00 am | 2:45 - 3:00 pm | 3:45 - 4:00 pm | 11:45 am - 12:00 pm | 12:45 - 1:00 am |
| [Lecture 1](slides/1-1-ggplot.rjs.html) | 8:00 - 8:45 am | 10:00 - 10:45 am | 11:00 - 11:45 am | 3:00 - 3:45 pm | 4:00 - 4:45 pm | 12:00 - 12:45 am | 1:00 - 1:45 am |
| [Lecture 2](slides/1-2-ggplot-adv.rjs.html) | 9:00 - 9:45 am | 11:00 - 11:45 am | 12:00 - 12:45 pm | 4:00 - 4:45 pm | 5:00 - 5:45 pm | 1:00 - 1:45 am | 2:00 - 2:45 am |
| [Lecture 3](slides/1-3-perception.rjs.html) | 10:00 - 10:45 am | 12:00 - 12:45 pm | 1:00 - 1:45 pm | 5:00 - 5:45 pm | 6:00 - 6:45 pm | 2:00 - 2:45 am | 3:00 - 3:45 am |
| Break |  |  |  |  |  |  |  |
| [Lecture 4](slides/2.1-tidyr.rjs.html) | 11:45 - 12:30 | 1:45 - 2:30 pm | 2:45 - 3:30 pm | 6:45 - 7:30 pm | 7:45 - 8:30 pm | 3:45 - 4:30 am | 4:45 - 5:30 pm |
| [Lecture 5](slides/2.2-messy-it-up.rjs.html) | 12:45 - 1:30 pm | 2:45 - 3:30 pm | 3:45 - 4:30 pm | 7:45 - 8:30 pm | 8:45 - 9:30 pm | 4:45 - 5:30 am | 5:45 - 6:30 am |
| [Lecture 6](slides/2.3-wrangling.rjs.html) | 1:45 - 2:30 pm | 3:45 - 4:30 pm | 4:45 - 5:30 pm | 8:45 - 9:30 pm | 9:45 - 10:30 pm | 5:45 - 6:30 am | 6:45 - 7:30 am |

### Tuesday

| Tuesday | US Pacific | US Central | US Eastern | Accra | London | Korea | Melbourne |
|----|----|----|----|----|----|----|----|
| [Lecture 7](slides/2.4-mvplot.rjs.html) | 8:00 - 8:45 am | 10:00 - 10:45 am | 11:00 - 11:45 am | 3:00 - 3:45 pm | 4:00 - 4:45 pm | 12:00 - 12:45 am | 1:00 - 1:45 am |
| [Lecture 8](slides/2.5-mvplot-tour.rjs.html) | 9:00 - 9:45 am | 11:00 - 11:45 am | 12:00 - 12:45 pm | 4:00 - 4:45 pm | 5:00 - 5:45 pm | 1:00 - 1:45 am | 2:00 - 2:45 am |
| [Lecture 9](slides/2.6-adv-graphics.rjs.html) | 10:00 - 10:45 am | 12:00 - 12:45 pm | 1:00 - 1:45 pm | 5:00 - 5:45 pm | 6:00 - 6:45 pm | 2:00 - 2:45 am | 3:00 - 3:45 am |
| Break |  |  |  |  |  |  |  |
| [Lecture 10](slides/3.1-interactive-plots.rjs.html) | 11:45 - 12:30 | 1:45 - 2:30 pm | 2:45 - 3:30 pm | 6:45 - 7:30 pm | 7:45 - 8:30 pm | 3:45 - 4:30 am | 4:45 - 5:30 pm |
| [Lecture 11](slides/3.2-shiny-apps.rjs.html) | 12:45 - 1:30 pm | 2:45 - 3:30 pm | 3:45 - 4:30 pm | 7:45 - 8:30 pm | 8:45 - 9:30 pm | 4:45 - 5:30 am | 5:45 - 6:30 am |
| [Lecture 12](slides/3.3-shiny-reactivity.rjs.html) | 1:45 - 2:30 pm | 3:45 - 4:30 pm | 4:45 - 5:30 pm | 8:45 - 9:30 pm | 9:45 - 10:30 pm | 5:45 - 6:30 am | 6:45 - 7:30 am |

### Wednesday

| Wednesday | US Pacific | US Central | US Eastern | Accra | London | Korea | Melbourne |
|----|----|----|----|----|----|----|----|
| [Lecture 13](slides/3.4-theme_a_shiny_app.rjs.html) | 8:00 - 8:45 am | 10:00 - 10:45 am | 11:00 - 11:45 am | 3:00 - 3:45 pm | 4:00 - 4:45 pm | 12:00 - 12:45 am | 1:00 - 1:45 am |
| [Lecture 14](slides/3.5-build_a_shiny_app.rjs.html) | 9:00 - 9:45 am | 11:00 - 11:45 am | 12:00 - 12:45 pm | 4:00 - 4:45 pm | 5:00 - 5:45 pm | 1:00 - 1:45 am | 2:00 - 2:45 am |
| [Lecture 15](slides/3.6-make_your_own_interactive_document.rjs.html) / Show and Tell | 10:00 - 10:45 am | 12:00 - 12:45 pm | 1:00 - 1:45 pm | 5:00 - 5:45 pm | 6:00 - 6:45 pm | 2:00 - 2:45 am | 3:00 - 3:45 am |

</div>

## Course outline

### Slack

Find us on slack: [SISBID.slack.com](SISBID.slack.com). The channel
`data-visualization-2026` will contain zoom and (later) video links for
the sessions.

### Wednesday afternoon

[ Day 1 zip file](SISBID_day1.zip)

| Title | Slides | 1pg Slides | Code | Instructor |
|----|----|----|----|----|
| 0\. Setting things up | [ Slides](slides/0-preamble.rjs.html) | [ 1pg](slides/0-preamble.onepage.html) | [ Code](code/0-preamble.R) | All |
| 1.1 The grammar of graphics and ggplot2 | [ Slides](slides/1-1-ggplot.rjs.html) | [ 1pg](slides/1-1-ggplot.onepage.html) | [ Code](code/1-1-ggplot.R) | Heike |
| 1.2 Advancing the grammar to maps, time and interactivity | [ Slides](slides/1-2-ggplot-adv.rjs.html) | [ 1pg](slides/1-2-ggplot-adv.onepage.html) | [ Code](code/1-2-ggplot-adv.R) | Di |
| 1.3 Visual perception and effective plot construction | [ Slides](slides/1-3-perception.rjs.html) | [ 1pg](slides/1-3-perception.onepage.html) | [ Code](code/1-3-perception.R) | Susan |

### Thursday

[ Day 2 zip file](SISBID_day2.zip)  
Note: this zip file assumes you will extract to the same folder as
yesterday – data files have not been included twice.

| Title | Slides | 1pg Slides | Code | Instructor |
|----|----|----|----|----|
| 2.1 Tidy data and tidying your messy data with tidyr | [ Slides](slides/2-1-tidyr.rjs.html) | [ 1pg](slides/2-1-tidyr.onepage.html) | [ Code](code/2-1-tidyr.R) | Heike |
| 2.2 Making Data Messy again | [ Slides](slides/2-2-messy-it-up.rjs.html) | [ 1pg](slides/2-2-messy-it-up.onepage.html) | [ Code](code/2-2-messy-it-up.R) | Susan |
| 2.3 Wrangling data and models | [ Slides](slides/2-3-wrangling.rjs.html) | [ 1pg](slides/2-3-wrangling.onepage.html) | [ Code](code/2-3-wrangling.R) | Heike |
| Break |  |  |  |  |
| 2.4 Multivariate plots using ggplot2, GGally | [ Slides](slides/2-4-mvplot.rjs.html) | [ 1pg](slides/2-4-mvplot.onepage.html) | [ Code](code/2-4-mvplot.R) | Di |
| 2.5 Touring on multivariate data | [ Slides](slides/2-5-mvplot-tour.rjs.html) | [ 1pg](slides/2-5-mvplot-tour.onepage.html) | [ Code](code/2-5-mvplot-tour.R) | Di |
| 2.6 Advanced graphics and statistical inference | [ Slides](slides/2-6-adv-graphics.rjs.html) | [ 1pg](slides/2-6-adv-graphics.onepage.html) | [ Code](code/2-6-adv-graphics.R) | Susan |

### Friday

[ Day 3 zip file](SISBID_day3.zip)  
Note: this zip file assumes you will extract to the same folder as
Wednesday – data files have not been included twice.

| Title | Slides | 1pg Slides | Code | Instructor |
|----|----|----|----|----|
| 3.1 Interactive and animated graphics using plotly and gganimate | [ Slides](slides/3-1-interactive-plots.rjs.html) | [ 1pg](slides/3-1-interactive-plots.onepage.html) | [ Code](code/3-1-interactive-plots.R) | Heike |
| 3.2 How to build a shiny app | [ Slides](slides/3-2-shiny-apps.rjs.html) | [ 1pg](slides/3-2-shiny-apps.onepage.html) | [ Code](code/3-2-shiny-apps.R) | Susan |
| 3.3 Reactive elements in shiny | [ Slides](slides/3-3-shiny-reactivity.rjs.html) | [ 1pg](slides/3-3-shiny-reactivity.onepage.html) | [ Code](code/3-3-shiny-reactivity.R) | Heike |
| Break |  |  |  |  |
| 3.4 Theme a shiny app | [ Slides](slides/3-4-theme-shiny.rjs.html) | [ 1pg](slides/3-4-theme-shiny.onepage.html) | [ Code](code/3-4-theme-shiny.R) | Susan |
| 3.5 Build your own Shiny app | [ Slides](slides/3-5-build-shiny-app.rjs.html) | [ 1pg](slides/3-5-build-shiny-app.onepage.html) | [ Code](code/3-5-build-shiny-app.R) | Heike |
| Show us What You’ve Made |  |  |  | All |
| 3.6 Interactive Documents | [ Slides](slides/3-6-interactive-document.rjs.html) | [ 1pg](slides/3-6-interactive-document.onepage.html) | [ Code](code/3-6-interactive-document.R) | Di |

## Software list

Download [RStudio](https://www.rstudio.com/products/rstudio/download/),
and [latest R version](https://cran.r-project.org).

Open RStudio, and run the code below to install these packages and their
dependencies:

``` r
# CRAN packages
packages <- c(
  "here", "readr", "readxl", "splitstackshape", "tidyr", "dplyr", "lubridate",
  "stringr", "purrr", "ggplot2", "ggthemes", "RColorBrewer", "scales",
  "dichromat", "colorspace", "viridis", "ggbeeswarm", "ggmap", "gridExtra",
  "GGally", "ggpcp", "corrgram", "tourr", "gganimate", "maps","datasauRus",
  "gapminder", "cranlogs", "shiny", "bslib", "DT", "leaflet", "plotly",
  "htmltools", "broom", "broom.mixed", "lme4", "MASS", "forecast", "nullabor",
  "ggdist", "bsicons", "ragg", "showtext", "thematic", "remotes", "quarto",
  "bslib")

# Install packages and their dependencies
to_install <- setdiff(packages, installed.packages())
install.packages(to_install, dep=TRUE, repos = "https://cloud.r-project.org/")

# Install some packages from GitHub
# If you can't install these,
# it won't affect your ability to participate
remotes::install_github("wmurphyrd/fiftystater")
remotes::install_github("heike/vinference")
remotes::install_github("rstudio/bslib")
remotes::install_github("rlbarter/superheat")

# For sharing web apps,
# but you need administrator rights to your computer:
install.packages("rsconnect")
```

**Note:** You can install all of the `tidyverse` of packages - `tidyr`,
`dplyr`, `readr`, `ggplot2`, `tibble`, `purrr`, `forcats`, `stringr` -
with `install.packages("tidyverse")`. But some operating systems seem to
run into difficulties doing this, so installing just a subset is easier.

If you want to compile the slides - you really don’t want to do this,
but if you do - you will need these additional packages:

``` r
install.packages("remotes")
remotes::install_github("hadley/emo")
remotes::install_github("mitchelloharawild/icons")
remotes::install_github("emitanaka/anicon")
remotes::install_github("dicook/gretchenalbrecht")
remotes::install_github("gadenbuie/countdown", subdir = "r")
install.packages("xaringanExtra")
```
