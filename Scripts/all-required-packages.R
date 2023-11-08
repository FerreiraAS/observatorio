# all packages required for this R project
# Create using PACKUP add-in to generate this code with all the required libraries for this Rmd
# 1. create code chunk
# 2. library(packup)
# 3. packup()

# set default directory
options(repos = structure(c(CRAN = "http://cran.r-project.org")))

# set timeout to download packages, in seconds
options(timeout = 360)

# most packages work fine if installed from CRAN
packs.cran <-
  c(
    "alluvial",
    "anytime",
    "BBmisc",
    "beepr",
    "bsplus",
    "cowplot",
    "chromote",
    "curl",
    "data.tree",
    "details",
    "devtools",
    "do",
    # plyr first, then dplyr
    "plyr",
    "dplyr",
    "DT",
    "fontawesome",
    "ggplot2",
    "ggpubr",
    "ggraph",
    "grid",
    "gridExtra",
    "gtsummary",
    "hrbrthemes",
    "htmlwidgets",
    "httpuv",
    "httr",
    "igraph",
    "janitor",
    "kableExtra",
    "knitr",
    "lemon",
    "lubridate",
    "magrittr",
    "networkD3",
    "pacman",
    "parallelly",
    "png",
    "raster",
    "RColorBrewer",
    "readtext",
    "readr",
    "readxl",
    "remote",
    "remotes",
    "rmarkdown",
    "Rmisc",
    "roadoi",
    "rorcid",
    "sessioninfo",
    "sf",
    "stringr",
    "tau",
    "terra",
    "tidyverse",
    "tm",
    "tools",
    "usethis",
    "vioplot",
    "webshot2",
    "wordcloud2"
  )

for (i in 1:length(packs.cran)) {
  if (!require(packs.cran[i], character.only = TRUE, quietly = TRUE))
    install.packages(packs.cran[i], character.only = TRUE, )
}

# other packages work better if installed from github
packs.git <-
  c("cssparser",
    "geobr",
    "packup",
    "rcrossref",
    "retractcheck",
    "sf",
    "textreadr")

if (!require("cssparser", character.only = TRUE, quietly = TRUE))
  remotes::install_github('coolbutuseless/cssparser')

if (!require("geobr", character.only = TRUE, quietly = TRUE))
  devtools::install_github("ipeaGIT/geobr", subdir = "r-package")

if (!require("packup", character.only = TRUE, quietly = TRUE))
  devtools::install_github("milesmcbain/packup")

if (!require("rcrossref", character.only = TRUE, quietly = TRUE))
  devtools::install_github("ropensci/rcrossref")

if (!require("retractcheck",
             character.only = TRUE,
             quietly = TRUE))
  remotes::install_github("libscie/retractcheck")

if (!require("sf", character.only = TRUE, quietly = TRUE))
  remotes::install_github("r-spatial/sf")

if (!require("pacman"))
  install.packages("pacman")
pacman::p_load_gh("trinker/textreadr")

# load all libraries
packs <- c(packs.cran, packs.git)

for (i in 1:length(packs)) {
  library(packs[i], character.only = TRUE)
}
