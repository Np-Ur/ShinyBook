library(shiny)

shinyUI(fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      selectInput("color", "select color",
                  c("red", "blue", "green", "black"))
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
))