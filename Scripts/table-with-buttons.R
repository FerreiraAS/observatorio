create_dt <- function(x, title, pageLength = 4) {
  DT::datatable(
    x,
    rownames = FALSE,
    extensions = c('Buttons', 'ColReorder', 'Responsive'),
    options = list(
      colReorder = TRUE,
      pageLength = pageLength,
      scrolX = F,
      dom = 'Bftip',
      searchHighlight = TRUE,
      buttons = list(
        list(extend = "copy"),
        list(extend = "csv"),
        list(
          extend = 'pdf',
          title = title,
          filename = title
        )
      )
    ),
    escape = FALSE
  )
}
