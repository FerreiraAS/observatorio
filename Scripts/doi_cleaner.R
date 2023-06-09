doi_cleaner <- function(dois) {
  if (!sjmisc::is_empty(dois)) {
    # duplicate data
    clean_doi <- dois
    for (j in 1:dim(clean_doi)[1]) {
      # remove square brackets from start-end
      if (length(grep("\\[|\\]", "", clean_doi$DOI[j])) == 0) {
        clean_doi$DOI[j] <- gsub("\\[|\\]", "", clean_doi$DOI[j])
      }
      # remove 'doi:' prefix
      if (length(grep("doi:", "", clean_doi$DOI[j])) == 0) {
        clean_doi$DOI[j] <- gsub("doi:", "", clean_doi$DOI[j])
      }
      # remove 'http://dx.doi.org/' prefix
      if (length(grep("http://dx.doi.org/", "", clean_doi$DOI[j])) == 0) {
        clean_doi$DOI[j] <-
          gsub("http://dx.doi.org/", "", clean_doi$DOI[j])
      }
      # remove 'https://doi.org/' prefix
      if (length(grep("https://doi.org/", "", clean_doi$DOI[j])) == 0) {
        clean_doi$DOI[j] <-
          gsub("https://doi.org/", "", clean_doi$DOI[j])
      }
    }
  }
  return(clean_doi)
}
