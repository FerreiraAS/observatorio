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
    if(is.na(invited.pos[i, 1])){
      # split invited.pos[i, 2] into two columns using gsub to extrac text between ()
      invited.pos[i, 1] <- trimws(gsub(".*\\((.*)\\).*", "\\1", invited.pos[i, 2]))
      # keep only text before ()
      invited.pos[i, 2] <- trimws(gsub("\\(.*\\)", "", invited.pos[i, 2]))
    }
  }
  colnames(invited.pos) <- c("Periódico", "Atuação")
  
  invited.pos <- cbind(invited.pos)
  
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
  cat("**Fontes**: [**Plataforma Sucupira**](https://sucupira.capes.gov.br/sucupira/), [**ORCID**](https://orcid.org)")
  cat('<br>')
  cat('<br>')
}
