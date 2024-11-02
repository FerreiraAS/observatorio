member <- c()

# get invited positions data
res <- rorcid::orcid_memberships(my_orcid)

if (is.null(res[[1]]$`affiliation-group`$summaries)) {
  # do nothing
} else {
  memberships <- res[[1]]$`affiliation-group`$summaries
  n.pos <- length(memberships)
  
  member <- as.data.frame(matrix(NA, ncol = 2, nrow = n.pos), check.names = FALSE)
  for (i in 1:n.pos) {
    # periódico
    member[i, 1] <-
      memberships[[i]][['membership-summary.organization.name']]
    member[i, 2] <-
      memberships[[i]][['membership-summary.role-title']]
  }
  colnames(member) <- c("Afiliação", "Atuação")
  
  # print table (reviewed journals)
  print(
    knitr::kable(
      member,
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

# ################################

services <- c()

# get invited positions data
res <- rorcid::orcid_services(my_orcid)

if (is.null(res[[1]]$`affiliation-group`$summaries)) {
  # do nothing
} else {
  services.res <- res[[1]]$`affiliation-group`$summaries
  n.pos <- length(services.res)
  
  services <- as.data.frame(matrix(NA, ncol = 2, nrow = n.pos), check.names = FALSE)
  for (i in 1:n.pos) {
    # periódico
    services[i, 1] <-
      services.res[[i]][['service-summary.organization.name']]
    services[i, 2] <-
      services.res[[i]][['service-summary.role-title']]
  }
  colnames(services) <- c("Afiliação", "Atuação")
  
  # print table (reviewed journals)
  print(
    knitr::kable(
      services,
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
