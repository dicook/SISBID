

# SISBID 2025 Module 2: Data Visualization

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

### Wednesday

| Wednesday | US Pacific | US Central | US Eastern | Accra | London | Korea | Melbourne |
|----|---:|---:|---:|---:|---:|---:|---:|
| [Meet & Greet](slides/0-preamble.rjs.html) | 11:30 - 11:45 am | 1:30 - 1:45 pm | 2:30 - 2:45 pm | 6:30 - 6:45 pm | 7:30 - 7:45 pm | 3:30 - 3:45 am | 4:30 - 4:45 am |
| [Lecture 1](slides/1-1-ggplot.rjs.html) | 11:45 - 12:30 | 1:45 - 2:30 pm | 2:45 - 3:30 pm | 6:45 - 7:30 pm | 7:45 - 8:30 pm | 3:45 - 4:30 am | 4:45 - 5:30 pm |
| [Lecture 2](slides/1-2-ggplot-adv.rjs.html) | 12:45 - 1:30 pm | 2:45 - 3:30 pm | 3:45 - 4:30 pm | 7:45 - 8:30 pm | 8:45 - 9:30 pm | 4:45 - 5:30 am | 5:45 - 6:30 am |
| [Lecture 3](slides/1-3-perception.rjs.html) | 1:45 - 2:30 pm | 3:45 - 4:30 pm | 4:45 - 5:30 pm | 8:45 - 9:30 pm | 9:45 - 10:30 pm | 5:45 - 6:30 am | 6:45 - 7:30 am |

### Thursday

| Thursday | US Pacific | US Central | US Eastern | Accra | London | Korea | Melbourne |
|----|----|----|----|----|----|----|----|
| [Lecture 1](slides/2.1-tidyr.rjs.html) | 8:00 - 8:45 am | 10:00 - 10:45 am | 11:00 - 11:45 am | 3:00 - 3:45 pm | 4:00 - 4:45 pm | 12:00 - 12:45 am | 1:00 - 1:45 am |
| [Lecture 2](slides/2.2-messy-it-up.rjs.html) | 9:00 - 9:45 am | 11:00 - 11:45 am | 12:00 - 12:45 pm | 4:00 - 4:45 pm | 5:00 - 5:45 pm | 1:00 - 1:45 am | 2:00 - 2:45 am |
| [Lecture 3](slides/2.3-wrangling.rjs.html) | 10:00 - 10:45 am | 12:00 - 12:45 pm | 1:00 - 1:45 pm | 5:00 - 5:45 pm | 6:00 - 6:45 pm | 2:00 - 2:45 am | 3:00 - 3:45 am |
| Break |  |  |  |  |  |  |  |
| [Lecture 4](slides/2.4-mvplot.rjs.html) | 11:45 - 12:30 | 1:45 - 2:30 pm | 2:45 - 3:30 pm | 6:45 - 7:30 pm | 7:45 - 8:30 pm | 3:45 - 4:30 am | 4:45 - 5:30 pm |
| [Lecture 5](slides/2.5-mvplot-tour.rjs.html) | 12:45 - 1:30 pm | 2:45 - 3:30 pm | 3:45 - 4:30 pm | 7:45 - 8:30 pm | 8:45 - 9:30 pm | 4:45 - 5:30 am | 5:45 - 6:30 am |
| [Lecture 6](slides/2.6-adv-graphics.rjs.html) | 1:45 - 2:30 pm | 3:45 - 4:30 pm | 4:45 - 5:30 pm | 8:45 - 9:30 pm | 9:45 - 10:30 pm | 5:45 - 6:30 am | 6:45 - 7:30 am |

### Friday

| Friday | US Pacific | US Central | US Eastern | Accra | London | Korea | Melbourne |
|----|----|----|----|----|----|----|----|
| [Lecture 1](slides/2-6-adv-graphics.rjs.html) | 8:00 - 8:45 am | 10:00 - 10:45 am | 11:00 - 11:45 am | 3:00 - 3:45 pm | 4:00 - 4:45 pm | 12:00 - 12:45 am | 1:00 - 1:45 am |
| [Lecture 2](slides/3.1-interactive-plots.rjs.html) | 9:00 - 9:45 am | 11:00 - 11:45 am | 12:00 - 12:45 pm | 4:00 - 4:45 pm | 5:00 - 5:45 pm | 1:00 - 1:45 am | 2:00 - 2:45 am |
| [Lecture 3](slides/3.2-shiny-apps.rjs.html) | 10:00 - 10:45 am | 12:00 - 12:45 pm | 1:00 - 1:45 pm | 5:00 - 5:45 pm | 6:00 - 6:45 pm | 2:00 - 2:45 am | 3:00 - 3:45 am |
| Break |  |  |  |  |  |  |  |
| [Lecture 4](slides/3.3-shiny-reactivity.rjs.html) | 11:45 - 12:30 | 1:45 - 2:30 pm | 2:45 - 3:30 pm | 6:45 - 7:30 pm | 7:45 - 8:30 pm | 3:45 - 4:30 am | 4:45 - 5:30 pm |
| [Lecture 5](slides/3.4-theme_a_shiny_app.rjs.html) | 12:45 - 1:30 pm | 2:45 - 3:30 pm | 3:45 - 4:30 pm | 7:45 - 8:30 pm | 8:45 - 9:30 pm | 4:45 - 5:30 am | 5:45 - 6:30 am |
| [Lecture 6](slides/3.5-build_a_shiny_app.rjs.html) & [Lecture 7](slides/3.6-make_your_own_interactive_document.rjs.html) | 1:45 - 2:30 pm | 3:45 - 4:30 pm | 4:45 - 5:30 pm | 8:45 - 9:30 pm | 9:45 - 10:30 pm | 5:45 - 6:30 am | 6:45 - 7:30 am |

</div>

## Course outline

### Slack

Find us on slack: [SISBID.slack.com](SISBID.slack.com). The channel is
`data-visualization-2025` which contains zoom and video links.

### Wednesday afternoon

zip file
[download](https://github.com/downloads/dicook/SISBID/SISBID_day1.zip)

1.  Setting things up · [ Slides](slides/0-preamble.rjs.html) · [ Single
    page](slides/0-preamble.onepage.html)
2.  The grammar of graphics and ggplot2 · [
    Slides](slides/1-1-ggplot.rjs.html) · [ Single
    page](slides/1-1-ggplot.onepage.html) (Heike)
3.  Advancing the grammar to maps, time and interactivity · [
    Slides](slides/1-2-ggplot-adv.rjs.html) · [ Single
    page](slides/1-2-ggplot-adv.onepage.html) (Di)
4.  Visual perception and effective plot construction · [
    Slides](slides/1-3-perception.rjs.html) · [ Single
    page](slides/1-3-perception.onepage.html) (Susan)

### Thursday

zip file [download](SISBID_day2.zip)  
Note: this zip file assumes you will extract to the same folder as
yesterday – data files have not been included twice.

#### Morning

1.  Tidy data and tidying your messy data with tidyr · [
    Slides](slides/2-1-tidyr.rjs.html) · [ Single
    page](slides/2-1-tidyr.onepage.html) (Heike)
2.  Making Data Messy again · [ Slides](slides/2-2-messy-it-up.rjs.html)
    · [ Single page](slides/2-2-messy-it-up.onepage.html) (Susan)
3.  Wrangling data and models · [ Slides](slides/2-3-wrangling.rjs.html)
    · [ Single page](slides/2-3-wrangling.onepage.html) (Heike)

#### Afternoon

4.  Multivariate plots using ggplot2, GGally · [
    Slides](slides/2-4-mvplot.rjs.html) · [ Single
    page](slides/2-4-mvplot.onepage.html) (Di)
5.  Touring on multivariate data · [
    Slides](slides/2-5-mvplot-tour.rjs.html) · [ Single
    page](slides/2-5-mvplot-tour.onepage.html) (Di)
6.  Advanced graphics, and statistical inference · [
    Slides](slides/2-6-adv-graphics.rjs.html) · [ Single
    page](slides/2-6-adv-graphics.onepage.html) (Susan)

### Friday

zip file · [download](SISBID_day3.zip)  
Note: this zip file assumes you will extract to the same folder as
Wednesday – data files have not been included twice.

#### Morning

1.  Advanced graphics and statistical inference · [
    Slides](slides/2-6-adv-graphics.rjs.html) · [ Single
    page](slides/2-6-adv-graphics.onepage.html) (Susan).
2.  Interactive and animated graphics using plotly and gganimate · [
    Slides](slides/3-1-interactive-plots.rjs.html) · [ Single
    page](slides/3-1-interactive-plots.onepage.html) (Heike).
3.  How to build a shiny app · [ Slides](slides/3-2-shiny-apps.rjs.html)
    · [ Single page](slides/3-2-shiny-apps.onepage.html) (Susan).

#### Afternoon

4.  Reactive elements in shiny · [
    Slides](slides/3-3-shiny-reactivity.rjs.html) · [ Single
    page](slides/3-3-shiny-reactivity.onepage.html) (Heike).
5.  Theme a shiny app · [ Slides](slides/3-4-theme-shiny.rjs.html) · [
    Single page](slides/3-4-theme-shiny.onepage.html) (Susan).
6.  Build your own Shiny app · [
    Slides](slides/3-5-build-shiny-app.rjs.html) · [ Single
    page](slides/3-5-build-shiny-app.onepage.html) (Heike).
7.  Show us what you’ve made and interactive quarto documents · [
    Slides](slides/3-6-interactive-documents.rjs.html) · [ Single
    page](slides/3-6-interactive-documents.onepage.html) (Di, Susan &
    Heike)

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
  "htmltools", "broom", "broom.mixed", "lme4", "MASS", "forecast", "nullabor")

# Install packages and their dependencies
install.packages(packages, dep=TRUE, repos = "https://cloud.r-project.org/")

# Install some packages from GitHub
remotes::install_github("wmurphyrd/fiftystater")
remotes::install_github("heike/vinference")

# For sharing web apps,
# but you need adminstrator rights to your computer:

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
remotes::install_github("r-for-educators/flair")
remotes::install_github("gadenbuie/countdown", subdir = "r")
```
