get_webqualis <-
  function(qualis,
           scimago,
           doi_with_altmetric = NULL,
           doi_without_altmetric = NULL) {
    # initialize values
    WebQualis_value <- NA
    
    # get WebQualis for "doi_with_altmetric" data
    if (!is.null(doi_with_altmetric)) {
      # try first ISSN
      WebQualis_value <-
        qualis[match(doi_with_altmetric$issn, qualis$ISSN), 3]
      if (is.na(WebQualis_value)) {
        # try journal name
        WebQualis_value <-
          qualis[match(tolower(gsub("&", "and", doi_with_altmetric$journal)),
                       tolower(qualis$Título)), 3]
      }
      if (is.na(WebQualis_value)) {
        # try other ISSN
        new.issn <-
          trimws(gsub(",", "", gsub(doi_with_altmetric$issn, "", scimago$Issn[grep(gsub("-", "", doi_with_altmetric$issn), scimago$Issn)])))
        issn.2 <- gsub('^(.{4})(.*)$', '\\1-\\2', new.issn)
        WebQualis_value <- qualis[match(new.issn, qualis$ISSN), 3]
      }
    }
    # get WebQualis for "doi_without_altmetric" data
    if (!is.null(doi_without_altmetric)) {
      if (is.na(doi_without_altmetric$issn)) {
        WebQualis_value <- NA
      }
      else {
        # try first and second ISSN
        issn.1 <- strsplit(doi_without_altmetric$issn, ",")[[1]][1]
        issn.2 <- strsplit(doi_without_altmetric$issn, ",")[[1]][2]
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
          qualis[match(tolower(doi_without_altmetric$journal),
                       tolower(qualis$Título)), 3]
      }
    }
    return(
      list(
        WebQualis_value = as.character(ifelse(sjmisc::is_empty(WebQualis_value), NA, WebQualis_value))
        )
      )
  }
