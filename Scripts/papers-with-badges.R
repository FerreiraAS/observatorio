table.with.badges <-
  function(show.Altmetric = NULL,
           show.Dimensions = NULL,
           show.PlumX = NULL,
           show.CiteScore = NULL,
           show.SJR = NULL,
           show.Qualis = NULL,
           doi_unique,
           my_dois_works,
           citescore,
           scimago,
           qualis) {
    cat(
      "<style>.PlumX-Popup{display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;}</style>"
    )
    cat(
      "<style>.ppp-container ppp-medium{display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;}</style>"
    )
    cat(
      "<style>.plx-wrapping-print-link{display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;}</style>"
    )
    cat(
      "<style>.plx-print{display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;}</style>"
    )
    
    # start table
    cat(
      "<table class=\"tb\" style=\"width:100%; font-size: 16px !important;\">\n    <tr>\n      <th>Produtos (n = ",
      max(dim(doi_unique)[1], 0) + max(dim(my_dois_works)[1], 0),
      ") e Impactos (Altmetric^1^, Dimensions^2^, PlumX^3^, CiteScore^4^, SJR^5^, Qualis^6^, Open Access^7^) </th>\n    </tr>",
      sep = ""
    )
    
    # print table with DOI and Altmetric
    if (max(dim(doi_unique)[1], 0) != 0) {
      for (ix in 1:dim(doi_unique)[1]) {
        # add bibliography info
        cat("<tr><td valign=top;>")
        cat("<br>")
        cat(
          # add OPEN ACESS badge
          tryCatch(
            expr = {
              if (as.logical(doi_unique$is_oa[ix])) {
                cat(
                  "<a style=\"display: inline-block; float: left; margin:0.0em 0.2em 0.0em 0.0em; padding:0.0em 0.2em 0.0em 0.0em;\" href=\"",
                  doi_unique$url[ix],
                  "\" target=\"_blank\">",
                  "<img height=\"18px;\" src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Open_Access_logo_PLoS_white.svg/256px-Open_Access_logo_PLoS_white.svg.png\">",
                  "</a>",
                  sep = ""
                )
              }
            },
            error = function(e) {
              
            }
          ),
          
          # add title with link
          paste0(
            "[**",
            doi_unique$title[ix],
            "**](",
            doi_unique$url[ix],
            "){target=\"_blank\"}",
            "<br>"
          )
        )
        
        # add authors' names
        cat(doi_unique$author.names[ix])
        
        # add year
        cat(paste0(
          "<br>",
          paste0(doi_unique$published_on[ix], "&nbsp; - &nbsp;")
        ))
        
        # add journal's title
        cat(paste0("*", toTitleCase(doi_unique$journal[ix]), "*", "<br>"))
        
        # initialize the DIV element for the badges
        cat("<div style=\"vertical-align: middle; display: inline-block;\">")
        
        # initialize the NOBR element for the badges
        cat("<nobr>")
        
        # add Altmetric badge
        if (show.Altmetric == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" class=\"altmetric-embed\" data-badge-type=\"donut\" data-badge-popover=\"right\" data-doi=\"",
            doi_unique$doi[ix],
            "\"></a>",
            sep = ""
          )
        }
        
        # add Dimensions badge
        if (show.Dimensions == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" data-legend=\"hover-right\" class=\"__dimensions_badge_embed__\" data-doi=\"",
            doi_unique$doi[ix],
            "\" data-style=\"small_circle\"></a>",
            sep = ""
          )
        }
        
        # add PlumX badge
        if (show.PlumX == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em; padding:0.5em 0.3em 0.5em 0.3em;\" class=\"plumx-plum-print-popup\" href=\"https://plu.mx/plum/a/?doi=",
            doi_unique$doi[ix],
            "\" data-popup=\"right\" data-size=\"medium\" data-site=\"plum\"></a>",
            sep = ""
          )
        }
        
        # add CiteScore
        if (show.CiteScore == TRUE) {
          citescore_id <-
            as.character(citescore$sourcerecord_id[grep(gsub("-", "", doi_unique$issn[ix]), citescore$print_issn)])
          if (is_empty(citescore_id)) {
            citescore_id <-
              as.character(citescore$sourcerecord_id[grep(gsub("-", "", doi_unique$issn[ix]), citescore$e_issn)])
          }
          if (is_empty(citescore_id)) {
            citescore_id <-
              as.character(citescore$sourcerecord_id[grep(
                tolower(gsub(
                  "&", "and", doi_unique$journal[ix]
                )),
                tolower(
                  citescore$source_title_medline_sourced_journals_are_indicated_in_green
                )
              )])
          }
          citescore_value <-
            citescore$x2021_cite_score[match(citescore_id, citescore$sourcerecord_id)]
          citescore_year <-
            as.numeric(citescore$last_coverage[match(citescore_id, citescore$sourcerecord_id)]) - 1
          citescore_p <-
            round(citescore$percentile[match(citescore_id, citescore$sourcerecord_id)] * 100, 0)
          cat(
            "<a href=\"https://www.scopus.com/sourceid/",
            citescore_id,
            '?dgcid=sc_widget_citescore\" style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em; text-decoration:none;color:#505050\"><div style=\"height:64px;width:160px;font-family:Arial, Verdana, helvetica, sans-serif;background-color:#ffffff;display:inline-block\"><div style=\"padding: 0px 16px;\"><div style=\"padding-top:3px;line-height:1;\"><div style=\"float:left;font-size:28px\"><span id=\"citescoreVal\" style=\"letter-spacing: -2px;display: inline-block;padding-top: 7px;line-height: .75;\">',
            paste0(ifelse(
              identical(citescore_value, numeric(0)) |
                all(is.na(citescore_value)),
              "?",
              format(round(as.numeric(
                citescore_value
              ), 2), nsmall = 2)
            )),
            "</span></div><div style=\"float:right;font-size:14px;padding-top:3px;text-align: right;\"><span id=\"citescoreYearVal\" style=\"display:block;\">",
            ifelse(
              identical(citescore_year, numeric(0)) |
                all(is.na(citescore_year)),
              "?",
              citescore_year
            ),
            "</span>CiteScore</div></div><div style=\"clear:both;\"></div><div style=\"padding-top:3px;\"><div style=\"height:4px;background-color:#DCDCDC;\"><div style=\"height: 4px; background-color: rgb(0, 115, 152); width:",
            paste0(ifelse(
              identical(citescore_p, numeric(0)) |
                all(is.na(citescore_p)),
              "?",
              round(citescore_p, 0)
            )),
            "%;\" id=\"percentActBar\">&nbsp;</div></div><div style=\"font-size:11px;\"><span id=\"citescorePerVal\">",
            paste0(ifelse(
              identical(citescore_p, numeric(0)) |
                all(is.na(citescore_p)),
              "?",
              paste0(as.character(round(
                citescore_p, 0
              )), "th percentile")
            )),
            "</span></div></div><div style=\"font-size:12px;text-align:right;\"></div></div></div></a>",
            sep = ""
          )
          
        }
        
        # add SJR
        if (show.SJR == TRUE) {
          SJR_id <-
            scimago[grep(gsub("-", "", doi_unique$issn[ix]), scimago$Issn), 2][1]
          SJR <-
            scimago[grep(gsub("-", "", doi_unique$issn[ix]), scimago$Issn), 6][1]
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" href=\"https://www.scimagojr.com/journalsearch.php?q=",
            paste0(ifelse(
              identical(SJR, numeric(0)) |
                all(is.na(SJR)), "0?", SJR_id
            )),
            "&amp;tip=sid&amp;exact=no\" target=\"_blank\" title=\"SCImago Journal &amp; Country Rank\"><img border=\"0\" height=\"64px;\" src=\"https://www.scimagojr.com/journal_img.php?id=",
            paste0(ifelse(
              identical(SJR, numeric(0)) |
                all(is.na(SJR)), "0", SJR_id
            )),
            "\" alt=\"SCImago Journal &amp; Country Rank\"  /></a>",
            sep = ""
          )
        }
        
        # add QUALIS
        if (show.Qualis == TRUE) {
          # try first ISSN
          WebQualis <-
            qualis[match(doi_unique$issn[ix], qualis$ISSN), 3]
          if (is.na(WebQualis)) {
            # try journal name
            WebQualis <-
              qualis[match(tolower(gsub(
                "&", "and", doi_unique$journal[ix]
              )),
              tolower(qualis$Título)), 3]
          }
          if (is.na(WebQualis)) {
            # try other ISSN
            new.issn <-
              trimws(gsub(",", "", gsub(
                doi_unique$issn[ix], "", scimago$Issn[grep(gsub("-", "", doi_unique$issn[ix]), scimago$Issn)]
              )))
            issn.2 <- gsub('^(.{4})(.*)$', '\\1-\\2', new.issn)
            WebQualis <- qualis[match(new.issn, qualis$ISSN), 3]
          }
          cat(
            "<a style=\"border-radius:10%; border-style: solid; margin:0.1em 0.3em 0.1em 0.3em; padding:0.4em 0.3em 0.4em 0.3em; text-decoration:none; text-align: center; display:inline-block; float:left; color:black;\"> Qualis <br>",
            paste0(ifelse(
              identical(WebQualis, numeric(0)) |
                all(is.na(WebQualis)),
              "?",
              WebQualis
            ), "</a>"),
            sep = ""
          )
        }
        
        # close the NOBR element for the badges
        cat("</nobr>")
        cat("</div>")
        cat("</tr>")
      }
    }
    
    # print table with DOI but no Altmetric (== NA; donut ?)
    if (max(dim(my_dois_works)[1], 0) != 0) {
      for (ix in 1:dim(my_dois_works)[1]) {
        # add bibliography info
        cat("<tr><td valign=top;>")
        cat("<br>")
        cat(
          # add OPEN ACESS badge
          tryCatch(
            expr = {
              if (as.logical(my_dois_works$is_oa[ix])) {
                cat(
                  "<a style=\"display: inline-block; float: left; margin:0.0em 0.2em 0.0em 0.0em; padding:0.0em 0.2em 0.0em 0.0em;\" href=\"",
                  my_dois_works$url[ix],
                  "\" target=\"_blank\">",
                  "<img height=\"18px;\" src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Open_Access_logo_PLoS_white.svg/256px-Open_Access_logo_PLoS_white.svg.png\">",
                  "</a>",
                  sep = ""
                )
              }
            },
            error = function(e) {
              
            }
          ),
          
          # add title with link
          paste0(
            "[**",
            my_dois_works$title[ix],
            "**](https://doi.org/",
            my_dois_works$doi[ix],
            "){target=\"_blank\"}",
            "<br>"
          )
        )
        
        # add authors' names
        names <- ""
        try(names <-
              apply(cbind(my_dois_works$author[[ix]]$given, my_dois_works$author[[ix]]$family), 1,
                    function(x) paste(x[!is.na(x)], collapse = " ")), silent = TRUE)
        cat(paste(names[names != ""], collapse = ", "))
        
        # add year
        cat(paste0("<br>",
                   paste0(
                     ifelse(
                       !is.na(my_dois_works$issued[ix]),
                       substr(my_dois_works$issued[ix], 1, 4),
                       substr(my_dois_works$created[ix], 1, 4)
                     ),
                     "&nbsp; - &nbsp;"
                   )))
        
        # add jornal's title
        cat(paste0(
          "*",
          toTitleCase(my_dois_works$container.title[ix]),
          "*",
          "<br>"
        ))
        
        # initialize the DIV element for the badges
        cat("<div style=\"vertical-align: middle; display: inline-block;\">")
        
        # initialize the NOBR element for the badges
        cat("<nobr>")
        
        # add Altmetric badge
        if (show.Altmetric == TRUE) {
          cat(
            "<img style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" src=\"https://badges.altmetric.com/?score=?&types=????????\">",
            sep = ""
          )
        }
        
        # add Dimensions badge
        if (show.Dimensions == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" data-legend=\"hover-right\" class=\"__dimensions_badge_embed__\" data-doi=\"",
            my_dois_works$doi[ix],
            "\" data-style=\"small_circle\"></a>",
            sep = ""
          )
        }
        
        # add PlumX badge
        if (show.PlumX == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em; padding:0.4em 0.3em 0.4em 0.3em;\" class=\"plumx-plum-print-popup\" href=\"https://plu.mx/plum/a/?doi=",
            my_dois_works$doi[ix],
            "\" data-popup=\"right\" data-size=\"medium\" data-site=\"plum\"></a>",
            sep = ""
          )
        }
        
        # add CiteScore
        if (show.CiteScore == TRUE) {
          if (is.na(my_dois_works$issn[ix])) {
            citescore_id <- character(0)
          } else {
            if (str_length(my_dois_works$issn[ix]) == 9) {
              citescore_id <-
                as.character(citescore$sourcerecord_id[grep(gsub("-", "", my_dois_works$issn[ix]),
                                                            citescore$print_issn)])
            }
            if (str_length(my_dois_works$issn[ix]) == 19) {
              citescore_id <-
                as.character(citescore$sourcerecord_id[grep(gsub("-", "", substr(my_dois_works$issn[ix], 1, 9)), citescore$print_issn)])
              if (is_empty(citescore_id)) {
                citescore_id <-
                  as.character(citescore$sourcerecord_id[grep(gsub("-", "", substr(
                    my_dois_works$issn[ix], 11, 19
                  )), citescore$print_issn)])
              }
            }
          }
          if (is_empty(citescore_id)) {
            citescore_id <-
              as.character(citescore$sourcerecord_id[grep(
                tolower(gsub(
                  "&", "and", my_dois_works$container.title[ix]
                )),
                tolower(
                  citescore$source_title_medline_sourced_journals_are_indicated_in_green
                )
              )])
          }
          citescore_value <-
            citescore$x2021_cite_score[match(citescore_id, citescore$sourcerecord_id)]
          citescore_year <-
            as.numeric(citescore$last_coverage[match(citescore_id, citescore$sourcerecord_id)]) - 1
          citescore_p <-
            round(citescore$percentile[match(citescore_id, citescore$sourcerecord_id)] * 100, 0)
          cat(
            "<a href=\"https://www.scopus.com/sourceid/",
            citescore_id,
            '?dgcid=sc_widget_citescore\" style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em; text-decoration:none;color:#505050\"><div style=\"height:64px;width:160px;font-family:Arial, Verdana, helvetica, sans-serif;background-color:#ffffff;display:inline-block\"><div style=\"padding: 0px 16px;\"><div style=\"padding-top:3px;line-height:1;\"><div style=\"float:left;font-size:28px\"><span id=\"citescoreVal\" style=\"letter-spacing: -2px;display: inline-block;padding-top: 7px;line-height: .75;\">',
            paste0(ifelse(
              identical(citescore_value, numeric(0)) |
                all(is.na(citescore_value)),
              "?",
              format(round(as.numeric(
                citescore_value
              ), 2), nsmall = 2)
            )),
            "</span></div><div style=\"float:right;font-size:14px;padding-top:3px;text-align: right;\"><span id=\"citescoreYearVal\" style=\"display:block;\">",
            ifelse(
              identical(citescore_year, numeric(0)) |
                all(is.na(citescore_year)),
              "?",
              citescore_year
            ),
            "</span>CiteScore</div></div><div style=\"clear:both;\"></div><div style=\"padding-top:3px;\"><div style=\"height:4px;background-color:#DCDCDC;\"><div style=\"height: 4px; background-color: rgb(0, 115, 152); width:",
            paste0(ifelse(
              identical(citescore_p, numeric(0)) |
                all(is.na(citescore_p)),
              "?",
              round(citescore_p, 0)
            )),
            "%;\" id=\"percentActBar\">&nbsp;</div></div><div style=\"font-size:11px;\"><span id=\"citescorePerVal\">",
            paste0(ifelse(
              identical(citescore_p, numeric(0)) |
                all(is.na(citescore_p)),
              "?",
              paste0(as.character(round(
                citescore_p, 0
              )), "th percentile")
            )),
            "</span></div></div><div style=\"font-size:12px;text-align:right;\"></div></div></div></a>",
            sep = ""
          )
        }
        
        # add SJR
        if (show.SJR == TRUE) {
          SJR_id <-
            scimago[grep(gsub("-", "", substr(my_dois_works$issn[ix], 1, 9)), scimago$Issn), 2][1]
          SJR <-
            scimago[grep(gsub("-", "", substr(my_dois_works$issn[ix], 1, 9)), scimago$Issn), 6][1]
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" href=\"https://www.scimagojr.com/journalsearch.php?q=",
            paste0(ifelse(
              identical(SJR, numeric(0)) |
                all(is.na(SJR)), "0?", SJR_id
            )),
            "&amp;tip=sid&amp;exact=no\" target=\"_blank\" title=\"SCImago Journal &amp; Country Rank\"><img border=\"0\" height=\"64px;\" src=\"https://www.scimagojr.com/journal_img.php?id=",
            paste0(ifelse(
              identical(SJR, numeric(0)) |
                all(is.na(SJR)), "0", SJR_id
            )),
            "\" alt=\"SCImago Journal &amp; Country Rank\"  /></a>",
            sep = ""
          )
        }
        
        # add QUALIS
        if (show.Qualis == TRUE) {
          if (is.na(my_dois_works$issn[ix])) {
            WebQualis <- NA
          }
          else {
            # try first and second ISSN
            issn.1 <- strsplit(my_dois_works$issn[ix], ",")[[1]][1]
            issn.2 <- strsplit(my_dois_works$issn[ix], ",")[[1]][2]
            WebQualis.1 <-
              qualis$Estrato[match(issn.1, qualis$ISSN)]
            WebQualis.2 <-
              qualis$Estrato[match(issn.2, qualis$ISSN)]
            WebQualis <-
              unique(na.omit(c(WebQualis.1, WebQualis.2)))[1]
            if (is_empty(WebQualis)) {
              WebQualis <- NA
            }
          }
          if (is.na(WebQualis)) {
            # try journal name
            WebQualis <-
              qualis[match(tolower(my_dois_works$container.title[ix]),
                           tolower(qualis$Título)), 3]
          }
          cat(
            "<a style=\"border-radius:10%; border-style: solid; margin:0.1em 0.3em 0.1em 0.3em; padding:0.4em 0.3em 0.4em 0.3em; text-decoration:none; text-align: center; display:inline-block; float:left; color:black;\"> Qualis <br>",
            paste0(ifelse(
              identical(WebQualis, numeric(0)) |
                all(is.na(WebQualis)),
              "?",
              WebQualis
            ), "</a>"),
            sep = ""
          )
        }
        
        # close the NOBR element for the badges
        cat("</nobr>")
        cat("</div>")
        cat("</td></tr>")
      }
    }
    
    # end table
    cat("</table>")
    cat('<br>')
    cat('*Fontes:*', sep = "")
    cat('^1^ [**Altmetric**](https://www.altmetric.com)', sep = "")
    cat(', ', sep = "")
    cat('^2^ [**Dimensions**](https://www.dimensions.ai)', sep = "")
    cat(', ', sep = "")
    cat('^3^ [**PlumX**](https://plu.mx)', sep = "")
    cat(', ', sep = "")
    cat('^4^ [**CiteScore**](https://www.scopus.com/sources)',
        sep = "")
    cat(', ', sep = "")
    cat('^5^ [**SCImago**](https://www.scimagojr.com)', sep = "")
    cat(', ', sep = "")
    cat(
      '^6^ [**WebQualis**](https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/veiculoPublicacaoQualis/listaConsultaGeralPeriodicos.jsf)',
      sep = ""
    )
    cat(', ', sep = "")
    cat('^7^ [**DOAJ**](https://doaj.org)', sep = "")
    cat('<br>')
    cat('<br>')
    cat('<br><a style="float:right" href="#top"><b>Início &nbsp;</b>⬆️</a><br>')
  }
cat('<br>')
