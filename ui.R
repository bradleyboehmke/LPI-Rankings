library(shiny)
library(plotly)
library(readr)
library(dplyr)
library(tidyr)
library(DT)
library(radarchart)

lpi <- read_csv("data/lpi.csv")


shinyUI(navbarPage(
        title = 'International Logistics Performance Index',
        
                tabPanel('Global Ranking',
                titlePanel(NULL),
                sidebarPanel(
                        
                        helpText("Modify the map and data table by selecting desired information below."),
                        
                        selectInput("metric", label = "Choose a metric to display",
                                    choices = names(lpi)[c(3, 5:10)],
                                    selected = "Overall LPI Score"),
                        
                        radioButtons("range", label = "Choose a year to display",
                                     choices = list("Average" = "Average","2016" = 2016, "2014" = 2014,
                                                    "2012" = 2012, "2010" = 2010),
                                     selected = "Average"),
                        
                        checkboxInput("alldata", label = "Show all data in table", value = FALSE),
                        
                        downloadButton('downloadData', 'Download Table'),
                        
                        helpText("The", a("Logistics Performance Index (LPI)", href = "http://lpi.worldbank.org/"),"is a benchmarking tool created to assess and compare the performance of 150+ countries on trade logistics. This map and the data table that follows illustrate the performance of countries across the world in each of the LPI metrics. Read more in the background section.")
                        

                ),
                mainPanel(
                        h2(htmlOutput("mapTitle", container = span),
                           style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;", align='center'),
                        plotlyOutput("trendPlot"),
                        htmlOutput("mapDesc"),
                        br(),
                        dataTableOutput("mapTable")
                )),
        
        tabPanel('Country Score Card',
                 titlePanel(NULL),
                 sidebarPanel(
                         
                         helpText("Modify the map and data table by selecting desired information below."),
                         
                         selectInput("country", label = "Choose a country to display",
                                     choices = sort(unique(lpi$Country)),
                                     selected = "United States"),
                         
                         checkboxGroupInput('selectedYears', "Years to include in Radar Chart",
                                            seq(2010, 2016, by = 2),
                                            selected = seq(2010, 2016, by = 2)),
                         
                         helpText("The country scorecard uses six key dimensions to benchmark countries' performance and also displays the derived overall LPI score. The plot illustrates the score the selected country has achieved for each metric and the data table displays how the selected country ranks among the world in regards to each metric.")
                         
                 ),
                 mainPanel(
                         
                         h2(htmlOutput("radarTitle", container = span), 
                            style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;", align='center'),
                         br(),
                         chartJSRadarOutput("radarPlot", width = "450", height = "300"),
                         br(),
                         br(),
                         htmlOutput("radarDesc"),
                         br(),
                         dataTableOutput("radarTable")
                 )),
        
        tabPanel('Background', 
                 h2("International LPI",
                    style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;"),
                 p("The", a("Logistics Performance Index (LPI)", href = "http://lpi.worldbank.org/"),"is a benchmarking tool created to assess and compare the performance of 150+ countries on trade logistics.  The LPI is based on a worldwide survey of operators on the ground (global freight forwarders and express carriers), providing feedback on the logistics “friendliness” of the countries in which they operate and those with which they trade. They combine in-depth knowledge of the countries in which they operate with informed qualitative assessments of other countries where they trade and experience of global logistics environment. Feedback from operators is supplemented with quantitative data on the performance of key components of the logistics chain in the country of work.",
                   style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;"),
                 p("The LPI consists therefore of both qualitative and quantitative measures and helps build profiles of logistics friendliness for these countries. It measures performance along the logistics supply chain within a country and offers two different perspectives: international and domestic. The information presented in this project focuses only on the international perspective.",
                   style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;"),
                 p("The international LPI provides qualitative evaluations of a country in six areas by its trading partners—logistics professionals working outside the country. The components analyzed in the International LPI were chosen based on recent theoretical and empirical research and on the practical experience of logistics professionals involved in international freight forwarding. They are:",
                   style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;"),
                 tags$li("The efficiency of customs and border management clearance", tags$em("(Customs)"), style = "font-family: 'Source Sans Pro'; margin-left: 3cm; margin-right: 2cm;"),
                 tags$li("The quality of trade and transport infrastructure", tags$em("(Infrastructure)"), style = "font-family: 'Source Sans Pro'; margin-left: 3cm; margin-right: 2cm;"),
                 tags$li("The ease of arranging competitively priced shipments", tags$em("(Ease of arranging shipments)"), style = "font-family: 'Source Sans Pro'; margin-left: 3cm; margin-right: 2cm;"),
                 tags$li("The competence and quality of logistics services—trucking, forwarding, and customs brokerage", tags$em("(Quality of logistics services)"), style = "font-family: 'Source Sans Pro'; margin-left: 3cm; margin-right: 2cm;"),
                 tags$li("The ability to track and trace consignments", tags$em("(Tracking and tracing)"), style = "font-family: 'Source Sans Pro'; margin-left: 3cm; margin-right: 2cm;"),
                 tags$li("The frequency with which shipments reach consignees within scheduled or expected delivery times",tags$em("(Timeliness)"), style = "font-family: 'Source Sans Pro'; margin-left: 3cm; margin-right: 2cm;"),
                 br(),
                 tags$p("The LPI uses standard statistical techniques to aggregate the data into a single indicator that can be used for cross-country comparisons. You can find more information regarding the LPI methodology", a("here", href="https://wb-lpi-media.s3.amazonaws.com/LPI%20Methodology.pdf"),".",
                   style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;"),
                 br(),
                 h3("Colophon", style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;"),
                 p("This app was made by", a("Brad Boehmke", href="http://bradleyboehmke.github.io"), "using", a("Shiny", href="http://shiny.rstudio.com/"), "and", a("RMarkdown", href="http://rmarkdown.rstudio.com/"), "provided by", a("RStudio", href="https://www.rstudio.com/"),". Code is available on", a("GitHub", href="https://github.com/bradleyboehmke/LPI-Rankings"), "licensed MIT. Suggestions and criticism welcome:", a("bradleyboehmke@gmail.com", href="mailto:bradleyboehmke.com"), ".",
                   style = "font-family: 'Source Sans Pro'; margin-left: 2cm; margin-right: 2cm;")
                 )
)
)

