library(shiny)

shinyUI(fluidPage(
  
  titlePanel("updateSelectInput"),
  
  radioButtons("input_radio_button", "Input radioButtons",
               c("Tokyo", "Gumma", "Ibaraki"), selected = "Tokyo"),
  selectInput("choices", "Select input",
              c("Tokyo", "Gumma", "Ibaraki"))
))