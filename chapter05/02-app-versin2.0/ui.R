shinyUI(
  navbarPage("Shiny - Google アナリティクス API",
             tabPanel("Google アカウント連携", tabName = "setup", icon = icon("cogs"),
                      h1("Setup"),
                      googleAuthUI("Google_login"),
                      authDropdownUI("viewId_select")),
             tabPanel("メトリクスとディメンション", tabName = "calc_metrics", 
                      icon = icon("bar-chart-o"))
  )
)