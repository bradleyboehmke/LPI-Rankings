library(shiny)
library(plotly)
library(readr)

lpi <- read_csv("data/lpi.csv")

shinyUI(navbarPage(
        title = 'International Logistics Performance Index',
        
                tabPanel('Global Ranking',
                titlePanel(NULL),
                sidebarPanel(
                        helpText("Modify the map and data table by selecting desired information below."),
                        
                        selectInput("var", label = "Choose a metric to display",
                                    choices = list("Overall LPI Score", "Customs", "Infrastructure", "International Shipments", "Logistics Quality & Competence", "Tracking & Tracing", "Timeliness"),
                                    selected = "Overall LPI Score"),
                        
                        sliderInput("range", "Year:",
                                    min = 2010, max = 2016, value = 2010, step = 2,
                                    format="####", sep="", animate=TRUE)
                ),
                mainPanel(
                plotlyOutput("trendPlot")
                )),
        
        tabPanel('Country Score Card'),
        
        tabPanel('Background')
        
))

