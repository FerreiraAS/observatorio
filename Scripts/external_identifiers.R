external_ids <- c()

# get IDs data
res <- rorcid::orcid_external_identifiers(my_orcid)
res.all <- c()

for (id in 1:length(my_orcid)) {
  ext.id <- matrix(NA, nrow = 0, ncol = 0)
  colnames(ext.id) <- c()
  if (!is.null(res[[id]]$`external-identifier`$`external-id-type`)) {
    # select external ID and external ID value
    ext.id <- data.frame(cbind(
      if(!is.null(res[[id]]$`external-identifier`$`source.assertion-origin-name.value`)){
        tools::toTitleCase(unique(na.omit(res[[id]]$`external-identifier`$`source.assertion-origin-name.value`)))
      } else {
        temp <- rorcid::orcid_id(my_orcid[id])
        tools::toTitleCase(paste(temp[[1]]$name$`given-names`, temp[[1]]$name$`family-name`))
        },
      t(c(my_orcid[id], res[[id]]$`external-identifier`$`external-id-value`))
    ))
    # add column names
    colnames(ext.id) <- c("Nome", "ORCID", res[[id]]$`external-identifier`$`external-id-type`)
    # remove duplicated columns if any
    ext.id <- ext.id[!duplicated(as.list(ext.id))]

    res.all <- 
      dplyr::bind_rows(
        res.all,
        ext.id
      )
  }
}

# remove multiple Scopus ID if any
mult.ids <- c()
for(i in 2:100){
  mult.ids <- c(mult.ids, paste("Scopus Author ID...", as.character(i), sep = ""))
}

# data %>% mutate(mycol = coalesce(x,y,z)) %>%
#   select(a, mycol)

res.all <- res.all[ , !names(res.all) %in% mult.ids]

if(!sjmisc::is_empty(res.all)){
  # print table (external IDs)
  print(
    knitr::kable(
      res.all[order(res.all[, 1]), ],
      align = "l",
      format = "html",
      escape = FALSE,
      row.names = FALSE
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
  cat('<br>')
}
  