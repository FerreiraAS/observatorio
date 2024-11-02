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

texto <- paste0(
  "Citação:",
  "\n\n",
  if (has.dados.cadastrais) {nome.IES} else if (has.sucupira.files) {nome.IES} else {"(NOME DA IES)"},
  ". ",
  if (has.sucupira.files) {paste0("Quadrienal ", as.character(min(quadrienal.vigente)), "-", as.character(max(quadrienal.vigente)))} else {""},
  ". ",
  tryCatch(
    {
      # Attempt to get the page numbers from the PDF
      paste0(pdftools::pdf_info("docs/autoavaliacao.pdf")$pages, "p")
    },
    error = function(e) {
      # In case of an error, return "0p"
      "0p"
    }
  ),
  ". ",
  "Relatório de autoavaliação elaborado computacionalmente pelo Observatório do Programa disponível em ",
  yaml::read_yaml(file = "./_site.yml")$href,
  ". ",
  paste0("Atualizado em ", format(Sys.Date(), "%d/%m/%Y")),
  ". ",
  "\n\n",
  "<br>",
  "Arthur de Sá Ferreira. (2023). Observatório (v1.0.0). Zenodo. https://doi.org/10.5281/zenodo.8322622",
  ". "
)

# escape HTML character /
texto <- gsub("/", "&#47;", texto)

df <- data.frame(
  label = texto,
  x = 0,
  y = 1.5,
  hjust = 0,
  vjust = 1,
  orientation = "upright",
  color = "black",
  fill = "white",
  check.names = FALSE
)

ggplot2::ggplot(df) +
  ggplot2::aes(
    x,
    y,
    label = label,
    color = color,
    fill = fill,
    hjust = hjust,
    vjust = vjust,
    orientation = orientation
  ) +
  ggtext::geom_textbox(width = grid::unit(0.93, "npc"),
                       box.colour = "black") +
  ggplot2::scale_discrete_identity(aesthetics = c("color", "fill", "orientation")) +
  ggplot2::xlim(0, 8.27) + ggplot2::ylim(0, 11.69) +
  ggplot2::theme_void() +
  ggplot2::theme(
    legend.position = "none",
    panel.background = ggplot2::element_rect(fill = 'white', colour = 'white')
  )

ggplot2::ggsave(
    "PPG/Images/Cover-2.png",
    width = W,
    height = H,
    units = "in",
    dpi = 300
  )

# save PDF
grDevices::pdf(file = "PPG/Images/Cover-2.pdf",
               width = W,
               height = H)
img <- png::readPNG("PPG/Images/Cover-2.png")
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

# delete png file
unlink("PPG/Images/Cover-2.png")
