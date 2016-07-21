library(shiny)
library(googleVis)
library(readr)
library(stringr)

lpi <- readRDS("data/lpi.rds")
# clean up non-UTF-8 characters
#str_detect(lpi$Country, "voire") %>% which(.)
lpi$Country[c(109, 238, 389, 565)] <- "Cote d Ivoire"

#str_detect(lpi$Country, "Tom") %>% which(.)
lpi$Country[c(269, 394, 603)] <- "Sco Tomi and Principe"


shinyServer(function(input, output) {
        
        output$text1 <- renderText({ 
                "You have selected this"
        })
        
        output$map <- renderPlot({ 
                
                Geo <- gvisGeoChart(lpi, locationvar="Country", 
                                    colorvar="Overall LPI Score",
                                    options=list(width="1000px", height="500px"),
                )
                plot(Geo)
        })
        
})