library(dplyr)

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
sucupira <- c()
sucupira.raw <- c()
sucupira.list <- list()
if (length(files.to.read) != 0) {
  for (file in 1:length(files.to.read)) {
    sucupira <-
      as.data.frame(readxl::read_excel(
        files.to.read[file],
        sheet = sheet,
        col_types = c("text")
      )) %>%
      dplyr::mutate(dplyr::across(tidyselect::everything(), as.character))
    
    # search for "|" (meaning there are changes within a given year)
    has.any.change <-
      which(`dim<-`(grepl(' \\| ', as.matrix(sucupira)), dim(sucupira)), arr.ind =
              TRUE)
    
    if (length(has.any.change) != 0) {
      warning(
        paste0(
          "Resolving duplicated entryes marked with ' | ' in Sucupira data of ",
          files.to.read[file]
        )
      )
      rows.to.change <- c()
      cols.to.change <- c()
      data.to.change <- c()
      for (i in 1:dim(sucupira)[1]) {
        for (j in 1:dim(sucupira)[2]) {
          # duplicate entries based on "|"
          change <- grep(' \\| ', as.character(sucupira[i, j]))
          if (length(change) != 0) {
            rows.to.change <- c(rows.to.change, i)
            cols.to.change <- c(cols.to.change, j)
            data.to.change <- rbind(data.to.change, sucupira[i, ])
          }
        }
      }
      
      # replace values
      index <- 1
      split.data <- c()
      for (i in unique(rows.to.change)) {
        for (j in cols.to.change[rows.to.change == i]) {
          split.data <-
            unlist(strsplit(as.character(sucupira[i, j]), " \\| "))
          data.to.change[(index:(index + length(split.data) - 1)), j] <-
            split.data
        }
        index <- index + length(split.data)
      }
      
      # delete original entries with "|"
      sucupira <- sucupira[-unique(rows.to.change),]
      sucupira  %>%
        dplyr::mutate_all(as.character())
      
      # append changed data
      colnames(data.to.change) <- colnames(sucupira)
      data.to.change %>%
        dplyr::mutate_all(as.character())
      sucupira <- dplyr::bind_rows(sucupira, data.to.change)
    }
    
    sucupira.list[[file]] <- sucupira
    
    sucupira.raw <-
      dplyr::bind_rows(sucupira.raw, sucupira)
    readr::type_convert(sucupira.raw)
    
  }
}
