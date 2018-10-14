library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Sample"),

  dashboardSidebar(
    sidebarMenu(
      menuItem("tabA", tabName = "tab_A"),
      menuItem("tabB", tabName = "tab_B")
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "tab_A",
              titlePanel("tab_Aの中身")),
      tabItem(tabName = "tab_B",
              titlePanel("tab_Bの中身"))
    )
  )
)