create_dt <- function(x, title, pageLength = 4) {
  DT::datatable(
    x,
    caption = format(Sys.Date(), "%d/%m/%Y"),
    rownames = FALSE,
    extensions = c('Buttons', 'Responsive'),
    options = list(
      colReorder = FALSE,
      pageLength = pageLength,
      width = "100%",
      scrollX = F,
      dom = 'Bftip',
      searchHighlight = TRUE,
      buttons = list(
        list(
          extend = "copy",
          text = "Copiar",
          filename = title
        ),
        list(
          extend = "csv",
          text = "CSV",
          filename = title
        ),
        list(
          extend = 'pdf',
          text = "PDF",
          title = title,
          filename = title
        )
      ),
      language = list(
        'info' = "Mostrando de _START_ até _END_ de _TOTAL_",
        'zeroRecords' = "Nenhum registro encontrado",
        'search' = "Pesquisar",
        paginate =
          list(
            'next' = "Próximo",
            'previous' = "Anterior"
          )
      )
    ),
    escape = FALSE
  )
}

# source
# https://github.com/DataTables/Plugins/blob/master/i18n/pt-BR.json
