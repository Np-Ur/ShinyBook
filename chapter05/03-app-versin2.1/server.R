shinyServer(function(input, output, session) {
  token <- callModule(googleAuth, "Google_login")
  
  ga_accounts <- reactive({
    validate(need(token(), "Googleアカウントと連携してください"))
    with_shiny(ga_account_list, shiny_access_token = token())
  })
  
  selected_id <- callModule(authDropdown, "viewId_select", 
                            ga.table = ga_accounts)
  
  # 以下追加部分
  selected_dimensions <- callModule(multi_select, "dimensions", 
                                    type = "DIMENSION", subType = "all")
  selected_metrics <- callModule(multi_select, "metrics", type = "METRIC", 
                                 subType = "all")
  
  data_from_api <- eventReactive(input$get_data, {
    with_shiny(google_analytics, viewId = selected_id(), 
               date_range = input$date_range, metrics = selected_metrics(), 
               dimensions = selected_dimensions(), 
               shiny_access_token = token())
  })
  
  output$data_table <- DT::renderDataTable({
    dimensions_length <- length(selected_dimensions())
    data <- data_from_api()
    data_col_number <- ncol(data)
    
    data[, (dimensions_length + 1):data_col_number] <- 
      round(data[, (dimensions_length + 1):data_col_number], 3)
    
    data
  })
})