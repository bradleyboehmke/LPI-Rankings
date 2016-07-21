library(shiny)
library(DT)

shinyUI(navbarPage(
        title = 'International Logistics Performance Index',
        
        tabPanel('Global Ranking',
                 sidebarLayout(
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
                                 plotOutput("map")
                         )
                 )),
        
        tabPanel('Country Score Card'),
        
        tabPanel('Background', 
                 includeHTML("include.html")
        )
))

