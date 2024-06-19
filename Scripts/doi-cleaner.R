doi_cleaner <- function(dois) {
  # duplicate data
  clean_doi <- dois
  if (!sjmisc::is_empty(dois)) {
    for (j in 1:dim(clean_doi)[1]) {
      # remove square brackets from start-end
      if (length(grep("\\[|\\]", clean_doi$DOI[j])) != 0) {
        clean_doi$DOI[j] <- gsub("\\[|\\]", "", clean_doi$DOI[j])
      }
      # remove 'doi:' prefix
      if (length(grep("doi:", clean_doi$DOI[j])) != 0) {
        clean_doi$DOI[j] <- gsub("doi:", "", clean_doi$DOI[j])
      }
      if (length(grep("DOI:", clean_doi$DOI[j])) != 0) {
        clean_doi$DOI[j] <- gsub("DOI:", "", clean_doi$DOI[j])
      }
      # remove 'http://dx.doi.org/' prefix
      if (length(grep("http://dx.doi.org/", clean_doi$DOI[j])) != 0) {
        clean_doi$DOI[j] <-
          gsub("http://dx.doi.org/", "", clean_doi$DOI[j])
      }
      # remove 'https://doi.org/' prefix
      if (length(grep("https://doi.org/", clean_doi$DOI[j])) != 0) {
        clean_doi$DOI[j] <-
          gsub("https://doi.org/", "", clean_doi$DOI[j])
      }
      # remove websites
      if (length(grep("http://", clean_doi$DOI[j])) != 0) {
        clean_doi$DOI[j] <- NA
      }
      # remove websites
      if (length(grep("https://", clean_doi$DOI[j])) != 0) {
        clean_doi$DOI[j] <- NA
      }
      # remove elements starting with www.
      if (length(grep("^www.", clean_doi$DOI[j])) != 0) {
        clean_doi$DOI[j] <- NA
      }
      # trim spaces
      clean_doi$DOI[j] <- trimws(clean_doi$DOI[j])
    }
  }
  return(clean_doi)
}
