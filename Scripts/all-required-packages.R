# all packages required for this R project
# Create using PACKUP add-in to generate this code with all the required libraries for this Rmd
# 1. create code chunk
# 2. library(packup)
# 3. packup()

# set default directory
options(repos = list(CRAN = "http://cran.rstudio.com/"))

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
    "evaluate",
    # plyr first, then dplyr
    "plyr",
    "dplyr",
    "DT",
    "fontawesome",
    "geobr",
    "glue",
    "ggplot2",
    "ggpubr",
    "ggraph",
    "ggtext",
    "ggwordcloud",
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
    "Rcpp",
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
    "sjmisc",
    "spatstat.linnet",
    "stringr",
    "svDialogs",
    "tau",
    "terra",
    "tidyverse",
    "tinytable",
    "tinytex",
    "tm",
    "tools",
    "units",
    "usethis",
    "vioplot",
    "webshot2",
    "yaml"
  )

# other packages work better if installed from github
packs.git <-
  c(
    "cssparser",
    "geobr",
    "packup",
    "rcrossref",
    "retractcheck",
    "rscopus",
    "sf",
    "pacman",
    "textreadr"
  )

# check if there is internet connection
if (curl::has_internet()) {
  for (i in 1:length(packs.cran)) {
    if (!require(packs.cran[i],
                 character.only = TRUE,
                 quietly = TRUE)) {
      install.packages(packs.cran[i],
                       character.only = TRUE,
                       dependencies = TRUE)
    }
  }
  
  if (!require("cssparser", character.only = TRUE, quietly = TRUE)) {
    remotes::install_github('coolbutuseless/cssparser')
  }
  
  if (!require("geobr", character.only = TRUE, quietly = TRUE)) {
    devtools::install_github("ipeaGIT/geobr", subdir = "r-package")
  }
  
  if (!require("packup", character.only = TRUE, quietly = TRUE)) {
    devtools::install_github("milesmcbain/packup")
  }
  
  if (!require("rcrossref", character.only = TRUE, quietly = TRUE)) {
    devtools::install_github("ropensci/rcrossref")
  }
  
  if (!require("retractcheck",
               character.only = TRUE,
               quietly = TRUE)) {
    remotes::install_github("libscie/retractcheck")
  }
  
  if (!require("rscopus", character.only = TRUE, quietly = TRUE)) {
    devtools::install_github("muschellij2/rscopus")
  }
  
  if (!require("sf", character.only = TRUE, quietly = TRUE)) {
    remotes::install_github("r-spatial/sf")
  }
  
  if (!require("pacman")) {
    install.packages("pacman")
    pacman::p_load_gh("trinker/textreadr")
  }
  
  
  # update TeX packages
  tinytex::tlmgr_update()
  
  # install missing TeX packages
  try(tinytex::parse_install("./autoavaliacao.log"), silent = TRUE)
  try(tinytex::parse_packages("./autoavaliacao.log"), silent = TRUE)
  
  # update all packages
  update.packages(checkBuilt = TRUE, ask = FALSE)
}

# load all libraries
packs <- unique(c(packs.cran, packs.git))

for (i in 1:length(packs)) {
  library(packs[i], character.only = TRUE)
}
