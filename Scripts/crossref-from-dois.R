# Getting CrossRef Data Using R
# by Arthur de Sá Ferreira

# select data to grab from Altmetric API
columns_to_grab <-
  c("is_oa", "citations")

# initialize dataframe
doi_with_metrics <-
  data.frame(matrix(
    vector(),
    nrow = 1,
    ncol = length(columns_to_grab),
    dimnames = list(c(), columns_to_grab)
  ))

# loop for all DOI in the list
for (input in 1:dim(dois)[1]) {
  tryCatch(
    expr = {
      # replace is_oa from Crossref
      my_doi_oa <-
        roadoi::oadoi_fetch(dois = as.character(dois$DOI[input]), email = "cienciasdareabilitacao@souunisuam.com.br")
      doi_with_metrics$is_oa[input] <- ifelse(length(my_doi_oa) != 0, toupper(as.character(my_doi_oa$is_oa)), "FALSE")
    },
    error = function(e) {
      if (!is.na(match(url, showConnections(all = TRUE)[, 1]) - 1)) {
        close(getConnection(match(url, showConnections(all = TRUE)[, 1]) - 1))
      }
      doi_with_error <- c(doi_with_error, dois$DOI[input])
    },
    finally = {
    }
  )
}

# loop for all DOI in the list
for (input in 1:dim(dois)[1]) {
  tryCatch(
    expr = {
      # add citation counts from Crossref
      my_doi_citations <-
        rcrossref::cr_citation_count(doi = as.character(dois$DOI[input]), key = "cienciasdareabilitacao@souunisuam.com.br")
      doi_with_metrics$citations[input] <- my_doi_citations$count
    },
    error = function(e) {
      if (!is.na(match(url, showConnections(all = TRUE)[, 1]) - 1)) {
        close(getConnection(match(url, showConnections(all = TRUE)[, 1]) - 1))
      }
      doi_with_error <- c(doi_with_error, dois$DOI[input])
    },
    finally = {
    }
  )
}
