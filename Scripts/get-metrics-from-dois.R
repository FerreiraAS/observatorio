# Verifica se há DOIs
if (sjmisc::is_empty(dois)) {
  doi_unique <- as.data.frame(matrix(nrow = 0, ncol = 0))
  my_doi_works <- as.data.frame(matrix(nrow = 0, ncol = 0))
} else {
  dois_list <- as.list(dois$DOI)
  
  # roda o script para obter dados do Altmetric
  source("Scripts/altmetric-from-dois.R", local = knitr::knit_global())
  doi_unique <- doi_reshaped_data
  
  # add citation counts
  doi_unique$citations <- rep(0, dim(doi_unique)[1])
  for (i in 1:dim(doi_unique)[1]) {
    try({
      citations <-
        rcrossref::cr_citation_count(doi = as.character(doi_unique$doi[i]), key = "cienciasdareabilitacao@souunisuam.com.br")
      doi_unique$citations[i] <- citations$count
    },
    silent = TRUE)
    # search for alternative source of journal name
    try(if (sjmisc::is_empty(doi_unique$journal[i])) {
      doi_unique$journal[i] <-
        scimago[grep(gsub("-", "", doi_unique$issn), scimago$Issn), 3][1]
    }, silent = TRUE)
  }
  
  # get data of papers without Altmetric from CrossRef
  if (sjmisc::is_empty(no_altmetric_dois_list)) {
    my_doi_works <- data.frame(matrix(nrow = 0, ncol = 0))
  } else {
    my_doi_works <-
      rcrossref::cr_works(dois = no_altmetric_dois_list) %>%
      purrr::pluck("data")
    
    if (length(my_doi_works) != 0) {
      # rename column
      try(data.table::setnames(my_doi_works, 'container.title', 'journal'),
          silent = TRUE)
      
      # paste authors' name
      authors <- dplyr::select(my_doi_works, author)
      my_doi_works$author.names <- rep("", dim(authors)[1])
      for (ix in 1:dim(authors)[1]) {
        names <- ""
        try(names <-
              stringr::str_sub(paste0(
                rbind(authors[[1]][[ix]]$given, " ", authors[[1]][[ix]]$family, ", "),
                collapse = ""
              ),
              start = 1,
              end = -3),
            silent = TRUE)
        my_doi_works$author.names[ix] <- names
      }
      
      # remove columns with list data
      drops <-
        c(
          "author",
          "link",
          "reference",
          "alternative.id",
          "license",
          "assertion",
          "funder"
        )
      my_doi_works <-
        my_doi_works[, !(names(my_doi_works) %in% drops)]
    }
    
    for (ix in 1:dim(my_doi_works)[1]) {
      # sort columns by title
      my_doi_works <-
        my_doi_works[order(as.vector(my_doi_works$title)), ]
      # replace is_oa from Crossref
      for (i in 1:length(my_doi_works$doi)) {
        my_doi_oa <-
          roadoi::oadoi_fetch(dois = my_doi_works$doi[i], email = "cienciasdareabilitacao@souunisuam.com.br")
        my_doi_works$is_oa[i] <-
          ifelse(length(my_doi_oa$is_oa) != 0,
                 toupper(as.character(my_doi_oa$is_oa)),
                 "FALSE")
      }
      # add citation counts
      my_doi_works$citations <- rep(0, dim(my_doi_works)[1])
      for (i in 1:dim(my_doi_works)[1]) {
        try ({
          citations <-
            rcrossref::cr_citation_count(doi = as.character(my_doi_works$doi[i]),
                                         key = "cienciasdareabilitacao@souunisuam.com.br")
          my_doi_works$citations[i] <- citations$count
        },
        silent = TRUE)
      }
      # add issued (created) year of publication
      tryCatch(
        expr = {
          # get year from issued
          my_doi_works$published_on <-
            stringr::str_sub(as.character(my_doi_works$issued), 1, 4)
          # get year from created if not issued
          my_doi_works$published_on[is.na(my_doi_works$published_on)] <-
            stringr::str_sub(as.character(my_doi_works$created[is.na(my_doi_works$published_on)]), 1, 4)
        },
        error = function(e) {
          
        }
      )
    }
  }
  # paper
  beepr::beep("coin")
}
