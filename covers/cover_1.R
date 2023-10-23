W <- 8.27
H <- 11.69

for(i in 1:2){
  
  if(i == 1){
    grDevices::png(file = "images/Cover_1.png",
                   width = W,
                   height = H,
                   units = "in",
                   res = 300)
  } else {
    grDevices::pdf(file = "covers/Cover_1.pdf",
                   width = W,
                   height = H)
  }
  par(mar = c(0, 0, 0, 0), oma = c(0, 0, 0, 0), omi = c(0, 0, 0, 0), mai = c(0, 0, 0, 0), bg = "black")
  plot(1, type = "n", xlab = "", ylab = "", xlim = c(0,W), ylim = c(0,H))
  
  # author name
  text(x = W, y = H - 0.5, labels = substitute(paste(bold(tools::toTitleCase(as.character(nome.IES))))), pos = 2, cex = 2, col = "white")
  
  # book title
  text(x = W, y = H/2 + 2 - 1, labels = substitute(paste(bold("Autoavaliação"))), pos = 2, cex = 6.5, col = "yellow")

  # book subtitle
  text(x = W, y = H/2 + 3 - 2.75, labels = substitute(paste(italic(as.character(nome.PPG)))), pos = 2, cex = 1.5, col = "white")

  # year
  text(x = W/2, y = 0, labels = format(Sys.Date(), "%Y"), adj = c(0,0), cex = 1.5, col = "white")
  
  grDevices::dev.off()
}
