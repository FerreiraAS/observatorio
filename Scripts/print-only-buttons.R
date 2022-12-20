print_buttons_dt <- function(x, title) {
  DT::datatable(
    x,
    extensions = 'Buttons',
    options = list(
      pageLength = 0,
      scrolX = F,
      dom = 'B',
      buttons = list(
        list(extend = "copy"),
        list(extend = "csv"),
        list(
          extend = 'pdf',
          title = title,
          filename = title
        )
      ),
      searchHighlight = FALSE,
      headerCallback = JS("function(thead, display){",
                          "$(thead).remove();",
                          "}")
    ),
    escape = FALSE
  )
}