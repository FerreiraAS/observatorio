create_dt <- function(x, title, pageLength = 4) {
  DT::datatable(
    x,
    caption = format(Sys.Date(), "%d/%m/%Y"),
    rownames = FALSE,
    extensions = c('Buttons', 'ColReorder', 'Responsive'),
    options = list(
      colReorder = TRUE,
      pageLength = pageLength,
      scrolX = F,
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
      language = list(paginate =
                        list(
                          'next' = "Próximo",
                          'previous' = "Anterior"
                        ))
    ),
    escape = FALSE
  )
}
