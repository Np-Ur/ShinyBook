library(shiny)

shinyServer(function(input, output) {
  
  output$text <- renderText({
    paste("あなたが選択したのは", input$selectInputId, "です。")
  })
})