library(shiny)
library(googleAuthR)
library(googleAnalyticsR)

options(shiny.port = 1221)
options(googleAuthR.webapp.client_id = "xxxxxxxxxxxxx.apps.googleusercontent.com")
options(googleAuthR.webapp.client_secret = "xxxxxxxxxxxxxxxx")
options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/analytics.readonly"))
