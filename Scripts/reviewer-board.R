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
  
  # get SJR from SCImago database
  SJR <- c()
  for (i in 1:length(issn)) {
    SJR.i <-
      scimago$SJR[grep(gsub("-", "", substr(issn[i], 1, 9)), scimago$Issn)]
    SJR <- c(SJR, ifelse(length(SJR.i) != 0, SJR.i, ""))
  }

  # bind and rank by SJR
  peer.review <-
    data.frame(matrix(unname(journals), ncol = 1), matrix(SJR, ncol = 1))
  peer.review <-
    peer.review[order(as.numeric(SJR), decreasing = TRUE), ]

  # remove rows with incomplete data
  peer.review <- peer.review[complete.cases(peer.review), ]
  colnames(peer.review) <-
    c(paste0("Periódicos (", dim(peer.review)[1], ")"), "SJR")
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
  cat('<br>')
  cat(
    "*Fontes:* [**Plataforma Sucupira**](https://sucupira.capes.gov.br/sucupira/), [**ORCID**](https://orcid.org)"
  )
  cat('<br>')
}