table.with.badges <-
  function(show.Altmetric = NULL,
           show.Dimensions = NULL,
           show.PlumX = NULL,
           show.CiteScore = NULL,
           show.SJR = NULL,
           show.Qualis = NULL,
           doi_with_altmetric,
           doi_without_altmetric,
           citescore,
           scimago,
           qualis) {
    # header
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
      "<table class=\"tb\" style=\"width:100%;\">\n    <tr>\n      <th>Produtos (n = ",
      max(dim(doi_with_altmetric)[1], 0) + max(dim(doi_without_altmetric)[1], 0),
      ") e Impactos (Altmetric^1^, Dimensions^2^, PlumX^3^, CiteScore^4^, SJR^5^, Qualis^6^, Open Access^7^) </th>\n    </tr>",
      sep = ""
    )
    
    # print table with DOI and Altmetric
    if (max(dim(doi_with_altmetric)[1], 0) != 0) {
      for (ix in 1:dim(doi_with_altmetric)[1]) {
        # add bibliography info
        cat("<tr><td valign=top;>")
        cat("<br>")
        cat(
          # add OPEN ACESS badge
          tryCatch(
            expr = {
              if (as.logical(doi_with_altmetric$is_oa[ix])) {
                cat(
                  "<a style=\"display: inline-block; float: left; margin:0.0em 0.2em 0.0em 0.0em; padding:0.0em 0.2em 0.0em 0.0em;\" href=\"",
                  doi_with_altmetric$url[ix],
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
            doi_with_altmetric$title[ix],
            "**](",
            doi_with_altmetric$url[ix],
            "){target=\"_blank\"}",
            "<br>"
          )
        )
        
        # add authors' names
        cat(doi_with_altmetric$author.names[ix])
        
        # add year
        cat(paste0(
          "<br>",
          paste0(doi_with_altmetric$published_on[ix], "&nbsp; - &nbsp;")
        ))
        
        # add journal's title
        cat(paste0("*", tools::toTitleCase(as.character(doi_with_altmetric$journal[ix])), "*", "<br>"))
        
        # initialize the DIV element for the badges
        cat("<div style=\"vertical-align: middle; display: inline-block;\">")
        
        # initialize the NOBR element for the badges
        cat("<nobr>")
        
        # add Altmetric badge
        if (show.Altmetric == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" class=\"altmetric-embed\" data-badge-type=\"donut\" data-badge-popover=\"right\" data-doi=\"",
            doi_with_altmetric$doi[ix],
            "\"></a>",
            sep = ""
          )
        }
        
        # add Dimensions badge
        if (show.Dimensions == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" data-legend=\"hover-right\" class=\"__dimensions_badge_embed__\" data-doi=\"",
            doi_with_altmetric$doi[ix],
            "\" data-style=\"small_circle\"></a>",
            sep = ""
          )
        }
        
        # add PlumX badge
        if (show.PlumX == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em; padding:0.5em 0.3em 0.5em 0.3em;\" class=\"plumx-plum-print-popup\" href=\"https://plu.mx/plum/a/?doi=",
            doi_with_altmetric$doi[ix],
            "\" data-popup=\"right\" data-size=\"medium\" data-site=\"plum\"></a>",
            sep = ""
          )
        }
        
        # add CiteScore
        if (show.CiteScore == TRUE) {
          citescore.out <-
            get_citescore(citescore = citescore, doi_with_altmetric = doi_with_altmetric[ix,])
          cat(
            "<a href=\"https://www.scopus.com/sourceid/",
            citescore.out$citescore_id,
            '?dgcid=sc_widget_citescore\" style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em; text-decoration:none;color:#505050\"><div style=\"height:64px;width:160px;font-family:Arial, Verdana, helvetica, sans-serif;background-color:#ffffff;display:inline-block\"><div style=\"padding: 0px 16px;\"><div style=\"padding-top:3px;line-height:1;\"><div style=\"float:left;font-size:28px\"><span id=\"citescoreVal\" style=\"letter-spacing: -2px;display: inline-block;padding-top: 7px;line-height: .75;\">',
            paste0(ifelse(
              identical(citescore.out$citescore_value, numeric(0)) |
                all(is.na(citescore.out$citescore_value)),
              "?",
              format(round(
                as.numeric(citescore.out$citescore_value), 2
              ), nsmall = 2)
            )),
            "</span></div><div style=\"float:right;font-size:14px;padding-top:3px;text-align: right;\"><span id=\"citescoreYearVal\" style=\"display:block;\">",
            ifelse(
              identical(citescore.out$citescore_year, numeric(0)) |
                all(is.na(citescore.out$citescore_year)),
              "?",
              citescore.out$citescore_year
            ),
            "</span>CiteScore</div></div><div style=\"clear:both;\"></div><div style=\"padding-top:3px;\"><div style=\"height:4px;background-color:#DCDCDC;\"><div style=\"height: 4px; background-color: rgb(0, 115, 152); width:",
            paste0(ifelse(
              identical(citescore.out$citescore_p, numeric(0)) |
                all(is.na(citescore.out$citescore_p)),
              "?",
              round(citescore.out$citescore_p, 0)
            )),
            "%;\" id=\"percentActBar\">&nbsp;</div></div><div style=\"font-size:11px;\"><span id=\"citescorePerVal\">",
            paste0(ifelse(
              identical(citescore.out$citescore_p, numeric(0)) |
                all(is.na(citescore.out$citescore_p)),
              "?",
              paste0(as.character(
                round(citescore.out$citescore_p, 0)
              ), "th percentile")
            )),
            "</span></div></div><div style=\"font-size:12px;text-align:right;\"></div></div></div></a>",
            sep = ""
          )
        }
        
        # add SJR
        if (show.SJR == TRUE) {
          sjr.out <- get_sjr(scimago = scimago, doi_with_altmetric = doi_with_altmetric[ix,])
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" href=\"https://www.scimagojr.com/journalsearch.php?q=",
            paste0(ifelse(
              identical(sjr.out$SJR_value, numeric(0)) |
                all(is.na(sjr.out$SJR_value)), "0?", sjr.out$SJR_id
            )),
            "&amp;tip=sid&amp;exact=no\" target=\"_blank\" title=\"SCImago Journal &amp; Country Rank\"><img border=\"0\" height=\"64px;\" src=\"https://www.scimagojr.com/journal_img.php?id=",
            paste0(ifelse(
              identical(sjr.out$SJR_value, numeric(0)) |
                all(is.na(sjr.out$SJR_value)), "0", sjr.out$SJR_id
            )),
            "\" alt=\"SCImago Journal &amp; Country Rank\"  /></a>",
            sep = ""
          )
        }
        
        # add QUALIS
        if (show.Qualis == TRUE) {
          cat(
            "<a style=\"border-radius:10%; border-style: solid; margin:0.1em 0.3em 0.1em 0.3em; padding:0.4em 0.3em 0.4em 0.3em; text-decoration:none; text-align: center; display:inline-block; float:left; color:black;\"> Qualis <br>",
            paste0(
              ifelse(
                identical(doi_with_altmetric$WebQualis[ix], numeric(0)) |
                  all(is.na(doi_with_altmetric$WebQualis[ix])),
                "?",
                doi_with_altmetric$WebQualis[ix]
              ),
              "</a>"
            ),
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
    if (max(dim(doi_without_altmetric)[1], 0) != 0) {
      for (ix in 1:dim(doi_without_altmetric)[1]) {
        # add bibliography info
        cat("<tr><td valign=top;>")
        cat("<br>")
        cat(
          # add OPEN ACESS badge
          tryCatch(
            expr = {
              if (as.logical(doi_without_altmetric$is_oa[ix])) {
                cat(
                  "<a style=\"display: inline-block; float: left; margin:0.0em 0.2em 0.0em 0.0em; padding:0.0em 0.2em 0.0em 0.0em;\" href=\"",
                  doi_without_altmetric$url[ix],
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
            doi_without_altmetric$title[ix],
            "**](https://doi.org/",
            doi_without_altmetric$doi[ix],
            "){target=\"_blank\"}",
            "<br>"
          )
        )
        
        # add authors' names
        cat(doi_without_altmetric$author.names[ix])
        
        # add year
        cat(paste0("<br>",
                   paste0(
                     ifelse(
                       !is.na(doi_without_altmetric$issued[ix]),
                       substr(doi_without_altmetric$issued[ix], 1, 4),
                       substr(doi_without_altmetric$created[ix], 1, 4)
                     ),
                     "&nbsp; - &nbsp;"
                   )))
        
        # add journal's title
        cat(paste0("*",
                   tools::toTitleCase(as.character(doi_without_altmetric$journal[ix])),
                   "*",
                   "<br>"))
        
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
            doi_without_altmetric$doi[ix],
            "\" data-style=\"small_circle\"></a>",
            sep = ""
          )
        }
        
        # add PlumX badge
        if (show.PlumX == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em; padding:0.4em 0.3em 0.4em 0.3em;\" class=\"plumx-plum-print-popup\" href=\"https://plu.mx/plum/a/?doi=",
            doi_without_altmetric$doi[ix],
            "\" data-popup=\"right\" data-size=\"medium\" data-site=\"plum\"></a>",
            sep = ""
          )
        }
        
        # add CiteScore
        if (show.CiteScore == TRUE) {
          citescore.out <-
            get_citescore(citescore = citescore, doi_without_altmetric = doi_without_altmetric[ix, ])
          cat(
            "<a href=\"https://www.scopus.com/sourceid/",
            citescore.out$citescore_id,
            '?dgcid=sc_widget_citescore\" style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em; text-decoration:none;color:#505050\"><div style=\"height:64px;width:160px;font-family:Arial, Verdana, helvetica, sans-serif;background-color:#ffffff;display:inline-block\"><div style=\"padding: 0px 16px;\"><div style=\"padding-top:3px;line-height:1;\"><div style=\"float:left;font-size:28px\"><span id=\"citescoreVal\" style=\"letter-spacing: -2px;display: inline-block;padding-top: 7px;line-height: .75;\">',
            paste0(ifelse(
              identical(citescore.out$citescore_value, numeric(0)) |
                all(is.na(citescore.out$citescore_value)),
              "?",
              format(round(
                as.numeric(citescore.out$citescore_value), 2
              ), nsmall = 2)
            )),
            "</span></div><div style=\"float:right;font-size:14px;padding-top:3px;text-align: right;\"><span id=\"citescoreYearVal\" style=\"display:block;\">",
            ifelse(
              identical(citescore.out$citescore_year, numeric(0)) |
                all(is.na(citescore.out$citescore_year)),
              "?",
              citescore.out$citescore_year
            ),
            "</span>CiteScore</div></div><div style=\"clear:both;\"></div><div style=\"padding-top:3px;\"><div style=\"height:4px;background-color:#DCDCDC;\"><div style=\"height: 4px; background-color: rgb(0, 115, 152); width:",
            paste0(ifelse(
              identical(citescore.out$citescore_p, numeric(0)) |
                all(is.na(citescore.out$citescore_p)),
              "?",
              round(citescore.out$citescore_p, 0)
            )),
            "%;\" id=\"percentActBar\">&nbsp;</div></div><div style=\"font-size:11px;\"><span id=\"citescorePerVal\">",
            paste0(ifelse(
              identical(citescore.out$citescore_p, numeric(0)) |
                all(is.na(citescore.out$citescore_p)),
              "?",
              paste0(as.character(
                round(citescore.out$citescore_p, 0)
              ), "th percentile")
            )),
            "</span></div></div><div style=\"font-size:12px;text-align:right;\"></div></div></div></a>",
            sep = ""
          )
        }
        
        # add SJR
        if (show.SJR == TRUE) {
          sjr.out <-
            get_sjr(scimago = scimago, doi_without_altmetric = doi_without_altmetric[ix, ])
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" href=\"https://www.scimagojr.com/journalsearch.php?q=",
            paste0(ifelse(
              identical(sjr.out$SJR_value, numeric(0)) |
                all(is.na(sjr.out$SJR_value)), "0?", sjr.out$SJR_id
            )),
            "&amp;tip=sid&amp;exact=no\" target=\"_blank\" title=\"SCImago Journal &amp; Country Rank\"><img border=\"0\" height=\"64px;\" src=\"https://www.scimagojr.com/journal_img.php?id=",
            paste0(ifelse(
              identical(sjr.out$SJR_value, numeric(0)) |
                all(is.na(sjr.out$SJR_value)), "0?", sjr.out$SJR_id
            )),
            "\" alt=\"SCImago Journal &amp; Country Rank\"  /></a>",
            sep = ""
          )
        }
        
        # add QUALIS
        if (show.Qualis == TRUE) {
          cat(
            "<a style=\"border-radius:10%; border-style: solid; margin:0.1em 0.3em 0.1em 0.3em; padding:0.4em 0.3em 0.4em 0.3em; text-decoration:none; text-align: center; display:inline-block; float:left; color:black;\"> Qualis <br>",
            paste0(
              ifelse(
                identical(doi_without_altmetric$WebQualis[ix], numeric(0)) |
                  all(is.na(doi_without_altmetric$WebQualis[ix])),
                "?",
                doi_without_altmetric$WebQualis[ix]
              ),
              "</a>"
            ),
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
    cat('^5^ [**SJR**](https://www.scimagojr.com)', sep = "")
    cat(', ', sep = "")
    cat(
      '^6^ [**WebQualis**](https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/veiculoPublicacaoQualis/listaConsultaGeralPeriodicos.jsf)',
      sep = "")
    cat(', ', sep = "")
    cat('^7^ [**DOAJ**](https://doaj.org)', sep = "")
    cat('<br>')
    cat('<br>')
    cat('<br><a style="float:right" href="#top"><b>Início &nbsp;</b>⬆️</a><br>')
  }
cat('<br>')
