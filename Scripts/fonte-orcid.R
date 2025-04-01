if (knitr::is_html_output()){
  cat('\n\n')
}
cat('**Fontes**: [**Plataforma Sucupira**](https://sucupira.capes.gov.br/sucupira/)', sep = "")
cat(', ', sep = "")
cat('[**ORCID**](https://orcid.org)', sep = "")
cat('\n\n')
if (knitr::is_html_output()) {
  cat('<br><a style="float:right" href="#top"><b>Início &nbsp;</b>', fontawesome::fa('circle-arrow-up'), '</a><br>')
}