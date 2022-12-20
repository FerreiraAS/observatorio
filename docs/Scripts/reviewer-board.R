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
    SJR <- c(SJR, ifelse(length(SJR.i) != 0, SJR.i, "-"))
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
  
  # print table (reviewer name)
  print(
    kable(
      paste0("**", reviewer.name, "** <br><br>"),
      align = "l",
      format = "html",
      escape = FALSE,
      col.names = NULL
    ) %>%
      kable_styling(
        bootstrap_options = c("striped", "hover", "condensed", "responsive"),
        full_width = T,
        position = "center"
      ) %>%
      row_spec(
        1,
        background = "#2C3E50",
        bold = TRUE,
        color = "white"
      ),
    row.names = FALSE,
    col.names = FALSE
  )
  # print table (reviewed journals)
  print(
    kable(
      peer.review,
      align = "l",
      format = "html",
      escape = FALSE
    ) %>%
      kable_styling(
        bootstrap_options = c("striped", "hover", "condensed", "responsive"),
        full_width = T,
        position = "center"
      ) %>%
      row_spec(
        0,
        background = "#2C3E50",
        bold = TRUE,
        color = "white"
      ),
    row.names = FALSE,
    col.names = FALSE
  )
  cat('<br>')
}