shinyServer(function(input, output, session) {
  token <- callModule(googleAuth, "Google_login")
  
  ga_accounts <- reactive({
    validate(need(token(), "Googleアカウントと連携してください"))
    with_shiny(ga_account_list, shiny_access_token = token())
  })
  
  selected_id <- callModule(authDropdown, "viewId_select", ga.table = ga_accounts)
  
  selected_dimensions <- callModule(multi_select, "dimensions", type = "DIMENSION", 
                                    subType = "all")
  selected_metrics <- callModule(multi_select, "metrics", type = "METRIC", subType = "all")
  
  data_from_api <- eventReactive(input$get_data, {
    with_shiny(google_analytics, viewId = selected_id(), 
               date_range = input$date_range, metrics = selected_metrics(), 
               dimensions = selected_dimensions(), shiny_access_token = token())
  })
  
  output$data_table <- DT::renderDataTable({
    dimensions_length <- length(selected_dimensions())
    data <- data_from_api()
    data_col_number <- ncol(data)
    
    data[, (dimensions_length + 1):data_col_number] <- 
      round(data[, (dimensions_length + 1):data_col_number], 3)
    
    data
  })
  
  plot_list <- eventReactive(input$get_plot, {
    
    metrics_length <- length(selected_metrics())
    dimensions_length <- length(selected_dimensions())
    
    data_for_graph <- as.data.frame(data_from_api())
    data_col_number <- ncol(data_for_graph)
    
    data_for_graph[, (dimensions_length + 1):data_col_number] <- 
      round(data_for_graph[, (dimensions_length + 1):data_col_number], 3)
    
    input_graph_type <- input$graph_type
    plots <- list()
    
    # 円グラフの処理
    if (input_graph_type == "円グラフ") {
      paste_dimension <- modify_dimensions_length_to_1(data_for_graph, dimensions_length)
      
      for (i in 1:metrics_length) {
        metrics_name = colnames(data_for_graph)[(dimensions_length + i)]
        tmp_data_for_plot = data.frame(metrics = data_for_graph[, (dimensions_length + i)], 
                                       dimension = paste_dimension)
        
        g <- ggplot(tmp_data_for_plot, aes(x = "", y = metrics, fill = dimension, 
                                           label = metrics))
        g <- g + geom_bar(width = 1, stat = "identity")
        g <- g + labs(title = metrics_name)
        g <- g + coord_polar("y")
        g <- g + geom_text(aes(x = "", y = metrics, label = metrics), 
                           size = 6, position = position_stack(vjust = 0.5))
        g <- g + theme(plot.title = element_text(size = 25, face = "bold"))
        g <- g + scale_fill_brewer(palette = input$color_type)
        
        plots[[i]] <- g
      }
      
      return(plots)
    }
    
    # 棒グラフ1 or 2の処理
    if ((input_graph_type == "棒グラフ1") || (input_graph_type == "棒グラフ2")) {
      if (dimensions_length == 1) {
        
        for (i in 1:metrics_length) {
          metrics_name <- colnames(data_for_graph)[(dimensions_length + i)]
          tmp_data_for_plot <- data.frame(metrics = data_for_graph[, (dimensions_length + i)], 
                                          dimension = data_for_graph[, 1])
          
          g <- ggplot(tmp_data_for_plot, aes(x = dimension, y = metrics, fill = dimension))
          g <- g + geom_bar(width = 0.8, stat = "identity") + labs(title = metrics_name)
          g <- g + theme(plot.title = element_text(size = 25, face = "bold"))
          g <- g + scale_fill_brewer(palette = input$color_type)
          
          plots[[i]] <- g
        }
        return(plots)
      }
      
      paste_dimension <- modify_dimensions_length_to_2(data_for_graph, dimensions_length)
      
      for (i in 1:metrics_length) {
        metrics_name <- colnames(data_for_graph)[(dimensions_length + i)]
        tmp_data_for_plot <- data.frame(metrics = data_for_graph[, (dimensions_length + i)], 
                                        dimension1 = paste_dimension[[1]], 
                                        dimension2 = paste_dimension[[2]])
        
        g <- ggplot(tmp_data_for_plot, aes(x = dimension1, y = metrics, fill = dimension2))
        
        if (input_graph_type == "棒グラフ1") {
          g <- g + geom_bar(width = 0.8, stat = "identity") + labs(title = metrics_name)
        } else {
          g <- g + geom_bar(position = "dodge", width = 0.8, stat = "identity") + 
            labs(title = metrics_name)
        }
        
        g <- g + theme(plot.title = element_text(size = 25, face = "bold"))
        g <- g + scale_fill_brewer(palette = input$color_type)
        
        plots[[i]] <- g
      }
      return(plots)
    }
    
    
    # 折れ線グラフと面グラフの処理
    if ((input_graph_type == "折れ線グラフ") || (input_graph_type == "面グラフ")) {
      if (dimensions_length == 1) {
        for (i in 1:metrics_length) {
          metrics_name <- colnames(data_for_graph)[(dimensions_length + i)]
          tmp_data_for_plot <- data.frame(metrics = data_for_graph[, (dimensions_length + i)], 
                                          dimension = data_for_graph[, 1])
          
          g <- ggplot(tmp_data_for_plot, aes(x = dimension, y = metrics))
          
          if (input_graph_type == "折れ線グラフ") {
            g <- g + geom_point() + geom_line()
            g <- g + scale_color_brewer(palette = input$color_type)
          } else {
            g <- g + geom_area()
            g <- g + scale_fill_brewer(palette = input$color_type)
          }
          g <- g + labs(title = metrics_name)
          g <- g + theme(plot.title = element_text(size = 25, face = "bold"))
          
          plots[[i]] <- g
        }
        
        return(plots)
      }
      
      paste_dimension <- modify_dimensions_length_to_2(data_for_graph, dimensions_length)
      
      for (i in 1:metrics_length) {
        metrics_name <- colnames(data_for_graph)[(dimensions_length + i)]
        
        tmp_data_for_plot <- data.frame(metrics = data_for_graph[, (dimensions_length + i)], 
                                        dimension1 = paste_dimension[[1]], 
                                        dimension2 = paste_dimension[[2]])
        
        if (input_graph_type == "折れ線グラフ") {
          g <- ggplot(tmp_data_for_plot, aes(x = dimension1, y = metrics, color = dimension2))
          g <- g + geom_point() + geom_line()
          g <- g + scale_color_brewer(palette = input$color_type)
        } else {
          g <- ggplot(tmp_data_for_plot, aes(x = dimension1, y = metrics))
          g <- g + geom_area(aes(group = dimension2, fill = dimension2))
          g <- g + scale_fill_brewer(palette = input$color_type)
        }
        
        g <- g + labs(title = metrics_name) + 
          theme(plot.title = element_text(size = 25, face = "bold"))
        
        plots[[i]] <- g
      }
      return(plots)
    }
    
    
    # 散布図の処理
    if (input_graph_type == "散布図") {
      if (dimensions_length == 1) {
        for (i in 1:metrics_length) {
          metrics_name <- colnames(data_for_graph)[(dimensions_length + i)]
          tmp_data_for_plot <- data.frame(metrics = data_for_graph[, (dimensions_length + i)], 
                                          dimension = data_for_graph[, 1])
          g <- ggplot(tmp_data_for_plot, aes(x = dimension, y = metrics))
          g <- g + geom_point() + labs(title = metrics_name)
          g <- g + theme(plot.title = element_text(size = 25, face = "bold"))
          g <- g + scale_color_brewer(palette = input$color_type)
          
          plots[[i]] = g
        }
        return(plots)
      }
      
      if (dimensions_length <= 2) {
        for (i in 1:metrics_length) {
          metrics_name <- colnames(data_for_graph)[(dimensions_length + i)]
          tmp_data_for_plot <- data.frame(metrics = data_for_graph[, (dimensions_length + i)], 
                                          dimension1 = data_for_graph[, 1], 
                                          dimension2 = data_for_graph[, 2])
          g <- ggplot(tmp_data_for_plot, aes(x = dimension1, y = metrics))
          g <- g + geom_point(aes(colour = dimension2)) + labs(title = metrics_name)
          g <- g + theme(plot.title = element_text(size = 25, face = "bold"))
          g <- g + scale_color_brewer(palette = input$color_type)
          
          plots[[i]] <- g
        }
        return(plots)
      }
      
      paste_dimension <- modify_dimensions_length_to_3(data_for_graph, dimensions_length)
      
      for (i in 1:metrics_length) {
        metrics_name <- colnames(data_for_graph)[(dimensions_length + i)]
        tmp_data_for_plot <- data.frame(metrics = data_for_graph[, (dimensions_length + i)], 
                                        dimension1 = paste_dimension[[1]], 
                                        dimension2 = paste_dimension[[2]], 
                                        dimension3 = paste_dimension[[3]])
        
        g <- ggplot(tmp_data_for_plot, aes(x = dimension1, y = metrics, colour = dimension2))
        g <- g + geom_point(aes(colour = dimension2, shape = dimension3)) + 
          labs(title = metrics_name)
        g <- g + theme(plot.title = element_text(size = 25, face = "bold"))
        g <- g + scale_color_brewer(palette = input$color_type)
        
        plots[[i]] <- g
      }
      return(plots)
    }
  })
  
  output$plot <- renderPlot({
    multiplot(plotlist = plot_list(), cols = 2)
  })
  
  output$download_data <- downloadHandler(
    filename <- "shiny.pptx",
    content <- function(file){
      doc <- pptx()
      doc <- addSlide(doc, "Title Slide")
      doc <- addTitle(doc,"Shinyで作ったパワーポイントです")
      doc <- addSubtitle(doc, "Google アナリティクスのデータを可視化")
      
      for (i in 1:length(plot_list())){
        doc <- addSlide(doc, "Title and Content")
        doc <- addTitle(doc, input$graph_title)
        doc <- addPlot(doc, fun = print, x = plot_list()[[i]])
      }
      
      writeDoc(doc, file)
    }
  )
})