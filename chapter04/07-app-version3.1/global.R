library(shiny)
library(shinydashboard)
library(ggmap)
library(leaflet)
library(rgdal)

map <- readOGR(dsn = "./data", layer = "sample", encoding = "UTF-8", stringsAsFactors = FALSE)
attribute_data <- read.csv("./data/attribute.csv")

# library(readr)
# attribute <- read_csv("./data/attribute.csv")
# attribute_data <- as.data.frame(attribute)

# 以下追加箇所
# selectInputで使う選択肢を読み込み
colors <- c("BrBG", "BuPu", "Oranges")
categories <- c("野菜" = "vegetables", "果物" = "fruit", "人口" = "population")
plot_choices <- c("circle", "polygons")

vegetables_choices <- c(トマト = "トマト", なす = "なす", はくさい = "はくさい")
fruit_choices <- c(りんご = "りんご", ぶどう = "ぶどう")
population_choices <- c(人口 = "population", 人口密度 = "pop_density")