library(shiny)

shinyUI(fluidPage(
  
  titlePanel("shiny-module"),
  
  fluidRow(
    column(6, histPlotUI("bins1", "left")),
    column(6, histPlotUI("bins2", "right"))
  )
))