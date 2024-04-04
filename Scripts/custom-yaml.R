# read YAML file
header_in <- yaml::read_yaml("_site.yml")

# get items from header
observatorio_capes <- header_in$navbar$left[[11]]$href
email <- header_in$navbar$left[[12]]$menu[[1]]$href
site <- header_in$navbar$left[[12]]$menu[[2]]$href
instagram <- header_in$navbar$left[[12]]$menu[[3]]$href
facebook <- header_in$navbar$left[[12]]$menu[[4]]$href
observatorio_href <- header_in$href

# create list
form <-
  list(
    "observatorio_capes" = observatorio_capes,
    "email" = email,
    "site" = site,
    "instagram" = instagram,
    "facebook" = facebook,
    "observatorio_href" = observatorio_href
  )

# TRANSFORMAR ESSE BLOCO EM POPUP (1 SÓ OU MÚLTIPLOS SE NÃO DER)
# edit the list
form$observatorio_capes <- "TESTE"
form$email <- "TESTE"
form$site <- "TESTE"
form$instagram <- "TESTE"
form$facebook <- "TESTE"
form$observatorio_href <- "TESTE"

# CHECK IF THE FORM
data <- svDialogs::dlg_form(
  form,
  title = "Formulário",
  columns = 1,
  gui = .GUI
  )
form <- data$res

# replace elements from the list
header_out <- header_in

header_out$navbar$left[[11]]$href <- form$observatorio_capes
header_out$navbar$left[[12]]$menu[[1]]$href <- form$email
header_out$navbar$left[[12]]$menu[[2]]$href <- form$site
header_out$navbar$left[[12]]$menu[[3]]$href <- form$instagram
header_out$navbar$left[[12]]$menu[[4]]$href <- form$facebook
header_out$href <- form$observatorio_href

# save the list
yaml::write_yaml(header_out, "_site_out.yml", indent = 2)
