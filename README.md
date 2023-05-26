# Observatório

## O **Observatório** é uma iniciativa que envolve o registro, o acompanhamento e a análise agregada e estruturada de dados de Programas de Pós-graduação Stricto Sensu do Brasil para divulgação transparente de suas atividades, planejamentos, ações e impactos, tornando-os acessíveis à sociedade

**Sumário**
=================
<!--ts-->
   * [Conteudo do Observatorio](#Conteudo-do-Observatorio)
   * [Recursos computacionais](#Recursos-computacionais)
   * [Fontes de dados](#Fontes-de-dados)
      * [Plataforma Sucupira](#Plataforma-Sucupira)
      * [Programa](#Programa)
      * [Agencias](#Agencias)
      * [Metricas](#Metricas)
   * [Instalacao](#instalacao)
   * [Como usar](#Como-usar)
   * [Atualizações](#Atualizacoes)
   * [Observatorios publicados](#Observatorios-publicados)
<!--te-->

## **Conteudo do Observatorio**

- [x] Programa
- [x] Pessoas
- [x] Produções
- [x] Destaques
- [x] Impactos
- [x] Galeria
- [x] Autoavaliação
- [x] Área

## **Recursos computacionais**

Os seguintes programas foram usados na construção do **Obsevatório**:

- [R project](https://www.r-project.org)
- [Rstudio desktop](https://posit.co/download/rstudio-desktop/)

## **Fontes de dados**

### **Plataforma Sucupira**

O **Obsevatório** utiliza arquivos exportados pela [Plataforma Sucupira](https://sucupira.capes.gov.br/sucupira/). Para gerar os arquivos, siga as seguintes etapas:

1. Crie uma pasta de nome "Sucupira" no seu computador
2. Na pasta "Sucupira", crie uma pasta para cada ano que o Programa possui dados disponíveis na Plataforma Sucupira (2012 em diante). O nome da pasta será o ano correspondente aos dados (ex.: "2023")

Ao completar esta etapa, a estrutura dos diretórios será esta:

```bash
├── Sucupira
│   └── 2012
│   └── 2013
│   └── 2014
│   └── 2015
│   └── 2016
│   └── 2017
│   └── 2018
│   └── 2019
│   └── 2020
│   └── 2021
│   └── 2022
│   └── 2023
```

1. Acesse a [Plataforma Sucupira](https://sucupira.capes.gov.br/sucupira/)
2. Clique no ícone "ACESSO RESTRITO" e faça login
3. Clique no ícone "Coordenador de PPG" para acesse o conteúdo
4. No menu "Relatórios", clique no ícone "Conferência de Programa"

Para cada ano de atividade do Programa, repita os seguintes passos:
1. No item "Categoria", mantenha a opção padrão "-- SELECIONE --"
2. Selecione o ano que deseja exportar os dados
3. Clique em "Gerar excel único com os dados do programa"
4. Na nova aba aberta, aparecerá a mensagem "Por favor, aguarde enquanto o relatório está sendo gerado". Após a compilação dos dados, clique em "Clique aqui para realizar o download"
5. Feche a nova aba e retorne à página principal da Plataforma Sucupira
6. Abra o arquivo "conferencia_programa.xls" e salve em formato XLSX (ex.: "conferencia_programa.xlsx")
7. Mova o arquivo "conferencia_programa.xlsx" para a pasta do ano correspondente
8. Delete o arquivo original "conferencia_programa.xls"

Ao completar esta etapa, a estrutura dos diretórios e arquivos será esta:

```bash
├── Sucupira
│   └── 2012
│       └── conferencia_programa.xlsx
│   └── 2013
│       └── conferencia_programa.xlsx
│   └── 2014
│       └── conferencia_programa.xlsx
│   └── 2015
│       └── conferencia_programa.xlsx
│   └── 2016
│       └── conferencia_programa.xlsx
│   └── 2017
│       └── conferencia_programa.xlsx
│   └── 2018
│       └── conferencia_programa.xlsx
│   └── 2019
│       └── conferencia_programa.xlsx
│   └── 2020
│       └── conferencia_programa.xlsx
│   └── 2021
│       └── conferencia_programa.xlsx
│   └── 2022
│       └── conferencia_programa.xlsx
│   └── 2023
│       └── conferencia_programa.xlsx
```

### **Programa**

O **Obsevatório** pode exibir informações complementares, não disponíveis na Plataforma Sucupira, desde que organizadas em planilhas XLSX. As seguintes planilhas podem ser complementadas:

```bash
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
```

### **Agencias**

Logotipos das principais agências de fomento estào disponíveis:

- [**CAPES**](https://www.gov.br/capes/pt-br/centrais-de-conteudo/logomarca)
- [**CNPq**](http://memoria.cnpq.br/marca-cnpq)
- [**FAPERJ**](https://www.faperj.br/?id=26.5.2)
- [**ODS**](http://www4.planalto.gov.br/ods/publicacoes/manual-de-identidade-visual-ods-pnud.pdf/view)

```bash
├── PPG
│   └── Agencias
│       ├── logo-capes.png
│       ├── logo-cnpq.png
│       ├── logo-faperj.png
│       └── logo-ods.png
```

### **Metricas**

Para análise das métricas, as seguintes fontes são utilizadas:

- [**Altmetric**](https://www.altmetric.com)
- [**Scopus**](https://www.scopus.com/home.uri)
- [**WebQualis**](https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/veiculoPublicacaoQualis/listaConsultaGeralPeriodicos.jsf)
- [**SJR**](https://www.scimagojr.com)
- [**CrossRef**](https://www.crossref.org)

```bash
├── Metrics
│   ├── Altmetric
│   │   └── cropped-altmetric-symbol.png
│   ├── CiteScore
│   │   └── extlistMarch2023.xlsx
│   ├── Qualis
│   │   └── classificações_publicadas_todas_as_areas_avaliacao1672761192111.xlsx
│   └── SJR
│       └── scimagojr 2022.csv
```

## **Instalacao**

Antes de começar, você vai precisar instalar em sua máquina os seguintes programas:

- [R project](https://www.r-project.org)
- [Rstudio desktop](https://posit.co/download/rstudio-desktop/)

## **Como usar**

### **1. Criando uma conta no GitHub**

### **2. Copiando o repositório do GitHub**

### **3. Criando novo projeto no RStudio**

### **4. Compilando o Observatório no RStudio**

### **5. Publicando o Observatório no Github**

## **Atualizacoes**

## **Observatorios publicados**

### **Centro Universitário Augusto Motta | UNISUAM**
- [**Observatório CR**](https://ppgcr-unisuam.github.io/observatoriocr) | Programa de Pós-graduação em Ciências da Reabilitação

- [**Observatório DL**](https://ppgdl-unisuam.github.io/observatoriodl) | Programa de Pós-graduação em Desenvolvimento Local
