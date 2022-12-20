# list all directories to extract Sucupira (yearly) data
dirs <-
  list.dirs(file.path(getwd(), "Sucupira"),
            full.names = FALSE,
            recursive = FALSE)

# load list of Sucupira files to read
files.to.read <- c()
for (i in 1:length(dirs)) {
  files.to.read <- c(
    files.to.read,
    list.files(
      file.path(getwd(), "Sucupira", dirs[i]),
      pattern = "xlsx",
      full.names = TRUE,
      recursive = FALSE
    )
  )
}

# initialize vectors and lists
sucupira.sheets <- c()

for (file in 1:length(files.to.read)) {
  abas <- excel_sheets(files.to.read[file])
  sucupira.sheets <- c(sucupira.sheets, abas)
}
sucupira.sheets <- unique(sucupira.sheets)
