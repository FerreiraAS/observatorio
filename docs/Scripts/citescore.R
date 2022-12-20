# load list of Sucupira files to read
files.to.read <- list.files(
  file.path(getwd(), "Metrics", "CiteScore"),
  pattern = "xlsx",
  full.names = TRUE,
  recursive = FALSE
)

# read CiteScore csv file (download from https://www.scimagojr.com)
citescore <-
  read_excel(files.to.read, sheet = 1)
citescore <- janitor::clean_names(citescore)

# get columns
columns_to_grab <-
  c(
    "sourcerecord_id",
    "source_title_medline_sourced_journals_are_indicated_in_green",
    "print_issn",
    "e_issn",
    "x2021_cite_score",
    "coverage"
  )

# initialize dataframe
citescore <- citescore %>% dplyr::select(all_of(columns_to_grab))
citescore <- as.data.frame(citescore)

# calculate percentile value
perc <- c()
distr <- ecdf(as.numeric(na.omit(citescore$x2021_cite_score)))
for (i in 1:length(citescore$x2021_cite_score)) {
  perc <- c(perc, distr(citescore$x2021_cite_score[i]))
}
citescore$percentile <- perc

# merge at least one ISSN to each journal to search for in the CSV provided by SCImago
issns <- matrix(NA, nrow = dim(citescore)[1])
# initialize with latest ISSN vector if available
if (length(citescore$print_issn) != 0) {
  issns <- citescore$print_issn
}
# try replacing with first issn (print)
if (length(citescore$print_issn) != 0) {
  issns[is.na(issns)] <- citescore$print_issn[is.na(issns)]
}
# try replacing with second issn (online)
if (length(citescore$print_issn) != 0) {
  issns[is.na(issns)] <- citescore$e_issn[is.na(issns)]
}
citescore$issn <- issns

# replace 'ongoing' by current year
citescore$coverage <-
  gsub("ongoing", format(Sys.time(), "%Y"), citescore$coverage)
# get last year of the last coverage period
citescore$last_coverage <- substr(citescore$coverage, 6, 9)

# if coverage is ongoing, last update was last year
citescore$last_coverage[citescore$last_coverage == format(Sys.time(), "%Y")] <-
  as.character(as.numeric(format(Sys.time(), "%Y")) - 1)
