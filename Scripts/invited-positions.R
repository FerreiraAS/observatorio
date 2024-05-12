invited.pos <- c()

# get invited positions data
res <- rorcid::orcid_invited_positions(my_orcid)

if (is.null(res[[1]]$`affiliation-group`$summaries)) {
  # do nothing
} else {
  affiliations <- res[[1]]$`affiliation-group`$summaries
  n.pos <- length(affiliations)
  
  invited.pos <- as.data.frame(matrix(NA, ncol = 2, nrow = n.pos))
  for (i in 1:n.pos) {
    # periódico
    invited.pos[i, 1] <-
      affiliations[[i]][['invited-position-summary.department-name']]
    invited.pos[i, 2] <-
      affiliations[[i]][['invited-position-summary.role-title']]
  }
  colnames(invited.pos) <- c("Periódico", "Atuação")
  
  # get SJR from SCImago database
  SJR <- c()
  for (k in 1:dim(invited.pos)[1]){
    SJR.i <- scimago$SJR[match(tolower(invited.pos[k, 1]), tolower(scimago$Title))]
    SJR <- c(SJR, ifelse(length(SJR.i) != 0, SJR.i, NA))
  }
  # get CiteScore from SCOPUS database
  CITESCORE <- c()
  for (k in 1:dim(invited.pos)[1]){
    CITESCORE.i <- citescore$CiteScore[match(tolower(invited.pos[k, 1]), tolower(citescore$source_title_medline_sourced_journals_are_indicated_in_green))]
    CITESCORE <- c(CITESCORE, ifelse(length(CITESCORE.i) != 0, CITESCORE.i, NA))
  }
  # get QUALIS from CAPES database
  QUALIS <- c()
  for (k in 1:dim(invited.pos)[1]){
    QUALIS.i <- qualis$Estrato[match(tolower(invited.pos[k, 1]), tolower(qualis$Título))]
    QUALIS <- c(QUALIS, ifelse(length(QUALIS.i) != 0, QUALIS.i, NA))
  }
  
  invited.pos <- cbind(invited.pos, SJR, CITESCORE, QUALIS)
  
  # print table (reviewed journals)
  print(
    knitr::kable(
      invited.pos,
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
  cat("**Fontes**: [**Plataforma Sucupira**](https://sucupira.capes.gov.br/sucupira/), [**ORCID**](https://orcid.org)")
  cat('<br>')
}
