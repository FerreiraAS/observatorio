# list all directories to extract PPG data
files.to.read <-
  list.files(
    file.path(getwd(), "PPG"),
    full.names = TRUE,
    pattern = "xlsx",
    recursive = FALSE
  )
