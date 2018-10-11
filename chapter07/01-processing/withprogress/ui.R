library(shiny)

shinyUI(fluidPage(
  
  titlePanel("withProgress を使った例"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1, max = 50, value = 30)
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))