broken_text <- text.2.break
for (j in 1:length(text.2.break)) {
  if (length(strsplit(text.2.break[j], split = " ")[[1]]) == 1) {
    broken_text[j] <- text.2.break[j]
  } else {
    k <- c()
    for (i in 1:length(strsplit(text.2.break[j], split = " ")[[1]])) {
      x <-
        nchar(paste0(strsplit(text.2.break[j], split = " ")[[1]][1:i], collapse = ""))
      k <- c(k, x)
    }
    index <- sum(k <= ceiling(nchar(text.2.break[j]) / 2))
    broken_text[j] <-
      paste0(paste(strsplit(text.2.break[j], split = " ")[[1]][1:index], collapse = " "),
             "\n",
             paste(strsplit(text.2.break[j], split = " ")[[1]][(index + 1):length(strsplit(text.2.break[j], split = " ")[[1]])], collapse = " "))
  }
}

