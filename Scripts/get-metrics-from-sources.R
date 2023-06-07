get_metrics <-
  function(doi_with_altmetric = NULL,
           doi_without_altmetric = NULL,
           citescore,
           scimago,
           qualis) {
    # check input
    if (!is.null(doi_with_altmetric)) {
      df <- doi_with_altmetric
    }
    if (!is.null(doi_without_altmetric)) {
      df <- doi_without_altmetric
    }
    df %>%
      data.frame(
        "CiteScore" = rep(NA, dim(df)[1]),
        "SJR" = rep(NA, dim(df)[1]),
        "WebQualis" = rep(NA, dim(df)[1])
      )
    if (!"altmetric_score" %in% colnames(df)) {
      df %>%
        data.frame("altmetric_score" = rep(NA, dim(df)[1]))
    }
    # get metrics
    for (ix in 1:dim(df)[1]) {
      # get CiteScore
      try(df$CiteScore[ix] <-
            get_citescore(citescore = citescore,
                          doi_with_altmetric = df[ix, ])$citescore_value,
          silent = TRUE)
      try(df$CiteScore[ix] <-
            get_citescore(citescore = citescore,
                          doi_without_altmetric = df[ix, ])$citescore_value,
          silent = TRUE)
      # get SJR
      try(df$SJR[ix] <-
            get_sjr(scimago = scimago,
                    doi_with_altmetric = df[ix, ])$SJR_value,
          silent = TRUE)
      try(df$SJR[ix] <-
            get_sjr(scimago = scimago,
                    doi_without_altmetric = df[ix, ])$SJR_value,
          silent = TRUE)
      # get WebQualis
      try(df$WebQualis[ix] <-
            get_webqualis(
              qualis = qualis,
              scimago = scimago,
              doi_with_altmetric = df[ix, ]
            )$WebQualis_value,
          silent = TRUE)
      try(df$WebQualis[ix] <-
            get_webqualis(
              qualis = qualis,
              scimago = scimago,
              doi_without_altmetric = df[ix, ]
            )$WebQualis_value,
          silent = TRUE)
    }
    return(df = df)
  }