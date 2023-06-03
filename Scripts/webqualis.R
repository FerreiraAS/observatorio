# read QUALIS xlsx file (download from https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/veiculoPublicacaoQualis/listaConsultaGeralPeriodicos.jsf)
files.to.read <- list.files(
  file.path(getwd(), "Metrics", "Qualis"),
  pattern = "xlsx",
  full.names = TRUE,
  recursive = FALSE
)

qualis <-
  data.frame(readxl::read_excel(files.to.read),
             sheet = 1,
             col_types = c("text"))

qualis <- dplyr::select(qualis, "ISSN", "Título", "Estrato")

# estratos Qualis
estratos <- sort(unique(qualis$Estrato))
qualis.base <- table(qualis$Estrato) / length(qualis$Estrato) * 100
