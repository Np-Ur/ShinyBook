library(shiny)
library(shinythemes)

shinyUI(
  # tagList(shinythemes::themeSelector(),
  navbarPage("shinythmes サンプル",
             theme = shinytheme("cerulean"), # 追加箇所
             tabPanel("ページ1", sidebarLayout(
               sidebarPanel(
                 sliderInput("bins",
                             "Number of bins:",
                             min = 1, max = 50, value = 30)
               ),
               mainPanel(
                 tabsetPanel(type = "tabs",
                             tabPanel("Plot", plotOutput("distPlot")),
                             tabPanel("Table", tableOutput("table"))
                 )
               )
             )),
             
             tabPanel("ページ2",
                      h2("テキスト")),
             navbarMenu("自己紹介",
                        tabPanel("名前",
                                 h2("私の名前はNp-Urです。")
                        ),
                        tabPanel("好きな食べ物", h2("私は寿司が好きです。"))
             )
  )
)