# test
# my_orcid <- "0000-0001-7014-2002"

member <- c()

labels.1 <- c("Ano (início)", "Ano (fim)", "Docente", "Afiliação", "Atuação", "País")
labels.2 <- c("Ano (início)", "Ano (fim)", "Docente", "Organização", "Atuação", "País")

# get invited positions data
res <- rorcid::orcid_memberships(my_orcid)

if (is.null(res[[1]]$`affiliation-group`$summaries)) {
  # do nothing
} else {
  memberships <- res[[1]]$`affiliation-group`$summaries
  n.pos <- length(memberships)
  
  # associações
  member <- as.data.frame(matrix(NA, ncol = length(labels.1), nrow = n.pos), check.names = FALSE)
  for (i in 1:n.pos) {
    # get ano inicial
    try(member[i, 1] <- 
      memberships[[i]][['membership-summary.start-date.year.value']], silent = TRUE)
    # get ano final
    try(member[i, 2] <-
      memberships[[i]][['membership-summary.end-date']], silent = TRUE)
    if(is.na(member[i, 2])){member[i, 2] <- "Atual"}
    # get name
    try(member[i, 3] <-
      memberships[[i]][['membership-summary.source.source-name.value']], silent = TRUE)
    # get afiliação
    try(member[i, 4] <-
      memberships[[i]][['membership-summary.organization.name']], silent = TRUE)
    # get atuação
    try(member[i, 5] <-
      memberships[[i]][['membership-summary.role-title']], silent = TRUE)
    # get país
    try(member[i, 6] <- 
      memberships[[i]][['membership-summary.organization.address.country']], silent = TRUE)
  }
  colnames(member) <- labels.1
}

# ################################

services <- c()

# get invited positions data
res <- rorcid::orcid_services(my_orcid)

if (is.null(res[[1]]$`affiliation-group`$summaries)) {
  # do nothing
} else {
  services.res <- res[[1]]$`affiliation-group`$summaries
  n.pos <- length(services.res)
  
  # periódicos
  services <- as.data.frame(matrix(NA, ncol = length(labels.2), nrow = n.pos), check.names = FALSE)
  for (i in 1:n.pos) {
    # get ano inicial
    try(services[i, 1] <- 
      services.res[[i]][['service-summary.start-date.year.value']], silent = TRUE)
    # get ano final
    try(services[i, 2] <-
      services.res[[i]][['service-summary.end-date.year.value']], silent = TRUE)
    if(is.na(services[i, 2])){services[i, 2] <- "Atual"}
    # get name
    try(services[i, 3] <-
      services.res[[i]][['service-summary.source.source-name.value']], silent = TRUE)
    # get organization
    try(services[i, 4] <-
      services.res[[i]][['service-summary.organization.name']], silent = TRUE)
    # get atuação 
    try(services[i, 5] <-
      services.res[[i]][['service-summary.role-title']], silent = TRUE)
    # get pais
    try(services[i, 6] <- 
      services.res[[i]][['service-summary.organization.address.country']], silent = TRUE)
  }
  colnames(services) <- labels.2
}
