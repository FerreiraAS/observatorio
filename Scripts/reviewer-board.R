peer.review <- c()

# get peer review data
res <- orcid_peer_reviews(my_orcid)

if (is.null(res[[1]]$group$`external-ids.external-id`)) {
  # do nothing
} else {
  # list of ISSN
  issn <-
    sapply(strsplit(sapply(
      res[[1]]$group$`external-ids.external-id`, `[[`, 2
    ), ":"), `[[`, 2)
  
  # get SJR from SCImago database
  SJR <- c()
  for (i in 1:length(issn)) {
    SJR.i <-
      scimago[grep(gsub("-", "", substr(issn[i], 1, 9)), scimago$Issn), 6]
    SJR <- c(SJR, ifelse(length(SJR.i) != 0, SJR.i, ""))
  }
  
  # list journals
  journals <- issn_title[issn]
  
  # bind and rank by SJR
  peer.review <-
    data.frame(matrix(unname(journals), ncol = 1), matrix(SJR, ncol = 1))
  peer.review <-
    peer.review[order(as.numeric(SJR), decreasing = TRUE), ]
  
  # remove rows with incomplete data
  peer.review <- peer.review[complete.cases(peer.review), ]
  colnames(peer.review) <-
    c(paste("Periódicos (", dim(peer.review)[1], ")", sep = ""), "SJR")
  rownames(peer.review) <- c()
  
  # print table
  if (dim(peer.review)[1] != 0) {
    source("Scripts/table-with-buttons.R", local = knitr::knit_global())
    cat(knitr::knit_print(create_dt(peer.review, title = "Revisor de periódico (ORCID peer review)")))
  } else {
    cat("*Sem dados para exibir*")
  }
  cat('<br>')
}