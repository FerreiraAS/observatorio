get_metrics <- function(df, citescore, scimago, qualis) {
  # get metrics
  df %>%
    data.frame(
      "CiteScore" = rep(NA, dim(df)[1]),
      "SJR" = rep(NA, dim(df)[1]),
      "WebQualis" = rep(NA, dim(df)[1])
    )
  if(!"altmetric_score" %in% colnames(df)) {
    df %>%
      data.frame("altmetric_score" = rep(NA, dim(df)[1]))
  }
  
  for (ix in 1:dim(df)[1]) {
    # get CiteScore
    try(df$CiteScore[ix] <-
          get_citescore(citescore = citescore,
                        doi_unique = df[ix,])$citescore_value,
        silent = TRUE)
    # get SJR
    try(df$SJR[ix] <-
          get_sjr(scimago = scimago,
                    doi_unique = df[ix,])$SJR_value,
    silent = TRUE)
    # get WebQualis
    try(df$WebQualis[ix] <-
          get_webqualis(qualis = qualis,
                        scimago = scimago,
                        doi_unique = df[ix,])$WebQualis_value,
        silent = TRUE)
  }
  return(df = df)
}