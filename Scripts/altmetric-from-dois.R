# Getting Altmetrics Data Using API and R
# by Arthur de Sá Ferreira

# sources:
# https://api.altmetric.com
# https://docs.google.com/spreadsheets/d/1ndVY8Q2LOaZO_P_HDmSQulagjeUrS250mAL2N5V8GvY/edit#gid=0

# select data to grab from Altmetric API
columns_to_grab <-
  c(
    "title",
    "doi",
    "url",
    "issns",
    "journal",
    "authors",
    "issns1",
    "issns2",
    "published_on",
    "last_updated",
    "cited_by_fbwalls_count",
    "cited_by_feeds_count",
    "cited_by_gplus_count",
    "cited_by_msm_count",
    "cited_by_posts_count",
    "cited_by_rdts_count",
    "cited_by_tweeters_count",
    "cited_by_videos_count",
    "cited_by_accounts_count",
    "cited_by_patents_count",
    "mendeley",
    "score",
    "is_oa"
  )

# initialize dataframe
doi_with_altmetric <-
  data.frame(matrix(
    vector(),
    nrow = 0,
    ncol = length(columns_to_grab),
    dimnames = list(c(), columns_to_grab)
  ))

# loop for all DOI in the list
for (input in 1:dim(dois_df)[1]) {
  tryCatch(
    expr = {
      # open Altmetric url
      url <- paste0("https://api.altmetric.com/v1/doi/",
                    dois_df$DOI[input],
                    collapse = "")
      raw_data <- read.csv(url,
                           sep = ",",
                           check.names = FALSE,
                           strip.white = FALSE)
      if (!is.na(match(url, showConnections(all = TRUE)[, 1]) - 1)) {
        close(getConnection(match(url, showConnections(all = TRUE)[, 1]) - 1))
      } else {
        # proceed as there is Altmetric info for this DOI
        split_data <- strsplit(colnames(raw_data), ":")
        
        split_names <- sapply(split_data, "[[", 1)
        
        split_data.2 <- c()
        for (i in 1:length(columns_to_grab)) {
          # bind label and data
          label <- columns_to_grab[i]
          data <-
            gsub("\\[|\\]",
                 "",
                 paste(split_data[[match(label, gsub("\\{|\\}", "", split_names))]][2:length(split_data[[match(label, gsub("\\{|\\}", "", split_names))]])], collapse = ":", sep = ""))
          split_data.2 <- rbind(split_data.2, c(label, data))
          
          # add multiple ISSN
          if (split_names[6] != "journals") {
            data <- gsub("\\[|\\]", "", paste(data, raw_data[[6]]))
          }
          
          # add multiple authors
          author.start <- match("authors", split_names)
          author.end <- match("type", split_names) - 1
          author.names <- c()
          for (k in (author.start):(author.end)) {
            author.names <- paste0(author.names, split_data[[k]], sep = ", ")
          }
          author.names <- gsub("\\[|\\]", "", author.names[2])
          author.names <-
            substr(author.names, 1, nchar(author.names) - 2)
        }
        split_data.2 <-
          rbind(split_data.2, c("authors", author.names))
        
        # bind rows data
        doi_with_altmetric[input, columns_to_grab] <-
          t(split_data.2)[2,]
        doi_with_altmetric$author.names[input] <- author.names
        
        # merge at least one ISSN to each journal to search for in the CSV provided by SCImago
        issns <- matrix(NA, nrow = dim(doi_with_altmetric)[1])
        # initialize with latest ISSN vector if available
        if (length(doi_with_altmetric$issns) != 0) {
          issns <- doi_with_altmetric$issns
        }
        # try replacing with first issn (print)
        if (length(doi_with_altmetric$issns1) != 0) {
          issns[is.na(issns)] <- doi_with_altmetric$issns1[is.na(issns)]
        }
        # try replacing with second issn (online)
        if (length(doi_with_altmetric$issns2) != 0) {
          issns[is.na(issns)] <- doi_with_altmetric$issns2[is.na(issns)]
        }
        doi_with_altmetric$issn <- issns
        
        # clean up the environment
        rm(raw_data)
        
        # beep
        beepr::beep("coin")
      }
    },
    error = function(e) {
      if (!is.na(match(url, showConnections(all = TRUE)[, 1]) - 1)) {
        close(getConnection(match(url, showConnections(all = TRUE)[, 1]) - 1))
      }
    },
    finally = {
      Sys.sleep(1)
    }
  )
}

# The Unix epoch is 00:00:00 UTC on 1 January 1970 (an arbitrary date)
# https://en.wikipedia.org/wiki/Unix_time
if (!is.null(doi_with_altmetric$published_on)) {
  year_publ <-
    format(as.Date(as.POSIXct(
      as.numeric(doi_with_altmetric$published_on), origin = "1970-01-01"
    )), format = "%Y")
} else {
  year_publ <-
    format(as.Date(as.POSIXct(
      as.numeric(doi_with_altmetric$last_updated), origin = "1970-01-01"
    )), format = "%Y")
}
doi_with_altmetric$published_on <- as.character(year_publ)

# convert Altmetric score to integer (rouded up)
doi_with_altmetric$score <-
  ceiling(as.numeric(doi_with_altmetric$score))
# rename column
data.table::setnames(doi_with_altmetric, 'score', 'altmetric_score')

# replace empty "count_" values by 0
doi_with_altmetric$cited_by_fbwalls_count[doi_with_altmetric$cited_by_fbwalls_count == ""] <-
  0
doi_with_altmetric$cited_by_feeds_count[doi_with_altmetric$cited_by_feeds_count == ""] <-
  0
doi_with_altmetric$cited_by_gplus_count[doi_with_altmetric$cited_by_gplus_count == ""] <-
  0
doi_with_altmetric$cited_by_msm_count[doi_with_altmetric$cited_by_msm_count == ""] <-
  0
doi_with_altmetric$cited_by_posts_count[doi_with_altmetric$cited_by_posts_count == ""] <-
  0
doi_with_altmetric$cited_by_rdts_count[doi_with_altmetric$cited_by_rdts_count == ""] <-
  0
doi_with_altmetric$cited_by_tweeters_count[doi_with_altmetric$cited_by_tweeters_count == ""] <-
  0
doi_with_altmetric$cited_by_videos_count[doi_with_altmetric$cited_by_videos_count == ""] <-
  0
doi_with_altmetric$cited_by_accounts_count[doi_with_altmetric$cited_by_accounts_count == ""] <-
  0
doi_with_altmetric$cited_by_patents_count[doi_with_altmetric$cited_by_patents_count == ""] <-
  0
doi_with_altmetric$cited_by_patents_count[doi_with_altmetric$mendeley == ""] <-
  0

# split and remove NA rows
doi_with_altmetric <-
  doi_with_altmetric[complete.cases(doi_with_altmetric),]

# remove duplicate entries
doi_with_altmetric <-
  doi_with_altmetric[!duplicated(doi_with_altmetric$doi),]

# sort columns by title
doi_with_altmetric <-
  doi_with_altmetric[order(doi_with_altmetric$title),]

# replace is_oa from Crossref
for (i in 1:length(doi_with_altmetric$doi)) {
  my_doi_oa <-
    roadoi::oadoi_fetch(dois = doi_with_altmetric$doi[i], email = "cienciasdareabilitacao@souunisuam.com.br")
  doi_with_altmetric$is_oa[i] <-
    ifelse(length(my_doi_oa) != 0,
           toupper(as.character(my_doi_oa$is_oa)),
           "FALSE")
}

doi_with_altmetric$citations <- rep(0, dim(doi_with_altmetric)[1])
for (i in 1:dim(doi_with_altmetric)[1]) {
  # add citation counts
  try({
    citations <-
      rcrossref::cr_citation_count(doi = as.character(doi_with_altmetric$doi[i]), key = "cienciasdareabilitacao@souunisuam.com.br")
    doi_with_altmetric$citations[i] <- citations$count
  },
  silent = TRUE)
  # search for alternative source of journal name
  if (sjmisc::is_empty(doi_with_altmetric$journal[i]) & !sjmisc::is_empty(doi_with_altmetric$issn[i])) {
    try({
      journal <- scimago[grep(gsub("-", "", doi_with_altmetric$issn[i]), scimago$Issn), 3][1]
      if(!sjmisc::is_empty(journal)){
        doi_with_altmetric$journal[i] <- journal
      }
    }, silent = TRUE)
  }
}

# collect DOIs without Altmetric data
doi_without_altmetric <- c()
doi_without_altmetric <-
  data.frame(DOI = setdiff(tolower(dois_df$DOI),
                           tolower(doi_with_altmetric$doi)))
