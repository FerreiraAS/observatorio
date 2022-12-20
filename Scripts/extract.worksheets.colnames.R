# LAST MODIFIED: MAR 02, 2022

# RESTART ALL VARIABLES
rm(list = ls(all = TRUE))

# HIDE ALL WARNINGS
options(warn = -1)

# INSTALL AND LOAD LIBRARIES
require(readxl)
library(readxl)

# READ XLSX FILES
filename <- "conferencia_programa.xlsx"
sheets <- readxl::excel_sheets(filename)

for (i in 1:length(sheets)){
	headers <- names(data.frame(read_excel("conferencia_programa.xlsx", sheet = sheets[i])))
	cat(noquote(paste0("- ", sheets[i], "\n")))
	cat(noquote(paste0("-- ", headers, "\n")))
}
