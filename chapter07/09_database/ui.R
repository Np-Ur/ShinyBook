shinyUI(
  fluidPage(
    textInput("id", "検索したいIDを入力してください。", "5"),
    tableOutput("table")
  )
)
