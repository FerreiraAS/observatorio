W <- 8.27
H <- 11.69

grDevices::png(
  file = "PPG/Images/Cover_1.png",
  width = W,
  height = H,
  units = "in",
  res = 300
)
par(
  mar = c(0, 0, 0, 0),
  oma = c(0, 0, 0, 0),
  omi = c(0, 0, 0, 0),
  mai = c(0, 0, 0, 0),
  bg = "black"
)
plot(
  1,
  type = "n",
  xlab = "",
  ylab = "",
  xlim = c(0, W),
  ylim = c(0, H)
)

# IES name
if (as.logical(has.dados.cadastrais)) {
  label.IES <- nome.IES
} else {
  label.IES <- ""
}
text(
  x = W,
  y = H - 0.5,
  labels = label.IES,
  pos = 2,
  cex = 2,
  col = "white"
)

# book subtitle
if (as.logical(has.dados.cadastrais)) {
  label.PPG <- nome.PPG
} else {
  label.PPG <- ""
}
text(
  x = W,
  y = H - 1.0,
  labels = label.PPG,
  pos = 2,
  cex = 1.5,
  col = "white"
)

# periodo
if (as.logical(has.sucupira.files)) {
  label.quad <-
    paste0("Quadrienal ", as.character(min(quadrienal.vigente)), "-", as.character(max(quadrienal.vigente)))
} else {
  label.quad <- ""
}
text(
  x = W,
  y = H / 2 + 2 - 0.0,
  labels = label.quad,
  pos = 2,
  cex = 2.5,
  col = "yellow"
)

# book title
text(
  x = W,
  y = H / 2 + 2 - 1.0,
  labels = "Autoavaliação",
  pos = 2,
  cex = 6.5,
  col = "yellow"
)

# year
text(
  x = W / 2,
  y = 0,
  labels = paste0("Atualizado em ", format(Sys.Date(), "%m/%Y")),
  adj = c(0.5, 0.5),
  cex = 1.0,
  col = "white"
)

grDevices::dev.off()

# save PDF
grDevices::pdf(file = "PPG/Images/Cover_1.pdf",
               width = W,
               height = H)
img <- png::readPNG("PPG/Images/Cover_1.png")
img <- grDevices::as.raster(img[, , 1:3])
par(
  mar = c(0, 0, 0, 0),
  oma = c(0, 0, 0, 0),
  omi = c(0, 0, 0, 0),
  mai = c(0, 0, 0, 0),
  bg = "black"
)
plot(img)
grDevices::dev.off()