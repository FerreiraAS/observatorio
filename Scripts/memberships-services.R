member <- c()

# get invited positions data
res <- orcid_memberships(my_orcid)

if (is.null(res[[1]]$`affiliation-group`$summaries)) {
  # do nothing
} else {
  memberships <- res[[1]]$`affiliation-group`$summaries
  n.pos <- length(memberships)
  
  member <- as.data.frame(matrix(NA, ncol = 2, nrow = n.pos))
  for (i in 1:n.pos) {
    # periódico
    member[i, 1] <-
      memberships[[i]][['membership-summary.organization.name']]
    member[i, 2] <-
      memberships[[i]][['membership-summary.role-title']]
  }
  colnames(member) <- c("Afiliação", "Atuação")
  
  # print table
  if (dim(member)[1] != 0) {
    source("Scripts/table-with-buttons.R", local = knitr::knit_global())
    cat(knitr::knit_print(create_dt(member, title = "Membro de associações (ORCID memberships)")))
  } else {
    cat("*Sem dados para exibir*")
  }
  cat('<br>')
}

# ################################

services <- c()

# get invited positions data
res <- orcid_services(my_orcid)

if (is.null(res[[1]]$`affiliation-group`$summaries)) {
  # do nothing
} else {
  services.res <- res[[1]]$`affiliation-group`$summaries
  n.pos <- length(services.res)
  
  services <- as.data.frame(matrix(NA, ncol = 2, nrow = n.pos))
  for (i in 1:n.pos) {
    # periódico
    services[i, 1] <-
      services.res[[i]][['service-summary.organization.name']]
    services[i, 2] <-
      services.res[[i]][['service-summary.role-title']]
  }
  colnames(services) <- c("Afiliação", "Atuação")
  
  # print table
  if (dim(services)[1] != 0) {
    source("Scripts/table-with-buttons.R", local = knitr::knit_global())
    cat(knitr::knit_print(create_dt(services, title = "Membro de associações (ORCID services)")))
  } else {
    cat("*Sem dados para exibir*")
  }
  cat('<br>')
}
