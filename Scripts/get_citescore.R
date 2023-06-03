get_citescore <-
  function(citescore,
           doi_unique = NULL,
           my_doi_works = NULL) {
    # initialize values
    citescore_id <- NA
    citescore_value <- NA
    citescore_year <- NA
    citescore_p <- NA
    
    # get CiteScore for "doi_unique" data
    if (!is.null(doi_unique)) {
      citescore_id <-
        as.character(citescore$sourcerecord_id[grep(gsub("-", "", doi_unique$issn), citescore$print_issn)])
      if (sjmisc::is_empty(citescore_id)) {
        citescore_id <-
          as.character(citescore$sourcerecord_id[grep(gsub("-", "", doi_unique$issn), citescore$e_issn)])
      }
      if (sjmisc::is_empty(citescore_id)) {
        citescore_id <-
          as.character(citescore$sourcerecord_id[grep(
            tolower(gsub(
              "& | &amp;", "and", doi_unique$journal
            )),
            tolower(
              citescore$source_title_medline_sourced_journals_are_indicated_in_green
            )
          )])
      }
    }
    # get CiteScore for "my_doi_works" data
    if (!is.null(my_doi_works)) {
      if (sjmisc::is_empty(my_doi_works$issn) |
          length(my_doi_works$issn) == 0) {
        citescore_id <- character(0)
        citescore_value <- "-1"
        citescore_year <- character(0)
        citescore_p <- character(0)
      } else {
        if (stringr::str_length(my_doi_works$issn) == 9) {
          citescore_id <-
            as.character(citescore$sourcerecord_id[grep(gsub("-", "", my_doi_works$issn),
                                                        citescore$print_issn)])
        }
        if (stringr::str_length(my_doi_works$issn) == 19) {
          citescore_id <-
            as.character(citescore$sourcerecord_id[grep(gsub("-", "", substr(my_doi_works$issn, 1, 9)), citescore$print_issn, fixed =
                                                          TRUE)])
          if (sjmisc::is_empty(citescore_id)) {
            citescore_id <-
              as.character(citescore$sourcerecord_id[grep(gsub("-", "", substr(my_doi_works$issn, 11, 19), fixed =
                                                                 TRUE),
                                                          citescore$print_issn,
                                                          fixed = TRUE)])
          }
        }
        if (sjmisc::is_empty(citescore_id)) {
          citescore_id <-
            as.character(citescore$sourcerecord_id[grep(
              tolower(
                gsub("& | &amp;", "and", my_doi_works$journal, fixed = TRUE)
              ),
              tolower(
                citescore$source_title_medline_sourced_journals_are_indicated_in_green
              ),
              fixed = TRUE
            )])
        }
      }
    }
    if (!sjmisc::is_empty(citescore_id)) {
      citescore_value <-
        citescore$x2021_cite_score[match(citescore_id, citescore$sourcerecord_id)]
      citescore_year <-
        as.numeric(citescore$last_coverage[match(citescore_id, citescore$sourcerecord_id)]) - 1
      citescore_p <-
        round(citescore$percentile[match(citescore_id, citescore$sourcerecord_id)] * 100, 0)
    }
    return(
      list(
        citescore_id = citescore_id,
        citescore_value = citescore_value,
        citescore_year = citescore_year,
        citescore_p = citescore_p
      )
    )
  }
