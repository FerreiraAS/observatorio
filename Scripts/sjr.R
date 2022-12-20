# load list of SJR files to read
files.to.read <- list.files(
  file.path(getwd(), "Metrics", "SJR"),
  pattern = "csv",
  full.names = TRUE,
  recursive = FALSE
)

# read SCImago csv file (download from https://www.scimagojr.com)
scimago <-
  read.csv(
    files.to.read,
    header = TRUE,
    sep = ";",
    quote = "\"",
    dec = ",",
    fill = TRUE
  )