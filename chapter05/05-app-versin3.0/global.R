library(shiny)
library(googleAuthR)
library(googleAnalyticsR)
library(DT)
library(ggplot2)
library(Rmisc)

options(shiny.port = 1221)
options(googleAuthR.webapp.client_id = "xxxxxxxxxxxxx.apps.googleusercontent.com")
options(googleAuthR.webapp.client_secret = "xxxxxxxxxxxxxxxx")
options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/analytics.readonly"))

# used for ui.R
color_choise <- c("YlOrRd", "YlOrBr", "YlGnBu", "YlGn", "Reds", "RdPu", 
                  "Purples", "PuRd", "PuBuGn", "PuBu", "OrRd", "Oranges", "Greys", "Greens", 
                  "GnBu", "BuPu", "BuGn", "Blues", "Set3", "Set2", "Set1", "Pastel2", 
                  "Pastel1", "Paired", "RColorBrewe", "Dark2", "Accent", "Spectral", 
                  "RdYlGn", "RdYlBu", "RdGy", "RdBu", "PuOr", "PRGn", "PiYG", "BrBG")

# used for server.R
modify_dimensions_length_to_1 <- function(data, dimensions_length) {
  paste_dim <- data[, 1]
  if (dimensions_length > 1) {
    for (i in 2:dimensions_length) {
      paste_dim <- paste(paste_dim, data[, i], sep = "-")
    }
  }
  return(paste_dim)
}

modify_dimensions_length_to_2 <- function(data, dimensions_length) {
  paste_dim1 = data[, 1]
  paste_dim2 = data[, 2]
  if (dimensions_length > 2) {
    for (i in 3:dimensions_length) {
      paste_dim2 <- paste(paste_dim2, data[, i], sep = "-")
    }
  }
  return(list(paste_dim1, paste_dim2))
}

modify_dimensions_length_to_3 <- function(data, dimensions_length) {
  paste_dim1 = data[, 1]
  paste_dim2 = data[, 2]
  paste_dim3 = data[, 3]
  
  if (dimensions_length > 3) {
    for (i in 4:dimensions_length) {
      paste_dim3 <- paste(paste_dim3, data[, i], sep = "-")
    }
  }
  return(list(paste_dim1, paste_dim2, paste_dim3))
}