get_sjr <-
  function(scimago,
           doi_unique = NULL,
           my_doi_works = NULL) {
    # initialize values
    SJR_id <- NA
    SJR_value <- NA
    # get SJR for "doi_unique" data
    if (!is.null(doi_unique) & !sjmisc::is_empty(doi_unique$issn)) {
      SJR_id <-
        scimago[grep(gsub("-", "", doi_unique$issn), scimago$Issn), 2][1]
      SJR_value <-
        scimago[grep(gsub("-", "", doi_unique$issn), scimago$Issn), 6][1]
    }
    # get SJR for "my_doi_works" data
    if (!is.null(my_doi_works) & !sjmisc::is_empty(my_doi_works$issn)) {
      SJR_id <-
        scimago[grep(gsub("-", "", substr(my_doi_works$issn, 1, 9)), scimago$Issn), 2][1]
      SJR_value <-
        scimago[grep(gsub("-", "", substr(my_doi_works$issn, 1, 9)), scimago$Issn), 6][1]
    }
    return(list(
      SJR_id = ifelse(sjmisc::is_empty(SJR_id), NA, SJR_id),
      SJR_value = ifelse(sjmisc::is_empty(SJR_value), NA, SJR_value)
    ))
  }