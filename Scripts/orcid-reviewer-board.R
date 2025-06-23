# test
# my_orcid <- "0000-0001-7014-2002"

peer.review <- c()

# get peer review data
res <- rorcid::orcid_peer_reviews(my_orcid)

if (is.null(res[[1]]$group$`external-ids.external-id`)) {
  # do nothing
} else {
  dt_list <- purrr::map(res, data.table::as.data.table)
  dt <- data.table::rbindlist(dt_list, fill = TRUE, idcol = T)
  
  # list of ISSN
  issn <- sapply(strsplit(sapply(res[[1]]$group$`external-ids.external-id`, `[[`, 2), ":"), `[[`, 2)
  
  # start year
  start.yr <- c()
  for(k in 1:dim(dt)[1]) {
    year <- data.table::rbindlist((dt[[3]][[k]])[[1]], fill = TRUE)
    year <- min(year$`completion-date.year.value`, na.rm = TRUE)
    start.yr <- c(start.yr, year)
  }
  
  # most recent year
  end.yr <- c()
  for(k in 1:dim(dt)[1]) {
    year <- data.table::rbindlist((dt[[3]][[k]])[[1]], fill = TRUE)
    year <- max(year$`completion-date.year.value`, na.rm = TRUE)
    if(is.na(year)){year <- "Atual"}
    if(year == ""){year <- "Atual"}
    end.yr <- c(end.yr, year)
  }
  
  # pareceres
  pareceres.all <- c()
  for(k in 1:dim(dt)[1]) {
    pareceres <- data.table::rbindlist((dt[[3]][[k]])[[1]], fill = TRUE)
    pareceres <- dim(pareceres)[1]
    pareceres.all <- c(pareceres.all, pareceres)
  }
  
  # get country
  paises.all <- c()
  for(k in 1:dim(dt)[1]) {
    paises <- data.table::rbindlist((dt[[3]][[k]])[[1]], fill = TRUE)
    paises <- paste0(unique(paises$`convening-organization.address.country`), collapse = ", ")
    paises.all <- c(paises.all, paises)
  }
  
  # list journals
  journals <- rorcid::issn_title[issn]
  
  # get SJR and CiteScore from database
  SJR <- c()
  CiteScore <- c()
  for (i in 1:length(issn)) {
    # get ISSN values
    df_scopus <- data.frame(issn = issn[i], check.names = FALSE)
    # remove - from ISSN
    df_scopus$issn <- gsub("-", "", df_scopus$issn)
    # get metrics
    source("Scripts/scopus-from-issn.R", local = knitr::knit_global())
    SJR <- c(SJR, ifelse(length(doi_with_metrics$SJR) != 0, doi_with_metrics$SJR, ""))
    CiteScore <- c(CiteScore, ifelse(length(doi_with_metrics$CiteScore) != 0, doi_with_metrics$CiteScore, ""))
    # wait to respect API rate limit (polite request)
    Sys.sleep(1)
    # beep to alert
    beepr::beep("coin")
  }
  
  # bind and rank by SJR
  peer.review <-
    data.frame(
      "Ano (início)" = start.yr,
      "Ano (fim)" = end.yr,
      "Docente" = rep(docente.name, length(journals)),
      "Periódico" = matrix(unname(journals), ncol = 1),
      "SJR" = format(round(matrix(as.numeric(SJR), ncol = 1), digits = 3), nsmall = 3),
      "CiteScore" = format(round(matrix(as.numeric(CiteScore), ncol = 1), digits = 1), nsmall = 1),
      "Pareceres" = pareceres.all,
      "País" = paises.all,
      check.names = FALSE)
  
  rownames(peer.review) <- c()
  
  # remove duplicates
  peer.review <- peer.review[!duplicated(peer.review), ]
}
