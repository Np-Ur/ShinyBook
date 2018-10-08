library(shiny)

shinyUI(fluidPage(
  
  titlePanel("download"),
  
  fluidRow(
    column(6, plotOutput("plot", brush = brushOpts(id = "brush")),
           downloadButton('download_data', 'Download')),
    column(6, DT::dataTableOutput("brushed_point"))
  )
))