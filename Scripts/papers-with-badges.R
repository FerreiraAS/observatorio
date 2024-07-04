table.with.badges <-
  function(show.Altmetric = NULL,
           show.Dimensions = NULL,
           show.PlumX = NULL,
           show.CiteScore = NULL,
           show.SJR = NULL,
           show.Qualis = NULL,
           metricas_all_produtos) {
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
    
    # get unique ID
    uniqueID <- unique(metricas_all_produtos$"ID da Produção")
    
    # start table
    cat(
      "<table class=\"tb\" style=\"width:100%;\">\n    <tr>\n      <th>Produtos (n = ",
      max(length(uniqueID), 0),
      ") e Métricas (Altmetric^1^, Dimensions^2^, PlumX^3^, CiteScore^4^, SJR^5^, Qualis^6^, Open Access^7^) </th>\n    </tr>",
      sep = ""
    )
    
    # print table with DOI and Altmetric
    if (!sjmisc::is_empty(uniqueID)) {
      for (ix in 1:length(uniqueID)) {
        # get sub metadata for the ID
        sub_metadata <- metricas_all_produtos[metricas_all_produtos$ID == uniqueID[ix], ]
        
        is_oa <- as.logical(unique(na.omit(sub_metadata$is_oa)))
        doi <- unique(na.omit(sub_metadata$DOI))
        title <- unique(na.omit(sub_metadata$"Nome da Produção"))
        altmetric <- unique(na.omit(sub_metadata$altmetric_score))
        source_id <- unique(na.omit(sub_metadata$source_id))
        source_year <- unique(na.omit(sub_metadata$CiteScore_year))
        CiteScore <- unique(na.omit(sub_metadata$CiteScore))
        Qualis <- unique(na.omit(sub_metadata$Qualis))
        
        cat("<tr><td valign=top;>")
        cat("<br>")
        # add title with link to DOI
        if (length(doi) != 0 | !sjmisc::is_empty(doi)) {
          cat(paste0('[**', title, '**](https://doi.org/', doi, '){target="_blank"}'), sep = "")
        } else {
          cat(paste0('**', title, '**'), sep = "")
        }
        
        # add OPEN ACCESS badge
        # if (length(is_oa) != 0 & !sjmisc::is_empty(is_oa)) {
        #   if (is_oa) {
        #     cat(
        #       '<a style="display: inline-block; float: left; margin:0.0em 0.2em 0.0em 0.0em; padding:0.0em 0.2em 0.0em 0.0em;" href="',
        #       "https://doi.org/",
        #       doi,
        #       '" target="_blank">',
        #       '<img height="18px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Open_Access_logo_PLoS_white.svg/256px-Open_Access_logo_PLoS_white.svg.png">',
        #       '</a>\n'
        #     )
        #   }
        # }
        cat("<br>")
        
        # initialize the DIV element for the badges
        cat("<div style=\"vertical-align: middle; display: inline-block;\">")
        
        # initialize the NOBR element for the badges
        cat("<nobr>")
        
        # add Altmetric badge
        if (show.Altmetric == TRUE) {
            if (!sjmisc::is_empty(altmetric)) {
            cat(
              "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" class=\"altmetric-embed\" data-badge-type=\"donut\" data-badge-popover=\"right\" data-doi=\"",
              doi,
              "\"></a>",
              sep = ""
            )
          } else
            cat(
              "<img style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" src=\"https://badges.altmetric.com/?score=?&types=????????\">",
              sep = ""
            )
        }
        
        # add Dimensions badge
        if (show.Dimensions == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" data-legend=\"hover-right\" class=\"__dimensions_badge_embed__\" data-doi=\"",
            ifelse(!sjmisc::is_empty(doi), doi, NA),
            "\" data-style=\"small_circle\"></a>",
            sep = ""
          )
        }
        
        # add PlumX badge
        if (show.PlumX == TRUE) {
          cat(
            '<a href="https://plu.mx/plum/a/?doi=',
            doi,
            '" data-popup="hidden" data-size="medium" class="plumx-plum-print-popup" data-site="plum" data-hide-when-empty="false"></a>',
            sep = ""
          )
        }
        
        # add QUALIS
        if (show.Qualis == TRUE) {
          cat(
            "<a style=\"border-radius:10%; border-style: solid; margin:0.1em 0.3em 0.1em 0.3em; padding:0.4em 0.3em 0.4em 0.3em; text-decoration:none; text-align: center; display:inline-block; float:left; color:black;\"> Qualis <br>",
            paste0(ifelse(
              sjmisc::is_empty(Qualis), "?", Qualis
            ), "</a>"),
            sep = ""
          )
        }
        
        # add SJR
        if (show.SJR == TRUE) {
          cat(
            "<a style=\"display: inline-block; float: left; margin:0.1em 0.3em 0.1em 0.3em;\" href=\"https://www.scimagojr.com/journalsearch.php?q=",
            paste0(ifelse(
              is.na(source_id), "0?", source_id
            )),
            "&amp;tip=sid&amp;exact=no\" target=\"_blank\" title=\"SCImago Journal &amp; Country Rank\"><img border=\"0\" height=\"64px;\" src=\"https://www.scimagojr.com/journal_img.php?id=",
            paste0(ifelse(
              is.na(source_id), "0", source_id
            )),
            "\" alt=\"SCImago Journal &amp; Country Rank\"  /></a>",
            sep = ""
          )
        }
        
        # add CiteScore
        if (show.CiteScore == TRUE) {
          cat(
            '<a href="https://www.scopus.com/sourceid/28773?dgcid=sc_widget_citescore" style="text-decoration:none; color:#505050;"> <div style="height:100px; width:120px; font-family:Arial, Verdana, helvetica, sans-serif; background-color:#ffffff; display:inline-block;"><div style="padding:0px16p;"><div style="padding-top:3px; line-height:1;"><div style="float:left; font-size:28px;"><span id="citescoreVal" style="letter-spacing:-2px; display:inline-block; padding-top:7px; line-height:.75;">',
            format(CiteScore, nsmall = 1),
            '</span></div><div style="float:right; font-size:14px; padding-top:3px; text-align: right;"><span id="citescoreYearVal" style="display:block;">',
            as.character(source_year),
            '</span>CiteScore</div></div><div style="clear:both;"></div><div style="padding-top:3px;"><div style="height:4px; background-color:#DCDCDC;"><div style="height:4px; background-color:#007398;" id="percentActBar">&nbsp;</div></div><div style="font-size:11px;"><span id="citescorePerVal">',
            '?th percentile',
            '</span></div></div><div style="font-size:12px; text-align:right;">Powered by &nbsp;<span><img alt="Scopus" style="width:50px; height:15px;" src="https://www.scopus.com/static/images/scopusLogoOrange.svg"></span></div></div></div></a>',
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
    
    # add footnotes
    cat('**Fontes**:', sep = "")
    cat('^1^ [**Altmetric**](https://www.altmetric.com)', sep = "")
    cat(', ', sep = "")
    cat('^2^ [**Dimensions**](https://www.dimensions.ai)', sep = "")
    cat(', ', sep = "")
    cat('^3^ [**PlumX**](https://plu.mx)', sep = "")
    cat(', ', sep = "")
    cat('^4^ [**CiteScore**](https://www.scopus.com/sources)', sep = "")
    cat(', ', sep = "")
    cat('^5^ [**SJR**](https://www.scimagojr.com)', sep = "")
    cat(', ', sep = "")
    cat('^6^ [**Qualis**](https://sucupira.capes.gov.br/sucupira/public/consultas/coleta/veiculoPublicacaoQualis/listaConsultaGeralPeriodicos.jsf)', sep = "")
    cat(', ', sep = "")
    cat('^7^ [**DOAJ**](https://doaj.org)', sep = "")
    cat('<br>')
    cat('<br>')
    cat(
      '<br><a style="float:right" href="#top"><b>Início &nbsp;</b>',
      fontawesome::fa("circle-arrow-up"),
      '</a><br>'
    )
  }
cat('<br>')
