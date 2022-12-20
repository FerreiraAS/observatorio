# function to obtain the first letter of each word in a vector of strings
initials <- function(names) {
  initials <- c()
  for (j in 1:length(names)) {
    names[j] <- gsub(" A ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" À ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" E ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" DA ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" NA ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" DE ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" DO ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" NO ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" DOS ", " ", names[j], fixed = TRUE)
    names[j] <- gsub(" EM ", " ", names[j], fixed = TRUE)
    names.temp <-
      c(" ", (unlist(strsplit(
        str_trim(str_trim(names[j], side = c("left")), side = c("right")), split = ""
      ))))
    initials.temp <- c()
    for (i in 1:length(names.temp)) {
      if (names.temp[i] == " ") {
        initials.temp <- paste(initials.temp, " ", names.temp[i + 1])
      }
    }
    initials.temp <- gsub(" ", "", initials.temp, fixed = TRUE)
    initials <- c(initials, initials.temp)
  }
  return('initials' = initials)
}