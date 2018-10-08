library(shiny)

shinyUI(fluidPage(
  
  titlePanel("shiny-module"),
  
  fluidRow(
    column(6,
           sliderInput("bins1",
                       "Number of bins:",
                       min = 1, max = 50, value = 30),
           plotOutput("plot1")
    ),
    column(6,
           sliderInput("bins2",
                       "Number of bins:",
                       min = 1, max = 50, value = 30),
           plotOutput("plot2")
    )
  )
))