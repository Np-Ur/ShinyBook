library(shiny)

shinyUI(
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        fileInput("file", "CSVファイルをアップロード",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")
        )
      ),
      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Table", tableOutput('table'))
        )
      )
    )
  )
)