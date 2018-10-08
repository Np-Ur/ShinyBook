library(shiny)

shinyUI(fluidPage(
  
  titlePanel("selectInputの例"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("selectInputId",
                  "何か選択してください。",
                  choices = c("東京" = "Tokyo",
                              "茨城" = "Ibaraki",
                              "群馬" = "gumma")
      )
    ),
    mainPanel(
      textOutput("text")
    )
  )
))