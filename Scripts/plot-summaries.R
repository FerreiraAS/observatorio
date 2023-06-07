for (i in 1:length(summ.data)) {
  plot(
    c(0, 1),
    c(0, 1),
    ann = F,
    bty = 'n',
    type = 'n',
    xaxt = 'n',
    yaxt = 'n'
  )
  text(
    x = 0.5,
    y = 0.6,
    labels = as.character(summ.data[i]),
    cex = 4.2,
    col = RColorBrewer::brewer.pal(n = 9, name = "Set3")[3]
  )
  text(
    x = 0.5,
    y = 0.2,
    labels = names(summ.data)[i],
    cex = 1.7,
    col = RColorBrewer::brewer.pal(n = 9, name = "Set3")[2]
  )
  box(lty = "solid",
      lwd = 15,
      col = RColorBrewer::brewer.pal(n = 9, name = "Set3")[1])
}
