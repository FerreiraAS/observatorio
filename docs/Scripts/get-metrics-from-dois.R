# Verifica se há DOIs
if (is_empty(dois)) {
  doi_unique <- as.data.frame(matrix(nrow = 0, ncol = 0))
  my_dois_works <- list()
} else {
  dois_list <- as.list(dois$DOI)
  
  # roda o script para obter dados do Altmetric
  source("Scripts/altmetric-from-dois.R", local = knitr::knit_global())
  doi_unique <- doi_reshaped_data
  
  # get data of papers without Altmetric from CrossRef
  if (is_empty(no_altmetric_dois_list)) {
    my_dois_works <- list()
  } else {
    my_dois_works <-
      rcrossref::cr_works(dois = unlist(no_altmetric_dois_list)) %>%
      pluck("data")
    # sort columns by title
    if (length(my_dois_works) != 0) {
      my_dois_works <-
        my_dois_works[order(as.vector(my_dois_works$title)), ]
    }
  }
  # add issued (created) year of publication
  tryCatch(
    expr = {
      # get year from issued
      my_dois_works$published_on <-
        str_sub(as.character(my_dois_works$issued), 1, 4)
      # get year from created if not issued
      my_dois_works$published_on[is.na(my_dois_works$published_on)] <-
        str_sub(as.character(my_dois_works$created[is.na(my_dois_works$published_on)]), 1, 4)
    },
    error = function(e) {
      
    }
  )
}