sintese <- function(sucupira.list = NULL, ano = NULL) {
  # initialize results
  labels <- c(
    # 1.1.1
    'Ano',
    'Áreas de concentração', # OK
    'Linhas de pesquisa', # OK
    'Projetos de pesquisa', # OK
    # 1.1.2
    'Níveis de curso', # OK
    'Mestrado', # OK
    'Doutorado', # OK
    'Disciplinas (M)', # OK,
    'Disciplinas (D)', # OK,
    'Disciplinas obrigatórias (M)', # OK
    'Disciplinas obrigatórias (D)', # OK
    'Disciplinas eletivas (M)', # OK
    'Disciplinas eletivas (D)', # OK
    'Créditos totais (M)', # OK
    'Créditos totais (D)', # OK
    'Carga horária total (M)', # OK
    'Carga horária total (D)', # OK
    # 
    'Turmas (ofertas de disciplina)',
    'Projetos de Cooperação entre Instituições',
    'Docentes permanentes',
    'Docentes colaboradores',
    'Pós-docs',
    'Discentes maticulados (Grad/MSc/DSc)',
    'Alunos novos (Grad/MSc/DSc)',
    'Egressos (MSc/DSc)',
    'Dissertações',
    'Teses',
    'Artigos em periódicos',
    'Livros ou capítulos',
    'Trabalhos em anais de eventos',
    'Apresentações de trabalhos em eventos',
    'Cursos de curta duração',
    'Material didático e instrucional',
    'Organizações de eventos'
  )
  resultados <- matrix(0, nrow = 1, ncol = length(labels))
  resultados <- data.frame(resultados)
  colnames(resultados) <- labels
  
  resultados$'Ano' <- ano
  
  sucupira <- sucupira.list[[as.character(ano)]]
  
  # sintese 1.1.1 estrutura curricular
  try(resultados$'Áreas de concentração' <-
    nlevels(as.factor(sucupira$'Área de Concentração')), silent = TRUE)
  try(resultados$'Linhas de pesquisa' <-
    nlevels(as.factor(sucupira$'Linha de Pesquisa')), silent = TRUE)
  try(resultados$'Projetos de pesquisa' <-
    nlevels(as.factor(sucupira$'Nome do Projeto de Pesquisa')), silent = TRUE)
  
  # sintese 1.1.2 proposta curricular
  try(resultados$'Níveis de curso' <-
        nlevels(as.factor(sucupira$'Nível do Curso')), silent = TRUE)
  try(resultados$'Mestrado' <-
        nlevels(as.factor(sucupira$'Nível do Curso'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "mestrado")])), silent = TRUE)
  try(resultados$'Doutorado' <-
        nlevels(as.factor(sucupira$'Nível do Curso'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "doutorado")])), silent = TRUE)
  
  try(resultados$'Disciplinas (M)' <-
        nlevels(as.factor(sucupira$'Nome da Disciplina'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "mestrado")])), silent = TRUE)
  try(resultados$'Disciplinas (D)' <-
        nlevels(as.factor(sucupira$'Nome da Disciplina'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "doutorado")])), silent = TRUE)
  
  try(resultados$'Disciplinas obrigatórias (M)' <-
        sum(as.factor(sucupira$'Indicadora de disciplina obrigatória'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "mestrado")]) == 'Sim'), silent = TRUE)
  try(resultados$'Disciplinas obrigatórias (D)' <-
        sum(as.factor(sucupira$'Indicadora de disciplina obrigatória'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "doutorado")]) == 'Sim'), silent = TRUE)
  
  try(resultados$'Disciplinas eletivas (M)' <-
        sum(as.factor(sucupira$'Indicadora de disciplina obrigatória'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "mestrado")]) == 'Não'), silent = TRUE)
  try(resultados$'Disciplinas eletivas (D)' <-
        sum(as.factor(sucupira$'Indicadora de disciplina obrigatória'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "doutorado")]) == 'Não'), silent = TRUE)
  
  try(resultados$'Créditos totais (M)' <-
        sum(as.numeric(sucupira$'Quantidade de créditos'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "mestrado")])), silent = TRUE)
  try(resultados$'Créditos totais (D)' <-
        sum(as.numeric(sucupira$'Quantidade de créditos'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "doutorado")])), silent = TRUE)
  
  try(resultados$'Carga horária total (M)' <-
        sum(as.numeric(sucupira$'Carga Horária'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "mestrado")])), silent = TRUE)
  try(resultados$'Carga horária total (D)' <-
        sum(as.numeric(sucupira$'Carga Horária'[stringr::str_detect(tolower(sucupira$'Nível do Curso'), "doutorado")])), silent = TRUE)
  
  # output
  return(resultados)
}
