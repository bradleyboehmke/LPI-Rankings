library(shiny)

shinyUI(navbarPage(
        title = 'International Logistics Performance Index',
        tabPanel('Global Ranking'),
        tabPanel('Country Score Card'),
        tabPanel('Background', includeHTML("include.html")
        )
))

