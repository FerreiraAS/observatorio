# test
# my_orcid <- "0000-0001-7014-2002"

# periódico
invited.pos <- c()
labels <- c("Ano (início)", "Ano (fim)", "Docente", "Periódico", "Atuação", "País")

# get invited positions data
res <- rorcid::orcid_invited_positions(my_orcid)

if (is.null(res[[1]]$`affiliation-group`$summaries)) {
  # do nothing
} else {
  affiliations <- res[[1]]$`affiliation-group`$summaries
  n.pos <- length(affiliations)
  
  invited.pos <- as.data.frame(matrix("", ncol = length(labels), nrow = n.pos), check.names = FALSE)
  for (i in 1:n.pos) {
    # get ano inicio
    try(invited.pos[i, 1] <-
          affiliations[[i]][['invited-position-summary.start-date.year.value']], silent = TRUE)
    # get ano fim
    try(invited.pos[i, 2] <-
          affiliations[[i]][['invited-position-summary.end-date']], silent = TRUE)
    if(is.na(invited.pos[i, 2])){invited.pos[i, 2] <- "Atual"}
    if(invited.pos[i, 2] == ""){invited.pos[i, 2] <- "Atual"}
    # get docente
    try(invited.pos[i, 3] <-
          affiliations[[i]][['invited-position-summary.source.source-name.value']], silent = TRUE)
    # get periódico
    try(invited.pos[i, 4] <-
          affiliations[[i]][['invited-position-summary.department-name']], silent = TRUE)
    # get atuacao
    try(invited.pos[i, 5] <-
          affiliations[[i]][['invited-position-summary.role-title']], silent = TRUE)
    if(is.na(invited.pos[i, 1])){
      # split invited.pos[i, 2] into two columns using gsub to extrac text between ()
      invited.pos[i, 4] <- trimws(gsub(".*\\((.*)\\).*", "\\1", invited.pos[i, 5]))
      # keep only text before ()
      invited.pos[i, 5] <- trimws(gsub("\\(.*\\)", "", invited.pos[i, 5]))
    }
    # get pais
    try(invited.pos[i, 6] <-
          affiliations[[i]][['invited-position-summary.organization.address.country']], silent = TRUE)
  }
  colnames(invited.pos) <- labels
}