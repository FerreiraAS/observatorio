get_id_metadata <- function (id, subtipo, produtos.detalhes) {
  # initialize detalhamento
  detalhamento <- ""
  
  # select products
  produtos.detalhes <- produtos.detalhes[produtos.detalhes$`ID da Produção` == id, ]
  
  # remove rows with NA all columns
  produtos.detalhes <- produtos.detalhes[!rowSums(is.na(produtos.detalhes)) == ncol(produtos.detalhes), ]
  
  # get metadata from ARTIGO EM PERIÓDICO
  if (subtipo == "ARTIGO EM PERIÓDICO") {
    # get metadata
    Periódico <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "ISSN / Título do periódico"]
    Periódico <- toupper(tolower(Periódico))
    Volume <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Volume"]
    Fascículo <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Fascículo"]
    Série <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Série"]
    Inicial <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número da página inicial"]
    Final <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número da página final"]
    DOI <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número do DOI"]

    # paste all information as detalhamento
    detalhamento <-
      paste0(
        paste0("<b>", Periódico, "</b>"),
        if(!sjmisc::is_empty(Volume)) paste0(", V. ", Volume),
        if(!sjmisc::is_empty(Fascículo)) paste0(", N. ", Fascículo),
        if(!sjmisc::is_empty(Série)) paste0(", Série ", Série),
        if(!sjmisc::is_empty(Inicial) & sjmisc::is_empty(Final)) paste0(", p. ", Inicial),
        if(!sjmisc::is_empty(Final)) paste0("-", Final),
        if(!sjmisc::is_empty(DOI)) paste0(", DOI: ", " <a href='", "https://doi.org/", DOI, "' target='_blank'>", DOI, "</a>")
      )
  }
  
  # get metadata from EDITORIA
  if(subtipo == "EDITORIA") {
    # get metadata
    Natureza <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Natureza"]
    Promotora <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Instituição promotora"]
    Promotora <- toupper(tolower(Promotora))
    Editora <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Editora"]
    Tipo <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Tipo"]
    Páginas <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número de páginas"]
    DOI <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número do DOI"]
    
    # paste all information as detalhamento
    detalhamento <-
      paste0(
        paste0("<b>", Natureza, "</b>"),
        if(!sjmisc::is_empty(Promotora)) paste0(", ", Promotora),
        if(!sjmisc::is_empty(Editora)) paste0(", ", Editora),
        if(!sjmisc::is_empty(Tipo)) paste0(", ", Tipo),
        if(!sjmisc::is_empty(Páginas)) paste0(", ", Páginas, " p."),
        if(!sjmisc::is_empty(DOI)) paste0(", DOI: ", " <a href='", "https://doi.org/", DOI, "' target='_blank'>", DOI, "</a>")
      )
  }
  
  # get metadata from LIVRO
  if(subtipo == "LIVRO") {
    # get metadata
    Obra <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Título da Obra"]
    Páginas.Obra <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número de páginas da Obra"]
    Contribuição <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Tipo da Contribuição na Obra"]
    Páginas.Contribuição <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número de Páginas da Contribuição na Obra"]
    Editora <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Editora"]
    ISBN <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "ISBN"]
    URL <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "URL"]
    
    # paste all information as detalhamento
    detalhamento <-
      paste0(
        paste0("<b>", Obra, "</b>"),
        if(!sjmisc::is_empty(Páginas.Obra)) paste0(", ", Páginas.Obra, " p."),
        if(!sjmisc::is_empty(Contribuição)) paste0(", ", Contribuição),
        if(!sjmisc::is_empty(Páginas.Contribuição)) paste0(", ", Páginas.Contribuição, " p."),
        if(!sjmisc::is_empty(Editora)) paste0(", ", Editora),
        if(!sjmisc::is_empty(ISBN)) paste0(", ISBN: ", ISBN),
        if(!sjmisc::is_empty(URL)) paste0(", <a href='", URL, "' target='_blank'>", URL, "</a>")
      )
  }
  
  # get metadata from TRABALHO EM ANAIS
  if(subtipo == "TRABALHO EM ANAIS") {
    # get metadata
    Evento <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Nome do evento"]
    Título <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Título dos Anais"]
    País <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "País"]
    Volume <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Volume"]
    Fascículo <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Fascículo"]
    Série <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Série"]
    Inicial <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número da página inicial"]
    Final <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "Número da página final"]
    ISBN <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "ISBN/ISSN"]
    URL <- produtos.detalhes$`Valor do Item de Detalhamento`[produtos.detalhes$`Item de Detalhamento` == "URL"]
    
    # paste all information as detalhamento
    detalhamento <-
      paste0(
        paste0("<b>", Evento, "</b>"),
        if(!sjmisc::is_empty(Título)) paste0(", ", Título),
        if(!sjmisc::is_empty(País)) paste0(", ", País),
        if(!sjmisc::is_empty(Volume)) paste0(", ", Volume),
        if(!sjmisc::is_empty(Fascículo)) paste0(", ", Fascículo),
        if(!sjmisc::is_empty(Série)) paste0(", ", Série),
        if(!sjmisc::is_empty(Inicial) & sjmisc::is_empty(Final)) paste0(", p. ", Inicial),
        if(!sjmisc::is_empty(Final)) paste0("-", Final),
        if(!sjmisc::is_empty(ISBN)) paste0(", ISBN: ", ISBN),
        if(!sjmisc::is_empty(URL)) paste0(", <a href='", URL, "' target='_blank'>", URL, "</a>")
      )
  }
  
  # return data
  return(list(detalhamento = detalhamento))
}
