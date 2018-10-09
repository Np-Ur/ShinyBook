shinyUI(
  navbarPage("Shiny - Google アナリティクス API",
             tabPanel("Google アカウント連携", tabName = "setup", icon = icon("cogs")),
             tabPanel("メトリクスとディメンション", tabName = "calc_metrics", 
                      icon = icon("calculator"))
  )
)