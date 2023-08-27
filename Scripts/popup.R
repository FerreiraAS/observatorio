# list of packages to manage
packs.cran <- c("svDialogs")

# loop for to install packages
for (i in 1:length(packs.cran)) {
  # install packages from CRAN
  if (!require(packs.cran[i], character.only = TRUE, quietly = TRUE))
    install.packages(packs.cran[i], character.only = TRUE)
}
# loop for to load packages
for (i in 1:length(packs.cran)) {
  # load required packages
  library(packs.cran[i], character.only = TRUE, quietly = TRUE)
}

# tentativas
max_tries <- 3

# nome
tries <- 0
correct_nome <- FALSE
while (tries < max_tries && !correct_nome) {
  # pop-up de digitação
  Nome <- dlgInput("Insira o nome:")$res
  # Verifica se está correto
  correct_nome <- length(Nome) != 0
  if (!correct_nome) {
    msgBox("Nenhum nome foi digitado, tente digitar novamente.")
    tries <- tries + 1
  }
  if (tries >= max_tries) {
    msgBox("Você excedeu o número máximo de tentativas.")
  }
}

# email
tries <- 0
correct_email <- FALSE
while (tries < max_tries && !correct_email) {
  # pop-up de digitação
  Email <- dlgInput("Insira o e-mail:")$res
  # Verifica se está correto
  correct_email <- grepl("@", Email)
  if (!correct_email) {
    msgBox("O formato de e-mail parece incorreto, tente digitar novamente.")
    tries <- tries + 1
  }
  if (tries >= max_tries) {
    msgBox("Você excedeu o número máximo de tentativas.")
  }
}

# site
tries <- 0
correct_site <- FALSE
while (tries < max_tries && !correct_site) {
  # pop-up de digitação
  Site <- dlgInput("Insira o site (formato https://):")$res
  # Verifica se está correto
  correct_site <- grepl("^https?://", Site)
  if (!correct_site) {
    msgBox("O formato do site parece incorreto, tente digitar novamente.")
    tries <- tries + 1
  }
  if (tries >= max_tries) {
    msgBox("Você excedeu o número máximo de tentativas.")
  }
}

# verifica se dispoe das informações corretas antes de salvar
df <- data.frame(Nome, Email, Site)
if (correct_email && correct_site) {
  message <- paste0("Os dados estão corretos?\n\n",
                    paste(names(df), df, collapse = "\n", sep = ": "))
  resultado <- dlg_message(message, type = c("yesno"))$res
  
  if (resultado == "no") {
    # Edite os valores digitados
    df$Nome <- dlgInput("Edite o nome:", Nome)$res
    df$Email <- dlgInput("Edite o e-mail:", Email)$res
    df$Site <- dlgInput("Edite o site (formato https://):", Site)$res
  }
  
  # especificar o caminho para a pasta onde você deseja salvar o arquivo
  caminho_arquivo <- file.path(getwd(), "dados.txt")
  write.table(df,
              caminho_arquivo,
              row.names = FALSE,
              col.names = TRUE,
              quote = FALSE,
              sep = "\t")
  
  if (file.exists(caminho_arquivo)) {
    # pop-up de confirmação da pasta criada
    msgBox("Dados armazenados com sucesso.")
  } else {
    warning("As informações não foram salvas. Repita o procedimento.")
  }
} else {
  warning("Dados incorretos. Tente novamente.")
}
