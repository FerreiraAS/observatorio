# for reproducibility
set.seed(0)

# create a corpus
docs <- tm::Corpus(tm::VectorSource(data.to.cloud))
docs <- tm::tm_map(docs, tm::content_transformer(tolower))
if (clean.text == TRUE) {
  # cleaning text
  docs <- tm::tm_map(docs, tm::removeWords, tm::stopwords("portuguese"))
  docs <- tm::tm_map(docs, tm::removeWords, tm::stopwords("english"))
  docs <- tm::tm_map(docs, tm::removePunctuation)
  docs <- tm::tm_map(docs, tm::removeNumbers)
  docs <- tm::tm_map(docs, tm::stripWhitespace)
  # create a document-term matrix
  dtm <- tm::TermDocumentMatrix(docs)
  matrix <- as.matrix(dtm)
  words <- sort(rowSums(matrix), decreasing = TRUE)
  df <- data.frame(word = names(words), freq = words)
  # set minimum word frequency
  df <- df[df$freq >= 1, ]
} else {
  # count the frequency of each term
  words <- sort(table(tolower(data.to.cloud)), decreasing = TRUE)
  df <- data.frame(word = names(words), freq = as.numeric(words))
  rownames(df) <- names(words)
  # replace frequencies by rank order
  df$freq <- rank(df$freq, ties.method = "first")
}

# ensure produção bibliográfica e técnica are displayed
n.max <- 100
if (nrow(df) > n.max) {
  df <- df[1:n.max, ]
}

# generate word cloud using ggplot
wordcloud <-
  ggplot2::ggplot(df, ggplot2::aes(
  label = word,
  size = freq,
  color = factor(as.character(freq))
  )) +
  ggwordcloud::geom_text_wordcloud(
    rm_outside = TRUE,
    max_steps = 1,
    grid_size = 1,
    eccentricity = .9
  ) +
  ggplot2::scale_size_area(max_size = 10) +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    plot.margin = ggplot2::unit(c(0.5, 0, 0, 0), "cm"),
    panel.background = ggplot2::element_rect(fill = main.color, color = main.color),
    plot.background = ggplot2::element_rect(fill = main.color, color = main.color),
    panel.grid.major = ggplot2::element_line(color = "transparent"),
    axis.text.x = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_blank(),
    plot.title = ggplot2::element_text(
      hjust = 0.5,
      size = 11,
      color = "white",
      face = "bold"
    ),
    text = ggplot2::element_text(color = "white")
  ) +
  ggplot2::scale_color_brewer(palette = "Blues", direction = -1) +
  ggplot2::ggtitle(cloud.title)
