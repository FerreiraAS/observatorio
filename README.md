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
      * [Curriculo Lattes](#Curriculo-Lattes)
      * [Metricas](#Metricas)
   * [Instalacao](#instalacao)
   * [Como usar](#Como-usar)
   * [Atualizações](#Atualizacoes)
   * [Observatorios publicados](#Observatorios-publicados)
   * [Licenca](#licenca)
<!--te-->

## **Conteudo do Observatorio**

- [x] Programa
- [x] Pessoas
- [x] Produções
- [x] Destaques
- [x] Impactos
- [x] Galeria
- [x] Autoavaliação
- [x] Toolbox
- [x] Downloads

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
│   └── Área.xlsx
│   └── Autoavaliações.xlsx
│   └── Avaliação.xlsx
│   └── Bibliografia.xlsx
│   └── Blog externo.xlsx
│   └── Blog institucional.xlsx
│   └── Bolsas.xlsx
│   └── Calendários.xlsx
│   └── CEP.xlsx
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
│   └── Periódicos institucionais.xlsx
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
│       ├── logo-fap.png
│       └── logo-ods.png
```

### **Curriculo Lattes**

Para cada docente em atividade do Programa, repita os seguintes passos:
1. Acesse a [Plataforma Lattes](https://lattes.cnpq.br)
2. Clique no ícone "Buscar currículo"
3. Digite o nome do docente e clique em "Buscar"
4. Identifique o nome do docente na lista e clique em abrir
5. Na janela, clique em "Abrir Currículo"
6. Selecione e copie o ID Lattes (apenas os números, ex: 5432142731317894)
7. Clique no ícone "Imprimir currículo"
8. Salve o currículo em formato PDF, com o nome igual ao ID lattes (ex.: "5432142731317894.pdf")

Ao completar esta etapa, a estrutura dos diretórios e arquivos será esta:

```bash
├── PPG
│   └── Lattes
│       ├── 5432142731317894.pdf
```

### **Metricas**

Para análise das métricas, as seguintes fontes são utilizadas:

- [**Altmetric**](https://www.altmetric.com)
- [**Dimensions**](https://www.dimensions.ai)
- [**PlumX**](https://plu.mx)
- CiteScore da [**Scopus**](https://www.scopus.com/sources)
- Webqualis da [**CAPES**](https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/veiculoPublicacaoQualis/listaConsultaGeralPeriodicos.jsf)
- SJR da [**SCImago**](https://www.scimagojr.com)

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

### [**1. Fazer o registro em uma conta do GitHub**](https://docs.github.com/pt/get-started/signing-up-for-github/signing-up-for-a-new-github-account)

*O GitHub oferece contas pessoais de indivíduos e organizações para que equipes de pessoas trabalhem juntas.*


### [**2. Verificar endereço de e-mail**](https://docs.github.com/pt/get-started/signing-up-for-github/verifying-your-email-address)

*A verificação do endereço de e-mail principal garante segurança reforçada, permite que a equipe do GitHub auxilie melhor caso você esqueça sua senha e fornece acesso a mais recursos no GitHub.*


### [**3. Criar um repositório**](https://docs.github.com/pt/get-started/quickstart/create-a-repo)

*Para colocar seu projeto no GitHub, você precisará criar um repositório no qual ele residirá.*


### [**4. Clonar um repositório**](https://docs.github.com/pt/repositories/creating-and-managing-repositories/cloning-a-repository)

*Ao criar um repositório no GitHub.com, ele existirá como um repositório remoto. É possível clonar o repositório para criar uma cópia local no seu computador e sincronizar entre os dois locais.*


### [**5. Configurar uma fonte de publicação para o site do GitHub Pages**](https://docs.github.com/pt/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)

*Você pode configurar seu site do GitHub Pages para ser publicado quando alterações são enviadas por push a um branch específico ou pode escrever um fluxo de trabalho do GitHub Actions para publicar seu site.*

1. Acesse o repositório clicando no link.
2. Clique em “Settings”.
3. Na barra lateral esquerda, clique em “Pages”.
4. No item “Build and deployment”, selecione branch -> “main” e folder -> “/docs”.
5. Aguarde alguns instantes e atualize a página.
6. Copie o link de acesso ao Observatório.


### [**Tutorial**](https://resources.github.com/github-and-rstudio/)

*This tutorial teaches you to create R Markdown documents with RStudio and publish them via GitHub, using GitHub Pages.*


## **Atualizacoes**

O Observatório é atualizado periodicamente pelo desenvolvedor. Para receber atualziações no seu repositório, siga os passos 6.1 e 6.2 acima.


## **Observatorios publicados**

### **Centro Universitário Augusto Motta | UNISUAM**

- [**Observatório CR**](https://ppgcr-unisuam.github.io/observatoriocr) | Programa de Pós-graduação em Ciências da Reabilitação
- [**Observatório DL**](https://ppgdl-unisuam.github.io/observatoriodl) | Programa de Pós-graduação em Desenvolvimento Local


### **Universidade Federal do Ceará | UFC**

- [**Observatório PPGFisio**](https://ppgfisioufc.github.io/PPGFisio_UFC/) | Programa de Pós-graduação em Fisioterapia


## **Licenca**

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/FerreiraAS/observatorio">Observatório</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://github.com/FerreiraAS">Arthur de Sá Ferreira</a> is licensed under <a href="http://creativecommons.org/licenses/by-nc/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-NC 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1"></a></p>
