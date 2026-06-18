libs <- c("curl", "xml2", "RSQLite", "uuid", "openxlsx")
try({
  # Load necessary libraries
  sapply(libs, function(lib) {
    library(lib, character.only = TRUE, quietly = TRUE)
  })
})
# If the libraries are not installed, install them
if (any(!libs %in% installed.packages())) {
  install.packages(libs[!libs %in% installed.packages()], repos = "https://cloud.r-project.org/")
  sapply(libs, function(lib) {
    library(lib, character.only = TRUE, quietly = TRUE)
  })
}

process_lattes_folder <- function(input_folder, output_folder, save_format = "flat-excel", output_filename = "lattes_parsed") {
  
  # Initialize empty data frames
  TBL_participacao <- data.frame(matrix(ncol = 2, nrow = 0), stringsAsFactors = FALSE)
  TBL_dados_basicos <- data.frame(matrix(ncol = 11, nrow = 0), stringsAsFactors = FALSE)
  TBL_detalhamento <- data.frame(matrix(ncol = 10, nrow = 0), stringsAsFactors = FALSE)
  TBL_participantes <- data.frame(matrix(ncol = 6, nrow = 0), stringsAsFactors = FALSE)
  TBL_informacoes_adicionais <- data.frame(matrix(ncol = 4, nrow = 0), stringsAsFactors = FALSE)
  TBL_setores_atividades <- data.frame(matrix(ncol = 3, nrow = 0), stringsAsFactors = FALSE)
  TBL_palavras_chave <- data.frame(matrix(ncol = 3, nrow = 0), stringsAsFactors = FALSE)
  TBL_area_conhecimento <- data.frame(matrix(ncol = 6, nrow = 0), stringsAsFactors = FALSE)
  
  # Get list of XML files
  xml_files <- list.files(path = input_folder, pattern = "\\.xml$", full.names = TRUE)
  
  if (length(xml_files) == 0) {
    stop("No XML files found in the specified folder.")
  }
  
  for (filepath in xml_files) {
#    print(paste("Processing file:", filepath))
    
    tryCatch({
      # Arquivo com o XML a ser lido
      file <- xml2::read_xml(filepath, encoding = "ISO-8859-1")
      # Nó que contém as informações de participação em bancas
      node <- xml2::xml_find_all(file, ".//PARTICIPACAO-EM-BANCA-TRABALHOS-CONCLUSAO")
      
      # iterate over each node
      for (table in node) {
        # Get the name of the table  ie the xml tag/node
        table_name <- xml2::xml_name(table)
        # get the table attributes, the data for the tables is in there.
        table_attrs <- xml2::xml_attrs(table)
        # get the inner nodes of the table, these are the nested tables
        inner_nodes <- xml2::xml_children(table)
        
        # Loop over the inner nodes/nested tables
        for (inner_table in inner_nodes) {
          # Get the name/tagname of the inner table
          inner_table_name <- xml2::xml_name(inner_table)
          # Get the attributes/data from the inner table
          inner_table_attrs <- xml2::xml_attrs(inner_table)
          
          # Generate a unique ID for the table
          table_id <- uuid::UUIDgenerate()
          
          # Every iteration will push the attributes of the inner table to the master table.
          TBL_participacao <- rbind(TBL_participacao, c(table_id, inner_table_attrs))
          
          # Get the children of the 2nd level table and iterate over them
          inner_table_children <- xml2::xml_children(inner_table)
          for (child_table in inner_table_children) {
            
            # If it has no children, we will just print the attributes of the child table
            if (length(xml2::xml_children(child_table)) == 0) {
              # Get the name of the child table
              child_table_name <- xml2::xml_name(child_table)
              # Get the attributes of the child table
              child_table_attrs <- xml2::xml_attrs(child_table)
              
              if (grepl("DADOS-BASICOS-DA-PARTICIPACAO-EM-BANCA", child_table_name, ignore.case = FALSE)) {
                if ("TIPO" %in% names(child_table_attrs)) {
                  TBL_dados_basicos <- rbind(TBL_dados_basicos, c(table_id, inner_table_attrs, child_table_attrs))
                } else {
                  fixing_child_table_attrs <- append(child_table_attrs, "N/A", after = 1)
                  TBL_dados_basicos <- rbind(TBL_dados_basicos, c(table_id, inner_table_attrs, fixing_child_table_attrs))
                }
              } else if (grepl("DETALHAMENTO-DA-PARTICIPACAO-EM-BANCA", child_table_name, ignore.case = FALSE)) {
                TBL_detalhamento <- rbind(TBL_detalhamento, c(table_id, inner_table_attrs, child_table_attrs))
              } else if (child_table_name == "PARTICIPANTE-BANCA") {
                TBL_participantes <- rbind(TBL_participantes, c(table_id, inner_table_attrs, child_table_attrs))
              } else if (child_table_name == "INFORMACOES-ADICIONAIS") {
                TBL_informacoes_adicionais <- rbind(TBL_informacoes_adicionais, c(table_id, inner_table_attrs, child_table_attrs))
              } else if (child_table_name == "SETORES-DE-ATIVIDADE") {
                for (attr in child_table_attrs) {
                  if (attr == "") next
                  TBL_setores_atividades <- rbind(TBL_setores_atividades, c(table_id, inner_table_attrs, attr))
                }
              } else if (child_table_name == "PALAVRAS-CHAVE") {
                for (attr in child_table_attrs) {
                  if (attr == "") next
                  TBL_palavras_chave <- rbind(TBL_palavras_chave, c(table_id, inner_table_attrs, attr))
                }
              }
            } else {
              # if the child has children, drill another level down
              child_table_children <- xml2::xml_children(child_table)
              for (bottom_child_table in child_table_children) {
                bottom_child_table_name <- xml2::xml_name(bottom_child_table)
                bottom_child_table_attrs <- xml2::xml_attrs(bottom_child_table)
                
                if (grepl("AREA-DO-CONHECIMENTO", bottom_child_table_name)) {
                  TBL_area_conhecimento <- rbind(TBL_area_conhecimento, c(table_id, inner_table_attrs, bottom_child_table_attrs))
                }
              }
            }
          }
        }
      }
    }, error = function(e) {
#      print(paste("Error processing file", filepath, ":", e$message))
    })
  }
  
  # Set the column names for each table
  # Note: We check if rows exist to avoid errors setting names on empty frames if no data found
  if (nrow(TBL_participacao) > 0) colnames(TBL_participacao) <- c("uuid", "sequencia")
  if (nrow(TBL_dados_basicos) > 0) colnames(TBL_dados_basicos) <- c("uuid", "sequencia", "natureza", "tipo", "titulo", "ano", "pais", "idioma", "homepage", "DOI", "titulo_ingles")
  if (nrow(TBL_detalhamento) > 0) colnames(TBL_detalhamento) <- c("uuid", "sequencia", "nome_candidato", "codigo_instituicao", "nome_instituicao", "codigo_orgao", "nome_orgao", "codigo_curso", "nome_curso", "nome_curso_ingles")
  if (nrow(TBL_participantes) > 0) colnames(TBL_participantes) <- c("uuid", "sequencia", "nome_completo", "nome_citacao", "ordem", "NRO_ID_CNPQ")
  if (nrow(TBL_informacoes_adicionais) > 0) colnames(TBL_informacoes_adicionais) <- c("uuid", "sequencia", "descricao", "descricao_ingles")
  if (nrow(TBL_setores_atividades) > 0) colnames(TBL_setores_atividades) <- c("uuid", "sequencia", "setor_atividade")
  if (nrow(TBL_palavras_chave) > 0) colnames(TBL_palavras_chave) <- c("uuid", "sequencia", "palavra_chave")
  if (nrow(TBL_area_conhecimento) > 0) colnames(TBL_area_conhecimento) <- c("uuid", "sequencia", "grande_area", "area", "subarea", "especialidade")
  
  # Ensure output directory exists
  if (!dir.exists(output_folder)) {
    dir.create(output_folder, recursive = TRUE)
  }
  
  # Save logic
  if (save_format == "csv") {
    write.csv(TBL_participacao, file.path(output_folder, "TBL_participacao.csv"), row.names = FALSE)
    write.csv(TBL_dados_basicos, file.path(output_folder, "TBL_dados_basicos.csv"), row.names = FALSE)
    write.csv(TBL_detalhamento, file.path(output_folder, "TBL_detalhamento.csv"), row.names = FALSE)
    write.csv(TBL_participantes, file.path(output_folder, "TBL_participantes.csv"), row.names = FALSE)
    write.csv(TBL_informacoes_adicionais, file.path(output_folder, "TBL_informacoes_adicionais.csv"), row.names = FALSE)
    write.csv(TBL_setores_atividades, file.path(output_folder, "TBL_setores_atividades.csv"), row.names = FALSE)
    write.csv(TBL_palavras_chave, file.path(output_folder, "TBL_palavras_chave.csv"), row.names = FALSE)
    write.csv(TBL_area_conhecimento, file.path(output_folder, "TBL_area_conhecimento.csv"), row.names = FALSE)
    
  } else if (save_format == "rsqlite") {
    db_path <- file.path(output_folder, paste0(output_filename, ".db"))
    db <- DBI::dbConnect(RSQLite::SQLite(), db_path)
    DBI::dbWriteTable(db, "TBL_participacao", TBL_participacao, overwrite = TRUE)
    DBI::dbWriteTable(db, "TBL_dados_basicos", TBL_dados_basicos, overwrite = TRUE)
    DBI::dbWriteTable(db, "TBL_detalhamento", TBL_detalhamento, overwrite = TRUE)
    DBI::dbWriteTable(db, "TBL_participantes", TBL_participantes, overwrite = TRUE)
    DBI::dbWriteTable(db, "TBL_informacoes_adicionais", TBL_informacoes_adicionais, overwrite = TRUE)
    DBI::dbWriteTable(db, "TBL_setores_atividades", TBL_setores_atividades, overwrite = TRUE)
    DBI::dbWriteTable(db, "TBL_palavras_chave", TBL_palavras_chave, overwrite = TRUE)
    DBI::dbWriteTable(db, "TBL_area_conhecimento", TBL_area_conhecimento, overwrite = TRUE)
    DBI::dbDisconnect(db)
    
  } else if (save_format == "flat-excel") {
    tables_list <- list(
      TBL_participacao = TBL_participacao,
      TBL_dados_basicos = TBL_dados_basicos,
      TBL_detalhamento = TBL_detalhamento,
      TBL_participantes = TBL_participantes,
      TBL_informacoes_adicionais = TBL_informacoes_adicionais,
      TBL_setores_atividades = TBL_setores_atividades,
      TBL_palavras_chave = TBL_palavras_chave,
      TBL_area_conhecimento = TBL_area_conhecimento
    )
    
    # Filter out empty tables to avoid merge errors
    tables_list <- tables_list[sapply(tables_list, nrow) > 0]
    
    if (length(tables_list) > 0) {
      master_df <- Reduce(function(x, y) merge(x, y, by = c("uuid", "sequencia"), all.x = TRUE), tables_list)
      # replace "N/A" with NA
      master_df[master_df == "N/A"] <- NA
      
#      openxlsx::write.xlsx(master_df, file = file.path(output_folder, paste0(output_filename, ".xlsx")), rowNames = FALSE)
    } else {
#      print("No data found to write to Excel.")
    }
  }
  
  return(master_df)
}
