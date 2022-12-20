# list all available years
anos <-
  as.numeric(list.dirs(
    file.path(getwd(), "Sucupira"),
    full.names = FALSE,
    recursive = FALSE
  ))