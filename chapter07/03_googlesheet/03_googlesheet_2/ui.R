library(shiny)
library(DT)

shinyUI(fluidPage(
  titlePanel("Google Spread sheet"),
  
  sidebarLayout(
    sidebarPanel(
      textInput('file_name','ファイル名'),
      numericInput('sheet_id','sheet', value = 1, min = 1, max = 26),
      actionButton("get_data", "データを取得")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("file一覧", DT::dataTableOutput("all_files")),
        tabPanel("Table", DT::dataTableOutput("table"))
      )
    )
  )
)
)