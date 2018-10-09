library(shiny)
library(rJava)
library(ReporteRs)

shinyUI(
  
  fluidPage(    
    selectInput("select", label = "col", choices = colnames(iris)[2:4]),
    selectInput("color", label = "col", choices = c("red", "black", "blue", "green")),
    plotOutput("plot"),
    downloadButton('downloadData', 'Download')
  )
)