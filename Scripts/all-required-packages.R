# all packages required for this R project
# Create using PACKUP add-in to generate this code with all the required libraries for this Rmd
# 1. create code chunk
# 2. library(packup)
# 3. packup()

# most packages work fine if installed from CRAN
packs.cran <-
  c(
    "alluvial",
    "anytime",
    "BBmisc",
    "bsplus",
    "cowplot",
    "data.tree",
    "details",
    "devtools",
    # plyr first, then dplyr
    "plyr",
    "dplyr",
    "DT",
    "fontawesome",
    "ggraph",
    "ggplot2",
    "ggpubr",
    "grid",
    "gridExtra",
    "gtsummary",
    "hrbrthemes",
    "htmlwidgets",
    "httpuv",
    "igraph",
    "janitor",
    "kableExtra",
    "knitr",
    "lemon",
    "lubridate",
    "magrittr",
    "networkD3",
    "parallelly",
    "RColorBrewer",
    "readtext",
    "readxl",
    "readr",
    "remote",
    "rmarkdown",
    "Rmisc",
    "roadoi",
    "rorcid",
    "sessioninfo",
    "sf",
    "stringr",
    "tau",
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
    install.packages(packs.cran[i], character.only = TRUE)
}

# other packages work better if installed from github
packs.git <-
  c("cssparser",
    "geobr",
    "packup",
    "rcrossref")

if (!require("cssparser", character.only = TRUE, quietly = TRUE))
  remotes::install_github('coolbutuseless/cssparser')

if (!require("geobr", character.only = TRUE, quietly = TRUE))
  devtools::install_github("ipeaGIT/geobr", subdir = "r-package")

if (!require("packup", character.only = TRUE, quietly = TRUE))
  devtools::install_github("milesmcbain/packup")

if (!require("rcrossref", character.only = TRUE, quietly = TRUE))
  devtools::install_github("ropensci/rcrossref")

# load all libraries
packs <- c(packs.cran, packs.git)

for (i in 1:length(packs)) {
  library(packs[i], character.only = TRUE)
}