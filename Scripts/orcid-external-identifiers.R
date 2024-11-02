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
    ), check.names = FALSE)
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

# remove multiple Scopus ID if any (up to 100)
mult.ids <- c()
for(i in 1:100){
  mult.ids <- c(mult.ids, paste0("Scopus Author ID.", as.character(i)), paste("Scopus Author ID...", as.character(i), sep = ""))
}

res.all <- res.all[ , !names(res.all) %in% mult.ids]

external.ids <- res.all[order(res.all[, 1]), ]
