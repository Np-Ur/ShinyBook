library(shiny)
library(shinycssloaders)

shinyUI(fluidPage(
  
  titlePanel("shinycssloaders を使った例"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1, max = 50, value = 30)
    ),
    
    mainPanel(
      withSpinner(plotOutput("distPlot"), type = 1, color.background = "white")
    )
  )
))
