library(shiny)
library(DT)

shinyUI(fluidPage(
  
  titlePanel("DTで行・列・セルを選択"),
  
  fluidRow(
    column(
      6, h1('行を選択'), hr(),
      DT::dataTableOutput('data1'),
      verbatimTextOutput('rows_selected')
    ),
    column(
      6, h1('列を選択'), hr(),
      DT::dataTableOutput('data2'),
      verbatimTextOutput('columns_selected')
    ),
    column(
      6, h1('セルを選択'), hr(),
      DT::dataTableOutput('data3'),
      verbatimTextOutput('cells_selected')
    )
  )
))