library(shiny)

shinyUI(fluidPage(
  titlePanel("INPUTの形式一覧"),
  
  fluidRow(
    column(4,
           h3("checkboxInput"),
           checkboxInput("checkbox",
                         "Choice A",
                         value = TRUE)),
    
    column(4,
           checkboxGroupInput("checkboxGroupInput",
                              h3("checkboxGroupInput"),
                              choices = list("Choice 1" = 1,
                                             "Choice 2" = 2,
                                             "Choice 3" = 3),
                              selected = 1)),
    column(4,
           dateInput("date",
                     h3("dateInput"),
                     value = "2016-01-01"))
  ),
  
  fluidRow(
    column(4,
           dateRangeInput("dateRangeInput", h3("dateRangeInput"))),
    
    
    column(4,
           textInput("text", h3("textInput"),
                     value = "Enter text...")),
    
    column(4,
           numericInput("num",
                        h3("numericinput"),
                        value = 1))
  ),
  
  fluidRow(
    column(4,
           selectInput("select", h3("selectInput"),
                       choices = list("Choice 1" = 1, "Choice 2" = 2,
                                      "Choice 3" = 3, "Choice 4" = 4), selected = 1)),
    
    column(4,
           sliderInput("sliderInput1", h3("sliderInput1"),
                       min = 0, max = 100, value = 50),
           sliderInput("sliderInput2", h3("sliderInput2"),
                       min = 0, max = 100, value = c(25, 75))
    )
  )
  
))