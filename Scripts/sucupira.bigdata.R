options(pillar.sigfig = 5)

# list excel files in the current directory
folders <- list.dirs(file.path("./Sucupira"), full.names = FALSE, recursive = FALSE)
files <- list.files(file.path("./Sucupira"), pattern = '*.xlsx', full.names = TRUE, recursive = TRUE)

get_file <- function (file, sheet = NULL){
  return(
    readxl::read_xlsx(file, sheet, col_types = "text")
  )
}

get_sheet_names <- function(file){
  return(readxl::excel_sheets(file))
}

big_dataframe <- function(file_path, dir_name) {
  
  sheet_names <- get_sheet_names(file_path)
  
  TODAS_AS_FOLHAS_EM_UMA_TABELA <- c()
  
  for(sheet in sheet_names) {
    temp_efr <- get_file(file_path, sheet)
    TODAS_AS_FOLHAS_EM_UMA_TABELA <- dplyr::bind_rows(TODAS_AS_FOLHAS_EM_UMA_TABELA,temp_efr)
  }
  
  add_dir_name_to_table_first_col <- function(){
    return(
      dplyr::bind_cols(as.matrix(data.frame(dir_name)), TODAS_AS_FOLHAS_EM_UMA_TABELA)
    )
  }
  
  return(
    add_dir_name_to_table_first_col()
  )
}

even_bigger_dataframe <- function (files, folders){
  
  tabelao <- c()
  for (index in 1:length(folders) ){
    # print(folders[index])
    temp_df <- big_dataframe(files[index],folders[index])
    tabelao <- dplyr::bind_rows(tabelao, temp_df)
  }
  return(tabelao)
}

tabelao <- even_bigger_dataframe(files,folders)


write_fun <- function (payload, dir_path, filename){
  tryCatch({
    openxlsx::write.xlsx(payload,
                         file = file.path(dir_path, filename),
                         rowNames = TRUE,
                         overwrite = TRUE)
    return (TRUE)
  },
  error = function(e){
    message('Houve um erro na gravação do arquivo.')
    print(e)
    return(FALSE)
  },
  warning = function(e){
    message('Aviso!')
    print(e)
    return(FALSE)
  }
  )
}

write_to_file <- function (payload, filepath,filename, flag = 'seguro') {
  
  if(file.exists(file.path(filepath,filename)) && flag == 'sobreescrever'){
    file_was_written <- write_fun(payload, filepath, filename)
  }
  else if(file.exists(file.path(filepath, filename)) && flag == 'seguro') {
    message('Arquivo já existe, esta operação irá sobreescrevê-lo, se for o caso utilize o parâmetro \'sobreescrever\' ')
    return(NULL)
  }
  else {
    new_file <- file.create(file.path(filepath, filename))
    if(new_file){
      file_was_written <- write_fun(payload, filepath, filename)
    } else{
      print('Houve erro na criação do arquivo.')
      return(NULL)
    }
  }
  if (file_was_written){
    message('Operação realizada com sucesso!')
  } else {
    message('Algo de errado acontece.')
  }
  
}
output_path <- paste(getwd())
file_name <- 'tabelao_conferencia_programa.xlsx'

# write_to_file(tabela, output_path,file_name, flag = 'seguro')
# write_to_file(tabelao, output_path,file_name, flag = 'sobreescrever')
# 'Lembre-se de fechar o arquivo antes de executar o script, ou será lançado um warning the permissão negada.'
# 
# Referência
# 'https://stackoverflow.com/questions/44464441/
#   r-is-there-a-good-replacement-for-plyrrbind-fill-in-dplyr'
