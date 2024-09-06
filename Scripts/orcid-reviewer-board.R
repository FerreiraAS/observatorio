peer.review <- c()

# get peer review data
res <- rorcid::orcid_peer_reviews(my_orcid)

if (is.null(res[[1]]$group$`external-ids.external-id`)) {
  # do nothing
} else {
  # list of ISSN
  issn <-
    sapply(strsplit(sapply(
      res[[1]]$group$`external-ids.external-id`, `[[`, 2
    ), ":"), `[[`, 2)
  
  # list journals
  journals <- rorcid::issn_title[issn]
  
  # get SJR and CiteScore from database
  SJR <- c()
  CiteScore <- c()
  for (i in 1:length(issn)) {
    # get ISSN values
    df_scopus <- data.frame(issn = issn[i])
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
    data.frame(matrix(unname(journals), ncol = 1),
               format(round(matrix(
                 as.numeric(SJR), ncol = 1
               ), digits = 3), nsmall = 3),
               format(round(matrix(
                 as.numeric(CiteScore), ncol = 1
               ), digits = 1), nsmall = 1))
  peer.review <-
    peer.review[order(as.numeric(SJR), as.numeric(CiteScore), decreasing = TRUE), ]
  
  # remove rows with incomplete data
  peer.review <- peer.review[complete.cases(peer.review), ]
  colnames(peer.review) <-
    c(paste0("Periódicos (", dim(peer.review)[1], ")"), "SJR", "CiteScore")
  rownames(peer.review) <- c()
  
  # remove duplicates
  peer.review <- peer.review[!duplicated(peer.review), ]

  # print table (peer review)
  print(
    knitr::kable(
      peer.review,
      align = "l",
      format = ifelse(knitr::is_html_output(), "html", "latex"),
      escape = FALSE
    ) %>%
      kableExtra::kable_styling(
        bootstrap_options = c("striped", "hover", "condensed", "responsive"),
        full_width = T,
        position = "center"
      ) %>%
      kableExtra::row_spec(
        0,
        background = main.color,
        bold = TRUE,
        color = "white"
      ),
    row.names = NULL
  )
  cat("**Fontes**: [**Plataforma Sucupira**](https://sucupira.capes.gov.br/sucupira/), [**ORCID**](https://orcid.org)")
  cat('<br>')
  cat('<br>')
}
