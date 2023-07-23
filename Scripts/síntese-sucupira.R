sintese <- function(sucupira.list = NULL, ano = NULL) {
  # initialize results
  labels <- c(
    'Ano',
    'Áreas de concentração', # OK
    'Linhas de pesquisa', # OK
    'Projetos de pesquisa', # OK
    'Disciplinas ativas', # OK
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
  try(resultados$'Nível do Curso' <-
        nlevels(as.factor(sucupira$'Nível do Curso')), silent = TRUE)
  try(resultados$'Nome da Disciplina' <-
        nlevels(as.factor(sucupira$'Nome da Disciplina')), silent = TRUE)
  try(resultados$'Indicadora de disciplina obrigatória' <-
        nlevels(as.factor(sucupira$'Indicadora de disciplina obrigatória')), silent = TRUE)
  try(resultados$'Quantidade de créditos' <-
        nlevels(as.factor(sucupira$'Quantidade de créditos')), silent = TRUE)
  try(resultados$'Carga Horária' <-
        nlevels(as.factor(sucupira$'Carga Horária')), silent = TRUE)
  
  # output
  return(resultados)
}
