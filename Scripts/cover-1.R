W <- 8.27
H <- 11.69

# define font family
extrafont::loadfonts(device = "all")

grDevices::quartzFonts(
  ComputerModern = c(
    "Computer Modern",
    "Computer Modern Bold",
    "Computer Modern Oblique",
    "Computer Modern BoldOblique"
  )
)
par(family = 'ComputerModern')

grDevices::png(
  file = "PPG/Images/Cover-1.png",
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
  bg = "white"
)
plot(
  1,
  type = "n",
  xlab = "",
  ylab = "",
  xlim = c(0, W),
  ylim = c(0, H)
)

# IES log
try(logo <-
      logo <- magick::image_read("PPG/Images/logo-programa.png"),
    silent = TRUE)
# resize png file
if (exists("logo")) {
  logo <- magick::image_scale(logo, "x50")
  size <- magick::image_info(logo)[c("height", "width")] / 72
}
if (exists("logo")) {
  rasterImage(
    logo,
    ytop = H,
    ybottom = H - size[1],
    xleft = W,
    xright = W - size[2],
    interpolate = FALSE
  )
}

# IES name
if (has.dados.cadastrais) {
  label.IES <- nome.IES
} else {
  label.IES <- ""
}
text(
  x = W,
  y = H - 1.0,
  labels = label.IES,
  pos = 2,
  cex = 1.5,
  col = "black"
)

# book subtitle
if (has.dados.cadastrais) {
  label.PPG <- nome.PPG
} else {
  label.PPG <- ""
}
text(
  x = W,
  y = H - 1.5,
  labels = label.PPG,
  pos = 2,
  cex = 1.0,
  col = "black"
)

# periodo
if (has.sucupira.files) {
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
  col = "black"
)

# book title
text(
  x = W,
  y = H / 2 + 2 - 1.0,
  labels = "Autoavaliação",
  pos = 2,
  cex = 6.5,
  col = "black"
)

# year
text(
  x = W / 2,
  y = 0,
  labels = paste0("Atualizado em ", format(Sys.Date(), "%m/%Y")),
  adj = c(0.5, 0.5),
  cex = 1.0,
  col = "black"
)

grDevices::dev.off()

# save PDF
grDevices::pdf(file = "PPG/Images/Cover-1.pdf",
               width = W,
               height = H)
img <- png::readPNG("PPG/Images/Cover-1.png")
img <- grDevices::as.raster(img[, , 1:3])
par(
  mar = c(0, 0, 0, 0),
  oma = c(0, 0, 0, 0),
  omi = c(0, 0, 0, 0),
  mai = c(0, 0, 0, 0),
  bg = "white"
)
plot(img)
grDevices::dev.off()
