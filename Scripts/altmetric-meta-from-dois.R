# Required metadata for content tracking
# Source: https://help.altmetric.com/support/solutions/articles/6000240582-required-metadata-for-content-tracking

if (length(dois$DOI) != 0) {
  for (j in 1:length(dois$DOI)) {
    if (!is.na(dois$DOI[j])) {
      cat('<head>')
      cat('<meta name="citation_doi" content="doi:',
          dois$DOI[j],
          '"/>',
          sep = "")
      cat('<meta name="Doi" content="doi:', dois$DOI[j], '"/>', sep = "")
      cat('<meta name="DC.Identifier" content="doi:',
          dois$DOI[j],
          '"/>',
          sep = "")
      cat('<meta name="DC.DOI" content="doi:',
          dois$DOI[j],
          '"/>',
          sep = "")
      cat('<meta name="DC.Identifier.DOI" content="doi:',
          dois$DOI[j],
          '"/>',
          sep = "")
      cat('<meta name="DOIs" content="doi:', dois$DOI[j], '"/>', sep = "")
      cat('<meta name="bepress_citation_doi" content="doi:',
          dois$DOI[j],
          '"/>',
          sep = "")
      cat('<meta name="rft_id" content="doi:',
          dois$DOI[j],
          '"/>',
          sep = "")
      cat('</head>')
    }
  }
}