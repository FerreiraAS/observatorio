# Observatório

## O **Observatório** é uma iniciativa que envolve o registro, o acompanhamento e a análise agregada e estruturada de dados de Programas de Pós-graduaçào Stricto Sensu do Brasil para divulgação transparente de suas atividades, planejamentos, ações e impactos, tornando-os acessíveis à sociedade

Sumário
=================
<!--ts-->
   * [Conteúdo](#conteudo)
   * [Recursos computacionais](#recursos)
   * [Pré-requisitos](#pre-requisitos)
   * [Infomações complementares](#complementos)
   * [Fontes externas](#fontes-externas)
   * [Instalação](#instalacao)
   * [Como usar](#como-usar)
   * [Atualizações](#atualizacao)
<!--te-->

## Conteúdo do **Obsevatório**

- [x] Programa
- [x] Pessoas
- [x] Produções
- [x] Destaques
- [x] Impactos
- [x] Galeria
- [x] Autoavaliação
- [x] Área

### Recursos computacionais

Os seguintes programas foram usados na construção do **Obsevatório**:

- [R project](https://www.r-project.org)
- [Rstudio desktop](https://posit.co/download/rstudio-desktop/)

### Pré-requisitos

O **Obsevatório** utiliza arquivos exportados pela [Plataforma Sucupira](https://sucupira.capes.gov.br/sucupira/). Para gerar os arquivos, siga as seguintes etapas:

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

├── Sucupira
│   └── 2012
│       ├── conferencia_de_programa.xlsx

### Informações complementares

O **Obsevatório** pode exibir informações complementares, não disponíveis na Plataforma Sucupira, desde que organizadas em planilhas XLSX. As seguintes planilhas podem ser complementadas:

├── PPG
│   └── Agendas de Pesquisa.xlsx
│   └── Apresentação.xlsx
│   └── Autoavaliações.xlsx
│   └── Avaliação.xlsx
│   └── Bibliografia.xlsx
│   └── Blog_externos.xlsx
│   └── Blog_IES.xlsx
│   └── Bolsas.xlsx
│   └── Calendários.xlsx
│   └── CEP.xlsx
│   └── Colegiado.xlsx
│   └── Convênios.xlsx
│   └── Cooperações.xlsx
│   └── Coordenação.xlsx
│   └── Dados Cadastrais.xlsx
│   └── Destaques.xlsx
│   └── Discentes.xlsx
│   └── Downloads.xlsx
│   └── Editais.xlsx
│   └── Financiadores.xlsx
│   └── Grupos de Pesquisa.xlsx
│   └── Histórico.xlsx
│   └── Infraestrutura.xlsx
│   └── Internacionalização.xlsx
│   └── Laboratórios.xlsx
│   └── Notas.xlsx
│   └── Prêmio CAPES de Tese.xlsx
│   └── Prêmios.xlsx
│   └── Produção.xlsx
│   └── Repositórios.xlsx
│   └── Softwares.xlsx

### Fontes externas

Logotipos das principais agências de fomento estào disponíveis:

├── PPG
│   └── Agencias
│       ├── logo-capes.png
│       ├── logo-cnpq.png
│       ├── logo-faperj.png
│       └── logo-ods.png

Dara análise das métricas, as seguintes fontes são utilizadas:

├── Metrics
│   ├── Altmetric
│   │   └── cropped-altmetric-symbol.png
│   ├── CiteScore
│   │   └── extlistMarch2023.xlsx
│   ├── Qualis
│   │   └── classificações_publicadas_todas_as_areas_avaliacao1672761192111.xlsx
│   └── SJR
│       └── scimagojr 2022.csv

### Instalação

Antes de começar, você vai precisar instalar em sua máquina os seguintes programas:

- [R project](https://www.r-project.org)
- [Rstudio desktop](https://posit.co/download/rstudio-desktop/)

*Em construção*

### Como usar

*Em construção*

### Atualizações

*Em construção*
