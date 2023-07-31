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
  
  # print table (reviewed journals)
  print(
    knitr::kable(
      invited.pos,
      align = "l",
      format = "html",
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
  cat('^[https://info.orcid.org/new-to-the-orcid-record-interface-professional-activities/]')
  cat('<br>')
}
