library(shiny)
library(googleAuthR)
library(googlesheets)
library(DT)

googlesheets::gs_auth(token = "shiny_app_token.rds")

shinyServer(function(input, output, session) {
  
  output$all_files <- DT::renderDataTable({
    return(gs_ls())
  })
  
  output$table <- DT::renderDataTable({
    input$get_data
    selected_data <- gs_read(gs_title(isolate(input$file_name)),
                             ws = as.integer(isolate(input$sheet_id)))
    return(selected_data)
  })
})