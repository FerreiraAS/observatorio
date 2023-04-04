# rorcid walkthrough
# by Clarke Iakovakis
# vhttps://ciakovx.github.io/rorcid.html

# copy/paste your client ID from https://orcid.org/developer-tools
orcid_client_id <- "APP-M86K45OXXQ2REL18"

# copy/paste your client secret from https://orcid.org/developer-tools
orcid_client_secret <- "e9eae410-9ee9-4d47-85a0-1815993194e3"

orcid_request <- httr::POST(
  url  = "https://orcid.org/oauth/token",
  config = httr::add_headers(`Accept` = "application/json",
                             `Content-Type` = "application/x-www-form-urlencoded"),
  body = list(
    grant_type = "client_credentials",
    scope = "/read-public",
    client_id = orcid_client_id,
    client_secret = orcid_client_secret
  ),
  encode = "form"
)

orcid_response <- httr::content(orcid_request)
print(orcid_response$access_token)
ORCID_TOKEN <- orcid_response

usethis::edit_r_environ()

# save and restart R
