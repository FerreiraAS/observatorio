# Getting Altmetrics Data Using API and R
# by Arthur de Sá Ferreira

# zources:
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
doi_reshaped_data <-
  data.frame(matrix(
    vector(),
    nrow = 0,
    ncol = length(columns_to_grab),
    dimnames = list(c(), columns_to_grab)
  ))

no_altmetric_dois_list <- list()

# loop for all DOI in the list
for (input in 1:length(dois_list)) {
  tryCatch(
    expr = {
      # open Altmetric url
      url <- paste0("https://api.altmetric.com/v1/doi/",
                    dois_list[[input]],
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
        doi_reshaped_data[input, columns_to_grab] <-
          t(split_data.2)[2,]
        doi_reshaped_data$author.names[input] <- author.names
        
        # merge at least one ISSN to each journal to search for in the CSV provided by SCImago
        issns <- matrix(NA, nrow = dim(doi_reshaped_data)[1])
        # initialize with latest ISSN vector if available
        if (length(doi_reshaped_data$issns) != 0) {
          issns <- doi_reshaped_data$issns
        }
        # try replacing with first issn (print)
        if (length(doi_reshaped_data$issns1) != 0) {
          issns[is.na(issns)] <- doi_reshaped_data$issns1[is.na(issns)]
        }
        # try replacing with second issn (online)
        if (length(doi_reshaped_data$issns2) != 0) {
          issns[is.na(issns)] <- doi_reshaped_data$issns2[is.na(issns)]
        }
        doi_reshaped_data$issn <- issns
        
        # clean up the environment
        rm(raw_data)
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
if (!is.null(doi_reshaped_data$published_on)) {
  year_publ <-
    format(as.Date(as.POSIXct(
      as.numeric(doi_reshaped_data$published_on), origin = "1970-01-01"
    )), format = "%Y")
} else {
  year_publ <-
    format(as.Date(as.POSIXct(
      as.numeric(doi_reshaped_data$last_updated), origin = "1970-01-01"
    )), format = "%Y")
}
doi_reshaped_data$published_on <- as.character(year_publ)

# convert score to integer (rouded up)
doi_reshaped_data$score <-
  ceiling(as.numeric(doi_reshaped_data$score))

# replace empty "count_" values by 0
doi_reshaped_data$cited_by_fbwalls_count[doi_reshaped_data$cited_by_fbwalls_count == ""] <-
  0
doi_reshaped_data$cited_by_feeds_count[doi_reshaped_data$cited_by_feeds_count == ""] <-
  0
doi_reshaped_data$cited_by_gplus_count[doi_reshaped_data$cited_by_gplus_count == ""] <-
  0
doi_reshaped_data$cited_by_msm_count[doi_reshaped_data$cited_by_msm_count == ""] <-
  0
doi_reshaped_data$cited_by_posts_count[doi_reshaped_data$cited_by_posts_count == ""] <-
  0
doi_reshaped_data$cited_by_rdts_count[doi_reshaped_data$cited_by_rdts_count == ""] <-
  0
doi_reshaped_data$cited_by_tweeters_count[doi_reshaped_data$cited_by_tweeters_count == ""] <-
  0
doi_reshaped_data$cited_by_videos_count[doi_reshaped_data$cited_by_videos_count == ""] <-
  0
doi_reshaped_data$cited_by_accounts_count[doi_reshaped_data$cited_by_accounts_count == ""] <-
  0
doi_reshaped_data$cited_by_patents_count[doi_reshaped_data$cited_by_patents_count == ""] <-
  0

# split and remove NA rows
doi_reshaped_data <-
  doi_reshaped_data[complete.cases(doi_reshaped_data),]

# remove duplicate entries
doi_reshaped_data <-
  doi_reshaped_data[!duplicated(doi_reshaped_data$doi),]

# sort columns by title
doi_reshaped_data <-
  doi_reshaped_data[order(doi_reshaped_data$title),]

# collect DOIs without altmetric data
no_altmetric_dois_list <-
  dois_list[is.na(match(
    lapply(dois_list, tolower),
    lapply(doi_reshaped_data$doi, tolower)
  ))]