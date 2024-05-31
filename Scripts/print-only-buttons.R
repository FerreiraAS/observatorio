print_buttons_dt <- function(x, title) {
  DT::datatable(
    x,
    caption = format(Sys.Date(), "%d/%m/%Y"),
    rownames = FALSE,
    extensions = c('Buttons'),
    options = list(
      colReorder = FALSE,
      pageLength = 0,
      scrolX = F,
      dom = 'B',
      searchHighlight = FALSE,
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
      headerCallback = JS("function(thead, display){",
                          "$(thead).remove();",
                          "}")
    ),
    escape = FALSE
  )
}

# source
# https://github.com/DataTables/Plugins/blob/master/i18n/pt-BR.json

