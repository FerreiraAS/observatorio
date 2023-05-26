# Observatório

## O Observatório é uma iniciativa que envolve o registro, o acompanhamento e a análise agregada e estruturada de dados de Programas de Pós-graduaçào Stricto Sensu do Brasil para divulgação transparente de suas atividades, planejamentos, ações e impactos, tornando-os acessíveis à sociedade

Sumário
=================
<!--ts-->
   * [Instalação](#instalacao)
   * [Como usar](#como-usar)
      * [Pré-requisitos](#pre-requisitos)
   * [Conteúdo](#conteudo)
   * [Recursos computacionais](#recursos)
<!--te-->

## Conteúdo

- [x] Programa
- [x] Pessoas
- [x] Produções
- [x] Destaques
- [x] Impactos
- [x] Galeria
- [x] Autoavaliação
- [x] Área

### Recursos computacionais

As seguintes ferramentas foram usadas na construção do projeto. Antes de começar, você vai precisar instalar em sua máquina as seguintes ferramentas:

- [R project](https://www.r-project.org)
- [Rstudio desktop](https://posit.co/download/rstudio-desktop/)

### Pré-requisitos

O Observatório utiliza arquivos exportados pela [Plataforma Sucupira](https://sucupira.capes.gov.br/sucupira/). Para gerar os arquivos, siga as seguintes etapas:

1. Crie uma pasta de nome "Sucupira" no seu computador
2. Na pasta "Sucupira", crie uma pasta para cada ano que o Programa possui dados disponíveis na Plataforma Sucupira (2012 em diante). O nome da pasta será o ano correspondente aos dados (ex.: "2023")
3. Acesse a [Plataforma Sucupira](https://sucupira.capes.gov.br/sucupira/)
4. Clique no ícone "ACESSO RESTRITO" e faça login
5. Clique no ícone "Coordenador de PPG" para acesse o conteúdo
6. No menu "Relatórios", clique no ícone "Conferência de Programa"

Para cada ano de atividade do Programa, repita os seguintes passos:
1. No item "Categoria", mantenha a opção padrão "-- SELECIONE --"
2. Selecione o ano que deseja exportar os dados
3. Clique em "Gerar excel único com os dados do programa"
4. Na nova aba aberta, aparecerá a mensagem "Por favor, aguarde enquanto o relatório está sendo gerado". Após a compilação dos dados, clique em "Clique aqui para realizar o download"
5. Feche a nova aba e retorne à página principal da Plataforma Sucupira
6. Abra o arquivo "conferencia_programa.xls" e salve em formato XLSX (ex.: "conferencia_programa.xlsx")
7. Mova o arquivo "conferencia_programa.xlsx" para a pasta do ano corrspondente
8. Delete o arquivo original "conferencia_programa.xls"
