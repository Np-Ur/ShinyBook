library(shiny)

shinyUI(fluidPage(
  
  titlePanel("absolutePanelの例"),
  
  sidebarLayout(
    plotOutput("distPlot"),
    absolutePanel(draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                  width = 350, height = "auto",
                  h2("absolutePanel"),
                  sliderInput("bins",
                              "Number of bins:",
                              min = 1, max = 50, value = 30)
    )
  )
))