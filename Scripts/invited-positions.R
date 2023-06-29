invited.pos <- c()

# get invited positions data
res <- orcid_invited_positions(my_orcid)

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

  # print table
  if (dim(invited.pos)[1] != 0) {
    source("Scripts/table-with-buttons.R", local = knitr::knit_global())
    cat(knitr::knit_print(create_dt(invited.pos, title = "Membro de corpo editorial (ORCID Invited positions)")))
  } else {
    cat("*Sem dados para exibir*")
  }
  cat('<br>')
}
