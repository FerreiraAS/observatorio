get_citescore <-
  function(citescore,
           doi_with_altmetric = NULL,
           doi_without_altmetric = NULL) {
    # initialize values
    citescore_id <- NA
    citescore_value <- NA
    citescore_year <- NA
    citescore_p <- NA
    
    # get CiteScore for "doi_with_altmetric" data
    if (!is.null(doi_with_altmetric) & !sjmisc::is_empty(doi_with_altmetric$issns)) {
      citescore_id <-
        as.character(citescore$sourcerecord_id[grep(gsub("-", "", doi_with_altmetric$issn), citescore$print_issn)])
      if (sjmisc::is_empty(citescore_id)) {
        citescore_id <-
          as.character(citescore$sourcerecord_id[grep(gsub("-", "", doi_with_altmetric$issn), citescore$e_issn)])
      }
      if (sjmisc::is_empty(citescore_id)) {
        citescore_id <-
          as.character(citescore$sourcerecord_id[grep(
            tolower(gsub(
              "& | &amp;", "and", doi_with_altmetric$journal
            )),
            tolower(
              citescore$source_title_medline_sourced_journals_are_indicated_in_green
            )
          )])
      }
    }
    # get CiteScore for "doi_without_altmetric" data
    if (!is.null(doi_without_altmetric)) {
      if (sjmisc::is_empty(doi_without_altmetric$issn) | sjmisc::is_empty(doi_without_altmetric$issn)) {
        citescore_id <- character(0)
        citescore_value <- character(0)
        citescore_year <- character(0)
        citescore_p <- character(0)
      } else {
        if (stringr::str_length(doi_without_altmetric$issn) == 9) {
          citescore_id <-
            as.character(citescore$sourcerecord_id[grep(gsub("-", "", doi_without_altmetric$issn),
                                                        citescore$print_issn)])
        }
        if (stringr::str_length(doi_without_altmetric$issn) == 19) {
          citescore_id <-
            as.character(citescore$sourcerecord_id[grep(gsub("-", "", substr(doi_without_altmetric$issn, 1, 9)), citescore$print_issn, fixed =
                                                          TRUE)])
          if (sjmisc::is_empty(citescore_id)) {
            citescore_id <-
              as.character(citescore$sourcerecord_id[grep(gsub("-", "", substr(doi_without_altmetric$issn, 11, 19), fixed =
                                                                 TRUE),
                                                          citescore$print_issn,
                                                          fixed = TRUE)])
          }
        }
        if (sjmisc::is_empty(citescore_id)) {
          citescore_id <-
            as.character(citescore$sourcerecord_id[grep(
              tolower(
                gsub("& | &amp;", "and", doi_without_altmetric$journal, fixed = TRUE)
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
        citescore$CiteScore[match(citescore_id, citescore$sourcerecord_id)]
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
