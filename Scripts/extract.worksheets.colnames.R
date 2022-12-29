# READ XLSX FILES
filename <- "conferencia_programa.xlsx"
sheets <- readxl::excel_sheets(filename)

for (i in 1:length(sheets)){
	headers <- names(data.frame(read_excel("conferencia_programa.xlsx", sheet = sheets[i])))
	cat(noquote(paste0("- ", sheets[i], "\n")))
	cat(noquote(paste0("-- ", headers, "\n")))
}