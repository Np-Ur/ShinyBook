library(shiny)

shinyUI(navbarPage("title",
                   tabPanel("subtitle1",
                            h1("1つ目のページ")),
                   tabPanel("subtitle2",
                            h1("2つ目のページ")),
                   navbarMenu("subtitle3",
                              tabPanel("subsubtitle1",
                                       h1("ドロップダウンメニュー1つ目のページ")),
                              tabPanel("subsubtitle2",
                                       h1("ドロップダウンメニュー2つ目のページ"))),
                   position = "fixed-bottom"
))