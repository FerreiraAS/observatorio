# Observatório

## O **Observatório** é uma iniciativa que envolve o registro, o acompanhamento e a análise agregada e estruturada de dados de Programas de Pós-graduação Stricto Sensu do Brasil para divulgação transparente de suas atividades, planejamentos, ações e impactos, tornando-os acessíveis à sociedade

<a href="https://zenodo.org/badge/latestdoi/580590445"><img src="https://zenodo.org/badge/580590445.svg" alt="DOI"/></a>

<div style="text-align: center; font-size:14px">

Copyright © 2021 Arthur de Sá Ferreira, DSc. Todos os direitos reservados.

<img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/circle-exclamation.svg" width="50" height="50"> <strong>Observatório</strong> é um software gratuito e NÃO vem com ABSOLUTAMENTE NENHUMA GARANTIA.

</div>

<br>

# **Sumário**

<!--ts-->

-   [Conteudo do Observatorio](#Conteudo-do-Observatorio)
-   [Recursos computacionais](#Recursos-computacionais)
-   [Fontes de dados](#Fontes-de-dados)
    -   [Plataforma Sucupira](#Plataforma-Sucupira)
    -   [Programa](#Programa)
    -   [Agencias](#Agencias)
    -   [Metricas](#Metricas)
    -   [Impacto](#Metricas)
    -   [API](#api)
-   [Instalacao](#instalacao)
-   [Como usar](#Como-usar)
-   [Atualizações](#Atualizacoes)
-   [Observatorios publicados](#Observatorios-publicados)
-   [FAQ](#faq)
-   [Licenca](#licenca) <!--te-->

## **Conteudo do Observatorio**

-   [x] Home
-   [x] Programa
-   [x] Pessoas
-   [x] Produções
-   [x] Destaques
-   [x] Impactos
-   [x] Galeria
-   [x] Downloads
-   [x] Autoavaliação
-   [x] Links
-   [x] Observatório CAPES
-   [x] Redes sociais

## **Recursos computacionais**

Os seguintes programas foram usados na construção do **Obsevatório**:

-   [R project](https://www.r-project.org)
-   [Rstudio desktop](https://posit.co/download/rstudio-desktop/)
-   [LaTeX](https://www.latex-project.org)

## **Fontes de dados**

### **Plataforma Sucupira**

O **Observatório** utiliza arquivos exportados pela [Plataforma
Sucupira](https://sucupira.capes.gov.br/sucupira/). Para gerar os
arquivos, siga as seguintes etapas:

1.  Crie uma pasta de nome "Sucupira" no seu computador
2.  Na pasta "Sucupira", crie uma pasta para cada ano que o Programa
    possui dados disponíveis na Plataforma Sucupira (2012 em diante). O
    nome da pasta será o ano correspondente aos dados (ex.: "2023")

Ao completar esta etapa, a estrutura dos diretórios será esta:

``` bash
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
│   └── 2024
```

1.  Acesse a [Plataforma
    Sucupira](https://sucupira.capes.gov.br/sucupira/)
2.  Clique no ícone "ACESSO RESTRITO" e faça login
3.  Clique no ícone "Coordenador de PPG" para acesse o conteúdo
4.  No menu "Relatórios", clique no ícone "Conferência de Programa"

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

``` bash
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
│   └── 2024
│       └── conferencia_programa.xlsx
```

### **Programa**

O **Observatório** pode exibir informações complementares, não disponíveis na Plataforma Sucupira, desde que organizadas em planilhas XLSX.

``` bash
├── PPG
│   └── Agendas de Pesquisa.xlsx
│   └── Apresentação.xlsx
│   └── Área CAPES.xlsx
│   └── Autoavaliação.xlsx
│   └── Avaliação.xlsx
│   └── Bibliografia.xlsx
│   └── Blog institucional.xlsx
│   └── Blogs externos.xlsx
│   └── Bolsas.xlsx
│   └── Calendários.xlsx
│   └── Comitê de Ética em Pesquisa.xlsx
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
│   └── Metodologia.xlsx
│   └── Notas.xlsx
│   └── Periódicos institucionais.xlsx
│   └── Planejamento estratégico.xlsx
│   └── Podcasts.xlsx
│   └── Políticas.xlsx
│   └── Prêmio CAPES de Tese.xlsx
│   └── Prêmios.xlsx
│   └── Produção.xlsx
│   └── Repositórios.xlsx
│   └── Videos.xlsx
```

Um arquivo-modelo de cada planilha está disponível no [repositório do Observatório CR](https://github.com/ppgcr-unisuam/observatoriocr/tree/76185c88ea0ead961c03c0a09f6c5fb9eb104e39/PPG).

*Importante*: Os modelos são disponibilizados com dados do PPGCR-UNISUAM, os quais devem ser substituídos pelos dados do PPG. As seguintes planilhas podem ser complementadas:

-   [Agendas de Pesquisa.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Agendas%20de%20Pesquisa.xlsx)
-   [Apresentação.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Apresenta%C3%A7%C3%A3o.xlsx)
-   [Área CAPES.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/%C3%81rea%20CAPES.xlsx)
-   [Autoavaliação.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Autoavalia%C3%A7%C3%A3o.xlsx)
-   [Avaliação.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Avalia%C3%A7%C3%A3o.xlsx)
-   [Bibliografia.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Bibliografia.xlsx)
-   [Blog institucional.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Blog%20institucional.xlsx)
-   [Blogs externos.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Blogs%20externos.xlsx)
-   [Bolsas.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Bolsas.xlsx)
-   [Calendários.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Calend%C3%A1rios.xlsx)
-   [Comitê de Ética em Pesquisa.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Comit%C3%AA%20de%20%C3%89tica%20em%20Pesquisa.xlsx)
-   [Convênios.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Conv%C3%AAnios.xlsx)
-   [Cooperações.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Coopera%C3%A7%C3%B5es.xlsx)
-   [Coordenação.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Coordena%C3%A7%C3%A3o.xlsx)
-   [Dados Cadastrais.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Dados%20Cadastrais.xlsx)
-   [Destaques.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Destaques.xlsx)
-   [Discentes.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Discentes.xlsx)
-   [Downloads.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Downloads.xlsx)
-   [Editais.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Editais.xlsx)
-   [Financiadores.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Financiadores.xlsx)
-   [Grupos de  Pesquisa.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Grupos%20de%20Pesquisa.xlsx)
-   [Histórico.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Hist%C3%B3rico.xlsx)
-   [Infraestrutura.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Infraestrutura.xlsx)
-   [Internacionalização.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Internacionaliza%C3%A7%C3%A3o.xlsx)
-   [Laboratórios.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Laborat%C3%B3rios.xlsx)
-   [Metodologia.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Metodologia.xlsx)
-   [Notas.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Notas.xlsx)
-   [Periódicos institucionais.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Peri%C3%B3dicos%20institucionais.xlsx)
-   [Planejamento estratégico.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Planejamento%20estrat%C3%A9gico.xlsx)
-   [Podcasts.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Podcasts.xlsx)
-   [Políticas.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/cd7e88477169e474befd583e89574711c877e4c1/PPG/Pol%C3%ADticas.xlsx)
-   [Prêmio CAPES de Tese.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Pr%C3%AAmio%20CAPES%20de%20Tese.xlsx)
-   [Prêmios.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Pr%C3%AAmios.xlsx)
-   [Produção.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Produ%C3%A7%C3%A3o.xlsx)
-   [Repositórios.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Reposit%C3%B3rios.xlsx)
-   [Videos.xlsx](https://github.com/ppgcr-unisuam/observatoriocr/blob/1ee2bc100e8ca943e81ac9302fd15f31986cfbcf/PPG/Videos.xlsx)

### **Metricas**

Para análise das métricas, as seguintes fontes são utilizadas:

-   [**Altmetric**](https://www.altmetric.com)
-   [**Dimensions**](https://www.dimensions.ai)
-   [**PlumX**](https://plu.mx)
-   CiteScore da [**Scopus**](https://www.scopus.com/sources)
-   Webqualis 2021 da [**CAPES**](https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/veiculoPublicacaoQualis/listaConsultaGeralPeriodicos.jsf)
-   SJR da [**SCImago**](https://www.scimagojr.com)

``` bash
├── Metrics
│   ├── Altmetric
│   │   └── cropped-altmetric-symbol.png
│   ├── CiteScore
│   │   └── extlistMarch2023.xlsx
│   ├── Qualis
│   │   └── classificações_publicadas_todas_as_areas_avaliacao1672761192111.xlsx
│   └── SJR
│       └── scimagojr 2023.csv
```

### **Impacto**

O **Observatório** utiliza arquivos exportados pela [Sage Policy Profile](https://policyprofile.sagepub.com). Para gerar os
arquivos, siga as seguintes etapas:

1. Utilize o link público do cadastro de cada docente no Sage Policy Profile.
2. Faça o download do arquivo em formato CSV.
3. Renomeie o arquivo com o nome do docente.
4. Salve o arquivo na pasta *Impacto -> Sage Policy Profile*.

Ao completar esta etapa, a estrutura dos diretórios será esta:

``` bash
├── Impacto
│   ├── Sage Policy Profiles
│   │   └── policy-impact-export-2024-01-07_DOCENTE_1.csv
│   │   └── policy-impact-export-2024-01-07_DOCENTE_2.csv
│   │   └── ...
│   │   └── policy-impact-export-2024-01-07_DOCENTE_N.csv
```

### **API**

Para obter dados de métricas, as seguintes API são utilizadas:

-   [**ORCID
    API**](https://info.orcid.org/documentation/features/public-api/)
    Para acesso a dados de *Invited positions*, *Membership*,
    *Services*, *Reviewer board*

-   [**Scopus API**](https://dev.elsevier.com/sc_apis.html) Para acesso
    a dados da Scopus e SciVal

-   [**CrossRef**](https://github.com/ropensci/rcrossref) Para acesso
    a dados da CrossRef

*Você pode configurar chaves de acesso para usar as APIs e obter as métricas. Acesse os sites acima para configurar o TOKEN, KEY e EMAIL.*

1.  No console do RStudio, digite "file.edit("~/.Renviron")".
2.  Copie e cole as chaves conforme a seguir:
ORCID_TOKEN="TOKEN"
OPENAI_API_KEY="KEY"
crossref_email="EMAIL"
3.  Substitua TOKEN, KEY e EMAIL pelos respectivos dados.
4. Salve e feche o arquivo .Renviron.
5. Reinicie o RStudio.


## **Como usar**

### [**1. Registre uma conta do GitHub**](https://docs.github.com/pt/get-started/signing-up-for-github/signing-up-for-a-new-github-account)

*O GitHub oferece contas pessoais de indivíduos e organizações para que equipes de pessoas trabalhem juntas.*

### [**2. Verifique o endereço de e-mail**](https://docs.github.com/pt/get-started/signing-up-for-github/verifying-your-email-address)

*A verificação do endereço de e-mail principal garante segurança reforçada, permite que a equipe do GitHub auxilie melhor caso você esqueça sua senha e fornece acesso a mais recursos no GitHub.*

### [**3. Crie um repositório**](https://docs.github.com/pt/get-started/quickstart/create-a-repo)

*Para colocar seu projeto no GitHub, você precisará criar um repositório público no qual ele residirá.*

### [**4. Clone um repositório**](https://docs.github.com/pt/repositories/creating-and-managing-repositories/cloning-a-repository)

*Ao criar um repositório no GitHub.com, ele existirá como um repositório remoto. É possível clonar o repositório para criar uma cópia local no seu computador e sincronizar entre os dois locais.*

### [**5. Configure uma fonte de publicação para o site do GitHub Pages**](https://docs.github.com/pt/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)

*Você pode configurar seu site do GitHub Pages para ser publicado quando alterações são enviadas por push a um branch específico ou pode escrever um fluxo de trabalho do GitHub Actions para publicar seu site.*

1.  Acesse o repositório clicando no link.
2.  Clique em “Settings”.
3.  Na barra lateral esquerda, clique em “Pages”.
4.  No item “Build and deployment”, selecione branch -\> “main” e folder -\> “/docs”.
5.  Aguarde alguns instantes e atualize a página.
6.  Copie o link de acesso ao Observatório.

### [**Tutorial**](https://resources.github.com/github-and-rstudio/)

*This tutorial teaches you to create R Markdown documents with RStudio and publish them via GitHub, using GitHub Pages.*

## **Atualizacoes**

O Observatório é atualizado periodicamente. Para receber atualizações no seu repositório, siga os passos 6.1 e 6.2 acima.

## **Observatorios publicados**

### **Modelo**

-   [**Observatório**](https://ferreiraas.github.io/observatorio) \| Modelo para PPGs

### [**UNISUAM**](https://www.unisuam.edu.br) **\| Centro Universitário Augusto Motta**

-   [**Observatório CR**](https://ppgcr-unisuam.github.io/observatoriocr) \| Programa de Pós-graduação em Ciências da Reabilitação
-   [**Observatório DL**](https://ppgdl-unisuam.github.io/observatoriodl) \| Programa de Pós-graduação em Desenvolvimento Local

### [**UFC**](https://www.ufc.br) **\| Universidade Federal do Ceará**

-   [**Observatório PPGFisio**](https://ppgfisioufc.github.io/PPGFisio_UFC/) \| Programa de Pós-graduação em Fisioterapia

### [**UFTM-UFU**](https://www.uftm.edu.br/stricto-sensu/ppgfisio) **\| Universidade Federal do Triângulo Mineiro - Universidade Federal de Uberlândia**

-   [**Observatório PPGFisio**](https://ppgfisiouftmufu.github.io/ObservatorioUFTM_UFU/) \| Programa de Pós-graduação em Fisioterapia

### [**UFRN**](https://posgraduacao.ufrn.br/ppgfst) **\| Universidade Federal do Rio Grande do Norte**

-   [**Observatório UFRN**](https://ppgfisioterapia.github.io/observatorioUFRN/) \| Programa de Pós-graduação em Ciências da Reabilitação

### [**USP**](https://www.fm.usp.br/fofito/pos-graduacao/programa-de-ciencias-da-reabilitacao) **\| Universidade de São Paulo**

-   [**Observatório PPGPosReab**](https://ppgreab.github.io/Observatorio-PPGPosReab-USP/) \| Programa de Pós-graduação em Ciências da Reabilitação

### [**IFRJ**](https://www.ifrj.edu.br/cursos-pos-graduacao/stricto-sensu/programa-pos-graduacao-ciencia-tecnologia-e-inovacao-saude-0/) **\| Instituto Federal do Rio de Janeiro**

-   [**Observatório PPGCTIS**](https://ppgctis.github.io/ObservatorioCTIS/) \| Programa de Pós-graduação em Ciência, Tecnologia e Inovação em Saúde

### [**UPE**](https://www.upe.br/petrolina/ppgrdf/) **\| Universidade de Pernambuco**

-   [**Observatório PPGRDF**](https://ppgrdf-upe.github.io/Observatorio_PPGRDF/) \| Programa de Pós-graduação em Reabilitação e Desempenho Funcional



## **FAQ**

*Como posso contribuir para este projeto?*

-   Você pode [criar um problema](https://docs.github.com/pt/issues/tracking-your-work-with-issues/creating-an-issue)
    ou [clonar o repositório](https://docs.github.com/pt/repositories/creating-and-managing-repositories/cloning-a-repository)
    e me enviar uma [solicitação de pull](https://docs.github.com/pt/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).

-   Envie um [e-mail](mailto:arthur_sf@icloud.com) para mim com sugestões.

## **Licença**

<div style="text-align: center">
  <p><b>Observatório</b> by <b>Arthur de Sa Ferreira</b> is licensed under an <a rel="license" data-spdx="Apache-2.0" href="https://www.apache.org/licenses/LICENSE-2.0">Apache License 2.0</a></p>
</div>
