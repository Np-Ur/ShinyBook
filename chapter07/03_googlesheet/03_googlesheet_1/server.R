library(shiny)
library(googleAuthR)
library(googlesheets)
library(DT)

options(shiny.port = 1221)
options("googlesheets.webapp.client_id" = "クライアントID")
options("googlesheets.webapp.client_secret" = "シークレットキー")
options("googlesheets.webapp.redirect_uri" = "http://127.0.0.1:1221")

shinyServer(function(input, output, session) {
  gs_deauth(clear_cache = TRUE)
  
  # ログインボタン
  output$login_button <- renderUI({
    if (!is.null(access_token())) {
      return()
    }
    tags$a("Authorize App",
           href = gs_webapp_auth_url(),
           class = "btn btn-default")
  })
  
  # ログアウトボタン
  output$logout_button <- renderUI({
    if (is.null(access_token())) {
      return()
    }
    tags$a("Logout",
           href = getOption("googlesheets.webapp.redirect_uri"),
           class = "btn btn-default")
  })
  
  # token取得部分
  access_token  <- reactive({
    pars <- parseQueryString(session$clientData$url_search)
    
    if (length(pars$code) > 0) {
      gs_webapp_get_token(auth_code = pars$code)
    } else {
      NULL
    }
  })
  
  output$all_files <- DT::renderDataTable({
    if (is.null(access_token())) {
      return()
    }
    
    files <- with_shiny(f = gs_ls,
                        shiny_access_token = access_token())
    return(files)
  })
  
  output$table <- DT::renderDataTable({
    if (is.null(access_token())) {
      return()
    }
    
    input$get_data
    selected_data <- with_shiny(f = gs_read,
                                shiny_access_token = access_token(),
                                gs_title(isolate(input$file_name)),
                                ws = as.integer(isolate(input$sheet_id)))
    return(selected_data)
  })
})