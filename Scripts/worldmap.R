paises_dataset <-
  as.data.frame(readxl::read_excel(
    file.path(
      "Metrics",
      "Países",
      "paises_e_territorios_codigos_e_abreviacoes.xls"
    ),
    sheet = 1,
    col_types = c("text")
  )) %>%
  dplyr::mutate(dplyr::across(tidyselect::everything(), as.character))

paises_alpha3  <-
  paises_dataset$`Código ISO ALPHA-3`[match(paises$Var1, paises_dataset$`Nome do país ou território`)]

worldmap <- ggplot2::map_data("world")

worldmap$iso3c <- maps::iso.alpha(x = worldmap$region, n = 3)

worldmap$Freq <- rep(0, times = length(worldmap$iso3c))

for (c in 1:dim(worldmap)[1]) {
  if (!is.na(match(worldmap$iso3c[c], paises_alpha3))) {
    worldmap$Freq[c] <-
      paises$Freq[match(worldmap$iso3c[c], paises_alpha3)]
  }
}
