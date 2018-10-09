shinyServer(function(input, output, session) {
  token <- callModule(googleAuth, "Google_login")
  
  ga_accounts <- reactive({
    validate(
      need(token(), "Googleアカウントと連携してください")
    )
    with_shiny(ga_account_list, shiny_access_token = token())
  })
  
  selected_id <- callModule(authDropdown, "viewId_select", ga.table = ga_accounts)
})