get_sjr <-
  function(scimago,
           doi_with_altmetric = NULL,
           doi_without_altmetric = NULL) {
    # initialize values
    SJR_id <- NA
    SJR_value <- NA
    # get SJR for "doi_with_altmetric" data
    if (!is.null(doi_with_altmetric) & !sjmisc::is_empty(doi_with_altmetric$issn)) {
      SJR_id <-
        scimago[grep(gsub("-", "", doi_with_altmetric$issn), scimago$Issn), 2][1]
      SJR_value <-
        scimago[grep(gsub("-", "", doi_with_altmetric$issn), scimago$Issn), 6][1]
    }
    # get SJR for "doi_without_altmetric" data
    if (!is.null(doi_without_altmetric) & !sjmisc::is_empty(doi_without_altmetric$issn)) {
      SJR_id <-
        scimago[grep(gsub("-", "", substr(doi_without_altmetric$issn, 1, 9)), scimago$Issn), 2][1]
      SJR_value <-
        scimago[grep(gsub("-", "", substr(doi_without_altmetric$issn, 1, 9)), scimago$Issn), 6][1]
    }
    return(list(
      SJR_id = ifelse(sjmisc::is_empty(SJR_id), NA, SJR_id),
      SJR_value = ifelse(sjmisc::is_empty(SJR_value), NA, SJR_value)
    ))
  }
