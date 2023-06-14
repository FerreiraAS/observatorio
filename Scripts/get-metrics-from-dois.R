# Verifica se há DOIs
if (sjmisc::is_empty(dois)) {
  doi_with_altmetric <- as.data.frame(matrix(nrow = 0, ncol = 0))
  doi_without_altmetric <- as.data.frame(matrix(nrow = 0, ncol = 0))
} else {
  dois_df <- dois
  # roda o script para obter dados do Altmetric
  source("Scripts/altmetric-from-dois.R", local = knitr::knit_global())
  # doi_with_altmetric output
  # doi_without_altmetric output
}

# get data of papers without Altmetric from CrossRef
if (sjmisc::is_empty(doi_without_altmetric)) {
  doi_without_altmetric <- data.frame(matrix(nrow = 0, ncol = 0))
  doi_without_altmetric$citations <- rep(0, dim(doi_without_altmetric)[1])
} else {
  if (dim(doi_without_altmetric)[1] != 0) {
    doi_without_altmetric <-
      rcrossref::cr_works(dois = doi_without_altmetric$DOI) %>%
      purrr::pluck("data")
    # rename column
    try(data.table::setnames(doi_without_altmetric, 'container.title', 'journal'),
        silent = TRUE)
    
    # paste authors' name
    authors <- dplyr::select(doi_without_altmetric, author)
    doi_without_altmetric$author.names <- rep("", dim(authors)[1])
    # deal with authors' name first to drop the list column data
    for (ix in 1:dim(doi_without_altmetric)[1]) {
      names <- ""
      try(names <-
            stringr::str_sub(paste0(
              rbind(authors[[1]][[ix]]$given, " ", authors[[1]][[ix]]$family, ", "),
              collapse = ""),
            start = 1,
            end = -3),
          silent = TRUE)
      doi_without_altmetric$author.names[ix] <- names
    }
    
    # remove columns with list data
    drops <-
      c(
        "author",
        "abstract",
        "link",
        "reference",
        "alternative.id",
        "license",
        "assertion",
        "funder"
      )
    doi_without_altmetric <-
      doi_without_altmetric[, !(names(doi_without_altmetric) %in% drops)]
    
    # add issued (created) year of publication
    tryCatch(
      expr = {
        # get year from issued
        doi_without_altmetric$published_on <-
          stringr::str_sub(as.character(doi_without_altmetric$issued), 1, 4)
        # get year from created if not issued
        doi_without_altmetric$published_on[is.na(doi_without_altmetric$published_on)] <-
          stringr::str_sub(as.character(doi_without_altmetric$created[is.na(doi_without_altmetric$published_on)]), 1, 4)
      },
      error = function(e) {
        
      }
    )
    
    # store data
    doi_without_altmetric$citations <-
      rep(0, dim(doi_without_altmetric)[1])
    
    for (ix in 1:dim(doi_without_altmetric)[1]) {
      # replace is_oa from Crossref
      my_doi_oa <-
        roadoi::oadoi_fetch(dois = doi_without_altmetric$doi[ix], email = "cienciasdareabilitacao@souunisuam.com.br")
      doi_without_altmetric$is_oa[ix] <-
        ifelse(length(my_doi_oa$is_oa) != 0,
               toupper(as.character(my_doi_oa$is_oa)),
               "FALSE")
      # add citation counts
      try ({
        citations <-
          rcrossref::cr_citation_count(doi = as.character(doi_without_altmetric$doi[ix]),
                                       key = "cienciasdareabilitacao@souunisuam.com.br")
        doi_without_altmetric$citations[ix] <- citations$count
      },
      silent = TRUE)
      # sort columns by title
      doi_without_altmetric <-
        doi_without_altmetric[order(doi_without_altmetric$title),]
      
      beepr::beep("ping")
    }
  }
}
