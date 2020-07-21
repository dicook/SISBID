## ---- echo = FALSE, message = FALSE, warning = FALSE, warning = FALSE----
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  error = FALSE, 
  collapse = TRUE,
  comment = "",
  fig.height = 8,
  fig.width = 12,
  fig.align = "center",
  cache = FALSE
)


## ----eval=FALSE, echo=FALSE--------------------------------------------
install.packages("remotes")
install.packages("xaringan")
remotes::install_github("hadley/emo")
remotes::install_github("ropenscilabs/icon")
remotes::install_github('emitanaka/anicon')
remotes::install_github('dicook/gretchenalbrecht')
gretchenalbrecht:::add_palette("sunset.png", "sunset")
sunset <- get_pal(30, "sunset")
viz_palette(sunset$col)
# A tibble: 30 x 5
       k    red  blue  green col    
   <int>  <dbl> <dbl>  <dbl> <chr>  
 1     1 253.   254.  254.   #FDFEFE
 2     2 161    157.  113.   #A1719D
 3     3   5.66 190.   68.9  #0645BE
 4     4 230.   217.  221    #E6DDD9
 5     5   2.64 155.   50.4  #03329B
 6     6  11.8   91.9  62.7  #0C3F5C
 7     7  74.3  134.   45.9  #4A2E86
 8     8   7    228.  116.   #0774E4
 9     9 104.   193   168.   #68A9C1
10    10 150.   197.  110.   #966EC5
11    11 112.   141.   45.6  #702E8D
12    12  96.1  217.  119.   #6077D9
13    13 190.   190.  186.   #BEBABE
14    14 107.   183.   68.4  #6B44B7
15    15 156.   111.   25.5  #9C196F
16    16  85    132.   89.3  #555984
17    17 183.    82.0  20.1  #B71452
18    18 243.    22.3  56.0  #F33816
19    19 247.    58.4 125.   #F77D3A
20    20 213.    33.1   3.32 #D50321
21    21 226.    54.2  10.9  #E20B36
22    22 250     10.2 112.   #FA700A
23    23 243    156   158    #F39E9C
24    24 129     55.7  31.7  #812038
25    25 254.     2   171.   #FEAB02
26    26 252.    44   181.   #FCB52C
27    27 250.    82.3 203.   #FACB52
28    28 131.    85   101.   #836555
29    29 183.   210   142.   #B78ED2
30    30   3.59 121.   92.7  #045D79


## ----eval=FALSE--------------------------------------------------------
install.packages("ggenealogy")


## ----eval=FALSE--------------------------------------------------------
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("impute")


## ----eval=FALSE--------------------------------------------------------
remotes::install_github("hadley/emo")

