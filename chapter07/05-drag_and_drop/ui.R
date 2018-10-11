library(shiny)

shinyUI(
  fluidPage(
    tags$head(tags$link(rel = "stylesheet", href = "style.css", type = "text/css"),
              tags$script(src = "drag.js")),
    sidebarLayout(
      sidebarPanel(
        h3("赤枠にデータをドロップ"),
        div(id="drop-area", ondragover = "f1(event)", ondrop = "f2(event)")
      ),
      mainPanel(
        tableOutput('table')
      )
    )
  )
)