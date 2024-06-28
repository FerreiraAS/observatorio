# Getting Scopus Data Using R
# by Arthur de Sá Ferreira

# select data to grab from Altmetric API
columns_to_grab <-
  c("source_id",
    "SJR",
    "SJR_year",
    "CiteScore",
    "CiteScore_year")

# initialize dataframe
doi_with_metrics <-
  data.frame(matrix(
    vector(),
    nrow = 1,
    ncol = length(columns_to_grab),
    dimnames = list(c(), columns_to_grab)
  ))

# loop for all entries in the list
for (input in 1:dim(df_scopus)[1]) {
  tryCatch(
    expr = {
      # open Altmetric url
      url <- paste0("https://api.elsevier.com/content/serial/title/", "issn", "/", df_scopus$issn[input], "?apiKey=703d4b9912c5399d774a88cb7adc10fd",
                    collapse = "")
      raw_data <- read.csv(url,
                           sep = ",",
                           check.names = FALSE,
                           strip.white = FALSE)
      if (!is.na(match(url, showConnections(all = TRUE)[, 1]) - 1)) {
        source_with_error <- c(source_with_error, df_scopus$issn[input])
        # close connection
        close(getConnection(match(url, showConnections(all = TRUE)[, 1]) - 1))
      } else {
        # proceed as there is info for this entry
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
        
        # get values
        doi_with_metrics$source_id <- as.numeric(split_data[[match("source-id", split_names)]][2])
        doi_with_metrics$SJR_year <- as.numeric(split_data[[match("SJRList", split_names) + 1]][2])
        doi_with_metrics$SJR <- as.numeric(gsub("\\[|\\]|\\{|\\}", "", split_data[[match("SJRList", split_names) + 2]][2]))
        doi_with_metrics$CiteScore <- as.numeric(split_data[[match("citeScoreYearInfoList", split_names)]][3])
        doi_with_metrics$CiteScore_year <- as.numeric(split_data[[match("citeScoreCurrentMetricYear", split_names)]][2])
        # clean up the environment
        rm(raw_data)
      }
    },
    error = function(e) {
      if (!is.na(match(url, showConnections(all = TRUE)[, 1]) - 1)) {
        close(getConnection(match(url, showConnections(all = TRUE)[, 1]) - 1))
      }
      source_with_error <- c(source_with_error, df_scopus$issn[input])
    },
    finally = {
      
    }
  )
}
