# X-Twitter
# https://developer.x.com/en/docs/twitter-for-websites/tweet-button/overview
cat("[", sep = "")
cat(
  fontawesome::fa(
    "x-twitter",
    margin_left = "0.2em",
    margin_right = "0.2em",
    height = "2em",
    width = "2em"
  )
)
cat("](https://twitter.com/intent/tweet?url=", home, ") ", sep = "")

# facebook
# https://www.facebook.com
cat("[", sep = "")
cat(
  fontawesome::fa(
    "facebook-square",
    margin_left = "0.2em",
    margin_right = "0.2em",
    height = "2em",
    width = "2em"
  )
)
cat('](https://www.facebook.com/sharer.php?u=', home, ') ', sep = "")

# LinkedIn
# https://www.linkedin.com
cat("[", sep = "")
cat(
  fontawesome::fa(
    "linkedin",
    margin_left = "0.2em",
    margin_right = "0.2em",
    height = "2em",
    width = "2em"
  )
)
cat('](https://www.linkedin.com/shareArticle?mini=true&amp;url=',
    home,
    ') ',
    sep = "")
