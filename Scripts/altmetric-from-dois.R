# Getting Altmetric Data Using API and R
# by Arthur de Sá Ferreira

# sources: 19 nov 2024
# https://api.altmetric.com
# https://api.altmetric.com/data-endpoints-counts.html

# select data to grab from Altmetric API
columns_to_grab <-
  c(
    "cited_by_fbwalls_count",
    "cited_by_feeds_count",
    "cited_by_gplus_count",
    "cited_by_msm_count",
    "cited_by_rdts_count",
    "cited_by_qna_count", # NEW
    "cited_by_tweeters_count",
    "cited_by_wikipedia_count", # NEW
    "cited_by_policies_count", # NEW
    "cited_by_patents_count",
    "cited_by_videos_count",
    "cited_by_accounts_count",
    "cited_by_posts_count",
    "mendeley",
    "score",
    "is_oa"
  )

# initialize dataframe
doi_with_metrics <-
  data.frame(matrix(
    vector(),
    nrow = 1,
    ncol = length(columns_to_grab),
    dimnames = list(c(), columns_to_grab)
  ), check.names = FALSE)

# loop for all DOI in the list
for (input in 1:dim(dois)[1]) {
  tryCatch(
    expr = {
      # open Altmetric url
      url <- paste0("https://api.altmetric.com/v1/doi/",
                    dois$DOI[input],
                    collapse = "")
      raw_data <- read.csv(url,
                           sep = ",",
                           check.names = FALSE,
                           strip.white = FALSE)
      if (!is.na(match(url, showConnections(all = TRUE)[, 1]) - 1)) {
        doi_with_error <- c(doi_with_error, dois$DOI[input])
        # close connection
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
        }
        
        # bind rows data
        doi_with_metrics[input, columns_to_grab] <- t(split_data.2)[2, ]
        
        # convert Altmetric score to integer (rouded up)
        try(doi_with_metrics$score <- ceiling(as.numeric(doi_with_metrics$score)))
        
        # replace empty "count_" values by 0
        doi_with_metrics$cited_by_fbwalls_count[doi_with_metrics$cited_by_fbwalls_count == ""] <- 0
        doi_with_metrics$cited_by_feeds_count[doi_with_metrics$cited_by_feeds_count == ""] <- 0
        doi_with_metrics$cited_by_gplus_count[doi_with_metrics$cited_by_gplus_count == ""] <- 0
        doi_with_metrics$cited_by_msm_count[doi_with_metrics$cited_by_msm_count == ""] <- 0
        doi_with_metrics$cited_by_rdts_count[doi_with_metrics$cited_by_rdts_count == ""] <- 0
        doi_with_metrics$cited_by_qna_count[doi_with_metrics$cited_by_qna_count == ""] <- 0
        doi_with_metrics$cited_by_tweeters_count[doi_with_metrics$cited_by_tweeters_count == ""] <- 0
        doi_with_metrics$cited_by_wikipedia_count[doi_with_metrics$cited_by_wikipedia_count == ""] <- 0
        doi_with_metrics$cited_by_policies_count[doi_with_metrics$cited_by_policies_count == ""] <- 0
        doi_with_metrics$cited_by_patents_count[doi_with_metrics$cited_by_patents_count == ""] <- 0
        doi_with_metrics$cited_by_videos_count[doi_with_metrics$cited_by_videos_count == ""] <- 0
        doi_with_metrics$cited_by_accounts_count[doi_with_metrics$cited_by_accounts_count == ""] <- 0
        doi_with_metrics$cited_by_posts_count[doi_with_metrics$cited_by_posts_count == ""] <- 0
        doi_with_metrics$mendeley[doi_with_metrics$mendeley == ""] <- 0

        # clean up the environment
        rm(raw_data)
      }
    },
    error = function(e) {
      if (!is.na(match(url, showConnections(all = TRUE)[, 1]) - 1)) {
        close(getConnection(match(url, showConnections(all = TRUE)[, 1]) - 1))
      }
      doi_with_error <- c(doi_with_error, dois$DOI[input])
    },
    finally = {
    }
  )
}
