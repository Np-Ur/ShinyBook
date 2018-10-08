library(shiny)

shinyUI(fluidPage(
  
  titlePanel("タイトルです。"),
  
  sidebarLayout(
    sidebarPanel(
      h1("h1タグを使って大見出し"),
      div("div関数を使っています。",
          br(),
          "改行を入れています。",
          p("p関数で段落を作っています。")
      )
    ),
    mainPanel(
      h2("h2タグを使って見出し"),
      h3("h3タグを使って見出し"),
      h4("h4タグを使って見出し"),
      h5("h5タグを使って見出し"),
      h6("h6タグを使って見出し"),
      a(href = "https://www.rstudio.com/", "Rstudioへのリンク"),
      p("普通のテキスト。",
        strong("強調されたテキスト"))
    )
  )
)
)