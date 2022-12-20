abbrev <- c()
for (i in 1:length(data.to.abbrev)) {
  data.abbr <-
    paste0(substr(strsplit(
      gsub('\\b\\w{1,2}\\b', '', data.to.abbrev[i]), split = " "
    )[[1]], 1, 1), collapse = "")
  abbrev <- c(abbrev, data.abbr)
}