library(shiny)

shinyServer(function(input, output, session) {
  observe({
    if (input$input_radio_button == "Tokyo") {
      choiceList = c("Shinjuku", "Shibuya", "Shinagawa")
    } else if (input$input_radio_button == "Gumma") {
      choiceList = c("Maebashi", "Takasaki", "Kiryu")
    } else {
      choiceList = c("Mito", "Tsuchiura", "Tsukuba")
    }
    
    updateSelectInput(session, "choices",
                      label = "Select input label",
                      choices = choiceList)
  })
})