get_webqualis <-
  function(qualis,
           scimago,
           doi_unique = NULL,
           my_doi_works = NULL) {
    # initialize values
    WebQualis_value <- NA
    
    # get WebQualis for "doi_unique" data
    if (!is.null(doi_unique)) {
      # try first ISSN
      WebQualis_value <-
        qualis[match(doi_unique$issn, qualis$ISSN), 3]
      if (is.na(WebQualis_value)) {
        # try journal name
        WebQualis_value <-
          qualis[match(tolower(gsub("&", "and", doi_unique$journal)),
                       tolower(qualis$Título)), 3]
      }
      if (is.na(WebQualis_value)) {
        # try other ISSN
        new.issn <-
          trimws(gsub(",", "", gsub(doi_unique$issn, "", scimago$Issn[grep(gsub("-", "", doi_unique$issn), scimago$Issn)])))
        issn.2 <- gsub('^(.{4})(.*)$', '\\1-\\2', new.issn)
        WebQualis_value <- qualis[match(new.issn, qualis$ISSN), 3]
      }
    }
    # get WebQualis for "my_doi_works" data
    if (!is.null(my_doi_works)) {
      if (is.na(my_doi_works$issn)) {
        WebQualis_value <- NA
      }
      else {
        # try first and second ISSN
        issn.1 <- strsplit(my_doi_works$issn, ",")[[1]][1]
        issn.2 <- strsplit(my_doi_works$issn, ",")[[1]][2]
        WebQualis.1 <-
          qualis$Estrato[match(issn.1, qualis$ISSN)]
        WebQualis.2 <-
          qualis$Estrato[match(issn.2, qualis$ISSN)]
        WebQualis_value <-
          unique(na.omit(c(WebQualis.1, WebQualis.2)))[1]
        if (is_empty(WebQualis_value)) {
          WebQualis_value <- NA
        }
      }
      if (is.na(WebQualis_value)) {
        # try journal name
        WebQualis_value <-
          qualis[match(tolower(my_doi_works$journal),
                       tolower(qualis$Título)), 3]
      }
    }
    return(
      list(
        WebQualis_value = as.character(ifelse(sjmisc::is_empty(WebQualis_value), NA, WebQualis_value))
        )
      )
  }
